Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824463;
	b=z6vYhMS3I7J45+lowHDbD6kq7ZD6IaoJmPxgtXmCPKDnkO+NNd82JgaCmhH3ja7y6oGD
	 dwMRkWCxvHqKCgnACzUxORAknGO8uzPx2IF84Nh2R7yuEsjl7DKwBvCVBCrpotlGNJpLm
	 Eav3qhPtdoQduOMJ5i9JOg6TibBdMcALXokmzFD2BOzAgErage/oG+qInGp16iGjo0bpG
	 QZlap64L8m2R8ayNzc4ULE5QnWCex3XUcDwKBszBp/MW/ji/mepsABd84McygWnfL47IG
	 10UcGF3Trvsm9dwmPioGdaZpUhVD3WsAKpNzooKsf4BAVdjQe6pZCcZwg/TPxPfkWQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SxIivNZ+9KiyN6EmpZyE1RW59DxCo02JyWpOC/Q+cOw=;
	b=Ox90kozHJ8UkNXp17HP9rQkOX6u7pHty6ir0LpnMw97boeDpy1ohUV8uYMKRkFGpdWQ1
	 Lm2MLUmpwcL0gJlE/DhmqOt1hMBs7S4jJ0P7r4m3iU3xclWbTLfOZkqO7NadX0xzO6pWm
	 ijMh2Uj7eqr7CmriTbVxNpWuij0k86a/Ru6LqD/3M78JOc2xvw+uPU0zhnl2s4I/Megmy
	 Ve+lgFNl/aEt//SlobOQtmuZ6gYTE3AIRW9hgox34FrcW5K3btsiWFpkHeEUO9YZJDZmx
	 SIiJAyMth6hxrzfqNXPndXtudiPVj6mbTCA2KvloGAnFv+W1RdlZiMLT/J6+St9CxWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKKQKGDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F7606A31C;
	Mon, 16 Nov 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKKQKGDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA5F1F000C5;
	Mon, 16 Nov 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824462;
	bh=SxIivNZ+9KiyN6EmpZyE1RW59DxCo02JyWpOC/Q+cOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKKQKGDGy9oy9xQcqkbwhTrW1qQjPxqOw9JGN2dl9aI1inXvxF/mPRKJfq56hntBH
	 QNq9QjWcIhs15K4W8LWYrPMqckCjO3yxmeQQqJrW+8eTKSqg/gxk81ZnCyqdko2Acu
	 fYrbQhsIk67Vdikvo10kg61PRJprw/D+8ALucbpw+0iYGp9+5ety0Xb82XM5+QJYgK
	 OB2NJakZVRKI24IuWqSeyjp2opzGRIm4mGkOFP3JzX9c8RpGQdN8B0JnXrIPA+PG2n
	 /7eS0a2VEb1v0J5gZ6TdcHO6tnkLNsamLvK4IpWKXuFe+qr0TjFAiJANsu641S7sWo
	 KrAKVMZtu95pw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/2] net: sgi: ioc3-eth: set platform drvdata in probe
Date: Mon, 16 Nov 2026 11:19:33 +0100
Message-ID: <20261116101934.25910-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116101934.25910-1-kaloz@kernel.org>
References: <20261116101934.25910-1-kaloz@kernel.org>
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

ioc3eth_remove() fetches the net_device with platform_get_drvdata(),
but probe never stores it, so unbinding the device oopses in
unregister_netdev().

Reproduced and tested on an SGI Fuel.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179473760071.2199510.16065103101920438822@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 009f37105eaf..ee284a4f75ff 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -848,6 +848,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
+	platform_set_drvdata(pdev, dev);
 
 	ip = netdev_priv(dev);
 	ip->dma_dev = pdev->dev.parent;
-- 
2.47.3

