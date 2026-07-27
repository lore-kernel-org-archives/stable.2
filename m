Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3763EDAD9
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144813; cv=none; b=S9Bh/LE+qT+tPh1ln14MKEyL8OV5TzXD4yDAS+wd2fG3VPvsegqypiOrrqJTV6y2o1Fp3rNNbumt3nth4HUw4IvJ7TvdIe8NSdzolCbsbJ4mymRpExt6k6GMcgmfOSr2jO/aRZQZHd3jW0Mw8pTirN1WPErYpSCIpuBT05vXJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144813; c=relaxed/simple;
	bh=X+YegrBBhRAi4oW55RZLgS1GnS6TchcCHYhjOP1LOxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIGw2aZKC+pw+kiBfg4PIPXdi0oqo/25xdqmEO8hiOHPsH2ewvRemUkKkOvVngCBTgq9OQA5RZYSXeMVlTN0SPMsSonmoeHLGDbqTk0c+4OkQ5ua3GU0fpuDeM+Qy3qNXZEVTlVLh22abwPtUa+KqkctW/6jLmZt1avIZnOWSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwKYGMAL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwKYGMAL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so2473017a91.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144811; x=1785749611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5/cTqswXiZuGVscIIuZbdXwuPfb3kXOxcV1hKzlbOc=;
        b=nwKYGMALx6FLeJ47xWxR15/u22PJNeinBY56BjP5D+azywiEAqUvd3JSGHHLxR2Pog
         RM0zv9MeCzU6thaE50FxFoiOWsiD2YIyLdu+wM/nutpEdnH7ibu0lSMzMAsAcSZEP7nY
         G7DXx7h1DF+vjTpAbXMNvRz1nMGA1ooQp6Ngkqr8cwdX/hIOmvemgvWY4Tj9OJXmSaxB
         y7zI4gQyXue+WOMN0FK+HBDHs1n4aJNUnAOq+wJBe1nq6ctcemCa8YISyD+oiV+zodnI
         s2AHCYcLoDP7S9QKRhj4kuilDspyBz0G4w5KPYC2WrXOSLLulJYevbciMZ8qqZqt5liI
         hjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144811; x=1785749611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5/cTqswXiZuGVscIIuZbdXwuPfb3kXOxcV1hKzlbOc=;
        b=RCiJmcz3cBS4j0pufEsNmoig+xReE8AX1IS6ASNa1zSiBbCC6iOz7vKra/K0AdqQUk
         HoIqVmOhbaDJg3qcDyQgYQOa67evsMlVpCKTrxPbnWPDcco/ndbXtiFFn56bkAzLZSyy
         v1+rbDz4I35NK+XX9dCKID9c0tSk2sur0CteRQr+waCPZo7EqK3AZphZscqzjmQ3RxGt
         dUE7mqojcSiZ7jqxnUT99nlY+eQLhbHH4RTDvAv+OCOtL8phrv0jDqaPW05E9r2j1lxh
         yJoeRzN2yPfszjNia3R5mHuNt7U87FIL1yARo57VoXb84dkcP21ZuW7e6PPnriSNLeE7
         RgRw==
X-Forwarded-Encrypted: i=1; AHgh+RpcucAP74j22s57cyVZR3m80N4JqwO4t6DZwUUFIyd3PIX7WUntm7+4I14Szm4MlqRWH79BzKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/ZvXN3eHnP/WsnGhhlPl5k0tBMrWm1yR3Fn6mqaCM36OIBRa
	s3bKiGeHzebn3OFaWVEXqQqneldJG3y+E5X9BhBjPHvVygaaCifWygKS
X-Gm-Gg: AR+sD10Uap6yLE3GpOBC4WLBxHRThgbZzt4YAvHGAqoumRaemqadH+r3baTvCLLvuR+
	nXDjQnZF1QQnIJLW+Ry9gqAHqbyQUv+qVP/KigbnvR3m+bv0d/bqwn/X/QJpA1CqwsjJkJ488s/
	ztW1nGIXUWCKZ0f1/rwxTEoYeXG0qqWLKB+YAnIWg0OEGq+ByHGMnKWn7orlNMX2youMyJ3RTCX
	2jH0q+X8Wq3nKFkD1QotewvwOW35ALxTQkOS93FmnYP6NVumztsAbKKUguWggfhUDYrY2YSW7T+
	YKIf05LgnoDCRhMvUZKJVHUz2TS/WIX852wkGtb8gzikt5DijvsWUCKy0TE0AohL2ijt3XlaR60
	jU8kFwtvZP3+GKeU+Ald64mZt4DLyBKLy1hyYmzVVxiRszUUstNvH4uWxqJcGnqj+JpFFskvYTr
	67VEhlU0PL
