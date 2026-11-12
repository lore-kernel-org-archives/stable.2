Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508339;
	b=zxlue4RYp6nJkXmkAjw0UqzngnqaudESUr4a+KvOUiAw/OgIZuimRNuDPBdv/PwhnWYy
	 7bbM+lm4UvQnwL9ClhmEfhvVNUAtXuos/jzPN44uNiDnyPz9ykLhp5gLIa1708pO6N8LN
	 9xsEXq+Af3JguK8x0xl8zswjELW1C9A2R3yoEZSt6NAqBQcMODwSocZ+g28URZWtk50ga
	 LPg75KNm1ArbJZTv4wIKUEHp5/M15QFPnwIaZAq+he0S5LynJ35DHMBUH2XcmRblL7/6p
	 Hjt0Cl1TEgBHSxfsSMhcTKDAc24JZlaSUA1OeTGXnkOaGOeSRv4R1+Fik5MY26yd86g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508339;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MCjGHsn872d8KofdKGL65svKL4PNja6pq4PIoM1w/9g=;
	b=5lTQq21D3g3G15y2HwhDpekvx8RN4HatnIYxuTV/zrizhnPPI/dgdN4sPU05a5j0t10N
	 ckztgAYMmK9M3eJnttS2zfpN3vkcFnDMP//7JZUDn6sqiuWGv3fFtowtXoylV7hMNDaTg
	 dfAm4COp1SKyP7pQZd1Nvj5pSM1WfZrCd+AL4Q5mvvidLxaLkula41bfYfe9ZhGhFBpiP
	 S7w0uzkZ8q47tR+RsMTREL++6iXPRGrl1+rzvbS212+9ylSQ4Oztrisidr5YbGR9YANEn
	 iis2k7ivs5v9+Xqwxf7KnmHNMYPgAaOzqGrwRBck0VIiNQAr3VdPoDe3vpyKObcdt5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axtWnStn;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7D60A2612;
	Thu, 12 Nov 2026 18:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A7D60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axtWnStn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794508340; x=1826044340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6II4ZThJGq3dR8oKhWLJPD70EGoV0mqzUUJP+s30b9s=;
  b=axtWnStny04glvf4i9VLRUjqKyPQyA8PnPXIDD+fO9TPOC85eaJgl4as
   sIcgbAbGTBdE7rX7bBNRvTsI1BlHhz24ZLs/TtmJOjg4FbcUdA2c8WiK/
   s1mQ/AR6YjVON3zMOez37HHqrkIRjqXBnsFTO6C/oTCRhqCTSkFDC7jZy
   0OuQybYYkjlu7Lmo4LgCt3ncNWVjLKmO0a4S/ql61NMHOfI+k/EjEhJuV
   y6tHzPqkCX8F3obERJxpA07snzRsS/b1iyLbGdMpLwZBFJ5twA1M16Azg
   i7nA/Uw+3oJvpZDMORcjWXbza5L4AnrXuAY/0We68afsSXLMrhL+uH1eI
   w==;
X-CSE-ConnectionGUID: 05UFM+D+TWquLBXBmPzqtg==
X-CSE-MsgGUID: NLJlYQuDQcGC77L/4fpBLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3347782"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3347782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 10:32:20 -0800
X-CSE-ConnectionGUID: IfaXPzcmR/KbcV982RD93g==
X-CSE-MsgGUID: xSF2KndPTQm8yyiMP4y72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8618134"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO mdjait-mobl.intel.com) ([10.245.244.103])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 10:32:18 -0800
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: michael.riesch@collabora.com
Cc: linux-media@vger.kernel.org,
	paul.elder@ideasonboard.com,
	daniel@makrotopia.org,
	linux-rockchip@lists.infradead.org,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] media: rockchip: rkcif: Don't reset the hardware in runtime suspend
Date: Thu, 12 Nov 2026 19:32:07 +0100
Message-ID: <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
References: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset in the runtime suspend also resets the VICAP IOMMU.

When the IOMMU driver accesses the IOMMU registers inside the delay window
between the assert and deassert, e.g. in rk_iommu_zap_lines() to shootdown
IOTLB entries, the system hangs.

Drop the reset and the now unused reset control.

Fixes: f53fb31a3889 ("media: rockchip: add driver for the rockchip camera interface")
Cc: stable@vger.kernel.org
Signed-off-by: Mehdi Djait <mehdi.djait@linux.intel.com>
---
 .../media/platform/rockchip/rkcif/rkcif-common.h  |  1 -
 drivers/media/platform/rockchip/rkcif/rkcif-dev.c | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-common.h b/drivers/media/platform/rockchip/rkcif/rkcif-common.h
index 4d9211ba9bda..38208e8b7b2d 100644
--- a/drivers/media/platform/rockchip/rkcif/rkcif-common.h
+++ b/drivers/media/platform/rockchip/rkcif/rkcif-common.h
@@ -237,7 +237,6 @@ struct rkcif_device {
 	struct clk_bulk_data clks[RKCIF_CLK_MAX];
 	unsigned int clks_num;
 	struct regmap *grf;
-	struct reset_control *reset;
 	void __iomem *base_addr;
 
 	struct rkcif_interface interfaces[RKCIF_IF_MAX];
diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-dev.c b/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
index be3a174b9aab..dceabee2ecd6 100644
--- a/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
+++ b/drivers/media/platform/rockchip/rkcif/rkcif-dev.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -18,7 +17,6 @@
 #include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <linux/reset.h>
 
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
@@ -201,10 +199,6 @@ static int rkcif_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get clocks\n");
 
-	rkcif->reset = devm_reset_control_array_get_exclusive(dev);
-	if (IS_ERR(rkcif->reset))
-		return PTR_ERR(rkcif->reset);
-
 	rkcif->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
 						     "rockchip,grf");
 	if (IS_ERR(rkcif->grf))
@@ -273,15 +267,6 @@ static int rkcif_runtime_suspend(struct device *dev)
 {
 	struct rkcif_device *rkcif = dev_get_drvdata(dev);
 
-	/*
-	 * Reset CIF (CRU, DMA, FIFOs) to allow a clean resume.
-	 * Since this resets the IOMMU too, we cannot issue this reset when
-	 * resuming.
-	 */
-	reset_control_assert(rkcif->reset);
-	udelay(5);
-	reset_control_deassert(rkcif->reset);
-
 	clk_bulk_disable_unprepare(rkcif->clks_num, rkcif->clks);
 
 	return 0;
-- 
2.56.0

