Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921963A3812
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258937; cv=none; b=V/Ul/rc4KwHz4NEp72vkZkiiepZi4TNZgMAY9P2a0hRTxC3OK1bwXHrLR7SASoGtC08hC1+BCzJcqJJPpPBm4pzqZWEWtnu4PNzRfGOW8CV+0qUwxAapXaOzmZJ5pH8eIozj4TEuoAlRdfo6V5ead+zAqyt83aYk29w1xLK8yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258937; c=relaxed/simple;
	bh=q8w1cjiyi3fDD815Skn6IVMXnxAr33vK4QwsZzCK9+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJC+NSQoTkrkxwNw0xlEcTfS1QqWd7Ho9QiZT73wwhiq8J2UHJ15+7ratBpRIh9rK3TM2Wyrb5Ucq5AFiTZGuEOBx1HRcXFZgnWtr5/Q5aLCvbYWKCcUBxWmlXendMrOTZ+sKlWYmOvpT2goR137iADkVgmsm9icR7WDMEg4uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgQo3S3r; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgQo3S3r"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so74989a91.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258936; x=1785863736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3AEn2faIvWQU4bHNGW5bAFp90KH6oE1JBVI6F9Tu/c=;
        b=WgQo3S3r6Z6ue6iqPBQY6sqnUUJbUYDWCdps1gVM1vHHIRYYRO7oQadKoKmUjKo/Fa
         gBUmunE0A/eK+Bf4AOBdZpghVaQv6/ynx+YZvTO7Q7w8ubVmOVSnTO/7U70ykcHt6Bn7
         V1+o064Tlbjh6NSMuyiLP87lG4omvDgSU/oTenv6+3V/Ze30b2ClbGbPFjcZcpqeyRRL
         FgSYmMnauK2bqgQdgrUhqvWD8nlwYmca8iZG+FUosX7f8nogz5hW4YNOILe1fwraymfF
         CwPj4QK+nq1NC8WovNSUDGNA6Iz6Bg753U2XkjqzDyEDTaI/3+PyMltTBez8C452wS4N
         b4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258936; x=1785863736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3AEn2faIvWQU4bHNGW5bAFp90KH6oE1JBVI6F9Tu/c=;
        b=oy6Hh/ZLkQdAEAjoBm+mQAbFqFqKVIxHHJNuhs5rAg4iAKjSNIVUOfSoSZHgXVVh6D
         bJ0zTyFvbFhPYRXqF+qZxbsQtFgg7nYU8h9Y/y3Yjk5hDToWwxWfenzk+PwfLjH3QeT1
         A8veEKJgmmLA9uwo+000Pfb9kFmsja3soz+Byy0M5ey8xso2qXrAcNo7xL+o42LwH3lH
         8UUFLqwkEI4QI5n9HmeI8x9H7tGjQ5DsaA99kpRAW4TrN/jkqpTeQzbGIZIcf/hr+O9c
         2nhDw/b8XTaByPSzRjCttLHfflYGsDj+/8j7arxGpPt2XcTooaSJi3njy0OQa6fuDpv5
         59Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrV6xLnVb+YCNzuCYgSqKMbQ+q69ukqIbmQVm1lrk7lELV4Urd9dXa4Pq1zVAxwXP+nXvwnsNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yzmN9VotIHMhwC5uVryQgSqQZoOpLc9Q+0Sg1k6gLGFnL/tY
	HKKOZyElsv6ebGp+2o49q2EG7W6mzfi4ZYiOVT6fO2zSRmUTIH/rzG8=
