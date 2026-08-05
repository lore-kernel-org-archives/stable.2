Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6443BD62E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898172; cv=none; b=bSyAlO//gWlyYc2I9IvaEyCmGvdRP3RP/6A4r9sIKMco1c4/VVo1Y0cHGdY0affAyUsl2isOY/mcDtQV4UiN1s563VVqS6Jphw3g3OrViBRKMY5x9BfxlVbueftjCazkxuWvtykdf0Mr+NHMigVP4klkUwyYLPBrEePNe43DFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898172; c=relaxed/simple;
	bh=WDk+V7IlHWdA3e/4bnzX8x/lZwXm8vtdt7oLlHPTeQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNMIliK4rF2OLAaFnOxPobu6zuw6+Q5jvcwRWRW++i7REuR/0TuFbAp483yCCXHh5FOTmkhOmbx4YfXK+Tt3wryRqUWBQC8254yUXY8Isv/W5TUWY8douokO3VrOTOaz1Ds50FbI0THeSVekWjctkrTuBnnwRmZIf+XYSCby47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW2yCp0c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW2yCp0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898170; x=1817434170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDk+V7IlHWdA3e/4bnzX8x/lZwXm8vtdt7oLlHPTeQw=;
  b=UW2yCp0cNtNzepe6N9rkOjA5NkXPjSk+FHp89s97XDxs0XxKj0EhyyGh
   KhZ+Cgyh3L8FbtmVHg7N834p6kji2qCc3QZhV0AXEpp1zPOjzOrowXIFo
   4XDpZ5NPVdtICjZr3fmE12LtWP2wKemjxxRP/hLXMjHM4GqrBpZy3cUwH
   3fdgHiLeSnajEZHyDtbS9glWZ1lGIy41x5FL7gg+rr8Qf/ti+Pqs+l+Be
   DDf/1ypEfmyG4CIrsSvlA0vJXksUAP1spiK2SdoE+srqMeta9VCl/yb5D
   QJ1oae+mnFNlKLf89hFX8jaWiOGoidRjH0owHyIcFClKN4zwOolqZPrGf
   g==;
X-CSE-ConnectionGUID: evM68KIHT/WMVVxK3MrmKA==
X-CSE-MsgGUID: cpeYN3uYTzml4yvrJmzoew==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826143"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826143"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: tVlj5LofTYC1mgVoShb3nA==
X-CSE-MsgGUID: INe1BJ72SSKyD5x4c8g2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911801"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 11/12] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Tue,  4 Aug 2026 19:49:14 -0700
Message-ID: <20260805024915.3407033-12-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
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

