Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046574;
	b=cqyDsGSt+ebwYfOCXcKfY6Qkq/T80xXG42dXbEnJ5vE1kH4YxCbRVgqu5oI7To6utKVU
	 Pojcnx634kcp/WBU8zzm92+OyL8qj1scjkI0rLvIhqW4yuAKbwANyCIbFj7ipDoHcioP/
	 bg1oHJnC+/yfwdT2lvAKnOE0im5EnPvTvpAQJb7SKq6xEcofaLIQ3GHEh3AG0++DtYfsh
	 3PtSAH4fmPybO0HxatZI1s9A1NDyGBO7RoSqbGhroUlOPltIcNy1HDoRGcc3TksMSMAVt
	 3iTy0ksUyUSIz2ZNDKhpr5p5i0qbYBAYCJEHfFCpyyXd2Q508/MAcyBV4uLTS69GCtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OdWs+b/v2jioZEdlV/HIbyHBAauOeDWi7AMfR4N6UZ4=;
	b=uhWUjsZnS4oz3utwiWxWvVtDSW0m41SY3mxtkBOER/FmWZJy2jDrKPWwQQBdA5VgbuCf
	 ZmWcaDnOfjEQl0GsITv7Oo4tri380ujJbUXzJCzXKr9GUJxcM+SNq1hf4Aj/ntjC7smkl
	 lJReySPyIrG9Ngn8ZdIrJXopC4a1Q1GYUi0/WWBUxRhGbVkg7i1cjbg1NWxfQW9Epi1lh
	 NKyPIK/eeFBqGzKVX2PStdGhCfGo7HRlO0E830/BAMrJ/Y7p9XtmGuBKUQAO4NqOgWK3u
	 DG9ILC8DRazBKCwpEeSOpTc5UzMxPEPNYDL97XRZOo71ksQXDK3248zi3pkmkJpGbog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqrpX7R7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2AC606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqrpX7R7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6851F0089F;
	Sat,  7 Nov 2026 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046574;
	bh=OdWs+b/v2jioZEdlV/HIbyHBAauOeDWi7AMfR4N6UZ4=;
	h=From:To:Cc:Subject:Date;
	b=iqrpX7R7rXNEBKUMHi+0LaOs/Pf823QLpMuB8Uqz2AB/Ptb2jmfbmueBEGtVyY609
	 +5GKnv40TxB7eb+X9AXi71SBWHgphq+ep3DQCkww0mu2VccjQqMN+vx3h6EgkhmXhJ
	 Wb6eNUcss5V0EsQZCTiJWRQwWOUqpe6fJ3JREj7rsysOHTfVJTUAX7V3oVGh6aWe4b
	 c2zsoN5nQ4ek3TDW/xQnkY1PeK3USwZ0EsMMmZyRg5V6H6yXVEewsapCsbnKLFv1Pd
	 9lgM8znAAk+Fjna5bMRtzVPDXhe8qvwOcU/A/1H27k1zQ4VE6yiHPpFxrGdYJs1wpt
	 b0iMFNgDdgXtg==
From: Sasha Levin <sashal@kernel.org>
To: jia.yao@intel.com,
	gwan-gyeong.mun@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in a separate BO" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:12 -0500
Message-ID: <20261107051612-failed-6.12-6af05de0dc19@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6af05de0dc19bbf3aaeec2020fe48b37c834b811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051612-failed-6.12-6af05de0dc19@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6af05de0dc19bbf3aaeec2020fe48b37c834b811 Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Tue, 4 Aug 2026 16:50:55 +0000
Subject: [PATCH] drm/xe/guc_ads: allocate UM queues in a separate BO

Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
CPU memset operations on it, which eliminates the CPU as a potential
cacheline-polluting agent and helps maintain consistency between GAM
writes and GuC reads.

We also need to ensure the base_dpa for the queue is contiguous on hw
where this is used instead of a GGTT address. Another good reason to
split this out to a separate BO.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
---
 drivers/gpu/drm/xe/xe_bo.h            | 14 +++++
 drivers/gpu/drm/xe/xe_guc.c           |  6 ++
 drivers/gpu/drm/xe/xe_guc_ads.c       | 90 +++++++++++++++++----------
 drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
 4 files changed, 83 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index c6d80e1bd6e7b..e8081af5bfc18 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -6,6 +6,7 @@
 #ifndef _XE_BO_H_
 #define _XE_BO_H_
 
+#include <drm/drm_prime.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include "xe_bo_types.h"
@@ -549,6 +550,19 @@ void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
 
 struct sg_table *xe_bo_sg(struct xe_bo *bo);
 
