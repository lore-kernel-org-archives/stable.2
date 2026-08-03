Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92435AC2C
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798115; cv=none; b=exdsh2uJu8HtSaTBu+m4U0ncp5iISDnG+ttRWYx8TkcLQjan02i9OLe/5Lagy8ApfO01npxJ5/oUtkFL9DmX30aY34XeP09/1Ro6aavEbzjCFg9qoxj+m3K//wIrSEvxB8lgueiwhc4u12iAQ2ZL/RAQ52UJSMSiBUIasiT8qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798115; c=relaxed/simple;
	bh=vQ2Hc7Bbs+uE2pO4UTzL09ug0555xEJGdk8INNrnj14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enoGVddHGkLD/fKi7juVE4dzb+p4d/mFkfjDZvWLK39MdVGHy6uKSTm2AMR0TlrhKE6R8P3o7s3aOUa1f1o5b7Ywqx9hMvOBCsTePaAcBtDZMehV50xsVWWdZPmcWEQgBdsvl2ulic3bJNVlPTEX3OsmacletbPQA+yVExa9Crw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKl2ml4X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKl2ml4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798113; x=1817334113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQ2Hc7Bbs+uE2pO4UTzL09ug0555xEJGdk8INNrnj14=;
  b=CKl2ml4XWT2EwXSf7kZZxyyBSGxe6CbUv7RvQPg7teIarJ4Clz/askXM
   vOEg+P4mYY8BGoT182/RaS0Be5OSjrEydpfPM3apB3iZV4OhG9H7WWHhm
   YnbySpGKZD04StDqwgoA9o7u7m8DSeZbB8T2U0AVzTJggirSOe/Ee5Kc9
   kOaxgmPWTBol4EpWuOho0rvKwfC+i2jN34hmvTNQFz4przPK2XiguwU8n
   2KMtopq9KcL31X0Sjq/DHumrtWFycdLDVNVu7Z5QqczVOtDcPT4V2RuZj
   mcTnrUVH9USQ3aEW5egybyoY+kPbVXqZ5P1/hvH6IVRGgqDsfv3UYUnT7
   Q==;
X-CSE-ConnectionGUID: qZO4rlXdTqWhMwSshkrqGg==
X-CSE-MsgGUID: 5VClWD6QSs22JXuslQZ31A==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871303"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871303"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:46 -0700
X-CSE-ConnectionGUID: nvAwyp2aQtekgLQCZfhlcg==
X-CSE-MsgGUID: J1HDOc7uRfOiWrSsAzzWjA==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 7/8] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Mon,  3 Aug 2026 16:01:35 -0700
Message-ID: <20260803230136.3270230-8-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
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
index d908f4e039063..5111c6519c6db 100644
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
@@ -866,6 +867,9 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 
 	mutex_destroy(&stream->stream_lock);
 
+	if (stream->sample)
+		xe_reg_dewhitelist_oa_regs(stream->gt);
+
 	xe_oa_disable_metric_set(stream);
 	xe_exec_queue_put(stream->k_exec_q);
 
@@ -1871,6 +1875,9 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto err_disable;
 	}
 
+	if (stream->sample)
+		xe_reg_whitelist_oa_regs(stream->gt);
+
 	/* Hold a reference on the drm device till stream_fd is released */
 	drm_dev_get(&stream->oa->xe->drm);
 
-- 
2.54.0

