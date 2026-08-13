Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E154788
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582227; cv=none; b=BV+QVytrE+BMe5BcfAUqSQV/ysQtSa+07u55hYec2sGAh0QYXPktIoV05ymqFS1hkaFTGzz7uAJEKK7l3Bl0WgmfOGrBzClavWXersXHYvPnLKowd7eIj476HNRzrytjERXCIkcEjO1O1yfFUSdpla8RCDCHG260v+jQk2BUBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582227; c=relaxed/simple;
	bh=0zXEoerecmJLcLAOeenj1krJJoV1WYeOPHVdSqjNIfQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uTDvuseJH+hQ7R5SNUSOmQuin94E0lIZNGNXHVtKButIdV/4GZP06LTeJJRpBW4btIbWcrTmMJfUs9drSpq74r6JCbmrK+cxP4ZBg1fqIiIUj8LRyW/E3ATVsq8szmA9B5BrWpYUSr9eoBDOdKqv/64upbNVLWB6erN0IdwTRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ot+Xvo+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ot+Xvo+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F381F000E9;
	Thu, 13 Aug 2026 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786582226;
	bh=WhXEAQ8/TMunc3jVVSZrUzfLS1lUQnRAumw2D8m293A=;
	h=Subject:To:Cc:From:Date;
	b=ot+Xvo+GpXxZSf65URBhQrEMqBQt48ylTBP2DbB0rL2QSskOZCKhr5ilQRCsxBKOi
	 N5ogAkktFFaP78bEhG05ciL6Q9Or8z+euP2+kUrIplfQp8fklzHWk1LLb39KSUKAl5
	 dYEA6tSibSBPpqsCt6Lr4MdaP+tW2h0wCFM+Du7E=
Subject: FAILED: patch "[PATCH] net: tap: set skb->dev before parsing virtio net header in" failed to apply to 6.6-stable tree
To: dongli.zhang@oracle.com,kuba@kernel.org,mst@redhat.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 09:48:50 +0900
Message-ID: <2026081350-bobcat-numerator-fdd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3874892dd27d5387aa9a06f58d9060f18f351d24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081350-bobcat-numerator-fdd3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

