Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB026FD9B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393049; cv=none; b=FcAuFg/Vl89R8sdNDVEV3RpEldx44mHDn4LHZprrorDueokv0PS2K0tjy6bQtYpD5/fWkD7lNRZm5V+NeVbB1O0KQT/U/E8MWRBBnsVPhVeWnKlGqHfQXmzk18BLYJ4bmjR789zUC4CplCFU/tnDK8Gk8O2PZ2DRmq3T3s/nuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393049; c=relaxed/simple;
	bh=lzC+LUUvfV7uYGcBaOhEXbvYJIWnO8/EqxSud/5mrYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJLBmpb2HVm9TzJ+3a7i2vLBjZXYgBS0zYAb6eP6iuPKh6avfg5xqbCN+fPH+6dVCO0jaGgV958QzzftLkiXlbjogB0B1SnAnn/YkZbSTCqlDFsB5F7PVz6W8z0ia+891FO+yu1K74lROljx7oqsJ6WFDJm8AcfYwOWmI5I2mLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEbCx2Ox; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEbCx2Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782393048; x=1813929048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lzC+LUUvfV7uYGcBaOhEXbvYJIWnO8/EqxSud/5mrYI=;
  b=CEbCx2OxcnNzT2WKPoet6fUs+DpiClwjmEsIOmoZ5zgrk4gpY0MqTIES
   kbjcgi5whr+d20RxJiHZCoCAwLqc+SGbVYVDNt0bPIl5O1wRB83CbHdyR
   yLKcw1jny4Q1ugY6RBqsMAtECLOzIYOwJtHEfz6cN7z3M2WhXWdDsI+Ho
   BSfefWwIVH+FGvTH/lmMHZ+aPbhQWBKPv57CIP7b0riGggDXgT2jF7E0M
   kTk8oIw9nin3P0JNyPWZpD20KIeuNvEpp4zccOAPFI7sh4iSQ3K+hjaTT
   ocxXiFN3b5Bgnrn4LnucAKuJhalv0Q4cjIPYHIulxV7WpUPD1SH0K/YTB
   w==;
X-CSE-ConnectionGUID: LrgTtdcvSZOWaHiMdq16uA==
X-CSE-MsgGUID: 4Q5CqBhRTbivw6O7szOHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100720060"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="100720060"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:10:47 -0700
X-CSE-ConnectionGUID: VMgQrozUR0awUldBDO2E3w==
X-CSE-MsgGUID: fCUVJKuuRguOl8X5bOl8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250863153"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:10:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH] drm/i915/vrr: require valid min/max vfreq for VRR
Date: Thu, 25 Jun 2026 16:10:40 +0300
Message-ID: <20260625131040.1051272-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

Ensure the EDID provided min/max vfreq are valid. Most scenarios are
already covered (by coincidence) through the checks in
intel_vrr_is_capable() and intel_vrr_is_in_range(), but be more explicit
about it. At worst, a zero min_vfreq could lead to a division by zero in
intel_vrr_compute_vmax().

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 117cd09ba528 ("drm/i915/display/dp: Compute VRR state in atomic_check")
Cc: <stable@vger.kernel.org> # v5.12+
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5d9b11185296..bffbdee76ee1 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -76,6 +76,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
+	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
+	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
+		return false;
+
 	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 
-- 
2.47.3

