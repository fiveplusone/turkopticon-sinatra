require 'constants'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'helpers')
require 'partials'
require 'helpers'
require 'before'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'models')
require 'person'
require 'requester'
require 'review'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'mailers')
require 'reg_mailer'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'routes')
require 'login'
require 'blog'

