Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B02E7376
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572709; cv=none; b=slKdZReMngHrrdYQPAvkKhCJVfz1NON2nsMOnXqWBU9C9j6GQ2M4LShJzPXmrozm0a1MeG0aQAwTjHAwCltLe/Pr6vbJfjN7uDnImA4GTKJyUhDLo5elLNrCRw/FF9vik4BdcMkP5gz/JU97+b6c6uV0VZLOG7aic2Uns8v++Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572709; c=relaxed/simple;
	bh=4imN6dewjqhFcB7XJgo0SvPWkNVNvVzWKsskIcIZ5vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKOSQBu78bMG7c+OmNT3QhpFVjZ+wV769yUQ+8hHWP+pjhxSdkxl1+6oCA39XvZYaWpRZKEechzhatOz/Yrz3QNvvh4HzLBAmoJPvgGo/U9EMYyTzZWKNwH/zOkErzUZZsUR7dvmJLXcKpZL4kxt4zbKGmd3MxDo0b+htnpzDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=TEw1hnD8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="TEw1hnD8"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C2ED82C05FB;
	Thu,  9 Jul 2026 16:51:36 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783572696;
	bh=/PLnxtqdm2Q7hB8MT88iT/3OGFchPxOauWRF0cLqMOU=;
	h=From:To:Cc:Subject:Date:From;
	b=TEw1hnD8BbSOuDppwVjjXV4972bxEvSqcp20/5llBxoUolCpg8oJrzFcBOsgS2/Xa
	 bvgaoxUwT1/oby92/Fu7YA2aNEl618bSKHY/rCGLGdmHkf2Y/0O/jiqpA6MPLzLPvZ
	 1W7N/jRAyQN7ratFT8Yg8umx/nic9d33/zYGg4s1h7AfagNA3Sqj8rgsVi27NO9Hb3
	 cy6cBxOQ43NImKVgdBQDEar9xvI3qlG2f4/H9Ayshhk/5qelPP6xULhseO6drYyhj9
	 g6wIDbiLp2LP+Zr+7VJus+SaNN9S+qSNz+bHN4ZjZSQRb5mTsvkIutknO9TcFVm2E/
	 TR38uSQ7K/Daw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a4f28d80000>; Thu, 09 Jul 2026 16:51:36 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9116E13EC4E;
	Thu,  9 Jul 2026 16:51:36 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id 8D23D409DC; Thu,  9 Jul 2026 16:51:36 +1200 (NZST)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: brgl@kernel.org,
	ian.ray@gehealthcare.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Thu,  9 Jul 2026 16:51:16 +1200
Message-ID: <20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a4f28d8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=RAioF0-LDSMA:10 a=VwQbUJbxAAAA:8 a=HDTP818q5T4t6XSuYIMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Locking is disabled in the regmap config as this driver uses its own
lock. This means that all calls to regmap functions (read or write) must
hold the i2c_lock. The function pca953x_irq_bus_sync_unlock() did not do
this, and it was therefore possible that multiple threads could cause an
incorrect register to be read/written.

A previous patch partly fixed this, but only protected the write to the
interrupt mask register, and not the read from the direction register.

Fixes: bfc6444b57dc ("gpio: pca953x: fix pca953x_irq_bus_sync_unlock race=
")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/gpio/gpio-pca953x.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2ee35e855e4d..ca73404e6909 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -605,20 +605,28 @@ static int pca953x_read_regs(struct pca953x_chip *c=
hip, int reg, unsigned long *
 	return 0;
 }
=20
-static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned o=
ff)
+static int pca953x_gpio_direction_input_unlocked(struct gpio_chip *gc,
+						 unsigned int off)
 {
 	struct pca953x_chip *chip =3D gpiochip_get_data(gc);
 	u8 dirreg =3D chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit =3D pca953x_get_bit_mask(chip, off);
=20
-	guard(mutex)(&chip->i2c_lock);
-
 	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D TCA6418_TYPE)
 		return regmap_update_bits(chip->regmap, dirreg, bit, 0);
=20
 	return regmap_update_bits(chip->regmap, dirreg, bit, bit);
 }
=20
+static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned i=
nt off)
+{
+	struct pca953x_chip *chip =3D gpiochip_get_data(gc);
+
+	guard(mutex)(&chip->i2c_lock);
+
+	return pca953x_gpio_direction_input_unlocked(gc, off);
+}
+
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 		unsigned off, int val)
 {
@@ -856,9 +864,10 @@ static void pca953x_irq_bus_sync_unlock(struct irq_d=
ata *d)
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
=20
+	guard(mutex)(&chip->i2c_lock);
+
 	if (chip->driver_data & PCA_PCAL) {
 		DECLARE_BITMAP(latched_inputs, MAX_LINE);
-		guard(mutex)(&chip->i2c_lock);
=20
 		/* Enable latch on edge-triggered interrupt-enabled inputs */
 		bitmap_or(latched_inputs, chip->irq_trig_fall, chip->irq_trig_raise, g=
c->ngpio);
@@ -880,7 +889,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_da=
ta *d)
=20
 	/* Look for any newly setup interrupt */
 	for_each_andnot_bit(level, irq_mask, reg_direction, gc->ngpio)
-		pca953x_gpio_direction_input(&chip->gpio_chip, level);
+		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
=20
 	mutex_unlock(&chip->irq_lock);
 }
--=20
2.54.0

