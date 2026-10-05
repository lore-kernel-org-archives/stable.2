Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3C4A5EA8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211075; cv=none; b=DmRymFRsTZU9F4jZ7uVxwY5EQt3uF2OYSyAF98g9J37Wt4tg6CWp78lBvFvcy02IElCMcly7G6tOFPlcHd2ImHg3EokkbG0NSBISi/dJEHvXNXK2Jc7fTg0jwPjIr37zM85k2rVhom7rQQX4sod0iRbH6Y0eKy1/zKheWxIdink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211075; c=relaxed/simple;
	bh=p44L3ktYE7wsTz+yPhthNvI8xkNxkt79n4s0hWVzW80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WkNejWoutIj4Dwf3TvuK03Lg14IcVl3PPCDzqwXivwRktDkbXGXZOi8+hSw2kv0Mzcyd3t56mf+b8+WQuqzNi3THhDcjenR28OA4wUpOhK7Fjh2JeqiSOzyr4lsLUYvqnIG+tncPiLwR1z9TH/CX0ltENGEdPb0SroTaSXj9Qic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWSGpY5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWSGpY5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33661F00899;
	Mon,  5 Oct 2026 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211065;
	bh=JD672zD8fmJx/1Swgt1jy+BMrfvm7NBUA4gNGXdVeZQ=;
	h=Subject:To:Cc:From:Date;
	b=ZWSGpY5YAcqKusdM1eKNveWq5MzEiXuLrRStLB/vch7X4gWpWtiLIY3ZbdKzPfeh8
	 /Nx+hn10GvlNXchfDl+wMxjWTfQEAPBlAa31dYfNerfNQvPsJEXlO+NQWzdMg0JZHY
	 k+yuXhJQnOXG7WHJDejSrGE3/t5i81eVvzNs5Mjw=
Subject: FAILED: patch "[PATCH] wifi: mac80211: count only matching reservations in reserved" failed to apply to 6.12-stable tree
To: zhilinz@nebusec.ai,johannes.berg@intel.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:37:34 +0200
Message-ID: <2026100534-reoccupy-afterglow-c3a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 437f3727b4fd715266c296435c116288f82666fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100534-reoccupy-afterglow-c3a1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 437f3727b4fd715266c296435c116288f82666fd Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Mon, 3 Aug 2026 11:28:22 +0800
Subject: [PATCH] wifi: mac80211: count only matching reservations in reserved
 switch

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

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 75bb204ad743..17b935448f13 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1772,7 +1772,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 }
 
 static bool
-ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link,
+					struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1782,6 +1783,9 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1794,6 +1798,12 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
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
 
@@ -1823,7 +1833,8 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 		}
 
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
-			if (!ieee80211_link_has_in_place_reservation(iter.link))
+			if (!ieee80211_link_has_in_place_reservation(iter.link,
+								     ctx))
 				continue;
 
 			old_ctx = ieee80211_link_get_chanctx(iter.link);
@@ -1925,7 +1936,9 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 		for_each_chanctx_user_assigned(local, ctx->replace_ctx, &iter) {
 			n_assigned++;
-			if (iter.link && iter.link->reserved_chanctx) {
+			if (iter.link &&
+			    ieee80211_link_has_in_place_reservation(iter.link,
+								    ctx)) {
 				n_reserved++;
 				if (iter.link->reserved_ready)
 					n_ready++;
@@ -1950,7 +1963,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 use_reserved:
 		ctx->conf.radar_enabled = false;
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
-			if (ieee80211_link_has_in_place_reservation(iter.link) &&
+			if (ieee80211_link_has_in_place_reservation(iter.link,
+								    ctx) &&
 			    !iter.link->reserved_ready)
 				return -EAGAIN;
 
@@ -1991,7 +2005,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		}
 
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
-			if (!ieee80211_link_has_in_place_reservation(iter.link))
+			if (!ieee80211_link_has_in_place_reservation(iter.link,
+								     ctx))
 				continue;
 
 			ieee80211_chan_bw_change(local,
@@ -2040,7 +2055,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
+			if (!ieee80211_link_has_in_place_reservation(link, ctx))
 				continue;
 
 			rcu_assign_pointer(link_conf->chanctx_conf,
@@ -2091,7 +2106,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		for_each_chanctx_user_reserved(local, ctx, &iter) {
 			struct ieee80211_link_data *link = iter.link;
 
-			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
+			if (WARN_ON(ieee80211_link_has_in_place_reservation(link,
+									    ctx)))
 				continue;
 
 			if (!link->reserved_ready)

