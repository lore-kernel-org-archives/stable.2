Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246E4A7C81
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106365; cv=none; b=UHkgo0PbsA3EKrU+o6fh+PX+0reQw773d6XsFbCUDq5sijrkTN7hlxB0YgewKzdt7KLTU5cWtxN21TMlx1f/n+Te46xjwRJS2UCP+SNfrJYEnLvR1rq8xkSPzXRjPvcB/2HHiFpzAAoGof4MtZvu1a/a/cekfcj3PHO9J/aVPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106365; c=relaxed/simple;
	bh=8MoaxatY2izDoNAYUPA3y7R0UpDFQ0rXZF4ec6yabMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZNEOtOjNtRzPIOJORAFlPV9GnYZveU2ybb0qKRNx1WOb/xKtz9O9ZLmpNoN5Wj800uTwOuaj7fjP4QZsQnEOcoC4vG15+JOU1vyqs3svkd0wL9zfwm27uoikBAWBNl1AaKTGZTGgAFAetrDPWPKKr3olwKiO+vqujtcj2tas50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ty7KKIUU; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ty7KKIUU"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso2055965ad.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106353; x=1790711153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tz/q0nSTLJ4QRO3t2821L4KQPs7Ia7F9nioYJaCojlQ=;
        b=ty7KKIUUBsIG7gQP2wBYce8qEzE6r3Yt5nLvdn3shhm3+4U3/VJIARTV70i5513tv5
         Jvv3fOrykovpfVPl1SkXVo0jRDeoWa/zNoTwN2D+O8Qzn6Xvp1H2OxZcGbB0mb7Ou7eH
         Gmn3oFo7LwIOm6dKA5wLxR7bKnTeOqOhKUaVQrLK5KzTJyKDCUAzQddsERGULmJoBKeI
         I1ecHz7o5IHRVMdaUCidBf+bgrij3IKBB39ku8/Vk5th5mJ1qaBeO54xgBOlAmvvFmwV
         ODp26ElXO200WWwvmUJBLrCi5ke+j2llrKL0NlFpVDIBuaX0/aBwZmvJ8HHx7x8Uf/s0
         Dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106353; x=1790711153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tz/q0nSTLJ4QRO3t2821L4KQPs7Ia7F9nioYJaCojlQ=;
        b=tkwFaEuuFGvS8GFKcrZSmTxEkJPk9imlkJna/RcQ/LOkj/KtJ3JkgT9/yWqObnpIdS
         v0MpzCSkVCqHomJ/f6G2hQ7y7qx7EAOnMY8OqIBrHrzV0JQ+vz+UMAtfuvzsrBbfxC5F
         WMawpKrVqe+sJqukqY8b76DW37I6c3SM9SfZnoYy2pYIlSJmiwB2ute38zFt1GWDibMI
         /Om37fW6NOsi8awC//+c8Ust8vxAklauoNuWv3u17kDt+i2c6d9sJOsiWfa18xwZ+SR0
         xdmTyh90M83oLK/eaWySvvpvZhAEwDh4xdRzoYXLDYF/HuF4kMmsj1EcBMjnPT+wyX6x
         R9aw==
X-Forwarded-Encrypted: i=1; AKwUvBzIvCLwNo7kLJN01vcKVMyvCESZR7ZyJCKmQjM7Sel2/irlptel4xIec1DLtpLubU2+Ki0VsAw=@vger.kernel.org
X-Gm-Message-State: AFuF++k1OCy1qVwd6kVl3OjkkGi7kKf0+gDR77Xr+38R4h0H+gyVUOFx
	C05q6+MRNUseDzMLtUrnAP188nLYWQ0EHftrtsT/jvFAE1xXJw+Xq2cKOavu5TcEK6nnDi+rg2n
	1l0c5aUhqDKzLsw==
