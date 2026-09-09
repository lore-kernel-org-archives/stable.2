Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF25374E60
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974273; cv=none; b=morQPASo9TV2LtymXz1XhlJxdcYQDGL06JJQXr2JGvGmf4gaemIxH39Jt2IhiVurfY+l9W9YRHTjWK8Aw4V8HB9ZWbdRtbVutMjZvBR1d6GdD/8lS0rEhBpG/202OZwEKa8NxD2k+F+tqN4rJgD+gzxj39TLrze2bzJViOVNL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974273; c=relaxed/simple;
	bh=Eb5cVPbGVjeB/35qdL87zK8KQlxRtYt2HCEHzq4xZc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2UHmKlz6s5wg6GpGoOR7lMoLCse7qORD1shI3eK6v3P0rfDGh4VSIF/cyVxjN9BFCPE8q2I1+o6BgT/FIIWg/VqAGTlZ3SkbJRl57T0O9vdKfenLDiYopu9ywQW667Lx7O4cQ/200MT9pNKagPTNnbLqz+Fl4cwtuXpfpgQiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcXOb17s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcXOb17s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C0B1F0089A;
	Wed,  9 Sep 2026 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974270;
	bh=tW4U37eeafwOjrLh+mqjE71cpcMgCDFKUjsDD5sTEAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcXOb17slnObqfxuzAL3+fpwMnwqXfQkmeTPb68ifJJUvAvIYec2T45fNGmymwYmT
	 yI3lLjzQN+7qrX7XQphp3pB31BsL9L19bI9O9HLMiUPmCacOWAxwWp2jJxjj3oj567
	 ZTZ3CV1LJg3PKYUBL1CyNXK2d0E8S2NK+XiSNaYE2/SNgeqKSUm+u/crbb9e0QwZ0K
	 gJuQuT1GEFkro4CSjfciUiyBY8nWI5VLdrDFYM3uFLu61NJDJwMwWDZbZsbDzpKYHO
	 TWI6VdJ2CYD3yC1+yZYZmZFm5gu6Jfb5VrOXMALyNBFjA8+54he8/QZHkbm3J2a1NQ
	 yJuNuujo1PaZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] net: ravb: Get rid of the temporary variable irq
Date: Wed,  9 Sep 2026 13:17:41 -0400
Message-ID: <20260909171743.3248398-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171743.3248398-1-sashal@kernel.org>
References: <2026090333-magnolia-munchkin-24b0@gregkh>
 <20260909171743.3248398-1-sashal@kernel.org>
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
index 0da019d1a2fd5..e13bf0a0f312a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2595,24 +2595,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
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
 
@@ -2624,7 +2627,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2647,28 +2650,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
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

