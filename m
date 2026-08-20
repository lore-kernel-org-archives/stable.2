Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127A37B41F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242294; cv=none; b=sdRKxZze049McqXNX9L/ash4IGyzlItSQFGXU7GB4DNgWqbSgKTyb0tKSYZlrtuEHpvBXXk48Y5/4ItNdEdReNvCS1b+aJakb/YBobBRTjidsMdgX4DcXCHc4rn6SV16UcZlJjnAmLrZUfzN7s1PHusaDB/ntGZTQAiY8QTVRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242294; c=relaxed/simple;
	bh=BhOPZgim9vP/lkp4DSODeJnpt/PstxUuZqpzq3V5NcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeuU0pdos1EQG637XVdFX7PAKjEk6rhZAptC9PoV3S1Okzu+jG/32b1czVDGKaOinS9qM1dwdkC2m/xQ5xz/wM8pDNlzDLF5X1+rOv1a2KbgmibOwh3UXXEnRVpBcCxUX9ud1HzzA/2F/Hlev89pjh6E6wGA3mqgibv6DJO4MvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXMsNciI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXMsNciI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787242293; x=1818778293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhOPZgim9vP/lkp4DSODeJnpt/PstxUuZqpzq3V5NcU=;
  b=JXMsNciIXWR6WS3AR3SlKZpvQsqhQoCwFHOvRMQkLXaERA9QvsrTiuO3
   GwvBrizabWFpKrkGLyQ/0SvBeHxyOcgvv2L6N5E6vkXAVaG+G/5CnO/ok
   IBca8QGIoMEAVzDF3B3JLn7heg1cvZK/JpAPSOAaElzTbnICy8qwmM6RR
   ApweYyOXkKckeYbR0/oAcoQ3lbdVI0lQXPJ0uGgJxXOoc8/bfzC+oCdMU
   kFShmjcdcmlwH0fjJ3Leumcf3maPa9dMnrg00/oWfXW8TIXUhXu14v0jG
   hg1pJv6G9ZaUGOtU/6uY7yZLpDV2lYniooIf4K1hIWl/T2gPksnneGDpA
   A==;
X-CSE-ConnectionGUID: rYKNYL+dQPKKz5Ph+LqbAw==
X-CSE-MsgGUID: Wr+oiNRvQOSRdBT0Y8OEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113322799"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="113322799"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:11:31 -0700
X-CSE-ConnectionGUID: F48CyxH1TAeJC0q9xpALMQ==
X-CSE-MsgGUID: 7+FY/wvHRL6UuZdNjbOoMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="268024030"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.54.89])
  by fmviesa004.fm.intel.com with ESMTP; 20 Aug 2026 09:11:30 -0700
From: Jia Yao <jia.yao@intel.com>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Thu, 20 Aug 2026 16:11:28 +0000
Message-ID: <20260820161128.1337094-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082047-manned-outer-503f@gregkh>
References: <2026082047-manned-outer-503f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
was previously created in system memory and later reallocated in
xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
VRAM on dGFX, where it is ultimately required.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-3-jia.yao@intel.com
(cherry picked from commit ace076ef0a854ab5940bacc539bf66afd61d118c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
(cherry picked from commit f342810a141f8a7e8b3786a6e4b6c0695a078a74)
---
 drivers/gpu/drm/xe/xe_guc.c     | 6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 8 +++++---
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index cc5741f751b9..ae0c88da422b 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -700,12 +700,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
-	if (guc->ads.um_queue_bo) {
-		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 806c2618a7cd..4c3e21b5e60e 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -392,15 +392,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		/*
 		 * Allocate a separate BO for the HW fault ring (UM queues).
 		 *
-		 * Round the size up to the next power of two so that
+		 * Round the size up to the next power of two so that on iGPU
 		 * (system memory, no IOMMU) the TTM pool issues a single
 		 * alloc_pages(order=N) call, maximising the chance of getting
 		 * a physically contiguous block.  GuC requires contiguous DPA.
 		 */
-		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+		size_t um_size = IS_DGFX(xe) ?
+				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
+				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
 						    GUC_UM_HW_QUEUE_MAX);
 
-		u32 um_flags = XE_BO_FLAG_SYSTEM |
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
 			       XE_BO_FLAG_PINNED_NORESTORE;
-- 
2.43.0

