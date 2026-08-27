Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F341DE1B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826578; cv=none; b=Tav7qZe0CkOQqzgm/365T6CpOtv5ywJPBN23OYwdV2i18XLJzuRcnJ725as/EkbuSg6DRXER6edH/n8wG+sCesUYMpraAXyt3dxpV3yn/OFnyqeNR604hu53XOvtsnpopfta298u5Y4x9dcVYVef7CEKXmitDS6EfPy8ZNUJO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826578; c=relaxed/simple;
	bh=R2i8bF8LbxoB3S0yvidye80F+6/08ElMFw5/FwfgP/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYrpHIOi+h30Pmp2IwqB3mF9weu9hvyAmfZi/iFX5d3luDm/v0/vUmCZAfIEalGIu+HfG8huVMvxV/6KDwhPLsY1J0tcJKtQsEhbI0S0mzn1e6ZlTmrywkLmfyVt2d0Ktmku6DsufVzlS0+KQuvC9XSaCkbqnnYdu+4eTy3xvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnKeA7d0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnKeA7d0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787826574; x=1819362574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2i8bF8LbxoB3S0yvidye80F+6/08ElMFw5/FwfgP/M=;
  b=KnKeA7d0yxUt94d4b2jkQ9a8Qt76zKPdG5CHny/GiYUKgGSTMl1t/BnV
   X0yFn3+OP4FFoCb2vClKcE5a7hbF3wlH5JB/YxeW1Ho6tK7gUEgEMI5uG
   PQU8xtJF56HH6UnLCnL5+IYoutqBfiFd6h+nNzECIjhhr5DnIgE8F7FUY
   Ob2zokGIarQ0tppwuCJ5wu48N8oSj0kmCMxsnen2W82xW5BfzXw8FQtxo
   Vv2CHf+pSyDrQeMFUXSXh982nitYbMZaZgpoOCVqaVbo2EeoR2SwS+66c
   reXXpncSK1Qt/yqZH4TACAOwapLX2cXP8KbcZXs5wRTCBnU+dDP2pemm+
   g==;
X-CSE-ConnectionGUID: fHDH5qnjTamaKh+oBGmXZA==
X-CSE-MsgGUID: +x9aJOBHTdGeKWaxwLo+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98920683"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="98920683"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:29:31 -0700
X-CSE-ConnectionGUID: nVhqKwGfQRCV32gaVneBgA==
X-CSE-MsgGUID: G5DmhbXTQ+uW/sHccESRkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="261711636"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:29:29 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	karol.wachowski@linux.intel.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	Magdalena Schulfer <magdalena.schulfer@intel.com>,
	stable@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 1/2] accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
Date: Thu, 27 Aug 2026 12:23:38 +0200
Message-ID: <20260827102339.281799-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
References: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
Content-Transfer-Encoding: 8bit

From: Magdalena Schulfer <magdalena.schulfer@intel.com>

Add a size parameter to ivpu_to_cpu_addr() and validate that the
whole [vpu_addr, vpu_addr + size) range stays within the BO.

Cc: stable@vger.kernel.org
Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Signed-off-by: Magdalena Schulfer <magdalena.schulfer@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_gem.h | 14 +++++++++++---
 drivers/accel/ivpu/ivpu_ipc.c |  7 ++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 0c3350f22b55..b1ae020a4fc2 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -87,15 +87,23 @@ static inline bool ivpu_bo_is_resident(struct ivpu_bo *bo)
 	return !!bo->base.pages;
 }
 
-static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u32 vpu_addr)
+static inline void *ivpu_to_cpu_addr(struct ivpu_bo *bo, u64 vpu_addr, u64 size)
 {
+	u64 bo_size = ivpu_bo_size(bo);
+	u64 offset;
+
 	if (vpu_addr < bo->vpu_addr)
 		return NULL;
 
-	if (vpu_addr >= (bo->vpu_addr + ivpu_bo_size(bo)))
+	if (size > bo_size)
+		return NULL;
+
+	offset = vpu_addr - bo->vpu_addr;
+
+	if (offset > bo_size - size)
 		return NULL;
 
-	return ivpu_bo_vaddr(bo) + (vpu_addr - bo->vpu_addr);
+	return ivpu_bo_vaddr(bo) + offset;
 }
 
 static inline u32 cpu_to_vpu_addr(struct ivpu_bo *bo, void *cpu_addr)
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 978bc3d8704f..8f69fb133e2e 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -79,7 +79,7 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 		return -ENOMEM;
 	}
 
-	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr);
+	tx_buf = ivpu_to_cpu_addr(ipc->mem_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 	if (drm_WARN_ON(&vdev->drm, !tx_buf)) {
 		gen_pool_free(ipc->mm_tx, tx_buf_vpu_addr, sizeof(*tx_buf));
 		return -EIO;
@@ -420,7 +420,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 			return;
 		}
 
-		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr);
+		ipc_hdr = ivpu_to_cpu_addr(ipc->mem_rx, vpu_addr, sizeof(*ipc_hdr));
 		if (!ipc_hdr) {
 			ivpu_warn_ratelimited(vdev, "IPC msg 0x%x out of range\n", vpu_addr);
 			continue;
@@ -429,7 +429,8 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 
 		jsm_msg = NULL;
 		if (ipc_hdr->channel != IVPU_IPC_CHAN_BOOT_MSG) {
-			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr);
+			jsm_msg = ivpu_to_cpu_addr(ipc->mem_rx, ipc_hdr->data_addr,
+						   sizeof(*jsm_msg));
 			if (!jsm_msg) {
 				ivpu_warn_ratelimited(vdev, "JSM msg 0x%x out of range\n",
 						      ipc_hdr->data_addr);
-- 
2.43.0

