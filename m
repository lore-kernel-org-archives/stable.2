Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F43CEBB8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350830; cv=none; b=WsTdOOqk7tFTRsXHC4deue7aGJeVKg8hqT45BeexweCYexAObu6u8e1JGcf1pPJxRMJbLI3hdkg5y4wxNR3/r6j3JIGlOWjc5tZYa4PZK0TsdsN6Zfw/LuoihD+Dx2NpkW8bUM4pjFq7ysim5ii7MnE81/xmLsiWuCsjObsoixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350830; c=relaxed/simple;
	bh=AJzSdV+zMwPJtuJFO7OyVO5bpEbne52qkaVT9LD93D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4GL2aXhKy5Y4WATgJyVszxNAXMSg8p1VsH4hKiOrwFWbltQZhQU5qBHbXv25/yRLzlCyfvtO1qDNEeUbRls3IzuNX6XPg5FxCKhMaKGt8+JXc3ldJ4R550VuSlZJCNuT9Yh+w9/vqB5N3oTrNhCOwAJaSBh//qmdEVHzfARoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWIUaQ+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWIUaQ+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40181F0089B;
	Wed,  7 Oct 2026 05:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350829;
	bh=50YmRM72LZ5JqlSGPax6/s4Q5PDWyjCt9/DfIqtVNYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AWIUaQ+gp1BITFScbl4xRse6yttvowB29ZFlwIXvZF9Y7NbGJhu5YQg710gffQPwa
	 pyTdoxn5VlCs8nqF0RJJIunwU6k3JsZKja7uE33s0sfxYZW3I0t9w1908dFGSASc99
	 EFMfzIDDU5vVGVKH4Zn4GNm5uGDxZXoxdQ+csICm0TEIgkareJu0n3gOo1xyEdGgnC
	 JQLF3DtnjHfRPT4ybbF+YOHBHp/VRmXom62kHnd0jORdUZEz1SO9icj7Bt/KSmmlCi
	 RZKn/iHkLKS6UJRQUeJRTNMus4c/5dZ+lgyQ0JOUH7g95erbgCKzCvNwTh3mAyJmZb
	 BLJR1KHXh0XsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: keep paired old chanctx alive
Date: Wed,  7 Oct 2026 01:27:05 -0400
Message-ID: <20261007052609.1186753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100551-shampoo-endocrine-c1ec@gregkh>
References: <2026100551-shampoo-endocrine-c1ec@gregkh>
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
[ sashal: adapted link-based chanctx handling to the older vif-based API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5639a71257e41..0d0bb18a77e79 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -846,6 +846,7 @@ void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_chanctx *ctx = sdata->reserved_chanctx;
+	struct ieee80211_chanctx *old_ctx = NULL;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
@@ -860,6 +861,7 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 			if (WARN_ON(!ctx->replace_ctx))
 				return -EINVAL;
 
+			old_ctx = ctx->replace_ctx;
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
 			WARN_ON(ctx->replace_ctx->replace_ctx != ctx);
@@ -870,6 +872,10 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
+
+			if (ieee80211_chanctx_refcount(sdata->local,
+						       old_ctx) == 0)
+				ieee80211_free_chanctx(sdata->local, old_ctx);
 		} else {
 			ieee80211_free_chanctx(sdata->local, ctx);
 		}
@@ -1078,7 +1084,9 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, old_ctx) == 0 &&
+	    !(old_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      old_ctx->replace_ctx))
 		ieee80211_free_chanctx(local, old_ctx);
 
 	if (sdata->vif.bss_conf.chandef.width != sdata->reserved_chandef.width)
@@ -1555,7 +1563,9 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
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

