Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190462;
	b=1Sok3fZw6gSJyIrh2qRWlWuydNBdNgv/75HF5T18xug0wqe9bApSGfj9wEXjF+oVSxIk
	 NqPqZUoU0Ob5up6dO3AQ6FRzsq/Uu2nMFBB3nPVG9I4O7wYPlEUIjnOq7lxbycUNphHtg
	 m6drWoqmXLx3xc6nffbXc00geBEeuJcjJdVOwUWfZFYk+yJdBxCKQTBYXc0+THkIUDi8L
	 5K18LbDVzQnvzugbJKf3UPKQueLdagYklP+HHWiolFO569HyGjALMgq84mGPeJugxkVdV
	 A67r23e/pdZz1DjlmkdJ3BmS2vcRqVfX5wiZPw/gwJ9NuVa/6O0GunaMDi9rgn7YLCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=uBZHDjcp8OHvO+9HMmytd8ayAJCp+xM1stb3TXPJ8UI=;
	b=2YX2WyKUIg0gW2CbQuFaJHL+W5KF4mafTg8Gr7wg0OMcbGfuLRGfXpsypCJD1SrScvBe
	 3Bfq7uA/JqInAShnS/MDrmX/145ILKrJP9OPlrnMPBVpjDjphzUK3CAcPSIwpMq+flplM
	 X54igwJBe0fCOX3I0L1bcSZnxSWZWrGiPOfM2IPsRaqDzf84InBEaqlKpotnzxDuhKjNK
	 hhkZ1kg7CqLIHYJJ5PvnKJ9PXmLsktf00ogFBHTs6Dv+3wNkUzWuijazO6D7oV/+o41GA
	 GwZpOtcfF62/fmfg+xMP060uK9MUsqjwAH0LknAxdwZx4Gyt/ZKz/0ugTUPJFKGyiKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4k51Ka8;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518B606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6518B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4k51Ka8
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4ad881b6517so880561fac.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190461; x=1795795261; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uBZHDjcp8OHvO+9HMmytd8ayAJCp+xM1stb3TXPJ8UI=;
        b=m4k51Ka8eU6xgJB0FiyfWWWXB69vi6/sEq6C8/NEdLlcSfvCwbegXzOw5x1U83KjDx
         xFccbe8sLrISZot5sGEjLfOiERpg6RC4+loGxtKDkPTcfqh7r0FiwejqMOVU6t08pGe8
         EsGwWh1f1WiEmhGf1TmDrtpSW1PG35N1nvQf5hYBxNsMbDKNEGQT3LiVfxTnjaYbRuky
         yZx4W4pJ56MlPte5itCwVH/etJ67VvE5ov67qGnSIwEkcoxK9jlBK9Y9n9paCz4NZjrD
         yK9f+sGXc/CmYA3IX/MjriafIkLO+HO7U0f1bj0/SnTjgwrrzV2dFD+hPFjTO9Aog+m2
         p5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190461; x=1795795261;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uBZHDjcp8OHvO+9HMmytd8ayAJCp+xM1stb3TXPJ8UI=;
        b=HP/u9UnUGIzFvmWWLIBa6FGouPZuZQ8wHl7TtP41CReGr8yeExB69XUUe+OMdUeo2h
         wSCA+wLpIy4gde3mdh6H7sViJruGQZYvUCHmhudoUs2E+U6Quxiya3Rh2Ix+/DHcrn+8
         AsdeOOYbp0UQZIb36A5tSelHvffVFy4BPUmPUEztznF7dHBdpA3/0lJGNXEXFYKeOT9W
         DynpT3khu7rKEXAp3J/lh68hW2LR+LkmhEMckiNazl5/653ghonwdgDFc/BdxA390B8f
         iWtH038wBwEYI7mQOBfdtAHJxmjZQNrbUVzRhyD/1YKEVKgqcpTwhiP8HhZVhQoO7ogr
         O7rw==
