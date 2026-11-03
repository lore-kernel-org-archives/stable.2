Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700329;
	b=eHFHUVX/W80Um37X4Fbx2/23n2Ai3DsWOYL9DHAQi/jUy0OJ0sUN2xms9WgBb4pgGDvf
	 etYv87J2FjSsxoBjg+gyCFLx3zPhVWpMInoNHyN1/jEJvB2m2Gn1bhQhS4JU03XFOE61T
	 soZWb/o7OpVblofiRAa6feOBK2cXnkHhcsGjzIwGcIDNYJqdjQ0SE5fa9vkacDB78p4ZA
	 qE51tZaN+J73cWxuWedBR+PrruM+yF0wBoNjQV6RyjbOM6iqixYeT8+sFECGoc7aprPlg
	 LvrCbQeZlw6fgIJ09fMeFHdcieLpb7Uw09yO6Q9RzDmVIXpFhSqkZtXpXmS6qfLCU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700329;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=nbe3HCMkE02cNxSbO6fejeM4cYJlJPCFxeXdrIl+taY=;
	b=vchJaigfA+ioVdeO/LyLNEg+9grJiYyVJuzRhhO6tkCIPj97MaYPYw7NN8UhX+lYuEtu
	 mrbfkQpJENHHAI0Ef7XaG6qp9CFvbG2Y4vkQcDH6pTcfmxkjxeueG/nNTKKuEhVxMX5Kx
	 v0HDv1gJ2FIBx4lM5rzz3oif6rS8yRhKkw4ebCWOC8+VwlkD0RuvPvEHKjMfgJRgrG2pQ
	 LICh4h4LJjlSmJD3eCDViY96qzNLhvaxgrrQdN/ip1UNlcW5epQoWQOSUnVGXg6KWEY58
	 7dqRzLfRLNyEVND8fP4Dh8I/bkGajHRRgQnbW/gE6oxPs7SoU79PXWxgxwMAqpWu+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01B606EE8B;
	Tue,  3 Nov 2026 10:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C01B606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn8JHhselqdXs7AA--.2502S2;
	Tue, 03 Nov 2026 18:05:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: cxgb4: do not leak a PTP skb when the Tx queue is busy
Date: Tue,  3 Nov 2026 10:05:30 +0000
Message-Id: <20261103100530.1309928-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn8JHhselqdXs7AA--.2502S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF13Gr13ZF4rJr47Ar1fZwb_yoW8ZFWDpw
	sakr90k395Jw4Ygayvyw48XFn0qw48t3yfKFyrC3s5u3s0qr1rury8WayjyrWDArWkGay7
	ArsFyFnrGrs8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMAA2rpnIBh8AAAsX

cxgb4_eth_xmit() stores the PTP skb in adap->ptp_tx_skb with an extra
reference before the descriptor credits are checked.  When the PTP
queue is full the function returns NETDEV_TX_BUSY, and later failures
such as an unsupported FCoE offload or a failed DMA mapping jump to
out_free.  None of those paths transmit the packet, so no transmit
timestamp ever arrives and the extra reference is never released.

Only take the extra reference once the packet is certain to be queued,
just before it is handed to the hardware.  The initial check for an
outstanding PTP skb is kept, and PTP transmits are serialized by
adap->ptp_lock, so only one PTP packet can be in flight.

Fixes: a456950445a0 ("cxgb4: time stamping interface for PTP")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 9fccb8ea9bcd..7e83f60bd14e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1523,12 +1523,9 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	qidx = skb_get_queue_mapping(skb);
 	if (ptp_enabled) {
-		if (!(adap->ptp_tx_skb)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			adap->ptp_tx_skb = skb_get(skb);
-		} else {
+		if (adap->ptp_tx_skb)
 			goto out_free;
-		}
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		q = &adap->sge.ptptxq;
 	} else {
 		q = &adap->sge.ethtxq[qidx + pi->first_qset];
@@ -1707,6 +1704,9 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb_tx_timestamp(skb);
 
+	if (ptp_enabled)
+		adap->ptp_tx_skb = skb_get(skb);
+
 	if (immediate) {
 		cxgb4_inline_tx_skb(skb, &q->q, sgl);
 		dev_consume_skb_any(skb);
-- 
2.34.1

