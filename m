Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE82D0603;
	Thu, 23 Jul 2026 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792157; cv=none; b=G+/8Efm2y4Id6pQI2adp9QE4iILj12FXmyg1mc/qlkADjnRkYEYGC8XktV4E6KTTzquLbRb5SlZhIFUweFos+Cod1OzkdPxRStc/7OBUGuYmkSR/BEMU37f2EV+c857u1IMM1FAE6ZQdV+U9AOBvSQfEFesJkyjEKfLRbikG61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792157; c=relaxed/simple;
	bh=3wPAAutF3Hw6eNyZ5EmlalQDwA71nl5RAl6j6uUF53s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwK/i3O20Fuvz6gQWZrWPCm/gse1KJujZt8tGld0ziWVkkJaC3stdQBYcBgDzV91QgtzKgjlnwTk/7lW/JE4Av2YGGrSYSbqTqPYwSm3D1Cl/CdWT/wLb/2jwpDzYtltZTNd1i+HxDj68OpkYdtPf5vVPdXgHswecN31F0lysOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVq7CwiS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVq7CwiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784792155; x=1816328155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wPAAutF3Hw6eNyZ5EmlalQDwA71nl5RAl6j6uUF53s=;
  b=CVq7CwiSgSERJu4hqQ2mf2nYdkrxbQsJKYYawhk/4mcy7BqHrkDODp3M
   okl3LlIvmbCBGsCs6bCJj0WbcGcVut4nAMTPtghXTkBW/j6y8Xp6jrBm1
   Crgr41A5jElk78F9ShCg8/b8LaxUVBCk5WgTzpM8uPeuASXTAokQC3Ows
   lNghGdQlB1MJKgyqd3uX4/XSs5Di1qkLP0ZXeK+qdhkFQXuUgV2ezuqVk
   BcAXONjDxf/C/tYeF6p0bHV2NyJDWRKOLJGi/GFjo56iMQlLuK/sV4GAH
   SKLBVW69X3y5MQ0k/UgSlDyoahhhwuDI4FvOBGcFIrJqwNjm0EJuhQeV5
   Q==;
X-CSE-ConnectionGUID: Qwl4FZl7ScKAsQ8qRz/STA==
X-CSE-MsgGUID: EXYgLpYjR4ybDSRbnUYQ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85559436"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85559436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 00:35:55 -0700
X-CSE-ConnectionGUID: /OHx6hZiQKK80jgwiSZhiw==
X-CSE-MsgGUID: ckzIFuurSTuj+Ga/zfh7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="282840065"
Received: from serinyeh-ms-7d25.itwn.intel.com ([10.225.65.16])
  by fmviesa001.fm.intel.com with ESMTP; 23 Jul 2026 00:35:53 -0700
From: Serin Yeh <serin.yeh@intel.com>
To: linux-media@vger.kernel.org
Cc: serin.yeh@intel.com,
	sakari.ailus@linux.intel.com,
	jimmy.su@intel.com,
	sarang.sapre@intel.com,
	bod@kernel.org,
	kieran.bingham@ideasonboard.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass mechanism
Date: Thu, 23 Jul 2026 15:40:36 +0800
Message-Id: <20260723074036.369363-1-serin.yeh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently skips power-on and power-off sequences when
running with ACPI devices by checking is_acpi_node(). This results in
all power configuration steps (GPIO, and regulators) being bypassed.

Remove the is_acpi_node() checks to ensure that the full power
sequence is always executed regardless of the firmware interface.

With these changes, the driver behaves consistently across DT and ACPI
platforms and ensures correct hardware initialization.

Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock helper")
Cc: stable@vger.kernel.org
Signed-off-by: Serin Yeh <serin.yeh@intel.com>
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

