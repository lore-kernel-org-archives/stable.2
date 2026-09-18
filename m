Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FEC47ECD0;
	Fri, 18 Sep 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726019; cv=none; b=HJ2ykcMbFEcEqqEQ1fZTZCUC6S2VdIJKhnS5KObC4GaEK5YDiqR3rM1YYdyymJBVk2/AKDqSaVzlWGbB5c3VFtO3lu2iHoWsQHWOhg7Kz7Tkjreq+NPFk3VBbGbrP+iOdOv1z+nrPGZ2jo2ijfKqERofU6q+QIIXn0caxNMO0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726019; c=relaxed/simple;
	bh=1JZ6dr3RaQ/2JsraylDDhOUeryJgVYQqI872oCK/kpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nC7WJVoOXbWXtlRfd79W9cRchv8xl+AmerZt/cmIsf6hRx4HnqFTSBn45/td9l/S4iG0MxrJoRBHM+lV27gA8FNFDb5fJUtpsgIOZz2hisrXT1EypMZ6DwVPEWhokgz9q8uyBZD54dPy6LvSw3YGZrnRKrYzXU086fy1k+YUyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=iuhmwc9b; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="iuhmwc9b"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dJ3Z1686889;
	Fri, 18 Sep 2026 11:06:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=Q
	+jjfCSxS8ZCzm89Vz+Ws2BYXa5D5Adj6ace8/Ys57Q=; b=iuhmwc9bvup4Qy6f0
	BGeICcuuKVi6G929agTjSBXCP2XyV5fq/7nR/dFOgm6H3RSqNM424BbajJLTjCDF
	PnVLQ0u4FF9ByJaW50Yp+2xTYOyyDBElw6EiRRX01eYuIUwD4r/Aq1GDF/K2gWtD
	q4uCH802N26WgcwTOjTaCdWgoNy2zkGsduLUnfRMrvzuTYzptaTCq//3KohL+HrF
	qz+Owr8RSvfMgcwqAT8hA7078S6h7ocH8ReFvYDA74KmceREtI6L6WOvuunIqyW1
	ZmBcxN8acSI8fK4N+5JxszMkNy4QpCIxQx9jEGJ1DYWKzOWFOYqi0JO4cLkgNWbg
	Piwyg==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtung39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:06:36 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 11:06:32 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 18 Sep 2026 15:35:40 +0530
Subject: [PATCH v2 2/2] drm/imagination: Fix page count for page table for
 map() interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mmu_fix-v2-2-f7c004fbe203@imgtec.com>
References: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
In-Reply-To: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5045;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=1JZ6dr3RaQ/2JsraylDDhOUeryJgVYQqI872oCK/kpw=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrQ0fWdtmyMuzQJzktM3vy+2a35AyHD2dZm7Hg
 oTbb0MKrJWJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaq0NHwAKCRDQJndZfgLx
 cNShD/9y+fCd1u8FusyhRN+Zrm+HK7QIfSy7c4VxuOTU31kt5PSybjPmiOXg5KSGBm/CiN8Ncmn
 y3qeHK2PUHuAb9Wn6+lVeO+Jzq7fwmW/so4xGW+RxrsWSbN2u+zxZ3N5Ti8VV4vj87fCqYOkTFo
 EZhybfaP2P01CDGMjgEv5tfqTDXLmo2Lq9VjZ/xrfyO9jeuvbNS7SXxiJTNaSFlSBtA8BWGKacD
 URVB/RwvGiI+rOqBrOCLRZgF+DStHwDoXw8bC8054HI8Ccl5j6t2S/7An9ohdXOaJJlC80u9I/P
 AfZP1hQYO8nJQbcE/vXuRELPynrLjRMoP+p/nlMeYMVEI++IjJascdwJFL5liVIL+JZfXO6mUZ0
 LelXO3Xz9g5eZFn2vUPQuGlVv/6BbUZFZxzsY1NifwRd/wCEfrsEFdYVYKwWVgYuu0VHiSyQ6Al
 F866HCjjraWGjhTounQO2t2Tj00PaZ2KtSElfUlWpmhR7MNPZgimJRszp0Sy7NSV+7eXrnRqFe2
 JdoKMp53ztnXfHqr9+0rLtxqIEI2E1ORnYHsHzbwqPRUDsW4oNcPe4U8YI0DwTwQbIsx78vczt6
 PN/o0uJwoIpkGOMiiVKwFL1rdsQIvadGtSCJMOOkHDsz5O4XxnGKPVjrH3+Vv9ZNivilG8YQZbP
 OXsLED6zU/WxUVg==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aad0d2c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=lyzDSBJAejP7XBH9i10A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: lgXLQ4WjxLEVZfXOPu0h697Oz5DRpw8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX/i5vnAn88lYd
 h6hdh1/mYt7tMTsQ6We5vyh7BERaePWSPbmlwj3bCa47ICa5yaeK+WT/EHcscjGqDEr1EpOWpkk
 RhBcPpgN5ub8ZLhN2wfsBscjCMl1umqliHPx7SQlX7c+zJ7E2PjGmIrEPqwb/30sT+OOz3jSApz
 MrseoKOVL7ZjZZ6fKtbpsBxtukw9jIrLqhr2Aw+vhsdaZerwPkahtMOnTNdJDDcut/7cbNHozr0
 hKpnfY4WLEwRYBZN8zpejZpP+LVGRir5lrzklFzzMFiEPboH0YkbOWPkX/g5nGG2iVgBIzzKL6e
 fh0f5RGOEbEu/2+NWhSjg6NJIx6qqjS/ItTSfUmPrecIwTecYQygltenCfV+iRo17bIOslDxl9w
 WATJZXM0FHGBNUy7s21bHE0WJuIEIzbabpYMVzmaERwYtfIH8F+cvXa7CYA08fHPay7Zno4Lyas
 +4Hw/gZErJohLClqIYw==
