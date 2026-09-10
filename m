Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49885921EB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067469; cv=none; b=NZ2uVldl/8dQeFgGR611ma7QFq+zacOaO2yICRNY7r0NdDcz8uLf8a8mdf7enYYHfFliZgNbgWIzqb79/TnAs0erzKo2SsFu97pMaS/7/sAYk9cd88sjFFq4Fn26kV7CdRz9C8Y52jQfWzEHbz4x8CkURiX+I+bAOq7Bre989Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067469; c=relaxed/simple;
	bh=G5ByD0mXyDtJhQvk8vmfleoXuo7pCvfqs0XT9suvDuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqVvKKGTnWqNR2DBQ2hyFxBDoEhuxqlE0ZpswQwrJpbZEgS9aFmEzf3gWNqJOmEd4CZwK+n5gcUSSLsxhzBYuct1R39C9V58uKtkyAFln0DxnB/7Vfiec6lgEJscP6Litzqm3D+m/jjYLC67fYI8SpdeMwJGtyDSkcTW1huF4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsyvPI3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsyvPI3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8AF1F00893;
	Thu, 10 Sep 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067467;
	bh=50+/IcHD+2ifsF9YaJlk1j4Dnv8ZcZ22CSQmso6zwHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsyvPI3uBPrY3rydHdPh/NHJVp98zxqUWoMFGSNP2A96G1CnvJC9Rt6tLMXsTgVp0
	 +C8NW6/Y25R6ZnLlRnr4naBgNL+xqbc0ayRQnuZiiDSJqZkimK+8ssD4xMoUoQRSnk
	 evaN6ma0aAorogIA8Kkcnz6r6NsF81ltJ4VwptYOREMoZEOiXRd5AJf6YCdpCO2ZZx
	 h47UfLCoUd8IGl8L1yCYNLGUpuSjH8AwCR95yzoZnJMU8uIG6hJutXCE2zowKfZLTt
	 S554quTlSwzrSvU3diGZNB0B4snZE0Q1r23QObHsZLFMSNv0I29pZ0uS8S2dyjbo5E
	 9oykRHf40esEg==
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
Subject: [PATCH 5.15.y 2/4] i2c: Convert to platform remove callback returning void
Date: Thu, 10 Sep 2026 15:11:00 -0400
Message-ID: <20260910191102.1467479-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910191102.1467479-1-sashal@kernel.org>
References: <2026090909-palpitate-shortage-3ec4@gregkh>
 <20260910191102.1467479-1-sashal@kernel.org>
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

For this stable dependency, retain only the Qualcomm CCI conversion.
The GXP driver is absent from this tree, and the other I2C driver
conversions are unrelated to the target autosuspend fix.

Also adapt the probe/remove cleanup from upstream f0285c286bca5
("i2c: qcom-cci: Remove overcautious disable_irq() calls"). The IRQ is
already requested with devm_request_irq(), so devres releases it on
probe failure and removal. Route both the existing cci_reset() and
cci_init() failures to disable_clocks, and remove the redundant IRQ
disables and error label. This supplies the context expected by
f98d4986482151a835b521a734722fe8dc5ca37d without adding functions.

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

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

Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index eae21899e0f3c..b3ccbea140e9d 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -632,11 +632,11 @@ static int cci_probe(struct platform_device *pdev)
 
 	ret = cci_reset(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	ret = cci_init(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -666,15 +666,13 @@ static int cci_probe(struct platform_device *pdev)
 			of_node_put(cci->master[i].adap.dev.of_node);
 		}
 	}
-error:
-	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
 
 	return ret;
 }
 
-static int cci_remove(struct platform_device *pdev)
+static void cci_remove(struct platform_device *pdev)
 {
 	struct cci *cci = platform_get_drvdata(pdev);
 	int i;
@@ -687,11 +685,8 @@ static int cci_remove(struct platform_device *pdev)
 		}
 	}
 
-	disable_irq(cci->irq);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-
-	return 0;
 }
 
 static const struct cci_data cci_v1_data = {
@@ -785,7 +780,7 @@ MODULE_DEVICE_TABLE(of, cci_dt_match);
 
 static struct platform_driver qcom_cci_driver = {
 	.probe  = cci_probe,
-	.remove = cci_remove,
+	.remove_new = cci_remove,
 	.driver = {
 		.name = "i2c-qcom-cci",
 		.of_match_table = cci_dt_match,
-- 
2.53.0

