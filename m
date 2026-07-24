Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDD2931CF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901659; cv=none; b=BieOnPWQqIEpQk6wa++KP2WAf/euzSwPiLMuMz49Jz7Y2ca5laFyNm90W+kHirkOyI3BlL1snXsYvcOOCV+V5G3tqU7eceWClqfk3YDt1y3aaIyUbQFrZ1T7CrHL9FZ9ldmcadu1DMU7mi80WyzsrY7KHB6jM3c9Uhi8Yp18arI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901659; c=relaxed/simple;
	bh=ae02kDJUi5X34KIYSffR579iWjBAySTALBq6UhL00Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8zr+H0j6s3Zp95F7eoDRoPiNeWFIdl9txHSxoHy3z0D1rsEvqzq9JjRRdNo7PyFz5T9r1f20MVeWWevz1r2KBxWRyXt8S7XeyCF53G0a6vpVUb6OSwsXC5p/X0AFod5MkdDbiAZ/mNyUiseIdMO5UX/PZDFMH9EXejXdXN9OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5OzzveE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5OzzveE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so402513b3a.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784901654; x=1785506454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ODrAnyB1NwavZ7GNr/hLSAQWJ7QusMhucYn8aavlns=;
        b=n5OzzveEifSSRfZAJ4LYeROOYZ1/ADNswpVx/blRBUOtma2rwHvKP8TuBGGkU629gQ
         dWaRGAJgjHU5ER/vcz9Yz7QtW4nLaL0bau4iZkKxFC4GoTWXZO57p1btL2JszpoNoFWc
         t1E5d2e6pRbGcKoPIPV1lWlpN42n/1Lus9gohHsogy1z66uKns/SeIYNZostHejME4gi
         79nlkEpWvDD5vsuVQ7dngeKlCMv3MtBz1SfSlE7qU4jUOP0aqzHSL5uqxJlUjwwMvJcj
         92JwIVyaLak8khFYJ7GNhHvaQ4l56sHgcp927gHBrlNZk82kRFiRSJE0joz22a2ST/Et
         yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784901654; x=1785506454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ODrAnyB1NwavZ7GNr/hLSAQWJ7QusMhucYn8aavlns=;
        b=gtXfC/Ql8EFHk2rWiTigEifEeDKHzVg55+HYh1IJBUNyYCt/OxHISlv/dLFMzlYA/2
         t3CVzo4jIFNaoyUfvWgtycyzsG41d+mahcbwSquI5GMGt5l5ARxDvpkBbofWJVOql1z8
         pouJvDMIs5abJcT5yAuWERhYHM9QP0vTL1UOIyBglqvj+PfUN2eUa3nBsXQDCh84WOFy
         yJp9FY/zmMqQHYzOVo9oxtKo2yc51HGmn5CZlxSRehsGrd5MpiX1HL/uZKFTseBB08zu
         eYVWCoOAG7nHW/ebGIhwVli5s1QWyrmHUnECCCxJ/O63YzsM5zOqkdNtjASEHND7eu0F
         a9EA==
X-Forwarded-Encrypted: i=1; AHgh+RpKtrNZ0gHwjihw+8sYLOcFh9wQJZRpeZSrl3tZdmI1oVS7sPvAodrLOVsHScu9bR0UCQWwBq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26V1D/4O5WTNQuukyxIPEULouVep/o2bhk2UxD29vm3JBtEae
	v1tLuJMk1THY3aIzP7QLkvkNRD4+uvs7cGbPOi/VvjRBFgWVSY3RbcE0
X-Gm-Gg: AR+sD11SUlW0X2LTHUpl/M0V9iYHLprrRlSSaodwrpSNU3OopN72TZVECiy5Z1T6KYO
	fKRQfAPHvIxi8ShxsoLlBuPpea0WhkwPA0AFSgs9rdSFaNxGf1x6aRJbuSxZ1z66Bbb6iqAgr/m
	J63lneTZjjizXCj9brswl/sSffynmvBneSAfy2LJitayCamvg49Di5+W4UqreXOLXM/oop5CMa4
	LFhF/PlHXPiRJ7AjmYZGMzHNjClLQycXeIdD0KzwiEZ+YaXZbOFlopntXAjj7A+RC0iLcLytMOP
	LoQVaRId+sWWPSfNCUL7rA/GqoTTeGk762MS2D8PRHZM1qZItBuAiBiTMY1SDn2MOSArIWNx4T9
	xDZ/ak1Y+Ad8YMxuGNiyjWjRdXEmwgqFHklAZnF6okfRQP8O/PpFaq9Wz7qVwUpQh9CvQejjRZ+
	d62Xpdgj3N
X-Received: by 2002:a05:6a00:140e:b0:84e:24f:2667 with SMTP id d2e1a72fcca58-84e2b7fda3cmr8601199b3a.8.1784901653562;
        Fri, 24 Jul 2026 07:00:53 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237721sm4861336b3a.10.2026.07.24.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:00:52 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: [PATCH net v2] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Fri, 24 Jul 2026 19:30:44 +0530
