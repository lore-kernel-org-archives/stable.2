Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047859;
	b=BzQQ1TAlOik84aDKhP7k2lKTyBLy8aD3jtmvs3H+UZjG9IKcDyXIeRLYp1sgLiGPcadY
	 n8eQywq53OhEd4rfG4QJpwLJ6SDkr4Xabh869Rm/Cr/LtPcdRGPWGJuKAvIGnSYYNjhB1
	 FeuJPAgM7dm7VKHm6u1SFyRq3jHz32i+ntLIFqlOlZOrgvF8m/7JQeGxeKgrHf1xMf1US
	 R6yyAv4BWp0qPVgy/k7Y7SSKmOnm9UytniqPN35zxMSVZyfVPChFb7eMYtDNZDbPLOsyT
	 qXSsO01Wx8epLuOhfBYWznDH7esjGMg9tRF95Svl0iD79S6VD/gXKBRlPHUZfWHSagA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2aZ6wzKby5asWI8DZIjdKAyqW6BXo2s6Y4uJ/5Ax/Ns=;
	b=1me3FaMNSJe8PjXtZCenlZWvZ562QIOeEyYy0H4zsmfPe0E9j5t/e9Qa0XZsG9exXpbW
	 Rwus7HZA8q2F4bNmYzxHNJkoDIdnr6T3ok5hIVnfIn2GStIxHgTKR5/AyKG9hg5WPnwaP
	 w2TqXddHsLYuqfVa9BACDOkjUG+AkD5Keq8UD8smNP+HQO9xZvJReAiTd3FOGM63egBjK
	 5RmWLPTw5DLdQwBCtNH0i+B7S6ZYHTl7gHe1eZ3f/iKbc5h9lqrbB0HEzlPlQ+AIZy5gd
	 Di28dVXYeaXmhr+47cv2p2UnZH1oLxbAJi6pQjrB5uUJmyVf1V9rYvis88Sy9p1WmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrJ6WNlN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28597606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrJ6WNlN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B01E1F0089F;
	Sat,  7 Nov 2026 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047859;
	bh=2aZ6wzKby5asWI8DZIjdKAyqW6BXo2s6Y4uJ/5Ax/Ns=;
	h=From:To:Cc:Subject:Date;
	b=OrJ6WNlNeHqkx1grs5adutM4Pbuy7iQZngPiEzrDNwjwktznl4vduVlLakb+KaGye
	 zkqyYwK9x6VRGLeiORq0T+eMNU43rdcQk6zKKDH1zxqGw2La6GUztq7xH+6Z5azty1
	 7chNqFSVYIGkL/+rd3ygSCoW6E4whYur0J/MxT1rZzNNgzPCY6QbPo2y9GfvdFvtBj
	 dknWR9OMC57hje6rZ4p1FJOSGR7Gdyq8wzIdoRTbDtSf/AYFfrHCSm4g4+u5EhbM0l
	 mdp/m0JwYUg8e7eRUuOx3hJXcvicGKttLNLaDxzaYu7ceOno36m35M8Xhl1ZRN263y
	 MNSLclAokw3DA==
From: Sasha Levin <sashal@kernel.org>
To: zhen.han@amd.com,
	philip.yang@amd.com,
	mukul.joshi@amd.com,
	lijo.lazar@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: correct vram_available calculation" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:37 -0500
Message-ID: <20261107053737-failed-6.6-9131cc85d0de@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9131cc85d0dedd8ba4cae60dbe5985d081551f30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053737-failed-6.6-9131cc85d0de@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9131cc85d0dedd8ba4cae60dbe5985d081551f30 Mon Sep 17 00:00:00 2001
From: Zhen Han <Zhen.Han@amd.com>
Date: Sun, 20 Sep 2026 02:31:31 +0000
Subject: [PATCH] drm/amdkfd: correct vram_available calculation

reserve_mem_limit() computes available VRAM as
	vram_size - reserved - vram_pin_size - kfd.vram_used
However, kfd.vram_used already includes BOs that are later pinned.
Pinning does not consume extra VRAM. Subtracting
vram_pin_size counts those bytes twice and causes fake-OOM
while VRAM is still free.

Reuse get_available_memory() in reserve_mem_limit(). Move
ALIGN_DOWN to the ioctl so the userspace ABI is unchanged. The
VRAM counter is a parameter: the ioctl passes vram_used_aligned[],
the gate passes vram_used[] so a 4K BO is not charged 2MB.

kfd.vram_pinned is only updated in gpuvm_pin_bo(). dma-buf pin
calls amdgpu_bo_pin() only, so the counter stays zero. Update it
from amdgpu_bo_pin() through a KFD helper, on first pin and last
unpin, matching vram_pin_size.

Track per-XCP pins in vram_pin_size_xcp[] and kfd.vram_pinned[].
Pins that are not owned by a single partition go to
vram_pin_size_common, which every partition subtracts.

