Strip strange characters from Paperclip upload

I modified [dmerand's version](https://github.com/dmerand/paperclip-strip-strange-characters) for compatability with paperclip 4.1 on rails 4.

-----------


# Introduction

This is a simple gem for Ruby on Rails that makes file names of paperclip[https://github.com/thoughtbot/paperclip] 
attachments URL's browser friendly by stripping any strange characters.

It attempts to do following operations on file name:

* transliterate string by using iconv standard transliteration functions,
* change string's case to downcase,
* remove apostrophes and quotes,
* replace any non-letter or non-number character with a space,
* remove spaces from beginning and end of string,
* replace groups of spaces with single hyphen.

If result is an empty string, it computes MD5 hash of the original string.

It also adds new method String#strip_strange_characters so you can use stripping
feature in any other context. It takes two boolean arguments:

* ignore - indicates if characters that cannot be transliterated should be ignored,
* hash - indicates if MD5 hash should be computed in case of empty result.
  
## Code samples

Here comes a quick code sample. Currently no docs.

### Paperclip

<pre>
  class Person < ActiveRecord::Base
    has_attached_file :photo
    before_post_process :strip_strange_characters_from_attachments
  end
</pre>

It is enough to call this callback once as it affects all attachments of the
model. Currently there's no way to define callback for selected attachments.

### Standalone

<pre>
  1.9.3-p194 :001 > "ąqwertÓŁ".strip_strange_characters
   => "qwert" 
  1.9.3-p194 :002 > "it's coffee time".strip_strange_characters
   => "its-coffee-time" 
  1.9.3-p194 :003 > "ABCD_EFGH".strip_strange_characters
   => "abcd-efgh" 
  1.9.3-p194 :004 > "///".strip_strange_characters
   => "884a6325c5f164f3cc6d5f97bd3e3231" 
</pre>

# Installation

### Ruby Versions

Code was tested with ruby-1.9.3-p194 [ amd64 ] under RVM.

### Gems

The gems are hosted at Rubygems.org[http://rubygems.org]. Make sure you're
using the latest version of rubygems:

  $ gem update --system

Then you can install the gem as follows:

  $ gem install paperclip-strip-strange-characters

### Bundler

Add to your Gemfile:

  gem "paperclip-strip-strange-characters", "~> 0.0.1"

and then type:

  bundle install

### From the GitHub source

The source code is available at https://github.com/saepia/paperclip-strip-strange-characters.
You can either clone the git repository or download a tarball or zip file.
Once you have the source, you can unpack it and use from wherever you downloaded.

# ChangeLog

### 0.0.1

* Initial release
