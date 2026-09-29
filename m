Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4833C1D7F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696657; cv=none; b=TvK39D1HR0cKDIXqI9YRdOcc59G8Q293WAnz10CB53H3yurPsqb9B1ZUS+oRClCdlMqMxDOmdsGBHhh5R8W+46mehAtrkm/C6Q/ViHw/TV9csKITgyN3rEKeEmTugLXggfIefNvU3ZLsIPxH1XFIBpaCgKRfuGpQlZkYvIgc8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696657; c=relaxed/simple;
	bh=LOWgfpif0IcHucuLosxwpXIgu8/p/e3LJiG5/0tWw1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM1BNp4d2GCdn55hXh6XtdBstk+wnpXmJ+N4j0oww0t8S7bsvl2YyHIwFp9wGgQNVb3TFabLdssTpg2vruNdot/nMjnKlb/7H9bVT4zfmDTGqrQQnwm3QgWid6qiKmeKSJJkSI0GiENPgrdU3cWylvPlJe3z4vOsbyFpoIrMq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5Ze+pJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5Ze+pJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0AC1F000FF;
	Tue, 29 Sep 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696655;
	bh=PEQ6G0IyMT375cZddwTHhXHCHj7EsmEyrYl3+x7RGYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5Ze+pJY+1Mdih3Bbbn9wuz78Zt7MLsETtvwoxyC7YzkPX/YQ26JVykcmqh+vYEJ6
	 tD3myzh7sUcDlsUQML8Q+1oV94lnBX2LDTokdp9peWKRj2MW4jZMeUDi9OF/fbtIVy
	 OWSzEMMGnlADWzXcP8PytzOviJpOwg2ye2dVExlzUhD6ns7g4PL/M8JUMaY8VUMVha
	 8JSa4H8UERIGdB3o02nk2tA8hmCS25z3Rk+B2whAAH2IZJuDnArYo0qYDgxRAt6bQ2
	 gdxpunrJWehz4Z7C6mxxJp4Qr7IfzXSIhlt4Li/kA3PaSaJX3XaBDUogB6pjYB3Drs
	 puNxN42W7Fg+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	mst@redhat.com,
	jasowangio@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Tue, 29 Sep 2026 11:44:13 -0400
Message-ID: <20260929154413.4090026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092901-amnesty-primer-ce2f@gregkh>
References: <2026092901-amnesty-primer-ce2f@gregkh>
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
index fe0e647808cd7..b98acab38ac4d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2429,6 +2429,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
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
 
@@ -2456,6 +2463,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	check_sq_full_and_disable(vi, dev, sq);
 
+kick_vq:
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-- 
2.53.0

