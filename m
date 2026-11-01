Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793525655;
	b=FdLjZ7zzGSM90SAioSI99fdx8FO1ztdXVdpkyNgVUqNxP1tDpEF6y9C4jDDiRlHOrMvM
	 xPTq2o8Hv1besFG3HmUiv/k4tx4d17oZyFyyWio6ZU0I8D95dh1XztSoVbgxmNi8h/ZDU
	 gUBpxySi2irdvrC2+Gb5WIVKRzWo3r3H+byFxqS4O/0qNmMIXDa+3HSoqScqbYb0h5oAL
	 QnNInrAx9KCFWsGL4ZbxWFunGxWiXom09Aaz2N8E797BWc+tx7kCHZ83pSSNvfgIwlpjD
	 TGLSsMRnqIJRkE9iehOXqNLF3V20bg2jjcp6DGBH8xBbyt3AQeQ87zViFX2qz6Izv4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793525655;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=IE/ei9ydvblkzeHHIKH9hvEsVow8o9vYsVhMASi+c3M=;
	b=k0wdEwJBjVOQWz40kDtUo+hD2Did3541uKdFUm1o1HxERA44GdYhCQixAM0cLq3n9v6O
	 ZP2simAf98VhYmUUQnBMdjF4CTQvSc+FlYhwTW3/JitjRtq0LbO/Tnj1zljE8E1eafJbw
	 HecuQRb5rOckI47Jv9C5Dt2njG7d7MM+y43osIxwjNi4F8jRGjnQaUK7ErRpNe2IL3xoy
	 odt+y0IZtdjbed2gRuqVoyO8wVmMw6KiCAKJyntEhYIF5OP5GYBCnRZ/rJ+W2pIteF9Qz
	 zwDe7z8s/sn7hqhDKwpIhggP8xFDDX2WZimDFwujcatBNw/qpNXuSe+2cuwooU4z1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B7606A324;
	Sun,  1 Nov 2026 09:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5B7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=IE/ei9ydvb
	lkzeHHIKH9hvEsVow8o9vYsVhMASi+c3M=; b=fBmdmYlLbD20gKWnoE7e1Acj9H
	gpLz/xEjp2aAkByt3gn+1PXbEmI9TQMDSwx8oJNZTuA5Y/fHLLenZQXXTtzYaEeA
	pjzbqvFg9L2O411uTDoEnqQAwUwIlZTAttydMf9WEFA7M/25/YlkDLzDOINWhJNR
	oz68mESfIm3Pb8Y4c=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.43])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAGCv2BB+dqSbwUAQ--.19624S2;
	Sun, 01 Nov 2026 17:33:55 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <mbrugger@suse.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7925: fix out-of-bounds read in mt7925_mac_add_txs
Date: Sun,  1 Nov 2026 17:33:52 +0800
Message-Id: <20261101093352.3070-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BbQMCkAGCv2BB+dqSbwUAQ--.19624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kJw4fXw1furykGrW7Jwb_yoW8Cr1Dpr
	WjkFyjkrWUJr4DGw18Aa1avan8A3Z5GrW3Gr4Fvw1rZ3s8Grn5AFy5ZF1j9F1YyFWjkF18
	JF4Utry3WrZ8uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2jXdUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2rmBFRXBAACsC

mt7925_queue_rx_skb() walks the TXS entries up to skb->len, but that
length only describes the whole packet. For RX skbs that are not fully
linear, such as the ones built from the fragmented USB RX path,
skb->data only covers skb_headlen(skb) bytes, so the loop advances past
the skb head buffer and mt7925_mac_add_txs() reads outside of the
allocated slab object:

  BUG: KASAN: slab-out-of-bounds in mt7925_mac_add_txs+0xe79/0x1290
  Read of size 4 at addr ffff88800ebea648 by task napi/mt76u-rx-0/209

Bound the iteration by skb_headlen(skb) instead. Fully linear skbs keep
the previous behaviour, since both lengths are equal there.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 3b82c9de26c5..adea216578f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1422,7 +1422,7 @@ void mt7925_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
-	__le32 *end = (__le32 *)&skb->data[skb->len];
+	__le32 *end = (__le32 *)&skb->data[skb_headlen(skb)];
 	enum rx_pkt_type type;
 	u16 flag;
 
-- 
2.34.1

