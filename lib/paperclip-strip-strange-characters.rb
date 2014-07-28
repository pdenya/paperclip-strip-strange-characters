#require 'iconv'
require 'digest/md5'

class String
  def strip_strange_characters(ignore = true, hash = true)
    # Escape str by transliterating to UTF-8
    s = self.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "").force_encoding('UTF-8')
    #if ignore
      # s = Iconv.iconv('ascii//ignore//translit', 'utf-8', self).to_s
      # s = self.gsub(/[\x80-\xff]/,"")
    #else
      # s = Iconv.iconv('ascii//translit', 'utf-8', self).to_s
      # s = self.gsub(/[\x80-\xff]/,"")
    #end
    
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
        self.instance_variable_get(:@_paperclip_attachments).keys.each do |attachment|
           attachment_file_name = (attachment.to_s + '_file_name').to_sym
           if self.send(attachment_file_name)
             self.send(attachment).instance_write(:file_name, self.send(attachment_file_name).strip_strange_characters)
          end
        end
      end
  end
end
