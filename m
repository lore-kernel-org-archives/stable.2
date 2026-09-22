Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6F212FAD
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096454; cv=none; b=r6vhhfURCDtaWpW3ufi6iLwAKuafuGUAkIGKd5nDBVK/gdEZvQAcPpip1dA/TD6ZDm7xibwYwhbSmhd8oc8JUw48G33tSJPcPJItCYjajI6XajP8kdZ4ukeZqPvoPJBjl3W33/VtJtBj+gqW51q9/4BPrICH5ZiK7JQpL7HSdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096454; c=relaxed/simple;
	bh=m+u70OcXnf7dcf+hiUwEpTVcF30/QWgU9CnyxM39cHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVqKyuhxm3THN06m63sxiRwyKWlyvQd1xBxv95vbhIMiCZqHah4UhPL9o0GZLl9JNnWgyHXSR4ys/Fv/WHsO0tZYwwyRRW59I7/54CcE8Fd+uOkVD094mW8aL0Np44x4nAwGEy2Uh4Vrrr6xBaKzOJ2RMEeQilJFdFNQMXRO3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg7ps5Vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg7ps5Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B651F00893;
	Tue, 22 Sep 2026 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790096452;
	bh=7H1+8l0pm7WuTEyBOZNkC6YorB2gT3D1zxsiyrCH9fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qg7ps5Vbk/5a7MZJpJ3udC2zJhQrR4my81QI0JRCdQJL/mPPczBkZt4qk1bJINYbM
	 ZcZPaH/Gmq4lTHK7lU1e0WHPhs5auKezzJI4J10RNo4LGZUDGMuUDz6Rgu8N64sVMz
	 hUDby/B2fzH37YjcRdgBHmJkB/KxCBF/xR6DrKWA2jMl+x3RXsw7DgWv6SaAbgQws4
	 PlhtAT/42MRiSMQpGIobfQ7a7wO7H6UqQaxmeGNGqS9rPESa6oh+nimdMxG+01wVD9
	 yBNmEvyZwML4WWgAn65CeZG5I4LiDD6h14A6F+wsRlG30OD4hiwutq1cOwBWbG7lvg
	 UhXnOBkRTpDjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jochen Friedrich <jochen@scram.de>,
	Peter Rosin <peda@axentia.se>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Asmaa Mnebhi <asnaa@nvidia.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Chris Pringle <chris.pringle@phabrix.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean Delvare <jdelvare@suse.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Tali Perry <tali.perry@nuvoton.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] i2c: Convert to platform remove callback returning void
Date: Tue, 22 Sep 2026 13:00:46 -0400
Message-ID: <20260922170047.3183673-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922170047.3183673-1-sashal@kernel.org>
References: <2026092238-outwit-provable-7707@gregkh>
 <20260922170047.3183673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e190a0c389e60178fba3d532abf936dcae223e7d ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Jochen Friedrich <jochen@scram.de>
Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asnaa@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Chris Pringle <chris.pringle@phabrix.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Tali Perry <tali.perry@nuvoton.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>

Stable adaptation for e0c3e9d76adb ("i2c: imx: disable autosuspend on
remove"): retain only the i.MX remove callback conversion needed by the
target. Drop the GXP conversion because this stable tree has no GXP I2C
driver, and omit the other unrelated driver conversions. The platform
core already supports .remove_new; no new functions are needed. Keep the
existing runtime-PM annotations so configurations without CONFIG_PM
remain supported.

[ sashal: Reduced backport -- upstream e190a0c389e60 touches 88 file(s), this
  backport carries 1. Not backported here:
  drivers/i2c/busses/i2c-altera.c
  drivers/i2c/busses/i2c-amd-mp2-plat.c
  drivers/i2c/busses/i2c-aspeed.c
  drivers/i2c/busses/i2c-at91-core.c
  drivers/i2c/busses/i2c-au1550.c
  drivers/i2c/busses/i2c-axxia.c
  drivers/i2c/busses/i2c-bcm2835.c
  drivers/i2c/busses/i2c-bcm-iproc.c
  ... and 79 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e0c3e9d76adb ("i2c: imx: disable autosuspend on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index cda7662e35bd6..f59dcd3aca0a5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1591,7 +1591,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int i2c_imx_remove(struct platform_device *pdev)
+static void i2c_imx_remove(struct platform_device *pdev)
 {
 	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
 	int irq, ret;
@@ -1625,8 +1625,6 @@ static int i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused i2c_imx_runtime_suspend(struct device *dev)
@@ -1657,7 +1655,7 @@ static const struct dev_pm_ops i2c_imx_pm_ops = {
 
 static struct platform_driver i2c_imx_driver = {
 	.probe = i2c_imx_probe,
-	.remove = i2c_imx_remove,
+	.remove_new = i2c_imx_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &i2c_imx_pm_ops,
-- 
2.53.0

