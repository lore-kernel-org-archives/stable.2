Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F054DE713;
	Thu, 17 Sep 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647681; cv=none; b=QYUAuVHHcRyiB7lDq4ukZD4/hc0xM60HogSE+sbin+bBSMRyepuxcCWdaQcM9vGWUTSFSgpVtvIi+aigMzGrX7CXT3D0WBTpDCbpbe1tsjTerHftA6DrKTddTevZOi0WuIaLwBsmGHuXOmraHXp87vcjBvMGQa6wgeD30l9lJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647681; c=relaxed/simple;
	bh=EbcdXFHrGSHSe3avH/oWkWcA7aUvQ9U1pf9dYa9aHFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a71Yu71qCkd8JRaOxHGWJPQsXHc6Ho00RnN6CtaLi4ohfm8MyOQ/UPxNnjTvkdwHt98IgGYMIG0wB3myz9BpAaIMxlwwIOc6exFRAvnO3tXqSfot2cKrEl16Iilc7MhgARAJfCDk7L05McJ5rijA/8C0gd8RbXPaQF/U5LxMfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB34jwq26tq1mSACA--.2616S2;
	Thu, 17 Sep 2026 20:20:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: angelogioacchino.delregno@collabora.com
Cc: kvalo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: Fix skb reference leak on USB/SDIO tx_queue_skb error paths
Date: Thu, 17 Sep 2026 12:20:58 +0000
Message-Id: <20260917122058.2150817-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB34jwq26tq1mSACA--.2616S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1kZFy7XF47uryDZw48Xrb_yoW5Aw1fpF
	WjgrWYkr18Jr4UG3Z7ua1UX3ZIya1rKFyakryfW34rurWrAr15XFWI9a42vrs3trs5C3W2
	qr1ktrsxWrZ2qrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07bnXd8UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgNA2qrrRmKFwABso

The mt76 queue ops take ownership of the skb handed to tx_queue_skb():
the DMA implementation releases it through ieee80211_tx_status_ext() on
every error path, but mt76u_tx_queue_skb() and mt76s_tx_queue_skb() just
return the error, so the reference is neither queued nor freed.

mt76_testmode_tx_pending() relies on that ownership transfer, so it leaks
the extra skb reference taken with skb_get() whenever the queue is full or
tx_prepare_skb()/mt76u_tx_setup_buffers() fails.

Release the skb on the error paths as well.

Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Fixes: d39b52e31aa6 ("mt76: introduce mt76_sdio module")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/usb.c  | 15 +++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 8bae77c761be..ef82af1f905c 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -526,13 +526,15 @@ mt76s_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	int err, len = skb->len;
 	u16 idx = q->head;
 
-	if (q->queued == q->ndesc)
-		return -ENOSPC;
+	if (q->queued == q->ndesc) {
+		err = -ENOSPC;
+		goto free_skb;
+	}
 
 	skb->prev = skb->next = NULL;
 	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
-		return err;
+		goto free_skb;
 
 	q->entry[q->head].skb = tx_info.skb;
 	q->entry[q->head].buf_sz = len;
@@ -544,6 +546,11 @@ mt76s_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	q->queued++;
 
 	return idx;
+
+free_skb:
+	dev_kfree_skb(tx_info.skb);
+
+	return err;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 632ae755c7a6..837b0b251b05 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -861,17 +861,19 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	u16 idx = q->head;
 	int err;
 
-	if (q->queued == q->ndesc)
-		return -ENOSPC;
+	if (q->queued == q->ndesc) {
+		err = -ENOSPC;
+		goto free_skb;
+	}
 
 	skb->prev = skb->next = NULL;
 	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
-		return err;
+		goto free_skb;
 
 	err = mt76u_tx_setup_buffers(dev, tx_info.skb, q->entry[idx].urb);
 	if (err < 0)
-		return err;
+		goto free_skb;
 
 	mt76u_fill_bulk_urb(dev, USB_DIR_OUT, q->ep, q->entry[idx].urb,
 			    mt76u_complete_tx, &q->entry[idx]);
@@ -882,6 +884,11 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	q->queued++;
 
 	return idx;
+
+free_skb:
+	dev_kfree_skb(tx_info.skb);
+
+	return err;
 }
 
 static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
-- 
2.34.1

