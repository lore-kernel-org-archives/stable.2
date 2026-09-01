Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA33C0A13
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267825; cv=none; b=YJaCPhoaOhsx2KGsNRBgyDl0SSl1u6pL9FOfwY7+207ouHxlEMnXhxbrJBog5oXovgdL507XUgn9wBBYfOKM0YCm6+ulDWAdxaTqkVPXYVPrTBqFA00w1+zP6iE+PUgSUrqzXWjhaeI4PDG52NB7nzAmbHPSLzWF53HOLygoPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267825; c=relaxed/simple;
	bh=R2i8bF8LbxoB3S0yvidye80F+6/08ElMFw5/FwfgP/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkCAXG1Z38WdgWH8vRXpjjXNNLecMvrzeHGp82o0jExxAetFysaKvILTAixy+3mO8KqOuDnP96AWxGP5KkGvslwf0nFOTSgbt7qFpSlxntuZwgC9jyrgIbdMQIxr+FJ4A8rcO24k83bupxVORKNfUke3M3lLC8GmpzcBtLjSvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGId0tGP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGId0tGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788267824; x=1819803824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2i8bF8LbxoB3S0yvidye80F+6/08ElMFw5/FwfgP/M=;
  b=OGId0tGPQnGwholK4xM5o7Hb3cqi/hMNolLpiYDWdWyYSZg/cAib2cD4
   GWjMFSVrksqx/ymY3Y+44poxl5uO4HhitDbNE8s9t8H5SfQT/nCo+ktZr
   2pi+n8VJ8hnlxOo43pD+cYfeMgrAali3iqcgPstt/N3nXDftzzMi+TT/F
   oB/mQQtuwOH7LoSA6vhJp3FEM6lVvCKOuFuOz5AXs30RCcHfSzaB3Q9C5
   v7d8VSOnzv5mFUX3z7ozr0Wwfm1LjJ6f4kLzrx8HU/LbxT5Qqt7zCtmbh
   QirGJsdAMHEVwBzxIiz2aFKtHL67tHX7WDAk0IIsZfFtXpx3WdJjRzC71
   w==;
X-CSE-ConnectionGUID: GN5/0SiFQv+5l7Pp/4+ZZg==
X-CSE-MsgGUID: IlwgnbVdR8W8CuPX7qhyRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88706289"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88706289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:03:44 -0700
X-CSE-ConnectionGUID: ARlmW3baTS6lsbTONI0seg==
X-CSE-MsgGUID: uQHOgj/pRci5F7wGyWZlGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="271029710"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:03:41 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	karol.wachowski@linux.intel.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Magdalena Schulfer <magdalena.schulfer@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
Date: Tue,  1 Sep 2026 14:57:47 +0200
Message-ID: <20260901125749.404338-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
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

