Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F74AD4C4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211091; cv=none; b=DWms7tAwFX9b3WCpuGxb0G54IWlF+DC7ZCMtBQIs4QX+ZKMIil2KegxNa4Dr0LZzZZ4+6Maxik3JxfbfL38AXWKYR5MEkIVQSYPedqY905AoOJ7OI+mi0YZz48GespRkaSbKIg5f9bhjGWytavKzd8O/ovILy+WzFWdrSnuESKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211091; c=relaxed/simple;
	bh=yyz0127VMfzJYI6C+Tz2/mTYlKtnYVce9HuwWrpggCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lpo1HOoQt92Gn/y/D5CLnxJHzp0KtrmsWkURp0MoZ9VlX44zwvjx4pDIp6UiQYU0RWjFZQ+n6ydAt2K4eoRbd0yXOSYWNnR7BrQGG2bd1E2paRipP9XWRTI4Mh9kZHYNz3wORyg3BB3uEiyGugDGARMBmg5XPkkIIe5JmDKWHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkhGhlfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkhGhlfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA55E1F00898;
	Mon,  5 Oct 2026 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211081;
	bh=q3Lpf73fIF/1WY2h1KM9U8wvkYVGvaP1Fl1lB1CvhIs=;
	h=Subject:To:Cc:From:Date;
	b=IkhGhlfP74lw+qAVRBExfbn84XX1SW9AhyS+s4PbvmBSRDqIs2OUMbh/haC1HUc3A
	 OfPZ4cX62jBuG8RLD0r6Av2IgtIznOW5HMDa/ebYUIDdSGTaF1FiH5YPcBzxz/24l9
	 28Zs19X7BFv2xI0C+7Av3Eg/Vsix388sNRYSplo0=
Subject: FAILED: patch "[PATCH] wifi: mac80211: keep paired old chanctx alive" failed to apply to 6.1-stable tree
To: zhilinz@nebusec.ai,johannes.berg@intel.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:37:50 +0200
Message-ID: <2026100550-greasily-paper-321a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3412e9a800786d1dec4a58367db1cba275e7ef11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100550-greasily-paper-321a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3412e9a800786d1dec4a58367db1cba275e7ef11 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Mon, 3 Aug 2026 12:35:10 +0800
Subject: [PATCH] wifi: mac80211: keep paired old chanctx alive

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

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 17b935448f13..9cba79507767 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -231,6 +231,13 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 	return num;
 }
 
+static bool
+ieee80211_chanctx_has_replace_partner(struct ieee80211_chanctx *ctx)
+{
+	return ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	       ctx->replace_ctx;
+}
+
 static int ieee80211_num_chanctx(struct ieee80211_local *local, int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
@@ -1405,6 +1412,7 @@ void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *ctx = link->reserved_chanctx;
+	struct ieee80211_chanctx *old_ctx = NULL;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -1418,6 +1426,7 @@ void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 			if (WARN_ON(!ctx->replace_ctx))
 				return;
 
+			old_ctx = ctx->replace_ctx;
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
 			WARN_ON(ctx->replace_ctx->replace_ctx != ctx);
@@ -1428,6 +1437,11 @@ void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
+
+			if (ieee80211_chanctx_refcount(sdata->local,
+						       old_ctx) == 0)
+				ieee80211_free_chanctx(sdata->local, old_ctx,
+						       false);
 		} else {
 			ieee80211_free_chanctx(sdata->local, ctx, false);
 		}
@@ -1707,7 +1721,8 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, old_ctx) == 0 &&
+	    !ieee80211_chanctx_has_replace_partner(old_ctx))
 		ieee80211_free_chanctx(local, old_ctx, false);
 
 	ieee80211_recalc_chanctx_min_def(local, new_ctx);
@@ -2192,7 +2207,8 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 	}
 
 	ieee80211_assign_link_chanctx(link, NULL, false);
-	if (ieee80211_chanctx_refcount(local, ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, ctx) == 0 &&
+	    !ieee80211_chanctx_has_replace_partner(ctx))
 		ieee80211_free_chanctx(local, ctx, skip_idle_recalc);
 
 	link->radar_required = false;

