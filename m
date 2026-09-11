Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902E1A682F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085736; cv=none; b=kfVNy80OtweEEqO3aEocsCRIGrvKHCK3MOLgIVjjc0xKe4IQmiK1psRLBOXbVKxhqkmaEivL2Tn48oQFjL3dWrO/yDsE1pO6NeX9pvELpoSJFabGGO5AS87Hw3vQjhpsnDqXjU2p2lurEgTms51qbessE76sY5KHXRyi2aP5dyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085736; c=relaxed/simple;
	bh=Z/H4TGx7xRPbOBFdExpHERe18jfn1SGms8J1gIFm8gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5Hl8MIv4fKtHPq6gn621kabVRr1im44ByFEK7qI21FNr548cH22OwkGFxtR/B4qg1Ayxs+dKV9jr6WDwetC8VdFNG7giuPUPS/SrD19TdKKwHFVMCSI9e6AxOOPfUbaKNQRArvEHIWlIUG91PZ57ikMlfxilPZbbXo3CVUNgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkIQD1FD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkIQD1FD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB61F00899;
	Fri, 11 Sep 2026 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085734;
	bh=DuEB+OK19ZuwB3lt9TxTkJI/8zDr8vBLEyWYuyiUHo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VkIQD1FD871oBq9J87mZWtK7SXNtRDi5QXst+Vu/CohhB9czMk1aLAcoow8YIg8FA
	 5OdfZojC/BLafMxqIBFhDGOPtbFcmI4oWkSGxQz66xY/tHwRbduR+uvET/8aC+UIvi
	 MCZppsK574ZE0tJDYUdGMGdoLHRZ6Qc+gGxULhJH+3xTJ6tglurYSHr9qRPPYbJ00d
	 VpSlqEiRYUcrKqXbYWLhZ5dHe5SJVhbpLDnzGF1E9r4PrzmSY/g6RrPlmnG1plNPyY
	 vYJVsxv7oulgXtE3fDtRV57+Y5d+OztbUAItjPxWUvEPnxVO1sDSXjOc5x19i69hnh
	 z6WjVjVNtXveg==
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
Subject: [PATCH 5.10.y 2/4] i2c: Convert to platform remove callback returning void
Date: Thu, 10 Sep 2026 20:15:27 -0400
Message-ID: <20260911001529.3302151-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911001529.3302151-1-sashal@kernel.org>
References: <2026090910-covenant-freestyle-77a9@gregkh>
 <20260911001529.3302151-1-sashal@kernel.org>
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

Stable dependency adaptation for 5.10:

Limit the driver conversion to Qualcomm CCI, the only driver touched by
f98d49864821. Drop the other 87 driver conversions, including drivers
absent from this branch and drivers that still use ACPI or I2C callbacks.

This branch lacks platform_driver.remove_new. Include the minimal support
from 5c5a7680e67b ("platform: Provide a remove callback that returns no
value"): add the callback member and dispatch it in the existing
platform_drv_remove(), preserving the legacy int-returning remove path.

Also adapt the CCI IRQ cleanup from f0285c286bca ("i2c: qcom-cci: Remove
overcautious disable_irq() calls"). The IRQ is already devres-managed;
remove its explicit disable calls and route both reset and initialization
failures to clock cleanup. Retain the 5.10-specific cci_init() call. This
provides the probe and remove context required for the target to apply
without conflicts. The managed runtime-PM helper used by the target is
already available in this branch.

No functions are added. The autosuspend fix remains in the target commit.

[ sashal: Reduced backport -- upstream e190a0c389e60 touches 88 file(s), this
  backport carries 3. Not backported here:
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
 drivers/base/platform.c           |  4 +++-
 drivers/i2c/busses/i2c-qcom-cci.c | 13 ++++---------
 include/linux/platform_device.h   |  2 ++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 647066229fec3..94a4c8184cc91 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -783,7 +783,9 @@ static int platform_drv_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret = 0;
 
-	if (drv->remove)
+	if (drv->remove_new)
+		drv->remove_new(dev);
+	else if (drv->remove)
 		ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
 
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 7e3e1514416d8..c13cc1509b166 100644
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
@@ -784,7 +779,7 @@ MODULE_DEVICE_TABLE(of, cci_dt_match);
 
 static struct platform_driver qcom_cci_driver = {
 	.probe  = cci_probe,
-	.remove = cci_remove,
+	.remove_new = cci_remove,
 	.driver = {
 		.name = "i2c-qcom-cci",
 		.of_match_table = cci_dt_match,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index e7a83b0218077..37b5161d61fcf 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -203,7 +203,9 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+	/* Use remove_new for callbacks that return no value. */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
-- 
2.53.0

