Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196246;
	b=AaNaGzGtbpe5brJNMDUEd07+SgVll2gJ5EIzJkkfzCwoIMk/+TufEXaWzrg5SFEazDX+
	 y3G3SWiMANnz5zQD7KX2EpV6sWMoXgXd0R5p8J9LKondujESDELxUaoHAGhVb6itQlcpp
	 zGqilrokuLuX0Bsm8Y0lw9oDjP/blHT9esdNbsSQD3deCTvLCW+7ph9AIjlVp+NhFDW4V
	 j/eQzmEFdEbxseAkb6CCrPFOa59c92g7wVTLj1dTtjCjSRZ2Sn56q36g77+anDDe/Bbn3
	 lnriKcMhhfl0RADKXaUwFrgMH6USMp1Oz3I/ouKfxAVxzCv8cGdOdG//Bmc56BQyBOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2pQ/nw5caVi4RbK1CcsBfPp7aScPNttl9DankhCdcO4=;
	b=rzXamSmD6zCt4PySrVDrxchpzWPGS4V+L4XNbHjMZX01iOXb9uIynPtyvm0JoF/yh94K
	 odCXtYy4F4VS03/js7POYpMen/19aFRz9b1wJVB4uZj/w9S+Ihm2wAnyw+IANllO6hvXK
	 V9zP4zwYIwhmzu74t9OvFQbEkuw844GB0ArDfX6G/lfZhah2uWIedNOBK1j93jncCMpcQ
	 mAIIeZpwsb+UctNv88t1fuMNjxJhZiXbnCCKOlyMOPOHddy9euLZueJsYvyXAuzlXP7NY
	 NgU2XraRYt4YnlnPmslwWXQOt2VzfVyZxnoDcrW6NjVEkic9jsSdvx0zB4NgmvSSj8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBs2GTH4;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDA606A332
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CCDA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBs2GTH4
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so570313a12.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196245; x=1795801045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pQ/nw5caVi4RbK1CcsBfPp7aScPNttl9DankhCdcO4=;
        b=SBs2GTH4L8M6Rb3Jxgh9y0QVbTov6iGvVd3DR49NC6s9S08jVl74nb1GLcO6K0JVJU
         sTM0P0mcCw+V0jB0osrRwu6gKBN0NzZPLk4s0iltsU4bG897u6qvjehhROtlzjAwGjqF
         A0SUUdE3OYJSXQnXeKotKuZjWZx5joSo9uFFE0YfG2BLwFL4GnRm0bcYYuWERvOZfz6L
         AI2AK9jkAlzdBZWqseJTZztDIMfxSXtzOeB0/F4FhkJD2J/OQOx5B7lWdyaBZ4BoWs+b
         CK1/UK85l84CX+80sK0sT9jmzeIOW9NYRioDQLJoy17gJ9q/0/QgqRVGJRRa1uVsRu71
         +aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196245; x=1795801045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pQ/nw5caVi4RbK1CcsBfPp7aScPNttl9DankhCdcO4=;
        b=ipALyHPlpeiT57ZnxHkx8BzcjAC1uzGZSTzYVQ40XdpVasfOt+GDskfsh9KhFdxSZd
         QmMkjQJW+QhejOPWxHmQ/uFAkFe0Dw8yDqrSEYYq1RUJHeDsB78LsXoi0U73cs/KEBnd
         skNGmoGi6scag7G4j82NrZpVBVWvqdH39Be+CiuoCvvvpwg5JlRCnNlYuUdxoK+ycOAU
         pBxPni4zqhdZP36Omhfe3q3XxWhjY0fkZibg36RFVa7reu7meb1N7ifkRybxdw68ZRs9
         EM+nMfeVZyBjVw54LVXL5/70YQBTr565v/HvO38M/rCxwczhCMzgzzLL+LnHpVmYXKRM
         NgJg==
X-Forwarded-Encrypted: i=1; AL+hErH2o7pMfhlZgEVvh2zDaXPYYW8SoDanRwVVsMXiXS0I9CTh+WKDKiHlBHzKf/DrrYOsQCBtjKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z938MG2DOmGObEENwCNAXmghEgID4ko9qnW1TV+yZ0mYAvEA2Ic
	bgKGFirC661AkL3SBEj5mD4/PfkeGtNxv64+RxAYVYrjyo45wGmxpAOL
