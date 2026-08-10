Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C62DEA68
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323119; cv=none; b=aeBxdatuH2rlyHFHKtNkXO61PARQQoHiFlFxoTvrMR++2NDhrw3W55raRhG3TiFyO8LyYWrnfgKiWoa8wARmgRRBw9TslQQGEy/zainqXK/E4PDUqzjHzYFaNw1YwEX8DXAogchBJEttqnHBt1ZePB8l+iQXrSp0uNcBTbEESn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323119; c=relaxed/simple;
	bh=OGPCpoTfVBGCOAl+oHBLu0+iVL11qWzWLTl9lbkvhRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3t6Q+fensepOxoKaUeI3ll0Wrk0+pPN2VayBf2P1cW0PKXCSzeIoUEZgKB+mFHKfp+NFJ7Q/PLnaebO4v/j9Z18rHIIsDo9/oEAWSlwYXKKef/mGQ/fMfb8JzW5ql0Cu6n9IWbGYYdYUsHVokg6b5oTFrxh0FLOkg30ZleYN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=YJsWhis0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YJsWhis0"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 009112C01F0;
	Mon, 10 Aug 2026 12:51:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1786323113;
	bh=ZcPMKmv6ea/Ap3wqk7302vK52znsjPsTpPdLPhsSFS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJsWhis0uoQy2oAHmvirAKTDCD5paUTFHOQfyCvMhx5akndvp+/WluJeE+POPrjOz
	 vvoIYx2jEKZk6nxSNN6iuKUqGQwAxzbHuouHt0/wHOJXoSEFMcr0cCag4lpMHb/ig0
	 uEOQIrkPpDqOLDM3flgqyfZWsfC84TgWP18LHHMS7ZWNevezlcxqq3R3UPwvOdsfEL
	 uoQidS7Q57lOHasEieQ3fKfeGucUfQE4yUI1RWwxj4wIVLSnAkJ4S4J4aVAR4qTl02
	 MeLDWd+PriKs1qMYq08QYvM5UUoWesEoB4ktCzwqvreQ1cb2GRZzi46hByx2amJium
	 lorgNMk4eu/sw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a7920a80000>; Mon, 10 Aug 2026 12:51:52 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 4F29213EDD7;
	Mon, 10 Aug 2026 12:51:52 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id 4A529406AE; Mon, 10 Aug 2026 12:51:52 +1200 (NZST)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: stable@vger.kernel.org
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 7.1.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Mon, 10 Aug 2026 12:51:44 +1200
Message-ID: <20260810005144.2225816-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026080529-enforcer-eel-8588@gregkh>
References: <2026080529-enforcer-eel-8588@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=O66avw9W c=1 sm=1 tr=0 ts=6a7920a8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Sv0fKeRqtYgA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HDTP818q5T4t6XSuYIMA:9 a=3ZKOabzyN94A:10 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22
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
 drivers/gpio/gpio-pca953x.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index b9c905a0ffa9..b40729aa13d3 100644
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
@@ -882,7 +891,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_da=
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

