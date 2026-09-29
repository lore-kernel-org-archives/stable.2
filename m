Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EC3D9DB6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664065; cv=none; b=ZUse2aj7jU09BMhp52VRbBcJSk/9oEWiINyzmBNFcZJELX+PhIxs9UMQc4XBk1XFbxrf2LR6Ey0kSHjXo1nVUfRDhCPKfkti9Ke1hu9oZhd2pKBROaoD04VouFSnTJ6bmPI/Gj8aqO4kXpK535VEPSepkU6jH93S7x6M0TlKeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664065; c=relaxed/simple;
	bh=8OaFY6KZGw/OaJDslyYOudcDjpNVStGI0iRoB2dlcYQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PStjXqrupwJUfl6LR8N6ryMCVTuX7VGpomsZETO++uZvg187RAInvaQ8NgC5/dfNwsQUD7sZcjZldNBY9Z7DIn0nVt0MOhmCIxgxBQJGtpuaarmog3+ewfXka5teO5SjLQzRWBoYJ4Io6iSw1K4urjNxDpcMO258XLZ7nTNIqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYLPpDGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYLPpDGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9480B1F000FF;
	Tue, 29 Sep 2026 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664064;
	bh=WOn7T07mhdAqGENSjVdUWO42fbn14DxU6eWJcxKTiOQ=;
	h=Subject:To:Cc:From:Date;
	b=jYLPpDGmQRqiM5Q2ozBsqs4CXnG0z3PqRLoJzWJz743NXoSV4/IRxljIgPSR/4l/0
	 XZFcJ+sLKTOAVfIm0K1UtcTfWdE+D9zmJ14XSqvLa0nMBEK8N4fUQNGaRGpE4bN/Tz
	 yojW/TgKABhCCY/jE/DYhiBIyGodLP68EIbeB3hE=
Subject: FAILED: patch "[PATCH] virtio_net: copy zerocopy frags in start_xmit without NAPI" failed to apply to 6.6-stable tree
To: willemb@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:41:01 +0200
Message-ID: <2026092901-amnesty-primer-ce2f@gregkh>
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
git cherry-pick -x 07e1a9408b6c2f9d0cfb757b67dabb52da7a32b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092901-amnesty-primer-ce2f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07e1a9408b6c2f9d0cfb757b67dabb52da7a32b2 Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 18 Sep 2026 20:47:28 -0400
Subject: [PATCH] virtio_net: copy zerocopy frags in start_xmit without NAPI

Virtio-net without NAPI frees completed skbs lazily on the next
start_xmit. Senders waiting for in-flight zerocopy buffers can
deadlock if they cannot transmit more packets, as then no
completed packets will be freed.

When !use_napi, virtio-net already calls skb_orphan to avoid waiting
up for transmitted skbs to be freed. For zerocopy packets that
require deep copying on orphan (i.e. those that do not set
SKBFL_DONT_ORPHAN, such as PACKET_TX_RING), call skb_orphan_frags
before orphaning to release the buffers.

This fixes the tpacket_snd slot reuse bug on skb_orphan for
virtio-net, and prevents PACKET_TX_RING from running out of slots.

This fix also touches vhost_net zerocopy packets, which also do not
set SKBFL_DONT_ORPHAN. This is fine: vhost_net packets only encounter
virtio-net in nested virtualization, and only if napi_tx is
explicitly disabled (it has been default-enabled since Linux 4.12).
In that rare case, copying the frags is desirable anyway to prevent
holding guest descriptors pinned across unbounded intervals.

This is a prerequisite for the next patch, which converts
PACKET_TX_RING to standard zerocopy completion. Without this patch
first, a bounded ring sender can stall indefinitely behind a
virtio-net virtqueue that cannot reclaim.

Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Cc: mst@redhat.com
Cc: jasowangio@gmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260919004748.1463985-2-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..bf82ef9874ab 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3349,6 +3349,14 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	else
 		virtqueue_disable_cb(sq->vq);
 
+	if (!use_napi &&
+	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		dev_kfree_skb_any(skb);
+		kick = !xmit_more || netif_xmit_stopped(txq);
+		goto kick_vq;
+	}
+
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
@@ -3381,6 +3389,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
 			  !xmit_more || netif_xmit_stopped(txq);
+kick_vq:
 	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);

