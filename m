Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28F1D89EF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593049; cv=none; b=qItGhcdHAo17L8cT4qIUL6/xhWtdNpmf+OOlOYrzNbvKjTcloZOnkgxj/iVEmmxJ1KbGq21nXrJ9Ur778/ZBulO/AJLhCYUcgabc+6JF5zW99BofiXKpL2IBVZK7mjJiUdIgs00CV+mRz8aO0BlWtjnfg0zMDGuUECIwqgQSHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593049; c=relaxed/simple;
	bh=TuyT8hANsk3TsB5lKscNCnk8Fs21GA6Vu+Q4d2a2HyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfRtUhuZd2ZHHvYW2oYBDoY+R3O7PLfZ2X3jbplEDNCPevkFSF+ojvw2oYT4qpkMLk8PKpXq+e1230p9v3nxRb3/IRbo+z6CmTCljzsHAmWWtrrhepdoE3B3BPE+EUttZMLaVMuEMHbgDj3+ddSBU2caIqNbN4WTV4jgmJYpjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VybzfqrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VybzfqrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7089B1F00AC4;
	Sat,  1 Aug 2026 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785593048;
	bh=YT9QfVzXzR+LbJGRkl3QE7i2tmBNtCuGue6arxR5BNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VybzfqrN7N+gJ6aWiVPVTiFgJrrL6mUDnsI4S+d02pAvvkrLcFpUyPOL2VpFsa2T7
	 ws0/ixFsRCsozqQpi4QGgiiIAi5RQWQsXzJCZ11kS0SVRQwJlk1pg/tcr5+/RX3LHu
	 3B64SsQys2wEaXBbChvuSMiCyza4PGQ6tMA+cIhrHpgDUZOfJgJ7dVv+y+65SMJxin
	 y54HGRBBkeFGpMJrqNIfcGt4Ir6p3hWrbD0enjILOa/QB5RvLtmmnQAYrcOgCU4h4a
	 0HuXLT2tTfaJFAD3L3SMndu9xFCdpTCXfoRu4UazqWQFnfcXFofT9qE1Tw8mMpgAVQ
	 2BrVHmnLAdKaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] drm/xe/vm: Prevent binding of purged buffer objects
Date: Sat,  1 Aug 2026 10:03:58 -0400
Message-ID: <20260801140402.3645391-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801140402.3645391-1-sashal@kernel.org>
References: <2026072936-hummus-emblem-55be@gregkh>
 <20260801140402.3645391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arvind Yadav <arvind.yadav@intel.com>

[ Upstream commit 4f44961eab8474a47de419113e1d46095f9b44e0 ]

Add purge checking to vma_lock_and_validate() to block new mapping
operations on purged BOs while allowing cleanup operations to proceed.

Purged BOs have their backing pages freed by the kernel. New
mapping operations (MAP, PREFETCH, REMAP) must be rejected with
-EINVAL to prevent GPU access to invalid memory. Cleanup
operations (UNMAP) must be allowed so applications can release
resources after detecting purge via the retained field.

REMAP operations require mixed handling - reject new prev/next
VMAs if the BO is purged, but allow the unmap portion to proceed
for cleanup.

The check_purged flag in struct xe_vma_lock_and_validate_flags
distinguishes between these cases: true for new mappings (must reject),
false for cleanup (allow).

Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260326130843.3545241-6-arvind.yadav@intel.com
Stable-dep-of: 7bc597ce74ba ("drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm.c | 79 ++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 8f7b8f2da06b..b49c1b3fa665 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2834,8 +2834,22 @@ static void vm_bind_ioctl_ops_unwind(struct xe_vm *vm,
 	}
 }
 
+/**
+ * struct xe_vma_lock_and_validate_flags - Flags for vma_lock_and_validate()
+ * @res_evict: Allow evicting resources during validation
+ * @validate: Perform BO validation
+ * @request_decompress: Request BO decompression
+ * @check_purged: Reject operation if BO is purged
+ */
+struct xe_vma_lock_and_validate_flags {
+	u32 res_evict : 1;
+	u32 validate : 1;
+	u32 request_decompress : 1;
+	u32 check_purged : 1;
+};
+
 static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
