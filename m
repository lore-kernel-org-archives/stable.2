Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6952AE7A;
	Mon, 22 Jun 2026 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103806; cv=none; b=r2AOkxOslb7ojmX1Ef+pzYMBr0jyAHtjGBQjP/MSTlrbgITirOpil0sDvcpSRdkWwm4WdYoq9tfZEGacMY7AK7gcl+2tF8JpmJ/SYXH4BuRSM27LpdMqK8QAbO+pFeGcGAr5oH8UIBmgENUauBw8NPsUmZBcftXV30QRtY6XK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103806; c=relaxed/simple;
	bh=MihYhHitBgIRq2skqdia1Bd6TDXpn4Qv1ik/XGT14Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itu5MYzwHga6jLhe5jg1b6YElbjsjZsml2gi7prJgAbQs93LXPm3vdZdL9TQXrDDJs3nTOj98Yx16Fu1EbG4ch6zd1N7KT09YhvmqhCanKlmmTcxJF0QpPXjtdLvBSWAue/KADMkvAkDGI+Guip1lwU6hexnlDl0EP8R3KwRz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dbdQAUYH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dbdQAUYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GZ
	tankCFaft2XhoUMoa3/uJleAp0j0bZd5291Kswe2s=; b=dbdQAUYHtpvRJw3/gh
	l0Z7i4uLD58dUcxGMtx75oZo2RteT4FjKNpngoi8QfG89Gi/zaSGHeHz+oQH9yzv
	OoPowWgRSAzNfEv6h+QGJM7M0NEJzXtxiprPbgXv+0Rw0qOSQ7RK+KgHUns+D0w6
	3bPeh/81y0O8BhXYpaz9rbyxg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3PvfLvjhq9IvzEw--.54790S2;
	Mon, 22 Jun 2026 12:49:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: meth: check skb allocation in meth_init_rx_ring()
Date: Mon, 22 Jun 2026 12:49:14 +0800
Message-Id: <20260622044914.664749-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PvfLvjhq9IvzEw--.54790S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFykurWxWryUWF45Wr4fAFb_yoWDtwcE9r
	4j9rnaqa1DGF10ywsFyr47CryY9F95Zr95ZFsxKrZ3JFW2gr1Fqr1DurZ3Gry7Wr1rAFWD
	GFnxta12y34ftjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN73kDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g2L+Wo4vs16HwAA3V

meth_init_rx_ring() does not check the return value of alloc_skb().
If the allocation fails, the NULL skb is passed to skb_reserve() and
then dereferenced through skb->head.

Add check for alloc_skb() to prevent potential null pointer dereference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/sgi/meth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index f7c3a5a766b7..ceff3cc937ad 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
 		priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
+		if (!priv->rx_skbs[i])
+			return -ENOMEM;
+
 		/* 8byte status vector + 3quad padding + 2byte padding,
 		 * to put data on 64bit aligned boundary */
 		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);
-- 
2.25.1

