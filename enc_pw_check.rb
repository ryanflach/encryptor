require 'digest/md5'
require './encryptor'

# MD5 hexdigest of encypted password ('ryanflach' [u'!qo,dl(]):
PASSWORD = "925b47b81b0ae23917de9c3d45d22fc1"

@e = Encryptor.new
@attempt = 0

def password_attempt
  puts "Please enter the password:"
  pw_attempt = @e.encrypt(gets.chomp)
  pw_md5 = Digest::MD5.hexdigest(pw_attempt)
  if pw_md5 == PASSWORD
    puts "Access granted."
    success
  else
    @attempt += 1
    puts "Password is not correct. #{3 - @attempt} tries remaining."
    if @attempt == 3
      puts "Maximum attempts reached. Goodbye."
    else
      password_attempt
    end
  end
end

def success
  loop do
    puts "Enter 'e' to encrypt, 'd' to decrypt, or 'q' to quit:"
    action = gets.chomp
    if action == 'e'
      @e.instant_encrypt
    elsif action == 'd'
      @e.instant_decrypt
    elsif action == 'q'
      puts "Goodbye."
      break
    else
      puts "Command not understood. Please try again."
    end
  end
end

password_attempt