+/**
+ * xe_bo_sg_is_contiguous() - Check if a BO's DMA address space is contiguous.
+ * @bo: the BO to check (must have a valid sg table, i.e. !xe_bo_is_vram())
+ * @len: required contiguous length in bytes
+ *
+ * Returns true if the first @len bytes of the BO are mapped to a contiguous
+ * DMA address range.
+ */
+static inline bool xe_bo_sg_is_contiguous(struct xe_bo *bo, size_t len)
+{
+	return drm_prime_get_contiguous_size(xe_bo_sg(bo)) >= len;
+}
+
 /*
  * xe_sg_segment_size() - Provides upper limit for sg segment size.
  * @dev: device pointer
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4286bd05c6861..4f132bf8539da 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
+	if (guc->ads.um_queue_bo) {
+		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index f0ac00586d3ac..f8c679cef0039 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -64,10 +64,14 @@ ads_to_map(struct xe_guc_ads *ads)
 
 /*
  * The Additional Data Struct (ADS) has pointers for different buffers used by
- * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
- * all the extra buffers indirectly linked via the ADS struct's entries.
+ * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
+ * and most of the extra buffers linked via the ADS struct's entries.  The UM
+ * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
+ * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
+ * performed on every GT reset does not discard fault descriptors already
+ * written into the rings by the GPU.
  *
- * Layout of the ADS blob allocated for the GuC:
+ * Layout of the ADS blob (ads->bo):
  *
  *      +---------------------------------------+ <== base
  *      | guc_ads                               |
@@ -99,10 +103,6 @@ ads_to_map(struct xe_guc_ads *ads)
  *      +---------------------------------------+
  *      | padding                               |
  *      +---------------------------------------+ <== 4K aligned
- *      | UM queues                             |
- *      +---------------------------------------+
- *      | padding                               |
- *      +---------------------------------------+ <== 4K aligned
  *      | private data                          |
  *      +---------------------------------------+
  *      | padding                               |
@@ -156,16 +156,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(ads->capture_size);
 }
 
-static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
-{
-	struct xe_device *xe = ads_to_xe(ads);
-
-	if (!xe->info.has_usm)
-		return 0;
-
-	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
-}
-
 static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
 {
 	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
@@ -206,22 +196,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(offset);
 }
 
-static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
-{
-	u32 offset;
-
-	offset = guc_ads_capture_offset(ads) +
-		 guc_ads_capture_size(ads);
-
-	return PAGE_ALIGN(offset);
-}
-
 static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
 {
 	size_t offset;
 
-	offset = guc_ads_um_queues_offset(ads) +
-		guc_ads_um_queues_size(ads);
+	offset = guc_ads_capture_offset(ads) +
+		guc_ads_capture_size(ads);
 
 	return PAGE_ALIGN(offset);
 }
@@ -461,6 +441,46 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
 	ads->bo = bo;
 
+	if (xe->info.has_usm) {
+		/*
+		 * Allocate a separate BO for the HW fault ring (UM queues).
+		 *
+		 * Round the size up to the next power of two so that
+		 * (system memory, no IOMMU) the TTM pool issues a single
+		 * alloc_pages(order=N) call, maximising the chance of getting
+		 * a physically contiguous block.  GuC requires contiguous DPA.
+		 */
+		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+						    GUC_UM_HW_QUEUE_MAX);
+
+		u32 um_flags = XE_BO_FLAG_SYSTEM |
+			       XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE;
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+
+		/*
+		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
+		 * ring via base_dpa, which must be a contiguous DMA address
+		 * range.  Verify that the allocated pages are contiguous in
+		 * DMA address space.
+		 */
+		if (!xe_bo_is_vram(bo) &&
+		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
+		    unlikely(!xe_bo_sg_is_contiguous(bo,
+						     GUC_UM_QUEUE_SIZE *
+						     GUC_UM_HW_QUEUE_MAX))) {
+			drm_err(&xe->drm,
+				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
+			return -ENOMEM;
+		}
+
+		ads->um_queue_bo = bo;
+	}
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
@@ -893,7 +913,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	struct xe_guc *guc = ads_to_guc(ads);
 	struct xe_device *xe = ads_to_xe(ads);
 	u64 base_dpa;
@@ -903,8 +923,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
 
 	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
 
-	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
-	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
+	if (um_bo) {
+		/* All USM platforms: UM queues in dedicated um_queue_bo */
+		base_ggtt = xe_bo_ggtt_addr(um_bo);
+		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
+	} else {
+		/* Platform does not support USM: no UM queues, nothing to do */
+		return;
+	}
 
 	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
 		/*
diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
index 48a8e092023fa..845c1fbd93a4e 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
@@ -16,6 +16,11 @@ struct xe_bo;
 struct xe_guc_ads {
 	/** @bo: Xe BO for GuC ads blob */
 	struct xe_bo *bo;
+	/**
+	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
+	 * NULL if the platform does not support USM.
+	 */
+	struct xe_bo *um_queue_bo;
 	/** @golden_lrc_size: golden LRC size */
 	size_t golden_lrc_size;
 	/** @regset_size: size of register set passed to GuC for save/restore */
-- 
2.53.0




