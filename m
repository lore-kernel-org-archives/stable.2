Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EB39CCE3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327335; cv=none; b=qaWsGkrnEdNzppj6NOlWmOuD/QPF0wiLu2vzYRF8LR9HNXG7gyv7Vvw/k868JRJUtFHWD1aSXVeE0wCx2Q/EcpWb6Eg5Kdx8gHr2a84rNe8rpDG+qvxUzfeGOyXaED75nDFGYxBtmqNgB3sT4h7Gh1PMMdfQqA3mfi36RdQqLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327335; c=relaxed/simple;
	bh=r0oBpPJhIztKbhOXlaCL7xFsiY6BXswKk3OHdzhreM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXIopAkXbIeQQhGKLiw8XdYMgADvgaTrBLdehCAZi4YdnjMYxlYCD/I33EQS82z5HnwXFWQTT8xyDYdo2gwDdzDqILErkEjtYKzi8m98n3HYR07Nj5mnEFkPTaMimTXWUzkCteicFAxQ9/4NRnilo5Wq0qBjYDGmwV2KSadruh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWFz46RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWFz46RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589861F0089C;
	Tue,  6 Oct 2026 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327335;
	bh=8nQ2h1e0mla8xE+ByjyDow+DFiBLsR4U1qKzqDnUnyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWFz46RQWP3KWSRLLP/RS0Qt78d8VBOiEDYLKgAT8Y5JC+vlj3Cd6c6/+fBCMYlCr
	 2L8SU0qy9/QLkyfAeE5ITq8u6e5m+lBXu/C9n3xZ+Xy+jwvhRcHutM8yoFj04lPBWD
	 GU7RJXUPTR2jG1wh+WFDQHkQzlir1YQvL8IJn8lQyQ0RV3rwZxdWwa0qPurKP8sPf+
	 G4YTL99QhxjgWUUhvvTJjB/+lUNm/M8p2+Py1T+7NPLYX2xksk+lg1GSr88i1ij/Yz
	 KgPXeVDRtY76OPnBzWd7w4DeEYzc7ImHBIEo3ISbJKxygYaUT2eyAIJbeMdOtaYIQn
	 0DWDorkJmFCPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: keep paired old chanctx alive
Date: Tue,  6 Oct 2026 18:55:31 -0400
Message-ID: <20261006225443.1043321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100551-filtrate-backlands-1f8b@gregkh>
References: <2026100551-filtrate-backlands-1f8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 3412e9a800786d1dec4a58367db1cba275e7ef11 ]

An in-place replacement keeps reciprocal replace_ctx pointers between
the old WILL_BE_REPLACED chanctx and the new REPLACES_OTHER chanctx.
However, the early free paths only consider assigned and reserved link
users when deciding whether to free the old chanctx.

That lets the old chanctx be freed too early while the replacement
partner still points back to it, either when the last assigned link is
released or when that link successfully reassigns to another existing
context. Later unreserve and switch-finalization paths can then follow a
stale replace_ctx pointer.

Keep a paired old chanctx alive until the replacement pair has been torn
down. Apply the same check to both __ieee80211_link_release_channel()
and ieee80211_link_use_reserved_reassign(). If the replacement is later
abandoned, ieee80211_link_unreserve_chanctx() already tears down the
pairing before freeing the old chanctx once no users remain.

Fixes: 5bcae31d9cb1 ("mac80211: implement multi-vif in-place reservations")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Link: https://patch.msgid.link/b9b582b0db3814f641648b8886bb50f9d68f93ac.1785730815.git.zhilinz@nebusec.ai
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: adapted link-based channel handling to VIF-based functions and fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f32d8d07d6a30..84be216fcb7c2 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -940,6 +940,7 @@ void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_chanctx *ctx = sdata->reserved_chanctx;
+	struct ieee80211_chanctx *old_ctx = NULL;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
@@ -954,6 +955,7 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 			if (WARN_ON(!ctx->replace_ctx))
 				return -EINVAL;
 
+			old_ctx = ctx->replace_ctx;
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
 			WARN_ON(ctx->replace_ctx->replace_ctx != ctx);
@@ -964,6 +966,10 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
+
+			if (ieee80211_chanctx_refcount(sdata->local,
+						       old_ctx) == 0)
+				ieee80211_free_chanctx(sdata->local, old_ctx);
 		} else {
 			ieee80211_free_chanctx(sdata->local, ctx);
 		}
@@ -1177,7 +1183,9 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, old_ctx) == 0 &&
+	    !(old_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      old_ctx->replace_ctx))
 		ieee80211_free_chanctx(local, old_ctx);
 
 	ieee80211_recalc_chanctx_min_def(local, new_ctx);
@@ -1649,7 +1657,9 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 	}
 
 	ieee80211_assign_vif_chanctx(sdata, NULL);
-	if (ieee80211_chanctx_refcount(local, ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, ctx) == 0 &&
+	    !(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      ctx->replace_ctx))
 		ieee80211_free_chanctx(local, ctx);
 
 	sdata->radar_required = false;
-- 
2.53.0

