Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1B49C4AC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947946; cv=none; b=kNxlT0LOAhNSfc4YjUMZbbPvlnNvyLfpGCI9wnHoWNBhIHMSNQ/5v6XuXOtYR2mid2pIxU7WkzRPiO6xqGxUAw/S0qf+gIBtVNETujwwZGIKsMS3TFpbU2kTQ+ElfXf221dRSTzjh3EDRCMe6QQIAT0HbZ5avy4qzpGQ6hUWcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947946; c=relaxed/simple;
	bh=qXRBiugHPHeQpiSWIvk9zHMAlN5GRaJ1JPgNo4cDcSw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y9kf3TIabJCYg0zf42c8aq/HIDytTyCYx+gPDBsp6kxkyYmjlb8f/mh3s2hR4Wfc0fQGCIAXhP4hValFnkG4ezBT9xJyTqqhAq83madRVUunUT93wRmq3mt6AtbG/T2fYxGJ//cdPpUJ3An8FebB3cyHLxBSEz7Ip162eTMPMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEdt3hQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEdt3hQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680771F00A3D;
	Wed,  9 Sep 2026 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947942;
	bh=FKh7QHzYuv5cTOGNfbwNzozb2xPcVltbuYBJETXYMi0=;
	h=Subject:To:Cc:From:Date;
	b=KEdt3hQxFKv1TvOO32Wvf8PyCMpBdOI4Uh9cxOVaSzSbYnfMzzlcBWkvUQ/w6/88q
	 UrJgd70ceq0KQL8eJsS6GuKRqJboTT95M2+zMCNy+NkHHQ+t763quxoEjgSAq4yFPe
	 8qhMng15BQkynNvNZsNEnfCeE7Mpo5QrEIADazXI=
Subject: FAILED: patch "[PATCH] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST" failed to apply to 6.12-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:56:32 +0200
Message-ID: <2026090932-fossil-parakeet-6fe7@gregkh>
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
git cherry-pick -x 7aedb59b80993c912ab45ce24386a2775150962b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090932-fossil-parakeet-6fe7@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7aedb59b80993c912ab45ce24386a2775150962b Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 9 Jul 2026 20:44:24 +0200
Subject: [PATCH] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 8e55b61dd2a6..e202088cf1fd 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -305,6 +305,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -338,6 +340,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -355,8 +360,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);

