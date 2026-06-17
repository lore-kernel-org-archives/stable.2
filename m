Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F22E7631
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659951; cv=none; b=tCpsxAb7e/7b/2GxTdd7NpD+QNlLbWbY99+onnHNwAn+yQnJRudjL3yBiOgXNZcxDBbHnW10ch2RKoTSJw32EQzMKFg1qp1BKo3qO0dsi22QZVbW2S7aoCBEtw74097Zni0Ih+xCpajXoRVHwlklaXkITYJXuAepFJD1MpSfBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659951; c=relaxed/simple;
	bh=clYG1vu/qi3k0GakpbRO01Y0pp+3c9cWp59hl1H4dOE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rkwvsFr8tHsrq02k+1B3c3nGsJ59hLeaAtYPmxrIBZZXZIaDZBPZzyHCdSc1rLHERN/J582X68KWoxiw06+C9qqdSKOfQIo+xpdei2tgTzgs4EYTciQdSNYP4zXAY1/9baf9IjWV7rWamgS1PpS4ve0CdaRoP2gAw5hyu+IybJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1gtwmle; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1gtwmle"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c40358e114so60417865ad.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781659946; x=1782264746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xQgZAZkYbqIaNm8Rqc/aLHwmWCJz3RLar9c8eN0I+0=;
        b=N1gtwmleJUxJdicT5NZg/Xd/sU2srZz4t7e5zOzWeZu9a1lllsEcJC6YRpXi+rsZhR
         E0r+lGnSQEZ6Z5n+c6FFBkzj4MG7S+hX4qZNTac2cG8LkRT3I5pxF7AODa2NuC29rret
         ZotFAFCHit6HyQN9bHfntIAX+VxgzQADDB254H8IOuXpGkVF4lQ90oA6AUr2ChtbkH6V
         7Y+3/FLg2mLNydunRV90B9sJmWGeNl3WV9hfEWluXUXC5TD+jqoBECEJiRzQfvu/kXQV
         nFS6sRBXcsgmH+HDGDX4n/N03DwtB6QESULSfT5vEiRIkMdEQotEeNl40DzFjJcgtQnG
         Odlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781659946; x=1782264746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xQgZAZkYbqIaNm8Rqc/aLHwmWCJz3RLar9c8eN0I+0=;
        b=I85FXqaCS21dy/rQEGuH0/t7YPJwlTGrC1OhyS29ckAx5xZQttCGtzK9v2z2rtKn6i
         0bmbrUL1xMgwbzdU9TkrlOdVuDphRHV9f2DrCKRj5mQS7D7wWyzhkxjSzCWtN48Qf4QT
         UxU8MyYO/7f35JAXsYi5AL/zFPkq5B15Sg5trkI0ORtLaKrCLGfuYyj4iXegcYQf0B1T
         jipT+FOH0ZaomufVdJMmGycmY4ZZHrZ0kW/Ev+3DSJkHyupBnw9nJcbQqPXrQw2ZfQXV
         sL281G2G6QVhWpx3qg6ZCPbdXeuXjeYEqbU8kRZrsu9tlPQfYhxK01bKkKpszrW3sTvW
         62ig==
X-Forwarded-Encrypted: i=1; AFNElJ9PVDXUoeW1wR3s+7DR2u5UC0IuczEWrCi5i5wvxmrFYgJp1ia80r15oIr3r0MZYSPqms7MQTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAX0uWxF1jdUPaJK8JUmUQKGI8ldn0asL0vumkYU6Y+tt+Jk07
	9SSm3i6A7U7GBZyGUWLiWeqHNoKeM11Na99lY2N37tnRamIIomenxEPizLWSoPvN+CzEIzfQ4lJ
	JQ2Y1R7HwkqgxeQ==