X-Forwarded-Encrypted: i=1; AL+hErHGdJEj/rRs0BLhnoYUcvaEpsR0fe5S29Fu4UP9+HTBL5y/PBzI2Hl27TlBCvp3/6MVQpBfP5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z90wK9XZtIgyU1Kx7EtpHw2mDGQXG/aUtI/mqmygObJ3rMYwV3h
	u0NLZDsTl1+HeEbxRbZ7st/H4GlOm4FC6XHxRKvUq6frZkqmN+UqMnIo
X-Gm-Gg: AZFdTZciErZT9pSYUqdNwd4dZqVdmrItGHoyXGyoONf/Ft+521x7fPD7YUaPBMqXpMq
	FJBkIQ16gG6MuWWCDB4J8Mpffzv5Bet6avKnj8QXRylglyLOITS+weEUAViMI8795ThMfyA0IpF
	egoCmj54X1Rhrc6g+VVCt0hngbp3JnSgNqyOcHyR/h5ysUMt2b6KpJozDapw4tfc6Q7m+0LjE8f
	jf6BBgVuXe+VCqEKGA3RkSQvhwW4L2W6FcPpnl8DT0CkGT6zbQKOtDrNWAEigQWH5uL8++VSeeO
	DvagBIssjIn1Vb+B5vMdX7X09D5EMqh5gw11KOn7dFqN3m4U5IEQgT2aEXrkYtYjpfMq+yoePwN
	EIf5llgfU1+bHr61ZYVHsx3zvpxTQMPgRfgZbmKd/24xMOlz5cn5rJqJmkTAhRyhxXlLplbbTCV
	C5oXSYhXm46K7TtPF0I6W9+63wV2OZ9jQ4IIjTba5CuLM5vXlaLkMz1/5S35Ee7fBMETWrH5kiu
	Ar0PjLO3ZGh/BxVrpbZp8tnO02wVxybBKm9PPI56+M3S9X4mOHUSgkajwjJNNu4gu1ZdTj7Co+a
	57XAA1xKFI6wgrd4RQMCVFaBubMZR2i2uMTJN8BpsnunNbFcm2UFAJ2ZUuEUlqG61V97eXUKc4I
	Mrhg9+/RozKgubQyvydXqO69twCQObvUpsJBduu4x+d4LuzHbZWGuKsJkoR77oZIWdtUOGTBBCf
	eWxL86iN10NeLIrXzoJIHT1wPM0x+fTt5OZbTthCyReKQukNc4z1M=
X-Received: by 2002:a05:6870:b93:b0:4a9:5bde:8484 with SMTP id 586e51a60fabf-4bc85402f1dmr3040217fac.51.1795190460802;
        Fri, 20 Nov 2026 08:01:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bd044fc4besm2161534fac.7.2026.11.20.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:01:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 09:00:53 -0700
Subject: [PATCH v2] mtd: rawnand: atmel: keep the HSMC clock on until the
 NFC IRQ is freed
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-submit-atmel-nand-irq-teardown-v1-v2-1-7460e7c8c163@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6doRSgujKexgXpR1hDC3aVtQQ7
 m6LcW8ymz9/8ubNzKMj9OyQzczhRJ5GG0O5yZjqpe0QSMfMyqKsOS924B+toQAyGBzASquB3B0
 CSqfHp4WJw2VflKLYKd7olkXOzeGFXuuP0/mbI+SKKiRwumilR2idtKpPKxN0nsi5xVdIfU8+j
 O69Sk48cX4+zR8+cTiIiteVUI1AFMfOSBq2ajTsvCzLByGyZ7cEAQAA
X-Change-ID: 20261107-submit-atmel-nand-irq-teardown-v1-f902307c18db
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

When the Atmel NAND driver is unbound on a system using the legacy DT
binding, another device on the shared interrupt line can still cause the
NFC handler to read registers after the HSMC clock has been disabled.
The remove callback turns off the clock, but devres releases the IRQ
only after the callback returns.

