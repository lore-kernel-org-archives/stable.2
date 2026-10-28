Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164073;
	b=DclXrf1NkrRsydSq56h3cHPSUQuo4+5P2RZWKrUVCK+yp/okCuBleXVwspoX0S+n2P7M
	 he/QhOZZ2iabQiNH3kqAAQdyHiAivf8n2s+6HzTKN1XdtOvULF89V/MH2HEXjHV3DmkY7
	 MEePeY5h+G7Qno3heRedGH8oyOq1RIsiccpvzvhmRlKfE52tmf/R6sBKt5armU1VpIN+U
	 90s8zEOPxaqY/Wv/MhDPkrsnI3uVW1zOWHoIk29ORnjr3Ty2B7VgVPt6UYD2fF/HK6Jyi
	 zUAvAHKXWjX91sT/tMCNnvDPaIPspvbiTbXvoxtAXJnQPDIeB7x1LehuEq0jZMCl/1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164073;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5rO9f1I5wxtaSzXVg3rcnKC09sTjMhhgv3WDJaewHGQ=;
	b=OHCOJOMhDQf0H2NvpiaxyjDiOkOMvuvm+K/dpUlUFmpH4iKR373TOxmBYc4TCuGbq8tw
	 TaghkUBrrqENEREKfRteATYZPurOadpNcy/lK+qaPAPNvhHEpx6RoTHJbQh9hEAKJRXM0
	 txqWB77mIVbK+y8mbY4sLJUZ0dnGmNsMtF9kKgoeWJ6CyIg9nxhW4jdy+Hvq/GKWtPvj9
	 HMsGcrtlhvMXe44f6k1ubgjbUlTazJkgoodM+w7LiR/1ArsNIdoDlsrtIAW0TsL9w1A53
	 ILtOMw7oECBgsSslwiGi1RYArrKK46qyEmatSSy0RwAa50EkqgLZ0hEVXWa5yx1knBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N0AGkb2Z;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D5606A31A;
	Wed, 28 Oct 2026 05:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE1D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N0AGkb2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5r
	O9f1I5wxtaSzXVg3rcnKC09sTjMhhgv3WDJaewHGQ=; b=N0AGkb2ZpAgmGY3bnn
	gkZQuCvT+qAmOY/UYO+9t8sIF00IHQTf6m8G0uDDurQg3OVW9SIw9vw6WXHC4Njp
	4Xe0jul65rV/9yezm3DPidD1fHA8DPFb4ZdQYXNUyWdTxXjwMTwhMVCNZndKJK4N
	Ftq1IN2yGOsiNP3lvYqIyNb8Q=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn31cMg+FqswGRDQ--.35366S3;
	Wed, 28 Oct 2026 13:07:26 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: mt76: mt7921: validate NIC capability payload lengths
Date: Wed, 28 Oct 2026 13:07:20 +0800
Message-Id: <20261028050722.135598-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDn31cMg+FqswGRDQ--.35366S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4kJF15WFWDurWftw4kCrg_yoWrXFyfpF
	WYgay5CrWUGFsF9w4DAr4UAan0y3s5KrW3KFyrC3WFq3ZrCrn8AF4Iv342kr4aka4kur1a
	yF4jvan5WrnrXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWrWrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg72MWrhgw73xwAA3x

The NIC capability parser checks that each declared payload fits in the
skb, but it does not ensure that the payload is large enough for the
selected capability. A truncated firmware response can therefore make
the driver read beyond the current TLV while copying fixed-size fields or
parsing capability structures.

Validate every consumed payload before accessing it and reject the
response when a known capability is shorter than its fixed data.

Fixes: dab35009fc1c ("wifi: mt76: mt7921: move connac nic capability handling to mt7921")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 41 +++++++++++++++----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 25638c68c468..c960648b2b61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -521,8 +521,8 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	return ret;
 }
 
-static void mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
-					 struct sk_buff *skb)
+static bool mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
+					 struct sk_buff *skb, int len)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 	struct mt7921_tx_resource {
@@ -537,6 +537,9 @@ static void mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
 		u8 pad[3];
 	} __packed * tx_res;
 
+	if (len < sizeof(*tx_res))
+		return false;
+
 	tx_res = (struct mt7921_tx_resource *)skb->data;
 	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
 	sdio->pse_mcu_quota_max = le32_to_cpu(tx_res->pse_mcu_quota);
@@ -546,10 +549,12 @@ static void mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
 	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
 	sdio->sched.pse_page_size = le16_to_cpu(tx_res->pse_page_size);
 	sdio->sched.deficit = tx_res->pp_padding;
+
+	return true;
 }
 
-static void mt7921_mcu_parse_phy_cap(struct mt76_dev *dev,
-				     struct sk_buff *skb)
+static bool mt7921_mcu_parse_phy_cap(struct mt76_dev *dev,
+				     struct sk_buff *skb, int len)
 {
 	struct mt7921_phy_cap {
 		u8 ht;
@@ -571,12 +576,17 @@ static void mt7921_mcu_parse_phy_cap(struct mt76_dev *dev,
 		WF0_5G
 	};
 
+	if (len < sizeof(*cap))
+		return false;
+
 	cap = (struct mt7921_phy_cap *)skb->data;
 
 	dev->phy.antenna_mask = BIT(cap->nss) - 1;
 	dev->phy.chainmask = dev->phy.antenna_mask;
 	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
 	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+
+	return true;
 }
 
 static int mt7921_mcu_get_nic_capability(struct mt792x_phy *mphy)
@@ -620,20 +630,30 @@ static int mt7921_mcu_get_nic_capability(struct mt792x_phy *mphy)
 
 		switch (le32_to_cpu(tlv->type)) {
 		case MT_NIC_CAP_6G:
+			if (len < sizeof(skb->data[0]))
+				goto invalid;
+
 			phy->cap.has_6ghz = skb->data[0];
 			break;
 		case MT_NIC_CAP_MAC_ADDR:
+			if (len < ETH_ALEN)
+				goto invalid;
+
 			memcpy(phy->macaddr, (void *)skb->data, ETH_ALEN);
 			break;
 		case MT_NIC_CAP_PHY:
-			mt7921_mcu_parse_phy_cap(phy->dev, skb);
+			if (!mt7921_mcu_parse_phy_cap(phy->dev, skb, len))
+				goto invalid;
 			break;
 		case MT_NIC_CAP_TX_RESOURCE:
-			if (mt76_is_sdio(phy->dev))
-				mt7921_mcu_parse_tx_resource(phy->dev,
-							     skb);
+			if (mt76_is_sdio(phy->dev) &&
+			    !mt7921_mcu_parse_tx_resource(phy->dev, skb, len))
+				goto invalid;
 			break;
 		case MT_NIC_CAP_CHIP_CAP:
+			if (len < sizeof(mphy->chip_cap))
+				goto invalid;
+
 			memcpy(&mphy->chip_cap, (void *)skb->data, sizeof(u64));
 			break;
 		default:
@@ -641,6 +661,11 @@ static int mt7921_mcu_get_nic_capability(struct mt792x_phy *mphy)
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
 
-- 
2.34.1

