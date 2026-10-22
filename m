Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668961;
	b=RuH90URAYlAivWVwkTxQcbqvxnRNFWXtAwnywm9eFHQ7htLYI60DHuSZaAgCxxFHg4D0
	 sZtJVF8qhb9vwyIdFA544FLWD0bxxTY9lLXR0dwzsptrTclOJPrgTv2av7iX43Msdq94w
	 ca3a+2uPqgbzrsDYYLkebHCQkibIZiRp5PZ1rzxGNPOG5R4p935VgWQnQz23WxUuSEj3g
	 a8xgqiMWkOd8hsD19jajPScT15fBWlRju6yLjou7ZUEC+QYpdf7/gIiOBFTup8Om7Enh5
	 /XqqZLrGBc0IGklFctllTIeWWuKsaBnXFFy6VluCeASAFqoMV6fZ3WS4KPh0JCc7U8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IzRk8X3oVfnY85aAfGEvAg2Vsmp4mdwTSTrMqws2alU=;
	b=sdqbEj3cM3oE57OgVHvGD1Zd+jOBmw5NLQ1+6LlLARuiAlDLiDLmGru3Ufgd874tGxGv
	 xtRwjFrdQ2hQQAsV1ULf3gnhATO+cf/wJDyW3ba2dzO3a720IMQQpspS0aIc0HrFTOyab
	 gAflDr2Xc4dC9EYjDlp74IuPhiNxW/1MC346iV+nsu3fjYIjGoM+alhid0aoPNNdRA1pt
	 s5ZugWqZtNeP8+SSGNoz1hXgzaG7ht7653KbOUB+XjGZnC9GgJSY3mKy2M6OQMn0/vwkT
	 1KnBm+fDtFtUB/yq0cSOXG9uUf+zavEJtgtkI+nYY5asQEYSg4q47aUr4Bhtr+t3SAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNf77xeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14A606A31F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNf77xeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053E11F000C1;
	Thu, 22 Oct 2026 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668960;
	bh=IzRk8X3oVfnY85aAfGEvAg2Vsmp4mdwTSTrMqws2alU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNf77xeECPaEcZVEDMGe99HiYqjS6/XDMmmpjXeY6H+r1Ma81iBbiPa8IPZvluiUJ
	 Ei/mPaHlQautLUMg1LnfVJcsoI85ox0YKY0p2FqjBjLyy4313GbdhlLTkD/gdNJW2m
	 eOQemZTZD6YIxO/ka+WJn4fW7nPg68pn7/fzESlg0c52cFCCmRUbgkJsIebvlb9g5L
	 Fq1bA4XbXFqNulZVSsi81zL00ShKJISKrxxHKPmv3ijkymLi4fu6i+iGPsrSrfKtup
	 tKnO7wZMRnZoV440qJGtqNm/1G1GwDvdb3d02yQ/X3D4k2hS/AVFd7MQPxzd2mFpca
	 qUVsQp/5ebovw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/xe: Bump LRU for external objects on exec and rebind
Date: Thu, 22 Oct 2026 07:35:58 -0400
Message-ID: <20261022113414.921168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102132-gab-disarm-872d@gregkh>
References: <2026102132-gab-disarm-872d@gregkh>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit d2ce8fcd778ee6d92748c92d23a56d4416c29d86 ]

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
[ sashal: Adjusted header context to accommodate missing xe_vm_bind_kernel_bo() and xe_vm_resume_rebind_worker() declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_exec.c |  7 ++-----
 drivers/gpu/drm/xe/xe_vm.c   | 31 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.h   |  2 ++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 04a88c16d8358..03af3704ee68d 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -330,11 +330,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
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
index da148df421057..d53cb4e625172 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -439,6 +439,33 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
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
@@ -552,9 +579,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 #undef retry_required
 
-	spin_lock(&vm->xe->ttm.lru_lock);
-	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-	spin_unlock(&vm->xe->ttm.lru_lock);
+	xe_vm_bump_lru(vm, &exec);
 
 	/* Point of no return. */
 	arm_preempt_fences(vm, &preempt_fences);
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index d2406532fcc50..b0a864618eccc 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -248,6 +248,8 @@ int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences);
 
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec);
+
 /**
  * xe_vm_resv() - Return's the vm's reservation object
  * @vm: The vm
-- 
2.53.0

