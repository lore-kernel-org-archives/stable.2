Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F53372073
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551382; cv=none; b=JOQJmu3e07G91l6cxJp76PKhP9LC7f6Lh1VNZh3IOGGfilju57i6kPMlbhjKQz2fw2nwqDSdE0qlMVwgdZOb86BPssEd1xd+GOUtHH3pNtI6ll15/ijuiBSehQNcFhV/qH89W8E4WF+SIcRyTxy+bxHw9mEwrj651m9z/COtQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551382; c=relaxed/simple;
	bh=RGQ9QdNxUzFqLEKHCt/kxCCwwD8YpKnIkxIjJpsuS9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ciyNdeoVyidjmsgvwx5FNUa26HBdLTt4AQ/zqeoJILHJLtL9AWeDFR8GfdVpPcT+h1bvJy9310ZOJNlKIn+456Jvuo8b5MNoP1YCI6iRmjbenltJBZbD4jjcXFz1PB7ycJC6TYSHaykiP2zDYRCD+gM/Umk96+Hl4gr2FvaFJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z81i3vlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z81i3vlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CAB1F00A3A;
	Mon, 20 Jul 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551381;
	bh=hJO2moRoNWIDkVTGIcTEFqrpYC/gFTBbEyORWN5Rcms=;
	h=Subject:To:Cc:From:Date;
	b=Z81i3vlMmcxHNv2FBKphBXufULLj4EWY8P2lK82T153lds6SxcpFDXKjX6ume7iPP
	 ThnFj+LlwOWhdbhfGhCpCROYcVV7Ao7Zlw0dnNV9ZBCWtNnSHs7tHn9+HVSeaYf+2F
	 3gWFU1Agw6UulyROlKHoHmgndvR8cWbhGGPZ247Q=
Subject: FAILED: patch "[PATCH] batman-adv: ensure minimal ethernet header on TX" failed to apply to 5.15-stable tree
To: sven@narfation.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:42:42 +0200
Message-ID: <2026072042-pretext-impound-67fc@gregkh>
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
git cherry-pick -x 49df66b7993c80b80c7eb9a84ba5b3410c8296a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072042-pretext-impound-67fc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49df66b7993c80b80c7eb9a84ba5b3410c8296a0 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 2 Jul 2026 11:46:21 +0200
Subject: [PATCH] batman-adv: ensure minimal ethernet header on TX

As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
at least eth header len bytes"), it is possible by for a local user with
eBPF TC hook access to attach a tc filter which truncates the packet and
redirects to an batadv interface. But the code assumes that at least
ETH_HLEN bytes are available and thus might read outside of the available
buffer.

The batadv_interface_tx() must therefore always check itself if enough data
is available for the ethernet header and don't rely on min_header_len.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 511f70e0706a..0b75234521b6 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -195,6 +195,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto dropped;
+
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 

