Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C38EEC3
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635372; cv=none; b=U3HZZdz0NXZhOX7qEqPPAQRrz/TN2vAHzKWfWulcztkOcSkK7YZY478KCN3798KHEJSJ/nRZhQZpIAhI/msf4TTUBKl+hMJ6dVya4oHpyPhfoRZvS+seuIu7MtHHGMpyCS8NEPmzhyoj++v6u/4ZbMK7v7X0ea7pyUZiISn3nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635372; c=relaxed/simple;
	bh=X+1vO3Ma9D7YLRAXtF6AHHSAX9mlO/gNqtR+QMtVimk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQNYexA/6AxkSnLwSrVgUDsILaikHAiO1FZ9K4JGpNVsDa0a83BVbCpRuiRqSLWjEP16rT+LV4JkcxS4OzZWcIhu5JRsFjeI+DIIikUKTQ7csEjm4gYBLLCVICEyZQQcQUrP11tcbTWw5zYJ04YdaCa9s8YsMR4rLFPBOvfMvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6VIIlYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6VIIlYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5808A1F00AC4;
	Sun,  2 Aug 2026 01:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635370;
	bh=6wRj75eZMxxEh45LggrOwZu4vmmGR9SVzUIC4/VJ3WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O6VIIlYzAcN28u2ftTbk+FE0T4421eD/eF0avj3YatdHGLILD/j2zV4Ae5JF23iqr
	 UvR3SQ3EkeufHWEDo9s1nisu/ytyJFLwXSltPuSKJXI5zkifUlz71mn1gfFGXvEEWx
	 mW4g3udc2pA3XT2NU9U06Ft5z21NVQNAqp2PHYU3+qK+61E8cbLc0M3ZKk+cocgycq
	 yCN8iV1EliXxah7Qv68oIrkFXbG5G/jAnmIaVmJkC3JKWRmdabL8ph5l3XdJSrfELV
	 2zmYpjpVVeFAOHQ3YVmyEwLMl5Wsrc/A+bfPEfp6GoWUH3PeiOGVAdXUF3osQqLly1
	 CwM/lRZAR2CpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/xe: Rename ___xe_bo_create_locked()
Date: Sat,  1 Aug 2026 21:49:27 -0400
Message-ID: <20260802014928.509277-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072925-decathlon-canopener-953d@gregkh>
References: <2026072925-decathlon-canopener-953d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit 550a42a8daee1b056f9b3e6c858e57451a5b315a ]

Don't start external function names with underscores.
Rename to xe_bo_init_locked().

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250908101246.65025-10-thomas.hellstrom@linux.intel.com
Stable-dep-of: 62775525a27c ("drm/xe: Hold a dma-buf reference for imported BOs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c      | 20 ++++++++++----------
 drivers/gpu/drm/xe/xe_bo.h      | 10 +++++-----
 drivers/gpu/drm/xe/xe_dma_buf.c |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index d5b63d90947f..37cf2053eeff 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1288,11 +1288,11 @@ void xe_bo_free(struct xe_bo *bo)
 	kfree(bo);
 }
 
-struct xe_bo *___xe_bo_create_locked(struct xe_device *xe, struct xe_bo *bo,
-				     struct xe_tile *tile, struct dma_resv *resv,
-				     struct ttm_lru_bulk_move *bulk, size_t size,
-				     u16 cpu_caching, enum ttm_bo_type type,
-				     u32 flags)
+struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
+				struct xe_tile *tile, struct dma_resv *resv,
+				struct ttm_lru_bulk_move *bulk, size_t size,
+				u16 cpu_caching, enum ttm_bo_type type,
+				u32 flags)
 {
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
@@ -1487,11 +1487,11 @@ __xe_bo_create_locked(struct xe_device *xe,
 		}
 	}
 
-	bo = ___xe_bo_create_locked(xe, bo, tile, vm ? xe_vm_resv(vm) : NULL,
-				    vm && !xe_vm_in_fault_mode(vm) &&
-				    flags & XE_BO_FLAG_USER ?
-				    &vm->lru_bulk_move : NULL, size,
-				    cpu_caching, type, flags);
+	bo = xe_bo_init_locked(xe, bo, tile, vm ? xe_vm_resv(vm) : NULL,
+			       vm && !xe_vm_in_fault_mode(vm) &&
+			       flags & XE_BO_FLAG_USER ?
+			       &vm->lru_bulk_move : NULL, size,
+			       cpu_caching, type, flags);
 	if (IS_ERR(bo))
 		return bo;
 
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 5e982be66c74..5b3e03510b55 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -80,11 +80,11 @@ struct sg_table;
 struct xe_bo *xe_bo_alloc(void);
 void xe_bo_free(struct xe_bo *bo);
 
-struct xe_bo *___xe_bo_create_locked(struct xe_device *xe, struct xe_bo *bo,
-				     struct xe_tile *tile, struct dma_resv *resv,
-				     struct ttm_lru_bulk_move *bulk, size_t size,
-				     u16 cpu_caching, enum ttm_bo_type type,
-				     u32 flags);
+struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
+				struct xe_tile *tile, struct dma_resv *resv,
+				struct ttm_lru_bulk_move *bulk, size_t size,
+				u16 cpu_caching, enum ttm_bo_type type,
+				u32 flags);
 struct xe_bo *
 xe_bo_create_locked_range(struct xe_device *xe,
 			  struct xe_tile *tile, struct xe_vm *vm,
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index c422f7d60115..412861c095c3 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -212,9 +212,9 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 	int ret;
 
 	dma_resv_lock(resv, NULL);
-	bo = ___xe_bo_create_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
-				    0, /* Will require 1way or 2way for vm_bind */
-				    ttm_bo_type_sg, XE_BO_FLAG_SYSTEM);
+	bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
+			       0, /* Will require 1way or 2way for vm_bind */
+			       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM);
 	if (IS_ERR(bo)) {
 		ret = PTR_ERR(bo);
 		goto error;
-- 
2.53.0

