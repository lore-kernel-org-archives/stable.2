Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6983955CC
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800036; cv=none; b=qv0hV6JprULzx8bDD1QRZ97zAYSAeH9veNhlLIvxVEYs66ePu6Ol4x0QAnn45X8WKIWp0zX0VbZ20rW4MjiforPUdrfmGEwebM32LJ/qo/VpEtTD4LcBxpO72kdicXowG2Lf+Ejz14+VC/TQ1IzXNK7Yni8DE96q4dETJsTxJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800036; c=relaxed/simple;
	bh=ihdNjvevTf67joVoOEHu00XbFYyaWDaLsbZtqxEa1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/ocaNwFlsJ7/hdehODEW13uL7fec4q2pvJzQdaOoAYkVr4iqYyKUdUINJgb1d35GByNIg3yTZ8EQkyGkHrpJ7kS/YB/PF5km20ltoM96z2oNHm9LLO3pqiPGasIJzlF3YHitQjTQRmyqnNY53xKMAikIU51moM+DWhNxaVy66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJwuUG6m; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJwuUG6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800036; x=1817336036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihdNjvevTf67joVoOEHu00XbFYyaWDaLsbZtqxEa1vk=;
  b=jJwuUG6m9FiHQoegsKGoQUTqgQWlA8JQMhWA6mfi08CafC2hTWc1HNGQ
   J4O0WbMtldP5G3kyT6Ap2baHnQoSA3HyCs54zCRfQrt+5m0pMgxJgXDig
   ZvomXnRc8RaaRzCFRgyeKmzC5hHldl4zmxjnwjujmKu1rWi51edsUHBWw
   Vvrc58FQFtjTz8Vvz5dHfnZffeue5laPGH9Dy3MnIlNfTGmt1fpve9Tnm
   P1Xh6OjycFpGEJfzfqUp+wGq7rMMUQPMDvj/2fBl8hXyDPIdqRnicaxAS
   ZP0IvhPpghc1k+c0MkSYy0xMKHRj100ZErOZ5pQH/7GDBGFj1UXobFQPJ
   A==;
X-CSE-ConnectionGUID: OzNMYi9mTtaDd9GQXuG/Tw==
X-CSE-MsgGUID: WjpOVEYLQbKROY2Ub2ljOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112901"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: Bqpst3vrSBKdQpJNE+2mow==
X-CSE-MsgGUID: z964HtNcQ0C5bf/sTuqnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838281"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 02/12] drm/xe: Introduce xe_gt_dbg_printer()
Date: Mon,  3 Aug 2026 16:33:36 -0700
Message-ID: <20260803233346.3277427-3-ashutosh.dixit@intel.com>
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

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 26582fc61a923e81832df8d5a169bbdab095d15e ]

We didn't have GT-oriented debug level printer as it was hard to
correctly show actual callsite annotation. But this is now doable
from commit c2ef66e9ad88 ("drm/print: Improve drm_dbg_printer").

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241209232739.147417-3-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_printk.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_printk.h b/drivers/gpu/drm/xe/xe_gt_printk.h
index 5dc71394372d6..11da0228cea71 100644
--- a/drivers/gpu/drm/xe/xe_gt_printk.h
+++ b/drivers/gpu/drm/xe/xe_gt_printk.h
@@ -60,6 +60,21 @@ static inline void __xe_gt_printfn_info(struct drm_printer *p, struct va_format
 	xe_gt_info(gt, "%pV", vaf);
 }
 
+static inline void __xe_gt_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
+{
+	struct xe_gt *gt = p->arg;
+	struct drm_printer dbg;
+
+	/*
+	 * The original xe_gt_dbg() callsite annotations are useless here,
+	 * redirect to the tweaked drm_dbg_printer() instead.
+	 */
+	dbg = drm_dbg_printer(&gt_to_xe(gt)->drm, DRM_UT_DRIVER, NULL);
+	dbg.origin = p->origin;
+
+	drm_printf(&dbg, "GT%u: %pV", gt->info.id, vaf);
+}
+
 /**
  * xe_gt_err_printer - Construct a &drm_printer that outputs to xe_gt_err()
  * @gt: the &xe_gt pointer to use in xe_gt_err()
@@ -90,4 +105,20 @@ static inline struct drm_printer xe_gt_info_printer(struct xe_gt *gt)
 	return p;
 }
 
+/**
+ * xe_gt_dbg_printer - Construct a &drm_printer that outputs like xe_gt_dbg()
+ * @gt: the &xe_gt pointer to use in xe_gt_dbg()
+ *
+ * Return: The &drm_printer object.
+ */
+static inline struct drm_printer xe_gt_dbg_printer(struct xe_gt *gt)
+{
+	struct drm_printer p = {
+		.printfn = __xe_gt_printfn_dbg,
+		.arg = gt,
+		.origin = (const void *)_THIS_IP_,
+	};
+	return p;
+}
+
 #endif
-- 
2.54.0

