Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F2394798
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800044; cv=none; b=b0o6zUa3WI05R3p3YNF1KNktA+gPDFjNQAP40IBxyJj2GsFq9hmpcC/O/oKg0jygpBm1GnnDVb/omMyBrLEDt0vhMSKHPsDqKVcupOjztgN50XL6vY/xVmZO93QAoJUCiE3z/EgD+q3j+QGwOfx4/ql2OK3nYjrVmMh8A0HGSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800044; c=relaxed/simple;
	bh=kO1T/nouGhqlgvku0Spl3pQk9W8mtvVgIML3tTNBHJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRMtmJEZjL/Rh47zlMSb3atHCuAoAadtuvv+Hfiyf+/a4Xr2MJNixWs9cZ8dcKR0wkeT3r0v9xXJ4P8wJpOg9fG4k47P/M4MLjXTLqWxwDT93t9vlZ+PlDAKiCYQ4q/go0+h+Wt/f/wKISk84xaMJ/+Q/sO+XYTJLQLkvSWbu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ig8qOLkX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ig8qOLkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800043; x=1817336043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kO1T/nouGhqlgvku0Spl3pQk9W8mtvVgIML3tTNBHJk=;
  b=ig8qOLkXO8NLk75nQ72Rai0OKUEgKFBusxYtgb8GrZnL83hAsDUkkymD
   RRzD4WfTRltUDX4K3D2M3haThYnEKUZJQUzuuRulixCdUVtIPzJQh3YoQ
   4c/oCCChEDJ8ofBfyzFUfdT6CixV8hfj9G0p0i1nMnCrHqjF/gGEVQwu0
   fXTZPQLAAhRTlvZROzCWBTbngG+wjLU9UUrHIK21fnEnNEtJcvUq9PNpr
   rtf98GGWyiBXdQSHiVX/OCQMUtqFGA0HayycpwAd/1XB4/BLtJRmpm/3B
   hQ0JZeUw79ZqC/utCgpW5Xxz7G7MWg5G3cl4v+kLs2IhhCYl17oOQuKsu
   g==;
X-CSE-ConnectionGUID: srG6JLpOTL6MIXnBb7MRgw==
X-CSE-MsgGUID: y9GE0NloTdGPoriu+AceIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112932"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: TxljzK8pTDSQDXPVZs4+Gw==
X-CSE-MsgGUID: 7FZIQwWHTY2TThdgz6afkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838292"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 12/12] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
Date: Mon,  3 Aug 2026 16:33:46 -0700
Message-ID: <20260803233346.3277427-13-ashutosh.dixit@intel.com>
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
index fea9d981e414f..0faec73954b70 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -120,6 +120,9 @@ struct xe_oa_gt {
 
 	/** @oa_unit: array of oa_units */
 	struct xe_oa_unit *oa_unit;
+
+	/** @whitelist_count: number of open streams for which oa registers are whitelisted */
+	u32 whitelist_count;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 8a1c3f3c82973..4b70460d6e002 100644
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
@@ -188,6 +189,10 @@ void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	if (gt->oa.whitelist_count++)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, true);
 }
@@ -203,6 +208,11 @@ void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
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

