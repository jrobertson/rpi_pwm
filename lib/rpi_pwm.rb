#!/usr/bin/env ruby

# file: rpi_pwm.rb

require 'rpi_gpio'


class RPiPwm

  HIGH = true
  LOW = false

  attr_accessor :duty_cycle, :freq


  def initialize(pin_num, duty_cycle: 100, freq: 100)

    @id, @duty_cycle, @freq = pin_num, duty_cycle, freq

    RPi::GPIO.set_numbering :bcm
    RPi::GPIO.setup pin_num, :as => :output

    @pwm = RPi::GPIO::PWM.new(pin_num, freq)

    @on, @blinking = false, false

    at_exit { RPi::GPIO.clean_up pin_num}

  end

  def duty_cycle=(val)
    @duty_cycle = val
    @pwm.duty_cycle = val
  end

  def on(durationx=nil, duration: nil)

    set_pin HIGH
    @on = true      
    duration ||=  durationx
    
    @off_thread.exit if @off_thread
    @on_thread = Thread.new {(sleep duration; self.off()) } if duration

  end

  def off(durationx=nil, duration: nil)

    set_pin LOW
    return if @internal_call
    
    @on, @blinking = false, false      
    duration ||=  durationx
    
    @on_thread.exit if @on_thread
    @off_thread = Thread.new { (sleep duration; self.on()) } if duration

  end
  
  alias stop off        
  alias start on

  def blink(seconds=0.5, duration: nil)

    @blinking = true
    t2 = Time.now + duration if duration

    Thread.new do
      while @blinking do

        set_pin HIGH
        sleep seconds / 2.0
        break if !@blinking
        sleep seconds / 2.0 
        break if !@blinking
        
        set_pin LOW;
        sleep seconds / 2.0
        break if !@blinking
        sleep seconds / 2.0

        break if !@blinking
        
        self.off if duration and Time.now >= t2
      end
      
    end
  end
  
  alias oscillate blink

  def on?()  @on  end
  def off?() !@on end

  # set val with 0 (off) or 1 (on)
  #
  def set_pin(val)

    if val then
      @pwm.start @duty_cycle
    else
      @pwm.stop
    end
      
  end
  
  def to_s()
    @id
  end
end