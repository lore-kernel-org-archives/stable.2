Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1A2D238F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601796; cv=none; b=mLDCX1nLMjtOWjd2asujJ9PcLz1H+bB5jMC9T9FqIMdaVvcWNouF+8muUYwdfSdWGw3k7ULiXLJsdT8GVWIa0UEdrbW+rNZp0jpHT8H5sS39nxTq+9j0bniDyK9PYmuT8gjecoKwhIQDN8g0rjSk+YKbMwhgbpM5n2BoUZbdavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601796; c=relaxed/simple;
	bh=Ghd0wm04oM39lziSj4fh+/vpJn4GVJA16s7+0SDrdCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sa/MdlpkN8EL0Hw7a3F0X4DS2gfHcF2I2rNDt67F2uyjVZHeUaFEs7pZbRPVVsl2tfaIwEsjsflgf/Saa0CCG33Z7XBdK4WxtM8uZ5ntPPM408Y50Y50qfqr3Uh6QV44058o/OM+rTRTXk5g4KNC07q2eUeyVItzi9BItrTx4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=J4QC11GH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="J4QC11GH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398a5aad413so120904a91.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791601791; x=1792206591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O9ffS901nFKZuAxdPugpS24TqdbsPBH7oWbzs6G6Zpg=;
        b=J4QC11GHpci4C+cvxxOI/mHRxTchp2jv8kBs5rdKzhVXsBRVeRA2epgzhlg8KRfib6
         6EOHc234Vj0oZzW9YTUbBBJeZ62cV626vBntzKj4L3t7MJLehHTkImuxYIOJfZ72TwD/
         WIrY/jUhX9anR0PEoKF1cyK4hzShMm7H6leckJszyVs1Q5b2TnpolyID682zreDbUC6J
         93BrR66hKyf0AVLsphJFYEYDdsYTkrLzVXPAl1fGfxEE0DnxxFHMWZdEv6Grl5fMhnJv
         37eIBqmxSxdC25LszdTncb1OEb22JHjhqLFLH2ZSixIjKU2eLaYV7ZlpczR+M9ertmI8
         lXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791601791; x=1792206591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9ffS901nFKZuAxdPugpS24TqdbsPBH7oWbzs6G6Zpg=;
        b=RrlU4CFfdZQA/hSbwrvYPaGMicKv8XagjnXgjvHisBHAojILKZxzw971nwa7wudgLl
         cLMo6x3khIW72MLdqX6k1YE0aiUPd57PArwJ3aFO/ybELnqWF41/ZaFR9QAbnSBZdCpA
         bmKZnKxDDdWWqE+6ap51IvGYIoDKqow+vSG0MDm/Eaxg7D1m4wq8vRNSvbf4ZiidBZ0T
         hzKDvbv+GPFHEL/jgDqwvIMcek3098Bsw6+/8yQQbCHuVHwy1eVi/ay+2SM5v67g/SiK
         ZrqP3gsqZEvVNArpnouVCt1r44whTuH6nI+rJqO4umt3n8EFXq2fwwls1CHM8OZPWcO8
         K+dw==
X-Forwarded-Encrypted: i=1; AKwUvBzi7oa0P9i2mR48voT90FSqAE0LSIST68yf/b6Toks2lYPRuBOqRAxMW12WAMYRDZw0Mq3u7Jc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK/kzU3OrlhpcNmjDxi8Yt7m8gc+fWvIrzV4IcnK04AxULM/je
	+av8MeCGwcQsQbFl4Gy4QW3DOFhLLDys2vB993FDHA+tyxIUeYe9vAMVX6RGuSEEi+M=
X-Gm-Gg: AYBFou1DFN8hGgoiUgKwi2AWqNwFTIN6C7dTMI5YZREOeDvti3Kjwk3LEEv/MU0aXdr
	7MdxZzK+sU6yWXtBZaFPdRjO5okIfLb67h1/jgaUVO5Gp9EgWpXNfvuwgcwZlc3aEjrAcWk/vm5
	ERjQODEcoY7V1tN2Cp27TyKUAPIpMdHjQCB7aPTqEfdTDI3I74D24+WQ/idgcSAHLibpoYEI+C6
	Ltb8TzZFF9ZE/g881g3YkCk9/dwJaGiBw9FpkFKv/qji3VpNHDaFPPQae8CREK6o+Jn+D9hVoZA
	A4qlCm0Y4iVqiwjVaQEkEgfJSREEeQHz0NvABfQaaqZZoIs1E61GSiUZKRZ88cU7rR4P9gGF1GG
	Dn082ngQyx4i62DesrSl660UllqXDbNA+ul+olK4GXc/srgjO6rcdihgUfP4wOFb0ssBI2D1clc
	hRC/FLhzhvP5G1pttUMqQl+hFCt/bcbFlOFMCUnjtqdijjrLBMPcqVzjd/JLXwNWZmDhsD3HS53
	DBD0SkffeCTtObcisKUPFKtXRBJQvpH
