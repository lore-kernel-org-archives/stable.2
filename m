Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20E41C72
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782955480; cv=none; b=tIyANvMG4DrLWFFFPHDJ2JIxNG5TAjR/Pb4aksCnHR9uita2kLuKaip0QECkncj1UT0U3ihT3LnWxUDIphqipRZZTeE59MLLO9/xsGsBQgX/LdhZ2/N55IGs5E0hTRnTugTqi9C7xBmkpaBwUOx44KXUK/VcG2+/H3My26Y015o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782955480; c=relaxed/simple;
	bh=ctpQ78W0lSbJOHnoQkwspXnJShQ/RwnX315jTlQMbDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5Ow5PI5qX0H9xpUZCvuSyrtSQPnIrRXFNO54dUDPFm+KfKutpu/4tcAm26ql/sF/Lrju3HRri8kKudVsKjWZqMWEDLf4OUzvUsT/vxZCb4LakCsuLeIeUIslEylfmo6FsGMymltBqBAorcdPXS0rHOXbYOZMO4dkRIm4kP8wFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3tnnHx4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3tnnHx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782955479; x=1814491479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ctpQ78W0lSbJOHnoQkwspXnJShQ/RwnX315jTlQMbDk=;
  b=U3tnnHx4aMYF22QnXD0/5RW3kSVbWm5QwZeq+2EGRxXZ66irr+1WYPtt
   yxHMdXWtObpCuLgcASn8UaGfjsmTwQ48jXtXTvbLAdaBuXf3Ps9QLlIq6
   rlClzj3kI915d3RNbZ9YWZMldsFDP+5xRnE9ELmxbowzYB/FVic1VNaBH
   4DxP1/+MJpvh/2B7wPQbtguiA7DgmgVgonOjF5lJWYgNQn02lsEjk2D/L
   T0k9Yxmr6zgxYSukcfbBf45BkuJOxF26WScb74xAusPKduMxHyVTxMEtq
   tSqEv163190xPgQSzevJSig53WAVA24U7UW/pnGD5s91oNC8ogLZHwIfj
   w==;
X-CSE-ConnectionGUID: 3lgSAycpT/2Ly/om6H0OEg==
X-CSE-MsgGUID: QaDlZz1LQKiE1i/jgsQ3Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82688434"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="82688434"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 18:24:38 -0700
X-CSE-ConnectionGUID: HGIktfkMSq6AT4OZCvVlNQ==
X-CSE-MsgGUID: ogIeEa1ORPecpIdEGVYojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257604364"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 18:24:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix PTE index in xe_vm_populate_pgtable() for chunked binds
Date: Wed,  1 Jul 2026 18:24:34 -0700
Message-Id: <20260702012434.3861171-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_vm_populate_pgtable() indexed the source PTE array (update->pt_entries)
by the per-call loop counter, assuming each call starts at the first entry
of the update. That holds for the CPU bind path
(xe_migrate_update_pgtables_cpu), which populates a whole update in a single
call, but not for the GPU bind path: write_pgtable() splits an update into
MAX_PTE_PER_SDI (510) sized MI_STORE_DATA_IMM chunks, invoking the populate
callback once per chunk with an advancing qword_ofs but a fresh command-
buffer destination pointer.

As a result, every chunk after the first re-read pt_entries from index 0
instead of from its true offset, so PTEs beyond the first 510 entries of a
single update were programmed with the wrong physical pages, shifting the
mapping by exactly MAX_PTE_PER_SDI pages.

This stayed latent because a single update only exceeds 510 qwords when a
large (e.g. 2M) region is bound as individual 4K PTEs rather than a single
huge-page entry, which happens when the backing store is sufficiently
fragmented. It was surfaced by the BO defrag path, which deliberately
rebinds such fragmented ranges via the GPU bind path, producing
deterministic data corruption offset by 510 pages.

Index pt_entries by the chunk's absolute offset relative to update->ofs so
both the CPU and GPU paths pick the correct entries.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.8
---
 drivers/gpu/drm/xe/xe_pt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 00cef6ff17cc..7970b4ed95b5 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1024,12 +1024,22 @@ xe_vm_populate_pgtable(struct xe_migrate_pt_update *pt_update, struct xe_tile *t
 	u64 *ptr = data;
 	u32 i;
 
+	/*
+	 * @qword_ofs is the absolute entry offset within the page table, while
+	 * @ptes is indexed relative to @update->ofs (its first entry). The GPU
+	 * path (write_pgtable) splits a single update into MAX_PTE_PER_SDI-sized
+	 * chunks, calling this with an advancing @qword_ofs but a fresh @data
+	 * pointer per chunk, so translate back into a @ptes index rather than
+	 * assuming the chunk starts at ptes[0].
+	 */
 	for (i = 0; i < num_qwords; i++) {
+		u32 idx = qword_ofs - update->ofs + i;
+
 		if (map)
 			xe_map_wr(tile_to_xe(tile), map, (qword_ofs + i) *
-				  sizeof(u64), u64, ptes[i].pte);
+				  sizeof(u64), u64, ptes[idx].pte);
 		else
-			ptr[i] = ptes[i].pte;
+			ptr[i] = ptes[idx].pte;
 	}
 }
 
-- 
2.34.1

