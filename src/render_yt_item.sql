function render_yt_item (
    p_item                in apex_plugin.t_page_item,
    p_plugin              in apex_plugin.t_plugin,
    p_value               in varchar2,
    p_is_readonly         in boolean,
    p_is_printer_friendly in boolean )
    return apex_plugin.t_page_item_render_result
is
  subtype plugin_attr is varchar2(32767);
  
  l_autoplay       plugin_attr := p_item.attribute_01; -- default is N
  l_fullscreen     plugin_attr := p_item.attribute_02; -- default is Y
  l_related        plugin_attr := p_item.attribute_03; -- default is Y
  l_start          plugin_attr := p_item.attribute_04;
  l_end            plugin_attr := p_item.attribute_05;
  l_iv_load_policy plugin_attr := p_item.attribute_06; -- default is Y (1)
  l_loop           plugin_attr := p_item.attribute_07; -- default is N
  l_show_info      plugin_attr := p_item.attribute_08; -- default is Y
  l_controls       plugin_attr := p_item.attribute_09; -- default is Y
  
  l_url_opt varchar2(1000);
  l_ifr_opt varchar2(1000);
  
  procedure append_opt (opt in varchar2, val in varchar2) is
  begin
    if l_url_opt is null then
      l_url_opt := '?';
    else
      l_url_opt := l_url_opt || '&';
    end if;
    l_url_opt := l_url_opt || opt || '=' || val;
  end append_opt;
begin
  if apex_application.g_debug then
    apex_plugin_util.debug_page_item(
      p_plugin        => p_plugin,
      p_page_item     => p_item
    );
  end if;
  
  if l_autoplay = 'Y' then append_opt('autoplay','1'); end if;
  if l_related = 'N' then append_opt('rel','0'); end if;
  if l_start is not null then append_opt('start',l_start); end if;
  if l_end is not null then append_opt('end',l_end); end if;
  if l_iv_load_policy = 'N' then append_opt('l_iv_load_policy','3'); end if;
  if l_loop = 'Y' then append_opt('loop','1'); append_opt('playlist',p_value); end if;
  if l_show_info = 'N' then append_opt('showinfo','0'); end if;
  if l_controls = 'N' then append_opt('controls','0'); end if;

  if l_fullscreen = 'N' then
    append_opt('fs','0');
  else
    l_ifr_opt := 'allowfullscreen';
  end if;
  
  sys.htp.p('<iframe'
    || ' id="UT-' || p_item.id || '"'
    || ' width="' || GREATEST(200,p_item.element_width) || 'px"'
    || ' height="' || GREATEST(200,p_item.element_height) || 'px"'
    || ' src="https://www.youtube.com/embed/' || p_value || l_url_opt || '"'
    || ' ' || l_ifr_opt || '></iframe>');

  return null;
end render_yt_item;
