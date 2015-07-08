FROM jystic/centos6-ghc7.10.1

# Update cabal
RUN cabal update

# Add .cabal file
ADD ./cowsay.cabal /opt/cowsay/cowsay.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
RUN cd /opt/cowsay && cabal install --only-dependencies -j4

# Add and install application code
ADD . /opt/cowsay
RUN cd /opt/cowsay && cabal install

# Add installed cabal executables to PATH
ENV PATH /root/.cabal/bin:$PATH

# Default Command for Container
CMD ["cowsay"]
