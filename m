Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757A36A340
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974081; cv=none; b=e+9xqLmc6cThmKnWTFZJ0ZHnZZojnphrS/dXd1jo45k1wci0DnDBKg5gPxeS7htg2kD2dczEMIczC/1p/vM/ZkWwIeH0CPabQq9VFvS7ubh2HiQzWl0UnKxup35knvS8rDXqnX2A3EnOl5lOtpQzFp2b9e5AtTxX/DopqF0G6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974081; c=relaxed/simple;
	bh=18ejlzSP3P/Lp0sedpuyrQQBe2wylC3BZ/MSrmSwAqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUNEigRxMi8K1w5nAYrV5XVEV97pNciXBt2SfwhAxFo/lxSSeH2rodqN6Cn14eBBedZiXIoCgGTAjlYRXGLms0xho73Ez5hG06hv/iTYyUyVSxXsc4zx/uYJ1+ZcO4su0j7iLIgLz1hCUPcddak0q4B/BJBaAkU0fVmaSh4xw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/r/R30m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/r/R30m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC441F00899;
	Wed,  9 Sep 2026 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974077;
	bh=ZA4+bc4UhL1PDADr/nl4IwSax8OvFMcoYmD+hHp0lpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/r/R30mnzovZydVMhS75euu3rPx7krlw7EIehlXVX7fNeE0XZYZT3NO1TAuZU/ay
	 TgMHyLCPmfxgEcKMlFftRazUcrV9US1Qg0hVeuXo3/tGm1CRwd+32h1L54KGwt+4j0
	 pHp+dPetuyJlWli9G0KwtQyvMyPV3vwZviEj81PRjrVXDW5VLBGgWI3JH6ey14bcJ0
	 wMUjEeyeT+Tzm+Z5o/AWkFFL+qAZ/H2laSrtQC0Q33lqmImOXwuMhQRlXhfEEUQueX
	 Y9CqFpxV9YMjwihg2a73K7/IRExHpf6ZCU+eoS/QojQOaevV5lZ9ybj/JS6WK8AZh6
	 VRhxqXNIx+9ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] net: ravb: Get rid of the temporary variable irq
Date: Wed,  9 Sep 2026 13:14:28 -0400
Message-ID: <20260909171431.3234845-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171431.3234845-1-sashal@kernel.org>
References: <2026090333-maroon-numerate-89b5@gregkh>
 <20260909171431.3234845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit a260f080660ef8bac97404dd0b9ddbe35a608426 ]

The 4th argument of ravb_setup_irq() is used to save the IRQ number that
will be further used by the driver code. Not all ravb_setup_irqs() calls
need to save the IRQ number. The previous code used to pass a dummy
variable as the 4th argument in case the IRQ is not needed for further
usage. That is not necessary as the code from ravb_setup_irq() can detect
by itself if the IRQ needs to be saved. Thus, get rid of the code that is
not needed.

Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4332e0ac220cd..35b58ffb5c2d6 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2579,24 +2579,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	struct device *dev = &pdev->dev;
 	const char *dev_name;
 	unsigned long flags;
-	int error;
+	int error, irq_num;
 
 	if (irq_name) {
 		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
 		if (!dev_name)
 			return -ENOMEM;
 
-		*irq = platform_get_irq_byname(pdev, irq_name);
+		irq_num = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
 		dev_name = ndev->name;
-		*irq = platform_get_irq(pdev, 0);
+		irq_num = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
-	if (*irq < 0)
-		return *irq;
+	if (irq_num < 0)
+		return irq_num;
+
+	if (irq)
+		*irq = irq_num;
 
-	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	error = devm_request_irq(dev, irq_num, handler, flags, dev_name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
 
@@ -2608,7 +2611,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2631,28 +2634,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 		return error;
 
 	if (info->err_mgmt_irqs) {
-		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "err_a", "err_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 
-		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 	}
 
-	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", NULL, ravb_nc_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", NULL, ravb_nc_interrupt);
 }
 
 static void ravb_set_delay_mode(struct net_device *ndev)
-- 
2.53.0