X-Received: by 2002:a05:6a20:4305:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c67dfeb47dmr7475969637.60.1785144810622;
        Mon, 27 Jul 2026 02:33:30 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm89948285c88.2.2026.07.27.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:33:30 -0700 (PDT)
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
Subject: [PATCH net v3] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Mon, 27 Jul 2026 15:03:22 +0530
Message-ID: <20260727093322.1119035-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.54.0
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
1. Adding NULL page validation in qede_fill_frag_skb()
   before dereferencing.
2. Checking error state EARLY in qede_tpa_end() and qede_tpa_cont() before
   processing fragments.
3. Ensuring NULL buffer descriptors are consumed rather than recycled to
   prevent NULL pointers from re-entering the active Rx ring.
4. Correcting buffer capacity tracking (rxq->filled_buffers) when dropping
   empty descriptors to avoid Rx ring starvation.
5. Validating uninitialized buffers before reusing them in error paths to
   prevent DMA and memory leaks.

Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
Cc: stable@vger.kernel.org

Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 v3: Addressed AI review feedback:
   - Fixed out-of-bounds array read by correcting logical AND condition 
     order in qede_tpa_end() loop.
   - Decremented rxq->filled_buffers when dropping NULL descriptors to 
     prevent Rx ring starvation.
   - Checked rx_bd->data validity before recycling BDs in TPA error loops 
     to prevent re-injecting NULL pointers into the active ring.
   - Fixed qede_tpa_end() error jump to prevent qede_reuse_page() from 
     recycling uninitialized buffers and leaking DMA mappings.
   - Moved version history below the '---' marker per subsystem guidelines.

 v2: Addressed AI review feedback from Simon Horman:
   - Added net_ratelimit() to prevent printk storm in NAPI fast path
   - Fixed NULL buffer recycling: check if page is valid before recycling,
     otherwise just consume the BD to prevent NULL from re-entering the ring
   - Added proper cleanup in qede_tpa_end() before early exit to prevent
     memory leaks and ring desynchronization (DMA unmap + BD recycling)

 v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/

 drivers/net/ethernet/qlogic/qede/qede_fp.c | 59 ++++++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..dd6032200f52 100644
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
 
@@ -698,8 +708,12 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 
 out:
 	tpa_info->state = QEDE_AGG_STATE_ERROR;
-	qede_recycle_rx_bd_ring(rxq, 1);
-
+	if (current_bd->data) {
+		qede_recycle_rx_bd_ring(rxq, 1);
+	} else {
+		qede_rx_bd_ring_consume(rxq);
+		rxq->filled_buffers--;
+	}
 	return -ENOMEM;
 }
 
@@ -959,8 +973,24 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 				 struct qede_rx_queue *rxq,
 				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
 {
+	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	int i;
 
+	/* Don't process fragments if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
+			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
+								NUM_RX_BDS_MAX];
+				if (likely(rx_bd->data)) {
+					qede_recycle_rx_bd_ring(rxq, 1);
+				} else {
+					qede_rx_bd_ring_consume(rxq);
+					rxq->filled_buffers--;
+				}
+		}
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
@@ -982,6 +1012,22 @@ static int qede_tpa_end(struct qede_dev *edev,
 	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	skb = tpa_info->skb;
 
+	/* Drop the packet if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
+		/* Recycle BDs from cqe->len_list to keep ring synchronized */
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
+			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
+								NUM_RX_BDS_MAX];
+			if (likely(rx_bd->data)) {
+				qede_recycle_rx_bd_ring(rxq, 1);
+			} else {
+				qede_rx_bd_ring_consume(rxq);
+				rxq->filled_buffers--;
+			}
+		}
+		goto err;
+	}
+
 	if (tpa_info->buffer.page_offset == PAGE_SIZE)
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
@@ -1023,8 +1069,11 @@ static int qede_tpa_end(struct qede_dev *edev,
 err:
 	tpa_info->state = QEDE_AGG_STATE_NONE;
 
-	if (tpa_info->tpa_start_fail) {
+	if (likely(tpa_info->buffer.data)) {
 		qede_reuse_page(rxq, &tpa_info->buffer);
+	} else if (tpa_info->buffer.page_offset == PAGE_SIZE) {
+		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
+			       PAGE_SIZE, rxq->data_direction);
 		tpa_info->tpa_start_fail = false;
 	}
 
-- 
2.54.0

