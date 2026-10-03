Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12230FC26
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070264; cv=none; b=PM5uy0H5cUZpeSXzjzKe9U0wy8yT9dYG3Oo4BJq47sCJOs4deaD3in4osIbLwL8oI37zBTum0hgNcqcQSjrdIa5RKUwKpAEwC9ujs6yw0yPf+8QDZwUVBNWiMtOOiPBKZ5mhBB8F77Z58h8AIL5qIg6ritumiB6PYm8lp265XXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070264; c=relaxed/simple;
	bh=Xw1FjG3l+X5v/tmL+AFv+0fYunh6K0cphgfqBQpcsDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MW5XZBv3n0j8hsWBKHOBu+sFo0IFFTd2mTWJmoKR/DQmR3Rs65Ey2nhqq2rJQ/JTF6w4kmUtUaQ72DEIs7VF9FDs0z9rQOek58ciyRdL5++elqEcfTXsGf6c3Nn1Fy6ivTLBf/WbRXP72XvPyjXn9kesCeNlw3w+is98BVxklJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=LoIZVhnD; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="LoIZVhnD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xw1FjG3l+X5v/tmL+AFv+0fYunh6K0cphgfqBQpcsDM=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791070259; v=1; x=1791675059;
 b=LoIZVhnDBTzw4tmm2bQcHILWhM8IEt3Rfdn5QuopCAu45qYdG4d6wqIFUA3TKrgwu306aYP2
 QcaWKpKoARndNWIXJ/7H/OsSfVdKZkb788ybIuNrEzscFTGB7QC7E50BI5i8C8VsbKfZfG89DCM
 xLrUn8DMNQhjNuN+hu9/ymMMaVKmFNveKyUU0weYpvDF8ve8ttX5k/rBV+YSBB8Ua+K1Cd69Tmc
 IhN2IrXs8wqWM7axrtc8v6+hKqGNrn+Yl/QL4p5AR1NY/XRypb0o1d1PR5CA4cC+Pjxzv/k2S2R
 awUmW14YG9SHXX2LjGDucgLGRKusGFmZ3OoaWH16K35cg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8392b3fc8d7e1049;
	Sat, 03 Oct 2026 23:30:59 +0000
X-Mizu-Trace-ID: 8392b3fc8d7e1049
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	JB Tsai <jb.tsai@mediatek.com>,
	Eason Lai <eason.lai@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND wireless] wifi: mt76: take rcu_read_lock in the USB/SDIO tx completion path
Date: Sat,  3 Oct 2026 16:30:56 -0700
Message-ID: <20261003233056.94497-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB and SDIO completion path reads a station pointer that RCU
protects, without holding the read lock. Lockdep catches it on the
first association:

  mt76.h:1305 suspicious rcu_dereference_check() usage!
  no locks held by mt76-usb-status/1254.
   mt7925_usb_sdio_tx_complete_skb+0x119/0x130 [mt7925_common]
   mt76_queue_tx_complete+0x27/0x60 [mt76]
   mt76u_status_worker+0xed/0x1e0 [mt76_usb]

  mt7925/mac.c:856 suspicious rcu_dereference_check() usage!
   mt7925_tx_check_aggr.part.0+0xc2/0xe0 [mt7925_common]
   mt7925_usb_sdio_tx_complete_skb+0xa0/0x130 [mt7925_common]

mt7921 does the same, and warns once instead of twice because its
aggregation check reads the default link directly. The DMA path makes
the same reads but completes from softirq, so it stays quiet.

Take the read lock around the lookup and the check.

Tested on 7.2-rc5 with lockdep, fresh module load per arm, 4000
packets each and no change to the link:

                             splats before   after
    MT7925  Netgear A9000          2           0
    MT7921  Alfa                   1           0
    mt7921e same kernel            0           0

Fixes: dc66a129adf1 ("wifi: mt76: add a wrapper for wcid access with validation")
Fixes: c22769de2509 ("wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e69978184f68..ad1352ddf1fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -831,11 +831,14 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+
+	rcu_read_lock();
 	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt76_connac2_tx_check_aggr(sta, txwi);
+	rcu_read_unlock();
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 101f571b027f..45bc79727426 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1687,11 +1687,14 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+
+	rcu_read_lock();
 	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt7925_tx_check_aggr(sta, e->skb, wcid);
+	rcu_read_unlock();
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-- 
2.55.0

