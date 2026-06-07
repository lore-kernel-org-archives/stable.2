Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E02D73A0
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861056; cv=none; b=HTWW2hWeOrm9ttvp4QUQ2Zn/TTPazmVtRU2g3uo5DbAzeEbjAdC3vbP6eQDxk1okV7g05NXYJDqwniXyWBP7LfaeBjuDXkoCp1z7lOSJ1ZqQ8nX8K3wwPnIDZ/afVd5LPaytxQt7U9UNduLQ/lJTPOz7T7+EhU8ubL+jmEcHDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861056; c=relaxed/simple;
	bh=TzvQakJ1S+Nsey6Vt7ynoW4v8ZmbADwjeVvQIRX45Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYocfoVvoalZaXT0TsEM/CESR7cvto+/omUG+LUiNPA4eo54RVS2cQ/7YgW9+3tIPJ5C4hSlJHlALVdqg4Djx8yOcQ2/OjnvvumQg17qxaQat/NmQ+4ahofy8EvKhZyJD84NNa2u90X8hkyau3ZYRmFp3BxMKjg9OHE/dUHL6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV0yGyrp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV0yGyrp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so2450115b3a.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780861054; x=1781465854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kewoD/JaIrVG2iWe454sEs6y3jw5rtHEnURmpvnmVNo=;
        b=PV0yGyrpIRRgZpF/C70DQA8rz8caUKzHVIpLeIMhltfxKUTlICTRqp5JwcfHc15Z31
         EkBaGji9UUXohJyMn+OmOb2jPhuhrgE30xbq5uBM8h641M1UmYz9RqtyaKJIPgOyn+XV
         vpBZgd3AUQltCeKsAUVoXELlRbP0Qm6hvAXbwvGodUuj7qlZT7WldqAC3rzCJTmGPmOA
         vEL3lrlCmRIdxs1Q+VHpzzSIyQzEuQK4piJu40kELE0hrd/mXskPIyIXpycX5TG0gLA5
         V06IauUZBcIj5HDeSvl47JXz4UpcVvd9IaFNqYvPnzVYgmeYiFE2T1DTBu2D6IGLhF+3
         3sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780861054; x=1781465854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kewoD/JaIrVG2iWe454sEs6y3jw5rtHEnURmpvnmVNo=;
        b=I0xlV5S7k7lGViYQKqle53iVw2N6JLe349FHcvSL3QCaVsd7r+Lx2/xRGLalO6HUWA
         wq3xLHFz6GOjfwIlS4h9UjXBTDojOVq3sZgRa7HnE5lgRaD6mXkbHtW8zkvEhiIHdLyS
         YLHK1YRO5Oec6wuK7phMisONWzVhnR8D6wAfWb5epVMiszoyX3UPsiMxcA1JDWS7xVpP
         qFbBmrQUmRiRqrOX43NdXqcDmUXPRKJztopKGZTq3NgsWUlKYGfQzv/euw1BI3lnBqGv
         F05sSXn+UshSDtuR4FYuKtF+t8X4E0vLOX0i+ZbVbgj1XDrMxELuSzc4BB3qerXXkYKh
         4wWQ==
X-Forwarded-Encrypted: i=1; AFNElJ99rejAkXp8b7wvRihjNQTPuAimVMkiCB05hDpK94tOeTv6VEqNW8dfLF+viRnREOTIK/2BoMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGOHxvm6jCpbH0Dq/6ltpOBAikQ6BlobS+1CSn2ynR3Dr15JN
	FdCFBuhI+qN0LjgcH/6lBdudP+RPG73ciwdlM/8egNjcL4UpoRZ75rak
