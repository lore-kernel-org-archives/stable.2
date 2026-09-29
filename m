Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EA3DC87A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697034; cv=none; b=qehhQ6yRTrAis9/SoIRCWlmmxod+WIVukN5IFfaV3UYwGCFZUk0CaJtjPPF7s9nD6WV8I66V/IIFtSe77ZwDf/jTdNBSBDT78eD3rLj/NqAZ1oNs7dqgKy50Cl0yFJGrqTCjyfVYHOtfPwSq2DYib1ZlyWDA+3LTT4rfHHvJ/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697034; c=relaxed/simple;
	bh=A6ZpYVKG7wOnqmc+uHCemt07Q00HUmjOYvdAdLsMzkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qom/GxK4e7JDI3XaTlXHXnk7tIwrNLgu5Lk40LkcBGbyoUKcLVcQr4PoC3B7htIolVjrOm+9r2ISE29YS0dVE8heDjlS7Q4nXWfIlWrWz1ycjS3h6rwBBhMSedPJHkdS7NbAZc5wO2Ny81V2ql/Zpkqif+Q0AZfqFkss45mUY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/IG6J5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/IG6J5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9467E1F000FF;
	Tue, 29 Sep 2026 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697033;
	bh=0RsQ0sAOZttSARouNrlwZ7g808ABWPbshAh+eocH1UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/IG6J5o/XLM9m4HkcxW+EuY6rGj1abo091wk/K85Y28vLEjsTKswwC9T1/sa9nFJ
	 B3o9UP6E8lrtpge3GvjF/KAtnrYZnQMd9F3xk35NjYG5fTozQwlHOm7AETIgO7L78q
	 Eilx/NNn/XlNZJtP6lhWVcBL0cETdtmracNX+nGPNKr92f3h1I8R2qLfWgmO+7WOHf
	 j8a6rxpA+eQrkBj4yDD8A5W8/FWsTtq8XE0T8FGcRPJwNN2bwXh/+GszopUKNH85md
	 PXzD2Vv8mdO//ih8yCpBU231jrw0IysJeQyKHTnVl9OA9xHjJcfZvwEVexX/JjSja/
	 kHc41aK29oBEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	mst@redhat.com,
	jasowangio@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Tue, 29 Sep 2026 11:50:31 -0400
Message-ID: <20260929155031.4095315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092902-afloat-sincerity-a311@gregkh>
References: <2026092902-afloat-sincerity-a311@gregkh>
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
index 23362ef9cb8c3..d2eb3b9bdadf5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1910,6 +1910,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
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
 
@@ -1960,6 +1967,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+kick_vq:
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-- 
2.53.0

