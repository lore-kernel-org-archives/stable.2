Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BD2701D9
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572432; cv=none; b=MLxXvNY6HspaHMArPLESs9fl69/AG+wBfFzl8F5HTrzCz5JmLjdrxUHyJYfJZ04P53RsDmw/ZXvxV7hCtjf3zYNPiT9ojw4K/iDVxjG7lT7r+usjBrhFXWHOzZb9/BMaMaPXEA6hV2jdVccIFOzPkC3YCfXINpfBVPOOhmw54e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572432; c=relaxed/simple;
	bh=PRroqpoyMJg/+rYrFJe4O8BKnUwWTSzH2NWue6bkJJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNPhyGqSIaXXfWRte739JBYHPo0Rcfstx9q6MhSqfQa0loCLXSDydj8By0z3Jp2aKbKQ2VqfDau91szfS8MtbHujYK+8z99gcLxH6lCKTpcAy6lBf9waBKvfWtc3eqd5iWrcL3EJ6YlaFCGGkHcIG7w99nRAiDaUMXE9EkyLtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4RIc+R2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4RIc+R2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so5221435ad.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572430; x=1784177230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGemzx+pMunN1tP8jAT+YOako4z0+tHzoNO2IOm+UVk=;
        b=n4RIc+R2Jp4fvqXccV0SRDYpftkct4bxvjoLSvrXWnpE5gFZuRdumdh3moejftvrto
         pB2UYCktHz/+oqhfptL3ZtCU0SYDPdkV8PT7Kh5mv8jbBG/2YGXgZo+QVm96xug+/sbR
         cZF6b1ch0aSyMPblNHgZVX+GHbMC8e3jbBlM40qWaUpagKRivqQjRwlw1bI51QujQulc
         1denembbw0phiJHLz2Z4xskUCGtUmoAZ/aO9xdTThoTRspINzpyCqktTBbWIMj5oZV6z
         VXp+g6xiZqWvVBYKYrYOD1Tv3I6rRRNj54ElIEQfIxR1rm/1Ls4K9dEUAUyUgrg11Vcb
         yiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572430; x=1784177230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGemzx+pMunN1tP8jAT+YOako4z0+tHzoNO2IOm+UVk=;
        b=LdhDsZWf40Gzf4iMraqhQut+N6B5YIA4Co6OYJE0jr5rSWk5HPjxT/v5afIrareY0p
         dAAqNo1QydqY7gRd5kuys7dagR9uhr5O4310EB5SM8ZTDWOTv06eqWqChT0sc7JqFiAe
         Tm1p3urTFlEtKKix9dL19kzhpIsI8FprEMlGPKHRudL5VEeZLHyoxG2zhcMXsoFHXLLh
         TKeH3u3fWuCmbnUu062LJqdzDK8oQCW/YrEcRK+Mkrlm0RK5O5tzBcJXliFejov7u6zf
         pIq8oFbGlHc9HHgcdrXVLh4wOO1R8Vsr1NSPkm/w/SUYuTldkqZx0/1pwgehkD62/r5C
         XuvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqK+18qIic0S6JpcuJHkr/TYz5Y9Y/0/YsEtocMSXMRJKLt2qUllxUV7dhD0A1YaVD5apHPJ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFiuTxuMiS8OkT3ChoB96KMPJdGXBJyAerCRvxIZGz7KmTWF7s
	GqAAhF9HrLJfXSMaDzVKRKUrE60nPVo9SXEUNSyM81EZbV0otU1SfGzR
X-Gm-Gg: AfdE7cnvjKOpfcvw0/GIGPg8ocrEq7sptxTj3FoEM55pCDOLjm21NOnS7jBls12IPFY
	A05NI2Cb+bzay9xP4RhkKdNVHCrF12qXVTlOaOeUvbFoDq+8IYoJ9rT8UiRlltxNKrWQPvZ4A+P
	LKDEo3XITvWH+Xwf6a9AvFB2mNulU2Z8fCMkYDmGyb3pJLHBEGmKbH3zUpEL+++x+E6cdqMhaWB
	oJol/9oOuYKOtcdMFQFLJlssIUIwlQ54YkrFaYDwxYWHcdz3gU5tYtLEfTsjsKDpRa2A4h8XwFl
	axz3x2NcCHbKsGWHZSV+ffmrw2sI/P5g7qCFHie/UqkffkKdTi7ofWQ4ebq75rivHsod8rbz2mR
	1qJruyq6qjWR25V3hhK17tUAYN7TQRDyzTl+itGo6vTrS2QT7XW+q8Q6CkklgKWA+UmUrlIUYaP
	4adckh2twRVdVQAxbMtw==
X-Received: by 2002:a17:903:3c67:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccea37d246mr55009625ad.5.1783572429827;
        Wed, 08 Jul 2026 21:47:09 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm38436785ad.12.2026.07.08.21.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:47:09 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: [PATCH net] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Thu,  9 Jul 2026 10:17:04 +0530
Message-ID: <20260709044704.141507-1-vnagare@redhat.com>
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
1. Adding NULL page validation in qede_fill_frag_skb() before dereferencing
2. Checking error state EARLY in qede_tpa_end() before processing fragments
3. Checking error state in qede_tpa_cont() to skip fragment processing

This allows the system to survive memory pressure by dropping packets
instead of crashing.

Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
Cc: stable@vger.kernel.org

Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..95b5cfcc43c2 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -670,13 +670,22 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 							 NUM_RX_BDS_MAX];
 	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
 	struct sk_buff *skb = tpa_info->skb;
+	struct page *page = current_bd->data;
 
 	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
 		goto out;
 
+	/* Avoid NULL pointer dereference when under severe memory pressure */
+	if (unlikely(!page)) {
+		DP_NOTICE(edev,
+			  "Failed to allocate RX buffer for TPA agg %u\n",
+			  tpa_agg_index);
+		goto out;
+	}
+
 	/* Add one frag and update the appropriate fields in the skb */
 	skb_fill_page_desc(skb, tpa_info->frag_id++,
-			   current_bd->data,
+			   page,
 			   current_bd->page_offset + rxq->rx_headroom,
 			   len_on_bd);
 
@@ -684,7 +693,7 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 		/* Incr page ref count to reuse on allocation failure
 		 * so that it doesn't get freed while freeing SKB.
 		 */
-		page_ref_inc(current_bd->data);
+		page_ref_inc(page);
 		goto out;
 	}
 
@@ -959,8 +968,16 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
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
@@ -982,6 +999,10 @@ static int qede_tpa_end(struct qede_dev *edev,
 	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	skb = tpa_info->skb;
 
+	/* Drop the packet if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb))
+		goto err;
+
 	if (tpa_info->buffer.page_offset == PAGE_SIZE)
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
-- 
2.54.0