-				 bool res_evict, bool validate)
+				 struct xe_vma_lock_and_validate_flags flags)
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
@@ -2844,10 +2858,19 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 	if (bo) {
 		if (!bo->vm)
 			err = drm_exec_lock_obj(exec, &bo->ttm.base);
-		if (!err && validate)
+
+		/* Reject new mappings to DONTNEED/purged BOs; allow cleanup operations */
+		if (!err && flags.check_purged) {
+			if (xe_bo_madv_is_dontneed(bo))
+				err = -EBUSY;  /* BO marked purgeable */
+			else if (xe_bo_is_purged(bo))
+				err = -EINVAL; /* BO already purged */
+		}
+
+		if (!err && flags.validate)
 			err = xe_bo_validate(bo, vm,
 					     !xe_vm_in_preempt_fence_mode(vm) &&
-					     res_evict, exec);
+					     flags.res_evict, exec);
 	}
 
 	return err;
@@ -2933,9 +2956,13 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 	case DRM_GPUVA_OP_MAP:
 		if (!op->map.invalidate_on_bind)
 			err = vma_lock_and_validate(exec, op->map.vma,
-						    res_evict,
-						    !xe_vm_in_fault_mode(vm) ||
-						    op->map.immediate);
+						    (struct xe_vma_lock_and_validate_flags) {
+							.res_evict = res_evict,
+							.validate = !xe_vm_in_fault_mode(vm) ||
+								    op->map.immediate,
+							.request_decompress = false,
+							.check_purged = true,
+						    });
 		break;
 	case DRM_GPUVA_OP_REMAP:
 		err = check_ufence(gpuva_to_vma(op->base.remap.unmap->va));
@@ -2944,13 +2971,28 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.remap.unmap->va),
-					    res_evict, false);
+					    (struct xe_vma_lock_and_validate_flags) {
+						    .res_evict = res_evict,
+						    .validate = false,
+						    .request_decompress = false,
+						    .check_purged = false,
+					    });
 		if (!err && op->remap.prev)
 			err = vma_lock_and_validate(exec, op->remap.prev,
-						    res_evict, true);
+						    (struct xe_vma_lock_and_validate_flags) {
+							    .res_evict = res_evict,
+							    .validate = true,
+							    .request_decompress = false,
+							    .check_purged = true,
+						    });
 		if (!err && op->remap.next)
 			err = vma_lock_and_validate(exec, op->remap.next,
-						    res_evict, true);
+						    (struct xe_vma_lock_and_validate_flags) {
+							    .res_evict = res_evict,
+							    .validate = true,
+							    .request_decompress = false,
+							    .check_purged = true,
+						    });
 		break;
 	case DRM_GPUVA_OP_UNMAP:
 		err = check_ufence(gpuva_to_vma(op->base.unmap.va));
@@ -2959,7 +3001,12 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.unmap.va),
-					    res_evict, false);
+					    (struct xe_vma_lock_and_validate_flags) {
+						    .res_evict = res_evict,
+						    .validate = false,
+						    .request_decompress = false,
+						    .check_purged = false,
+					    });
 		break;
 	case DRM_GPUVA_OP_PREFETCH:
 	{
@@ -2972,9 +3019,19 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 				  region <= ARRAY_SIZE(region_to_mem_type));
 		}
 
+		/*
+		 * Prefetch attempts to migrate BO's backing store without
+		 * repopulating it first. Purged BOs have no backing store
+		 * to migrate, so reject the operation.
+		 */
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.prefetch.va),
-					    res_evict, false);
+					    (struct xe_vma_lock_and_validate_flags) {
+						    .res_evict = res_evict,
+						    .validate = false,
+						    .request_decompress = false,
+						    .check_purged = true,
+					    });
 		if (!err && !xe_vma_has_no_bo(vma))
 			err = xe_bo_migrate(xe_vma_bo(vma),
 					    region_to_mem_type[region],
-- 
2.53.0