Message-ID: <20260724140044.1055918-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716084746.212045-1-horms@kernel.org>
References: <20260716084746.212045-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Under memory pressure, the qede driver encounters NULL pointer
  dereferences when processing TPA continuation fragments because:
  1. qede_fill_frag_skb() does not validate the page pointer before use
  2. qede_tpa_end() checks error state AFTER calling qede_fill_frag_skb()

  The crash occurs when:
  1. System experiences memory pressure (GFP_ATOMIC allocations fail)
  2. qede_alloc_rx_buffer() returns -ENOMEM, leaving sw_rx_data->data NULL
  3. qede_tpa_start() sets QEDE_AGG_STATE_ERROR on SKB allocation failure
  4. Hardware delivers TPA_CONT and TPA_END events for this aggregation
  5. qede_tpa_end() calls qede_fill_frag_skb() before checking error state
  6. qede_fill_frag_skb() accesses NULL pointer in skb_fill_page_desc()
  7. Kernel panics with NULL pointer dereference

Example crash from production system:
  BUG: unable to handle kernel NULL pointer dereference at 0x8
  RIP: qede_fill_frag_skb+0x96/0x430 [qede]
  Call Trace:
    qede_rx_int+0xb06/0x1de0
    qede_poll+0x2f4/0x6c0
    __napi_poll+0x2d/0x130

Observed on HPE Synergy 480 Gen11 running RHEL 8.10
(4.18.0-553.134.1.el8_10.x86_64), but the vulnerable code path
exists in mainline.

Fix by:
1. Adding NULL page validation in qede_fill_frag_skb() before dereferencing
2. Checking error state EARLY in qede_tpa_end() before processing fragments
3. Checking error state in qede_tpa_cont() to skip fragment processing

This allows the system to survive memory pressure by dropping packets
instead of crashing.

Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
Cc: stable@vger.kernel.org

Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>

  v2: Addressed AI review feedback from Simon Horman:
    - Added net_ratelimit() to prevent printk storm in NAPI fast path
    - Fixed NULL buffer recycling: check if page is valid before recycling,
      otherwise just consume the BD to prevent NULL from re-entering the ring
    - Added proper cleanup in qede_tpa_end() before early exit to prevent
      memory leaks and ring desynchronization (DMA unmap + BD recycling)

  v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 39 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..748b988cbf5d 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -670,13 +670,23 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 							 NUM_RX_BDS_MAX];
 	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
 	struct sk_buff *skb = tpa_info->skb;
+	struct page *page = current_bd->data;
 
 	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
 		goto out;
 
+	/* Avoid NULL pointer dereference when under severe memory pressure */
+	if (unlikely(!page)) {
+		if (net_ratelimit())
+			DP_NOTICE(edev,
+				  "Failed to allocate RX buffer for TPA agg %u\n",
+				  tpa_agg_index);
+		goto out;
+	}
+
 	/* Add one frag and update the appropriate fields in the skb */
 	skb_fill_page_desc(skb, tpa_info->frag_id++,
-			   current_bd->data,
+			   page,
 			   current_bd->page_offset + rxq->rx_headroom,
 			   len_on_bd);
 
@@ -684,7 +694,7 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 		/* Incr page ref count to reuse on allocation failure
 		 * so that it doesn't get freed while freeing SKB.
 		 */
-		page_ref_inc(current_bd->data);
+		page_ref_inc(page);
 		goto out;
 	}
 
@@ -698,7 +708,10 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 
 out:
 	tpa_info->state = QEDE_AGG_STATE_ERROR;
-	qede_recycle_rx_bd_ring(rxq, 1);
+	if (current_bd->data)
+		qede_recycle_rx_bd_ring(rxq, 1);
+	else
+		qede_rx_bd_ring_consume(rxq);
 
 	return -ENOMEM;
 }
@@ -959,8 +972,16 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 				 struct qede_rx_queue *rxq,
 				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
 {
+	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	int i;
 
+	/* Don't process fragments if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
+			qede_recycle_rx_bd_ring(rxq, 1);
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
@@ -982,6 +1003,18 @@ static int qede_tpa_end(struct qede_dev *edev,
 	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	skb = tpa_info->skb;
 
+	/* Drop the packet if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
+		/* Clean up: unmap DMA if needed */
+		if (tpa_info->buffer.page_offset == PAGE_SIZE)
+			dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
+				       PAGE_SIZE, rxq->data_direction);
+		/* Recycle BDs from cqe->len_list to keep ring synchronized */
+		for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)
+			qede_recycle_rx_bd_ring(rxq, 1);
+		goto err;
+	}
+
 	if (tpa_info->buffer.page_offset == PAGE_SIZE)
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
-- 
2.54.0

