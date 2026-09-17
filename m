Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E34EDCB0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677129; cv=none; b=VX64cuPF4jsUQHE7B1yVRiCrKxBkMXhzkWgJiY5LHFnMiIINJ4qMosgrXas1n2RvMNThgobaO1gPibL4vHUVAAx7X/VhTMu+NrN4HaSgRgFLb7xHPg7wWPy6jpJvEv/gQyO0NO/jjDedmIUSHg3tIA8m4MtSoM96F3kbsI3opdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677129; c=relaxed/simple;
	bh=Q72J2znbfuacFkTKeVhV5vggXUIH5p8bQ3Mz8EZ0q40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ugJC8iQE0La+qHhnqLqGcaJFrntF2AKikNcuFB/lL6phg5OwW5qDi/K/US1/5aePepsTXgBzbNlTaQyzCEe7bvD2bVXT+S3JrkV0uzfDHXGhmxNwzckzRLyrJNfBJGsiwrZ8Fp6E4TxUfKiotOj/6BhanypFY1ViW5eArNKTksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tvay5gjd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tvay5gjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677127; x=1821213127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q72J2znbfuacFkTKeVhV5vggXUIH5p8bQ3Mz8EZ0q40=;
  b=Tvay5gjdHEC/hYNj7zgQxUtlIHgfvtwCOw8SCE6QsXVj27LoOqlksqDy
   N3102e40Sxu6+QPtc2GjASGBah1CSb/Wxm36yU8HUetJgCaZgxEnDAukU
   PDl3RLdez9ZaKpZqcEUnPlueUWwtEY9NVN66YFfbdJnogSb/kZ29tn0Eo
   xjUZzj3rSxbWw5eXoDFNZ+bDufG6WJK5Ee/TTe3weOiskosVKewxPHWzU
   88ze4vFVbkEwbKiDd+bH3nyiIs/XAKTGyVMBMu6vG6TU31qrglM6D0I9p
   8iybu/MRuZfsXMOOo7OuQlLoWY6BGhqCFXkJBmMsY8tBo0jaro8fk+bYF
   w==;
X-CSE-ConnectionGUID: 7v5JKaasQsevqxIB+Pmokg==
X-CSE-MsgGUID: 8uTgXWSpRFCnwgDO43V+3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89076949"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89076949"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:32:06 -0700
X-CSE-ConnectionGUID: +RsW0BTfRie1TzjBCKnmlg==
X-CSE-MsgGUID: eHvFhu0qTd+pgypL9/7MQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275975377"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:32:04 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] drm/xe: Keep walking on SVM eviction failure
Date: Thu, 17 Sep 2026 13:31:58 -0700
Message-Id: <20260917203158.292823-1-matthew.brost@intel.com>
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

Adjust the SVM eviction failure path because of races in ->move() to
return -ENOSPC so that TTM continues searching for another buffer to
evict.

Fixes: 3ca608dc7561 ("drm/xe: Basic SVM BO eviction")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
v2:
 - Only convert -EBUSY (races) to -ENOSPC
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 9f3f0cb95afa..f2ab9bf43a86 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1044,6 +1044,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		} else {
 			drm_dbg(&xe->drm, "Evict system allocator BO failed=%pe\n",
 				ERR_PTR(ret));
+			/*
+			 * The semantic we want upon SVM eviction failure
+			 * because of racing access is keep walking for
+			 * eviction, which is -ENOSPC.
+			 */
+			if (ret == -EBUSY)
+				ret = -ENOSPC;
 		}
 
 		goto out;
-- 
2.34.1

