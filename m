Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1B3DB320
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327312; cv=none; b=k9vJ0Lu+gVqge0M6SAvSPbBGlTV6GElxPXJUYgZow8Es7FswslA95ZFk4woA3Jt0bqN0ypOeTKc/FLAaZ9rCQ9AAHt05iAB0endN6YBhMiYagiFISgh+tcFtIkmW3IwgHtMpCaz+UVBqsnobfMMqW4p3ip5ZBFcfpDWBMM1WVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327312; c=relaxed/simple;
	bh=AgjFQwTN4ZDbXVDSzax3ai8dUiOO+ePObs/3jmWGR2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckddi4ir8Acu/WOpYG+QMiQM7aV6KrTHPEw2PcLzlbAiroX2pdRL9wapNaDhC35EKD2qp0y+fAtQJ5ptgPO6Mssh8eMx+rIekQ5t3R+kzUn9MMY98AUYYUwoWXW4x/zPoqYRybA08kRgXkr9Ajveu1bT6Tdyy6ITWK2CyrHZVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jls2nB0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jls2nB0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31DA1F0089B;
	Tue,  6 Oct 2026 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327312;
	bh=KkwHt8HSj2LPnjCuUAj1GOxUK6Ghfg0GBYIQzKZcQBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jls2nB0V3aVT+onTmeX8Ab2AfRr2Gfz6ZUoVseKcv0z5T47DwD/Ax8SYDce976ESm
	 OXrG9Mwpl7YU/blJYGPXpG1dV8NVo+MBRC+Khr6tD+Z5MKTs4WnHJmWWYBS5SCSvQ6
	 ZCqXzvPl52ciJ/ZwlcL4NzvnoWDUC2pAo0gWdEkS1z8nPaEzoounTLYxTVOWqpzWIo
	 r1HaiO6IjGazfeYgHEPUM4JdR1bPCSfsyxyKyAUmimF5+JpSC8+Xo7KcrBYQDzNW8U
	 lJyKPaj/NcVVJ2noXrhqPjlLOZO2Tx4mUFkmtyeCTVePIH9OJzI72A54etyUlfo19c
	 cWWLoQvaZBkMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Tue,  6 Oct 2026 18:55:07 -0400
Message-ID: <20261006225446.1132406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100535-edition-smith-a0aa@gregkh>
References: <2026100535-edition-smith-a0aa@gregkh>
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
[ sashal: Adapted iter.link accesses to direct link pointers in list-based loops. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 26e692a853d9b..d3cd31844c1f4 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1381,7 +1381,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 }
 
 static bool
-ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link,
+					struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1391,6 +1392,9 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1403,6 +1407,12 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
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
 
@@ -1452,7 +1462,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
@@ -1561,7 +1571,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (link->reserved_chanctx) {
+			if (ieee80211_link_has_in_place_reservation(link, ctx)) {
 				n_reserved++;
 				if (link->reserved_ready)
 					n_ready++;
@@ -1582,7 +1592,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (ieee80211_link_has_in_place_reservation(link) &&
+			if (ieee80211_link_has_in_place_reservation(link, ctx) &&
 			    !link->reserved_ready)
 				return -EAGAIN;
 
@@ -1656,7 +1666,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u32 changed = 0;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			rcu_assign_pointer(link_conf->chanctx_conf,
@@ -1709,7 +1719,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
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