X-Received: from pgbco10.prod.google.com ([2002:a05:6a02:34a:b0:cc1:bcd4:fc4d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b98:b0:3dd:85a8:cad6 with SMTP id adf61e73a8af0-3ddf82c4947mr500247637.45.1790106352893;
 Tue, 22 Sep 2026 12:45:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:32 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-9-joshwash@google.com>
Subject: [PATCH net v2 8/9] gve: ensure XDP mem model is registered when
 disabling XSK pools
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When disabling XSK pools, QPL and RDA modes have different behaviors,
but they are both incorrect in that the function returns just after
unregistering the memory model.

RDA mode performs an internally consistent re-configuration of rings,
making the extra logic, including the XSK pool unregistration,
unnecessary. However, it is possible for the reconfiguration to fail due
to memory allocation. Instead of freeing and re-allocating ring memory,
stop the rings and reinitialize the ring state. That way, failure to
stop the rings would result in a safer device reset, making it safe to
unregister the pool regardless of the error condition when stopping
queues. This change involves a bit of refactoring in the TX
initialization path, introducing new methods to reset ring state when
stopping the rings.

QPL mode, which does not need to reconfigure rings due to not posting
XSK umem to the hardware ring, simply misses registering the RXQ XDP
info with the MEM_TYPE_PAGE_SHARED memory model.

Make a best-effort attempt to register memory model in both cases.
Because memory model registration can fail and xp_release_deferred
cannot, the XSK pool must be unregistered and DMA-unmapped regardless of
whether memory model registration succeeds. In both cases, there should
be a guarantee against the device DMA'ing into freed memory, however.

Fixes: 077f7153fd25 ("gve: merge xdp and xsk registration")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v2:
- Newly introduced
---
 drivers/net/ethernet/google/gve/gve_main.c   |  77 +++++++++-----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 101 ++++++++++++++-----
 2 files changed, 126 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f2bd4011de23..787d311ff99b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1715,15 +1715,56 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 	return err;
 }
 
+static int gve_unreg_xsk_pool_live(struct gve_priv *priv,
+				   struct net_device *dev, u16 qid)
+{
+	struct gve_rx_ring *rx;
+	int err;
+
+	rx = &priv->rx[qid];
+	gve_disable_xsk_napis(priv, qid);
+
+	gve_unreg_xsk_pool(priv, qid);
+	if (gve_is_qpl(priv))
+		err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
+						 MEM_TYPE_PAGE_SHARED,
+						 NULL);
+	else
+		err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
+						 MEM_TYPE_PAGE_POOL,
+						 rx->dqo.page_pool);
+	if (err)
+		netdev_warn(dev,
+			    "Failed to register memory model after unregistering XSK pool");
+
+	smp_mb(); /* Make sure it is visible to the workers on datapath */
+
+	gve_enable_xsk_napis(priv, qid);
+
+	return err;
+}
+
+static int gve_restart_rings(struct gve_priv *priv)
+{
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	int err;
+
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	err = gve_queues_stop(priv);
+	if (err)
+		return err;
+
+	err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	return err;
+}
+
 static int gve_xsk_pool_disable(struct net_device *dev,
 				u16 qid)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct napi_struct *napi_rx;
-	struct napi_struct *napi_tx;
 	struct xsk_buff_pool *pool;
 	int err = 0;
-	int tx_qid;
 
 	if (qid >= priv->rx_cfg.num_queues) {
 		err = -EINVAL;
@@ -1735,31 +1776,11 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
 		goto unmap_and_return;
 
-	/* Stop and start RDA queues to repost buffers. */
-	if (!gve_is_qpl(priv) && priv->xdp_prog) {
-		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
-		if (err)
-			return err;
-	}
-
-	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
-	napi_disable_locked(napi_rx); /* make sure current rx poll is done */
-
-	tx_qid = gve_xdp_tx_queue_id(priv, qid);
-	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
-	napi_disable_locked(napi_tx); /* make sure current tx poll is done */
-
-	gve_unreg_xsk_pool(priv, qid);
-	smp_mb(); /* Make sure it is visible to the workers on datapath */
-
-	napi_enable_locked(napi_rx);
-	napi_enable_locked(napi_tx);
-	if (gve_is_gqi(priv)) {
-		if (gve_rx_work_pending(&priv->rx[qid]))
-			napi_schedule(napi_rx);
-
-		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
-			napi_schedule(napi_tx);
+	if (gve_is_qpl(priv)) {
+		err = gve_unreg_xsk_pool_live(priv, dev, qid);
+	} else {
+		/* Stop and start RDA queues to repost buffers. */
+		err = gve_restart_rings(priv);
 	}
 
 unmap_and_return:
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 80ab0a449ff5..78f946ae7264 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -208,6 +208,78 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
 	}
 }
 
