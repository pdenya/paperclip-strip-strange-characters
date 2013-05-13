Strip strange characters from Paperclip upload

I modified [wspruijt's version](https://github.com/wspruijt/paperclip-strip-strange-characters) because I didn't like the notification messages I was getting about iconv being deprecated. So I removed all references to iconv in this version. wspruijt did all of the work of actually converting references to `iconv` to references to `gsub`.
