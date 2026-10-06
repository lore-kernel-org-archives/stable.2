Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155D883F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324800; cv=none; b=tLu3fnO3RfB5H4yCJOlpQ22u4N8b6008FkVU5w10+1puxYpjNSv6Yer8rGoVNd/hZpr1TMX/qGF+niCf46GOaVsNHJ7FLRTZOtU9X7QXxmRVdJGiN9jWiyCLkPBaBbjpq2H9inR9+cS8YEPK6LHDNPOJ0rSxvvQ3dkOIQVIGBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324800; c=relaxed/simple;
	bh=QUj40Q8aVXVGKN9y3scKL1PZdyy9geprI8+0pZ9FnSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQHgcDLraZyRHMJaT5XQvoiiDEhTqou5lJXb62K/aQnvdXCdS1aDKxLSGxyjnHBB8+IiLU0FX7fq6oEUGvUqYAFm3mcW3CF1lTZRFGvMKNsM3DX1SMKenfdcRmMsTN2wndf4meDLGNmk6chDbgKy2zSDlnR7fVqqW7LN2MpkB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh/7g7p9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh/7g7p9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2081F0089B;
	Tue,  6 Oct 2026 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324798;
	bh=NpvAr9kbpXdbK0/Uo/aIryy3XnuPpJsebisn1oPWL2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uh/7g7p956MnYlwNIYh1KRIHHoNgZLYigf8Dn3ZuE19mL0YsFTZKi1WIvX8BicMqm
	 KMdxxl1cITGChC9ISpULUY9ea9bPb8w2mwAcSV7L0xriOZWaxAYYZ5coGMfII+Jo/W
	 McP9m2gfycubC4fEp2jvjfUbi527W/9b1wz9wDpWurYBC19thm8ga0vBEJ97jBbjzs
	 BYLP3VOIHL3z3OEVf6o4/Is3fZ/3OT8HAmojQNYmYZPfiNjYRoSblNpj3kigL9QSOe
	 yUHND37WHkSybBLH+csHO5FNuHdJntpenklBwYaKtp9QAvu4CdisKlqABiewlnwMI9
	 yPQlZzemETxpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Tue,  6 Oct 2026 18:13:15 -0400
Message-ID: <20261006221304.1043101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-uninstall-golf-0192@gregkh>
References: <2026100534-uninstall-golf-0192@gregkh>
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
[ sashal: Adapted channel-context iterators to direct link-list traversal. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4a21e53afa72e..c875243f3d7f0 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1386,7 +1386,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 }
 
 static bool
-ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link,
+					struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1396,6 +1397,9 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1408,6 +1412,12 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
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
 
@@ -1457,7 +1467,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
@@ -1566,7 +1576,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (link->reserved_chanctx) {
+			if (ieee80211_link_has_in_place_reservation(link, ctx)) {
 				n_reserved++;
 				if (link->reserved_ready)
 					n_ready++;
@@ -1587,7 +1597,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (ieee80211_link_has_in_place_reservation(link) &&
+			if (ieee80211_link_has_in_place_reservation(link, ctx) &&
 			    !link->reserved_ready)
 				return -EAGAIN;
 
@@ -1661,7 +1671,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			rcu_assign_pointer(link_conf->chanctx_conf,
@@ -1714,7 +1724,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
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

