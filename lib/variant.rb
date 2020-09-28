# frozen_string_literal: true

# Copyright, 2020, by Samuel G. D. Williams. <http://www.codeotaku.com>
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

require_relative 'variant/version'
require_relative 'variant/environment'

module Variant
	KEY = 'VARIANT'
	SUFFIX = '_VARIANT'
	
	# Force the process-level variant to be the specified value.
	# 
	# @reentrant Parallel modifications to `ENV` are undefined.
	# 
	# @example
	# 	Variant.force!(:testing)
	#
	def self.force!(value, environment = ENV, **overrides)
		# Clear any specific variants:
		environment.delete_if{|key, _| key.end_with?(SUFFIX)}
		
		# Set the specified variant:
		environment[KEY] = value.to_s
		
		overrides.each do |name, new_value|
			key = name.upcase.to_s + SUFFIX
			
			environment[key] = new_value.to_s
		end
		
		return environment
	end
	
	def self.default
		Environment.instance.default_variant
	end
	
	def self.default= value
		Environment.instance.default_variant= value
	end
	
	def self.for(*arguments)
		Environment.instance.variant_for(*arguments)
	end
end