X-Received: from plof5.prod.google.com ([2002:a17:902:8605:b0:2bf:1274:c8f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:950:b0:2c0:c4c9:4cb with SMTP id d9443c01a7336-2c6bc0c6273mr13052645ad.14.1781659946120;
 Tue, 16 Jun 2026 18:32:26 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:32:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260617013208.3781453-1-joshwash@google.com>
Subject: [PATCH net] gve: fix header buffer corruption with header-split and HW-GRO
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>, stable@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

The DQO RX datapath programs a per-buffer-queue-descriptor
header_buf_addr at post time and reads the split header back at
completion time. Both the post and the read currently index the
header buffer by queue position rather than by the buffer's identity:

  - post (gve_rx_post_buffers_dqo): header_buf_addr is computed from
    bufq->tail
  - read (gve_rx_dqo): the header is read from desc_idx (the completion
    queue head index)

This relies on the buffer-queue index and the completion-queue index
being equal for the start of every packet, i.e. on the device consuming
posted buffers and returning completions in the exact same order. That
assumption does not hold once HW-GRO is enabled with multiple
flows: coalesced segments are accepted and completed in an order that
may differ from the order buffers were posted, and segments from
different flows may interleave.

That results in two problems:

1. Wrong header slot on read. Because the read offset is derived from
   the completion index (desc_idx) while the device wrote the header to
   the address programmed for the buffer's buf_id, the driver can copy
   a header belonging to a different packet. This shows up as
   throughput drop (about 30% drop and large numbers of TCP
   retransmissions) with header-split and HW-GRO both enabled and many
   streams.

2. Header buffer reused while still owned by the device. The driver
   advances bufq->head by one per completion and re-posts buffers based
   on that. Arrival of N RX completions only guarantees that at least N
   RX buffer descriptors have been read by the device. It does not
   guarantee that the device has relinquished the ownership of all the
   buffers corresponding to those N descriptors. With out-of-order
   completions (e.g. the completion for a packet copied into buffer N
   arrives before the completion for a packet copied into buffer N-1),
   the driver can re-post and overwrite a header buffer that the device
   is still going to write into, corrupting the header of a packet
   whose completion has not yet been processed.

Fix both issues by indexing the header buffer by buf_id on both the post
and read paths. Reading from buf_id's slot is therefore always correct
regardless of completion ordering (fixes problem 1).

Indexing by buf_id also ties each header slot to the lifetime of its
buffer state. A buffer state is only returned to the free/recycle lists
when its own completion (buf_id) is processed, so its header slot can
only be re-posted after the device is done with it. This makes header
slot reuse safe under out-of-order completions (fixes problem 2).

Allocate (gve_rx_alloc_hdr_bufs) and free (gve_rx_free_hdr_bufs) the
header buffers based on num_buf_states to match the buf_id indexing.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7924dce7..02cba280 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -21,11 +21,13 @@
 static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
 {
 	struct device *hdev = &priv->pdev->dev;
-	int buf_count = rx->dqo.bufq.mask + 1;
 
 	if (rx->dqo.hdr_bufs.data) {
-		dma_free_coherent(hdev, priv->header_buf_size * buf_count,
-				  rx->dqo.hdr_bufs.data, rx->dqo.hdr_bufs.addr);
+		size_t size =
+			(size_t)priv->header_buf_size * rx->dqo.num_buf_states;
+
+		dma_free_coherent(hdev, size, rx->dqo.hdr_bufs.data,
+				  rx->dqo.hdr_bufs.addr);
 		rx->dqo.hdr_bufs.data = NULL;
 	}
 }
@@ -254,7 +256,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	/* Allocate header buffers for header-split */
 	if (cfg->enable_header_split)
-		if (gve_rx_alloc_hdr_bufs(priv, rx, buffer_queue_slots))
+		if (gve_rx_alloc_hdr_bufs(priv, rx, rx->dqo.num_buf_states))
 			goto err;
 
 	/* Allocate RX completion queue */
@@ -381,10 +383,13 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 			break;
 		}
 
-		if (rx->dqo.hdr_bufs.data)
+		if (rx->dqo.hdr_bufs.data) {
+			u16 buf_id = le16_to_cpu(desc->buf_id);
+
 			desc->header_buf_addr =
 				cpu_to_le64(rx->dqo.hdr_bufs.addr +
-					    priv->header_buf_size * bufq->tail);
+					(size_t)priv->header_buf_size * buf_id);
+		}
 
 		bufq->tail = (bufq->tail + 1) & bufq->mask;
 		complq->num_free_slots--;
@@ -826,10 +831,13 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		int unsplit = 0;
 
 		if (hdr_len && !hbo) {
-			rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
-							    rx->dqo.hdr_bufs.data +
-							    desc_idx * priv->header_buf_size,
-							    hdr_len);
+			size_t offset =
+				(size_t)buffer_id * priv->header_buf_size;
+
+			rx->ctx.skb_head =
+				gve_rx_copy_data(priv->dev, napi,
+						 rx->dqo.hdr_bufs.data + offset,
+						 hdr_len);
 			if (unlikely(!rx->ctx.skb_head))
 				goto error;
 			rx->ctx.skb_tail = rx->ctx.skb_head;
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