A KFD VRAM BO always carries a partition, so the KFD credit is only
correct for xcp >= 0. Call the helper for both branches and let it
warn once and skip if that ever stops holding: without the credit the
BO would be subtracted through vram_pin_size_common and never added
back, which is the double counting this patch removes, and
kfd.vram_pinned[] would be indexed out of bounds.

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Zhen Han <Zhen.Han@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 894cbb31c50e3cf49657130396bbf6c0475304e4)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 20 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 94 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 33 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 12 ++-
 5 files changed, 127 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce671731b7007..c7577b608f3e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -844,8 +844,17 @@ struct amdgpu_device {
 	struct mutex	mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
 
-	/* tracking pinned memory */
+	/* tracking pinned memory
+	 *
+	 *	vram_pin_size = sum(vram_pin_size_xcp[]) + vram_pin_size_common
+	 *
+	 * vram_pin_size         total pin size in device
+	 * vram_pin_size_xcp[i]  pins owned by partition i (bo->xcp_id = i, i >= 0)
+	 * vram_pin_size_common  pins not owned by any partition, bo->xcp_id = -1
+	 */
 	atomic64_t vram_pin_size;
+	atomic64_t vram_pin_size_xcp[MAX_XCP];
+	atomic64_t vram_pin_size_common;
 	atomic64_t visible_pin_size;
 	atomic64_t gart_pin_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index a53d7e4a1eb5c..77c0504cc158d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -42,6 +42,12 @@
 
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
+/*
+ * Align VRAM availability to 2MB to avoid fragmentation caused by 4K
+ * allocations in the tail 2MB BO chunk.
+ */
+#define VRAM_AVAILABLITY_ALIGN (1 << 21)
+
 enum TLB_FLUSH_TYPE {
 	TLB_FLUSH_LEGACY = 0,
 	TLB_FLUSH_LIGHTWEIGHT,
@@ -106,7 +112,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
-	atomic64_t vram_pinned;
+	atomic64_t vram_pinned[MAX_XCP];
 	bool init_complete;
 	struct work_struct reset_work;
 
@@ -390,6 +396,8 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
  * Allows KFD to release its resources associated with the GEM object.
  */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
@@ -407,6 +415,16 @@ static inline
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 }
+
+static inline
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id)
+{
+}
+
+static inline
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
+{
+}
 #endif
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 129acb88dc11e..ff77e8ae9fe6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -46,12 +46,6 @@
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 #define AMDGPU_RESERVE_MEM_LIMIT			(3UL << 29)
 
-/*
- * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
- * BO chunk
- */
-#define VRAM_AVAILABLITY_ALIGN (1 << 21)
-
 /* Impose limit on how much memory KFD can use */
 static struct {
 	uint64_t max_system_mem_limit;
@@ -73,6 +67,8 @@ static const char * const domain_bit_to_string[] = {
 #define domain_string(domain) domain_bit_to_string[ffs(domain)-1]
 
 static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work);
+static size_t __get_available_memory(struct amdgpu_device *adev,
+				     uint8_t xcp_id, int64_t vram_used);
 
 static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
 		struct kgd_mem *mem)
@@ -169,13 +165,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id)
 {
-	uint64_t reserved_for_pt =
-		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint64_t reserved_for_ras = (con ? con->reserved_pages_in_bytes : 0);
 	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
-	uint64_t vram_size = 0;
 
 	system_mem_needed = 0;
 	ttm_mem_needed = 0;
@@ -196,7 +187,6 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
 			return -EINVAL;
 
-		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
 		if (adev->apu_prefer_gtt) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
@@ -232,14 +222,11 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	 * VRAM check since ttm_mem_limit check already cover this allocation
 	 */
 
-	if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
-		uint64_t vram_available =
-			vram_size - reserved_for_pt - reserved_for_ras -
-			atomic64_read(&adev->vram_pin_size);
-		if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
-			ret = -ENOMEM;
-			goto release;
-		}
+	if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu) &&
+	    vram_needed > __get_available_memory(adev, xcp_id,
+						 adev->kfd.vram_used[xcp_id])) {
+		ret = -ENOMEM;
+		goto release;
 	}
 
 	/* Update memory accounting by decreasing available system
@@ -318,6 +305,30 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	kfree(bo->kfd_bo);
 }
 
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id)
+{
+	if (!bo->kfd_bo)
+		return;
+
+	if (WARN_ONCE(xcp_id < 0, "KFD BO pinned in VRAM with no partition"))
+		return;
+
+	atomic64_add(amdgpu_bo_size(bo),
+		     &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id]);
+}
+
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
+{
+	if (!bo->kfd_bo)
+		return;
+
+	if (WARN_ONCE(xcp_id < 0, "KFD BO unpinned in VRAM with no partition"))
+		return;
+
+	atomic64_sub(amdgpu_bo_size(bo),
+		     &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id]);
+}
+
 /**
  * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect information
  * about USERPTR or DOOREBELL or MMIO BO.
@@ -1537,10 +1548,6 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
 
-	if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
-		atomic64_add(amdgpu_bo_size(bo),
-			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
 out:
 	amdgpu_bo_unreserve(bo);
 	return ret;
@@ -1564,10 +1571,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 
 	amdgpu_bo_unpin(bo);
 
-	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
-		atomic64_sub(amdgpu_bo_size(bo),
-			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1671,8 +1674,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
 	return ret;
 }
 
-size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
-					  uint8_t xcp_id)
+/* Caller must hold kfd_mem_limit.mem_limit_lock. */
+static size_t __get_available_memory(struct amdgpu_device *adev,
+				     uint8_t xcp_id, int64_t vram_used)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
@@ -1681,15 +1685,17 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 	ssize_t available;
 	uint64_t vram_available, system_mem_available, ttm_mem_available;
 