Register a clock cleanup action before requesting the IRQ. Devres then
drains the handler before disabling and releasing the clock, both on
removal and when probe fails after requesting the IRQ.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Use a devres action for clock cleanup so devres releases the IRQ first.
- Link to v1: https://patch.msgid.link/20261108-submit-atmel-nand-irq-teardown-v1-v1-1-341643c83ee3@gmail.com
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index b86d080bcb2c..ce5e13276d2e 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -263,9 +263,6 @@ struct atmel_hsmc_nand_controller {
 	struct completion complete;
 	u32 cfg;
 	int irq;
-
-	/* Only used when instantiating from legacy DT bindings. */
-	struct clk *clk;
 };
 
 static inline struct atmel_hsmc_nand_controller *
@@ -2151,6 +2148,14 @@ atmel_smc_nand_controller_init(struct atmel_smc_nand_controller *nc)
 	return 0;
 }
 
+static void atmel_hsmc_nand_clk_cleanup(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+}
+
 static int
 atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 {
@@ -2164,6 +2169,7 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	struct device_node *nand_np, *nfc_np;
 	void __iomem *iomem;
 	struct resource res;
+	struct clk *clk;
 	int ret;
 
 	nand_np = dev->of_node;
@@ -2173,41 +2179,46 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		return -ENODEV;
 	}
 
-	nc->clk = of_clk_get(nfc_np, 0);
-	if (IS_ERR(nc->clk)) {
-		ret = PTR_ERR(nc->clk);
+	clk = of_clk_get(nfc_np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
 		dev_err(dev, "Failed to retrieve HSMC clock (err = %d)\n",
 			ret);
 		goto out;
 	}
 
-	ret = clk_prepare_enable(nc->clk);
+	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable the HSMC clock (err = %d)\n",
 			ret);
-		goto out_put_clk;
+		clk_put(clk);
+		goto out;
 	}
 
+	ret = devm_add_action_or_reset(dev, atmel_hsmc_nand_clk_cleanup, clk);
+	if (ret)
+		goto out;
+
 	nc->irq = of_irq_get(nand_np, 0);
 	if (nc->irq <= 0) {
 		ret = nc->irq ?: -ENXIO;
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
 				ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	ret = of_address_to_resource(nfc_np, 0, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing NFC IO resource (err = %d)\n",
 			ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	iomem = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(iomem)) {
 		ret = PTR_ERR(iomem);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	regmap_conf.name = "nfc-io";
@@ -2217,20 +2228,20 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		ret = PTR_ERR(nc->io);
 		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
 			ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	ret = of_address_to_resource(nfc_np, 1, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing HSMC resource (err = %d)\n",
 			ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	iomem = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(iomem)) {
 		ret = PTR_ERR(iomem);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	regmap_conf.name = "smc";
@@ -2240,30 +2251,24 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		ret = PTR_ERR(nc->base.smc);
 		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
 			ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	ret = of_address_to_resource(nfc_np, 2, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing SRAM resource (err = %d)\n",
 			ret);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	nc->sram.virt = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(nc->sram.virt)) {
 		ret = PTR_ERR(nc->sram.virt);
-		goto out_disable_clk;
+		goto out;
 	}
 
 	nc->sram.dma = res.start;
 
-	goto out;
-
-out_disable_clk:
-	clk_disable_unprepare(nc->clk);
-out_put_clk:
-	clk_put(nc->clk);
 out:
 	of_node_put(nfc_np);
 
@@ -2345,11 +2350,6 @@ atmel_hsmc_nand_controller_remove(struct atmel_nand_controller *nc)
 			      (unsigned long)hsmc_nc->sram.virt,
 			      ATMEL_NFC_SRAM_SIZE);
 
-	if (hsmc_nc->clk) {
-		clk_disable_unprepare(hsmc_nc->clk);
-		clk_put(hsmc_nc->clk);
-	}
-
 	atmel_nand_controller_cleanup(nc);
 
 	return 0;

---
base-commit: ec1e844b9486302a488abc03ea918db60709766e
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
change-id: 20261107-submit-atmel-nand-irq-teardown-v1-f902307c18db

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

