-- Youtube Player plugin v1.0 Aug 2019

subtype plugin_attr is varchar2(32767);

procedure render
  (p_item   in            apex_plugin.t_item
  ,p_plugin in            apex_plugin.t_plugin
  ,p_param  in            apex_plugin.t_item_render_param
  ,p_result in out nocopy apex_plugin.t_item_render_result
  ) is
  
  l_options        plugin_attr := p_item.attribute_01;
  l_start          plugin_attr := p_item.attribute_04;
  l_end            plugin_attr := p_item.attribute_05;
  l_cc_lang_pref   plugin_attr := p_item.attribute_06;
  l_color          plugin_attr := p_item.attribute_07;
  l_hl             plugin_attr := p_item.attribute_08;
  
  l_opt varchar2(4000);
  
  procedure append_opt (opt in varchar2, val in varchar2) is
  begin
    if l_opt is null then
      l_opt := '?';
    else
      l_opt := l_opt || '&';
    end if;
    l_opt := l_opt || opt || '=' || val;
  end append_opt;

begin
  if apex_application.g_debug then
    apex_plugin_util.debug_page_item(
      p_plugin        => p_plugin,
      p_page_item     => p_item
    );
  end if;
  
  if instr(l_options,'autoplay')>0 then append_opt('autoplay','1'); end if; --default is 0
  if instr(l_options,'rel')=0 then append_opt('rel','0'); end if; --default is 1
  if l_start is not null then append_opt('start',l_start); end if;
  if l_end is not null then append_opt('end',l_end); end if;
  if instr(l_options,'iv_load_policy')=0 then append_opt('iv_load_policy','3'); end if; --default is 1
  if instr(l_options,'loop')>0 then append_opt('loop','1'); append_opt('playlist',sys.htf.escape_sc(p_param.value)); end if; --default is 0
  if instr(l_options,'controls')=0 then append_opt('controls','0'); end if; --default is 1
  if instr(l_options,'modestbranding')>0 then append_opt('modestbranding','1'); end if; --default is no
  if instr(l_options,'disablekb')>0 then append_opt('disablekb','1'); end if; --default is 0
  if l_cc_lang_pref is not null then append_opt('cc_lang_pref',l_cc_lang_pref); end if;
  if instr(l_options,'cc_load_policy')>0 then append_opt('cc_load_policy','1'); end if; --default is user pref
  if l_color is not null then append_opt('color',l_color); end if;
  if l_hl is not null then append_opt('hl',l_hl); end if;
  if instr(l_options,'fs')=0 then append_opt('fs','0'); end if;
  
  sys.htp.p(
       '<iframe id="' || p_item.name || '"'
    || ' width="' || greatest(200,p_item.element_width) || 'px"'
    || ' height="' || greatest(200,p_item.element_height) || 'px"'
    || ' src="https://www.youtube.com/embed/' || sys.htf.escape_sc(p_param.value) || l_opt || '"'
    || case when instr(l_options,'fs')>0 then ' allowfullscreen' end
    || '></iframe>');

end render;