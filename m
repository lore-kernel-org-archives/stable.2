Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F873B9608
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350824; cv=none; b=qOIkTkQvKQLvrBHzFKw2bdwwz100qYdZbHw8YU0UueVfrEJ25wgNVGolINuBZMJWqtMvOh/rqu4WsFwmJQ5Ftm2blDF1OUr/uJGBhUa4eSiKFR2biLAvUxm/ILsOBa4/r2atYN9GXQDbHq/E+ngSP5H1TOprITXEo1DQEE9PtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350824; c=relaxed/simple;
	bh=W/ZYXApaBy/RIGVkFF3DODnnI+Z6h7FTYUpVKsaR5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPl14jE4cjbNZYPAfricUfIWSPbNFxzg5ptLHdjbyBELsFIBPOygp0dXsCc7P4hyO4904TXXJ8jGQUTyUNmj5SNucQy5FdQpu3VpqMrD0IByS+OHBGM5KxdmCsSwBbQdOg/gsSRlKEphzDWC282L4e4Dze7nzLRMVjCm64b7YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrgkSFuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrgkSFuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8241F0089B;
	Wed,  7 Oct 2026 05:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350823;
	bh=U4+zHseZMtxRQ4HUU4C/L1GVfLdYE3HT+PkYylE+wyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrgkSFuF513fZMb1PmoxpNUDQbQrC/z5OITkHhhVYg6X28Yo/GZ3VrECYkpmADEVQ
	 kWvFcF7MeNOUj69f2NeVFlv0hdrCQGvDYYOBiyL+yEM+dNfY5jXXiAldDYMw1NsAyN
	 tX4EU2sffkQ54kA7sLcn6iWHwTq9KGcjseX0dPQZadrkBeKxV0Z8WP7t3G/aoirdBf
	 NmOC1Rsv02zfjI5rOyBanZuKuV9EwpmP6Dbutqv9xWXbus9EnlkC5Y7vr2lYP0NMGZ
	 qgLb7rCFUBEPtwqL8r5jTw6IPh295ypAn3ei/nbPhPyBCk5e022CFjJOJ15mi8cFUO
	 EEAvxQ7k/5kiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Wed,  7 Oct 2026 01:26:59 -0400
Message-ID: <20261007052612.1186231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100535-entrench-prowling-0faf@gregkh>
References: <2026100535-entrench-prowling-0faf@gregkh>
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
[ sashal: Adapted per-link reservation handling to the existing per-interface helpers and list traversal. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f32d8d07d6a30..563649257c195 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1240,7 +1240,8 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 }
 
 static bool
-ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
+ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 
@@ -1249,6 +1250,9 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
 	new_ctx = sdata->reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1261,6 +1265,12 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
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
 
@@ -1311,7 +1321,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
 			if (!ieee80211_vif_has_in_place_reservation(
-					sdata))
+					sdata, ctx))
 				continue;
 
 			old_ctx = ieee80211_vif_get_chanctx(sdata);
@@ -1418,7 +1428,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(sdata, &ctx->replace_ctx->assigned_vifs,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (sdata->reserved_chanctx) {
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx)) {
 				n_reserved++;
 				if (sdata->reserved_ready)
 					n_ready++;
@@ -1439,7 +1449,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
-			if (ieee80211_vif_has_in_place_reservation(sdata) &&
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx) &&
 			    !sdata->reserved_ready)
 				return -EAGAIN;
 
@@ -1509,7 +1519,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				    reserved_chanctx_list) {
 			u32 changed = 0;
 
-			if (!ieee80211_vif_has_in_place_reservation(sdata))
+			if (!ieee80211_vif_has_in_place_reservation(sdata, ctx))
 				continue;
 
 			rcu_assign_pointer(sdata->vif.chanctx_conf, &ctx->conf);
@@ -1562,7 +1572,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
 					 reserved_chanctx_list) {
 			if (WARN_ON(ieee80211_vif_has_in_place_reservation(
-					sdata)))
+					sdata, ctx)))
 				continue;
 
 			if (WARN_ON(sdata->reserved_chanctx != ctx))
-- 
2.53.0

