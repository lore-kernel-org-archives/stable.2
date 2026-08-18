Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886F1F94F
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097201; cv=none; b=jYK0Dzh97NGkcT3UPIeX6b5a7ymscitzUOVkepAZLEVdhZpeg6cklrD/25JNjQCl+IcwIpVWOUxy1rzx4E2aq8JKrD4KX78VNKOx3vHuPf7NoXWaPBYOIBM81vlRWv2khd/HDXwTRNRrcM1CqXCExTN0s00+8u1SoCCimG86v3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097201; c=relaxed/simple;
	bh=8r8QO+4ER2+//xLMw+ASVsCY+J5pLhvzRmo3gmqz4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll7yE4zHSGlEoyzPHyqwaa8LNcze3CZ/r2dvJbQEpcSVuaEVSS676ihK+Eppg+WQk1YB6m+tAZ644PVQq7HKUiU9sLyQy5klIvfCgIN76W17lbqTFd8pgV1SUEhXd0B0G5ql81cCfS2ERdQu+LYA5LB/9qju5qTb9eduGMTNsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gyEU+noM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gyEU+noM"
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CDAF03F8AE
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787097196;
	bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gyEU+noMkN+30b4Nimcbt8lgfYi1tVES6Q/i+OO30gD1oAWLQQ6VmFCMINYbGhyCj
	 anJd7OMENQyG4nuXCpHQ983cB00nDvM3DCdPm56pXPFyzrTSXlSuLyg2Pz1JHFMaHl
	 jap7X/RQQxqEIwl9kdxsvWiC/ndh43nsChiAD2iw8sscQaUoNceur3YP8N7Oq3iGfP
	 1sLpRKV5irks3v4zcLbj0bWcoU0xN6mOXkm9muKDz5dIS4G9OtKWRuFymn9Qtdisom
	 MhhmQS3gBue0W3pRcUp5e4Jw8R/SwYKZYO4tlAihNLI1qjHqAa342I6BH+VG9PRI1Z
	 5xJP3pXk/W+5ezykIxCZZNLwdTY5ivnUWcXbwtn3DkS1ceA/CVRvC0JFa3dNRCgYDj
	 vBM0VdAmpHdN0Z4b8MSk1Qzag8Vtfl6rq4H3eexy8ZF0dnvB0xRF8/fww8nRLlxEgq
	 suMtWeo1o4tigFAin9cUT8POJQmltZrMtmyX3IgqIC7opaDyDyxhXnolnM8ScF4Onm
	 lJTflsBY3RKmpjPm/7mHbIvjj7TcS8YXtox6qZexWIy6M2nGnsYSpwDjp0i0Z5R/fZ
	 l1HruAk76eUzPFmuXjFGR4HkegYmBEFLw+dYlJgMXxzudUXlyn0kiAWD0uE3EyUY8e
	 MCLaB4Z6HNAdG5K6v1DFb+F4=
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-820111eb28aso9475407b3.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787097196; x=1787701996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
        b=VrV+SZzq7loN677vWjLzh3v6lOI3SH/sIIwz9GtT+uJoHai5megIDUTjkalNYbwDSm
         XgvIS2bb8o6HvTw6WuurfoRg4vnrrluLO/Zt3m9zs1srQoWYCVjokYurDD2zoVRvZUlG
         ifSSl4f8nTN7+6OJ7UWzr1JwnwniS/IJkkBfAtomf2kC8048EBEffEd2E+AbaAkd4by/
         NW5AmrEc9I7dqGYRtdaxGKTSHp7Cf7stLRsLYqFB7/y/agfB23GSknJkTSKx+7n+vZ+w
         M6M0As3uUDo1vIjQxk0w9st9ejZBG+KZWlqs5OGQo0I4CNeRn5EyB8GIBo7CjG6YR5NT
         TdrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSXv+JrBWmLCJkUCxeiGScfiBMYdiKmsIwp/XCDkFzVhG/R2cwEL1bH1fHVIt8MfC6PDFbhyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1F9XsbvjjIXfAHsbuH9DLOsVEM8DyFTsLFsq0VHVdjupVcbm
	Cq7+UYClT0m9hcSEHef2FEOP5Tb/7tCmJi+xrtayihkdYKm+oY9WCLiUokGRPB6zEoZ+15UtuvT
	3yN+MDOjbDThE+Qre7JYnj5PHtN5pEKDoVONFNxe1FTIQGdySOQhGlL3k1pm2WwGKFN/LziRlkg
	==
