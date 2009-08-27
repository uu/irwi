class Irwi::Comparators::DiffLcs < Irwi::Comparators::Base
  
  def initialize
    super
    
    require 'diff/lcs'
  end
  
  def build_changes( old_text, new_text )
    diffs = Diff::LCS.sdiff( old_text, new_text )    
    changes = []
    
    diffs.each do |change|
      case change.action
        when '=' then
          if !changes.empty? && changes.last.action == '='
            changes.last.value << change.old_element
          else
            changes << new_not_changed( change.old_element )
          end
          
        when '+' then
          if !changes.empty? && changes.last.action == '+'
            changes.last.new_value << change.new_element
          elsif !changes.empty? && changes.last.action == '!'
            changes.last.new_value << change.new_element
          else
            changes << new_changed( '+', nil, change.new_element )
          end
          
        when '-' then
          if !changes.empty? && changes.last.action == '-'
            changes.last.old_value << change.old_element
          else
            changes << new_changed( '-', change.old_element, nil )
          end
          
        when '!' then
          if !changes.empty? && changes.last.action == '!'
            changes.last.old_value << change.old_element
            changes.last.new_value << change.new_element
          else
            changes << new_changed( '!', change.old_element, change.new_element )
          end
        
      end
    end

    changes
  end
    
end