Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FC395AC7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800042; cv=none; b=Px0usgwSBEke5T3w4wSbl5csZ4da96mluIjB/P20D6100qhuDZ0XKpR6gCf9JeDBH/8jJF6aD2k1NRXK0P11+srCZBpKHJwvDik5ONXMGl2IrvDQIE0vz+tMRsknMhd+fFLoNVMrfL2K5hkosU2TxqxMh7qLzJsZo49sIj862SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800042; c=relaxed/simple;
	bh=3s/hStrDapxb92P1hPYBWVQNmRZRyvlEGo+B8VTo3mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KK6KgyW47YwV2uG8Tb3iGpp4cBn9VKbtWvvU4tapXkqyx53Jk4JYmQ8lAJK/JtsNdAIExy1iqoFWWnthDeDq7Ncu73Sm1//uDJf/8srHvdyRsWfKdUtbNHskciNiRVrHoqVl5mSwLEJkghbTCZf+qVkEVtwZJYYHBDEha3v1z6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDqHxxVd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDqHxxVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800042; x=1817336042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3s/hStrDapxb92P1hPYBWVQNmRZRyvlEGo+B8VTo3mg=;
  b=dDqHxxVdmiN7YgNHr2dsoXJu+CKtHsoar60TNyoJvjkrKso6J6IpPWCe
   59ieWMXkqRfhy3IuImCEVMxtf4PlCXgnOgJx2KmTRxjS9h8GPeL8m71WR
   ebA0yO38KIbNYetglFG4lUn8OqMEk231JczvtEbshyx6VneTY+KigU4v2
   uiibBnp1zpDDJd46EaOKAYLeWzV2n3tqFj2XCS9h0OJzVOda23z++MxPL
   lPyQXW5q6KUiaprGADCkq424vwC6wvRAxXkj0t/Hiw1UnLkU1D7EPPi5h
   9Eq79U8Pktfn4CLj7Yo4CXHJOslsU0clw+fPNmLzYULCW3P/El53t8sV/
   Q==;
X-CSE-ConnectionGUID: Uoxo3vumTKy6vgSKlc0pjw==
X-CSE-MsgGUID: lxyRj8l4RTS+cMsiLKL8gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112929"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112929"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: lwOlDtWdRQaSujXLyda1XA==
X-CSE-MsgGUID: ubNXIrYqQX6V+a5OtAq6fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838290"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 11/12] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Mon,  3 Aug 2026 16:33:45 -0700
Message-ID: <20260803233346.3277427-12-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
References: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f8e6874f46f19a6a2a0f24a81689f90641bb402a ]

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
index 5e38afc46e20e..476d887749a9b 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -34,6 +34,7 @@
 #include "xe_oa.h"
 #include "xe_observation.h"
 #include "xe_pm.h"
+#include "xe_reg_whitelist.h"
 #include "xe_sched_job.h"
 #include "xe_sriov.h"
 #include "xe_sync.h"
@@ -836,6 +837,9 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 
 	mutex_destroy(&stream->stream_lock);
 
+	if (stream->sample)
+		xe_reg_dewhitelist_oa_regs(stream->gt);
+
 	xe_oa_disable_metric_set(stream);
 	xe_exec_queue_put(stream->k_exec_q);
 
@@ -1868,6 +1872,9 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto err_disable;
 	}
 
+	if (stream->sample)
+		xe_reg_whitelist_oa_regs(stream->gt);
+
 	/* Hold a reference on the drm device till stream_fd is released */
 	drm_dev_get(&stream->oa->xe->drm);
 
-- 
2.54.0

