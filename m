Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3A395AD1
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799583; cv=none; b=ll1Q64QQ4MTpHHNtlFdKGKa4U6UDcgDy+5nwNPveoMKpC5qQt+kxgdOsSz5swR5f50LI1IBjFx+AkcjnJoyFwu9HeQRWGo5NAp3siWjd+F0wOi9ICpiK76/T/FNCFgMZ+tfL+WW8J2YeiLuY6gAABZ4gEXn0GfNi4skf5+7PRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799583; c=relaxed/simple;
	bh=3EU1Mi6WhiemK/dBwevgXyLCI/j0wSSbhtWGky3O464=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHGCE8W24hKKCji2KT70T1UVdxuCYFub0RVIMXa4veaJA2s0sfghguX+W5ApYbq0WgBfb9qjyhGn87FCzfdRg0mgzL75+7op33hwLlWy4Jg03U+uMWAINXbWGrDKI9M6FN/84N6zmWjNccpZZxUJahW8kE6YR4nPafj/61U2/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHddEwcJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHddEwcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799581; x=1817335581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EU1Mi6WhiemK/dBwevgXyLCI/j0wSSbhtWGky3O464=;
  b=jHddEwcJrHTfZh4Z2+RKDoKApVrEQ1439NH+mK2AUZxii40dugxGXceu
   P4w256jHLUme5aBSQHKuthXf3tziA2QRiETLgOvWu9lM7aUyOxuKwEzoS
   adop5qvauUdvova9JjGqMfUOx5bvkK8rx+dFMc5MbKBDSQyAME0Zn9LnS
   EVeUdfs2SV9OcwHSPqkCWSesNlcALO1oY8KETgfvb8mWDBRxNMUtDrRF+
   6rEHYIqQG/IbzirhOnCZ8dY5fc4o7coN8LqabRRldZ3tPASHMyRjN3YUM
   jZ/lZRm/1uwiCZ3NH/tdgQxwNYwM6gSDy40XSyCJ83choGNbcfYyZkb07
   g==;
X-CSE-ConnectionGUID: t6ba//6TSbG8ufyZ1R+lgw==
X-CSE-MsgGUID: dDaPKuqoSfi6Lt7FQBURhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232428"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: jUv2VoMuTqiOSZFrOV87dQ==
X-CSE-MsgGUID: t8WzxRB0RBumMgZtXMZ7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932559"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 09/10] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Mon,  3 Aug 2026 16:26:07 -0700
Message-ID: <20260803232608.3276045-10-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
References: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
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

