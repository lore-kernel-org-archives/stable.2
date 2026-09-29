Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25C253340
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664080; cv=none; b=oQCJnYTStXKeHpslr9EMQ9IHxjYpHAKhF5MUP6mifsayq6Vc8f+7QHTSSjx9Wy9LOcIavOc1YBQtb1+dbBrYjxyueNUiADYvMZqYDFa29ornZ3hlaG6pvsZYa3c5pRpxzyqfBhPZ7zc/qo0haih51I0hw50+sygQ0qeo2cK2IU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664080; c=relaxed/simple;
	bh=xf1YnLFwpWgDp6neh+3fgW6qiHK4BvCuF8tSD2wBv/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XttZuhT5dtorsBYiybCVGu1sLt+K+O6sjU+EuFD0JTMwGXhK1dUZ01+CPNuJgqsB1j9CJFnr4JqClO4VuzeAxN+QYh/kAkd312li8+ca+ujF0eVLj2jF9POMSZks/xl3p3sDYxjSZk9knOhx+Igm0ItbZL9kkhpyMMqgUQFtU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2e39SVYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2e39SVYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF391F000FF;
	Tue, 29 Sep 2026 06:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664078;
	bh=USazyICS2RYM/GG9Fi6B74lDsnCU6IEuVo8BaIO18iw=;
	h=Subject:To:Cc:From:Date;
	b=2e39SVYcUpBWLFnKKFwcaEh+ciGR+ZhqPxKJ1DTRhdTf0haGCCIyYHWaSbFlgnbyh
	 az2TLK44SpvEcYxlU3eNl7cBnj7dIUtyVKlGi2j/HJBZZX27aTI6HkghHOT9eEJ0VU
	 Jj804DHAmcBWbs6O0a3JEMeSztTVY7reBEJRx+0s=
Subject: FAILED: patch "[PATCH] virtio_net: copy zerocopy frags in start_xmit without NAPI" failed to apply to 5.10-stable tree
To: willemb@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:41:03 +0200
Message-ID: <2026092903-supremacy-exuberant-b0ec@gregkh>
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
git cherry-pick -x 07e1a9408b6c2f9d0cfb757b67dabb52da7a32b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092903-supremacy-exuberant-b0ec@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

