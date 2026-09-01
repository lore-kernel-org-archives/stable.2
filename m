Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FE37C0F6
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283878; cv=none; b=k5YK2cGO1k34Jb6c1pgvTikvB2EEvLZ4gdAhNN/Iyjpr4g+kiRwWfniCpf2+6HYyHpk2uGdciQZ7MPFp310oehTS1at7NaqGuXvyeMCFv9KplwRkJ6h+iQVnP9l/ntKi9T/GqlHxnD1KBNjO2hQgeDKfkKxg2AL0dlhrI+mkR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283878; c=relaxed/simple;
	bh=aQPtZU5dKlQ1c0+bGOkaAo7lRfeU+axD0xVwyFVEwdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFX+j5h5yR+rhyxaU5JOxooIUg7H9Js/Qe0dhVYMwrGUvs8tXfPIUouLj5fybaMfu2jr0mgEkHNIxInpFkJT3Czq5SP+vSIXt473XuA0ZYqMMukiNcyxOFvxMzgHn/1gOdUPaR1JgsoeNhhhGj1cbWxOh8xO0b22URdx0FmQFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=narG8EpD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="narG8EpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788283876; x=1819819876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQPtZU5dKlQ1c0+bGOkaAo7lRfeU+axD0xVwyFVEwdY=;
  b=narG8EpDl9JFk4jPRJ+v6AEGiZ3bt2q7LoYYZhKfAFy8+gqmNzDpoqVB
   //TClQqtGpEp7Llh9+v42XYS/f77MBnxY2Ep5tjCGFJfHTG9opyqsvhkg
   NouUw7pwHc41tr0WvwZV35hE/t8xmwPcErVvjgJpKc7OSxbn3b5JKE0dg
   mICEPrgptYywfZnPZa71rY7MRsQCS5MKMbk6zPH0b/CsjCVHdcrWnv0eg
   rGX5Phr7aKaDfw7D0oPR00uGJAyC9kMwvedYMybbk7xf70fu4iBc4QJL8
   BZM7+o8Q/c9mlIPqfewzeAp88Mgs47BZwei+E033Z8FjtZKmDcmOEKs9R
   A==;
X-CSE-ConnectionGUID: uZ1LA8SlT6m99WxD4ijPKg==
X-CSE-MsgGUID: ufVWKf60RNi/5sk+AObTmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87862142"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87862142"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:31:16 -0700
X-CSE-ConnectionGUID: EJ61YDQpRC6ovlLTPP0XqQ==
X-CSE-MsgGUID: Hb3liPyjTAyA/scIWCdtZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="269750053"
Received: from osgcshtiger.sh.intel.com ([10.239.81.49])
  by orviesa009.jf.intel.com with ESMTP; 01 Sep 2026 10:31:15 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v5 1/2] drm/xe/shrinker: Do not discard freed pages on error
Date: Tue,  1 Sep 2026 17:30:58 +0000
Message-Id: <20260901173059.455469-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173059.455469-1-shuicheng.lin@intel.com>
References: <20260901173059.455469-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__xe_shrinker_walk() and xe_shrinker_walk() both return the error in
place of the pages they have already freed.  xe_shrinker_scan() only
accumulates non-negative returns, so those pages are never reported,
while *scanned is updated by pointer and does count them.  The shrinker
then tells mm that it scanned without freeing, which skews the reclaim
accounting away from it.

Report what was freed when there is something to report, and the error
only when there is not.

v2: drop EBUSY check and add more return check. (Sashiko)

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..7f40153911ff 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -80,7 +80,7 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
 
 			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
 			if (lret < 0)
-				return lret;
+				return freed ? freed : lret;
 
 			freed += lret;
 			if (*scanned >= to_scan)
@@ -119,7 +119,7 @@ static s64 xe_shrinker_walk(struct xe_device *xe,
 	if (!ctx->no_wait_gpu) {
 		lret = __xe_shrinker_walk(xe, ctx, save_flags, to_scan, scanned);
 		if (lret < 0)
-			return lret;
+			return freed ? freed : lret;
 		freed += lret;
 		if (*scanned >= to_scan)
 			return freed;
@@ -128,7 +128,7 @@ static s64 xe_shrinker_walk(struct xe_device *xe,
 	if (flags.writeback) {
 		lret = __xe_shrinker_walk(xe, ctx, flags, to_scan, scanned);
 		if (lret < 0)
-			return lret;
+			return freed ? freed : lret;
 		freed += lret;
 	}
 
-- 
2.43.0

