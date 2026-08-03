Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BE3955F6
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799582; cv=none; b=olLnzr2cfshHMgFmRcHYbi1lauB007QQpsK7NH5Jfo7aZkH8HdXwPCk16Mrd0XYllBcu9Br64KjtC3UbCpByN/gneMLB6YitpuP/GqmyYba90Vg4w+yAxzR6SbvBO5P6BCibvzDpoBeJWNM31Tfrtw9Pol6L56GCGveWO9QT0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799582; c=relaxed/simple;
	bh=gnEmvt3yhwCHOMCucveyHwDA4E5Rczg8SZPQ8d9s6xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep3tpKBae9WUONuxsqHFiPDZc6uVFDF8QDKsNSCwHysECe+K6wcx2PnWUJMJ/Qcx/nInacr3NQoWsjv15baYXqsOLItCPPgJctZGdSq2yIjUvlLiOqBUT+O/2vL9hdcinzbMpdbi/O9kw5A6uaH5vh6R3s/EVvo9FUp+90POTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwWe8aOo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwWe8aOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799580; x=1817335580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gnEmvt3yhwCHOMCucveyHwDA4E5Rczg8SZPQ8d9s6xE=;
  b=cwWe8aOogQYQPt2bs6CcCbouH6u3/SQonmmWr+6c8+CSwg5OPEq0ifc2
   NvJlR/6oESJ3Hd2luoqX004M/ojP+v+dJM86vkxXK0XNc1V7gRDCDrQVu
   mYWyvVTzxSyQ5Vm9irYeb2QLDfDltvi8N72A0GmPUA6IQjWgZ+mBXUYDj
   cblHnwJjhCkl0cn73dv5Qs0W0VSb/SpiQQsgkMfgpUpkFi2xSI7hi7p59
   9M8zm8aJ/+zt8JQmHP68V9pXACcAlqJX30ZRcvfC7NcL5J4wMMhnBzUx2
   J6CYv69FND915pZgYgXtsuR50AsdFZO4aRF9kqsy/oObpkplxUoCHarRO
   w==;
X-CSE-ConnectionGUID: ryw1dKYeQ+Kd5/+Zf7R7uA==
X-CSE-MsgGUID: R4nIMBKiRKSdEIXw9HixHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232431"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232431"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: wlZnfaT9QBKQk/WZWUhjXg==
X-CSE-MsgGUID: 9X04fX6QRMWCE8gn3e6RAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932560"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 10/10] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
Date: Mon,  3 Aug 2026 16:26:08 -0700
Message-ID: <20260803232608.3276045-11-ashutosh.dixit@intel.com>
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

[ Upstream commit 645f1a2589bd4782e25490e5ecc05b7043c36cbf ]

Since multiple OA streams might be open in parallel on a gt, ensure that
proper locking is in place. Also ensure that OA registers are whitelisted
when the first OA stream is open and de-whitelisted after the last OA
stream is closed.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-10-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_oa_types.h      |  3 +++
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index daf701b5d48b9..48f9520f560c2 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -125,6 +125,9 @@ struct xe_oa_gt {
 
 	/** @oa_unit: array of oa_units */
 	struct xe_oa_unit *oa_unit;
+
+	/** @whitelist_count: number of open streams for which oa registers are whitelisted */
+	u32 whitelist_count;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index e77f50da4a268..eb1d6f52f75fb 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -9,6 +9,7 @@
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_oa_regs.h"
 #include "regs/xe_regs.h"
+#include "xe_assert.h"
 #include "xe_gt.h"
 #include "xe_gt_printk.h"
 #include "xe_platform_types.h"
@@ -187,6 +188,10 @@ void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	if (gt->oa.whitelist_count++)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, true);
 }
@@ -202,6 +207,11 @@ void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	xe_assert(gt_to_xe(gt), gt->oa.whitelist_count);
+	if (--gt->oa.whitelist_count)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, false);
 }
-- 
2.54.0

