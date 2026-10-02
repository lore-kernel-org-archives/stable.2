Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419433B5837
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973952; cv=none; b=Gbux1/5G+1SV+pAVxbyHpVynXhGcbAZ9/WzfHzY2jpAoSHg4H2/4/JxBUNWWJARpkXjqbIV2kGKw0yCUPZxYIRNH6oHK3kCtENG3PuihnZvX7FQSyjiWWymjKDwcl+DnfkpltrkAUuYYQZ4DqAIsUEaZGDjvLnvh13QOmaTEo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973952; c=relaxed/simple;
	bh=hrKzZ43cJvocqLxV9DmG9Sqd8Bel7/0VvNw3HPWvWl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6ZhYM2uirzFnTfYNyCH+l4D5bnER0VGCvFrM0+TsQsSUjDmmCHc38zu6fzp2y+74OxPiKQmcZfenRGocuKWXsGajs6Wjb3ifqzOmf+SxJsNLUUXo9GbQCN4ssF4+UlDYkdV4/G+k11SbaikAegCz7Y82w/b+bqF9tuACozhL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AjydZFSi; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AjydZFSi"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso5653eec.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790973946; x=1791578746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sgvZhgmjrftKT8E5vS9CrFzO9ANsKTScS9cgLRZmapE=;
        b=AjydZFSi6+qOl+SbIh2WgsTnZLal6hyXI+qguksU8u77CeKc7zRKpt/qOS0LZXyEf1
         zsisyp4mWxI0DCWa1yZtLAXnOSQn5msquk8VH/C+o1STLI2hS9fKuV5fSl3v5wXp2Pi9
         vs7foWQY32QZwedmGBoq/CLBdgq8NFOjsFpzVhJDDi2itLjheu6qZ/L8CR44cS8mYu95
         UcE51rYnFheCPoWFgrFwyz6zFDaelv0MqiZqnWULcj9RnzXka1VXPIIjEnFekeMYnUAx
         qYGvaFW0k+zxxUaWls3POQ71VaTF8dFWC32L0IxAFiIhlalZP6XDPoRVwpb0WrVyHHZm
         V7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973946; x=1791578746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgvZhgmjrftKT8E5vS9CrFzO9ANsKTScS9cgLRZmapE=;
        b=an9ipWHlija5USoTCDQdsxsQc++bJg2wA3ru/HgpIXXaHZWfYn9ex4V6+r16jT6tJB
         ggOzXvRYH60eWeiat+SPBq8yp8YZDccvOVMBJmKEH1DenrofcqdyE1rmc4NSORdjFpwW
         aPPi4i31T57CjeTvxCFv7IHmxmQ7Kc0lAP3JdSluHr1VxYAG6fBZCaod+UQ1Gfmrva90
         juUpiFVfupd322m9SQF7ZviAi/++SQKvB1/iNJ3UEL0DYeriIt4zxtSgEYcWa0nXl6uu
         5zYQCjQl/BZ4YAKrT+OGo0o2FhEE7/XurvAY4qde9pT0WvBHb+tQc6qhNHIws2iYxr9Z
         cTyQ==
X-Gm-Message-State: AFq9FYLAooQeo3L8IQHxkpbnQK5kYsGOZqaQbP/d3i9yGxTwRU0RpFzp
	mnO1n/K46bdAtwsqLP1q9vIpd8eJqE5xWnwfNwBWaolsHPv1GMeD1RMPMzJF8EC6hp5JRKDdnGN
	0vaB1WzUecA==
X-Gm-Gg: AYBFou0cuxrjwBiUkM37BeOq5Lc9dqHIg9aSwvZTl7rmKSZIcmmn7BY5X2yZGep86pT
	htubOBk6DkT7L8OmdeULMjW6xVWjjGIlBXsyaYuRhibprWHvvnZnYqn1dB2UZKDSCbi9tSfvS1C
	A7Ons5iPfoOBfnOtGGxBrjQs+1chlWJyCnc98IDCiHXA9qwuBlE2LIZD+30s1/rV55W6I0jtlMU
	33Sy0/iwaqBhLKGWcUvikUAihbEmLhITuyvGYEiQGir6HpGomR9aDi9UnIX8tidARKfFJ37GBsX
	L2ly6DTJE+fCj/sVmfVx//+WlxcAOrlPB60BABEOoGf0gH48XIxCi4QB5uC9l8d+LAb7qArFWbe
	W7IzVu0K/asGNO92yzzMnF203XnQrNMJqDnWIsoZrqu6YsrrL+zqpkVMYSKmY+o47A96ljIn74T
	3Ob6RvMMX8ukH/duSFtXsXWTAUyDYdFvy14H5fRYLWP8+riN8qzp/R6KTFXye+pTBqI1s7wJNkk
	wGuVv72pc+guM3cE/IGDzrB/xkN+jDxGhPvxKBir65fKEOlDTDZ9eAPqjn3GsOObXTjC81m
