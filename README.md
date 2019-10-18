# README FOR IMAPSYNC

##Installation instructions (For the plugin).

1. First change the working directory to 'roundcube-root/plugins/' and copy the repository into 'imapsync/*'  . Change the permissions of all directories to 775 and 664 for files, to match everything else at the roundcube installation.
2. create a configuration.

##Install installations for the backend:

1. clone the git repository
2. in './bin/' rename config.sample to config.conf and add the correct values to that file.
3. also in './bin/' there is a file called imapsync.pl in which you need to replace the imap server(our server) to the desired one, for now it is 'imap01.binero.se'.
4. install the required libs, see appendix

```
apt-get update && apt-get upgrade
apt-get install imapsync
cpan install  File::Tail App::cpanminus Authen::NTLM CGI Compress::Zlib Crypt::OpenSSL::RSA Data::Dumper Data::Uniqid Digest::HMAC Digest::HMAC_MD5 Digest::MD5 Dist::CheckConflicts Encode::Byte File::Copy::Recursive IO::Socket::INET IO::Socket::INET6 IO::Socket::SSL IO::Tee JSON JSON::WebToken JSON::WebToken::Crypt::RSA HTML::Entities LWP::UserAgent Mail::IMAPClient Module::Implementation Module::Runtime Module::ScanDeps Net::SSLeay Package::Stash Package::Stash::XS PAR::Packer Parse::RecDescent Pod::Usage Readonly Regexp::Common Sys::MemInfo Term::ReadKey Test::Fatal Test::Mock::Guard Test::MockObject Test::More Test::Pod Test::Requires Test::Deep Try::Tiny Unicode::String URI::Escape LockFile::Simple DBD::mysql

perl -MCPAN -e 'install DBI'
```

also setup the './bin/imapsync.pl' to run with cron every 15 minutes

##Database installation
This is really simple just make a new table like tho one defined in ./mysql/mysql.initial.sql and give the roundcube user access to it.


