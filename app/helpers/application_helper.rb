module ApplicationHelper


  def group_start(text)
      res=" <h2>#{h(text)}</h2><div id='group'>".html_safe
      return res
    end

    def group_end
      res ="</div>"
      return res.html_safe
    end

    def header(text)
      res="<h2>#{h(text)}</h2>".html_safe
    end

    def header_blue(text)
       "<div id='show_field_blue_header'> #{h(text)}</div>".html_safe
    end

    def show_field(label_name, value, type=:normal)
      if type==:important then
        color=" style='background: #F0700D;'"
      else
        color=''
      end
      res = "<div id='show_field_even' #{color}>"  ##{cycle('even', 'odd')}
      res += "<div id='label'>#{label_name}:</div>"
      res += "<div id='value'>#{if value.nil? or value.blank? then
        '-'
      else
        h(value.to_s)
      end}</div>"
      res += "</div>"
      return res.html_safe
    end


    def show_text(text)
      "<div id='show_field_even'>#{h(text)}</div>".html_safe
    end

    def short_date(fdate)
      if fdate.nil? then
        return '-'
      else
        return fdate.strftime("%m/%d")
      end
    end

    def d(number, precision)
      number_with_precision(number, :precision => precision)
    end

    def c(number)
       number_to_currency(number)
    end

    def c_short(number)
      number_to_currency(number, :precision=>0)
    end

    def show_negative(value)
      return '' if value==''
      if value.to_f<=0 then
        "<spawn style='color:green'>-$#{value*-1}</spawn>".html_safe
      else
        "<spawn style='color:red'>$#{value}</spawn>".html_safe
        end
    end

    def show_text_yellow(text)
      res="<div id='show_field_yellow'>#{h(text)}</div>".html_safe
    end



  #  def new_menue_helper(&block)
  #    content = capture(&block)
  #    concat("<div id='menu_wrapper' class='grey'> <div id='left' class='grey'></div> <ul id='menu'>", block.binding)
  #    concat(content, block.binding)
  #    concat("</ul></div>", block.binding)
  #  end


    ### see ruby pattern page 291 and http://github.com/pluginaweek/menu_helper

    def menu_bar(&block)
     content_for :menue do
      MenuBar.new(&block).html
    end
     end

    class MenuBar < Object

      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::TagHelper

      def initialize(&block)
        @content=''
        @block=block
        yield(self) if block_given?
      end



      def menu_line(*args, &block)
        my_content = link_to(*args, :id => "button", &block)
        if args[0].include? '<<' then
          @content+="<span id='arrow_frame'>" +my_content+ "</span>"
        else
          @content+="<span id='btn_frame'>" + my_content + "</span>"
        end
        return nil
      end

      def html
        res= "<div id='button_background'>" + @content +"</div>"
        return res.html_safe

      end

=begin

      def menu_line(*args, &block)
        my_content = link_to(*args, &block)
        if @first then
          @first =false
          @content+="<li>"+my_content+"</li>"
        else
          @content+="<li class='grey'>"+my_content+"</li>"
        end
        return nil
      end

      def html
        res="<div id='menu_wrapper' class='grey'> <div id='left' class='grey'></div> <ul id='menu'>"+@content+"</ul></div><div style='clear:left'></div>"
        return res.html_safe
      end
=end

    end

end
