Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6F3B637C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666644; cv=none; b=HZiy1HQ8rixYqwL3WAOu5XxbgRYhymmhCfiEPpZEu4mxTp2M/LW38mf8W9CP2voXG4AXt8614McMldD+r6HSFT7xW92+2qiMQb/KpWP++A/rXreHL9hvG1RYjrcB/qg68r7CbAnIXjgYVqaWUvcx8OxnA5aa4U0st5oXwMuylKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666644; c=relaxed/simple;
	bh=ujuuPtTMhapUF03co5hOJM+7cFnNCSg9KOpLT2PeRvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kadRkrUXNA5w86U2ZpVBl9yEy0v3f/QK6J8ZNw5FfbZRZU5M8Gtypz7X3TtVvQQu8R3i4zXCVe/8CXaPyHr5/LKiJoG2fIcrtHruF4kIp1llLxXmlyyqBlnRtYqe5YfsEG3XLOO5IF2deJV3Dx1zIbwLNPqMYrovyYTj9p6N02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfGRvioJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfGRvioJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784666639; x=1816202639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ujuuPtTMhapUF03co5hOJM+7cFnNCSg9KOpLT2PeRvE=;
  b=cfGRvioJs4Wwt9NGmhiCa2g2GVA5cW/jXZXw7++mAqgUBNsqi+OEbJVo
   xZH1CLnbDk/W1+pSW+FIoBUcaRhC4RMfAWxZDXCldmjkonEHgIcUUUS69
   fIwU3WwDP+Qwr6VDITp2+7UbtyDfoyTvZgcZ7V36w7zWt0wwUyu9r10sJ
   Cly72uJ0bSlwnhs94MKhRCEI64TTbsOBeQxqvpYDKPeN+tnXpQkcb5pxJ
   1WoQJne5vkCPPxDDa4w8Yg9bum8C2DyF11bIVL6f3FtE0+aEhCDmPf27B
   IUxCO45vMkOMiu9QIuXAeqI8cG4pCY/Ujvocu7F2GmQe8mQMO3pWogJD9
   g==;
X-CSE-ConnectionGUID: UFYmYkkgThy9Kjm86UXFrg==
X-CSE-MsgGUID: coau5EkhTjy1BDTg4lvrag==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96798331"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96798331"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:43:59 -0700
X-CSE-ConnectionGUID: t7Ju8d6FQyCGP7337Vr8jg==
X-CSE-MsgGUID: XFFRVyMSRfmFNmwf9n5K0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258538139"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:43:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/pagemap: Clear driver-provided PFNs from migration PFN array
Date: Tue, 21 Jul 2026 13:43:53 -0700
Message-Id: <20260721204353.1082632-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM pagemap overloads the migration PFN array to store driver-provided
PFNs before calling migrate_vma_*() to finalize the migration. If an
error occurs during the incremental copy phase, the migration PFN
entries are reverted to their original state. After reverting the
device-folio mutations, clear any remaining driver-provided PFNs to
avoid confusing the migrate_vma_*() helpers.

Also clear any driver-provided PFNs if populate_devmem_pfn() fails, as
a precaution against stale entries being interpreted as migration PFNs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to_devmem")
Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
v2:
 - Be paranoid and also clear driver-provided on populate_devmem_pfn()
   failure (Sashiko)
---
 drivers/gpu/drm/drm_pagemap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..892b325fa99b 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -727,8 +727,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	}
 
 	err = ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
-	if (err)
-		goto err_aborted_migration;
+	if (err) {
+		npages = 0;
+		goto err_finalize;
+	}
 
 	own_pages = 0;
 
@@ -807,8 +809,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		msecs_to_jiffies(mdetails->timeslice_ms);
 
 err_finalize:
-	if (err)
+	if (err) {
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
+		for (i = npages; i < npages_in_range(start, end); ++i)
+			migrate.dst[i] = 0;
+	}
 err_aborted_migration:
 	migrate_vma_pages(&migrate);
 
-- 
2.34.1