-	spin_lock(&kfd_mem_limit.mem_limit_lock);
+	lockdep_assert_held(&kfd_mem_limit.mem_limit_lock);
+
 	if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
 		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-			- adev->kfd.vram_used_aligned[xcp_id];
+			- vram_used;
 	else
 		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-			- adev->kfd.vram_used_aligned[xcp_id]
-			- atomic64_read(&adev->vram_pin_size)
-			+ atomic64_read(&adev->kfd.vram_pinned)
+			- vram_used
+			- atomic64_read(&adev->vram_pin_size_xcp[xcp_id])
+			- atomic64_read(&adev->vram_pin_size_common)
+			+ atomic64_read(&adev->kfd.vram_pinned[xcp_id])
 			- reserved_for_pt
 			- reserved_for_ras;
 
@@ -1704,19 +1710,29 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 
 		available = min3(system_mem_available, ttm_mem_available,
 				 vram_available);
-		available = ALIGN_DOWN(available, PAGE_SIZE);
 	} else {
-		available = ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_ALIGN);
+		available = vram_available;
 	}
 
-	spin_unlock(&kfd_mem_limit.mem_limit_lock);
-
 	if (available < 0)
 		available = 0;
 
 	return available;
 }
 
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
+					  uint8_t xcp_id)
+{
+	size_t available;
+
+	spin_lock(&kfd_mem_limit.mem_limit_lock);
+	available = __get_available_memory(adev, xcp_id,
+					   adev->kfd.vram_used_aligned[xcp_id]);
+	spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+	return available;
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2a6a5bc01eb40..6aa895f63aeaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -923,6 +923,19 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
 	*bo = NULL;
 }
 
+/* Map a BO onto vram_pin_size_xcp[]. bo->xcp_id < 0 means "any partition":
+ * such pins are not owned by a single partition and go to
+ * vram_pin_size_common, which every partition subtracts.
+ */
+static int amdgpu_bo_get_xcp(struct amdgpu_bo *bo)
+{
+	s8 xcp = bo->xcp_id;
+
+	if (xcp >= 0 && xcp < MAX_XCP)
+		return xcp;
+	return -1;
+}
+
 /**
  * amdgpu_bo_pin - pin an &amdgpu_bo buffer object
  * @bo: &amdgpu_bo buffer object to be pinned
@@ -1003,7 +1016,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 	ttm_bo_pin(&bo->tbo);
 
 	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
+		int xcp = amdgpu_bo_get_xcp(bo);
+
 		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
+		if (xcp >= 0) {
+			atomic64_add(amdgpu_bo_size(bo),
+				     &adev->vram_pin_size_xcp[xcp]);
+		} else {
+			atomic64_add(amdgpu_bo_size(bo),
+				     &adev->vram_pin_size_common);
+		}
+		amdgpu_amdkfd_account_vram_pin(bo, xcp);
 		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
@@ -1036,7 +1059,17 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 		dma_buf_unpin(bo->tbo.base.import_attach);
 
 	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
+		int xcp = amdgpu_bo_get_xcp(bo);
+
 		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
+		if (xcp >= 0) {
+			atomic64_sub(amdgpu_bo_size(bo),
+				     &adev->vram_pin_size_xcp[xcp]);
+		} else {
+			atomic64_sub(amdgpu_bo_size(bo),
+				     &adev->vram_pin_size_common);
+		}
+		amdgpu_amdkfd_account_vram_unpin(bo, xcp);
 		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
 	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3831451240e97..cad60ccdb2166 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1110,11 +1110,19 @@ static int kfd_ioctl_get_available_memory(struct file *filep,
 {
 	struct kfd_ioctl_get_available_memory_args *args = data;
 	struct kfd_process_device *pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
+	struct amdgpu_device *adev;
+	size_t available;
 
 	if (!pdd)
 		return -EINVAL;
-	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
-							pdd->dev->node_id);
+
+	adev = pdd->dev->adev;
+	available = amdgpu_amdkfd_get_available_memory(adev, pdd->dev->node_id);
+	if (adev->apu_prefer_gtt)
+		args->available = ALIGN_DOWN(available, PAGE_SIZE);
+	else
+		args->available = ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
+
 	kfd_unlock_pdd(pdd);
 	return 0;
 }
-- 
2.53.0




