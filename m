Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050370;
	b=v+FxuyVWDFpmshjYwedmGBk/twqoBI2EdosowehP1rhwOYy0gbLLRmzT7uOE4SgtFAfW
	 nndxjrcC6AoZISaOLRoRDTpRA9CV7fHW4EK7KZ7mjnRq10lwvcgt8OemMH6PF8H+dMTB+
	 Xn1H6GhIGcp3ohxYarseSFp3JHQD//er3ilyJgXrLb7P1SndB/tNwiZZmxFBCEhhmdEJ+
	 vZn0wsC1eYKIQyNp0cDLm2gdUBwPsiLVAPj4HGMo767nNl+4aKm6VQKmIZh5xgWj++6Vg
	 u/V4A6tVuAu9HPDHbex2ofcNEJy8Csy0aW2ibIcQumxND1dsnMpoOMaq5uiU/0SzFcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UwqewlgcIpfoFR7mq/HUHUiq0o2Hmqb+w6NurBkCnW4=;
	b=Dj2bz+v4/zmVGd8BT17u0lQF59HkihXG+5YjVJBKgQ1sZ4SfT/okNWNzoPJZ+hxdxnk7
	 D+nAHB8Z9Njv5Wpsk/mzoiTCw4zxnnjthk+/EiEM24nh7//r2M2uYM2aU6Vw2QjoeTDO9
	 k1A642QvrO6p0N9Vm8N1Jlj0wq74+2EMh+HxaXKGSkEvwZ+A5ejNkxbBQ1ORrYgUMEsyw
	 ZB1LZpcFRbzEZlfwqglQyeny7xy2pRgqdQ1BIwiZUEIo9XDGOD52ZHDxMXRg7dY/GDMYL
	 541arFyBG5WUPrCGHxipq3wZxh7DVjyB6j6hjHx4dz41lXMGuOqdgfbHfBCWgbFFZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDCjCSIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C702606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDCjCSIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E461F0089F;
	Sat,  7 Nov 2026 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050369;
	bh=UwqewlgcIpfoFR7mq/HUHUiq0o2Hmqb+w6NurBkCnW4=;
	h=From:To:Cc:Subject:Date;
	b=CDCjCSIwukGECHKBBD0y+LeKrbvy69HtBxazJwxvKYetdwBXQZHQGVnj3Jg5MSqq/
	 A4V3dAeSQP37XBqxnCDDWhCnzEmlXmzWQQKAbZx8PgfX3SAlN7+WHVhz1YgEp1cNoy
	 EuDtGoxvq0fJg4MsFdhHH4CD5ZyfMCiRL1gHGtK3X1wdICRcEjOax0ebppjrJr+R1t
	 H8XY347Gd+w0uR+zPUJfuvMO4jPCLJTnWS5vKfeaT1DhXbdbfdcuWroogZLDR4k7/U
	 9mq6cfBCjQz4K+6X9PRLKTM/HzNS/qV4y0w1g6VSf/ljItS0vboiZMplGwNd7XuZU6
	 ahVYgSwqOEG0w==
From: Sasha Levin <sashal@kernel.org>
To: eason.lai@mediatek.com,
	lucid_duck@justthetip.ca,
	hbuchheim@gmail.com,
	sergei.melnichenko@gmail.com,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: fix memory leak in USB TX path" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:27 -0500
Message-ID: <20261107061927-failed-5.10-82856da2d3b6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 82856da2d3b6a30011f4db6ea5f34c13484e0ef8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061927-failed-5.10-82856da2d3b6@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 82856da2d3b6a30011f4db6ea5f34c13484e0ef8 Mon Sep 17 00:00:00 2001
From: Eason Lai <eason.lai@mediatek.com>
Date: Mon, 14 Sep 2026 10:19:20 +0800
Subject: [PATCH] wifi: mt76: fix memory leak in USB TX path

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
Closes: https://github.com/morrownr/mt76/issues/83
Signed-off-by: Eason Lai <eason.lai@mediatek.com>
Tested-by: Hans Buchheim <hbuchheim@gmail.com>
Reported-by: Sergei Melnichenko <sergei.melnichenko@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260914021920.32246-3-eason.lai@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 31 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a9af3aa6b80a9..dfc12f6944a74 100644
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
2.53.0