+static void gve_tx_init_ring_state_dqo(struct gve_tx_ring *tx)
+{
+	int i;
+
+	atomic_set_release(&tx->dqo_compl.hw_tx_head, 0);
+
+	/* Set up linked list of pending packets */
+	for (i = 0; i < tx->dqo.num_pending_packets - 1; i++)
+		tx->dqo.pending_packets[i].next = i + 1;
+
+	tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next = -1;
+	atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);
+
+	tx->dqo_compl.miss_completions.head = -1;
+	tx->dqo_compl.miss_completions.tail = -1;
+	tx->dqo_compl.timed_out_completions.head = -1;
+	tx->dqo_compl.timed_out_completions.tail = -1;
+
+	/* Generate free TX buf list */
+	if (tx->dqo.tx_qpl_buf_next) {
+		for (i = 0; i < tx->dqo.num_tx_qpl_bufs - 1; i++)
+			tx->dqo.tx_qpl_buf_next[i] = i + 1;
+		tx->dqo.tx_qpl_buf_next[tx->dqo.num_tx_qpl_bufs - 1] = -1;
+
+		atomic_set_release(&tx->dqo_compl.free_tx_qpl_buf_head, -1);
+		atomic_set_release(&tx->dqo_compl.free_tx_qpl_buf_cnt, 0);
+	}
+}
+
+static void gve_tx_reset_ring_dqo(struct gve_tx_ring *tx)
+{
+	size_t size;
+
+	/* Reset dqo_tx fields. */
+	tx->dqo_tx.head = 0;
+	tx->dqo_tx.tail = 0;
+	tx->dqo_tx.last_re_idx = 0;
+	tx->dqo_tx.posted_packet_desc_cnt = 0;
+	tx->dqo_tx.completed_packet_desc_cnt = 0;
+	tx->dqo_tx.free_pending_packets = 0;
+
+	/* Reset dqo_compl fields. */
+	tx->dqo_compl.head = 0;
+	tx->dqo_compl.cur_gen_bit = 0;
+	tx->dqo_compl.xsk_reorder_queue_head = 0;
+	tx->dqo_compl.xsk_reorder_queue_tail = 0;
+
+	if (tx->dqo.xsk_reorder_queue) {
+		size = (tx->dqo.complq_mask + 1) *
+			sizeof(*tx->dqo.xsk_reorder_queue);
+		memset(tx->dqo.xsk_reorder_queue, 0, size);
+		atomic_set(&tx->dqo_tx.xsk_reorder_queue_tail, 0);
+	}
+
+	size = sizeof(tx->dqo.tx_ring[0]) * (tx->mask + 1);
+	memset(tx->dqo.tx_ring, 0, size);
+
+	size = sizeof(tx->dqo.compl_ring[0]) * (tx->dqo.complq_mask + 1);
+	memset(tx->dqo.compl_ring, 0, size);
+
+	memset(tx->q_resources, 0, sizeof(*tx->q_resources));
+
+	if (tx->dqo.tx_qpl_buf_next) {
+		tx->dqo_tx.free_tx_qpl_buf_head = 0;
+		size = sizeof(tx->dqo.tx_qpl_buf_next[0]) *
+			tx->dqo.num_tx_qpl_bufs;
+		memset(tx->dqo.tx_qpl_buf_next, 0, size);
+	}
+
+	gve_tx_init_ring_state_dqo(tx);
+}
+
 void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
