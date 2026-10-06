Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55BB3769FD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309357; cv=none; b=RgD5IIAw7CR4v7dsjsHsMf1ee9lL9z/mfzRt+de4LLwYSE9XPRmWOcapGAqWOMdzQLSzwX8loJVXsP/BxPKW7Kcq3PSIymT3t7ysk5Ct+tXSc32mczsqYWTq+J9SWWazhrXhS72/PM1P8eMc5tYeyrLlAyUtsF6mwhIr8SjAUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309357; c=relaxed/simple;
	bh=A1LcrHQjDDbq+ly05A4dktfBz6kR0jj1MpgvgNBZPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbEvN5XAxfcr7dAKXXdvqHNDAjRqTEM44TZo6HE/8ks7Qv6O3FnLadMPpgN0FVxIDXttoSte/Y5VohpOhkGvDCkYRA9q0ejVtnxmFWVmspiX6M+h4WLgiEG8QRupt/t8TsbCOzrfglWiGeP87Tcs4eKUTKi0Is0qb3JZv8qkJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv79IiNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv79IiNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B46B1F0089B;
	Tue,  6 Oct 2026 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309356;
	bh=MG1C6dzHyeExGTw7MySLTKOWETvpswigo1ZMKLW01a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tv79IiNIyFKlS1uwKYJ3viXXmaxza/gPc9YIcxZpvI0c52hiC0U5OCvAPws8eYO0f
	 szbEic8KOB7I1TZw+Hs35zCbV0OLSrqOcHRXUl7QE9wcsXs1bM2ufhcMoDxiI8jp7/
	 fM1KMKEYRrZjgAwY6ZSPlyQmG1P4zigBFoQvKkr7Eh/6wMfTeueCDTBJwiUzrTFExH
	 JasnRxJ4bQkw2XZvI4qWSXXZUHC1fUax67A3xcqr1aWsviQo+h4y19Ey8KsFYnTfB2
	 csp7QVOXqMjAjf7tIRbFRqKomj67DZ6RmBqSnca0rMrgdwdBlymb5UJLyo/AlbUj2s
	 vWkodKfYYL4VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211: keep paired old chanctx alive
Date: Tue,  6 Oct 2026 13:55:52 -0400
Message-ID: <20261006175525.914502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100550-agreeing-enamel-9da2@gregkh>
References: <2026100550-agreeing-enamel-9da2@gregkh>
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
[ sashal: Inlined the replacement-partner helper at both call sites. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4a21e53afa72e..85875ed7536f8 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1067,6 +1067,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *ctx = link->reserved_chanctx;
+	struct ieee80211_chanctx *old_ctx = NULL;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
@@ -1081,6 +1082,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 			if (WARN_ON(!ctx->replace_ctx))
 				return -EINVAL;
 
+			old_ctx = ctx->replace_ctx;
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
 			WARN_ON(ctx->replace_ctx->replace_ctx != ctx);
@@ -1091,6 +1093,10 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
+
+			if (ieee80211_chanctx_refcount(sdata->local,
+						       old_ctx) == 0)
+				ieee80211_free_chanctx(sdata->local, old_ctx);
 		} else {
 			ieee80211_free_chanctx(sdata->local, ctx);
 		}
@@ -1322,7 +1328,9 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, old_ctx) == 0 &&
+	    !(old_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      old_ctx->replace_ctx))
 		ieee80211_free_chanctx(local, old_ctx);
 
 	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
@@ -1802,7 +1810,9 @@ static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 	}
 
 	ieee80211_assign_link_chanctx(link, NULL);
-	if (ieee80211_chanctx_refcount(local, ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, ctx) == 0 &&
+	    !(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      ctx->replace_ctx))
 		ieee80211_free_chanctx(local, ctx);
 
 	link->radar_required = false;
-- 
2.53.0

