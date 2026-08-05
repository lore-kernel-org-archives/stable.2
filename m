Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AB23D7DF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898166; cv=none; b=EDWwVEyBl/cA7D7RsbAgYZzbJhsE4rcryrVGSpSneHYEEC0rdBQ1q3PbFe8Ra/9STBA2pJvM0bk1FCqZxtS+93CGJNWRuaGTn395E1z1ANvC8D3tzmWH/IgL0PLRaMT/zsFK1JK1QVAIMyASw8iUpu4AJ6VJTG71SVBwJOrXgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898166; c=relaxed/simple;
	bh=ihdNjvevTf67joVoOEHu00XbFYyaWDaLsbZtqxEa1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQq7QdgZBtn9cbztwjL2KXRkQUrD3IlBcoqIFQ1p4mJc5TWDiSRWnBYrF3k7qj+QcEtDByDV3eJWVbYIZEMFIkcrAibvDdelQOmk+3oULsUbLSQv92jOYXSSq2yI7BhDlFZOaoJQUEsLnuRBuxgCFeK8DhzTyp9xhBdhxdYA+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCl98Zu2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCl98Zu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898165; x=1817434165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihdNjvevTf67joVoOEHu00XbFYyaWDaLsbZtqxEa1vk=;
  b=aCl98Zu2br9GJcWOgdfwGzsdePyv6MVcz3c1CjT2V/Km1rEPUcUnDS72
   MyEvDcWwJJwlZctxiE78rSZD8CcTC+g0AeqIkt7GAh/EeoS0j+s12Jh3p
   lKO0jQpLwmsbTtRp3WT8mH2cvatZlsIUnnp9muTpf0wQHS0kcqcIXBvE9
   ek9w73XDgz7evRsR/QZQ36skgK8R9e4i6kfryU7dqa9UH1f5LCz4DNe9Q
   1BwxKWnaiS01c1iWCT07snPqLM/eTFIhjiRihNzGR8CHi+SSQvJAMAMmp
   9Mbz1xHP6ErSWyr4ydHInWCkLWdG4C415OzSVJNAwfEAVbHAZPCZ6wyUg
   w==;
X-CSE-ConnectionGUID: icqDrieTS9iXktsFe88bAg==
X-CSE-MsgGUID: STTLlsBnTTCfUxeOCKhd/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826121"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826121"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:21 -0700
X-CSE-ConnectionGUID: 0wqHiT0VTZ2itQaxQnmcdw==
X-CSE-MsgGUID: F5K5tMSIRTWEUCe+NQkswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911787"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 02/12] drm/xe: Introduce xe_gt_dbg_printer()
Date: Tue,  4 Aug 2026 19:49:05 -0700
Message-ID: <20260805024915.3407033-3-ashutosh.dixit@intel.com>
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

