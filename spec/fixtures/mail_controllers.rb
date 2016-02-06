class CountController < Airmail::Controller
  def receive
    Counter.inc
  end
end

class BlankController < Airmail::Controller
  def receive
  end
end

class Counter
  @@val = 0

  def self.reset
    @@val = 0
  end

  def self.inc
    @@val += 1
  end

  def self.count
    @@val
  end
end
