require 'digest/md5'

class String
  def strip_strange_characters(ignore = true, hash = true)
    # Escape str by transliterating to UTF-8
    s = self.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "").force_encoding('UTF-8')
    
    # Downcase string
    s.downcase!

    # Remove apostrophes so isn't changes to isnt
    s.gsub!("'", '')

    # Remove quotes 
    s.gsub!("\"", '')

    # Replace any non-letter or non-number character with a space
    s.gsub!(/[^A-Za-z0-9]+/, ' ')

    # Remove spaces from beginning and end of string
    s.strip!

    # Replace groups of spaces with single hyphen
    s.gsub!(/\ +/, '-')
    
    if hash and s == ""
      return Digest::MD5.hexdigest(self) # Fallback - better MD5 than nothing
    end

    return s
  end
end  

module ActiveRecord
  class Base
    protected
      def strip_strange_characters_from_attachments
        if self.class.attachment_definitions
          self.class.attachment_definitions.each do |k,v|

            # Only modify names of attachments that are being updated
            # Otherwise, the record names & the paths in s3 can become desynchronized
            if self.send(k).file? && self.send("#{k}_file_name_changed?")
              full_file_name = self.send("#{k}_file_name")
              extension = File.extname(full_file_name)
              file_name = full_file_name[0..full_file_name.size-extension.size-1]
              new_file_name = file_name.strip_strange_characters

              # Only modify the extension if there's one present
              # Ex: Dont rename 'img-123' to 'img-123.d41d8cd98f00b204e9800998ecf8427e'
              new_file_name += ".#{extension.strip_strange_characters}" if extension.present?

              self.send("#{k}").instance_write(:file_name, new_file_name)
            end
          end
        end
      end
  end
end
