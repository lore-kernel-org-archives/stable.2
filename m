Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524130DEA3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898173; cv=none; b=UFItRjnTI3luKtQqDi0jXHVwkJfuK/Amat/ew1tGA5/Fuq+ISBekRyoTAoHpgO9XarZlrVQdSE0453cW7J7OCPHXblFHXh0mBJMFokVWfD5d+Z+1ambsOWvJXxAA36brgf6yiBLatr74nRlY6kcPT4beP40nehUG0DbHDwdJqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898173; c=relaxed/simple;
	bh=Vt/wxt2eWLUFE9geyDCH4JCots7eZV3/PsdalNtCx4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWL8jHCqNQyyNBywx7QZS704ghPJk0Q08ZRpySXRMDuhQOnzUlOiO1BWurnNnSoCzTCPXJAfYa8lNDSphfhF7IhipBRANgnzbNKKAwLCVdsjZ2mvyZkHjaF+mDAIbO7qphDoJx8EWJs8M/Hb8MMpL83NC+CfyGtLwnajXQBSFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sj2avans; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sj2avans"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898171; x=1817434171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vt/wxt2eWLUFE9geyDCH4JCots7eZV3/PsdalNtCx4Q=;
  b=Sj2avansilsnnWpJE6PeurUjZg15SX5ZIP2X7/cdZp3rKbAQKJYSadAI
   3J1BsUz8OXsReoR677wI9dNRGzOk6+EVng5VF4vuLSr4TXxzjzRUPorVO
   dxTYwZjV7i3NpoeOXWIn4uzeRkE2KD6XBmx9ziIczufEaXbzEmEpOxrlY
   HfoMPRwyMETUIqtdY15eiSt5sxDr/5aHKIaAbfAh2HBWl5j+GzeUe00r6
   qOckQdEjdB0mel2+Dm3cWubVEKZBaDAO4AZ4UQFZ6+Hklf0lBp8eb8hNn
   ER2juDc3YyMtdPBdb7rKfztWK4/EZxQe5hVLjNQcMFy50Ux8pX6jzP6rY
   w==;
X-CSE-ConnectionGUID: Tq4sw3HHSIyYUfpzOjMFrA==
X-CSE-MsgGUID: 5eUc1dXMQt+hW73zKn0TCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826145"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: aUQwKdsVQOqgpIJjB+yibQ==
X-CSE-MsgGUID: Lu2qSNBrS+uuWy0onokAKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911802"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 12/12] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
Date: Tue,  4 Aug 2026 19:49:15 -0700
Message-ID: <20260805024915.3407033-13-ashutosh.dixit@intel.com>
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

[ Upstream commit ef78e2a22f72c892fd6663f0760abd208d49a3e2 ]

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

