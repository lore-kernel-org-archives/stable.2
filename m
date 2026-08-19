Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63B76026
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098555; cv=none; b=EjuJ2I+biUmiwBMnp80/raCewTU3yB0DyCcJyqVeLi97zIGIvxpRPVdFbkheDxyRygOSdFHFWN6bg/dmkccA778EXypeEcVf+X4udnHE2VgslmSbv+SyPdcbtVLddUbBndytMiWI726tDX1VQ2nykEqZ1jYyH/EWYxEwKOD8/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098555; c=relaxed/simple;
	bh=8r8QO+4ER2+//xLMw+ASVsCY+J5pLhvzRmo3gmqz4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVjEqYY3d4pXtjX1TaGC/vaoKzBuJeH01nOeLgafXGexX26BNuACeJsNf66j/B+O/rO5EvIXKD3WvNRAn/mZlguWw/jI61HYLnCARNU4TC058NqlevhO2c0iIbroNJgL3b3H1HMCUVuIjxA/sri1C/D+tioqTUk3RHevXbgt5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=TiL35Ifr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="TiL35Ifr"
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 10C323F72E
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787098550;
	bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=TiL35IfrbeOe0bt57W2aiRbxhfJZ5BrNIXiBgf3nXSVeMHytcwvdONhZggO4zletF
	 xBN08BRTj58yThdvyMq8Ob/6LmdrJrZhuwaiGtbY2p5yOIZTVQfG/DCB9A/F/qjOsp
	 iozl+AEQoHOWaRAgmEKN9tOAUWU8KGMdeid04bIMNq28m65oSRRrdLjDqhm+TdMebb
	 foU2WsZ+9qFB9gJAIiFubgbm9M6fNAiq3V3iIMqbFvEdTr4718vcG2AK2cM1VDTVbx
	 xnLDnOJYOBg/4FBZHVUf78cAMCBQEbhaKitOlQLU0bXvj81JtutXAQ5IRJYFZ1yfwQ
	 7bHUKvsZRu8Ls7H+ln6MUmEMJVcMAY61beIGIwlrB2O31/gTv/pAeR0UNJgLctiuw4
	 D8jmkFBXDDxaHlXsIjaDXf5RwiichoCi6wvfhDEUcq67Ih5pOqrY1aZ9jtXWRBr5Xk
	 EXgQwKFfNWzV6Gh11zVBavSrOb/e4CeDkCilnWCDR0WQVsiVVzBFPrAzXup/NgN7lx
	 vS1DHIzluFOrRnck071RnplRGtsVoSlKF+Q4NVdQ4t4w8E4KbvgN5VkNjqb4WUgKVg
	 +DeCLdknue/x4VuRrU34SuWkmmwd7+LPfnfBwks0xiS81b4MOVnPr7+RLbswmoAbm5
	 TNY7yihcT67o6EOcn3fuqg2k=
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-44ce386fe90so582416fac.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787098548; x=1787703348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
        b=M18caP8BhrGzTUiCVH9mpS4hTyqKAVol5wTS8N/DArhM7rUT2MW33Qeu4KJcZSHvxR
         33N8ZBoFq0hmj3eflk/RKVs2ACp+Kw6QkP8jKrVNjDOXw2GX2nYkFLRodlWk/s6TwORd
         PloJ+6leFIZoSvQjy0pHm/YxrcFOpqhgkEeh15Dj3xrcvRh3jAFS6Lx4TY1uoOrf4/kh
         tiCZblYz5tn/Z8X3kS1ZvB7VqG55w9M+CAPfcyrT1zyO9GXovjLfTVNuVVyvEAzAUTst
         MKYz3mc88UWfVm9D6I6Karjw/NrtihmGDzOeYTcL+2fRnabnpAa/qrsm+zLSH43tDUEe
         yDVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKYHbD6x3T+G3nzDamFeWyVWmGEOoLmHCo1SsMa+EghwTtlHoqkLgKNCaZc1ZBI8ZGC92VFpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEUZc7GO7NArJwvIsrkQbSguu2wMmTxSggLtt1+E61DSmH3lr
	23sU2fow2xdWEDC0NsbK2toppxgLo0NcO2ze/XDB6nSqNCDKTDFsiYqnvuz0BiYduCB/ZvAU23+
	XSeUjgeDpHdBKHGhaT/rampWQRP+I1u8NdHBZXgEbYEL69HDMcKfV4O0/OIfr4V+rJAxLAscJlF
	utAUBcK4+TJEw=
X-Gm-Gg: AR+sD13NLc2sBOgDIKmz1zvqLsPKEpfmHaE39G2/Yyv1mJRzTuxAw3W7X5+glG6ANJU
	+RoqB6nsWZoUxY9/V0QuLJfk6tdQubd4ahXY8CZT2WbAJY4sT2/Z3sGqsiA+HS6oUGQ9RJz+Ytr
	YWdQJYDncggGHzldFUOGKQI4Xnq9WpspjA1xLp/7r+ESVl8b6IkrzxDQuikKvj4lqqeOH7EK3x+
	Rxf15GiYMWv+WoRbycy1grHLaaEknfPVTZZonD4FFzx6CoXfr83webcn3D/NUpxAQbm7sP8l176
	lVEDIRG8stR8//4T4NV28Z837O9ORqcDjSfnG+vK/dHCkTNKpTn95sgs3p+L0YGSRi6w49q0xMT
	8uWAe8uqL5IiCSTrfS9OgAMiiiVQ=
X-Received: by 2002:a05:6820:6ac4:b0:6a3:8738:410d with SMTP id 006d021491bc7-6b13c352041mr1156770eaf.14.1787098548465;
        Tue, 18 Aug 2026 17:15:48 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac4:b0:6a3:8738:410d with SMTP id 006d021491bc7-6b13c352041mr1156737eaf.14.1787098548053;
        Tue, 18 Aug 2026 17:15:48 -0700 (PDT)
Received: from localhost ([189.163.105.101])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb51ebdsm402067eaf.3.2026.08.18.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 17:15:47 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: Ankit Garg <nktgrg@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Joshua Washington <joshwash@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
Subject: [SRU][N:linux-gcp][PATCH 1/2] gve: fix header buffer corruption with header-split and HW-GRO
Date: Tue, 18 Aug 2026 18:15:31 -0600
Message-ID: <20260819001532.21315-2-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819001532.21315-1-rickey.castillo.valenzuela@canonical.com>
References: <20260819001532.21315-1-rickey.castillo.valenzuela@canonical.com>
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

