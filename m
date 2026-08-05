Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAC4F5E0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897988; cv=none; b=dVOMo0HqrSJbRR1ItoszymXiMKdaWOWGu9Kv+5DvMQkaTR6DijHaLpCusJ+OQOTSkOF/EnXvuyo+n0JQOi8i7MmzB9qcFKynP2E+k36UMdCCIVVc2R8FpnfVKbF0LuRWr+IdbNIGFzS5maRxUaDflZ0hhZZrHvS1bO45u7UDdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897988; c=relaxed/simple;
	bh=il0nqxR8e3O5HosR6t1E5+pb2K2OsYBLYV6U5cOCwcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzqZzKA6YpF85uuZhizxBoKCTRjSvDM70VAdzezNZYMEvklvxDRmkCcXTQ3+ccmd2LxkcHroLbCYy8DrMK8D5bRIy+f3THeICgQcN1QJeNHI+9XicOMm6cIZXEGiz3MUaoWsn537W1or85umGpcNXJuDbgC3gCusa4kOYQXuAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmNhkD6T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmNhkD6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897987; x=1817433987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=il0nqxR8e3O5HosR6t1E5+pb2K2OsYBLYV6U5cOCwcY=;
  b=FmNhkD6Te/KgDzaCLZn9RiiECVC/9fYAaOEKknn9Gbu0niSe6N3TEajH
   8iMIHVEUIu+qJAuRc+oqoMKqKWgu+92SxyiguTlgfF8bHmeWaZWwuucBe
   g1hyKF3yWJUF/nZy9G8nRPufhSpOGPdX+EG8hjChEgMDA58mMPFChdCbI
   yE19zMevtVViHS95G7CFNkDeXoYjP1ylldbcV4vyk3BN8oyHXnCAd5Ik4
   pGkK4G+egT7e8dPC87VPm+7imXd2e5Ee75AwkvSl6F6+UdbMaSj99dvpM
   vP7dsIVSSh8saHUZyG8H+Tf6Z1vkIh6kXTVMzgBA0yCVlqZgUDIhm+qDY
   Q==;
X-CSE-ConnectionGUID: laTQkGbqQ2Gvc5RMVKxMcA==
X-CSE-MsgGUID: loR0h4fSQ1yzGutEw3WU+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586058"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:21 -0700
X-CSE-ConnectionGUID: gfF38F7+S+GA/BY9uCVXsw==
X-CSE-MsgGUID: BmCymwbFRf+GAvKGRNj1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925519"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 08/10] drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
Date: Tue,  4 Aug 2026 19:46:12 -0700
Message-ID: <20260805024614.3406679-9-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ebba7ce65252a4ab0e3794ff14854df2afca5c08 ]

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
index 4922b3561dbf4..e77f50da4a268 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -9,7 +9,7 @@
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_oa_regs.h"
 #include "regs/xe_regs.h"
-#include "xe_gt_types.h"
+#include "xe_gt.h"
 #include "xe_gt_printk.h"
 #include "xe_platform_types.h"
 #include "xe_reg_sr.h"
@@ -161,7 +161,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
-__maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
+static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool whitelist)
 {
 	struct xe_reg_sr_entry *entry;
 	unsigned long reg;
@@ -176,6 +176,36 @@ __maybe_unused static void __whitelist_oa_regs(struct xe_hw_engine *hwe, bool wh
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

