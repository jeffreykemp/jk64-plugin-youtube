function render_yt_item (
    p_item                in apex_plugin.t_page_item,
    p_plugin              in apex_plugin.t_plugin,
    p_value               in varchar2,
    p_is_readonly         in boolean,
    p_is_printer_friendly in boolean )
    return apex_plugin.t_page_item_render_result
is
  subtype plugin_attr is varchar2(32767);
  
  l_autoplay   plugin_attr := p_item.attribute_01; -- default is N
  l_fullscreen plugin_attr := p_item.attribute_02; -- default is Y
  l_related    plugin_attr := p_item.attribute_03; -- default is Y
  l_start      plugin_attr := p_item.attribute_04;
  l_end        plugin_attr := p_item.attribute_05;
  
  l_options varchar2(4000);
  
  procedure append_opt (opt in varchar2, val in varchar2) is
  begin
    if l_options is null then
      l_options := '?';
    else
      l_options := l_options || '&';
    end if;
    l_options := l_options || opt || '=' || val;
  end append_opt;
begin
  if apex_application.g_debug then
    apex_plugin_util.debug_page_item(
      p_plugin        => p_plugin,
      p_page_item     => p_item
    );
  end if;
  
  append_opt('autoplay',TRANSLATE(l_autoplay,'YN','10'));
  append_opt('fs',      TRANSLATE(l_fullscreen,'YN','10'));
  append_opt('rel',     TRANSLATE(l_related,'YN','10'));
  if l_start is not null then
    append_opt('start',l_start);
  end if;
  if l_end is not null then
    append_opt('end',l_end);
  end if;
  
  sys.htp.p('<iframe'
    || ' id="UT-' || p_item.id || '"'
    || ' width="' || GREATEST(200,p_item.element_width) || 'px"'
    || ' height="' || GREATEST(200,p_item.element_height) || 'px"'
    || ' src="' || REPLACE(REPLACE(REPLACE(p_value
                      ,'youtu.be/', 'www.youtube.com/watch?v=')
                      ,'/watch?v=', '/embed/')
                      ,'http://', 'https://')
                || l_options
                || '"'
    || '></iframe>');

  return null;
end render_yt_item;