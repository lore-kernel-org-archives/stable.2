Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BB3EE1EE;
	Tue, 22 Sep 2026 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051256; cv=none; b=L4/jFi/fdpGjjFZ5Tca8lTOsBjO0nSDlDSBnRDKxT8Pune0L+1dlN5SayvayCTm1EWtSq1m9NtCd2AhjUzwjTuNyuxawLO+TgQ16kt6III7FUXMWKhEFviNhXeSY/jEeKpcpqW8rVmojeqeZ4P+DNQXsrN+kWq08Xq88GrnjVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051256; c=relaxed/simple;
	bh=6vy6U5iPr6I/EMMjZ9ppuxiboba1NgugXVPdXYqGQzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CE0CUOa5P4jxqUrXbDcr6961x9IsJ5amuiYjtHqOgwDJgXhxTLvtpfRfX4/kEsJ9TeSGB9taYilMxsqQoQVXUoHwimrXiml5Tb/V0mX0LORqrNR9Htz1XtP7ayWxT626Ig0j5YzubyR86glDqHrXxEfuobxe+eoVqEAkxB2T3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=OSj6P2Bd; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="OSj6P2Bd"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M4P2tH4175838;
	Tue, 22 Sep 2026 05:27:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=H
	rGv+yXH49C3vUtMO0bXAyH0pthrtMmxMwBMqDo1n0c=; b=OSj6P2Bd4crDtZBZ4
	N24ZR9V/2Oli4kjOLpfmxjx7qmvphGp200Xx9m8jGNRAEzQn4PRKXixR+p/Mo/S6
	wQzYuBSSFPWOkbft1WM6x66gqgnU5fibFZqYKfPlSjOcP+Ywb6J3OYb6wNl/mPHc
	S8soFugJ5hySbu2zzIpg4gvnfXsxxaMiRS8wNmg3TCra3hNVK7hoR1XSNMhmV3C8
	A8uGkyfruoKQiMK2FbrETSvBjwBOhOfJIH861oHOkKTTew3v8JfcYin0k+G1QtXR
	knAwDhm3FtirC6Oe07bjBAM6xtPYz6i+GrpWypnpRO9G1ygUdl899fm2vLpKy0cq
	Hu7zQ==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq22je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 05:27:15 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.122) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 22 Sep
 2026 05:27:12 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 22 Sep 2026 09:56:56 +0530
Subject: [PATCH v4 2/2] drm/imagination: Fix page count for page table for
 map() interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260922-mmu_fix-v4-2-12f1a871456a@imgtec.com>
References: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
In-Reply-To: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5142;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=6vy6U5iPr6I/EMMjZ9ppuxiboba1NgugXVPdXYqGQzU=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqsgOYa3cnfplVxK7UK8YuKEuZoCjFwCOEjQM+C
 3HcE09Kvj+JAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCarIDmAAKCRDQJndZfgLx
 cGWSD/9wnpyb+bn3GBfUS5X5q+SoLho8qNTpaIe7MqgL3ZzlGVGNyChFNaSI3/6ezFGLdkP20uB
 YrFSwS1v6yGaQGzXnpdV2jtVJznZaNz/mtOTqtGw+GfednWg1eaoilOVNY4M6/X/5FkR2SeZexY
 bahVDSxsi/IW0ZnobJ379Dt1Evr2ffzWJyzqpjiYh9p9qsXKMIWQmLYiORpbGqsh3YIvsT2s+67
 u7i9ernD5gMxP1LHbm7wY/7Va5eECbjgkk2Jf9b6k+aPWzxb7Ya+l1Zxry5ADc0027AELocaF71
 YUzpVoItXtgoP+K6xVhuzx8uSv7ACWj3/kC6btqIZCrzB2BHE7E3C3wGFHfWhtCbl9iGodLeT4G
 eq6vF94MtH/PODFOaEPQr9pJouMf0lOYCtOGbEPu3odR/fynO0xmAKWrSyMNQta/+fQEPQbUkHV
 I70T8CuDPfebRpCV1lWiDlej7VQj9mZB9aYVY/g8zw27uu/F1E2v6jWRe4VXIXIwD8ifascEDRS
 7nVdtTHNq2Sx4krd+msoGslYEA5Ahm6hMbtOouQFe+yurF5zgBI3hpir+KqRcJdpk4RjAyqhte2
 vtdwsmG7CqqlBaxvv31r/3Dc1GmJMDC6k+v4lFjz/q/zfo/uDzBPjffwtfViljvmFmao8DisALj
 d3wuXyXvNXEjWIA==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfX+VfDChm5HRCG
 KTzvJrEmrxg2ce1kp4JJORsxPMIxNFxDVUDOiUyForQmaqIHrd9Bkgm+zHj5gWklew2xTmBGmfV
 EilPjgNrwsKpDbrfQijxs4c3XnPe3E1YdI4nigMHKhz9s8UcTaTO+ZRv2EyNYcjB8ciAsb03nng
 a+0YWTp0n9oc/vSmpk+w6RXBJgNo5INyju6pgKK2+BThBhdHnwHA12EbDOJ1bqj7q4spNdNo0C8
 JuRxtLT98smVc+Jm8g/+dXQuvLRtdhng0aC8p46SNDPqahoQX2TgIrFP60zYpeUYT/jePud0Ymi
 wwDZaaAhDPFXKrLF7MjPgl6ngEWy617Wy/LakroGydzxYLVyEIzFsu7X+Aw4b5Tu0kzg24oH5Tf
 nSHu3Ws1GDBiEuMnauoLALASOhEqLgFvqYU5IIMeLmAgxUsN4ZG0MLUD/+V2rov687ZhLL0/1k8
 V9Ubv2kmrEO/BT/s5lw==
X-Proofpoint-ORIG-GUID: ZzLfsrXLNVYBSKlkM3s3_xudxGMpVjI4
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab203a3 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ofw6MtmsdEsA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=xl1JLUuWoStywUw0sDsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: ZzLfsrXLNVYBSKlkM3s3_xudxGMpVjI4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfX03jmSoSTP0jc
 h7J90BY+9538WGJBcwrBNXBcv94LPu+UuZCH9nXf51URMhdQTjoM/Z15VgRWbATimvmLe1awM0f
 Xvzj37dksQPXhb/Sapx8cAWqhcgg8V8=

The GPU virtual start address wasn't included in the calculation for the
amount of page tables required for mapping a BO object in map() interface.
It resulted in map failure later due to not enough pages at L0/L1 level.
Update pvr_mmu_op_context_create() interface to pass device address as well
to allow correct calculation for page table memory.

If L0 tables cover 2MB (0x200000), the range defined by device address
0x80001ff000 (general heap at 2MB - 4KB) and size 0x2000 (two 4KB pages)
requires two L0 pages to be mapped, but without the base
address a range of 0x2000 computes to a single L0 page which is not enough.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Reviewed-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
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

