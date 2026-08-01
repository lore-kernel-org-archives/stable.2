Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B9372B5A
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627804; cv=none; b=lAgRE42kSuKAVDWE9f6wkv7qyTWeP4bemRWVfAeRm5HgtFTixd1+TbtEb06mry+HwmI4v+sfp2HusBsVVvAhC6fIllEWqb9UpLKfN7TgGgs0UOhkrhH6t2qHpJ3F8ufAPS/MCSGOyeITEwBPviFmXj3V7bahBX00IHYz8FtlO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627804; c=relaxed/simple;
	bh=eEV/tM6ctTqp070mKOh/xM3UzuyC05A1rmcxzmBhNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWq7tOCCWSpPqWUIfGLZQK08U5+SG3B0E38T4Yxu+NfZ9yR7lwHDq2/drI874OHpbJNOXeJoLV5LosxBJtc2DSq+u5WzWuWg4yKG+HPu6UYSx1zpwO6JPAPizkwoYu2BuKT2Nlm1k8586eC4g0+qLnCpXspHPECchXOyU4Q/VR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/FvCYJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/FvCYJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922901F00AC4;
	Sat,  1 Aug 2026 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627803;
	bh=u0+xeMK9S5dNsBemVaPG6rDe7pbsdGa4WL1XiSGUg0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/FvCYJhubo70HbJVmkomXPulRrt9eK5x/39NHbot3r7pr8eKASDKNZAk8cHbLl63
	 i1NiOjcy+sjbD1N9Trzfs/pqEzh1huWn28L9hzXbOdLvV7tg7WvV1RVcWgJC4fE42R
	 mwjq7Hwx4p09h9zyHELVaqqbG8BL6UTG/QZEr8ReNACF1CkskajcmnVKufW3nFON7U
	 1xvDKQTy8To6wO7ZoxS08SbuVvDJxHnbsAwao+o5+aM93Uoxpf6y4m+NJIemjZdnK9
	 esEphSAOk4K8tfgwiTylRHt/+mvsYsjCn8Db7I8BbvTruu1LZx+3LKsxUwX7cI8ize
	 RKIMLj6du+4Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/exec: Remove the index parameter from drm_exec_for_each_locked_obj[_reverse]
Date: Sat,  1 Aug 2026 19:43:19 -0400
Message-ID: <20260801234320.1848118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072911-surplus-properly-117b@gregkh>
References: <2026072911-surplus-properly-117b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit ce44b78512e9102aea54ff6b6e521d6c8de9f31c ]

Nobody makes any use of it. Possible internal future users can
instead use the _index variable. External users shouldn't use
it since the array it's pointing into is internal drm_exec state.

v2:
- Use a unique id for the loop variable (Christian)

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patch.msgid.link/20260520101616.41284-2-thomas.hellstrom@linux.intel.com
Stable-dep-of: af80e2bfde93 ("drm/xe: Wait on external BO kernel fences in exec IOCTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  9 +++------
 drivers/gpu/drm/drm_exec.c             |  6 ++----
 drivers/gpu/drm/drm_gpuvm.c            |  3 +--
 drivers/gpu/drm/xe/xe_vm.c             |  3 +--
 include/drm/drm_exec.h                 | 20 ++++++++++++--------
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e018a807e4e3..eb94e7891c2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -843,7 +843,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -964,7 +963,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto out_free_user_pages;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
 		if (unlikely(r))
 			goto out_free_user_pages;
@@ -1202,7 +1201,6 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	struct drm_gpu_scheduler *sched;
 	struct drm_gem_object *obj;
 	struct dma_fence *fence;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -1213,7 +1211,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 		return r;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		struct dma_resv *resv = bo->tbo.base.resv;
@@ -1281,7 +1279,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *gobj;
-	unsigned long index;
 	unsigned int i;
 	uint64_t seq;
 	int r;
@@ -1332,7 +1329,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
-	drm_exec_for_each_locked_object(&p->exec, index, gobj) {
+	drm_exec_for_each_locked_object(&p->exec, gobj) {
 
 		ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
 
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 18e366cc4993..6c1351cd7f15 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -22,7 +22,6 @@
  *
  *	struct drm_gem_object *obj;
  *	struct drm_exec exec;
- *	unsigned long index;
  *	int ret;
  *
  *	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
@@ -38,7 +37,7 @@
  *			goto error;
  *	}
  *
- *	drm_exec_for_each_locked_object(&exec, index, obj) {
+ *	drm_exec_for_each_locked_object(&exec, obj) {
  *		dma_resv_add_fence(obj->resv, fence, DMA_RESV_USAGE_READ);
  *		...
  *	}
@@ -54,9 +53,8 @@
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 
-	drm_exec_for_each_locked_object_reverse(exec, index, obj) {
+	drm_exec_for_each_locked_object_reverse(exec, obj) {
 		dma_resv_unlock(obj->resv);
 		drm_gem_object_put(obj);
 	}
diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 2515cff33485..338a21a58ec5 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1451,9 +1451,8 @@ drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
 			 enum dma_resv_usage extobj_usage)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		dma_resv_assert_held(obj->resv);
 		dma_resv_add_fence(obj->resv, fence,
 				   drm_gpuvm_is_extobj(gpuvm, obj) ?
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 7ce6a9d4e5c1..deb4d0314db3 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -418,7 +418,6 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	do {
@@ -431,7 +430,7 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			return ret;
 	} while (!list_empty(&vm->gpuvm.evict.list));
 
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		ret = dma_resv_reserve_fences(obj->resv, num_fences);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index aa786b828a0a..dee6ebdbe416 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -65,31 +65,35 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 	return index < exec->num_objects ? exec->objects[index] : NULL;
 }
 
+/* Helper for drm_exec_for_each_locked_object(). Internal use only. */
+#define __drm_exec_for_each_locked_object(exec, obj, __index)		\
+	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
 /**
  * drm_exec_for_each_locked_object - iterate over all the locked objects
  * @exec: drm_exec object
- * @index: unsigned long index for the iteration
  * @obj: the current GEM object
  *
  * Iterate over all the locked GEM objects inside the drm_exec object.
  */
-#define drm_exec_for_each_locked_object(exec, index, obj)		\
-	for ((index) = 0; ((obj) = drm_exec_obj(exec, index)); ++(index))
+#define drm_exec_for_each_locked_object(exec, obj)			\
+	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
 
+/* Helper for drm_exec_for_each_locked_object_reverse(). Internal use only. */
+#define __drm_exec_for_each_locked_object_reverse(exec, obj, __index)	\
+	for (unsigned long __index = (exec)->num_objects - 1;		\
+	     ((obj) = drm_exec_obj(exec, __index)); --__index)
 /**
  * drm_exec_for_each_locked_object_reverse - iterate over all the locked
  * objects in reverse locking order
  * @exec: drm_exec object
- * @index: unsigned long index for the iteration
  * @obj: the current GEM object
  *
  * Iterate over all the locked GEM objects inside the drm_exec object in
- * reverse locking order. Note that @index may go below zero and wrap,
+ * reverse locking order. Note that the internal index may wrap around,
  * but that will be caught by drm_exec_obj(), returning a NULL object.
  */
-#define drm_exec_for_each_locked_object_reverse(exec, index, obj)	\
-	for ((index) = (exec)->num_objects - 1;				\
-	     ((obj) = drm_exec_obj(exec, index)); --(index))
+#define drm_exec_for_each_locked_object_reverse(exec, obj)		\
+	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
-- 
2.53.0

