Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF239363C46
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397333; cv=none; b=VemYiKYBGl1veG6IbIlGhzt8hRM7BJmWtPy1XujifzaJEZoJKOXOGoF4UufUrqx6UD9qGMHLHy1ZIfu9W5UTOfe1d4Z+M5oprwyMSPH9RCXU32FEyVkuWy4HROOzeIpQJQLmU9n1p06HRY4fqkATahedcFi2Y7v7xjrYjlfx9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397333; c=relaxed/simple;
	bh=9RxcQiK8eNwoj4TWdFexDHhbMbFh44gHc1Ur1L8rfnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvrONf+qWXCykWtmAriRpLck521FxPbemAGAUE2K6HrM9OuH4Xe6AgsQnoma+qVk/igLBYHQ0uLH6I1VlXNQypnIue1ZcXljZmhZd65bcQiA3oMaDdCAeVx3qp68J6JbBksVw0nizFYHhR8sZMMrgWqx+n7hEicflXkt1M0uS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buxrmPio; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buxrmPio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782397332; x=1813933332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9RxcQiK8eNwoj4TWdFexDHhbMbFh44gHc1Ur1L8rfnM=;
  b=buxrmPiofyPutAt82d0fMaI0dOzcV+MYcpTW2ntykmQTKsCuRNbQQywu
   dWIHdub3Oej0KtY97/K7VQClN79YP6lq6GrgfAMPqLNaO4eqIlhHkb3G4
   MR2R48JtPezYdVRQNC2hcMI0tGs3v03TP783ubhxGOVjuU6WQwtu7RGw+
   XSXaPXqx4vypJxFlGw3VKrudoFx8Wc+edFar9Ajn7FwFWVikU3lCpH+4M
   mqX3F0A+P8iKTNw1IYd005ve23ilCMLKD2DyB5ZXaggH8N8o/zNSZM2/X
   nTvhh14NrSjNPIqv/UnrPCx2J08PMA74pNxE5Wd8gE65X6lYohV6M+l+l
   Q==;
X-CSE-ConnectionGUID: hjOSmLZETEea8TPwbJ29hg==
X-CSE-MsgGUID: QdRfIuFMQyKzilBVl4SdrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="70684414"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="70684414"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:22:11 -0700
X-CSE-ConnectionGUID: skDKxPkgSpiGM7kWtDo4XQ==
X-CSE-MsgGUID: a40Rus0qSYisFycO3GJcnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254832038"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:22:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>
Subject: [PATCH] drm/i915/mst: limit DP MST ESI service loop
Date: Thu, 25 Jun 2026 17:22:04 +0300
Message-ID: <20260625142204.1078287-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

The loop in intel_dp_check_mst_status() keeps servicing interrupts
originating from the sink without bound. Add an upper bound to the new
interrupts occurring during interrupt processing to not get stuck on
potentially stuck sink devices. Use arbitrary 32 tries to clear incoming
interrupts in one go.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Note: The condition likely pre-dates the commit in the Fixes: tag, but
this is about as far back as a backport has any chance of
succeeding. Before that, the retry had a goto.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 3c0ec2c2d594 ("drm/i915: Flatten intel_dp_check_mst_status() a bit")
Cc: <stable@vger.kernel.org> # v5.8+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6e3fa6662cbe..ade7e51e7590 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5590,8 +5590,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	bool force_retrain = intel_dp_link_training_get_force_retrain(intel_dp->link.training);
 	bool reprobe_needed = false;
+	int tries = 33;
 
-	for (;;) {
+	while (--tries) {
 		u8 esi[4] = {};
 		u8 ack[4] = {};
 		bool new_irqs;
@@ -5634,6 +5635,11 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 			break;
 	}
 
+	if (!tries) {
+		drm_dbg_kms(display->drm, "DPRX ESI not clearing, device may be stuck\n");
+		reprobe_needed = true;
+	}
+
 	return !reprobe_needed;
 }
 
-- 
2.47.3

