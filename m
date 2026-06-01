Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEC38F239
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306830; cv=none; b=Ftc3jU+yqnpo4K+8TUhJZkkwWURi25aQ6voXzYrxdnwYv0jg/A3ps/hWd/xJQ+CSD288s24QSu/oYo4Zl4jKRwPATDBJZAG6gQsu6c63igWpBDnrZsGLo1vzl7PoeT/mMv+E+VIWPY4viIDV74NHkkvdW3B/rGbywSujRK9A/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306830; c=relaxed/simple;
	bh=+RSiV4t9ZMPDIDecXW8eTPPICHYbj/MQhsKjjWhoYsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZWfIdo54Bp8FQrbmNBKq/lGugUq6rwhwPiTBHV5/LLgvGD+MA5urUY1zyOjO9CiBEQ2Usm+0n9OtEn6Sz0qqbuLcUOqQX/OxHzD7+i/PiYTgivI8xBZSfJDj4MiB0pd7UiHkpSnXT+ySKs3x/3P9cQnRidiOow7fmOJxm9DyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6l/voAi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6l/voAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780306828; x=1811842828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+RSiV4t9ZMPDIDecXW8eTPPICHYbj/MQhsKjjWhoYsQ=;
  b=T6l/voAiKBBAwYTC2983HeH1286gMa4dbgJM+Tnvl66spsv4hBgTWDPg
   1L/BYMkQen0FOoGrgsVnd98CmwLcM0oBGeHcCfWHeFSIATA88Iyl/j19Q
   ti8QTCnVPNMSY+qLnP1qtzOpbc4R9ZuRd353inEsMcj77SJbfpzQTbJP1
   ljhIPu4zHjMadQLgs+mQOVP6EFw2FzVpvHnq7OKjOMOU2HYxISiwjOm15
   RDCysszdnyKRHzDZi5XSwRRHNHvS7HYpLdgjjsqJirneXJh0iSzcdm/ft
   i8OyDwrh/qQqHISlg3BU4gPVAH8oiTMb+O8wA9xFXMwceiB5cQzMHIFeD
   A==;
X-CSE-ConnectionGUID: adz3J4x2QRmXtsqcL4iMSg==
X-CSE-MsgGUID: D24/tZJrRJaaMifgXvlVig==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="68595816"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="68595816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:40:28 -0700
X-CSE-ConnectionGUID: 9BJz7sp5Smmqb/5ZXjUfGg==
X-CSE-MsgGUID: b9cZHzXPTa29C6uRfpUttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239344266"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by fmviesa010.fm.intel.com with ESMTP; 01 Jun 2026 02:40:26 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach failure
Date: Mon,  1 Jun 2026 15:45:37 +0530
Message-ID: <20260601101536.1333480-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_dma_buf_create_obj() creates the importer BO with obj->resv
pointing at the exporter's dma_buf->resv. When dma_buf_dynamic_attach()
fails, no dma_buf reference is held so the exporter can be freed
immediately. Since ttm_bo_release() now always defers cleanup for
ttm_bo_type_sg BOs to the TTM workqueue, the worker later calls
dma_resv_lock() on the already-freed exporter resv, causing a UAF.

Reset obj->resv to the BO's private _resv before calling xe_bo_put()
in the error path. The BO is not yet published (attach failed) and
carries no fences, so the switch is safe.

Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG (QEMU):

  Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b9c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
  Call Trace:
   <TASK>
   ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
   ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
   ww_mutex_lock+0x3c/0xb0
   ttm_bo_delayed_delete+0x41/0xc0 [ttm]
   process_one_work+0x239/0x740
   worker_thread+0x200/0x3f0
   kthread+0x10d/0x150
   ret_from_fork+0x3bd/0x470
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..6d944bd4065c 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -384,6 +384,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
 	if (IS_ERR(attach)) {
+		/*
+		 * The BO was created with resv = dma_buf->resv (exporter's
+		 * resv). Since attach failed, no dma_buf reference is held and
+		 * the exporter may be freed before TTM's delayed_delete worker
+		 * runs. Switch to the BO's own resv to prevent a UAF when
+		 * ttm_bo_delayed_delete() tries to lock the stale pointer.
+		 */
+		obj->resv = &obj->_resv;
 		xe_bo_put(gem_to_xe_bo(obj));
 		return ERR_CAST(attach);
 	}
-- 
2.50.1

