Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1725158AB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095840; cv=none; b=M3EgK2fLrQSOS11egPygT0IErH5B/3QW86KGZJ0LWoqj/T9QNPNTGMtCaCA9W88sVmYKQHoJvBmSGrF4MZKOMQgqIsN2D1CWj7yoDUar0D+kMALLy9YSYdtMnQEocrNUkrNkZ4qUBWjSjIuaxMylXIt8BXx3C4zZBEq8/RyslY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095840; c=relaxed/simple;
	bh=ilLW9ahKI0VnfnIEoj2++bgf/Q8OGC1g3I1xF+hDSjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSl2Nv3PxPoNZ7aH6WZjQSqwRZH1aQ52Rj6yNWpU0Dhn0kGV5p97lC++exKHstTcj1aEF13HY4PWMbynwB9Dj9sWsGEQEMw54Jochw/fXDdhbFA2ojy7jYpTO7p5fx4pPCbR7EGrcqBsp7aNTQAxu3So+KbhPCdNoYx959OOBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdhlyFhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdhlyFhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B2D1F00893;
	Tue, 22 Sep 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095838;
	bh=9fDKt1UhSDeaoc9D4cnl+lLhbJLi212uNRXDa1IFVq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdhlyFhTjy8pG2CtEKeOoPGXX8jfjoxG3lIWOMasV2/3AcB0XN5bEZ+k3+QiQSwhG
	 ghz2gpSqSe7ga/GGXKlgg8NURUJEQgLnVNZyfwuOB1whc0r1f1lVqwkjlsd5SUYNew
	 9/2czlfKkXInROByJvRgfZU1dRDG9cPh+TopGDPlDEw4DWrDrhvzbzQr/+jBhh8R1k
	 rqjReOmPl7VRwSj2dhOM2iLdtVsA6SdjvxfpbjvRS7BuvMetI34IiMxdQ0a9dVX9VI
	 tEiseTflP6jcrljwoq0/hfsMp33OwV0bc2WJYKZqUEBKXSOwa8MFZiZ+dwBWrNdnUh
	 jlM75rAj2ob9w==
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
Subject: [PATCH 6.1.y 2/3] i2c: Convert to platform remove callback returning void
Date: Tue, 22 Sep 2026 12:50:32 -0400
Message-ID: <20260922165033.3134020-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922165033.3134020-1-sashal@kernel.org>
References: <2026092238-babied-brewery-a086@gregkh>
 <20260922165033.3134020-1-sashal@kernel.org>
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
index 92d177568328a..a0c1a707be676 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1624,7 +1624,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int i2c_imx_remove(struct platform_device *pdev)
+static void i2c_imx_remove(struct platform_device *pdev)
 {
 	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
 	int irq, ret;
@@ -1658,8 +1658,6 @@ static int i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused i2c_imx_runtime_suspend(struct device *dev)
@@ -1690,7 +1688,7 @@ static const struct dev_pm_ops i2c_imx_pm_ops = {
 
 static struct platform_driver i2c_imx_driver = {
 	.probe = i2c_imx_probe,
-	.remove = i2c_imx_remove,
+	.remove_new = i2c_imx_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &i2c_imx_pm_ops,
-- 
2.53.0