X-Received: by 2002:a05:7301:1709:b0:34d:f38d:4302 with SMTP id 5a478bee46e88-34f150d1b0bmr4216038eec.17.1790973939173;
        Fri, 02 Oct 2026 13:45:39 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a1e3:ffe2:b35a:69a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351143b577bsm62111eec.15.2026.10.02.13.45.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:45:38 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH 6.1.y] net: ena: Add validation for completion descriptors consistency
Date: Fri,  2 Oct 2026 16:45:33 -0400
Message-ID: <20261002204534.26297-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7 ]

Validate that `first` flag is set only for the first
descriptor in multi-buffer packets.
In case of an invalid descriptor, a reset will occur.
A new reset reason for RX data corruption has been added.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240512134637.25299-4-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and net maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-40999. It detects inconsistent ENA completion
descriptors and resets instead of consuming them.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The code change is identical to upstream.

Could you please queue it for 6.1.y?

CVE: CVE-2024-40999
Upstream: b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 933e619b3a3134..4c6e07aa4bbb55 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -229,30 +229,43 @@ static struct ena_eth_io_rx_cdesc_base *
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
 
-static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
-					   u16 *first_cdesc_idx)
+static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
+				    u16 *first_cdesc_idx,
+				    u16 *num_descs)
 {
+	u16 count = io_cq->cur_rx_pkt_cdesc_count, head_masked;
 	struct ena_eth_io_rx_cdesc_base *cdesc;
-	u16 count = 0, head_masked;
 	u32 last = 0;
 
 	do {
+		u32 status;
+
 		cdesc = ena_com_get_next_rx_cdesc(io_cq);
 		if (!cdesc)
 			break;
+		status = READ_ONCE(cdesc->status);
 
 		ena_com_cq_inc_head(io_cq);
+		if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK) >>
+		    ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count != 0)) {
+			struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
+
+			netdev_err(dev->net_device,
+				   "First bit is on in descriptor #%d on q_id: %d, req_id: %u\n",
+				   count, io_cq->qid, cdesc->req_id);
+			return -EFAULT;
+		}
 		count++;
-		last = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
-		       ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
+		last = (status & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
+			ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
 	} while (!last);
 
 	if (last) {
 		*first_cdesc_idx = io_cq->cur_rx_pkt_cdesc_start_idx;
-		count += io_cq->cur_rx_pkt_cdesc_count;
 
 		head_masked = io_cq->head & (io_cq->q_depth - 1);
 
+		*num_descs = count;
 		io_cq->cur_rx_pkt_cdesc_count = 0;
 		io_cq->cur_rx_pkt_cdesc_start_idx = head_masked;
 
@@ -260,11 +273,11 @@ static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			   "ENA q_id: %d packets were completed. first desc idx %u descs# %d\n",
 			   io_cq->qid, *first_cdesc_idx, count);
 	} else {
-		io_cq->cur_rx_pkt_cdesc_count += count;
-		count = 0;
+		io_cq->cur_rx_pkt_cdesc_count = count;
+		*num_descs = 0;
 	}
 
-	return count;
+	return 0;
 }
 
 static int ena_com_create_meta(struct ena_com_io_sq *io_sq,
@@ -539,10 +552,14 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
 	u16 i = 0;
+	int rc;
 
 	WARN(io_cq->direction != ENA_COM_IO_QUEUE_DIRECTION_RX, "wrong Q type");
 
-	nb_hw_desc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx);
+	rc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx, &nb_hw_desc);
+	if (unlikely(rc != 0))
+		return -EFAULT;
+
 	if (nb_hw_desc == 0) {
 		ena_rx_ctx->descs = nb_hw_desc;
 		return 0;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5159fb9fbe66fd..11f47f24917eb3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1853,6 +1853,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	if (rc == -ENOSPC) {
 		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
 		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
+	} else if (rc == -EFAULT) {
+		ena_reset_device(adapter, ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index 1e007a41a52564..23466d62fbc5c5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -21,6 +21,7 @@ enum ena_regs_reset_reason_types {
 	ENA_REGS_RESET_USER_TRIGGER                 = 12,
 	ENA_REGS_RESET_GENERIC                      = 13,
 	ENA_REGS_RESET_MISS_INTERRUPT               = 14,
+	ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED	    = 16,
 };
 
 /* ena_registers offsets */
-- 
2.39.5

