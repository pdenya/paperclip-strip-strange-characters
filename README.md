Strip strange characters from Paperclip upload

I modified [wspruijt's version](https://github.com/wspruijt/paperclip-strip-strange-characters) because I didn't like the notification messages I was getting about iconv being deprecated. So I removed all references to iconv in this version. I also changed wspruijt's version to use String.encode per [this stackoverflow](http://stackoverflow.com/questions/7870636/equivalent-of-iconv-convutf-8-ignore-in-ruby-1-9-x/7870859#7870859).
