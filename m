Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069265;
	b=w1EHzxpWdzgJXXFoxtJjItRec5+J6o3wAsw+qUOAPwpMHwWf5GK5zsV0s9Gdbuvag/+f
	 5kiFFhbLyTjusgyl4Kb7JG1/6XAts7z8080FtP0CTqsVCjrvEAop/eNgj3qfmdGRVNwS0
	 zj4Mc1WMWLZY4dlRfjbWNrZHpTtn7T3STNVcyteHX00cMbFBJoQnuTacVcnUX00xzLisa
	 nodKWCajyUomZwDVUfUafjiC9vPsL3RTc10Zs4oFO2vPeBKokYrwoBWqwVtvzu1ql5TTg
	 /rT7m8NTAC6kQhJC8SIqn8aHFL6SaUTC1No7pqmCYd9BvLgMjyHbBeYIGEnqpwwBTkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069265;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qbyL5HMrGv75dxRJkA0TUVYKMlH2SnW57JgwxkKtV7Q=;
	b=036xAW82MTekdt/t9nEJjC6DZUNa/y/qFiNhKNEd4g6WwLPEDYos4MGuDGLu75wqwzkt
	 a2lMOoWWXY9Me+5f7oPJ1nE1vvgPM0gpdYc9IYWDkqvUjHel+o5h8lilOqnMpOITcGQdq
	 Oe89hxFagXbyRmNDNj4Wjc0wri3VaUCqh01kJPAX9wuoAYJtIYx3teRhIUDqyuKv8NF+3
	 7JmKsj2m0PVrFBquAKT3KbzRTRtqcJmjjaHhTtEoagpwKVDSqGkW7uOdurIGQvIb7EShD
	 yFfNlTFezJgHTGw675+PTLmT3Ub/QYzSdbsms2SKsLXTIXLROpg+CAHUgxdtqcj5eSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G0Kv+Gb2;
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D093606A326;
	Thu, 19 Nov 2026 06:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D093606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G0Kv+Gb2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795069254; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qbyL5HMrGv75dxRJkA0TUVYKMlH2SnW57JgwxkKtV7Q=;
	b=G0Kv+Gb2uorMxENuh45jQqk6geH5Pzo80fnPJdXyzahSRT3Z5tq2LXJrd8Yg0axxfRptu/HTJtfMp9/pSqroDaWU3EvN7pgfZRDDmWpiX663R7m0DQWJBLUlypow/6Ar/MqDUauNRjlejZaJ6I0jw0onopLJuEGtORVniCU3FYk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436262|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00479623-0.00100605-0.994198;FP=17005987452478377524|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083034076;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k5V6pCz_1795069250;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k5V6pCz_1795069250 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 14:20:52 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	netdev@vger.kernel.org
Cc: Liu Haijun <haijun.liu@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lin Qiaojie <linqj@xiaopeng.com>
Subject: [PATCH net] net: wwan: t7xx: validate PIT data offset before skb_reserve
Date: Thu, 19 Nov 2026 14:20:44 +0800
Message-ID: <20261119062044.72261-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

t7xx_dpmaif_set_data_to_skb() derives the data offset from the
modem-supplied PIT data address and the driver's BAT DMA base address.
The unsigned 64-bit difference is stored in an int, so a backwards
address can wrap into a non-negative value and escape validation.
A negative offset passed to skb_reserve() moves skb->data and
skb->tail before skb->head. The subsequent skb_put() then extends
the skb over an invalid range, allowing later packet processing
to access memory outside the allocated buffer. The existing tail/end
check runs after skb_reserve() and only guards the tail side.

Compare the addresses in the unsigned domain and validate the offset
and data length against both the skb tailroom and the DMA mapping
length before calling skb_reserve(). This subsumes the old tail/end
check.

On error the DMA mapping is already torn down, but the skb stayed
assigned to the BAT entry and the entry was never marked consumed.
This leaves the BAT entry unreclaimable and can eventually stall BAT
release and buffer replenishment. Free the skb and mark the entry
consumed so it can be released and reallocated.

Reject invalid packets with -ENOBUFS.

Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
Cc: stable@vger.kernel.org
Reviewed-by: Lin Qiaojie <linqj@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 29 ++++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 5af90ca6e063..44e2ba15984d 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -632,9 +632,9 @@ static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
 	unsigned long long data_bus_addr, data_base_addr;
 	struct device *dev = rxq->dpmaif_ctrl->dev;
 	struct dpmaif_bat_skb *bat_skb;
-	unsigned int data_len;
+	unsigned int data_len, tailroom, max_len;
 	struct sk_buff *skb;
-	int data_offset;
+	unsigned long long data_offset;
 
 	bat_skb = rxq->bat_req->bat_skb;
 	bat_skb += t7xx_normal_pit_bid(pkt_info);
@@ -643,22 +643,35 @@ static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
 	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
 	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
 	data_base_addr = bat_skb->data_bus_addr;
-	data_offset = data_bus_addr - data_base_addr;
 	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
 	skb = bat_skb->skb;
 	skb->len = 0;
 	skb_reset_tail_pointer(skb);
-	skb_reserve(skb, data_offset);
 
-	if (skb->tail + data_len > skb->end) {
-		dev_err(dev, "No buffer space available\n");
-		return -ENOBUFS;
+	if (data_bus_addr < data_base_addr) {
+		dev_err_ratelimited(dev, "Invalid PIT data address\n");
+		goto err_drop;
+	}
+
+	data_offset = data_bus_addr - data_base_addr;
+	tailroom = skb_tailroom(skb);
+	max_len = min(tailroom, bat_skb->data_len);
+	if (data_offset > max_len || data_len > max_len - data_offset) {
+		dev_err_ratelimited(dev, "Invalid PIT data offset or length\n");
+		goto err_drop;
 	}
 
+	skb_reserve(skb, (int)data_offset);
 	skb_put(skb, data_len);
 	skb_info->cur_skb = skb;
 	bat_skb->skb = NULL;
 	return 0;
+
+err_drop:
+	dev_kfree_skb_any(skb);
+	bat_skb->skb = NULL;
+	t7xx_dpmaif_set_bat_mask(rxq->bat_req, t7xx_normal_pit_bid(pkt_info));
+	return -ENOBUFS;
 }
 
 static int t7xx_dpmaif_get_rx_pkt(struct dpmaif_rx_queue *rxq,
@@ -674,7 +687,7 @@ static int t7xx_dpmaif_get_rx_pkt(struct dpmaif_rx_queue *rxq,
 
 	ret = t7xx_dpmaif_set_data_to_skb(rxq, pkt_info, skb_info);
 	if (ret < 0) {
-		dev_err(rxq->dpmaif_ctrl->dev, "RX set data to skb failed: %d\n", ret);
+		dev_err_ratelimited(rxq->dpmaif_ctrl->dev, "RX set data to skb failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.50.1

