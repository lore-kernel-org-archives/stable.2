Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000A472534
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665207; cv=none; b=m59pUIW7RJmfxe3YUoDXdZxPnWIFQ0zpKlPuJ9rVZkZ7o/GNcpS1pVuTt3kgesh4d2qUTGDV+q4pWUZ1Q5xPirb0ugAiS+uXsbQfb9wlg9gtsu6+usWuBbb2Ygzzsfx3BzRgyFsN85KO8GI2aZnBQ1K5tpq2w2XQiF3q1aIqt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665207; c=relaxed/simple;
	bh=PNIej+pFL396EvUVvZLG/dYSWwiLpVcQZci6t7vie/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmCIGK4lovZYiEKV/8XAWpcf1I+DwNq2+54GUvESJD2Bj/bcBjsoVCEZhN6WjpChlRPbia4N7RhPeTgp8rp9wpJB8AxaCjt03qnFgKYlHHICvwgv6nm0G5r0hrVp367CTB+ZDVmpVR6L3zI06x0OAylMcm7vREyA5dQInmYNoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpA6oWjJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpA6oWjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784665204; x=1816201204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNIej+pFL396EvUVvZLG/dYSWwiLpVcQZci6t7vie/A=;
  b=dpA6oWjJ1ECpHkMnyxgzdspsBPWPhVPOh/2DnTtQvneeq+jfpjKH5sS9
   lQ0HZYb5yJEQHEqVY4dhgNyhNZvWQCzpVLYoZipfW2120swBi6qK6jbPz
   TeY7Hq9oavlFtOO00tGMbBi1ukl1NsK/awhW4ofOu5u29y9PRtHrpX13+
   YEgwSdnAqo2MMfyjTO6VcHsZ+eA2swP9GYo+TDx1h6Bl6wCCb75un2r0v
   /9ZQoZXqf+inDVTztoVA7xBRFKmmL2KxBb4HSiVVR6s1sdhX38qobQ9pE
   eztx8AE28HFv8ZT68DfpFI+zc+Ni1DUPumKDNfFhgXdOHQ1+N+7050nhU
   g==;
X-CSE-ConnectionGUID: jKh/hzw8TkaAGoHKFAb8/w==
X-CSE-MsgGUID: ETuxt7sGS9e2pye0B/5GSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85319677"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85319677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:20:03 -0700
X-CSE-ConnectionGUID: owA6kmc1RcSAN6EXHsa4Fg==
X-CSE-MsgGUID: s8A4Ql16TtaMB1dssZIJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="253505829"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:20:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/pagemap: Clear driver-provided PFNs from migration PFN array
Date: Tue, 21 Jul 2026 13:19:59 -0700
Message-Id: <20260721201959.1082266-1-matthew.brost@intel.com>
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
avoid confusing the migrate_vma_*() functions.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to_devmem")
Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..f991b296c8e1 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -807,8 +807,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
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