X-Gm-Gg: AR+sD11mUeQq4L+GWBCrXUESsSJjg4EpxYv0yi2+BrPj7zJ4vb/y7SpYxUdpaiq/9LV
	088tkoPs20OYCUKnaknxKIHRZn77Hr02+jp5m40WlciHCaQtDQ0qwJbolkFOR8LYMBCdjdibyCz
	HQUc1jpa4R3ovlcy4cEaLu1soFh1/KdNzIizgscehgDxJGgbvnJj4Ro7xc9PHuzsSUvNuFWvjPK
	lv8IYbGxJU9hd2w1h+uzoggMZSIh7QBA8TtNsA36GLxgkN6iyMl3pZqVtvDkYICh1//1t7+BNhN
	FT9e2F90DePQGPQ425YqFDd+wyG2CWAOJSQh0YnUIezk+J5w8PhWkyRr936whxhwo02RVTQ7skZ
	mZnw3FOBFLOb9JzM=
X-Received: by 2002:a05:690c:6e05:b0:844:7e98:fe01 with SMTP id 00721157ae682-844dd14119amr4868867b3.5.1787097195555;
        Tue, 18 Aug 2026 16:53:15 -0700 (PDT)
X-Received: by 2002:a05:690c:6e05:b0:844:7e98:fe01 with SMTP id 00721157ae682-844dd14119amr4868747b3.5.1787097195101;
        Tue, 18 Aug 2026 16:53:15 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84512474673sm931477b3.12.2026.08.18.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:53:14 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Ankit Garg <nktgrg@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Joshua Washington <joshwash@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp][PATCH 1/2] gve: fix header buffer corruption with header-split and HW-GRO
Date: Tue, 18 Aug 2026 17:53:06 -0600
Message-ID: <20260818235307.19435-2-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818235307.19435-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818235307.19435-1-rickey.castillo.valenzuela@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankit Garg <nktgrg@google.com>

BugLink: https://bugs.launchpad.net/bugs/2153950

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260617013208.3781453-1-joshwash@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(backported from commit d676c9a73bdcd8237425dbb826f2bd1a25c36e40)
[rickey.castillo: Fixed conflict in drivers/net/ethernet/google/gve/gve_rx_dqo.c
 because this kernel is missing the commit:
 ebdfae0d377b ("gve: adopt page pool for DQ RDA mode") which relocated some
 lines from gve_rx_post_buffers_dqo() to a new function gve_alloc_buffer()]
Signed-off-by: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 27 ++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8df733a7e2ef..e6decc0e7a30 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -202,11 +202,13 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
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
@@ -405,7 +407,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	/* Allocate header buffers for header-split */
 	if (cfg->enable_header_split)
-		if (gve_rx_alloc_hdr_bufs(priv, rx, buffer_queue_slots))
+		if (gve_rx_alloc_hdr_bufs(priv, rx, rx->dqo.num_buf_states))
 			goto err;
 
 	/* Allocate RX completion queue */
@@ -539,10 +541,12 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
 		desc->buf_addr = cpu_to_le64(buf_state->addr +
 					     buf_state->page_info.page_offset);
-		if (rx->dqo.hdr_bufs.data)
+		if (rx->dqo.hdr_bufs.data) {
+			u16 buf_id = le16_to_cpu(desc->buf_id);
 			desc->header_buf_addr =
 				cpu_to_le64(rx->dqo.hdr_bufs.addr +
-					    priv->header_buf_size * bufq->tail);
+					(size_t)priv->header_buf_size * buf_id);
+		}
 
 		bufq->tail = (bufq->tail + 1) & bufq->mask;
 		complq->num_free_slots--;
@@ -789,10 +793,13 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
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
2.53.0

