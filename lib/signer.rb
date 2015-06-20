require 'digest/md5'

class Signer
  def self.sign_hash(hash, key)
    Digest::MD5.hexdigest("#{hash.values.sort.join}#{key}")
  end
end
