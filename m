Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BB289E13
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357175; cv=none; b=dAu53DlSRycvsBpYtvyVmTGIadFIsyqq1D32+/fjNcYVRtdNtsVdK4LpvKTyW4vzIUeN25qtqxKJNMlbHlN0CljiCkyaetVnbDEf8B2lObJmwJoBN9IOCW4yk3+rgTcJKq3C/lPQ7bElMD9np5M9olD2mQtlJpFLpIy3KuC1kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357175; c=relaxed/simple;
	bh=ODh+tDAQNkgnGt1YRFOS8+RSiz2UWNVIyuo2p051M1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTg5jDPodJGn6Qz9ThmZ9IyqO1S8+mxMpjxV9g0qdIzUWTVtXoHDywRJXhSIrQhXGJYKfis4fyshq+psoZIkKo0y5VdSKAF+2+BIt5imQvh+XOlkEYMW6D9Xd5n+3HpjCh6trPcVrnl9sR3oX0jYNKHIbN1uZNELak+TQ+1PR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpfTPRg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpfTPRg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFBB1F0089B;
	Wed,  7 Oct 2026 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357174;
	bh=cQYnOH2booZfSM2cULuG0ynXQBhFTVa4mlyZjobod7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LpfTPRg3cu22H5/98GhSnAi0lPp4yKXsp0WhrH7qpMzBnpbKqmjMOUKdK4zVRPAlH
	 2Z4JbT0Aph9rVv8uj3dnxOUvGmRyOEk/vmMpRyTpy4q8qNe30XwllWz6NvBFRarqOn
	 vQpk/BaVwu9ItHq5ufh4QgMtoWm3NjdhZaUFp1gdOP1J0RIFJNmgb4Qec8nchLS7B+
	 JPR75WWieRML+x9SbZAIq17X4LAvio0YtldoJuhq1U3aEI/qGfnmcvQESnweciyKYZ
	 wolt1t2JJa3eSgELmuLeRAGYRfWxTECY+2AW9fW+kSl7LchmfKpX3BI00IB7Ny0wqg
	 VeHNB7mNIXc5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Wed,  7 Oct 2026 03:12:49 -0400
Message-ID: <20261007071151.1477281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100536-swivel-blinker-8991@gregkh>
References: <2026100536-swivel-blinker-8991@gregkh>
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
[ sashal: Adapted per-link reservation handling to per-vif sdata helpers and list iteration. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5639a71257e41..db8b9d39d6ede 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1146,7 +1146,8 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 }
 
 static bool
-ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
+ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 
@@ -1155,6 +1156,9 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
 	new_ctx = sdata->reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1167,6 +1171,12 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
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
 
@@ -1217,7 +1227,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
 			if (!ieee80211_vif_has_in_place_reservation(
-					sdata))
+					sdata, ctx))
 				continue;
 
 			old_ctx = ieee80211_vif_get_chanctx(sdata);
@@ -1324,7 +1334,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(sdata, &ctx->replace_ctx->assigned_vifs,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (sdata->reserved_chanctx) {
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx)) {
 				n_reserved++;
 				if (sdata->reserved_ready)
 					n_ready++;
@@ -1345,7 +1355,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
-			if (ieee80211_vif_has_in_place_reservation(sdata) &&
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx) &&
 			    !sdata->reserved_ready)
 				return -EAGAIN;
 
@@ -1415,7 +1425,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				    reserved_chanctx_list) {
 			u32 changed = 0;
 
-			if (!ieee80211_vif_has_in_place_reservation(sdata))
+			if (!ieee80211_vif_has_in_place_reservation(sdata, ctx))
 				continue;
 
 			rcu_assign_pointer(sdata->vif.chanctx_conf, &ctx->conf);
@@ -1468,7 +1478,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
 					 reserved_chanctx_list) {
 			if (WARN_ON(ieee80211_vif_has_in_place_reservation(
-					sdata)))
+					sdata, ctx)))
 				continue;
 
 			if (WARN_ON(sdata->reserved_chanctx != ctx))
-- 
2.53.0