X-Received: by 2002:a17:90b:52:b0:3a8:c0cd:57df with SMTP id 98e67ed59e1d1-3ab3a747d07mr3439160a91.11.1791601791427;
        Fri, 09 Oct 2026 20:09:51 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c95f:28ac:324a:cdc3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da05caaesm1840096a12.32.2026.10.09.20.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:09:51 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Fan Gong <gongfan1@huawei.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Sat, 10 Oct 2026 12:09:01 +0900
Message-ID: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hinic3_rx_poll() takes the packet length from the Rx completion
descriptor and turns it into a fragment count:

      pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
      sge_num = pkt_len >> rxq->buf_len_shift ...

RQ_CQE_SGE_LEN_MASK is a 16-bit field, so pkt_len is up to 65535 and
sge_num up to 32 with the default 2048-byte buffers.  packaging_skb()
then calls skb_add_rx_frag() sge_num times without checking the count
against MAX_SKB_FRAGS, so a device reporting a length above
MAX_SKB_FRAGS * buf_len writes fragment descriptors past the end of the
skb's shared info array.

Driving the receive path with an out-of-range length reports under
KASAN:

      BUG: KASAN: slab-out-of-bounds in hinic3_fetch_rx_buffer [hinic3]
      Write of size 8 ...
      The buggy address belongs to the object ...
       which belongs to the cache skbuff_small_head of size 704

The length is chosen by the device and an skb cannot hold more than
MAX_SKB_FRAGS fragments, so drop a frame that needs more instead of
overrunning the array.  The buffers it claimed are already posted on the
ring, so return them to the page pool and advance the consumer index
over them to keep it in step with the device.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 42 +++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab59013797..974dab51fa425 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -275,6 +275,34 @@ static u32 hinic3_get_sge_num(struct hinic3_rxq *rxq, u32 pkt_len)
 	return sge_num;
 }
 
+/* The device reported a frame that needs more fragments than an skb can
+ * carry.  Give the buffers it claimed back to the pool and advance the ring
+ * over them, so the consumer index stays in step with the device.
+ */
+static void hinic3_discard_rx_pkt(struct hinic3_rxq *rxq, u32 sge_num)
+{
+	u32 sw_ci = rxq->cons_idx & rxq->q_mask;
+	u32 i;
+
+	for (i = 0; i < sge_num; i++) {
+		struct hinic3_rx_info *rx_info = &rxq->rx_info[sw_ci];
+
+		if (rx_info->page) {
+			page_pool_put_full_page(rxq->page_pool, rx_info->page,
+						false);
+			rx_info->page = NULL;
+		}
+		sw_ci = (sw_ci + 1) & rxq->q_mask;
+	}
+
+	rxq->cons_idx += sge_num;
+	rxq->delta += sge_num;
+
+	u64_stats_update_begin(&rxq->rxq_stats.syncp);
+	rxq->rxq_stats.dropped++;
+	u64_stats_update_end(&rxq->rxq_stats.syncp);
+}
+
 static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,
 					      u32 pkt_len)
 {
@@ -553,7 +581,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
-	u32 sw_ci, status, pkt_len, vlan_len;
+	u32 sw_ci, status, pkt_len, vlan_len, sge_num;
 	struct hinic3_rq_cqe *rx_cqe;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
@@ -571,13 +599,21 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 
 		vlan_len = le32_to_cpu(rx_cqe->vlan_len);
 		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
-		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
+
+		/* The length is chosen by the device and an skb can only hold
+		 * MAX_SKB_FRAGS fragments, so a longer frame has to be dropped
+		 * rather than overrun the fragment array.
+		 */
+		sge_num = hinic3_get_sge_num(rxq, pkt_len);
+		if (unlikely(sge_num > MAX_SKB_FRAGS))
+			hinic3_discard_rx_pkt(rxq, sge_num);
+		else if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
 			break;
 
 		nr_pkts++;
 		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
 		if (num_lro)
-			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
+			num_wqe += sge_num;
 
 		rx_cqe->status = 0;
 
-- 
2.43.0

