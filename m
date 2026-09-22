Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313453B359
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089917; cv=none; b=X8+Nmz02l5ikkXZJd56SMqg4NYlK7ybX/FbF+nk37ntZjp8EjHrCNh6KdJcizyRv7+Qy81uHSvDeVRpzqaTbLRIsdU2FZpdTeFsxfzgYFVbuy6ZSFRWK6PrCy2qvjJKy+nV4XqJFkIvnevboMc2qauPVajV1Fxildn9sY71skV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089917; c=relaxed/simple;
	bh=3eqr6WtuIYJNMPq3QKXRGIvyAAQP1oG8RovKfhtTMaI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kFJKJ6aq7FVHwQE35wto6F0tqtjl1gjgJI5z59PkSJjZl74HxwHFF0jNpDmyzqVotLGNhCDOUGFfZpKvouOVm6gD7vhhlCPW+pQQDnDGpEOFuhCHlM/Bxx0VZzmDQ6P9KoGzp2q/96gYye4j7HPDZ8CVpl3fL46Vzv95RfsRg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XB3Kqxwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XB3Kqxwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C151F000FF;
	Tue, 22 Sep 2026 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089915;
	bh=LhuMXNZ9XK4FWzh9p4fQvBmr1dqqn4GJaqeod04Aeuc=;
	h=Subject:To:Cc:From:Date;
	b=XB3KqxwqDUrnkvEBppz0gduF6FGsXrcxA/YmVpIlqSYiuzQnXmvntIsvj+yAeZ7U6
	 ttMQl3u9uAK3ITcXzP2wQUaLTPQfWfyGYb/jjG4i6dDMGqRacCzMZAX8HXZBPwh9Fi
	 A8aVnK/Jmnug3qgSNdD182w9tklQYWH3+iK2bxtU=
Subject: FAILED: patch "[PATCH] wifi: mac80211: refuse to make a monitor active when it has" failed to apply to 6.12-stable tree
To: lucid_duck@justthetip.ca,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:01:21 +0200
Message-ID: <2026092221-mashed-snippet-eb34@gregkh>
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
git cherry-pick -x 2b04d6556964ae9f89819b86a0a7801e39c3aae5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092221-mashed-snippet-eb34@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b04d6556964ae9f89819b86a0a7801e39c3aae5 Mon Sep 17 00:00:00 2001
From: Devin Wittmayer <lucid_duck@justthetip.ca>
Date: Fri, 4 Sep 2026 13:03:38 -0700
Subject: [PATCH] wifi: mac80211: refuse to make a monitor active when it has
 no queue

A monitor interface only gets a TXQ if it's created active, and one can't
be added later. Setting the flag on a down interface is still allowed, so
the driver is handed a monitor with no queue. ath9k dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000066
  RIP: 0010:ath_tx_node_init+0x49/0x170 [ath9k]
   ath9k_add_interface+0x10c/0x140 [ath9k]
   drv_add_interface+0x54/0x250 [mac80211]
   ieee80211_do_open+0x32f/0x800 [mac80211]

Reached with CAP_NET_ADMIN by "iw dev X set monitor active" followed by
"ip link set X up". RTNL is held, so netlink operations block behind it.

Refuse the flag when there is no queue to give.

Fixes: 79af1f866193 ("mac80211: avoid allocating TXQs that won't be used")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260904200338.10829-1-lucid_duck@justthetip.ca
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d3558f0c7550..a1753335eb9d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -115,6 +115,10 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
+	/* TXQs are reserved in ieee80211_if_add() and cannot be added later */
+	if ((params->flags & MONITOR_FLAG_ACTIVE) && !sdata->vif.txq)
+		return -EOPNOTSUPP;
+
 	/* validate whether MU-MIMO can be configured */
 	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&

