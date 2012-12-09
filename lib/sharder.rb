class Sharder

  SHARDS = 10

  def []=(key, val)
    @shards[shard(key)][key] = val
  end

  def [](key)
    @shards[shard(key)][key]
  end

  def initialize()
    @shards = {}
    (0..(SHARDS-1)).each { |i| @shards[i] = {} }
  end

  def include?(key)
    !@shards[shard(key)][key].nil?
  end

  def shard(index)
    index % SHARDS
  end

end
