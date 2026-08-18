Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3A2EEE7E
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096561; cv=none; b=D93GgpAbyOMH+O+skGVX5mJ/yQ1Z6V0ELUN28XmJTgrK+by/TT3YI6QZQaH+QTZ4aVDp4HW9s4esabSN4lc4ZS94Kkc9lHyAj3NVW7Ax7nI2fltfdGHxdXV35nTG4c+Ks6g5bkAe0qJAfYV3qxAHItUlbUzALjgeLls2YBCq1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096561; c=relaxed/simple;
	bh=8r8QO+4ER2+//xLMw+ASVsCY+J5pLhvzRmo3gmqz4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UADIOTR/dast3Rs3tuK0dgx6TJX8ecPG7dNB8XCLpBGhLyMCY5LCBihUoVZQCqJ3qw/UDfrQDVnGoaGOKWTdTY3eblzp3LNaUYhBVEZOj4Gdh4yfAZScD3dgGfR0VyXi6r1o0KQdD4ys4eIAGHhQh+NNPGq4RCWMAJKs79veUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pvbQmWPc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pvbQmWPc"
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6FBB53F0B5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787096556;
	bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pvbQmWPcW1OvsfeGLTrdxn2Dmml5O8VQ/MJR/XrLtYVXicDsbGqEos2QvrRXxX5Py
	 yLlo5p6NKkApEYUYMEL84phUPJJKrkPxpt+knGky5rvh845Mh+E7rw0pB6+9O7MrHO
	 7AdgWYQcvUeSly8uS6XTRvg2dcYApBKWAkWbUA16ZxKjotvZsJvDAPxRaHIRREjXFR
	 tBaLDTgTMolej4yNQ2JxBF3QcoEFUgolCx1CW7hWLEF8yxZDEh3zQXXOe+ZW1MOafM
	 iGBsbO+nSW2HxmeJYj/KMSXHb7I1v9cRzA56Rvo43NGJkWRol2nvq8k2FpVz99HH6o
	 YwnFRBG2h8l1z0Mj5hU6LR6DYJvO7PciSGNEKYytrKOeniuBTPpCok1KWSXH2d5T1X
	 I9ukh7x/u6OWDZhoMk5FUq96M0uT8Es3GuFpFNa/pFcr2o3G95uk3wKYJJlkV/+1uH
	 gFcRJF87OfBPDXi6OtSK3oMQCaUsdOyenzTgMpWUAhsAbJUpUnQNMR7gTT4X20ypId
	 kDsBvl1Mmbu7o/74R3PxXRvxQK1DDjNx0jmNe2HyhLPdSXR9s4qf/PDA48rme+Y0w6
	 WyEpRrqfsMwEwfuAgv0iPl9gSjXS8TwRqcIrezuEs5obWH23/41VrLkhzQINPNeN1h
	 TiAk3cVJtK2iR7wfFRk3nZsE=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e735bcceaso9506197b3.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787096555; x=1787701355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
        b=ZhMhv56+DGFeyqt7zODCaCLQjexu/L38XllKLgvYsWKUZsV5eP4JRQkZfVKk4AnX2l
         5VlZu7KEoaPwv+l+551TN1VI/1fYQqE10EekP6EOyx/B0/SDvVHsEq3IJdJOw3BPBB6/
         dsAMVJKMJM7s/xdXSGNBk8xZi6mNIfZhQHandX1i0JDj2j0+GpPio2wwZ0vfKkYrOFem
         sHOn0xdCFTfnAD4h/P4LrrsN+eTZRD6+Y4jAYAjmpWNHza6CDEskWHAabMhcTKqNj2ri
         X0u/Jx+C8jn4NDFLXi7XaZUCBm4bxPlhlMVb3Og+OLbPNEjZnui2W8OClc/PubbpHm5S
         KVLA==
X-Forwarded-Encrypted: i=1; AHgh+RoWJo5RSBLJTide3Eyc70SK3ViLMWWisy4BG8LQy3z+is4EIJbDknAj4oUDUY6svlDlYdtq+jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+wO3seaHrvscWpdtT/VNmGre1vWFk4idr0Rw1LPB3AI99JS9
	A867dpE+UUokdFzyEl/VaBFVBLQYI36O0q2CxgSM0LaeRYSMe5CtdNAJ4e3hvTerd2DG5IyZYCz
	iaSi1R30tUQzq68ausa9151a1HBG42ZsnAGMroXDjpTdkYcPgCjGfLT2Pnx5nycacss+ifqCHJQ
	==
X-Gm-Gg: AR+sD10vuvzM1OJzGYr+7T5MoyXzh1cfUADmkTOoe24lUimx+gSRJNvblHstwxeFUfx
	o/m4r6e/ighrCwwYn9LR6swK+lYoOUhgoJIGEIxOBcisEvVB2I95ySpnog0j9IgxPCGe7uZDPj3
	+a9Imzf22Cyr9/fap8T9yKpmR8VQinqZmdGemEpQOEYNuwIXzioQWiG4MXDjvQLDu7sYNg+WhSt
	62Ei4/KJijYCnpgRg0cKPRMQiDLF1Yd1UUzvOmtVQdxf7W6HBRzgX7vjIqOWEH1MYcQkVXFQofw
	Fz5o8H0+efv9+3jiMYAK548QNYi/qdvzi5BHZfdN8MU4oklgQCg/YF0GWaDJyZhIsDR5P1FFH4t
	lQG5TG8icylFgcpc=
X-Received: by 2002:a05:690c:e691:20b0:81d:5806:ecc7 with SMTP id 00721157ae682-844dd142937mr2983867b3.1.1787096555264;
        Tue, 18 Aug 2026 16:42:35 -0700 (PDT)
X-Received: by 2002:a05:690c:e691:20b0:81d:5806:ecc7 with SMTP id 00721157ae682-844dd142937mr2983567b3.1.1787096553250;
        Tue, 18 Aug 2026 16:42:33 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84512c4072fsm842827b3.17.2026.08.18.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:42:33 -0700 (PDT)
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
Subject: [SRU][N:linux-gcp 1/2] gve: fix header buffer corruption with header-split and HW-GRO
Date: Tue, 18 Aug 2026 17:42:25 -0600
Message-ID: <20260818234226.18814-2-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818234226.18814-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818234226.18814-1-rickey.castillo.valenzuela@canonical.com>
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

