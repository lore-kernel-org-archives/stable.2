Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164075;
	b=DDfV0Lj5XEWb46MSrs90aLnF17tHvHTPPiBkIK+U343KiOjRs1TqzIOF8hOlQT4QNeox
	 xOHZd7viAzADquVz7H5sFrmmFXTNFDadF288TaspQ3U7kLP10gMruPmLXZuLqhGbQLwEj
	 RqKUdc6AHqDbJ7u+/VziRAsRfKCg24RmbZcsEq0AFGA4R9gaFX8k2SauujTutGLlwj56J
	 Af9tvMungy0ksPO0B+B+jLIXR3neFllsvhFDXD7NGiEq/VqgImmoE6RBr3CE8aKcLtS/a
	 GWbFbJroP037JUtakD1MOK6I6nL52UkpAFnsTGh1SbO0xWCfrN3GQkd1SWAr0Jrn8Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164075;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MTIAVEb2k2hh86gcLrq0Ks4EmnWvWMm36zR/JvnNe0E=;
	b=HMYPHB3aDrHpWPdNZ83AJQR8Ja1kkBPXasHi4CSaMPSZeWP+6K3gKUGhwLty0hiY4Ayz
	 XMbseKs+wYQK9qSjbcNtrjFdE3FXtEjZ8KC1ie6gapuoHQwpSE39HeNxcSLfMGELXeRA0
	 2nemYLm28lmyKja7Fw5bhnRAqs/DRioGn5R/uVMq7DM2ylKsGT4vJvxRB/USYcZy0soZA
	 +2brBIswzPg4wYbYmNvLAKBHBnOXrRgiAkxCHWvyFOnn0tT+/IAAEy063+bdUDKNkyYic
	 4Jiudnp9bhYG9hc5e1LYZD6Wv550501YZ4qiVSIk+wj91T4vd+uSS+PFsjcp8AhAv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nrNkqtu8;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90830606A327;
	Wed, 28 Oct 2026 05:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90830606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nrNkqtu8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MT
	IAVEb2k2hh86gcLrq0Ks4EmnWvWMm36zR/JvnNe0E=; b=nrNkqtu8fhkkFEswyo
	5jC53CibVwNMeuTwwxIPK5GhoGBJ5QhERYZUqAh3NQg6svcqL+1EERLpf3jlDmSE
	uh56lqO5C0w8K95PS9/wQeWbUoRmDicQkKooX4LxHUDku7w9wzO66RhNSEeIYu31
	Z9qI5QEFvp3KltohOrzo2Fvmw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn31cMg+FqswGRDQ--.35366S5;
	Wed, 28 Oct 2026 13:07:28 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Rong Yan <rong.yan@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7925: validate NIC capability payload lengths
Date: Wed, 28 Oct 2026 13:07:22 +0800
Message-Id: <20261028050722.135598-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050722.135598-1-yaojiale02@163.com>
References: <20261028050722.135598-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDn31cMg+FqswGRDQ--.35366S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF17Kr4xJFyxZr15XrWfAFb_yoWrJr4Upa
	yagFW5Kry8trsrWw4Iyw4fArWay3s8Kw47JFyfJwn0vws7Awn5Ga18Z34vvr1ak395ur1I
	vr4UtFn8W34DuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwb18UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xH3MmrhgxHxmgAA3J

The NIC capability parser only checks whether a declared TLV length fits
in the skb. It does not reject lengths shorter than the TLV header or
ensure that known payloads contain the fields consumed by the driver. A
truncated firmware response can therefore stall the parser on a zero
length TLV or cause out-of-bounds reads from fixed-size payloads.

Reject undersized TLVs and validate every known payload before accessing
it.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 43 +++++++++++++++----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c612fda55eb7..41138203ada2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1039,8 +1039,8 @@ int mt7925_mcu_get_temperature(struct mt792x_phy *phy)
 	return temperature;
 }
 
-static void
-mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
+static bool
+mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data, int len)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_dev *mdev = mphy->dev;
@@ -1064,16 +1064,21 @@ mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
 		WF0_5G
 	};
 
+	if (len < sizeof(*cap))
+		return false;
+
 	cap = (struct mt7925_mcu_phy_cap *)data;
 
 	mdev->phy.antenna_mask = BIT(cap->nss) - 1;
 	mdev->phy.chainmask = mdev->phy.antenna_mask;
 	mdev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
 	mdev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+
+	return true;
 }
 
-static void
-mt7925_mcu_parse_eml_cap(struct mt792x_dev *dev, char *data)
+static bool
+mt7925_mcu_parse_eml_cap(struct mt792x_dev *dev, char *data, int len)
 {
 	struct mt7925_mcu_eml_cap {
 		u8 rsv[4];
@@ -1081,9 +1086,14 @@ mt7925_mcu_parse_eml_cap(struct mt792x_dev *dev, char *data)
 		u8 rsv2[6];
 	} __packed * cap;
 
+	if (len < sizeof(*cap))
+		return false;
+
 	cap = (struct mt7925_mcu_eml_cap *)data;
 
 	dev->phy.eml_cap = le16_to_cpu(cap->eml_cap);
+
+	return true;
 }
 
 static int
@@ -1121,36 +1131,53 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 
 	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
 		struct tlv *tlv = (struct tlv *)skb->data;
-		int len;
+		int data_len, len;
 
 		if (skb->len < sizeof(*tlv))
 			break;
 
 		len = le16_to_cpu(tlv->len);
-		if (skb->len < len)
+		if (len < sizeof(*tlv) || skb->len < len)
 			break;
+		data_len = len - sizeof(*tlv);
 
 		switch (le16_to_cpu(tlv->tag)) {
 		case MT_NIC_CAP_6G:
+			if (len < sizeof(*tlv) + sizeof(tlv->data[0]))
+				goto invalid;
+
 			mphy->cap.has_6ghz = !!tlv->data[0];
 			break;
 		case MT_NIC_CAP_MAC_ADDR:
+			if (len < sizeof(*tlv) + ETH_ALEN)
+				goto invalid;
+
 			memcpy(mphy->macaddr, (void *)tlv->data, ETH_ALEN);
 			break;
 		case MT_NIC_CAP_PHY:
-			mt7925_mcu_parse_phy_cap(dev, tlv->data);
+			if (!mt7925_mcu_parse_phy_cap(dev, tlv->data, data_len))
+				goto invalid;
 			break;
 		case MT_NIC_CAP_CHIP_CAP:
+			if (len < sizeof(*tlv) + sizeof(__le64))
+				goto invalid;
+
 			dev->phy.chip_cap = le64_to_cpu(*(__le64 *)tlv->data);
 			break;
 		case MT_NIC_CAP_EML_CAP:
-			mt7925_mcu_parse_eml_cap(dev, tlv->data);
+			if (!mt7925_mcu_parse_eml_cap(dev, tlv->data, data_len))
+				goto invalid;
 			break;
 		default:
 			break;
 		}
 		skb_pull(skb, len);
 	}
+
+	goto out;
+
+invalid:
+	ret = -EINVAL;
 out:
 	dev_kfree_skb(skb);
 	return ret;
-- 
2.34.1

