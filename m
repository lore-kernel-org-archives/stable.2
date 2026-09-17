Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D9269D18;
	Thu, 17 Sep 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642649; cv=none; b=Imlb390LSKAmBVvpzS4QFsxlhjdT3Tb0ixmYqjxFZMBxFdK1kefm/WKsoZVMdhXTbsR8Z3sUjT64FidRxh5NsNtlbLp9rXsiQS9K0lbLr6wFIMgkj9+ox4Xb25InVhSGf7F8Dkoc2x1nJ4HNT78xauLk6CrTBaqpEHzDQzEOn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642649; c=relaxed/simple;
	bh=hDoSqsBm7GKBR+809pd6BRgpS2bitg9x/F9+9TgRMnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEuQOrMZNrTpJCmoqmAMmSMMhUcdP0zfMRbp4o978DLRYk5JbR7+ZnmdFigaug0tX4fvWTLHQdYA2zHqei+qf57w3jzs09qLgBADwa4ejZtxuruT4RDa6lJwvdsuy2HVD2KQjdlhMfZ9H5hWCA5XjRY0Bh7hLb1RxvSposYTK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHtD6Jx6tqIxR_CA--.1135S2;
	Thu, 17 Sep 2026 18:57:13 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: atul.gupta@chelsio.com,
	bharat@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	ganeshgr@chelsio.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cxgb4: Fix ptp_tx_skb reference leak in cxgb4_eth_xmit()
Date: Thu, 17 Sep 2026 10:57:13 +0000
Message-Id: <20260917105713.2147903-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHtD6Jx6tqIxR_CA--.1135S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1fJw1rKF1rCw1xJr4ruFg_yoW8ury7pF
	s0kFW8A3yvqFs7Wa1kAw4fWFnakw4ktryfKFyxCw1rZ3s8tryDua4j93yjyrs5Ars5WF4a
	yrsFvFnFgrs5Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU5TOJ7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMNA2qrrJpY0wAAs9

When PTP is enabled, cxgb4_eth_xmit() takes an extra reference on the
skb and stores it in adap->ptp_tx_skb. If the Tx queue is full the
function returns NETDEV_TX_BUSY, and the remaining error paths jump to
out_free; neither path releases that extra reference, so the skb is
leaked and adap->ptp_tx_skb keeps a stale pointer.

Move the adapter lookup before the first error path so out_free can use
it, then release adap->ptp_tx_skb on both paths.

Fixes: a456950445a0 ("cxgb4: time stamping interface for PTP")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 9fccb8ea9bcd..5d4c63d9a937 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1503,12 +1503,13 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int chip_ver;
 	struct adapter *adap;
 
+	pi = netdev_priv(dev);
+	adap = pi->adapter;
+
 	ret = cxgb4_validate_skb(skb, dev, ETH_HLEN);
 	if (ret)
 		goto out_free;
 
-	pi = netdev_priv(dev);
-	adap = pi->adapter;
 	ssi = skb_shinfo(skb);
 #if IS_ENABLED(CONFIG_CHELSIO_IPSEC_INLINE)
 	if (xfrm_offload(skb) && !ssi->gso_size)
@@ -1553,6 +1554,10 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_err(adap->pdev_dev,
 			"%s: Tx ring %u full while queue awake!\n",
 			dev->name, qidx);
+		if (adap->ptp_tx_skb == skb) {
+			dev_kfree_skb_any(adap->ptp_tx_skb);
+			adap->ptp_tx_skb = NULL;
+		}
 		return NETDEV_TX_BUSY;
 	}
 
@@ -1723,6 +1728,10 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 out_free:
+	if (adap->ptp_tx_skb == skb) {
+		dev_kfree_skb_any(adap->ptp_tx_skb);
+		adap->ptp_tx_skb = NULL;
+	}
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
-- 
2.34.1

