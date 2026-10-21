Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594336;
	b=sYIPgbiRuYLvHvM3Qf4Sv50/FNBmlhkqwKSgMv0h640v/yQ/g+GNBFBuJANMR+T56ft9
	 7Zyarj6EmxwT9CTTjOdkAYS9g5lXVTieYS170iJZyqX1bWSKqRUlkJYtuJTsnzmi9TJTQ
	 1CgK5B3UsyJiOQ2ToYLMPYPqSTwG92C7RCPZ6hNr43MjkwNlkbDgEiF0xXItpsiPU3ok/
	 MilfDZNoY4L6Hb9Firc2gg3TfaFN342WoVf25yIE9zYBVJlMUeRtdRTbSDr9d0tljS0gJ
	 t0inj0qxzugyBKRmDtrtBdkBAdKhFJ3yehiKZsilL87S0MrnP9abt9YVnOM+m6rsnAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594336;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9pGzucEDNjm1SslTodrmM5QJDZaF4pflB1GX0pPihb4=;
	b=b/YCen4RYXEJGvANMg+Yh1eYGob70czegcpB0FLiYn6kwD7f1BlVm6SMODQSrnnvWcei
	 mXmGWAnGkjQVaJv9ZA7hGkx4t3AcGpCe2LJW44S/rV8XZhhnU9WitKoqUtH9HrkWBy8u4
	 0AiEDaYhM9XYmTocPk8Ie3RDoGgvDHh1T7Pc4dvL4lrzzN+MflGc63VNmZQkpuYrkKQxE
	 66lUgSh39Wnst/w57XzJwVH/4PnZKcZkW3Gj/jhPZIjn6Qw8Ax3mEWGb7A5GlBD6yBMy1
	 oO113L8i0nD/5T6GVpfwB+hOGZXFYNhfUok8z8TdnCYHJFzwqM+ZiIEcZ4ZufbmaDQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z1kcENJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86150606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z1kcENJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FD81F000C1;
	Wed, 21 Oct 2026 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594336;
	bh=9pGzucEDNjm1SslTodrmM5QJDZaF4pflB1GX0pPihb4=;
	h=Subject:To:Cc:From:Date;
	b=z1kcENJL+fAGactHvydn3IQw7ARIvLDdLaSzCDGSVW61nkfvgZaw4hyd9umPQ7Maz
	 T1d2Q1cIGWCZhKagPI8L06wDl+Ay4rXxJ34NkQl4m4naosd19VLPGWg1f4EOiW8Z9f
	 sUByb2p3mI0YEI2oy7pgx4m16eldnC+MLHrYR4wQ=
Subject: FAILED: patch "[PATCH] drm/xe: Bump LRU for external objects on exec and rebind" failed to apply to 6.12-stable tree
To: thomas.hellstrom@linux.intel.com,matthew.auld@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:47:32 +0200
Message-ID: <2026102132-gab-disarm-872d@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d2ce8fcd778ee6d92748c92d23a56d4416c29d86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102132-gab-disarm-872d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2ce8fcd778ee6d92748c92d23a56d4416c29d86 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Mon, 12 Oct 2026 15:26:07 +0200
Subject: [PATCH] drm/xe: Bump LRU for external objects on exec and rebind
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VM's private BOs get their LRU position refreshed in bulk via
ttm_lru_bulk_move_tail() on vm->lru_bulk_move, both after a successful
non-LR exec and after the LR preempt-fence rebind worker runs. External
objects (BOs potentially shared across VMs) are never added to that
per-VM bulk move list, so their LRU position is never refreshed by
either path. This makes external objects in active use look more
evictable than they are.

Add xe_vm_bump_lru(), which, under a single lru_lock critical section,
performs the bulk move of the VM's private BOs and bumps each external
object locked by the drm_exec transaction. Use it from both the non-LR
exec path and the LR rebind worker, replacing the open-coded bulk move.

Fixes: d490ecf57790 ("drm/xe: Rework xe_exec and the VM rebind worker to use the drm_exec helper")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20261012132607.21387-1-thomas.hellstrom@linux.intel.com
(cherry picked from commit 324ba30cca180c2e1d02090743dd78ccb15b9e4a)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index d5293bc33a67..7dc9a0a1f569 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -346,11 +346,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	xe_sched_job_push(job);
 	xe_vm_reactivate_rebind(vm);
 
-	if (!err && !xe_vm_in_lr_mode(vm)) {
-		spin_lock(&xe->ttm.lru_lock);
-		ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-		spin_unlock(&xe->ttm.lru_lock);
-	}
+	if (!err && !xe_vm_in_lr_mode(vm))
+		xe_vm_bump_lru(vm, exec);
 
 	if (mode == EXEC_MODE_LR)
 		xe_hw_engine_group_resume_faulting_lr_jobs(group);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index ef20e205a734..99e42bd29e79 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -410,6 +410,33 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 	return 0;
 }
 
+/**
+ * xe_vm_bump_lru() - Bump the LRU position of BOs used by a submission
+ * @vm: The vm for which we are bumping LRUs.
+ * @exec: The struct drm_exec with the locked GEM objects.
+ *
+ * Move the VM's private BOs, and all external objects locked by @exec,
+ * to the LRU tail. Private BOs are moved in bulk using @vm's
+ * &xe_vm.lru_bulk_move. External objects, which may be shared with other
+ * VMs, are not part of that bulk move and are bumped individually.
+ */
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec)
+{
+	spinlock_t *lru_lock = &vm->xe->ttm.lru_lock;
+	struct drm_gem_object *obj;
+
+	spin_lock(lru_lock);
+	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
+	drm_exec_for_each_locked_object(exec, obj) {
+		if (!drm_gpuvm_is_extobj(&vm->gpuvm, obj))
+			continue;
+
+		ttm_bo_move_to_lru_tail(&gem_to_xe_bo(obj)->ttm);
+		cond_resched_lock(lru_lock);
+	}
+	spin_unlock(lru_lock);
+}
+
 static int xe_preempt_work_begin(struct drm_exec *exec, struct xe_vm *vm,
 				 bool *done)
 {
@@ -560,9 +587,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 #undef retry_required
 
-	spin_lock(&vm->xe->ttm.lru_lock);
-	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-	spin_unlock(&vm->xe->ttm.lru_lock);
+	xe_vm_bump_lru(vm, &exec);
 
 	/* Point of no return. */
 	arm_preempt_fences(vm, &preempt_fences);
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c5b900f38ded..4b606445799c 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -284,6 +284,8 @@ int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences);
 
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec);
+
 struct dma_fence *xe_vm_bind_kernel_bo(struct xe_vm *vm, struct xe_bo *bo,
 				       struct xe_exec_queue *q, u64 addr,
 				       enum xe_cache_level cache_lvl);

