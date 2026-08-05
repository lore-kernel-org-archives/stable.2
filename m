Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24E248881
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897796; cv=none; b=HAr/XmTBddIqeCgumFcxg2hjENITRmWNQcwL3JeXMzKptFY9z31i97RWW2Ynjno6gW+bDIgd0/sKYw+u2FOJp12WsKTQjP7BUZjcNBVajr+4P8I68diJ27I0PMbzCmii/sk9pm8OMwQ+s9Rllgv5qo3is+e9HhbUVQ1G6Ptv7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897796; c=relaxed/simple;
	bh=/jENn+3CWgOAde6xYRXg9hCP7oeEYY1tVcXaMW1w4O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0v6MOxId92dX1OfmkppEfQiiuETE2BSR93JsHVVIgXFaXqMSySrzk+YOzv/pOdYdYVrPezAv3mffrkUsZLV3vg5tC6boVkXFBJwLs8Qh9hjzhBXe4XF5UWZlLisA1nCBRwtUNY7qJCNE3iK8Q8t713+mHrgU5Ffh0e1G10XA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHSweMnq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHSweMnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897795; x=1817433795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/jENn+3CWgOAde6xYRXg9hCP7oeEYY1tVcXaMW1w4O4=;
  b=BHSweMnqfNZe9/lcWXCwSMq/lXr0fMG9jUvIVJpitfK5BcBPZh9EvzRX
   2SpUx8SZXBCQvYVNtQaKKaCBuQ/dDTO905HJdNCqmfWOeL+ix0izxQVVH
   HMssnwlJF3AksxcCUliaoJslMDqHnPLZUORiyW7ZIfVWsWEFH1xeq5c6m
   JnZ+wQZtUCmz1KXcXUZO08A5Hk5KJHwCuaUoVTF5Hmw8xkb9vrP4XJMxx
   uYuzPdQI1K4JAfUPSwTgv+V/UU4wB7HYtazh89pzUHDtlbAAqPUnuGIqV
   jOnV/dce753tyb47S03GCj8FkIux+gVQHD1dSJ/TKjc8vv04IOMcTYjlD
   Q==;
X-CSE-ConnectionGUID: NVqKuSvgSvOVP/sKwR+VEw==
X-CSE-MsgGUID: AbxKUCcbTOG87U419JC/kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585786"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: lx2kVQGtSLaG5l4ij/Tx8Q==
X-CSE-MsgGUID: rC9W+7dATj2dIkLVCICDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612682"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 8/8] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
Date: Tue,  4 Aug 2026 19:43:00 -0700
Message-ID: <20260805024300.3406307-9-ashutosh.dixit@intel.com>
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

