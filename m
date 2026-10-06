Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAED3AB28F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322329; cv=none; b=ZFmF5wMOnA7pwtWM+YroKQCU4UsXz90njUb2swtwSgXN89aI1TgcjkZYtZZFpK44tjXIOCPu01b6fdtsEqqxVt7nfycgnn34LSiHUSRsvyq75ZVxeAsb+GWt0ydrFfXhyQEOt2G7OkKrmL9yKfalJA0+SpiXGnH74R0Z0GG0CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322329; c=relaxed/simple;
	bh=gIghvWnqoCUgmQt/oihqVPScZjwR1FMWM8LzcU+GuGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImdPRCRKN2xJZm6YrAioHaJgaguXQN0K/YETWO3/LnOqqwKuzlpwUh3t+TxQLBSM1ftYTRPLzYfN5h+d2m0ZC7drpWW8/lHEpO8VMMr0RdIWap0HtbztBQC9koakgz7YlfVGJHLIdHD77YUPpwlRELvE2K7F/hCIiqQwfSQy1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyYgmKFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyYgmKFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF311F0089B;
	Tue,  6 Oct 2026 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322325;
	bh=OjRnNdxv54ltKS13ZURV5IQavozJZ1+GfnTCOZD5xoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyYgmKFxCZvQWLWdb3GRN2zaB2XY/lKp+jDzGXGm04AQmV0xstZ/6Sx0Jt74sRWIa
	 KfqBMy4SPZstfo3nOmpnV4cMqwG8geh0ZG5H4x1xfI1oF9+boirV86HrwjeuNjgRoM
	 W7m2LpTVv5NBpqoLVf2UKjoMZxrDg2GktX69XIYAC8okhsmEltqB4sxRGHGQ319Nnz
	 J/zmiL7CuHEHC5YDh8ZXyojQVJxcWr8Uh44+Z+LHhAyoBMUxf88A7tH74pscBb0Q1q
	 yo2FJ6amblkOP8s1lZKUSvHsx85YQ55pzQR5d4sZE1gnIrSRIhwL1rgE0X6kF4pifX
	 +Mzuq+lLzY9YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mac80211: count only matching reservations in reserved switch
Date: Tue,  6 Oct 2026 17:32:01 -0400
Message-ID: <20261006213143.981493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-reoccupy-afterglow-c3a1@gregkh>
References: <2026100534-reoccupy-afterglow-c3a1@gregkh>
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
[ sashal: adapted iter.link-based channel-context iteration to direct link-list traversal. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b156f12daacbb..aea060719a1ea 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1441,7 +1441,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 }
 
 static bool
-ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link,
+					struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1451,6 +1452,9 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1463,6 +1467,12 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
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
 
@@ -1492,7 +1502,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(link);
@@ -1595,7 +1605,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (link->reserved_chanctx) {
+			if (ieee80211_link_has_in_place_reservation(link, ctx)) {
 				n_reserved++;
 				if (link->reserved_ready)
 					n_ready++;
@@ -1616,7 +1626,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (ieee80211_link_has_in_place_reservation(link) &&
+			if (ieee80211_link_has_in_place_reservation(link, ctx) &&
 			    !link->reserved_ready)
 				return -EAGAIN;
 
@@ -1658,7 +1668,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			ieee80211_chan_bw_change(local,
@@ -1707,7 +1717,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			rcu_assign_pointer(link_conf->chanctx_conf,
@@ -1761,7 +1771,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
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

