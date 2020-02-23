# frozen_string_literal: true

# Copyright, 2016, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'thread/local'

module Variant
	class Wrapper
		extend Thread::Local
		
		DEVELOPMENT = :development
		
		# It is not safe to modify ENV.
		def initialize(environment = ENV.to_hash, default: DEVELOPMENT)
			@environment = environment
			@default = @environment.fetch('VARIANT', DEVELOPMENT).to_sym
		end
		
		attr :environment
		attr :default
		
		def default= name
			@default = name.to_sym
			@environment['VARIANT'] = name.to_s
		end
		
		def [](name)
			@environment.fetch(variant_key(name), @default).to_sym
		end
		
		def for(name)
			self[name]
		end
		
		def []=(name, value)
			@environment[variant_key(name)] = value.to_s
		end
		
		private
		
		def variant_key(name)
			"#{name.upcase}_VARIANT"
		end
	end
end
