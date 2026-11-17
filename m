Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926737;
	b=VDXhCGxtWhcKx8vcjgrg+jE6zN0zEoa5PGllj5BTCPATT+6c5z7DnhIXO9aLRtfB0oKN
	 1mjP/Y/P7YB+eQ9uQPrVuBQe6gNbSI18XmZhoKSq8/dDamoMvnXDYixYaZCcOCdR53cu5
	 L2yU7Ipe6YTo34ySmwsWfo67K2LshrYNTUqevGO793aGKjWkqjqLjBseW5PCQbv4LHYzO
	 k8aGcSasCG6YfJyKsCA5vUPVteJCE58b5pBn8GGZU66SFbEIPDxYFkWvpWThy/Ro31Y9t
	 2FCkWnhkLGkpAp2+wy+dclbzS1hPLZki2xufxUGSesGFuKHGwL9gcaVyvgzeyR22Fkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926737;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=AhzMQ2E3g/vRFX15pwJIjwTP95X1ccIWcj1om489vX4=;
	b=dFs401V+1gjx6T86+xuvG6rXTwKTxejnRAWe4CluR/5hLk9Bn0E9Bf6Z8ojKJym14LOH
	 RFNJJZ0BXUhWuPy7ybqqPLaHQqMtlgY/q9tEusN/+iqDnh8FJr3447DujbkhxOfh9kHiN
	 esQ24DQkWRrBhVzJxxfhDG4/6g6Wrv2OY15zw18f+wPWRvyA74T3Nnj1wWe1Up1RvrD+j
	 Fro+P+A6Pcrq/68yGJGSgQHAPFFFvulevaT5BsY59xa/ZdXhvlpAUKFxAOJ0efYh44jAG
	 OAOSnA0JgWua5CnqIi/dyn9JgNEaG14niqiUZSqWRVDBZxZHMgg+YprWHbsaeeaLBzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eWWleW+P;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232BC606A330;
	Tue, 17 Nov 2026 14:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 232BC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eWWleW+P
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55020e792;
	Tue, 17 Nov 2026 22:45:20 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Boon Khai Ng <boon.khai.ng@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: emaclite: Fix potential use-after-free during removal
Date: Tue, 17 Nov 2026 22:45:18 +0800
Message-ID: <20261117-571e631490-net-2@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117-571e631490-net-0@mail.sdu.edu.cn>
References: <20261117-571e631490-net-0@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e9f8329d03a1kunm6b1ed508156203
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT05MVkoZT0tKSkIfHkweS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=eWWleW+Prxyyl6CPBnxsU9TR71Ot0NZcypj/qxve1DKhKKW2H/JHeYZLe7vD/CyQkXjFnOn7YAoYMQIpTpQbD7k2QrQPX5lkhA4luIo5z1ogKSC+1sDVt+fJ3cCvlsHs6n/0W7c3eEKbO0vFLJYwItp+K0Jaf4JyCxPnF4nVwTw=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=AhzMQ2E3g/vRFX15pwJIjwTP95X1ccIWcj1om489vX4=;
	h=date:mime-version:subject:message-id:from;

xemaclite_of_remove() frees the MDIO bus before unregistering the
network device. If the interface is up, unregister_netdev() calls
xemaclite_close(), whose phy_disconnect() still accesses that bus.
This can cause a use-after-free during PHY detachment.

Unregister the network device first so that PHY detachment finishes
before the MDIO bus is unregistered and freed.

This issue was found by our static analysis tool under development.

Fixes: 27cad0084066 ("net: emaclite: Fix MDIO bus unregister bug")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 4719d40a63ba..008e3d1e2981 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1189,6 +1189,8 @@ static void xemaclite_of_remove(struct platform_device *of_dev)
 
 	struct net_local *lp = netdev_priv(ndev);
 
+	unregister_netdev(ndev);
+
 	/* Un-register the mii_bus, if configured */
 	if (lp->mii_bus) {
 		mdiobus_unregister(lp->mii_bus);
@@ -1196,8 +1198,6 @@ static void xemaclite_of_remove(struct platform_device *of_dev)
 		lp->mii_bus = NULL;
 	}
 
-	unregister_netdev(ndev);
-
 	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
 }
-- 
2.43.0

