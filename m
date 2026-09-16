Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66F3D6CB0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535793; cv=none; b=hfiAX5LoqFQmH8UibfrJ15UrBdV2kNOSQyn6eDYgr37D+Za3IhVi8Fe16vLJc+o/v0hnNrlWYywAd3eHlsH/uWYUHfeoyfP6bZgAG3urKQfIOtH8uq0TAXKTUIJKvBVCqFmkaz1qJRrgzzKwKe814buG12yh9B0Qvzg4wmLf14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535793; c=relaxed/simple;
	bh=uwmZUWNFubCxa2vYuasTSUVwkwVzc+oCbHAoSLSNBaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgsPkoIp27OoC9SBhwRYI2FsNPYGK/H8HUflGRORxHTJw5BZSH26sAKA903DVsF+dqEWzXUOY7RoIBHm0Q0X1/cUh6BBbAepMkbBCa/hq2uqA1KpiZCrUMdkci5df/olP2XlKmHCR8UEdtov6qPoLIJQkwLKgK/PS40mN2/L5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQHWVY/A; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQHWVY/A"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so419601a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535789; x=1790140589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVOHsi5wK8IUeKTXKaFBxVem+p3DhnYKQL8R4DBSpiI=;
        b=aQHWVY/ACJkqGvCQKrgzOSX/ich3frOvdLYx4A87x/LjEbpc2KlCkZ/qN5+u+I8mlI
         RoHDwxFu/xVIRxILPnctlFD4hpawi3Z7K0TLPk06w9oU89xNA5zOqPoQ7WFXqOUaH9VK
         /JQGH60jgVXujug0Sk/Xo5on/scCn9nlCbuOrI0spSfUNrw1SLa99OJwRrMBdQ2u+19r
         zNBy++L868jJobrNvE5R2/YVq6UNSoV5Dd9EPfA207n/Qm+n4U2NMAn278WB6HQN6ctX
         McWsvtQYRI4aBKghcvjtW7H5SBLd/1pzNaqfkq/KXOHk2tVdcHLShGzBVfiHf6kz0Z8r
         l1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535789; x=1790140589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVOHsi5wK8IUeKTXKaFBxVem+p3DhnYKQL8R4DBSpiI=;
        b=I5Lpk1pQHo/jE+20SKvc7MMFd1TLeogLyJr+1bhT0fosu3QtSUbMl8Bv/ZndhJf3UM
         eWGwJaMVm64e4dK+EY6wwJjsNYo9JuHDxGhG50tx1sShNRbeU3GIVgLwwMXPk3R0jxqw
         rix6hg+xgpzrVO5NGD16QBu7sWObQ82LqkoEZqqzN3C79oD7cnJLtPZZBxgSEhYV63ZQ
         Wyj/1trSO6c8J1XbGHlab+WBOfK46irO7MEBwqfjNVxqgnoucJt/ljGIBmwJ8Xqw8zu+
         cI0qy4cZE+KI8hfN4WGBp9GBz3En+hw249KpeNQjaEiKwlDH9HuSt6sh/A6G3KfTBUwc
         fOrg==
X-Forwarded-Encrypted: i=1; AKwUvBycCdzpZcMia1vYIo30cLl3gOO4itw/Z2nNUJqzSzOCuDEEVViRg4UF2W484VXv0qCC65ezMXw=@vger.kernel.org
X-Gm-Message-State: AFuF++lEieu8AlMm2DZ/ox6wjpbOS8AxFSeCEGRyJL/31qI4hZ7xaJ0K
	B2vYKIpoSFQPbfDeU2JR8DGeOo2Nz53QEO+LNIl4NBNYkB8Pd9A/TtOh
X-Gm-Gg: AYBFou0jgN07i6L/4jHshR++Zq2jlnCTRH38ywaQGQfcvTcF9wtKXAU5pMiRnLrItLD
	ZTH+/2h2gU0fitjJtNNbYwvaG8w50bkJ20AcPSL7gv6WxpPre9jgH9x1lxFrzZRkWor61DNxYk+
	AjxdnVz4Cve99C/9TuLk676lVsXD/wFFKS0zbLxKcr67kjaZSFC/6IiSjrQgrA3Hu6/jurgEYmT
	qnlB7r7ihbxO7aJqPYChrweVUBmuK/Qr3Y07l+uYFAdp+528A5xNh5ybCobMsBv/i5F6LRdaoiI
	9arfwA2fjrM4/Ne9bmmeGJqOK/mjr/pBI5arz7wgxeTB1jHkuR7kG6OoKsLSC4+WBMW8+2AT7Eh
	McS7NQdbNk64LOXhcjl3mZoarbZscdEVEiHqbPtNWuM90AnDb0NweZqNjEnvybVZHphWP/0YQkr
	stlc7x2sxvAcfdzDKQMOehaWANHJk5C4OktdQGXDg8J9LFzR8F0ygaPwx3NmQSeSUgnwRr
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39e1e5777famr3113557a91.23.1789535788375;
        Tue, 15 Sep 2026 22:16:28 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb22ee5sm2428218a91.5.2026.09.15.22.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:16:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: mediatek: fix PPE resource leak on remove
Date: Wed, 16 Sep 2026 13:16:18 +0800
Message-ID: <20260916051618.2904439-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_ppe_init() initializes the l2_flows rhashtable for each PPE
instance.

The probe failure path releases these resources with
mtk_ppe_deinit(). However, after a successful probe, mtk_remove()
tears down the network devices without calling mtk_ppe_deinit(),
leaving the PPE rhashtable resources allocated.

Call mtk_ppe_deinit() during device removal before freeing the network
devices.

This issue was found by manual code inspection.

Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..04d0a1eec4cf 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5394,6 +5394,7 @@ static void mtk_remove(struct platform_device *pdev)
 
 	netif_napi_del(&eth->tx_napi);
 	netif_napi_del(&eth->rx_napi);
+	mtk_ppe_deinit(eth);
 	mtk_cleanup(eth);
 	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
-- 
2.43.0

