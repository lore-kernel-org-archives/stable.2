Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7102D5C68
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793837; cv=none; b=LJ+TJTXeOwQjMjANOo8eo5e0jdzvtyNt94biUdzRF2bMOExTtfHdI3YnJGj3ed2iVNJweX5Rg2Tn0ur57SPkf/UW7RMiHJXJj4gFFuhNISRBhZIpCMf/usSoo/1R2EAxLCxeuj/j5KJgXbcK9DxAYm0OU++tWC70azfON0YH6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793837; c=relaxed/simple;
	bh=BvIsLVTjnGJia0JRVDwn/6xLfIgXvHaA7kvj6aaYSEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inDNYnboo0rx4ovMLReQtHkTAozOhC65IxQWRhub6ZbK6iP3SPrZBnRx2xxW2HcKMwv6++LyDVxAu9dSreU5faCGq9fSA1Hv52sGvl0j/YB3Hcjga13PRqrslt1es9krIp0EBXkb1djpTNN8TWX0mlSkW6n+r9YL8voHgdy4wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6htguUU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6htguUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785793835; x=1817329835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BvIsLVTjnGJia0JRVDwn/6xLfIgXvHaA7kvj6aaYSEA=;
  b=l6htguUU+up0cPCZvzVHGBZCfLMySqJE9wApcmOyR6Lztig3NFxOCgMW
   kLCn3S6NYbRicUseUcoqxAMob6USCC30Gf1aNqOKX6eXdO7jeQYbdBeJo
   VLspSYnR65w204hTX44KnYCPfpkWok1CHLIctQGlWTJjXYcny+u6eGttL
   wnBJOb2fuau6S8AXacYFMmTwDCIh+tIIwL16m4uFPdmR9Me1dg7XjBNYg
   L/0L9Yx/dWM9oGnhgk+E3rHPsG2jk/OrERIrcOljoIM2dO1JHh2mRLRtP
   FG7B0wS7znujus3i2bSN7Axekpth+/19x7AfPUKfP2p79FiDwoNeWO5SM
   Q==;
X-CSE-ConnectionGUID: Fu5t0OMvT++uWsyq+O0oKQ==
X-CSE-MsgGUID: l5CMyk4JSxGcXAs6miyjdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97849153"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97849153"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 14:50:35 -0700
X-CSE-ConnectionGUID: C/xYupQlQf2mS2V5kQS7lg==
X-CSE-MsgGUID: D+RSJNrCTiCmOLQCcr7x6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="291272107"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa002.jf.intel.com with ESMTP; 03 Aug 2026 14:50:34 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] drm/i915/3dlut: disable 3D LUT if unsupported
Date: Mon,  3 Aug 2026 23:49:09 +0200
Message-ID: <20260803214909.3076716-5-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260803214909.3076716-1-michal.grzelak@intel.com>
References: <20260803214909.3076716-1-michal.grzelak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

XE2LPD_DE_CAP_3DLUT_MASK is defined but never used.

Check DE_CAP with the mask whether 3D LUT is disabled for LNL+. Reset
has_3dlut if that is the case.

Bspec: 71161
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: 6d181a288e64 ("drm/i915/xe2lpd: update the dsc feature capability")
Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_device.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display_regs.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index a2bea5ac59cf..d4e52e627b34 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -1940,6 +1940,10 @@ static void __intel_display_device_info_runtime_init(struct intel_display *displ
 	if (DISPLAY_VER(display) >= 20) {
 		u32 cap = intel_de_read(display, XE2LPD_DE_CAP);
 
+		if (REG_FIELD_GET(XE2LPD_DE_CAP_3DLUT_MASK, cap) ==
+		    XE2LPD_DE_CAP_3DLUT_REMOVED)
+			display_runtime->has_3dlut = 0;
+
 		if (REG_FIELD_GET(XE2LPD_DE_CAP_DSC_MASK, cap) ==
 		    XE2LPD_DE_CAP_DSC_REMOVED)
 			display_runtime->has_dsc = 0;
diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 740331ead20a..78b9e6008828 100644
--- a/drivers/gpu/drm/i915/display/intel_display_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
@@ -1773,6 +1773,7 @@
 
 #define XE2LPD_DE_CAP			_MMIO(0x41100)
 #define   XE2LPD_DE_CAP_3DLUT_MASK	REG_GENMASK(31, 30)
+#define   XE2LPD_DE_CAP_3DLUT_REMOVED	1
 #define   XE2LPD_DE_CAP_DSC_MASK	REG_GENMASK(29, 28)
 #define   XE2LPD_DE_CAP_DSC_REMOVED	1
 #define   XE2LPD_DE_CAP_SCALER_MASK	REG_GENMASK(27, 26)
-- 
2.45.2

