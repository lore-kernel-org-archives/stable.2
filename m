Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528730;
	b=wRKhfdLzqF41HJMWinoBc8mM2gbxXRonwY10hv9N4ecjKBdnJv34T+rY2I3M4dbX5Zb+
	 HAJHGrQS0uFCWsQI69LG+96b36yUFqANWwGzW5bo4hKeyEYvG0+P/BttHwuFr97ujlN2R
	 KzDb1I/1JyVo/8DT1CELJWPiyAJTyLvhg3TxJ1i0xfq5Ck9JMQvHDeVQlQp0p9DBygdZO
	 XurRb/4+NWNAXldh1qegRKCbclc/oDi5CwMGLHVf+HhlaKMPVnRFEZKdZUxOKBVlijTQN
	 xcvG/OYRw/dvJUOY6UVdLssF5KVXhfxr3rKQboWXalmd9UbVrGvkgR6n86pmYv8yQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528730;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=xyKoEJ5FjRS+4OPkOgOKrVMWDVJZ2fDT0agRmE2qKng=;
	b=k0gL4hGm43SChkQ2hGAvrxs4r3V24SZmuDRB3COOR8Sfty/VlZ+H2vG2yAUk6nck9+bk
	 xHtoTdNF3diyOoDaszNaAgwOLdxIcGxOinjv9J0h2+yZ1HCm1i2K8Q5koxnEherAthkTU
	 QVvIQx38jRhXfnb2CmddLRqIcdGHL7iyB20Ri+ly+n9+OtsHwY/RmIJwsOlc4qh31lZkw
	 35/s/0eGAppLVDe0uuUNnRoF2mucZudHVuJg5QZjjpPlwUsOALXufLqCIRmU8+e3PSO7u
	 zeTavRQlHUJ5z2t49AXYfCx4fum8gbC+2xmSDXytXB6n/P8FTftPqdelIGGdVuolQcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PGd1cMaw;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B085606A336;
	Tue, 24 Nov 2026 13:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B085606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PGd1cMaw
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb9d;
	Tue, 24 Nov 2026 21:58:38 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mfd: palmas: Fix potential IRQ action leaks on removal
Date: Tue, 24 Nov 2026 21:58:36 +0800
Message-ID: <20261124135836.2275740-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa20dd9f85003a1kunm03365dc23424a0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR9PVh8eQx9MGk9MQkpOTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=PGd1cMawoZKsYb1f8JOOvPrGsuoUmw7ompaf472pTRs1ui73niardRRuwKnJJvNZjoh8ZvcN3rpV897sok8USV+nToGwNU92cdikbMx4Dy+ZSqpe3HEs19+bpnUVOodpypMNm+fvLm+EDm1s23RcjZ1lyYxz3Glu1TPPk+I/onE=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=xyKoEJ5FjRS+4OPkOgOKrVMWDVJZ2fDT0agRmE2qKng=;
	h=date:mime-version:subject:message-id:from;

The remove callback deletes the IRQ chip before managed OF children
are removed. Their later free_irq() calls cannot find the disposed IRQ
descriptors, potentially leaking interrupt actions.

Use managed registration for the IRQ chip and auxiliary I2C clients so
the children are removed first. Manage the power-off handler cleanup
as well and drop the remove callback and explicit error unwinding.

This issue was found by our static analysis tool under development.

Fixes: 124e9deb1c40 ("mfd: palmas: Use devm_of_platform_populate()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Use managed IRQ-chip and auxiliary I2C-client registration.
    Manage the power-off cleanup as well and remove the remove callback.

 drivers/mfd/palmas.c | 74 +++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 00332bd4f1c6..14ca8c05f35b 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -463,6 +463,14 @@ static void palmas_power_off(void)
 				__func__, ret);
 }
 
+static void palmas_clear_power_off(void *data)
+{
+	if (palmas_dev == data) {
+		pm_power_off = NULL;
+		palmas_dev = NULL;
+	}
+}
+
 struct palmas_driver_data {
 	unsigned int features;
 	const struct regmap_irq_chip *irq_chip;
@@ -520,14 +528,14 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 		if (i == 0)
 			palmas->i2c_clients[i] = i2c;
 		else {
-			palmas->i2c_clients[i] =
-					i2c_new_dummy_device(i2c->adapter,
-							i2c->addr + i);
+			palmas->i2c_clients[i] = devm_i2c_new_dummy_device(&i2c->dev,
+									   i2c->adapter,
+									   i2c->addr + i);
 			if (IS_ERR(palmas->i2c_clients[i])) {
 				dev_err(palmas->dev,
 					"can't attach client %d\n", i);
 				ret = PTR_ERR(palmas->i2c_clients[i]);
-				goto err_i2c;
+				return ret;
 			}
 			palmas->i2c_clients[i]->dev.of_node = of_node_get(node);
 		}
@@ -538,7 +546,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 			dev_err(palmas->dev,
 				"Failed to allocate regmap %d, err: %d\n",
 				i, ret);
-			goto err_i2c;
+			return ret;
 		}
 	}
 
