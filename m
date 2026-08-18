Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF225348463
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096400; cv=none; b=o5yrG1w8OS2hKyj8n/SBEZbGNGrBdCxCkEeRoXv0mgVP1cwSGAwXoIEnKOHUxPwvyfF03FfU74gmqIDKuj1Y5Yg6FwS1kBx+az37Q/+7+72Bcs3txrWxP3cE9MtnSZhjDSBbBs/rZZD/7adrvWOmXDXrQ4JWmbG/N3IuKLzft94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096400; c=relaxed/simple;
	bh=8r8QO+4ER2+//xLMw+ASVsCY+J5pLhvzRmo3gmqz4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/VPh6Dh8ujaVU8oDN4vk5HpzvX+cHpOMbLnJKEwmgfhiBjkPFO11u4WPw1aiBncCTnyEDPGl03R65xDIFl1N6APkgT8OnjalEIGR6eZh/R+IF/P/sMd9WqsUISUnScQCCf+w+F1rTtYcJ0jsxUX7gMAsHoX3wcxmIJIYS0Y2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Fo69EgwU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Fo69EgwU"
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32D143FBB3
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787096388;
	bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Fo69EgwUg96ZpqaCHMZKdzUNK8MMBoGT7shCIZcC7RxgrukERuEHAJds0t5LXqxKb
	 6LnfESDXJ2mArIDug+cnl96qsQX/S+DLjE+mIVFCjwNGJ0QCxBaf9q0dHT/0+Dkm0P
	 bWVMGJdm2bxPDGiyAEFe2XE5Q592Z4PtpQik5vPP9FdCMsbQpaULy6Z56GtnsXL78v
	 Bx58B2LmvRx0SI+zgrkiziYGmJReSihmiXxXElWfoJxyE770dqEbAWAvpKR8a6hBaB
	 1fz5nS13wmiCSAB4i8ZAj0z0w/bwPNQ4EsBoD0wED/wOB5CE9vLg2hXRtdxztE8AHy
	 M9jT49taLRm6hVRw2npyJPGTYxAUodIC2wLm2WGfy5c8bSoSPIktGyBLLqcmFB9oCg
	 NWpUbOWA7uciBqcwadnmOdBzOXOd5RrRs3hjYmsVGS6zp5voqcSVN1bBHztEFPY/ip
	 zUu019c/fh2HEw6tpCmyumK0qWIqCzSLOWCd8FzS04nurazbahHDw3/mhGQQqkxOPY
	 0jQtH3H4eVUolOsf6uFE+eHKIK8IS1+MZ6NwZ0cQZrzwLfBqOp5XnHfIaifH7/0uP0
	 lgxanym+evaUym4Np6LdjMLLlkpk6JX5rBxiE2dAxk2CTmswfq+wz8y3lPFFbRK+Tw
	 AR3NbonRdWf8QZAHf/OunWtk=
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66c9841d667so703623d50.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787096387; x=1787701187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBANzmFBSt8Y3fp9MCaKxc8YXM7abkGyzuSUIwtQgT4=;
        b=ELY9czbZcZk3iyiuss7jiHBjtW+KQQ+iEc76e33qMpM4CpiTd48D60N2HfTiyWq3Gl
         /8TitcIAo87m6xGi+NUER2OmbKvWbZGK+zJAVhfotqQozduxRZEN1T5mAt8Cevl9KdqK
         Pzaql0VPflqGIG5n96mGIDGoxcJVHOHzABPJ/kiJt7ZiXQZxC9oB+IHbiBvOUkhubEVE
         CqV2QegiWk9umgcJoKhNLGjalEXnrq01ODnr4bvE9GDYeMk9Hwt+DSdgrseqam2CgMnF
         63tMYk1XVCijdsWcxJKAWyE9L4/WGo8LRch/wSMLFRVBTXr5e8p4p8K2+H+zmLkvi/B9
         UtKA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7GSWmRhSSbS/udFnVCZST2ui/WAFvJeyWI9KJTVkLZuF6EdMvlebdLL+xS6NNsIO9m45fFV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3AEumMlirU7ngRDNsvNZNHE+iFWKpLDxBrhQ5lP8+iadEBD0
	PmBOamPDf0+yR30Kd4mBx1RHNK5PVcd22XUrL7zZ6XJjQ22Z+oiqRLSQqhUOaeemijztoddNaFn
	vFUQBhfJifZ6POdd+tpH2WeRNzzo1OWjMSZGRZEFd8GLmjT0YxZdyBsofNA2Gte0g8q9fdAPu9g
	==
X-Gm-Gg: AR+sD13S4A1EvGfPfZQE2abIarFu5dvIwFBXXqyUvekpo6dml2d5xs2kN0xiNj8MgAu
	NR7Owfsbcpmn3OYzDSsbtHH5uUVsUuuWteGYCqITt+R3m19eqzPFTVU80H3hxFpyHXdigyVXBhA
	M86qZS4OV2yYZYkkKSUWn2FZIn61G4cld1gkg+gs6RkJdSvWmKnsKjHbFyUrsi1CKU8zN+od9CC
	3H330vT2+FuMAddQwnH+npX/NFAxl/O30t4tYaFKKrrfhql9sBtM5gD1TW08A2LBFQxkQ9Z4jP5
	Hv762pFkczr8GTBFG2f0R5ycDp1ZcEZZ1VKmpWyf1gFrm4DaxdbgxVL7PUqYCQhj7CryqqDpPYe
	cH++DW5Se++8CC8s=
X-Received: by 2002:a05:690e:1c1a:b0:664:ddca:8183 with SMTP id 956f58d0204a3-66ccb6d63c5mr217167d50.52.1787096386834;
        Tue, 18 Aug 2026 16:39:46 -0700 (PDT)
X-Received: by 2002:a05:690e:1c1a:b0:664:ddca:8183 with SMTP id 956f58d0204a3-66ccb6d63c5mr217117d50.52.1787096384812;
        Tue, 18 Aug 2026 16:39:44 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb172b96sm180454d50.15.2026.08.18.16.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:39:44 -0700 (PDT)
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
Date: Tue, 18 Aug 2026 17:39:32 -0600
Message-ID: <20260818233933.18570-2-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818233933.18570-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818233933.18570-1-rickey.castillo.valenzuela@canonical.com>
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