@@ -222,6 +294,7 @@ void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx)
 		netdev_tx_reset_queue(tx->netdev_txq);
 	gve_tx_clean_pending_packets(tx);
 	gve_tx_remove_from_block(priv, idx);
+	gve_tx_reset_ring_dqo(tx);
 }
 
 static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
@@ -270,11 +343,10 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	netif_dbg(priv, drv, priv->dev, "freed tx queue %d\n", idx);
 }
 
-static int gve_tx_qpl_buf_init(struct gve_tx_ring *tx)
+static int gve_tx_qpl_buf_list_alloc(struct gve_tx_ring *tx)
 {
 	int num_tx_qpl_bufs = GVE_TX_BUFS_PER_PAGE_DQO *
 		tx->dqo.qpl->num_entries;
-	int i;
 
 	tx->dqo.tx_qpl_buf_next = kvzalloc_objs(tx->dqo.tx_qpl_buf_next[0],
 						num_tx_qpl_bufs);
@@ -282,13 +354,6 @@ static int gve_tx_qpl_buf_init(struct gve_tx_ring *tx)
 		return -ENOMEM;
 
 	tx->dqo.num_tx_qpl_bufs = num_tx_qpl_bufs;
-
-	/* Generate free TX buf list */
-	for (i = 0; i < num_tx_qpl_bufs - 1; i++)
-		tx->dqo.tx_qpl_buf_next[i] = i + 1;
-	tx->dqo.tx_qpl_buf_next[num_tx_qpl_bufs - 1] = -1;
-
-	atomic_set_release(&tx->dqo_compl.free_tx_qpl_buf_head, -1);
 	return 0;
 }
 
@@ -304,6 +369,7 @@ void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx)
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
 
+
 static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 				 struct gve_tx_alloc_rings_cfg *cfg,
 				 struct gve_tx_ring *tx,
@@ -313,13 +379,11 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 	int num_pending_packets;
 	size_t bytes;
 	u32 qpl_id;
-	int i;
 
 	memset(tx, 0, sizeof(*tx));
 	tx->q_num = idx;
 	tx->dev = hdev;
 	spin_lock_init(&tx->dqo_tx.xdp_lock);
-	atomic_set_release(&tx->dqo_compl.hw_tx_head, 0);
 
 	/* Queue sizes must be a power of 2 */
 	tx->mask = cfg->ring_size - 1;
@@ -350,13 +414,6 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 	if (!tx->dqo.pending_packets)
 		goto err;
 
-	/* Set up linked list of pending packets */
-	for (i = 0; i < tx->dqo.num_pending_packets - 1; i++)
-		tx->dqo.pending_packets[i].next = i + 1;
-
-	tx->dqo.pending_packets[tx->dqo.num_pending_packets - 1].next = -1;
-	atomic_set_release(&tx->dqo_compl.free_pending_packets, -1);
-
 	/* Only alloc xsk pool for XDP queues */
 	if (idx >= cfg->qcfg->num_queues && cfg->num_xdp_rings) {
 		tx->dqo.xsk_reorder_queue =
@@ -367,11 +424,6 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 			goto err;
 	}
 
-	tx->dqo_compl.miss_completions.head = -1;
-	tx->dqo_compl.miss_completions.tail = -1;
-	tx->dqo_compl.timed_out_completions.head = -1;
-	tx->dqo_compl.timed_out_completions.tail = -1;
-
 	bytes = sizeof(tx->dqo.tx_ring[0]) * (tx->mask + 1);
 	tx->dqo.tx_ring = dma_alloc_coherent(hdev, bytes, &tx->bus, GFP_KERNEL);
 	if (!tx->dqo.tx_ring)
@@ -397,10 +449,11 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 		if (!tx->dqo.qpl)
 			goto err;
 
-		if (gve_tx_qpl_buf_init(tx))
+		if (gve_tx_qpl_buf_list_alloc(tx))
 			goto err;
 	}
 
+	gve_tx_init_ring_state_dqo(tx);
 	return 0;
 
 err:
-- 
2.55.0.1082.g2b9226bbc0-goog

