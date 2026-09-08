Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B559C984
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893033; cv=none; b=LEpOKR0Y7BwNmrTpAPNqCaFREYr/QLpytYt9YEayddtq7uqja6s8W9HneBv3U2VA8GSdesUyUd1mjcVhf4/2NGpJCPQ2BwKmnaXkOk9u2XaEM852hlOKIeHPQgTxhbMFf86qBk6XL3ZO7rgzil6M13P+h8enHZgDmt3kfiePtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893033; c=relaxed/simple;
	bh=5Rw/JlqIG5T/As5eBmk3ZU9xOi4Qm3HLXKvGD75HOY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQsJBxRK7o+z1NFiaqpUEtNIOZ+WYvGUbh3A5XNppeA04co8QmxE/mk33wkv4AQxAXnS7ERc0Wfi+QD54NspqkLOMPqRiNCQGT01EJeh0H1szZ/hGiBVsNwHnRjBDBPDwh046N+29Z1Pm8lnARtl2ymx6YNExFz6eYExE3R5NBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1Y5o0Eb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1Y5o0Eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788893031; x=1820429031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Rw/JlqIG5T/As5eBmk3ZU9xOi4Qm3HLXKvGD75HOY0=;
  b=N1Y5o0EbC7EG+zkwpDs8l1XN5U/QTeh9BG/45PICzuAozBHuE5zDjupY
   YYT+p+Aq4ow/iddWpHXdUEd9DcN6Cp/hu92CQZfc1Ut7reeLk71/cY+Mr
   khsUnGAbYiAW3aGb+Z+TBP87E7/Tb/52LXqrOu6EkXx7GZoqF2Lt9EBdI
   64e/32mKUzxujEMfC6GEXlSPtYonF1UeT+TMWa3sHu/7n2w370R4lQcBf
   NvVYZnwGyTPcCsmz4D4hDFe5j+MEWHOLvffK20kzqNwkewgYgh6N16vKy
   ujq9Cqfa7fct7ph/iOscfSC8njzTW7Egd6Popl13sLIoUFDYBPRxOkb31
   g==;
X-CSE-ConnectionGUID: UszN9oCRQf20oeISN3GhIA==
X-CSE-MsgGUID: iNLr5CL1S5KrBSPk23p4Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100826291"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="100826291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:43:51 -0700
X-CSE-ConnectionGUID: UJO4LCE+QFqGYHxq5/so3g==
X-CSE-MsgGUID: +VW7/waxQOWS+74VcvE72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="270589962"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:43:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Keep walking on SVM eviction failure
Date: Tue,  8 Sep 2026 11:43:46 -0700
Message-Id: <20260908184346.92332-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The desired behavior for SVM eviction failures, which can occur due to
various uncontrollable races, is for TTM to continue walking the LRU
list and look for another eviction candidate. This is expressed by
returning -ENOSPC from the ->move() callback.

Adjust the SVM eviction failure path in ->move() to return -ENOSPC so
that TTM continues searching for another buffer to evict.

Fixes: 3ca608dc7561 ("drm/xe: Basic SVM BO eviction")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b162753cebb7..8264b2ef557e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1043,6 +1043,11 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		} else {
 			drm_dbg(&xe->drm, "Evict system allocator BO failed=%pe\n",
 				ERR_PTR(ret));
+			/*
+			 * The semantic we want upon SVM eviction failure is
+			 * keep walking for eviction, which is -ENOSPC.
+			 */
+			ret = -ENOSPC;
 		}
 
 		goto out;
-- 
2.34.1

