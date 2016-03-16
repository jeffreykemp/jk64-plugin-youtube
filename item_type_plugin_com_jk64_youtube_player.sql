set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.2.00.07'
,p_default_workspace_id=>20749515040658038
,p_default_application_id=>572
,p_default_owner=>'SAMPLE'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/item_type/com_jk64_youtube_player
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(75257501389838464)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.JK64.YOUTUBE_PLAYER'
,p_display_name=>'Youtube Player'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render_yt_item (',
'    p_item                in apex_plugin.t_page_item,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_value               in varchar2,',
'    p_is_readonly         in boolean,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_page_item_render_result',
'is',
'  subtype plugin_attr is varchar2(32767);',
'  ',
'  l_autoplay       plugin_attr := p_item.attribute_01; -- default is N',
'  l_fullscreen     plugin_attr := p_item.attribute_02; -- default is Y',
'  l_related        plugin_attr := p_item.attribute_03; -- default is Y',
'  l_start          plugin_attr := p_item.attribute_04;',
'  l_end            plugin_attr := p_item.attribute_05;',
'  l_iv_load_policy plugin_attr := p_item.attribute_06; -- default is Y (1)',
'  l_loop           plugin_attr := p_item.attribute_07; -- default is N',
'  l_show_info      plugin_attr := p_item.attribute_08; -- default is Y',
'  l_controls       plugin_attr := p_item.attribute_09; -- default is Y',
'  ',
'  l_url_opt varchar2(1000);',
'  l_ifr_opt varchar2(1000);',
'  ',
'  procedure append_opt (opt in varchar2, val in varchar2) is',
'  begin',
'    if l_url_opt is null then',
'      l_url_opt := ''?'';',
'    else',
'      l_url_opt := l_url_opt || ''&'';',
'    end if;',
'    l_url_opt := l_url_opt || opt || ''='' || val;',
'  end append_opt;',
'begin',
'  if apex_application.g_debug then',
'    apex_plugin_util.debug_page_item(',
'      p_plugin        => p_plugin,',
'      p_page_item     => p_item',
'    );',
'  end if;',
'  ',
'  if l_autoplay = ''Y'' then append_opt(''autoplay'',''N''); end if;',
'  if l_related = ''N'' then append_opt(''rel'',''0''); end if;',
'  if l_start is not null then append_opt(''start'',l_start); end if;',
'  if l_end is not null then append_opt(''end'',l_end); end if;',
'  if l_iv_load_policy = ''N'' then append_opt(''l_iv_load_policy'',''3''); end if;',
'  if l_loop = ''Y'' then append_opt(''loop'',''1''); append_opt(''playlist'',p_value); end if;',
'  if l_show_info = ''N'' then append_opt(''showinfo'',''0''); end if;',
'  if l_controls = ''N'' then append_opt(''controls'',''0''); end if;',
'',
'  if l_fullscreen = ''N'' then',
'    append_opt(''fs'',''0'');',
'  else',
'    l_ifr_opt := ''allowfullscreen'';',
'  end if;',
'  ',
'  sys.htp.p(''<iframe''',
'    || '' id="UT-'' || p_item.id || ''"''',
'    || '' width="'' || GREATEST(200,p_item.element_width) || ''px"''',
'    || '' height="'' || GREATEST(200,p_item.element_height) || ''px"''',
'    || '' src="https://www.youtube.com/embed/'' || p_value || l_url_opt || ''"''',
'    || '' '' || l_ifr_opt || ''></iframe>'');',
'',
'  return null;',
'end render_yt_item;'))
,p_render_function=>'render_yt_item'
,p_standard_attributes=>'VISIBLE:SOURCE:WIDTH:HEIGHT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.1'
,p_about_url=>'https://github.com/jeffreykemp/jk64-plugin-youtube'
,p_plugin_comment=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Some sample videos:',
'https://www.youtube.com/watch?v=fwkJtgVswgM',
'https://www.youtube.com/watch?v=P5_GlAOCHyE',
'https://www.youtube.com/watch?v=6pxRHBw-k8M'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75269151097134639)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Autoplay'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Set to Yes to have video automatically start playing on page load.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75270218826211310)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Allow Fullscreen mode'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Set to No to hide the full-screen button in the player.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75270818714215312)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Show Related Afterwards'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Set to No to stop "related" videos being offered after video ends.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75271440808218942)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Start from'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_display_length=>5
,p_unit=>'seconds'
,p_is_translatable=>false
,p_help_text=>'Set to the number of seconds from video start to start playing from. Substitution variable is allowed, e.g. &P1_START.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75272008976223391)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'End at'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_display_length=>5
,p_unit=>'seconds'
,p_is_translatable=>false
,p_help_text=>'Set to the point of the video to stop playing (that is, number of seconds from start of video, not relative to the "start from" attribute). Substitution variable is allowed, e.g. &P1_END.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75321988708242649)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Show video annotations by default'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'This is the default setting for the player. The user can show/hide video annotations at runtime.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75322907361285183)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Loop'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Set to Yes to make the video play in a loop. (Note: if you set the Start and End attributes, they seem to only apply to the first playing; on the first repeat it seems to go back to playing the entire video)'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75324349488316335)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Show info'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Set to No to hide info like the video title, uploader, etc.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(75325216442335752)
,p_plugin_id=>wwv_flow_api.id(75257501389838464)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Show controls'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Set to No to hide the player controls.'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
