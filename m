Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AD37F306
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897796; cv=none; b=LQBvOmOHZrpw9YtK3QLjHmbbpUKSslLpSKvcrj7r8OsSEcB/m9YtogrPIU7jlsftjDlPWtfifNznZlQ7b/lm8cbb99TUs9mgpb6qsQs9VxLRxMBVgWqSPtbIce5/RYAh9unR4Q79nCQmS7h4n6IlUuKBmnymNr/IL5RVQuaPEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897796; c=relaxed/simple;
	bh=MNYjOcXPqLgOIJiU8JFJ7ZX4gA0ehEeqmLAcH09GytU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGUEBADVPFWbvZ3B4G/G1EhSgFd2KotDaaCZOzQ27dszh3G9fwUtbaznWxI8SEkiwiatykc4MSzTYegfSV4apYz8YPg9TyaxcVBJImPanrsXErD5aRDOX87UCsCIAjFVxnXsIpVZgtZnDhesckXvQFLUgAcLbfsIIQmQ8jv5x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf5Aezz7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf5Aezz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897794; x=1817433794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNYjOcXPqLgOIJiU8JFJ7ZX4gA0ehEeqmLAcH09GytU=;
  b=Kf5Aezz7N57RAmHGckrjv1pO9vEIWcz0kMLLVYFGv7UjGfIUDWxQlNxm
   rtphQw7YaM/rinu4u6bHiImBz0ai0+yyex6XXkKyE+gIm5tDYi/nSJ9vf
   CrSzLkBFIqIjNjKX0nJKL+22W292AtaOk76MFBJOG8vn/8aEIPxBumiEA
   tmsqkybC5F51IA6ojIZkUJNUktxGSnhDKb09umfCfJVP362WBnXe40cxg
   cuFXZI6p7sBUr0k9GiIqKzIzoDwGZLoKtPmWFrEArt84vp5GixTqV1z5+
   sGuVg0hKVlUqi3qzmYFHBKMSLuDdT/RcA45+kFJo1I6HF6a9xGTbfJAy0
   Q==;
X-CSE-ConnectionGUID: d3LiK6+wRa+w4JePrt9/Gw==
X-CSE-MsgGUID: XOAakMTJQmWX0oNJw4wLGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585784"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585784"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: xe300nNbTAWnsRHimYMJ7A==
X-CSE-MsgGUID: tG2H8v3fQpCIlfJIL2sN/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612681"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 7/8] drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
Date: Tue,  4 Aug 2026 19:42:59 -0700
Message-ID: <20260805024300.3406307-8-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
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

