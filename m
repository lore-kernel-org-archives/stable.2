Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE13CB8E9
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126805; cv=none; b=HDWpmSKiaYXLIbChKlRlX9k0UDfr/Y0NCZ7nqQz9/GCC93a2mxyeUeVbF6EtnDKVS5a+9uHKJzg7kPlCv0GsIZ0RbVK4DTwsjqU45hinNTy9THynlYlLwHKQtL8rp36dTEvEiMMNc/P0Qk9FvLzpLqatOQ7fBKtsbvnmkju90zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126805; c=relaxed/simple;
	bh=eoXaDRe6mDv/U6CI2Py2v0epG/drLl03/Ipm0jnRZk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn+svqknp9FqxwdqEsK1MqBp3BgebI9WM0jt7Rz63+hLPpSudXauvgGbpwgjzLXS91VUsuL+04iDE0GN+8T9PqovukJjjX+Fa5m8Tn3pEtm1bU07gqYxtOmJs76AGlvwMGyUzu6dXmE33yoqzsCCxFQqDRrWb9ZAhnRX1sKduqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m48oqPCz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m48oqPCz"
X-UUID: e36ea69c9ba411f1b1788b6acf885367-20260819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XX78+L5F/1RXl2iNxigSzWE8NOyLgddkL6ovb0LMu8s=;
	b=m48oqPCzAdb3nTsT0nQtm2Vi5JlJN8rACDpaIVHhppWbnsmqCePD8ml/QLNQYxQiG7k1EAIjDvsItY+k8wKP5MQWDeRikUMUH+yDeLNpU7LAsnGLXwXykfzjPGox1QceLHN2zb9K84pBU1n3Een5DK/Aw+S23UgV2p4k8sMCfU0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8c24fa35-bf89-4ce2-aec9-21b4fb60f00c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b5282ffe-f4cb-4ad2-b022-e3ac6648bf25,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e36ea69c9ba411f1b1788b6acf885367-20260819
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 885025233; Wed, 19 Aug 2026 16:06:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 19 Aug 2026 16:06:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 19 Aug 2026 16:06:30 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: Eason Lai <eason.lai@mediatek.com>
CC: <stable@vger.kernel.org>, Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH v3 2/2] wifi: mt76: fix memory leak in USB TX path
Date: Wed, 19 Aug 2026 16:06:28 +0800
Message-ID: <20260819080628.1056925-3-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260819080628.1056925-1-eason.lai@mediatek.com>
References: <20260819080628.1056925-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When errors occur in mt76u_tx_queue_skb(), the skb is not properly
freed, leading to memory leaks. This happens when:
- The queue is full
- tx_prepare_skb() drops zero-length frames (such as WMM NULL frames)
  to prevent hardware TX hangs
- Buffer setup fails

Fix by properly releasing the skb with ieee80211_tx_status_ext() when
the queue is full or tx_prepare_skb() fails, and using
mt76_tx_complete_skb() when mt76u_tx_setup_buffers() fails (since
tx_prepare_skb() has already succeeded and may have allocated resources
that need cleanup)

Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")

Cc: stable@vger.kernel.org
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Eason Lai <eason.lai@mediatek.com>
---
v2:
  - add error handling for queue full and tx_prepare_skb()
  - correct error handling for mt76u_tx_setup_buffers()
v3: add Tested-by: Devin Wittmayer and cc stable
---
 drivers/net/wireless/mediatek/mt76/usb.c | 31 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a9af3aa6b80a..dfc12f6944a7 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -893,6 +893,9 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		   enum mt76_txq_id qid, struct sk_buff *skb,
 		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+	};
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -900,17 +903,27 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	u16 idx = q->head;
 	int err;
 
-	if (q->queued == q->ndesc)
-		return -ENOSPC;
+	if (q->queued == q->ndesc) {
+		err = -ENOSPC;
+		goto err_free_skb;
+	}
 
 	skb->prev = skb->next = NULL;
 	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
-		return err;
+		goto err_free_skb;
 
 	err = mt76u_tx_setup_buffers(dev, tx_info.skb, q->entry[idx].urb);
-	if (err < 0)
-		return err;
+	if (err < 0) {
+		/*
+		 * mt76_tx_status_skb_get() walks the idr and dereferences
+		 * a freed skb. This SKB is not counted in non-AQL counter
+		 * due to error return, so using 0xffff as wcid to keep
+		 * balanced.
+		 */
+		mt76_tx_complete_skb(dev, 0xffff, tx_info.skb);
+		goto err_ret;
+	}
 
 	mt76u_fill_bulk_urb(dev, USB_DIR_OUT, q->ep, q->entry[idx].urb,
 			    mt76u_complete_tx, &q->entry[idx]);
@@ -921,6 +934,14 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	q->queued++;
 
 	return idx;
+
+err_free_skb:
+	status.skb = tx_info.skb;
+	spin_lock_bh(&dev->rx_lock);
+	ieee80211_tx_status_ext(dev->hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
+err_ret:
+	return err;
 }
 
 static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
-- 
2.45.2

