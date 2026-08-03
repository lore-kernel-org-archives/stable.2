Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C635C6A1
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798114; cv=none; b=NfmuyshjvJCf3FAtUTRwXeimlD58FmEEOeuZwn3PTukaeTklX6AUJj2GPtXwz8RNZfE2Db0YrcE7RcPPZIqe2DIl0p/icGDKp3nTWvdnsYP2fVTOCHFjP+NjYwAtC9sh3uddmTd2HZpWxiDTYAB/fbaicMo+E4iMbeJaYWsPDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798114; c=relaxed/simple;
	bh=FSlpLQP/3LqWHnrrTFJhMTk13Nu2AJtpANS8jD+tlHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SojpmXiHBQj5m7klMd9V+xf6HB80nddy3OK6Ms2dwrK0Yn1SLx6OBG1NBmNGE5bILonSVQaQesu/L06IlHdV3jS5BJUmCJMvfvToiH+o2s9mC/NcAXOxX9lkTOvXSLI35m4BADSG1UkXDyhxUAZaAdxdROP3Sg5fPONlPVeUlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/i3eZOI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/i3eZOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798112; x=1817334112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSlpLQP/3LqWHnrrTFJhMTk13Nu2AJtpANS8jD+tlHU=;
  b=I/i3eZOIFYf5gz2Dgl8ALKfJ3+bJrex53pfh/gxm4Bh51DzWz4uafvTF
   T6bmIQo4bNB356Sf5vrhEK7+Q4wGMxeosDFibiE1NLsUoExOiwj8YGptX
   pfqy98rI+gld2NXJ2TILzEog22j39xPdRewnd8DvNquuQjNR+eZiAZ/Vr
   JW1mg9vuDFYsWGNVEo7CflSklw5ZwIzHY3Oa5gbN9MxV3S0QI5fpJDUeb
   GLkgpbeMHhrsXFv6sglDehXzATU7lrEwLd47KEDLWaAH7E2jPQEYtz4VR
   2mAapn4hJSTJ2LcTJOT4NVpCXgeeH2vNC+sT8FzoRrQ17QwBPhOL1IJI9
   g==;
X-CSE-ConnectionGUID: rYwNcrtHRmKnbn0hj7qiSg==
X-CSE-MsgGUID: 6BncpmVhQeSv3fXNYwl7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871300"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: e/jwFeSYQGOWCqtpVTIhaQ==
X-CSE-MsgGUID: tGVcyEqIRGmLD8pTxBjv7Q==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 6/8] drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
Date: Mon,  3 Aug 2026 16:01:34 -0700
Message-ID: <20260803230136.3270230-7-ashutosh.dixit@intel.com>
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

[ Upstream commit 6f73bf8fffa728aa5d5ee143ba318fa0744113a2 ]

Whitelist or de-whitelist OA registers for all hwe's on the gt on which the
OA stream is opened. This simplifies the case where an oa unit has 0
attached hwe's (but which monitors OA events on the associated GT).

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-8-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 34 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_reg_whitelist.h |  4 ++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 1a53abbd9a74f..2ecf273c5f401 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -9,7 +9,7 @@
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_oa_regs.h"
 #include "xe_device.h"
-#include "xe_gt_types.h"
+#include "xe_gt.h"
 #include "xe_gt_printk.h"
 #include "xe_platform_types.h"
 #include "xe_reg_sr.h"
@@ -216,7 +216,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
-__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
 {
 	struct xe_reg_sr_entry *entry;
 	unsigned long reg;
@@ -231,6 +231,36 @@ __maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool wh
 	xe_reg_sr_apply_mmio(&hwe->oa_sr, hwe->gt);
 }
 
+/**
+ * xe_reg_whitelist_oa_regs - whitelist oa registers for gt
+ * @gt: gt to whitelist oa registers for
+ *
+ * Whitelist OA registers by resetting RING_FORCE_TO_NONPRIV_DENY
+ */
+void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
+{
+	struct xe_hw_engine *hwe;
+	enum xe_hw_engine_id id;
+
+	for_each_hw_engine(hwe, gt, id)
+		__whitelist_oa_regs(hwe, true);
+}
+
+/**
+ * xe_reg_dewhitelist_oa_regs - dewhitelist oa registers for gt
+ * @gt: gt to dewhitelist oa registers for
+ *
+ * Dewhitelist OA registers by setting RING_FORCE_TO_NONPRIV_DENY
+ */
+void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
+{
+	struct xe_hw_engine *hwe;
+	enum xe_hw_engine_id id;
+
+	for_each_hw_engine(hwe, gt, id)
+		__whitelist_oa_regs(hwe, false);
+}
+
 /**
  * xe_reg_whitelist_print_entry - print one whitelist entry
  * @p: DRM printer
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.h b/drivers/gpu/drm/xe/xe_reg_whitelist.h
index 69b121d377da0..f243b6ac60b7e 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.h
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.h
@@ -9,12 +9,16 @@
 #include <linux/types.h>
 
 struct drm_printer;
+struct xe_gt;
 struct xe_hw_engine;
 struct xe_reg_sr;
 struct xe_reg_sr_entry;
 
 void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe);
 
+void xe_reg_whitelist_oa_regs(struct xe_gt *gt);
+void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt);
+
 void xe_reg_whitelist_print_entry(struct drm_printer *p, unsigned int indent,
 				  u32 reg, struct xe_reg_sr_entry *entry);
 
-- 
2.54.0

