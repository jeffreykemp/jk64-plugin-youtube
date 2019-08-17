prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>20749515040658038
,p_default_application_id=>572
,p_default_owner=>'SAMPLE'
);
end;
/
prompt --application/shared_components/plugins/item_type/com_jk64_youtube_player
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(28308929752175819734)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.JK64.YOUTUBE_PLAYER'
,p_display_name=>'Youtube Player'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Youtube Player plugin v1.0 Aug 2019',
'',
'subtype plugin_attr is varchar2(32767);',
'',
'procedure render',
'  (p_item   in            apex_plugin.t_item',
'  ,p_plugin in            apex_plugin.t_plugin',
'  ,p_param  in            apex_plugin.t_item_render_param',
'  ,p_result in out nocopy apex_plugin.t_item_render_result',
'  ) is',
'  ',
'  l_options        plugin_attr := p_item.attribute_01;',
'  l_width          plugin_attr := p_item.attribute_02;',
'  l_height         plugin_attr := p_item.attribute_03;',
'  l_start          plugin_attr := p_item.attribute_04;',
'  l_end            plugin_attr := p_item.attribute_05;',
'  l_cc_lang_pref   plugin_attr := p_item.attribute_06;',
'  l_color          plugin_attr := p_item.attribute_07;',
'  l_hl             plugin_attr := p_item.attribute_08;',
'  ',
'  l_opt varchar2(4000);',
'  ',
'  procedure append_opt (opt in varchar2, val in varchar2) is',
'  begin',
'    if l_opt is null then',
'      l_opt := ''?'';',
'    else',
'      l_opt := l_opt || ''&'';',
'    end if;',
'    l_opt := l_opt || opt || ''='' || val;',
'  end append_opt;',
'',
'begin',
'  if apex_application.g_debug then',
'    apex_plugin_util.debug_page_item(',
'      p_plugin        => p_plugin,',
'      p_page_item     => p_item',
'    );',
'  end if;',
'  ',
'  if instr(l_options,''list'')>0 then',
'    append_opt(''listType'',''playlist'');',
'    append_opt(''list'',sys.htf.escape_sc(p_param.value));',
'  end if;',
'',
'  if instr(l_options,''autoplay'')>0 then append_opt(''autoplay'',''1''); end if; --default is 0 (don''t autoplay)',
'  if instr(l_options,''fs'')=0 then append_opt(''fs'',''0''); end if; --default is 1 (allow full screen)',
'  if instr(l_options,''rel'')=0 then append_opt(''rel'',''0''); end if; --default is 1 (show related videos from other channels)',
'  if instr(l_options,''iv_load_policy'')=0 then append_opt(''iv_load_policy'',''3''); end if; --default is 1 (don''t show video annotations)',
'  if instr(l_options,''controls'')=0 then append_opt(''controls'',''0''); end if; --default is 1 (show controls)',
'  if instr(l_options,''modestbranding'')>0 then append_opt(''modestbranding'',''1''); end if; --default is standard youtube branding',
'  if instr(l_options,''disablekb'')>0 then append_opt(''disablekb'',''1''); end if; --default is 0 (keyboard controls enabled)',
'  if instr(l_options,''cc_load_policy'')>0 then append_opt(''cc_load_policy'',''1''); end if; --default is user pref',
'',
'  if instr(l_options,''loop'')>0 then',
'     append_opt(''loop'',''1''); --default is 0 (don''t loop)',
'     append_opt(''playlist'',sys.htf.escape_sc(p_param.value));',
'  end if;',
'',
'  if l_cc_lang_pref is not null then append_opt(''cc_lang_pref'',l_cc_lang_pref); end if;',
'  if l_color is not null then append_opt(''color'',l_color); end if;',
'  if l_hl is not null then append_opt(''hl'',l_hl); end if;',
'  if l_start is not null then append_opt(''start'',l_start); end if;',
'  if l_end is not null then append_opt(''end'',l_end); end if;',
'  ',
'  sys.htp.p(',
'       ''<iframe id="'' || p_item.name || ''"''',
'    || case when l_width is not null then '' width="'' || l_width || ''"'' end',
'    || case when l_height is not null then '' height="'' || l_height || ''"'' end',
'    || '' src="https://www.youtube.com/embed/''',
'    || case when instr(l_options,''list'')=0 then sys.htf.escape_sc(p_param.value) end',
'    || l_opt || ''"''',
'    || case when instr(l_options,''fs'')>0 then '' allowfullscreen'' end',
'    || ''></iframe>'');',
'',
'end render;'))
,p_api_version=>2
,p_render_function=>'render'
,p_standard_attributes=>'VISIBLE:SOURCE'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'Generates a Youtube video player. The value of the item must be valid Youtube video ID. For example for <code>https://www.youtube.com/watch?v=fwkJtgVswgM</code>, the video ID is <code>fwkJtgVswgM</code>.'
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/jeffreykemp/jk64-plugin-youtube'
,p_plugin_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Some sample videos:',
'https://www.youtube.com/watch?v=fwkJtgVswgM',
'https://www.youtube.com/watch?v=P5_GlAOCHyE',
'https://www.youtube.com/watch?v=6pxRHBw-k8M',
'https://www.youtube.com/watch?v=oIXgef-Yw9E',
'',
'Youtube API: https://developers.google.com/youtube/player_parameters'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(39133865640483412)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Options'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_default_value=>'fs:controls'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39134425526484787)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>10
,p_display_value=>'Autoplay'
,p_return_value=>'autoplay'
,p_help_text=>'Start playing video automatically on page load.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39134897840485857)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>20
,p_display_value=>'Allow Full-Screen'
,p_return_value=>'fs'
,p_help_text=>'Show the full-screen button in the player.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39135209179487373)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>30
,p_display_value=>'Show related videos from other channels'
,p_return_value=>'rel'
,p_help_text=>'Offer "related" videos from other channels after video ends. (If unticked, related videos from the same channel may be offered)'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39135669470488674)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>40
,p_display_value=>'Show video annotations by default'
,p_return_value=>'iv_load_policy'
,p_help_text=>'The user can show/hide video annotations at runtime.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39136061291489829)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>50
,p_display_value=>'Loop'
,p_return_value=>'loop'
,p_help_text=>'Make the video play in a loop. (Note: if you set the Start and End attributes, they only apply to the first playing; on the first repeat it seems to go back to playing the entire video)'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39136488663491176)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>60
,p_display_value=>'Show controls'
,p_return_value=>'controls'
,p_help_text=>'Show the player controls.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39136854177492216)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>70
,p_display_value=>'Modest branding'
,p_return_value=>'modestbranding'
,p_help_text=>'Hide the prominent Youtube logo.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39137226970496302)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>80
,p_display_value=>'Disable keyboard'
,p_return_value=>'disablekb'
,p_help_text=>'Cause the player to not respond to keyboard controls.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39154415080942906)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>90
,p_display_value=>'Show Captions'
,p_return_value=>'cc_load_policy'
,p_help_text=>'Show closed captions by default, even if the user has turned captions off. The default behavior is based on user preference.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39176575038922215)
,p_plugin_attribute_id=>wwv_flow_api.id(39133865640483412)
,p_display_sequence=>100
,p_display_value=>'Item value is a Play List'
,p_return_value=>'list'
,p_help_text=>'Play the playlist identified by the value of the item. Default is to interpret the value of the item as a single video ID.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(39173019756794015)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Width'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Width for the iframe. May be specified in pixels (e.g. <code>400px<code>) or percentage of container''s size (e.g. <code>100%</code>).'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(39173666035795858)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Height'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Height for the iframe, typically specified in pixels (e.g. <code>400px<code>).'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(28308943691594200212)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
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
 p_id=>wwv_flow_api.id(28308944259762204661)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
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
 p_id=>wwv_flow_api.id(39153744062937077)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Captions Language'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_max_length=>2