X-Gm-Gg: Acq92OELffngbCgP+DV+4RM/oTBHHy+4q3PXCi/be3jHxa2XHTr/dhdY6TqJNG7n44n
	2SGNEjfaIa78tBiqVypFw/yeCB551pmsZE6xIk86gthw/crj8lYStQJiUL+WuRR0KinD3oQ2MRD
	YPbK75buhpO2LTcfZyTbOET9lIejo1ttV7ERTQbJyGIzGCthrgalOzxLZtvA4vQBwm58Nfi4DOY
	1P3RY2oMjwUk4eCEVFgFTCK6S8xmzLF+NtDU4mCdoc+xfrHl4KV37SotN64055jpwjXgG1MxnQY
	SW5Ao5eyYStbd1dWVlN3+uz3jxtepzuY+ERDh4IYzDTwGL4LhuMQkF0fuk/zU81c5CIoUiDNQdH
	3AyFJC9rIARnKl0TmN+S/fqgzZqfAUlBjU1X9E+Ar1wPTeG/gVc3YY1N76hW+34/Xsu2+R7KkPz
	h+MzQFUUJuk/1njBHgyk3SdaWhftDL8wJacq1atVLnYvYpIiqKCJkj0nkW9TAPdiVJ/037ppGE
X-Received: by 2002:a05:6a00:1da3:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-842b0dafd4bmr12422704b3a.22.1780861054230;
        Sun, 07 Jun 2026 12:37:34 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm15429233b3a.28.2026.06.07.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:37:33 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in probe
Date: Mon,  8 Jun 2026 01:07:11 +0530
Message-Id: <20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spl2sw_probe() acquires three of_node references that are never properly
released in all paths:

  - eth_ports_np from of_get_child_by_name() leaks on every probe.
  - port_np returned from spl2sw_get_eth_child_node() (which exits a
    for_each_child_of_node() loop mid-iteration) leaks per loop pass.
  - phy_np from of_parse_phandle() leaks on the -EPROBE_DEFER and
    spl2sw_init_netdev() failure goto paths, and the registered netdev's
    mac->phy_node is not released on the out_unregister_dev cleanup path.

Convert eth_ports_np and port_np to scoped __free(device_node), add
explicit of_node_put(phy_np) on the two early-error gotos where
ownership has not yet been transferred to mac->phy_node, and release
each registered ndev's mac->phy_node in the out_unregister_dev loop
before unregister_netdev().

The mac->phy_node release in the normal driver-remove path is handled
by the preceding fix to spl2sw_phy_remove().

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 5e0e4c9ecbb0..d78bda050ee4 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -319,10 +319,8 @@ static struct device_node *spl2sw_get_eth_child_node(struct device_node *ether_n
 
 static int spl2sw_probe(struct platform_device *pdev)
 {
-	struct device_node *eth_ports_np;
-	struct device_node *port_np;
+	struct device_node *eth_ports_np __free(device_node) = NULL;
 	struct spl2sw_common *comm;
-	struct device_node *phy_np;
 	phy_interface_t phy_mode;
 	struct net_device *ndev;
 	struct spl2sw_mac *mac;
@@ -418,8 +416,10 @@ static int spl2sw_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++) {
-		/* Get port@i of node ethernet-ports. */
-		port_np = spl2sw_get_eth_child_node(eth_ports_np, i);
+		struct device_node *port_np __free(device_node) =
+			spl2sw_get_eth_child_node(eth_ports_np, i);
+		struct device_node *phy_np;
+
 		if (!port_np)
 			continue;
 
@@ -441,6 +441,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 		/* Get mac-address from nvmem. */
 		ret = spl2sw_nvmem_get_mac_address(&pdev->dev, port_np, mac_addr);
 		if (ret == -EPROBE_DEFER) {
+			of_node_put(phy_np);
 			goto out_unregister_dev;
 		} else if (ret) {
 			dev_info(&pdev->dev, "Generate a random mac address!\n");
@@ -449,8 +450,10 @@ static int spl2sw_probe(struct platform_device *pdev)
 
 		/* Initialize the net device. */
 		ret = spl2sw_init_netdev(pdev, mac_addr, &ndev);
-		if (ret)
+		if (ret) {
+			of_node_put(phy_np);
 			goto out_unregister_dev;
+		}
 
 		ndev->irq = irq;
 		comm->ndev[i] = ndev;
@@ -500,8 +503,11 @@ static int spl2sw_probe(struct platform_device *pdev)
 
 out_unregister_dev:
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
-		if (comm->ndev[i])
+		if (comm->ndev[i]) {
+			mac = netdev_priv(comm->ndev[i]);
+			of_node_put(mac->phy_node);
 			unregister_netdev(comm->ndev[i]);
+		}
 
 out_free_mdio:
 	spl2sw_mdio_remove(comm);
-- 
2.25.1

