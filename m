Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC08635D;
	Thu,  6 Aug 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996830; cv=none; b=O97egq9/YR/YLer4bfdt55nJsiJYRlNf3lxirf69Z3XIph8ti3SY/V199u2WWfwdRTOjH3w3l0YZtqHTxwelWnxZfNkviiO8yeptMYPfFApF/2HnRVLkxqu9KL63AdJNPLNAM3uFZ6RuzNTESqpxzKg22A5HrWjKbsUH4gc4rmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996830; c=relaxed/simple;
	bh=DP352WImcWYlInjaHyrODPI3o/XF1NyYfycSe2fR4jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DrbeYytxP8xG1noIYYRQSzogi4pEyhLUc1Us6Zn7qP3f8FJQoipquzEJrSod8SydcphMBsG+ewSYdqko9Lpzs1GLszSXqVsxZHcGbPHoLNHwn2Iun2dP3tBNurkuAXqs2nT+zxw5dUESIeZHa0eDw7azSdcGwwXSCj1HDmEPHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJCKSP3B; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJCKSP3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785996827; x=1817532827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DP352WImcWYlInjaHyrODPI3o/XF1NyYfycSe2fR4jk=;
  b=WJCKSP3B1xWragOtKb5+YGpCWT2aYCAhk+8Dxzeej7jZii1nMVHyiPxc
   Be5iHvJzJ7wVwoKcwZmKJJhkP0Cc2NYWxSpTLme05D7R6Le91uw/KW8zf
   PUKoxWzaBqafYryI75rIvmcr7jjqmW453FB5E+vWRxNVgLTc7aR8bNgiE
   NW3WkjXvsIuIMYPwvGFM+rgR00El/OdyUCRYnWJUtut8zoZPNb4vpKh3c
   p3V6pgaKNmatuwmVALjHdfMChLnmKhIQm9PGLF8XwdyjV5BKAGrNsfCly
   5TC/TLmKLt0Y7y9UFqrK1Gj1gOeOqh3N5EHFJ4Cuv9LJxqccBJPgt96Fm
   g==;
X-CSE-ConnectionGUID: +2beYwrhSvudFbhp8OLclw==
X-CSE-MsgGUID: b5vCh7vMShqizC9AFXA3vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109372704"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109372704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 23:13:46 -0700
X-CSE-ConnectionGUID: nf0b/s9VQJC7AN0i7uJTLw==
X-CSE-MsgGUID: kmKN1luuSOKrT5jr74O4Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="259386320"
Received: from serinyeh-ms-7d25.itwn.intel.com ([10.225.65.16])
  by fmviesa008.fm.intel.com with ESMTP; 05 Aug 2026 23:13:43 -0700
From: Serin Yeh <serin.yeh@intel.com>
To: linux-media@vger.kernel.org
Cc: serin.yeh@intel.com,
	sakari.ailus@linux.intel.com,
	jimmy.su@intel.com,
	sarang.sapre@intel.com,
	bod@kernel.org,
	kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass mechanism
Date: Thu,  6 Aug 2026 14:18:04 +0800
Message-Id: <20260806061804.1359700-1-serin.yeh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel platforms the sensor is enumerated via ACPI, and an INT3472
"discrete" companion device (the power-logic-control driver under
drivers/platform/x86/intel/int3472) registers the sensor's
reset/powerdown GPIOs and the regulator supply. These resources are
therefore discoverable and usable through the standard gpiod/regulator
lookups at probe time.

However, the driver guarded both the GPIO/regulator acquisition in
ov8856_get_hwcfg() and the whole power-on/off sequence with
is_acpi_node() and skipped them on ACPI. As a result the sensor was
never powered or reset by the driver, and probe failed when reading the
chip ID in ov8856_identify_module().

Remove the is_acpi_node() checks so the GPIO/regulator resources are
acquired and the full power sequence runs regardless of the firmware
interface. The driver now behaves consistently across DT and ACPI
platforms and initialises the hardware correctly.

Tested on Intel platforms with kernel 6.17 and 7.0.

Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock helper")
Cc: stable@vger.kernel.org
Signed-off-by: Serin Yeh <serin.yeh@intel.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov8856.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 8bedb47cd7cf..9d2b0469a576 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2082,9 +2082,6 @@ static int ov8856_power_on(struct device *dev)
 	struct ov8856 *ov8856 = to_ov8856(sd);
 	int ret;
 
-	if (is_acpi_node(dev_fwnode(dev)))
-		return 0;
-
 	ret = clk_prepare_enable(ov8856->xvclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable xvclk\n");
@@ -2120,9 +2117,6 @@ static int ov8856_power_off(struct device *dev)
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov8856 *ov8856 = to_ov8856(sd);
 
-	if (is_acpi_node(dev_fwnode(dev)))
-		return 0;
-
 	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
 			       ov8856->supplies);
@@ -2293,21 +2287,18 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856)
 		dev_warn(dev, "external clock rate %u is unsupported",
 			 xvclk_rate);
 
-	if (!is_acpi_node(fwnode)) {
-		ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-							     GPIOD_OUT_LOW);
-		if (IS_ERR(ov8856->reset_gpio))
-			return PTR_ERR(ov8856->reset_gpio);
+	ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(ov8856->reset_gpio))
+		return PTR_ERR(ov8856->reset_gpio);
 
-		for (i = 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
-			ov8856->supplies[i].supply = ov8856_supply_names[i];
+	for (i = 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
+		ov8856->supplies[i].supply = ov8856_supply_names[i];
 
-		ret = devm_regulator_bulk_get(dev,
-					      ARRAY_SIZE(ov8856_supply_names),
-					      ov8856->supplies);
-		if (ret)
-			return ret;
-	}
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ov8856_supply_names),
+				      ov8856->supplies);
+	if (ret)
+		return ret;
 
 	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
 	if (!ep)
-- 
2.25.1

