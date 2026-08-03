Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACB35C19F
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798116; cv=none; b=XtWZ2LjhAK88WE2Xiuw8j2esia0R1hkO+Ox2YeBLtZivXwXAP6Fcv1YSjkRhvsazlbmpcpPmVjcWkLi16odwETr+sywGB9BRa9+Q0VsHnI2Sb2XNxq8huemzlVYg8b1PZycdQqumXV57hYlzzkzPY5+RKtGtj8S+f/zaN0k+oKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798116; c=relaxed/simple;
	bh=vd/o4E33cG6yRQHBcLg6CHRxRSa22YgWCAzgRM0vOUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO1n3x09buFTWxbrwb+5paSo783dHusgYPvtt/QQfqI/GPqfoTZeQQ8zREXkUO3HuU5mcTFv4Z5uhQWytzttGcJUbkDigNPmVnc8jFb4nPrkIE3af+A8snCjIOlruWO9wDAciCg4djYQDBekUbWQZebuH4+2QR+0JRmLmDUfgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jokh8Jbo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jokh8Jbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798113; x=1817334113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vd/o4E33cG6yRQHBcLg6CHRxRSa22YgWCAzgRM0vOUU=;
  b=jokh8Jbo4fbnxoowXLAUJulq7+0ZMLt7MkkTEG1hM6zaSNzPAKkzNAh2
   JCuvA9+BoTj/q4B9e51tIDfS5Sf06q/YJz2ouHrLjAj5XO8D/6rmt+RUi
   eFtFKo/lNWUGbAYYn++tFNuvENrharFak3+g/GJ1JvqvUfQiHihpvQj8y
   A0Bq4jcateKbbd0/U2PC51hL9/anz1UQckeMhZ7pm5n5CieS081mNZOC/
   eh7fuFLZi1nfsWdMHvKQmKDiDE9NPmzeX58GnQ9yg+tTpgtCA3MU8Ql4i
   HG3KfVNmaweXL+o6GTr+xSMTsc9XmGbD2RK+KyixMKIb8JUscl0irawic
   A==;
X-CSE-ConnectionGUID: /79bHyPVQTm6IsuDL/YD2g==
X-CSE-MsgGUID: wYDpu2OORwSPqIPipOx82Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871306"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871306"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:46 -0700
X-CSE-ConnectionGUID: wEx2eaDlTma7QxkwCZilRA==
X-CSE-MsgGUID: RYAFL5B3Se6Dp6E5/RXzTQ==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:46 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 8/8] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
Date: Mon,  3 Aug 2026 16:01:36 -0700
Message-ID: <20260803230136.3270230-9-ashutosh.dixit@intel.com>
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
 drivers/gpu/drm/xe/xe_oa_types.h      | 3 +++
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index b03ffd5134834..c0ddfae755b6a 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -126,6 +126,9 @@ struct xe_oa_gt {
 
 	/** @oa_unit: array of oa_units */
 	struct xe_oa_unit *oa_unit;
+
+	/** @whitelist_count: number of open streams for which oa registers are whitelisted */
+	u32 whitelist_count;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 2ecf273c5f401..dad47988bdf6d 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -242,6 +242,10 @@ void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	if (gt->oa.whitelist_count++)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, true);
 }
@@ -257,6 +261,11 @@ void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
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

