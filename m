Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340513FEE
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433158; cv=none; b=LFTVhTN05qvHEDoTUFQkoZzD14QJusH+yqGUe7I6dgvVwjsFqkBPZARYBDRD+qraCNk//pWzVmGi2oi/WEYnGUF6tHyFHSymRQJ7PgNA+eWMi0o6hWY7W76c5UR8L9WEh9rM2BKDh4oxzQA5H6SNwXRIV8AuX9TKfGxtWh10hgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433158; c=relaxed/simple;
	bh=CftBxbd902Wn6lSTnpIfX3tGl9M5MFemFzPadcohOZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utwoo9l4Els2R+uIJbOwCmTXRyStSh/eGIYNFYdQfewV1wYaQdHXnIvBBeSf+KneZ9cBcF+ZjL205b5DS/AoKK20EnTu2MEs1HRov3c4N09UxolzsT6bn/3FwQ9U7B3eLwrP4/fpTBKb6m8chFpUPWXyxIDblysVV1H643NR+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOSQVx/l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOSQVx/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791433158; x=1822969158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CftBxbd902Wn6lSTnpIfX3tGl9M5MFemFzPadcohOZg=;
  b=aOSQVx/leRYEMSdAKE1qZSvof0VRTmAk7QuQbFuNvxpzW14PvIVQVPgD
   /bEsYEmQqFEEr5uPbi/OMHwK6vzcIwEeGXRiQmfblG4m1lT+CxWyn81Do
   fv5zeHx7YVknByqfrEUpMKnQXGb+z0OY5bwHDyNFJ/BEn/EToIMD7M1KO
   Dibpz2IaUy9lXPBQn8Hm5Ku4IiVe7VNhk1+nxpMQea8LPdIWiYW2Fxipu
   2d5bPvCFv7zkTefM0UxXkNItgCuw9e8LeSloeQZi5zpNw/jXEQSn8CfSo
   LKggiYC9C8NaKaz0CTzHCD7NfhxgxEB02hTH7uglECz+fWYlo1HgYhCX2
   w==;
X-CSE-ConnectionGUID: esEyHL8GQo6AO49KVnGHZw==
X-CSE-MsgGUID: j4x2ejdZRHKUUCjr+6nTFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="89052"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="89052"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:19:17 -0700
X-CSE-ConnectionGUID: dEDkVcCaQ4a9JWnBDIPi5Q==
X-CSE-MsgGUID: YwdmLAG4QhuRiaOGBr8ABw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="228882"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
  by fmviesa009.fm.intel.com with ESMTP; 07 Oct 2026 21:19:15 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	stable@vger.kernel.org,
	Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max source width
Date: Thu,  8 Oct 2026 09:48:09 +0530
Message-Id: <20261008041809.3674538-1-arun.r.murthy@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skl_scaler_mode_valid() compares the mode's hdisplay against the pipe
scaler maximum source height instead of the maximum source width, so
single pipe YUV420 modes are pruned against the wrong limit.

Compare against max_w instead of max_h.

Fixes: 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/skl_scaler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 7994b983d509..7e65c4fffbc0 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -145,7 +145,7 @@ skl_scaler_mode_valid(struct intel_display *display,
 
 	if (num_joined_pipes < 2 && output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
 		skl_scaler_max_src_size(display, &max_w, &max_h);
-		if (mode->hdisplay > max_h)
+		if (mode->hdisplay > max_w)
 			return MODE_NO_420;
 	}
 
-- 
2.25.1

