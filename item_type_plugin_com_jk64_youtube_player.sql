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
'  l_autoplay   plugin_attr := p_item.attribute_01; -- default is N',
'  l_fullscreen plugin_attr := p_item.attribute_02; -- default is Y',
'  l_related    plugin_attr := p_item.attribute_03; -- default is Y',
'  l_start      plugin_attr := p_item.attribute_04;',
'  l_end        plugin_attr := p_item.attribute_05;',
'  ',
'  l_options varchar2(4000);',
'  ',
'  procedure append_opt (opt in varchar2, val in varchar2) is',
'  begin',
'    if l_options is null then',
'      l_options := ''?'';',
'    else',
'      l_options := l_options || ''&'';',
'    end if;',
'    l_options := l_options || opt || ''='' || val;',
'  end append_opt;',
'begin',
'  if apex_application.g_debug then',
'    apex_plugin_util.debug_page_item(',
'      p_plugin        => p_plugin,',
'      p_page_item     => p_item',
'    );',
'  end if;',
'  ',
'  append_opt(''autoplay'',TRANSLATE(l_autoplay,''YN'',''10''));',
'  append_opt(''fs'',      TRANSLATE(l_fullscreen,''YN'',''10''));',
'  append_opt(''rel'',     TRANSLATE(l_related,''YN'',''10''));',
'  if l_start is not null then',
'    append_opt(''start'',l_start);',
'  end if;',
'  if l_end is not null then',
'    append_opt(''end'',l_end);',
'  end if;',
'  ',
'  sys.htp.p(''<iframe''',
'    || '' id="UT-'' || p_item.id || ''"''',
'    || '' width="'' || GREATEST(200,p_item.element_width) || ''px"''',
'    || '' height="'' || GREATEST(200,p_item.element_height) || ''px"''',
'    || '' src="'' || REPLACE(REPLACE(REPLACE(p_value',
'                      ,''youtu.be/'', ''www.youtube.com/watch?v='')',
'                      ,''/watch?v='', ''/embed/'')',
'                      ,''http://'', ''https://'')',
'                || l_options',
'                || ''"''',
'    || ''></iframe>'');',
'',
'  return null;',
'end render_yt_item;'))
,p_render_function=>'render_yt_item'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:SOURCE:WIDTH:HEIGHT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.1'
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
,p_default_value=>'Y'
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
,p_default_value=>'Y'
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
,p_help_text=>'Set to the number of seconds from video start to start playing from.'
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
,p_help_text=>'Set to the point of the video to stop playing (that is, number of seconds from start of video, not relative to the "start from" attribute).'
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