@@ -557,7 +565,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 			reg);
 	if (ret < 0) {
 		dev_err(palmas->dev, "POLARITY_CTRL update failed: %d\n", ret);
-		goto err_i2c;
+		return ret;
 	}
 
 	/* Change IRQ into clear on read mode for efficiency */
@@ -567,11 +575,11 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 
 	regmap_write(palmas->regmap[slave], addr, reg);
 
-	ret = regmap_add_irq_chip(palmas->regmap[slave], palmas->irq,
-				  IRQF_ONESHOT | pdata->irq_flags, 0,
-				  driver_data->irq_chip, &palmas->irq_data);
+	ret = devm_regmap_add_irq_chip(&i2c->dev, palmas->regmap[slave],
+				       palmas->irq, IRQF_ONESHOT | pdata->irq_flags,
+				       0, driver_data->irq_chip, &palmas->irq_data);
 	if (ret < 0)
-		goto err_i2c;
+		return ret;
 
 no_irq:
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
@@ -582,11 +590,11 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 		reg = pdata->pad1;
 		ret = regmap_write(palmas->regmap[slave], addr, reg);
 		if (ret)
-			goto err_irq;
+			return ret;
 	} else {
 		ret = regmap_read(palmas->regmap[slave], addr, &reg);
 		if (ret)
-			goto err_irq;
+			return ret;
 	}
 
 	if (!(reg & PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_0))
@@ -617,11 +625,11 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 		reg = pdata->pad2;
 		ret = regmap_write(palmas->regmap[slave], addr, reg);
 		if (ret)
-			goto err_irq;
+			return ret;
 	} else {
 		ret = regmap_read(palmas->regmap[slave], addr, &reg);
 		if (ret)
-			goto err_irq;
+			return ret;
 	}
 
 	if (!(reg & PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_4))
@@ -644,7 +652,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 
 	ret = regmap_write(palmas->regmap[slave], addr, reg);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	/*
 	 * If we are probing with DT do this the DT way and return here
@@ -652,42 +660,17 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 	 */
 	if (node) {
 		ret = devm_of_platform_populate(&i2c->dev);
-		if (ret < 0) {
-			goto err_irq;
-		} else if (pdata->pm_off && !pm_power_off) {
+		if (ret < 0)
+			return ret;
+		if (pdata->pm_off && !pm_power_off) {
 			palmas_dev = palmas;
 			pm_power_off = palmas_power_off;
+			ret = devm_add_action_or_reset(&i2c->dev,
+						       palmas_clear_power_off, palmas);
 		}
 	}
 
 	return ret;
-
-err_irq:
-	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
-err_i2c:
-	for (i = 1; i < PALMAS_NUM_CLIENTS; i++) {
-		if (palmas->i2c_clients[i])
-			i2c_unregister_device(palmas->i2c_clients[i]);
-	}
-	return ret;
-}
-
-static void palmas_i2c_remove(struct i2c_client *i2c)
-{
-	struct palmas *palmas = i2c_get_clientdata(i2c);
-	int i;
-
-	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
-
-	for (i = 1; i < PALMAS_NUM_CLIENTS; i++) {
-		if (palmas->i2c_clients[i])
-			i2c_unregister_device(palmas->i2c_clients[i]);
-	}
-
-	if (palmas == palmas_dev) {
-		pm_power_off = NULL;
-		palmas_dev = NULL;
-	}
 }
 
 static const struct of_device_id of_palmas_match_tbl[] = {
@@ -713,7 +696,6 @@ static struct i2c_driver palmas_i2c_driver = {
 		   .of_match_table = of_palmas_match_tbl,
 	},
 	.probe = palmas_i2c_probe,
-	.remove = palmas_i2c_remove,
 	.id_table = palmas_i2c_id,
 };
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

