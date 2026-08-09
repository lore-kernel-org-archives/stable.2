Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0228F5
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786320260; cv=none; b=N63z5EgNXiX+f1WHkcgkdbrSZdWf8Su8jYqiMQDkLl4Dx3T41tz+vwVRWegWutFofrmf2fTJGzg02J4YJoiJqdeVvERt5Ce0n60EKCNLg3IE+DfLl+F/Kzof3VIAPD50Czc6sFxM/aSjiTTbmCTEKo8l2nMP9uguGI4s92wOU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786320260; c=relaxed/simple;
	bh=UhCKw7uKKMhjzETFjpRQKul63KSiRHh6x97PEoh0Apk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q05mMlsKyShrMBVVkK3vXQXaOENGPyYd7R+7QARAVgAGN7P3rVz50AH9rDtLvXgqvB4GTLqJa2f79sN1btkgw06OI0Gz13sRfm3F/ZHNBKyvXvAJ7ShVQE1OWCVJocEIgksWYy8wcuV1POas5sc2XuYtcSnpUXUinVoUHgT81PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=KOMDuYV2; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KOMDuYV2"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9CD7B2C01F0;
	Mon, 10 Aug 2026 11:57:11 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1786319831;
	bh=FnVN76IK/ZlMNomEDHZW2lLU775rWGV6CxZvYExkBoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOMDuYV2Wl+H3j0zfXyjSYEuZNBFMPLiVRTLjIkSa0S3SSCmD++zLNsWS8giJVUBz
	 k8CSqgvACRBenyH6NwNVrQlBpETZU5HuRoFI7yOfeetRCN7Ev6Z1Hg9ht5WxQZD2Ru
	 CM3joUd1dc9teC8ifNEktRPir3uFe8DXU1lyjL882oMWT5uvXDmQ+zn0YoZ/wHHMOI
	 /H3IFntZF/Txmh89PB20b6ci5jwlBNer2wT0KXlv/5hB78peUPjD7kouFczAwCMLXd
	 1ZXC3se714OUUCbGK+YKoZIscPIL5wafNUKi1s8KfNEFV9ayMQaMnQk59uHM8aS8dK
	 8Yr3IHYdTyqkw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a7913d70000>; Mon, 10 Aug 2026 11:57:11 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6D64913EDD7;
	Mon, 10 Aug 2026 11:57:11 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id 69CC5406AE; Mon, 10 Aug 2026 11:57:11 +1200 (NZST)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: stable@vger.kernel.org
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.12.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Mon, 10 Aug 2026 11:56:32 +1200
Message-ID: <20260809235632.1856553-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026080530-jailbird-pedicure-255b@gregkh>
References: <2026080530-jailbird-pedicure-255b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=O66avw9W c=1 sm=1 tr=0 ts=6a7913d7 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Sv0fKeRqtYgA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HDTP818q5T4t6XSuYIMA:9 a=3ZKOabzyN94A:10 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22
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
Link: https://patch.msgid.link/20260709045116.2304246-1-mark.tomlinson@al=
liedtelesis.co.nz
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
(cherry picked from commit 9dc325327babe7f159e84cbe9380a45342da0585)
---
 drivers/gpio/gpio-pca953x.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 489c7ebe87c8..2d8c3da7abad 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -525,15 +525,23 @@ static int pca953x_read_regs(struct pca953x_chip *c=
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
 	u8 bit =3D BIT(off % BANK_SZ);
=20
+	return regmap_write_bits(chip->regmap, dirreg, bit, bit);
+}
+
+static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned i=
nt off)
+{
+	struct pca953x_chip *chip =3D gpiochip_get_data(gc);
+
 	guard(mutex)(&chip->i2c_lock);
=20
-	return regmap_write_bits(chip->regmap, dirreg, bit, bit);
+	return pca953x_gpio_direction_input_unlocked(gc, off);
 }
=20
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
@@ -759,8 +767,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_da=
ta *d)
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
=20
+	guard(mutex)(&chip->i2c_lock);
+
 	if (chip->driver_data & PCA_PCAL) {
-		guard(mutex)(&chip->i2c_lock);
=20
 		/* Enable latch on interrupt-enabled inputs */
 		pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip->irq_mask);
@@ -782,7 +791,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_da=
ta *d)
=20
 	/* Look for any newly setup interrupt */
 	for_each_set_bit(level, irq_mask, gc->ngpio)
-		pca953x_gpio_direction_input(&chip->gpio_chip, level);
+		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
=20
 	mutex_unlock(&chip->irq_lock);
 }
--=20
2.54.0

