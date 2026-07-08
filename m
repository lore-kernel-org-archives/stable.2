Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40068403AE5
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499929; cv=none; b=efu3N89wlSg+N7EAf+KOVsL8Ydanmoitm7QduM0SlxuPa2FX4EH2eZvJRIu2/pISTY93bjHS5rGENAwaWuI5rVe3M5jCo/E0mvBdkttfND0x0gun/U2cyYaxFy0b0/A3U7RVBe2zU0LTluNR/Xd+aO2YbVdJ/u1bnkz/e8NGAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499929; c=relaxed/simple;
	bh=7/SS1b53la8wj26oX2KDb+61KE6NUg8vXMTiB/BKZ0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQhyUemxDCiSB6sM/uSPeXQpXt9dumjkpI0dJcIRQwEdtHzUTbpDgInJBj6w2cDuyrtqbqDBqh/MZ7bEJw6Uk5aZu6UiHAlryJbwG7BBf+D/6s6d6M3rSoMzaDF3Cbp2Z9lYpPrxrj1yWE5hjEiT8FnWwLdiHMZHNapO0PqUn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1OCy27X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1OCy27X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783499924; x=1815035924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/SS1b53la8wj26oX2KDb+61KE6NUg8vXMTiB/BKZ0M=;
  b=J1OCy27Xoyf4q1iRHDCBYYflfCovl12e+JCA1wWuSCk+Wahf9jZov7Hu
   4kNOs1cdrnPbdCVHKssC3njfow02mYAWktO5or1gafreURmBaVe/7MrrA
   c6xZdiXZroIW1MUcX5liRumkzSr4AFgD1eLXyMmcnxiOjoAgS+YYa+THB
   cd5VRdPqZTwUK1cMu1wes09EEhwNSspmBdD9jzOUkcED+i0MB4SFT3Xxq
   G0btb5EQ2RJeGZinxM23Y+qLGoGhhFlmwwSpNqziduKoLiE0TJ3LWBbdU
   DLY9ZryufiAmvqD695a2qzwPNHWkO1UOeaUA/UGD521qnNjE/5Q/cAydG
   g==;
X-CSE-ConnectionGUID: G/2GX8sBTVKTxRvT+qT9EA==
X-CSE-MsgGUID: bYgTh6tdSGOHaThNafaNDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94800424"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94800424"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:38:43 -0700
X-CSE-ConnectionGUID: yQ+uWy/zRQSflR4DtoMf8Q==
X-CSE-MsgGUID: aZGCMK7vTia+hL5VXiVS1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250240882"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jul 2026 01:38:41 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v5 1/2] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Date: Wed,  8 Jul 2026 14:45:07 +0530
Message-ID: <20260708091512.205482-5-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708091512.205482-4-nitin.r.gote@intel.com>
References: <20260708091512.205482-4-nitin.r.gote@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a dma-buf importer creates a ttm_bo_type_sg BO with bo->base.resv
pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
fails, no dma_buf reference is held. The exporter can be freed before
the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing a
use-after-free:

  Oops: general protection fault, probably for non-canonical address
        0x6b6b6b6b6b6b6b9c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0

ttm_bo_individualize_resv() skips the resv swap for all sg BOs to keep
the shared resv available for delayed_delete to release the dma-buf
mapping. A BO whose attach never succeeded has no mapping to release,
yet it keeps bo->base.resv pointing at the exporter resv that
delayed_delete later locks once the exporter is gone.

Fix this by checking bo->base.import_attach, which is set only after a
successful attach. The check is placed after dma_resv_copy_fences() so
successful imports still copy fences to _resv before returning, keeping
the shared resv for delayed_delete. Failed imports fall through to swap
resv to _resv, so delayed_delete never locks the stale exporter resv.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 3980f376e3ba..f157e259dd5f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 	if (r)
 		return r;
 
-	if (bo->type != ttm_bo_type_sg) {
-		/* This works because the BO is about to be destroyed and nobody
-		 * reference it any more. The only tricky case is the trylock on
-		 * the resv object while holding the lru_lock.
-		 */
-		spin_lock(&bo->bdev->lru_lock);
-		bo->base.resv = &bo->base._resv;
-		spin_unlock(&bo->bdev->lru_lock);
-	}
+	/*
+	 * Successfully imported sg BOs need the shared resv for dma-buf
+	 * cleanup. Failed imports have no attachment or mapping and can
+	 * use the private _resv.
+	 */
+	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
+		return 0;
+
+	/* This works because the BO is about to be destroyed and nobody
+	 * references it any more. The only tricky case is the trylock on
+	 * the resv object while holding the lru_lock.
+	 */
+	spin_lock(&bo->bdev->lru_lock);
+	bo->base.resv = &bo->base._resv;
+	spin_unlock(&bo->bdev->lru_lock);
 
 	return r;
 }
-- 
2.50.1

