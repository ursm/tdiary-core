#
# 05referer.rb: Japanese resource of referer plugin
#
# Copyright (C) 2006, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#

def referer_today; 'この日のリンク元'; end
def volatile_referer; '本日のリンク元'; end

def label_no_referer; 'リンク元記録除外リスト'; end
def label_only_volatile; '本日分のみに記録するリンク元リスト'; end
def label_referer_table; 'リンク置換リスト'; end

add_conf_proc( 'referer', 'リンク元', 'referer' ) do
	saveconf_referer

	<<-HTML
	<h3 class="subtitle">リンク元の表示</h3>
	#{"<p>リンク元リストを表示するかどうかを指定します。</p>" unless @conf.mobile_agent?}
	<p><select name="show_referer">
		<option value="true"#{if @conf.show_referer then " selected" end}>表示</option>
		<option value="false"#{if not @conf.show_referer then " selected" end}>非表示</option>
	</select></p>
	<h3 class="subtitle">リンク元記録除外リスト</h3>
	#{"<p>リンク元リストに追加しないURLを指定します。正規表現で指定できます。1件1行で入力してください。</p>" unless @conf.mobile_agent?}
	<p>→<a href="#{@conf.update}?referer=no" target="referer">既存設定はこちら</a></p>
	<p><textarea name="no_referer" cols="70" rows="10">#{@conf.no_referer2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">本日分のみに記録するリンク元リスト</h3>
	#{"<p>「本日のリンク元」にのみ記録したいURLはこちらに記述します。このリストにマッチしたリンク元は、新しい日付の日記を書くと消去されます。正規表現で指定できます。1件1行で入力してください。</p>" unless @conf.mobile_agent?}
	<p>→<a href="#{@conf.update}?referer=volatile" target="referer">既存設定はこちら</a></p>
	<p><textarea name="only_volatile" cols="70" rows="10">#{@conf.only_volatile2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">リンク元置換リスト</h3>
	#{"<p>リンク元リストのURLを、特定の文字列に変換する対応表を指定できます。1件につき、URLと表示文字列を空白で区切って指定します。正規表現が使えるので、URL中に現れた「(〜)」は、置換文字列中で「\\1」のような「\数字」で利用できます。</p>" unless @conf.mobile_agent?}
	<p>→<a href="#{@conf.update}?referer=table" target="referer">既存設定はこちら</a></p>
	<p><textarea name="referer_table" cols="70" rows="10">#{@conf.referer_table2.collect{|a|a.join( " " )}.join( "\n" )}</textarea></p>
	HTML
end

