Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD235DA42
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781991484; cv=none; b=MOe2GbskVcgl2lOBbUMZq2D5iw0a+21CX5+XJiI1qARkhwR4EXRXmHOIJeTiZY1u54UlfhvP4efy4tKcyt2bZJxXAnVL585g5VMzrEPpo25rc4VjsjKz4uzV+wKO5cD3ScTurtDfvSZcZGzeLXseTnAbUwCZHZLgsvFvX2hCCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781991484; c=relaxed/simple;
	bh=ZEJ92BXzs7uxFvZ8o+bk+yvRtMFQ80qmq1Smsi3caog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOOIZRiUGrlUDmE0g5JWlGMA8SQY/t7yB+19jiGy6DG1ZbdErUkC2eHaTZbQFkAslJmhU9WOlIswLs7zhbUm/SeUam7IC2kmslPmewgfiXKb8kttVpFIG0hWByuN4Ygmn4P0SYOgBqL09/DwwAXi60JmN1UA1fzhJzbw18tdX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGTB73hC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGTB73hC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1459570f8f.2
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781991482; x=1782596282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyy19G3UAGpqNpZJRFtz4WPWcaaqaP4tOOJJnrBVNEo=;
        b=oGTB73hCBI+aKbmNhcNbDN1rb//FBS5ylOmcoCekAH4r7Y7tCe1MDtDGwCSkOviot2
         ZGPB7KVzU3avkexN+WsVTNAxrle9TSRc+jeBraiSgJcw5ViwObsxrgGyQpWEm9sYTEiI
         rOhdnKTwV4GJWFR3ToAUpg+vwg40SNDF26cE7/oXlQreosRMeWiubQ1qSP3SDMvg2kFJ
         UP7piEUg7cPmhEG8ZFLD/oI91soqxjwRXRBcHC9or4dDTUYHoW50+m2Ue7vEDR1K1jjx
         +dcM0PwSh7P9/kjQFCc1y8bRFXlrGL19Q2G6biHG8c8caKtiY14UhUhpDQqNsbMkBPLn
         k+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781991482; x=1782596282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyy19G3UAGpqNpZJRFtz4WPWcaaqaP4tOOJJnrBVNEo=;
        b=YQfRzV8135J6DiazXffYE1N35nCkQU+AiiiglAacPRPLRQyVBtEZDvYOUDt6Iv5E3K
         rH9VHztQBtgNX7vC4hA/+jVz30oWjvf/G3f3gwCMBjx+CNke1vujhtisjfeD6jQuh50E
         qStgaG9iCKHPmO7FyFvvcY1aPsfYwSgXVi4VgJdCLo8/rxikBhv4RG1s9KVP3hmOZyBv
         8W6enykF40SUrNmofp6Be0YGJjBSP2iemTvsLHtZ/ZpOChc0084xd50vZH/t+GgZqc9F
         pdNddYgOAf4//i+KajBrjoV07M7U1wxPOO3nncF8dIKAf34BlpaM+MbkvMI//PPykU/J
         zL/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQV+Du+zPcn8jev9GXUJlWzcMI+jcFW8zQJh5M6I/qggExsxKOq44YVsTg/UqVa72lujsz6qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5pb/pwhCyiZe2+FcPFd3d76iCM+cXsKs8P4n2y15rKzF4LBn
	MahtDOUtZPqgUcxu7ZQ1HF0YhuzdH2YtB9sIKrTP+ow82rJPsCTPR0++
X-Gm-Gg: AfdE7cmo32Gn+XEC6c/b6lALE6Xn87IfxGXf3ZxXygLTWO5KwUZXr0cTblB1ssAe+SP
	q06wGmKUGAbcbif0b62ffHvYZUEmdaVEi5MeslNWVDRvTf2nZAwpR0zi3iFj9nkjq4klxDK6RvL
	Kt+42HmeNpAwFh1Jh5nUNxTVhSPYyHFrF+KdJctsKGfjUBs3hlG6zJN2GsmKo/jiVr8+y4NDYar
	iUTg7fJ6w7XwJ9JIEdLJT8xKMn+p6DOJRYx0xld0yuc1kLa+JF5zivtycYwVYGBusfbKv808GuW
	vAsdtMMTucJsq9OPCM3+PxWEY8/9ozaY9wP6gDX++RPX08PR6Is9x678/OHjIMH9AR0vyXM/8WL
	9+pcuguQFD5VrrgpQzD3t3xPqx3+REY91stumpCs3UM0LK0BBykIfw0jQD5eM+FRGOQGoKwabwS
	Fxoy6dPW010uh2F6s2eEFuDCHhBzjVgwKFrxjaJV5tq9dLfWAN8di36abi+nL2R9WNYMhuF7ZT
X-Received: by 2002:a05:6000:2b01:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4650043b85amr9392338f8f.15.1781991481496;
        Sat, 20 Jun 2026 14:38:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm12128189f8f.16.2026.06.20.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 14:38:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m-malladi@ti.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path
Date: Sat, 20 Jun 2026 22:37:56 +0100
Message-ID: <20260620213756.87499-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).

Pick the TX buffer type from the frame's memory type: keep
PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame. The
completion path already unmaps PRUETH_SWDATA_XDPF buffers.

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..302e700ea17d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -804,6 +804,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
  */
 static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
 {
+	enum prueth_tx_buff_type tx_buff_type;
 	struct net_device *ndev = emac->ndev;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
@@ -826,11 +827,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
 			goto drop;
 		}
 
+		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
+		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
+		 * page that is not DMA mapped. Such a frame must be mapped
+		 * via the NDO path; only a page pool-backed frame already
+		 * carries a usable page_pool DMA address.
+		 */
+		tx_buff_type = xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
+				PRUETH_TX_BUFF_TYPE_XDP_TX :
+				PRUETH_TX_BUFF_TYPE_XDP_NDO;
+
 		q_idx = cpu % emac->tx_ch_num;
 		netif_txq = netdev_get_tx_queue(ndev, q_idx);
 		__netif_tx_lock(netif_txq, cpu);
 		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
-					     PRUETH_TX_BUFF_TYPE_XDP_TX);
+					     tx_buff_type);
 		__netif_tx_unlock(netif_txq);
 		if (result == ICSSG_XDP_CONSUMED) {
 			ndev->stats.tx_dropped++;
-- 
2.53.0