,p_is_translatable=>false
,p_text_case=>'LOWER'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This parameter specifies the default language that the player will use to display captions. Set the parameter''s value to an ISO 639-1 two-letter language code (http://www.loc.gov/standards/iso639-2/php/code_list.php).',
'<p>',
'If you use this parameter and also set the Captions option on, then the player will show captions in the specified language when the player loads. If you do not also set the Captions option, then captions will not display by default, but will display'
||' in the specified language if the user opts to turn captions on.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(39156676589997686)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Progress bar colour'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This specifies the colour that will be used in the player''s video progress bar to highlight the amount of the video that the viewer has already seen. Valid parameter values are red and white, and, by default, the player uses the colour red in the vid'
||'eo progress bar.',
'<p>',
'Note: Setting the colour parameter to white will disable the Modest Branding option.'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39157475965998439)
,p_plugin_attribute_id=>wwv_flow_api.id(39156676589997686)
,p_display_sequence=>10
,p_display_value=>'white'
,p_return_value=>'white'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(39157856777999094)
,p_plugin_attribute_id=>wwv_flow_api.id(39156676589997686)
,p_display_sequence=>20
,p_display_value=>'red'
,p_return_value=>'red'
,p_help_text=>'(default)'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(39160084923088590)
,p_plugin_id=>wwv_flow_api.id(28308929752175819734)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Interface language'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_max_length=>2
,p_is_translatable=>false
,p_text_case=>'LOWER'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Sets the player''s interface language. The parameter value is an ISO 639-1 two-letter language code (http://www.loc.gov/standards/iso639-2/php/code_list.php) or a fully specified locale. For example, fr and fr-ca are both valid values. Other language '
||'input codes, such as IETF language tags (BCP 47) might also be handled properly.',
'<p>',
'The interface language is used for tooltips in the player and also affects the default caption track. Note that YouTube might select a different caption track language for a particular user based on the user''s individual language preferences and the '
||'availability of caption tracks.'))
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
