# Appreciate your Behance project!

## What to do:

1. Install tor at the command prompt if you haven't yet:
       
        $ brew install tor

2. Run tor with following options:

        $ tor --CookieAuthentication 0 --HashedControlPassword "" --ControlPort 9050 --SocksPort 50001
3. Clone this app from github:

        $ git clone https://github.com/elpassion/el_behance.git

4. Go into el_behance directory:

        $ cd el_behance
       
5. Install bundler (if needed) and run bundler:

        $ gem install bundler
        $ bundle

 6. Run application:
 
        $ ruby el_behance.rb appreciate -p YOUR_PROJECT_URL -v NUMBER_OF_VOTES
       
