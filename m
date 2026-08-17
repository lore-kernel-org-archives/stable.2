Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AD41D133
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970655; cv=none; b=Zkrr1ynESyAO+xPXmCmIxKxCjrKuClqjK/GnrbOVPSUYsKpcqxaGvmBI9AbNpyqs8/hox031Is+qs7sJ7JWHIIOjtDbE4fsuHLcFNfaBgdI7DwV3p43yZc9anlICFe1EcZopTHocxwFTFIjcRbo2HbIvKjjZEsnuGV7bL4UHYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970655; c=relaxed/simple;
	bh=ObvUoJV7jgaKbkxF0KrDgOsvi2Fadpv5AZ5fv7DiuU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fL9XJv3C6HZK1y+HyfH5dsRviHPgkRTVxF1XQ8ft9bvQVzq9nSDk+HmwBSU9WHlkNXJBVksMkES4fyOOw7YW25lpql+d8GdAtyZGawaBz5pO5fbx6PJtL5ffkTrA6/V+0TDDVK3xd2UIfgyoLtSLJatW5P/+snf1SX+2jk1Iso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNEy0EaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNEy0EaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDA1F000E9;
	Mon, 17 Aug 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970654;
	bh=kWIyIZzeWf1Jhhwbjn+4lZfj45eE/oOP6oYAPluUbnk=;
	h=Subject:To:Cc:From:Date;
	b=PNEy0EaB3UnkNlt/MwN0O+/yy687rkR93fR/za5VeKXxfzoSu53II0Yat5ESidSgZ
	 7sVkxGUcaX8qLdGvO41uvIh+0BmnuLxWLt42HtCR6MvtPK0V0/x7fSUty+DZhrhzSe
	 kAIYfe8ILwNRhaUUL4aXS1DYHJX78W9BZmZfwcGg=
Subject: FAILED: patch "[PATCH] NTB: ntb_netdev: Preserve RX queue depth on allocation" failed to apply to 6.6-stable tree
To: den@valinux.co.jp,dave.jiang@intel.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:42:10 +0200
Message-ID: <2026081710-mandolin-absence-59b8@gregkh>
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
git cherry-pick -x d2121faf133ac3bf9531b53a7e21273649a08517
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081710-mandolin-absence-59b8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2121faf133ac3bf9531b53a7e21273649a08517 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 6 Aug 2026 12:25:37 +0900
Subject: [PATCH] NTB: ntb_netdev: Preserve RX queue depth on allocation
 failure

ntb_netdev_rx_handler() hands the received skb to the network stack
before allocating its replacement. If the allocation fails, nothing is
reposted. Every failure therefore takes one buffer out of the RX queue
while the interface remains up, and enough failures eventually stall
reception.

A retry path could refill the queue later, but ntb_netdev has none.
Allocate the replacement first instead. If that fails, drop the packet
and repost the same skb. This keeps the queue full and lets packet
delivery resume as soon as memory is available again.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260806032537.3526498-1-den@valinux.co.jp
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index c3a6ba96fc8a..029a4a532a10 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -127,8 +127,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
-	struct sk_buff *skb;
 	int rc;
 
 	ndev = dev->ndev;
@@ -144,6 +144,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -157,12 +163,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);

