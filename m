Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153D42C4FA;
	Wed,  2 Sep 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343010; cv=none; b=foW33+w66rXLorK9DfDrA/ed6u4Mwy1vadR5gv0oLJaD0ciqcYChCj0sTdBZovUfBMc5Mpcq3PiPRpSj6YZYKoj0TzB8wSED8jNwwxv/1OIxqiZ0T9Gnql1iEBc0zzTZQQjmP0147BnJp0uC3bTP59kukqX9+DkkIMu+KFrzQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343010; c=relaxed/simple;
	bh=Z4C3XcmwQrDZRC3N48cXZdvB0rcLR558TD8Wlt+9mjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a9U/0J385ZI4PRzh9jpwcjvMt/vT346RxgHxtWSG5VMhnzcjn9uIVEiwUfbQfdL+EqpnDkKgVBiDureAMctNHqDSREAL1pq29z7Z5Zfn3MsaJr9GebjEalynWImtiXxiKS/tup1vXVyCPNjBiPEsZfHV8lBvnS3Q0GZYo27/gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=of3A1UUE; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="of3A1UUE"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829Pd8R2434461;
	Wed, 2 Sep 2026 10:56:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=B
	GGwoFpQnXV4GjeWZIyIezYBBWoVRiSu7p8slXrghwY=; b=of3A1UUEQL7qIjcn3
	WtD3hbq9lmRpNo2LOASghDEvQ0qPhRKhGIYSQ3M8AdM94RcwOyFa6yrQHspTlg/v
	gEoqK4TjpDFVVNmxT8NHOHR4OxP9HHaxYyi1l8kJ/CcLjOyIUkjm1jNCpDpQCzKB
	Ac7f7w7L1wKDfIjYpX49QUmajFC2h6U001T3rgBwSHo4b3gRXB8Y/3iIDf7T8raV
	gHPQMRKlYij0NKuu+A6/76YpWdQJN4dS17gKU+DrvJSHpz+ZjpiD3OhFw1+h8ZSm
	sQk4BtE73cfb8HB0Iehy6F7pIQA1vATno4okDqMQZs6YIPrXGfRZtqfXBWRSMJSo
	GZOcQ==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gbqgvb7kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:56:17 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:56:14 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 2 Sep 2026 15:25:32 +0530
Subject: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
In-Reply-To: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4930;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=Z4C3XcmwQrDZRC3N48cXZdvB0rcLR558TD8Wlt+9mjo=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBql/K4zxwZc2yPOf/c7DbUnXk0FHGyJ+j6QSHt3
 bwv2ZMtUreJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCapfyuAAKCRDQJndZfgLx
 cEpiEACCTQWZK/FbBVUW2lMYOjsIxng1Y1sCjkhN75Uj5mpo4HzoGRhN5xtl79Wodq3kY8b1fLo
 /8UcfgC4H/Wn/g0mJsRQTZRqP5f5tlKlBSBVBjwYSwnWaX+wF1Ejl6jozGgw9TGrppJ92x/UcZR
 AV0G5S2oktWqXl0RDFYaoP0pCyQTor1Ejro4+KoGOOe84aXkDCani8yzTflAUYc5HvOusjMyj98
 jir0ZhCprXC8PmU7VmmSFWWFj4cRdAogWB8CVl+kqAJRu124DfgmeMe1wIayNEdaCvoJ3DzMjA/
 7xw/OIVGPmsFM+uUx4JTJREUDem7la3l4/ifLUbE81t0THTKMgQolruJ+fC5eGBWNg+V+uJPfat
 IFocd5v2JLzGm8N9NV1Yb42ckvVRKhOOHmDwreXAYQXpQE4XdCvm6AIQWd35+J5QRmym1jB4gup
 3D1yEcZ0QSjA6RipTapY+5AIBF2B2woKW0ErahWXDoEEyXu3hA3OtpBpwtWqMTAWHjdcKqkl/yP
 18fbnukHBBOGBOb+WK1HdO5kg4BjWfpsOqjtU4ATcNePCkQ436t+m0j8gL5WzIFFQB/mrxjzvOg
 R5P3TDlAu52myoRd8LiBvIbS+F14eFF54u/SxHtAudwgyWCSPysj+BMhswqBRHTVA1d2qPdP5bV
 3giCn5m4IAMnmfA==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-GUID: 2bjuldljHsTPpOGzhfgaDqfCmJMx2dqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4NyBTYWx0ZWRfXxnYUbKRGIBLH
 T5C38QWgUL4nEI7faUabuwvEKQHkg6Xd6zDhxa6E7eQKzIrW96tZiOrPrhhiGSYlnWZFP33qmAK
 /YOzKE7SyicqO8SzlsktE1bhoQnP7Kd5+kGOdjzEhEpvLhl7JpkTSvKlIFe4sBxz5X8kyYBf5G/
 cBt2rIoD5uTwGP2YNWIoYyD+aIacc1r6U5aEdAWQqwU9kiZqxLTf4ZkLxUBgreBKdcMsE9T0chM
 hY9qQIi/qvFZuVe9/qWroL0zbU0TfHBFXx0um5EVxwMEay+wXbKW7ueyKdz5mec05ZiXovx/ji+
 6J16j/tEtTSKU090UymhKf3PzgCFbJ7efX38V+3giD9FpWPMmIyKGQA+XlOHnd2t63ib2lQ8bBb
 6qevpgsFEQ0hPfWt+lQKjSA7xYafwBIT+fZIf8r+YgOlqBwYVHbH+bmY/wVlhxyvH1BspqreNh1
 emMVwkOnySmRPw+ZVrg==
X-Proofpoint-ORIG-GUID: 2bjuldljHsTPpOGzhfgaDqfCmJMx2dqw
X-Authority-Analysis: v=2.4 cv=OcCQnBTY c=1 sm=1 tr=0 ts=6a97f2c1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=lyzDSBJAejP7XBH9i10A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4NyBTYWx0ZWRfXwBsa15hMG5Db
 VjyotfB1fys/2EE43iw+SeMcA4wMqwH1NVw8feSCegE2oXLiYKnfUIlhU6Ul8MzaR8aRaHAuJlO
 ack1KgIGZ/eYBjhak1WEy8oECAEfDHA=

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
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 14 ++++++++------
 drivers/gpu/drm/imagination/pvr_mmu.h |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c  |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 175f0ba4d993..52d8fbc00384 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2336,6 +2336,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  * pvr_mmu_op_context_create() - Create an MMU op context.
  * @ctx: MMU context associated with owning VM context.
  * @sgt: Scatter gather table containing pages pinned for use by this context.
+ * @device_add: Virtual device address at the start of the requested mapping.
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