X-Gm-Gg: AR+sD11M1dHffyaFJQxB70jn6mjUCkSmGow6li6fMdQuL/AiGaPDOuMkNaD02hEQxI4
	99CjaVVNi78qTIT/+9eYwTRkdx+Cf14xAUUO9TAyh0Ybrt3v35gmo1VA5WWJq/C/vpmuLjcJICT
	PisEsi/i3Du3ExgzBoHBpuhbh9Hb1WxWWUe09BYWzWnzrr/uJTRvdF06iv9o4Rl5TfQr9QhAIa7
	VVvXp+OloNjoSd5sSps27EWyye8jWhMN2PvrK7hhMR+WXH2qT+sghMSLJ/xyVUTYPGTd/dDkWHo
	nD7mXdLp4cm3/+LjLmyV8Y98ef0+wMMIgJmiP9pNI9R2Hs1LkPiGfjARxSOmX+m1pGFgQeobmB4
	Qu0j8qsE2N5K6YNMt1v75lAcnz60pgYRIk4B7aQG2THEX61YXihD2wKsB/kMpsZTBPoB1VtAEON
	T/J07N4KYqQwNPyaGGqp6yAc1adMrx9R9jSexPMwL9Ntv/1yTeC3x+9gQm5KXwzlFjm/N2lJ5t9
	srs540eT1eD3ia+5oAiV0yi0g==
X-Received: by 2002:a17:90b:3945:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-38f6a33d8cemr3736659a91.4.1785258935722;
        Tue, 28 Jul 2026 10:15:35 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f2b9e35sm226215a91.14.2026.07.28.10.15.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:15:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] i2c: iop3xx: fix adapter and IRQ teardown
Date: Wed, 29 Jul 2026 02:15:27 +0900
Message-ID: <20260728171527.48275-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe path enables the controller and requests its IRQ before
registering the I2C adapter, but ignores an adapter registration
failure. The remove path also frees the IRQ data and unmaps its
registers without first unregistering the adapter or IRQ handler.

Check the adapter registration result and unwind the IRQ on failure.
On removal, unregister the adapter first, then quiesce the controller
and synchronize and release the IRQ before freeing its backing
resources.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/i2c/busses/i2c-iop3xx.c | 31 ++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-iop3xx.h |  1 +
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 4c67c5d18f..c375509c93 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -89,6 +89,16 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
 
+static void
+iop3xx_i2c_disable(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
+
+	cr &= ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+}
+
 static void
 iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
@@ -392,14 +402,10 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 	struct i2c_algo_iop3xx_data *adapter_data =
 		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	unsigned long cr = __raw_readl(adapter_data->ioaddr + CR_OFFSET);
 
-	/*
-	 * Disable the actual HW unit
-	 */
-	cr &= ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
-		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
-	__raw_writel(cr, adapter_data->ioaddr + CR_OFFSET);
+	i2c_del_adapter(padapter);
+	iop3xx_i2c_disable(adapter_data);
+	free_irq(adapter_data->irq, adapter_data);
 
 	iounmap(adapter_data->ioaddr);
 	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
@@ -467,6 +473,7 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 		ret = irq;
 		goto unmap;
 	}
+	adapter_data->irq = irq;
 	ret = request_irq(irq, iop3xx_i2c_irq_handler, 0,
 				pdev->name, adapter_data);
 
@@ -492,13 +499,19 @@ iop3xx_i2c_probe(struct platform_device *pdev)
 	iop3xx_i2c_reset(adapter_data);
 	iop3xx_i2c_enable(adapter_data);
 
-	platform_set_drvdata(pdev, new_adapter);
 	new_adapter->algo_data = adapter_data;
 
-	i2c_add_numbered_adapter(new_adapter);
+	ret = i2c_add_numbered_adapter(new_adapter);
+	if (ret)
+		goto disable;
+	platform_set_drvdata(pdev, new_adapter);
 
 	return 0;
 
+disable:
+	iop3xx_i2c_disable(adapter_data);
+	free_irq(adapter_data->irq, adapter_data);
+
 unmap:
 	iounmap(adapter_data->ioaddr);
 
diff --git a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
index 1435483355..6c07ea16bf 100644
--- a/drivers/i2c/busses/i2c-iop3xx.h
+++ b/drivers/i2c/busses/i2c-iop3xx.h
@@ -92,6 +92,7 @@ struct i2c_algo_iop3xx_data {
 	spinlock_t lock;
 	u32 SR_enabled, SR_received;
 	int id;
+	int irq;
 	struct gpio_desc *gpio_scl;
 	struct gpio_desc *gpio_sda;
 };
-- 
2.47.1
