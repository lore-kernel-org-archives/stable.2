Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164074;
	b=KcnpndVVpwIJGylH6krbh54KZ3ZHcZawbwAa213xqommcD4Ry/eRdxvzLz5geHifEOwO
	 ayZyjnPRAjRstGevyDbndn6k5lz6PN22xfwx7tjZOOoooooLmlT3Fa5FcMHM8CL8SDW5Z
	 uo23nUUiwehKgXndjQFLz4U159soBJBnWdkWWwiHjbMN0f4hRvH9JY09Gfls0F/gtTovv
	 p3OgaiN4m9ywi77hhfQGm6uWUcAvvCBwpRUFZzqksGuQm2q6Z3W1fXMcG90NT1eH0V+hI
	 DveCsZfduXcq42J4K7/rN689ZmdPZ8gjU0ALTqrtS5JPdb5BwP1PaPpRAprRyPnIxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164074;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lRCQZa5YVFO4ifUqBznjC6YOnqAmsQeBaBsRyaw4EU0=;
	b=mtW7qSKAZBMB7eypJ6Rev93zQpEd1XF/V6hoUALnYxtOPf1nI/coC2ymtj/6wOTAoIQE
	 TDzU+GIlYxAGdia51xXBV5BPXmR2fklrv1EdpXdgGI6NcdM8D9ZNnsxDTwaNf49PeHoTL
	 0QRTX7M3jxUGhcYaIZB2KnYFAZ4Y+5l2fSgu4v0YtUCFl1G5vk6XkG4tNX8NCujtIH76Y
	 RM6ApG2vBbG0F2ZAzjlmvC3Dk2dxcpSbRG0j39oN6dft3nFp4CihdYcX5wn0iafKPVShQ
	 uFA0VnT/pYvzpOujA9wqR2ZR8qJN8plXLWj0leTawGK6h0lvsiP9VAGOt9nxHKZ/i5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q32c1yfm;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11478606A31F;
	Wed, 28 Oct 2026 05:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11478606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q32c1yfm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lR
	CQZa5YVFO4ifUqBznjC6YOnqAmsQeBaBsRyaw4EU0=; b=Q32c1yfmLOLzFQYXgB
	eNnM3lr7sBG2WO6DN+w+LqOuLQAHeebjDuqmiLUPTp2IOlTm0ogu/7OAVjmwRU+5
	GSUJquXvHt2FfXSl2ZWO/ssIon+ZmU6BjL1+RMW/NdjkHoXdyYYv+37O0KTCkKhu
	wfdiTfpCfaXm7mf/62NKxXc8A=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn31cMg+FqswGRDQ--.35366S4;
	Wed, 28 Oct 2026 13:07:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mingyen Hsieh <mingyen.hsieh@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/3] wifi: mt76: mt7925: validate debug message lengths
Date: Wed, 28 Oct 2026 13:07:21 +0800
Message-Id: <20261028050722.135598-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDn31cMg+FqswGRDQ--.35366S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4UXr1DXr15Kw45Xr17trb_yoW5Wr13pa
	yUK3WFyrWUJr4DJw18Can5Zr4aywsYgF47GrWvvwn5ZrZxAr1F9FyqqFyjvF1rtrWrCry3
	Kr4qqry3Crn8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFpB-UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ-2MWrhgw+-tgAA3L

The debug message event handler removes the event prefix and accesses the
message header without checking the skb length. It also subtracts the
fixed header from the firmware-provided length without checking for an
underflow and trusts the string length. A truncated event can therefore
cause out-of-bounds reads while formatting firmware logs.

Validate the event prefix, fixed fields, declared message extent and each
format-specific payload before reading them.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 26cdb3f0a98a..c612fda55eb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -596,8 +596,14 @@ mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 			} __packed txt;
 		};
 	} __packed * hdr;
+	u16 msg_len;
 
+	if (skb->len < sizeof(struct mt7925_mcu_rxd) + 4)
+		return;
 	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	if (skb->len < offsetof(struct mt7925_uni_debug_msg, idx))
+		return;
+
 	hdr = (struct mt7925_uni_debug_msg *)skb->data;
 
 	if (hdr->id == 0x28) {
@@ -608,19 +614,28 @@ mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 		return;
 	}
 
+	msg_len = le16_to_cpu(hdr->len);
+	if (msg_len < offsetof(struct mt7925_uni_debug_msg, idx) ||
+	    msg_len > skb->len)
+		return;
+
 	if (hdr->type == 0) { /* idx log */
 		int i, ret, len = PAGE_SIZE - 1, nr_val;
-		struct page *page = dev_alloc_pages(get_order(len));
+		struct page *page;
 		__le32 *val;
 		char *buf, *cur;
 
+		if (msg_len < sizeof(*hdr))
+			return;
+
+		page = dev_alloc_pages(get_order(len));
 		if (!page)
 			return;
 
 		buf = page_address(page);
 		cur = buf;
 
-		nr_val = (le16_to_cpu(hdr->len) - sizeof(*hdr)) / 4;
+		nr_val = (msg_len - sizeof(*hdr)) / sizeof(*val);
 		val = (__le32 *)hdr->idx.data;
 		for (i = 0; i < nr_val && len > 0; i++) {
 			ret = snprintf(cur, len, "0x%x,", le32_to_cpu(val[i]));
@@ -635,6 +650,11 @@ mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 				   le32_to_cpu(hdr->idx.idx), nr_val, buf);
 		put_page(page);
 	} else if (hdr->type == 2) { /* str log */
+		if (msg_len < offsetof(struct mt7925_uni_debug_msg, txt.data) ||
+		    hdr->txt.len > msg_len - offsetof(struct mt7925_uni_debug_msg,
+						       txt.data))
+			return;
+
 		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", hdr->txt.len, hdr->txt.data);
 	}
 }
-- 
2.34.1

