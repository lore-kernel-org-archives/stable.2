Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC34B7A4F;
	Fri, 18 Sep 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728117; cv=none; b=Mf5GFnC4/4oaM/zXIP5f57zCzTJ0O/S6INpklZKxuKOk+jlAYAxQ+JUx/1BYx7H4m+ub4poOb79Hy0dJLeM+9OFfZw6egf7Mc5LxxTWzcdTZVMHObjKVILLy2DdkFxIhVbYRT/+XCMiIU3XkBVMmmk4DQNIYdIqSogvIYBHrOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728117; c=relaxed/simple;
	bh=hr31MLDk78Vm4gpqDFRdeOtP0lsOlahxqI2LUyBNWOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UZWbmn00CV/l2CaUm8wlf9Lgxl/G/1Ls+dsFrG9pi8kBJdrqEvjK6l1XRTQ+22b7iHCZV1lSDVxuI01Zij9BTymQnojNSJZA4WVxorsbtaFVQHocnAefrXqwK5wBTPtJjzl7OZM5bLGMV2eUBRUGbvEeGMc9L/Ik39djJC7bLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Z0JnkJZ9; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Z0JnkJZ9"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9deIo1687771;
	Fri, 18 Sep 2026 11:41:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=P
	9s+38RWbu/7v34wRavJ3rNdn0EYpfrcE4CennW2IuY=; b=Z0JnkJZ9QIYXU9lZM
	ML4RBHnJtXQhTfZf6WgV74mcPpJAfc6CLPWh7u5Um5HGpjSTLtq92BdmoLex5Ydk
	WtzKfDJxqt5YjLOimuTQlPePLY4QyQbnYglTMKPkXqhOMhcWneH8g65nSNNgP6fn
	hkCrInR+jfvpUaWBiXJktS0ksusdaTYJuEFbQg5TQgrg+dLJ3SZ/KcO2v9gYjoC2
	CJ9vXZ3hbYtQ7X8bOcLeTIrHdnqOOdFbJ3bRBsFEa3Phu1xMXrJbQupmge3Rwm6h
	NA6tG/Box4LHQn/SU7r58WX/15vuMvHjX8K332VTOFe4PJauLlcwr60iOlhKscmv
	xLu0Q==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtungv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:41:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 11:41:31 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 18 Sep 2026 16:11:14 +0530
Subject: [PATCH v3 2/2] drm/imagination: Fix page count for page table for
 map() interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mmu_fix-v3-2-7b3d73aef041@imgtec.com>
References: <20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com>
In-Reply-To: <20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5065;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=hr31MLDk78Vm4gpqDFRdeOtP0lsOlahxqI2LUyBNWOo=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrRVUf3/1+de4tw5zWt8UgEQZ7axbPC84XGfvu
 b8Vid2BQHaJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaq0VVAAKCRDQJndZfgLx
 cMS3EACTgs3HSvyLNgy6GU5Mkxw7asew/eUWvdqiptRxAgcEySOKPQMpg73VIoESe1dy177DS6T
 mQ8mqL+IfcgdxqWBHw/x3STv6nRzDPraz77btOQzXuzFJhcL/lFRIMutK2ie4FDBr6xSVGhw18m
 oY8qqE+s9qryVQ10AWbSJzyV5tYptcCTY3aSZPgiUDWuzvGNqvgb7xEfSNgrN7G5Zw19SmXtJ5R
 yeqxg6xFmnLfhIQl3vMfCi4xA25mSKGUyp9dh7hRkJXSnZrPyUtHWuwfMJBjBxNHIHbEn4MyU68
 D35HPIik8LBZo2Wznr7QhVaks8u909xkSVChupVLACgJSiDEdLJFme+wbRKgfUqE1exvQBn81es
 l53XZ2fD2o70qkhQUmzR3AOgCNMiBWFcYE1b2eU/UlQLPvB8rIh0893MZmO/o/PlxNRM0KMDV/Q
 z2FWPeOABnF8t3JyzRGGBYzaHOIecv3x/5L+CayMjCVCciQJy8AsQ/wgMCX3dFo8II4pQLBOf9c
 7c57nR0aBDjPUmfGbELoatW/d5rfNw+1Mu+9J+d38QtEWUJDimmBg1s2Aa6fNvyrJLDQsY66gy3
 QBGPh66+YC54oWC8Ovkk9wnYL3WQxcvszn0iyL16K7SOe71wqU272EWsAT+0yY85NJ0g8SQWQd5
 ao8yEvyUv7aUXKA==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aad155f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=lyzDSBJAejP7XBH9i10A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: OQOzjgKRMxNdoEJ1mV7ZhaTMNV2sC-o7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0OSBTYWx0ZWRfX8qTX/7yW+Jor
 C0qWQp766iQMU5zxusMTGNiDkXgEWzC/jBxh+9O8d+LpWHyrCyCkvyNWWzHMk4X/jE6UcG3baL5
 gQaWWpGYf03ggd+q71ekoMzH8VAVx1aqm87eCewn3aQcjKZYVNTo10YOAy5nnvhHSwv8m1PldJv
 iDoU2ANg5U1ETnoVHW2bmJBnVraxxrusheOmQuVtBa3vg9PkC+E/OP7OH1eL/eNRH8PBDgs6Df7
 nac/jGZ4qPhWNViaHEt4SaoJEaoZ2T9Aq6nCcME/ucT+0tY734I/hv1iipwR2NqtW23b4wYAf8Y
 r3ZcFiXc1QoPWo6G3QQYpn/Nh87eqsITCibWJXqWzPacXsGVqo8ECQL5DI0o6E19oRFmRfUtnJc
 XIQ8hoyvWsc7h5fOCNu5n0IYmtF3s/6A/NSPhMh48OQoXt4WDnlIC1UvlMj9x4QeXvkOEEBjqg3
 BMSdlsFV9g26Hff7N+g==
X-Proofpoint-GUID: OQOzjgKRMxNdoEJ1mV7ZhaTMNV2sC-o7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0OSBTYWx0ZWRfX/uPzFBQg9+YR
 /HT6FMAODuQ1pZC6wEcQajQX7IzVvuuZ/AQzBvMiNkvwcmZzfGOQkdkA/iCIn1BzBKEew9hbHuH
 2+fIukwXwxjMdhoRIQ0+RWLA5BEc2Ig=

The GPU virtual start address wasn't included in the calculation for the
amount of page tables required for mapping a BO object in map() interface.
It resulted in map failure later due to not enough pages at L0/L1 level.
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

