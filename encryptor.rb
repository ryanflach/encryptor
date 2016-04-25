class Encryptor

  def rotation(size)
    values = [3, 9, 27]
    rotational = []
    reset = 0
    size.times do
      if reset < 3
        rotational << values[reset]
        reset += 1
      else
        reset = 0
        rotational << values[reset]
        reset += 1
      end
    end
    rotational
  end

  def supported_characters
    (' '..'z').to_a
  end

  def cipher(rotate)
    rotated_characters = supported_characters.rotate(rotate)
    Hash[supported_characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def decrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation.key(letter)
  end

  def encrypt(string)
    letters = string.split("")
    enc_rotations = rotation(string.length)
    increase = 0
    results = letters.collect do |letter|
      rotation = enc_rotations[increase]
      increase += 1
      encrypted_letter = encrypt_letter(letter, rotation)
    end
    results.join
  end

  def decrypt(string)
    letters = string.split("")
    enc_rotations = rotation(string.length)
    increase = 0
    results = letters.collect do |letter|
      rotation = enc_rotations[increase]
      increase += 1
      decrypted_letter = decrypt_letter(letter, rotation)
    end
    results.join
  end

  def encrypt_file(filename)
    input = File.open(filename, "r")
    contents = input.read
    encrypted = encrypt(contents)
    new_filename = filename + ".encrypted"
    output = File.open(new_filename, "w")
    output.write(encrypted)
    output.close
  end

  def decrypt_file(filename)
    input = File.open(filename, "r")
    contents = input.read
    decrypted = decrypt(contents)
    output_filename = filename.gsub("encrypted", "decrypted")
    output = File.open(output_filename, "w")
    output.write(decrypted)
    output.close
  end

  def decrypt_crack(string, rotation)
    letters = string.split("")
    results = letters.collect do |letter|
      decrypted_letter = decrypt_letter(letter, rotation)
    end
    results.join
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt_crack(message, attempt)
    end
  end

  def instant_encrypt
    puts "Please enter the message you wish to encrypt: "
    message = gets.chomp.to_s
    encrypted = encrypt(message)
    puts "Your encrypted message is: #{encrypted}"
  end

  def instant_decrypt
    puts "Please enter the message you wish to decrypt: "
    message = gets.chomp.to_s
    decrypted = decrypt(message)
    puts "Your decrypted message is: #{decrypted}"
  end
end