X-Proofpoint-GUID: lgXLQ4WjxLEVZfXOPu0h697Oz5DRpw8E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX1JknfVqsKdea
 W36j2PwI/7CBrojRchhRFtpw8BGKkAEmeS6Ej1Niu/TMdqGVHJNH5W/oi2nBlNTp935lnQVN3kS
 hVplVC64cNUGo6zI+fj6p1tdtx6wiIo=

GPU virtual start address wasn't included in page count for page table
calculation for mapping an BO object in map() interface. It resulted in
map failure later due to not enough pages at L0/L1 level.
Update pvr_mmu_op_context_create() interface to pass device address as well
to allow correct calculation for page table memory.

Miscalculation of page table pages for mapping a BO starting at a device
address 0x8001b45000 of size 0x8ca000:
               old       new
L0 count       5          6
L1 count       1          1

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Reviewed-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 14 ++++++++------
 drivers/gpu/drm/imagination/pvr_mmu.h |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c  |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 23261d9ad3fd..62eae7fcd5a2 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2336,6 +2336,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  * pvr_mmu_op_context_create() - Create an MMU op context.
  * @ctx: MMU context associated with owning VM context.
  * @sgt: Scatter gather table containing pages pinned for use by this context.
+ * @device_addr: Virtual device address at the start of the requested mapping.
  * @sgt_offset: Start offset of the requested device-virtual memory mapping.
  * @size: Size in bytes of the requested device-virtual memory mapping. For an
  * unmapping, this should be zero so that no page tables are allocated.
@@ -2347,8 +2348,9 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  */
 struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
-			  u64 sgt_offset, u64 size)
+			  u64 device_addr, u64 sgt_offset, u64 size)
 {
+	u64 start_addr = device_addr + sgt_offset;
 	int err;
 
 	struct pvr_mmu_op_context *op_ctx = kzalloc_obj(*op_ctx);
@@ -2364,16 +2366,16 @@ pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
 	if (size) {
 		/*
 		 * The number of page table objects we need to prealloc is
-		 * indicated by the mapping size, start offset and the sizes
+		 * indicated by the mapping size, start address and the sizes
 		 * of the areas mapped per PT or PD. The range calculation is
 		 * identical to that for the index into a table for a device
 		 * address, so we reuse those functions here.
 		 */
-		const u32 l1_start_idx = pvr_page_table_l2_idx(sgt_offset);
-		const u32 l1_end_idx = pvr_page_table_l2_idx(sgt_offset + size);
+		const u32 l1_start_idx = pvr_page_table_l2_idx(start_addr);
+		const u32 l1_end_idx = pvr_page_table_l2_idx(start_addr + size);
 		const u32 l1_count = l1_end_idx - l1_start_idx + 1;
-		const u32 l0_start_idx = pvr_page_table_l1_idx(sgt_offset);
-		const u32 l0_end_idx = pvr_page_table_l1_idx(sgt_offset + size);
+		const u32 l0_start_idx = pvr_page_table_l1_idx(start_addr);
+		const u32 l0_end_idx = pvr_page_table_l1_idx(start_addr + size);
 		const u32 l0_count = l0_end_idx - l0_start_idx + 1;
 
 		/*
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.h b/drivers/gpu/drm/imagination/pvr_mmu.h
index a8ecd460168d..2c02d61ba0a2 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.h
+++ b/drivers/gpu/drm/imagination/pvr_mmu.h
@@ -99,7 +99,7 @@ dma_addr_t pvr_mmu_get_root_table_dma_addr(struct pvr_mmu_context *ctx);
 void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx);
 struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx,
-			  struct sg_table *sgt, u64 sgt_offset, u64 size);
+			  struct sg_table *sgt, u64 device_addr, u64 sgt_offset, u64 size);
 
 int pvr_mmu_map(struct pvr_mmu_op_context *op_ctx, u64 size, u64 flags,
 		u64 device_addr);
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 396d349fb6ce..867a4a44958a 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -276,7 +276,7 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 		goto err_bind_op_fini;
 
 	bind_op->mmu_op_ctx =
-		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, offset, size);
+		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, device_addr, offset, size);
 	err = PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
 	if (err) {
 		bind_op->mmu_op_ctx = NULL;
@@ -318,7 +318,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 	}
 
 	bind_op->mmu_op_ctx =
-		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0);
+		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, device_addr, 0, 0);
 	err = PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
 	if (err) {
 		bind_op->mmu_op_ctx = NULL;

-- 
2.43.0

