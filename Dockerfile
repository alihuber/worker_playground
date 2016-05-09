FROM ubuntu:trusty


RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y build-essential autoconf bison libpq-dev libreadline6-dev libsqlite3-dev libssl-dev libyaml-dev zlib1g-dev openssh-server git curl software-properties-common python-software-properties
RUN sed -i 's|session    required    pam_loginuid.so|session     optional    pam_loginid.so|g' /etc/pam.d/sshd

RUN mkdir -p /var/run/sshd

RUN apt-get install -y openjdk-7-jdk

RUN add-apt-repository -y ppa:brightbox/ruby-ng
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get update
RUN apt-get -y install nodejs

RUN apt-get -y install ruby2.3 ruby2.3-dev

RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

# percussions for installing gems
RUN echo "jenkins ALL= NOPASSWD: ALL" >> /etc/sudoers

RUN gem install bundler --no-ri --no-rdoc

RUN mkdir /worker_playground
WORKDIR /worker_playground
ADD Gemfile /worker_playground/Gemfile
ADD Gemfile.lock /worker_playground/Gemfile.lock
ADD . /worker_playground

RUN bundle install

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
