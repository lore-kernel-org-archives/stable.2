Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829857;
	b=2S7lklcZoK2cknidP2mVdA00JZsHehc4nulx6RkTXdQ9GEl7WTdEAjhlvdTeoHytRda/
	 QeaPPDURL/9QB/nImRuM5GvZHptGFzyU51i2YuCazfBoYp2swh/7ijKs0e5krQJplkH12
	 VAH8FstvDyFRV+ATjS9ELxA1QY4f8fbmq9L68Fw39LP5zO9oGi7lckcOw5cvKwXd7XDgJ
	 8MITiGN5SejhyRAGWJARrLjlbHYheVoQSOnP9YlB5qLo5UH/GlHprDlbnWkIM6Ih7kbFq
	 RK6DMxs7FT6ZIOzuOQtn0pfUXhucTXhDpq/kjgJSmZtFpQ82AFPNHgyTqGn9fMHdxfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829857;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=6WoQEmCVBIuhl/cSF3DZdFXshm17IcMA/oo1QCpuU6Y=;
	b=zylW2fj3wfADCDo+Vj4HFuwp6f6kQeGafGMJ2d+I+YJscFN67Z09ZwLOTreCAs/EXFLr
	 firQztqkGmVs94PYnqbDymveMgdZOx7trioVy8PfTF27o6ar6Wsdi4CLjfPvj/Vv0YRUj
	 wDk+SDuzfzziRmZ+t8ksDtOIJLnKET91W3ZO63cpO2o7KC1knUwNtK8atVKdqKHWGRdm5
	 H+M0u8qgZljpd7oAyKj2xg6+vtAJdpwAAVoPBGhwlx55bOnISzgGtt0Mk9c1Dp0RKup0l
	 w2MWAYKq/l0RabyKbByWTCrx2b55hYALmCuNH44UFFIsBSmWEL5G2E9MEB1eMuPqaLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDD606A32C;
	Mon, 16 Nov 2026 11:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FDD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=6WoQEmCVBIuhl/cSF3DZdFXshm17IcMA/o
	o1QCpuU6Y=; b=xd7TyJkFQexSyjngBgdxIIKCaZmIeVLBa3O+p/8KMV+5Gl5OTJ
	eLmcux86f349NUo1qW52SJdv/wKIaWudJB8uxPJn15VJEOwtNZxA4w14Olv2KgiE
	moX8Nh4vllVi4rlI0ogmTcZ7p0X5i8oeuNEvgPNm6euagYNPg/S2M1u3I=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkB2vwQF7vpqZ6S3AQ--.3956S3;
	Mon, 16 Nov 2026 19:50:38 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <mbrugger@suse.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mt76: mt7615: fix out-of-bounds read in mt7615_mac_add_txs
Date: Mon, 16 Nov 2026 19:50:27 +0800
Message-Id: <20261116115028.2766-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116115028.2766-1-25031212351@stu.xidian.edu.cn>
References: <20261116115028.2766-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkB2vwQF7vpqZ6S3AQ--.3956S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kJw4fXw1ftr4rZFWxCrg_yoW8AFyrpF
	WjkFyj93yDtr4DGw4kAa1293Z8XanYgFWSgr4Fvw15u3s8Cr1rXFyrZF4j9r1FyrWYkF18
	JF4Utry3WrZ8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62
	kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2
	z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0ag43UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytfPsAAAsp

mt7615_queue_rx_skb() walks the TXS entries up to skb->len, but that
length only describes the whole packet. For RX skbs that are not fully
linear, such as the ones built from the fragmented USB RX path,
skb->data only covers skb_headlen(skb) bytes, so the loop advances past
the skb head buffer and mt7615_mac_add_txs() reads outside of the
allocated slab object:

  BUG: KASAN: slab-out-of-bounds in mt7615_mac_add_txs+0x5c8/0x650
  Read of size 4 at addr ffff888005097b40

Bound the iteration by skb_headlen(skb) instead. Fully linear skbs keep
the previous behaviour, since both lengths are equal there.

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index aad232c5a6fa..86c6b443ef71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1620,7 +1620,7 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
-	__le32 *end = (__le32 *)&skb->data[skb->len];
+	__le32 *end = (__le32 *)&skb->data[skb_headlen(skb)];
 	enum rx_pkt_type type;
 	u16 flag;
 
-- 
2.34.1

