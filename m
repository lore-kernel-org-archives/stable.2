Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F53769FD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309354; cv=none; b=KJ2VyIsPT+YAtr4VH1Vh+DJ6qIE3xrBD4Pd1olGo3biwNja1UB6f0QXIQmVWxsdGoD9m6TWdQ7CGpakfFPstcBeyvagEa9TyNK6WVMO22L3+wHUD7FGe5C5i4ch4saWcpvzEV2CntPJFSkzl99bs7iUKM5mzfUUYW+D61gU7CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309354; c=relaxed/simple;
	bh=czOqjssutVvtVDgAT1vMRC2O6CyLmcsg4lF3pN7WpUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+8NrnebSgb7bh51ZFbLrq37WLzn7r9sPlRcf2+4J4P11SK3HeNef3S5J+HT49ZvU74byfOvIoK1Fa8WdLG08NFLgVkIAxNpFn22Jm4ipBDBqZwlF++T9jpe2H/UG65TeDq6KWlX4WwUIO6esdyLCTXIPCvQ4aUvaARYU4rO8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKAlcNmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKAlcNmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7217E1F0089B;
	Tue,  6 Oct 2026 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309352;
	bh=Mk0eNXGNrTv1z/1L8YCndVycVT9B4T0t7ee1aHvQsfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKAlcNmKVtczmg6pBkjtRiGLJ1Hd4QVblL0yPf/Mbqs3/tFDlRjEVtWyBa976uCB9
	 mMtKs5AZxQIewnTH7d5bcxdlgN50Az9Pws84ufLbiADfBg/pltbHiz8H1qCvgpZH3B
	 wMzR3/e9FFKHmIecsVFMenAVinsLwwc9atBZqM2FLCPhbR2OH14zL3iojH1Gni/VLe
	 2V9fsmuu5brSx3rr1Iys3SMXME0PYQWLJORKlUhwCzkjfhXF1YNNppRwT+kDAF9wX4
	 RXpbxwPQrN53lnx/Hc3vL5QsjXHtkXqfcfD+fJThC8lWnT09byMStjD3eo87/eVnhW
	 v8JL78TJFMt7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Tue,  6 Oct 2026 13:55:48 -0400
Message-ID: <20261006175528.905419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-sector-drab-5350@gregkh>
References: <2026100534-sector-drab-5350@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 437f3727b4fd715266c296435c116288f82666fd ]

ieee80211_vif_use_reserved_switch() validates a replacement by counting
assigned links on ctx->replace_ctx and treating reservations too
broadly. A link can still be assigned to the old channel context while
holding a reservation that belongs to a different replacement
operation.

That can make the current replacement appear complete too early. If
another link finalizes first, the function can free the
WILL_BE_REPLACED chanctx while the unmatched link and driver still use
it, leading to a use-after-free in later beacon generation.

Require an in-place reservation to point at the current replacement
context, and require the reserved and assigned contexts to be the
matching replacement pair, before counting or moving the link.

Fixes: 5bcae31d9cb1 ("mac80211: implement multi-vif in-place reservations")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Link: https://patch.msgid.link/4b6c4b8648ab1920c38a40be32c0b1a2797b4ac6.1785726007.git.zhilinz@nebusec.ai
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Adapted channel-context iterator accesses to existing direct list loops using link instead of iter.link. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 7241868563564..b733822c452de 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1485,7 +1485,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 }
 
 static bool
-ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link,
+					struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1495,6 +1496,9 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1507,6 +1511,12 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	if (new_ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 		return false;
 
+	if (new_ctx->replace_ctx != old_ctx)
+		return false;
+
+	if (old_ctx->replace_ctx != new_ctx)
+		return false;
+
 	return true;
 }
 
@@ -1536,7 +1546,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
@@ -1639,7 +1649,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (link->reserved_chanctx) {
+			if (ieee80211_link_has_in_place_reservation(link, ctx)) {
 				n_reserved++;
 				if (link->reserved_ready)
 					n_ready++;
@@ -1660,7 +1670,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (ieee80211_link_has_in_place_reservation(link) &&
+			if (ieee80211_link_has_in_place_reservation(link, ctx) &&
 			    !link->reserved_ready)
 				return -EAGAIN;
 
@@ -1702,7 +1712,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			ieee80211_chan_bw_change(local,
@@ -1751,7 +1761,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			rcu_assign_pointer(link_conf->chanctx_conf,
@@ -1805,7 +1815,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		 */
 		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
-			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
+			if (WARN_ON(ieee80211_link_has_in_place_reservation(link,
+									    ctx)))
 				continue;
 
 			if (WARN_ON(link->reserved_chanctx != ctx))
-- 
2.53.0

