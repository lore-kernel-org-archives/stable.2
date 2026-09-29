Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFD3451BB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697687; cv=none; b=XGz67+61KZxeJvqwflcuEvgBucS70wclWhuZJxmvLqNXaba4zkrjI03LlwN6Gql9YY/lQ6efRjVKXfLsG+eP53FnjmU0OaXPeknxAorLXLZH89i0jjd6GywKghnA5BhDVAj9o/vdJh6ctGiIJcW3pe5eJ38X+IX/krssk/pz33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697687; c=relaxed/simple;
	bh=dyxXlUuxDRcD/KBB5CLDY42TGrVRS10bJG43BRDxcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jzia9pjPfb2gexo/hyfxTD4YBq0dAoE1q6FJwuzctPbr9Xl7v24DjBgLt2ZN5M5Z5LVx+9natWwwrNgbbnzXhFuuqRn2gE55zbqea3WoDaQYPOI3EMyvO8ZXjMUyKntAvv2r0ktW4xwMitvqko9LKx1Gx3bWbUeRLyFp2m7GYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgWsqcJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgWsqcJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BD31F000FF;
	Tue, 29 Sep 2026 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697685;
	bh=l+S1AoYvHx0G/yol2iWtR7C33PbTU9OojbZbt8Wyud8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgWsqcJeJLo4Lv1xXbs95Cq31jak1MulI1Hz5MlShR2mVCWIvirUT1jnSstERwwai
	 EnZomRN4qS8Q4Whl/wz8JfScexXqZjrPUQGKrmQWgfLr6IG/7vakOxugU1Yu56sqJh
	 F5RDBJYYQ/ofX+dYN5qkkjIpO0N00+UJQZalI1hTprlGZl2nQnKC4CAPY2Y98tDL0n
	 EmFBqCqLA2iWD3uWrTsyJ8WewtBUl+ktf/qCK4narI2NormYmCVNTj35jFEVR/UOhU
	 TSS0HOa08T2Tw3aqz2G0yBvsxa50GeT4oCZ5q2RzQVa1WvgAez834PsUj3SUd75yYI
	 QT2tqKhron3XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	mst@redhat.com,
	jasowangio@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Tue, 29 Sep 2026 12:01:23 -0400
Message-ID: <20260929160123.4106130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092902-resample-evade-34b3@gregkh>
References: <2026092902-resample-evade-34b3@gregkh>
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
index 535ea3ad3a8cd..a6101cb1d3115 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1813,6 +1813,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	} while (use_napi && kick &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
+	if (!use_napi &&
+	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		dev_kfree_skb_any(skb);
+		goto kick_vq;
+	}
+
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
@@ -1863,6 +1870,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+kick_vq:
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-- 
2.53.0

