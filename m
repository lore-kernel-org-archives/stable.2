Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999C1F12FB
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785603559; cv=none; b=XmerCV2JN1X8Xz5n2vcgq4KpVShnni5lCeLX4E4C6K6cJ/qaf/zXDYjS5FM3osYOsMJf/p4KUuX3BR/uNTRJccpS/fdWXH3s4/nxYmFeILu3pkyC1ijfYplpAnblVaSxtf08sF993vOeIBhr+YiO8UWGtlr5r5qFKvyhiJvcsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785603559; c=relaxed/simple;
	bh=icwK0V060d8QU0ri1mUisTHm8E+BT+HPXQ9wNAGsftc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQT7769iBWPfekJuD3pgC/G2xjN62GnzY9k23YOGHqjH67cxZzLDCtQoLh87PQNnoLt4VaasalzAen6Rh0ATsAxEeevTU96XiQoIPrv7YWZ1V9e4RMy0S0Mpb0U1FsawsuqJ5PrekuLUmbYYYjSJP9S2z6e3xhKOBiJqWH+G4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/gvDcSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/gvDcSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804031F00AC4;
	Sat,  1 Aug 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785603558;
	bh=zOw535rvpbJNzPJNJ5waDOcOj3lE3kVJyc135Eo2pfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K/gvDcSfmw7dVdq4J5G0O6gkoO9sKAUCFziDqnbt7zoWVlszwQ5iyR4EokETRuE9P
	 YQgI7qsDIgMUCH50LntpGZPh624vZg2ClLw0KzIaTHTdsxh2Qrn9Xwh+FP7hhekyh7
	 htcDBBHrMZkgJGQueZFy7jsg5/lGxrCKhPz4uX/Tkgg+2Jy5kdC9Hg9Z7YEMr49d6O
	 s+oJBnboTkjIeJViHN/+T3epFvvLHUSDA/CTXyUk51TbKilt4KM/znNRhFJOIDTbhU
	 MhWDJtHYmj0lonQD2ftQulX/IaaIekASZsoPY2ErBbGVD2sjj3dnnlh8w2kcGq4oLX
	 DVqnRiz3yl6Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/exec: Remove the index parameter from drm_exec_for_each_locked_obj[_reverse]
Date: Sat,  1 Aug 2026 12:59:12 -0400
Message-ID: <20260801165915.2408629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072911-lake-unrobed-1810@gregkh>
References: <2026072911-lake-unrobed-1810@gregkh>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  9 +++------
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  3 +--
 drivers/gpu/drm/drm_exec.c                    |  6 ++----
 drivers/gpu/drm/drm_gpuvm.c                   |  3 +--
 drivers/gpu/drm/xe/xe_vm.c                    |  3 +--
 include/drm/drm_exec.h                        | 20 +++++++++++--------
 6 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8669e2fd6eff..7a9abd555875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -860,7 +860,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -965,7 +964,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto out_free_user_pages;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
 		if (unlikely(r))
 			goto out_free_user_pages;
@@ -1205,7 +1204,6 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	struct drm_gpu_scheduler *sched;
 	struct drm_gem_object *obj;
 	struct dma_fence *fence;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -1216,7 +1214,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 		return r;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		struct dma_resv *resv = bo->tbo.base.resv;
@@ -1285,7 +1283,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *gobj;
-	unsigned long index;
 	unsigned int i;
 	uint64_t seq;
 	int r;
@@ -1336,7 +1333,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
-	drm_exec_for_each_locked_object(&p->exec, index, gobj) {
+	drm_exec_for_each_locked_object(&p->exec, gobj) {
 
 		ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..83fad3a37184 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -49,7 +49,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 {
 	struct amdgpu_eviction_fence *old_ef, *new_ef;
 	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	if (evf_mgr->ev_fence &&
@@ -77,7 +76,7 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	/* Attach the new fence */
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		if (!bo)
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 8d0601400182..746210f3f6c2 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -24,7 +24,6 @@
  *
  *	struct drm_gem_object *obj;
  *	struct drm_exec exec;
- *	unsigned long index;
  *	int ret;
  *
  *	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
@@ -40,7 +39,7 @@
  *			goto error;
  *	}
  *
- *	drm_exec_for_each_locked_object(&exec, index, obj) {
+ *	drm_exec_for_each_locked_object(&exec, obj) {
  *		dma_resv_add_fence(obj->resv, fence, DMA_RESV_USAGE_READ);
  *		...
  *	}
@@ -56,9 +55,8 @@
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
index 5c8bf010cd96..61c3df0711a3 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1521,9 +1521,8 @@ drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
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
index 8f7b8f2da06b..8c740912122d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -355,7 +355,6 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	do {
@@ -368,7 +367,7 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
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

