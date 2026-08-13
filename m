Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB42931FB
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582240; cv=none; b=eY2PgVSilPVd1OmQIz7G+pRJm9yR/YAQWTH8TptUOezxsvSauMwybpQQOzFlFVlgxXM/osiYUGA1S65wgI1s652PPzhoMbWVTU0PKLPbpllyGH3M1Fy/2MoU2HQxIznaTCMH6+eEd/0swSDjcdR9UoFcd4JxdmjtkvN7xhxPKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582240; c=relaxed/simple;
	bh=On+VH+4RVfM/aJDJiEPZRvi/Cwjo8OnWC6XQuGyX8C0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F1wL0W5cnXyQRBpaNk/Z2iQkYho8SIBkTP1Uqjqxfb2ZQZDuB8D5ds/YDG4Mw3hnR5ApZkydUkWl9AVhRrRyRShB0fMK1gaz/JvJOSxVFZ2iz9h75sLBuf9G4KYfG1k0YJ2B2UbZoEGhtzXIrvAY/lEQCRCTTiwJt/0DkHufo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n3OcB2jr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n3OcB2jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB011F000E9;
	Thu, 13 Aug 2026 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786582235;
	bh=sH4Rf3/JwfXCkbQk8q1kX2dJOiGTPsglSNJN+XJi4PE=;
	h=Subject:To:Cc:From:Date;
	b=n3OcB2jr0gULnlh4sx3gix7SF8GjIip5BwbYUKGxupATAEj7Cpae/GbXVcetO7Gfq
	 UeR5NBGA3R4e/CkMZiFhKNq62zaNrta4ej1H5fsOVPJ52SNkSDU5NMIIXtqsM3w+l3
	 qfnvp4ugYa7BFu2loR1hRsi+c3RWYy21pbdmZg9E=
Subject: FAILED: patch "[PATCH] net: tap: set skb->dev before parsing virtio net header in" failed to apply to 5.10-stable tree
To: dongli.zhang@oracle.com,kuba@kernel.org,mst@redhat.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 09:48:53 +0900
Message-ID: <2026081353-startle-promoter-64a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3874892dd27d5387aa9a06f58d9060f18f351d24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081353-startle-promoter-64a7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3874892dd27d5387aa9a06f58d9060f18f351d24 Mon Sep 17 00:00:00 2001
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Sun, 2 Aug 2026 15:46:12 -0700
Subject: [PATCH] net: tap: set skb->dev before parsing virtio net header in
 tap_get_user_xdp()

The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
dev_parse_header_protocol when skb->dev is null") fixed a crash in
tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
This is required because virtio_net_hdr_to_skb() may invoke
dev_parse_header_protocol(), which dereferences skb->dev. Without the
assignment, a NULL pointer dereference can occur.

However, tap_get_user_xdp() still parses the virtio-net header before
assigning skb->dev. When the vhost TX path passes an XDP buffer containing
a GSO virtio-net header but the protocol is set to zero on purpose,
tun_vnet_hdr_to_skb() can reach dev_parse_header_protocol() while skb->dev
is still NULL, resulting in a crash.

Fix this by looking up the tap device and assigning skb->dev before calling
tun_vnet_hdr_to_skb(), matching the ordering already used in
tap_get_user(). Preserve the existing RCU read-side critical section across
dev_queue_xmit().

Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
Cc: stable@vger.kernel.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260802224612.264563-1-dongli.zhang@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index fae115915c8e..5d2d34d24ce8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1074,10 +1074,21 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_hdr(skb)->h_proto;
 
+	rcu_read_lock();
+	tap = rcu_dereference(q->tap);
+	if (!tap) {
+		kfree_skb(skb);
+		rcu_read_unlock();
+		return 0;
+	}
+	skb->dev = tap->dev;
+
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err)
+		if (err) {
+			rcu_read_unlock();
 			goto err_kfree;
+		}
 	}
 
 	/* Move network header to the right position for VLAN tagged packets */
@@ -1085,15 +1096,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-	rcu_read_lock();
-	tap = rcu_dereference(q->tap);
-	if (tap) {
-		skb->dev = tap->dev;
-		skb_probe_transport_header(skb);
-		dev_queue_xmit(skb);
-	} else {
-		kfree_skb(skb);
-	}
+	skb_probe_transport_header(skb);
+	dev_queue_xmit(skb);
 	rcu_read_unlock();
 
 	return 0;

