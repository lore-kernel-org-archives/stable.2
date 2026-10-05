Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAD4AD7C0
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211082; cv=none; b=dnbCclsjcOeeP4D55K/qWUVoRk4H0XpcxhmbpZnkxO+n/PxEKmg7uS4ki23e1EwZSzqfNFq7uO+C2Q2KfpObnoZmT00whbO7GAdR7xyhdcBhHn5/bY+KxEz8k++qZDTjL4WkcxFAWzF9DdlMapGRKyJ6SS+EOL0ERiUYdPULt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211082; c=relaxed/simple;
	bh=jFneRpD3WAgATliP8xYYsd7BmQYdjzZ3ySqaUxrAAsI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fExmyBEnR9hZUNkL4WUT6X49OBueQyImkbaL1HVvYFFypuVN/J8ungWP6Amg62KCHE8z8R7FMFbD2wJWZHi4K7KWmrT9/mQPlZuj8k2IXnNU71I6eK88z0q0lejlrwnMXkDTMEQTxOctgi+Oe7GRLtzCtERm2POlRjSoSdxBars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtPKS6M+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtPKS6M+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C96F1F000FF;
	Mon,  5 Oct 2026 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211070;
	bh=tzaoBWkn/IZKWGvupAm7gVdGLoJG/F/YextyJzndcO0=;
	h=Subject:To:Cc:From:Date;
	b=NtPKS6M+5xcImSJXgbcZADgNpimvW/tUzRznl85nZJbFNCk6dncsxAtlZSNHv63+E
	 k4qqpbu0i4kAt3BTglWCsZZ5WMs8es9O3RLUKk166cIOdXbVemICyE5sfWq6xaLf8s
	 7K3VPcM0XzTgme+Xc9fWaE44zay2LOqoP4nAKLXY=
Subject: FAILED: patch "[PATCH] wifi: mac80211: count only matching reservations in reserved" failed to apply to 5.15-stable tree
To: zhilinz@nebusec.ai,johannes.berg@intel.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:37:35 +0200
Message-ID: <2026100535-entrench-prowling-0faf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 437f3727b4fd715266c296435c116288f82666fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100535-entrench-prowling-0faf@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