X-Gm-Gg: AYBFou1uCf8tL4MJObCkwFvs/CUriDz/SbSjUtB0AZXh81NfOij0zvhI7ACoW/xAci+
	Fq7mV5vZiFgz2W8btVvGTBjoHigIrX2de5hxH0IAl8xE+Dtys+lX4g0jHfKHPQaU1v3kOcgMcGs
	aoZ+zMzqO41hSHg9Am9X3vsUhMMIlDfn8Gx7jQNFSZJDtwjTZLCxCTq6BWqbksnxfUSoL5PKiDX
	PHshjUCccxDGfvxjP6XtW4umkkvJUX8LjOGRi85B+1SFFnzdMK9FGEtr8lAiZrlvpFeZ6d120Py
	GGSlcYffFvbRiGUvZezSlISz2d8x1+58Fesfw2Slo+6YGoUUo5KpYxHMpg8ho1rcYXayK2kcPJB
	sRmHgrxYdnMZexJwffcT8Tj1Wn1pUGs+9y26aw2ZL9/kq7Q/quKwWWkVWZ7+Jqqe2GFOopFgU+Q
	QrO18qEsMKqbJB4ZpPIz0emx1QY4zVaaAXu17tIceY8bwteg2CF2ZOk20zNNsMFoM1R6xEJvrR+
	LPnuWYAmcNad9iJpR5RdoCFp6/7Bg4EAxW9sfgM0J8yX/2bHlTL3p2P2yb/f8emLJxz8TksKy4+
	f7H2rMo5BlgbdFY3hI4HYuUlNTzonICPU8SIoXEidVyU90O9u3oJ
X-Received: by 2002:a05:6a21:4d8e:b0:3fa:10b3:c8f1 with SMTP id adf61e73a8af0-4014d25ddfbmr3224637637.41.1795196244659;
        Fri, 20 Nov 2026 09:37:24 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1d71dsm1853608b3a.53.2026.11.20.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:37:24 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH net] net: hix5hd2_gmac: do not release the RX ring on interface close
Date: Sat, 21 Nov 2026 01:36:56 +0800
Message-ID: <20261120173702.1551838-1-mmyangfl@gmail.com>
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
Content-Transfer-Encoding: 8bit

hix5hd2_net_close() frees the receive buffers while the free queue still
holds the descriptors the block has already fetched.

A port that keeps receiving then DMAs arrived frames into buffers the
slab has already taken back; on Hi3716cv200 the descriptors at the next
open all carried the previous session's stamps, and the frames received
then came up as slab garbage -- six parsed as LLC, the rest with an
unrecognized ethertype.

Do not release the receive buffers, their descriptors and the queue
pointers on the close, until the device goes away, so the block keeps
ownership of every address it prefetches.

The sibling hisi_femac has the same defect and resets the port before
freeing its ring, as in commit d54b21d82430 ("net: hisilicon:
hisi_femac: Stop the receiver before releasing the RX ring"); this one,
however, has no reset feature and has to keep them alive across a close.

Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 12a5657653f8..8c67a0670cbb 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -792,7 +792,7 @@ static netdev_tx_t hix5hd2_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void hix5hd2_free_dma_desc_rings(struct hix5hd2_priv *priv)
+static void hix5hd2_free_rx_buffers(struct hix5hd2_priv *priv)
 {
 	struct hix5hd2_desc *desc;
 	dma_addr_t addr;
@@ -810,6 +810,13 @@ static void hix5hd2_free_dma_desc_rings(struct hix5hd2_priv *priv)
 		dev_kfree_skb_any(skb);
 		priv->rx_skb[i] = NULL;
 	}
+}
+
+static void hix5hd2_free_tx_buffers(struct hix5hd2_priv *priv)
+{
+	struct hix5hd2_desc *desc;
+	dma_addr_t addr;
+	int i;
 
 	for (i = 0; i < TX_DESC_NUM; i++) {
 		struct sk_buff *skb = priv->tx_skb[i];
@@ -873,7 +880,10 @@ static int hix5hd2_net_close(struct net_device *dev)
 	hix5hd2_irq_disable(priv);
 	napi_disable(&priv->napi);
 	netif_stop_queue(dev);
-	hix5hd2_free_dma_desc_rings(priv);
+	/* free rx buffers when device goes away, not when interface closed;
+	 * the hardware prefetches rx descriptors and cannot be expelled
+	 */
+	hix5hd2_free_tx_buffers(priv);
 
 	if (dev->phydev) {
 		phy_stop(dev->phydev);
@@ -985,6 +995,8 @@ static void hix5hd2_destroy_hw_desc_queue(struct hix5hd2_priv *priv)
 {
 	int i;
 
+	hix5hd2_free_rx_buffers(priv);
+
 	for (i = 0; i < QUEUE_NUMS; i++) {
 		if (priv->pool[i].desc) {
 			dma_free_coherent(priv->dev, priv->pool[i].size,
-- 
2.53.0

