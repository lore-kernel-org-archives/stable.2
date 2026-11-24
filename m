Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795548371;
	b=BQ+gh1OJ3iP65jNQdh+QzmXni8ionw+ZEI0nqHHAB+zn+NdIYNy3JHREVsJqbUxQYd13
	 nbtkwqY4k3CQ+EXKgoOJ4IvXSXCzziDYMJIUv2fcZMXSDojxeqVT0N9sRLLAX0RgbIs6j
	 iKLt40YQY02py+nN+zFvCpUNMPIbnmuqafkbwi7kw9k1e9So5k90jmyRXtgS+8F+Ov5qf
	 nbJ/i7ZPANPoly8NcMmZak7jTxNWlnMin3ell60O8l3YBASGjL59eV/dcP6frUYgbPCYm
	 vdTUaNMrfVdpX0fqB69wcoHKEH1Iup9ow5ijKTMrkT+N/xjW58BGDnbUWtuZLonf3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1BnuF23XQPA0m74Vl+zVMfRMHbdMZPwomn/o/FDuIqk=;
	b=FjMuKn/AV0zfTs5+DYCfZMGLcQbB0WHwDh/vdULxX3Er/EqZycGlQJHpaqhdKvIcH967
	 UyW+y5w9nDVAi+f6kP3de+GZpBQMP2i7FpEXptVNY/5MkdJfjdtMawr2X/2+1oYt1M8pJ
	 jbBiOusJrSwGPSLYABgXkK0B8ElBhJO0erzkRPgN6ALNSUAWVYW/zJ6OoJI37VVF9qLCX
	 2GNjzCLXO2LQzBtq4bKeGtwc2BMN813U3/9aJVlqzfDB2lSL8g8KyOP4x6xtOnCIbAPLP
	 GzwJfE7Wqk3N/7Rlw3vZHVMPD7vWC94+ojvHrmoVyA8pHbAO6WVONCoYHb32ayN3Nkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JLoolxZh;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C84606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JLoolxZh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795548370; x=1827084370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A/Kb9OtXc9sWmShUGKKnDOfx52PCBRfWt5X5T8P/DRo=;
  b=JLoolxZhI46tgqLO/X7a0mBInvY7ai+CNVrG7kY6BxioTE0etNEC7sao
   AGi0RpMbR6MT0ZJDdTW1T+Dg8HCDzcx5x75zOgYx/KR3HPSr5LTJAQKQW
   6JOO9bNfLPJ16IllJQsGgEY7xsBjSUDBQ5eI/IqcUbW4w+cQngEsSAL6P
   Lfdn4kalYqTCa997cMmwyG1cXgVhLyClLAoM1ysQLDy5Cj8/GE0cUBE/H
   nXqHB6EA4fsPrEkRBO+dGJD2HBkCTFn72Ab9hKBcuKUOOUYS0xuOVee12
   bHeDAQImBesDqQcO5jKrOMlw67pGhL/q4uYC9beny/otmB8sBsI4DLNZR
   A==;
X-CSE-ConnectionGUID: 8r1eloThQf+4eTOZE1d1Yg==
X-CSE-MsgGUID: s/gH3oW/QFGgwxKyz+hjsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4488659"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4488659"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 11:10:18 -0800
X-CSE-ConnectionGUID: IcURFiI9Qsi7gEmd3aNJ9A==
X-CSE-MsgGUID: rg2omO0TTKeOHk6h/jH6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12066008"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 11:10:16 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Natalie Vock <nat@pixelcluster.dev>,
	Arun Pravin <arunpravin.paneerselvam@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when it's no longer needed
Date: Tue, 24 Nov 2026 20:09:54 +0100
Message-ID: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.1
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

The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
VRAM. In that case the bo may still carry a ttm_tt that was created
for its deferred placement, and it is left dangling on a bo whose new
resource doesn't use a ttm_tt.

Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is NULL
or its memory type manager doesn't use a ttm_tt.

ttm_bo_tt_destroy() is internal to TTM and not exported. Rather than
exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
export that instead.

Patch and commit message was drafted using an LLM.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Natalie Vock <nat@pixelcluster.dev>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 20 ++++++++++++++++++++
 include/drm/ttm/ttm_bo.h          | 15 ++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4d5a09..7f3459db596a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -202,6 +202,26 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_move_memcpy);
 
+/**
+ * ttm_bo_move_null() - assign memory for a buffer object.
+ * @bo: The bo to assign the memory to.
+ * @new_mem: The memory to be assigned, or NULL.
+ *
+ * Free the current resource of @bo and assign @new_mem to it. If @new_mem is
+ * NULL or its memory type manager doesn't use a &struct ttm_tt, the bo's
+ * &struct ttm_tt, if any, is unpopulated and destroyed.
+ */
+void ttm_bo_move_null(struct ttm_buffer_object *bo,
+		      struct ttm_resource *new_mem)
+{
+	if (!new_mem || !ttm_manager_type(bo->bdev, new_mem->mem_type)->use_tt)
+		ttm_bo_tt_destroy(bo);
+
+	ttm_resource_free(bo, &bo->resource);
+	ttm_bo_assign_mem(bo, new_mem);
+}
+EXPORT_SYMBOL(ttm_bo_move_null);
+
 static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
 {
 	struct ttm_transfer_obj *fbo;
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..d525e04893ed 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -356,19 +356,8 @@ static inline void ttm_bo_assign_mem(struct ttm_buffer_object *bo,
 	bo->resource = new_mem;
 }
 
-/**
- * ttm_bo_move_null - assign memory for a buffer object.
- * @bo: The bo to assign the memory to
- * @new_mem: The memory to be assigned.
- *
- * Assign the memory from new_mem to the memory of the buffer object bo.
- */
-static inline void ttm_bo_move_null(struct ttm_buffer_object *bo,
-				    struct ttm_resource *new_mem)
-{
-	ttm_resource_free(bo, &bo->resource);
-	ttm_bo_assign_mem(bo, new_mem);
-}
+void ttm_bo_move_null(struct ttm_buffer_object *bo,
+		      struct ttm_resource *new_mem);
 
 /**
  * ttm_bo_unreserve
-- 
2.56.1

