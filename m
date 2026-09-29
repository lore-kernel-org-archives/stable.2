Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5104FE2C3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698406; cv=none; b=PA2ScvCmm0nwPDhb/BnKA1xvutQNB9gFMgwnBPPqIbuDoBvS3qSFKkZVM0/3Uo1PWtNQisjKzWEXqshSLYS5/hhhUmt9YHD/lXIlwm8Q4oyWSAM/AmREQ+FXJ6Kldvv3IuOwfsQS3qFlCcc4Z8DNhHxE24M5k+Qe219GEOtSPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698406; c=relaxed/simple;
	bh=FSqp4KnaYA5yUAwJe97Gt6gDDmYtXJhIDcUhbMUkrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eafjIi9oe5EzSdJucM7p08EBNoJol8zRq843lr2EY2gIeSR1NfJQBnfRpM9tGNJ9PevHMDaJw93hidJoyCcadStCaBMaURQb25kWRXbHIfUuImVd9W0jwF63x3mcrcWs/nOd96mdpG1VFxRh0ResgRUE7TxvOqerweU0Hh8M/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U02fsEo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U02fsEo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96A01F000FF;
	Tue, 29 Sep 2026 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698404;
	bh=cX2Sd6Pixv48uagAs+yjZpAJ08wHTtan6omhtGO0jdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U02fsEo/314DmoMzZe8lUdQopvWz9/DudnMTi03lC0h4RBfyQ5IEbec1JR7/eGggs
	 j6AWqYCZweycyuslx6mPIDTlIPoqhl1jOAamqaYTwiUsMsgU/uZ7e0nRcqcuRaF2g3
	 8erCdjNPg41wXZ+Yu30PeW7DV8HFxrhwROF05a5FuCh+3HkIASNPO7OtqycH3VEVjO
	 QzH6A+6u+3Fx1FfmLcuDsnQGaDpRouN6w6RcBpjsIkPXNrUpQFPJ6RB7r5muxwhUVJ
	 eTVQVR+Ohw3icF9H+A+3SFWxyZUjOMZbEndEZcvq6gGOR4ZWuIkYPDYRoIt/FbHYoD
	 Ree/qvE06UAAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	mst@redhat.com,
	jasowangio@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Tue, 29 Sep 2026 12:13:22 -0400
Message-ID: <20260929161322.4117802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092903-supremacy-exuberant-b0ec@gregkh>
References: <2026092903-supremacy-exuberant-b0ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 07e1a9408b6c2f9d0cfb757b67dabb52da7a32b2 ]

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
[ omitted the xmit_more-based kick assignment to use 6.6’s existing kick initialization and notification condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index aa61bf852e2e0..a20de8924316e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1722,6 +1722,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
 
+	if (!use_napi &&
+	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		dev_kfree_skb_any(skb);
+		goto kick_vq;
+	}
+
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
@@ -1770,6 +1777,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+kick_vq:
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-- 
2.53.0

