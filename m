Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B536074F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897988; cv=none; b=tPcvZMa6oq7/4IOwVcs2h5xjhWx8iMawWvK/6TEMpKfDlNZRt3CcBHD9xN18NGIvv2bwXAXtMAjKtig9gGF8Hqha0+vBhyBIWvpq8+wQYcSUzyBqY24MT7q/y/OV1E+lYqsFVB7C2uQGF8UuXbnpJSMd3/74y3p04bqNrdhZLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897988; c=relaxed/simple;
	bh=Wy8GXYfhD8Zxhl/UpxyaxaVXBdq99fWnBdJi+ZYoCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmbiJZCAcUiETxnRAxiPDmeA2nde/RXZcBpQ99Et7lsF0sW+hpQ44lvfb5OETP6vaMETlDYyTKzXN8BryKa2dAX6bA/1PNgXi4VX8lV39PTBh2RQjFf0w4vBNR7X+q6MIPwapJUrXDn89Ycy0rLizrIMZA1GEhSiiumFh1UqRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7jw/MxQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7jw/MxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897987; x=1817433987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wy8GXYfhD8Zxhl/UpxyaxaVXBdq99fWnBdJi+ZYoCc8=;
  b=Y7jw/MxQ17Fh/AyP5aiB17kaDy0KxjT2tzUFIALWGtRnM8xfZU8mC4Pk
   0e/+1/PZTVgAownqOMKYMG4hrj3RIq/qUpAVqvbVShBPAz31zI8gE8hmN
   6/HejlnfVlZU5y8oE5LrtY7Bk6yAJbvFk2FcyIgCGcWHQd4FVePJ/RjiQ
   32Hby7vaEXFZZO9k/BHPCkuFqkQbDIogmWc0DaBtQHFPorXeySUXVWGaA
   A3v+7U/+hRwqXRo1VR8BsfgTFTkUkgLmZwpUgMsxtbLtGShybA9v83E/r
   TLb3pJD0dsp/UXpnCxouVTovMxqVtC3FfivvHZlBV8D075yAt9/4CXcNd
   Q==;
X-CSE-ConnectionGUID: +i/QyJyMRh+QKXFwXqJEcw==
X-CSE-MsgGUID: HUNVOm2DQSmReKr8kl1JCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586060"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586060"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:21 -0700
X-CSE-ConnectionGUID: IqF+Pl5fRK+bzLhYLLaw9w==
X-CSE-MsgGUID: JctHBf7IR4ajF65ejH1yAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925520"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 09/10] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Tue,  4 Aug 2026 19:46:13 -0700
Message-ID: <20260805024614.3406679-10-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 63ddb3ad08ff4e89c108499dfec5e9be5ddc25c9 ]

Whitelist OA registers on stream open and de-whitelist on stream
close/release. Whitelisting is only done when 'stream->sample' is
true. 'stream->sample' is only true when (a) xe_observation_paranoid is set
to false by system admin, or (b) the process is perfmon_capable(). This
therefore enforces the OA register whitelisting security requirements.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-9-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_oa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 7d04591e297a8..98df9ee1cac39 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -35,6 +35,7 @@
 #include "xe_oa.h"
 #include "xe_observation.h"
 #include "xe_pm.h"
+#include "xe_reg_whitelist.h"
 #include "xe_sched_job.h"
 #include "xe_sriov.h"
 #include "xe_sync.h"
@@ -863,6 +864,9 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 
 	mutex_destroy(&stream->stream_lock);
 
+	if (stream->sample)
+		xe_reg_dewhitelist_oa_regs(stream->gt);
+
 	xe_oa_disable_metric_set(stream);
 	xe_exec_queue_put(stream->k_exec_q);
 
@@ -1887,6 +1891,9 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto err_disable;
 	}
 
+	if (stream->sample)
+		xe_reg_whitelist_oa_regs(stream->gt);
+
 	/* Hold a reference on the drm device till stream_fd is released */
 	drm_dev_get(&stream->oa->xe->drm);
 
-- 
2.54.0

