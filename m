Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339404;
	b=KNcwggjT/nWZ5PXd5BYruzOKnJLv/u9oUFmTgH4cYrA9IXdI1WgEcTf5x9KCctd2mdph
	 vqsRMujFBQu7bH3CD5XY6SwPUtL29U9aopAuPHB9bc3PwonGym4i0OZ2GHTQhx1/Za8ka
	 8cC4f5LkzRYlu0W4u+keJmjz2eA7UAupRw/EBEnpEAJmvzNWVhAs+CvnjfTHhYFQFUlVL
	 gERUg4AU6UHP74iDE5ZS039fsNTBz8jmZAxhO32NzmBX59WD01/j1fjtzOM63O20Cjue9
	 UExysXDe1Zce8/n4ot0NxuCQ6kmAUgNKYypmkv9FRC9qvnWjF7LzyIZbcezqd4B5J4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339404;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B6V02g+MA05LwZf6qpx2sF5cRI0F+MCxf09747s+nKU=;
	b=GauiwXE30DEaWmlln2XioKfs6XgpBZfVUwq5ACdz6zYleOPk9xoBNUo8JMr0X6+GO+4M
	 NoA/vArTk9tDw1Ut4Tu6xXC7KSVa08zxmHGtLqSdhfBaXdTUabkzTQrTO3gxD6dswnwpY
	 0OHefLXE3DZqLpFZBqcAMlAy6goC9Skfemtyl/BvhgOlpPvWZAwNObEHkOz2TzzOjsJ2N
	 GYGyIjrA8IH6rXBAW+iu1zDdRLcgFMRrWqYz7RQBAxHb3AWInCaZ4PRcO01IC04wJj3Z5
	 mYR49mZc9/SyTp1+x4lXElLX9FwSmRd9+4nItB0EU7LNg9ZTcQSmuGZfPstm0MNf5yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsBM0zbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsBM0zbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05C31F0089F;
	Tue, 10 Nov 2026 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339403;
	bh=B6V02g+MA05LwZf6qpx2sF5cRI0F+MCxf09747s+nKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsBM0zbnAh6jD43bG38IqmY8RfJtGUepHMNem2IDiNLEEGE2lPcLpPjGzZZzLOS/Y
	 QbirWvs3m0QSQCrWthZJwa8OBQ+HBr+E/d1AdQge+8GUBzpJT/Xv/Sm8ZsdC9UvD/A
	 2uce/YdmRxeF+BNxyC/SxY5L/MiVCWgiI9x5ZyQbUEETBxfsdsFSZWQ/PbjmuHLEs5
	 ZdeEhbxtwSBliWEl75acFhLjHt5U9zioyy7vfzs5vecsG0xtIXQre7bUYNWFXsGJ/C
	 KC7qIHfGYe8EE6MWOPOPDL/E1fbmjDgoBkYAD96+lAnSUQ+ewh4ibZLyATW/T8OWPF
	 Ou+yvocLQOkBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdkfd: fix doorbell allocation race creating duplicate allocations
Date: Tue, 10 Nov 2026 14:36:41 -0500
Message-ID: <20261110193604.3555386-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055241-failed-6.1-bebad4505094@kernel.org>
References: <20261107055241-failed-6.1-bebad4505094@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit bebad45050945a3d668d6701fb77ae2571c5d44b ]

The check-and-allocate sequence on pdd->qpd.proc_doorbells is
lockless at every call site of kfd_alloc_process_doorbells():
kfd_get_process_doorbells() (mmap of /dev/kfd),
kfd_ioctl_create_queue() and the CRIU restore path each test the
pointer under different locking (or none), so two racing threads can
both observe NULL and each allocate a doorbell BO and bitmap,
orphaning one allocation and handing the two mappings different
backing pages.

Move the serialization into kfd_alloc_process_doorbells() itself,
using a new per-process-device mutex so all three call sites are
covered regardless of their own locking.  The device-global
kfd->doorbell_mutex is not suitable here: it is acquired under
dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
the sleeping allocations above would create a lock-ordering
inversion with dqm->lock via TTM eviction, and it would also
serialize doorbell setup of unrelated processes behind a
device-wide lock for per-process state.

This issue was discovered by Tencent CodeBuddy Security.

v3 (Felix Kuehling):
- Removed unlocked check in kfd_get_process_doorbell flagged as
  problematic by Sashiko Bot. Fall back to the locked check inside
  kfd_alloc_process_doorbells
- Added missing mutex_destroy
v4 (Felix Kuehling):
- Removed unlocked checks around other kfd_alloc_process_doorbells calls

Fixes: 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e27ba5ad5f76932d4f6cbacd25c81c2dd40ec4a)
Cc: stable@vger.kernel.org
[ sashal: Adapted doorbell allocation locking for numeric indices instead of buffer objects. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 23 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    |  3 +--
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 43bfd668c5480..a08c84556ace4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -333,8 +333,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	if (!pdd->doorbell_index &&
-	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
+	if (kfd_alloc_process_doorbells(dev, pdd) < 0) {
 		err = -ENOMEM;
 		goto err_alloc_doorbells;
 	}
@@ -2203,8 +2202,7 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (!pdd->doorbell_index &&
-		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+		if (kfd_alloc_process_doorbells(pdd->dev, pdd) < 0) {
 			ret = -ENOMEM;
 			goto exit;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 3ac599f74fea8..a38e3e917c437 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -277,35 +277,40 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
 
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
-	if (!pdd->doorbell_index) {
-		int r = kfd_alloc_process_doorbells(pdd->dev,
-						    &pdd->doorbell_index);
-		if (r < 0)
-			return 0;
-	}
+	if (kfd_alloc_process_doorbells(pdd->dev, pdd) < 0)
+		return 0;
 
 	return pdd->dev->doorbell_base +
 		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
 }
 
-int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
+int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
 {
 	int r = 0;
 
+	mutex_lock(&pdd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (pdd->doorbell_index) {
+		mutex_unlock(&pdd->doorbell_mutex);
+		return 0;
+	}
+
 	if (!kfd->shared_resources.enable_mes)
 		r = ida_simple_get(&kfd->doorbell_ida, 1,
 				   kfd->max_doorbell_slices, GFP_KERNEL);
 	else
 		r = amdgpu_mes_alloc_process_doorbells(
 				(struct amdgpu_device *)kfd->adev,
-				doorbell_index);
+				&pdd->doorbell_index);
 
 	if (r > 0)
-		*doorbell_index = r;
+		pdd->doorbell_index = r;
 
 	if (r < 0)
 		pr_err("Failed to allocate process doorbells\n");
 
+	mutex_unlock(&pdd->doorbell_mutex);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index cdcaba185052c..04f8098b8ba3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -712,6 +712,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
@@ -1017,7 +1020,7 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
 					unsigned int doorbell_id);
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
 int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
-				unsigned int *doorbell_index);
+				struct kfd_process_device *pdd);
 void kfd_free_process_doorbells(struct kfd_dev *kfd,
 				unsigned int doorbell_index);
 /* GTT Sub-Allocator */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fd7fecaa9254b..db0689c23e6ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1065,6 +1065,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			pdd->runtime_inuse = false;
 		}
 
+		mutex_destroy(&pdd->doorbell_mutex);
+
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
@@ -1613,6 +1615,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
 	}
 
+	mutex_init(&pdd->doorbell_mutex);
 	p->pdds[p->n_pdds++] = pdd;
 
 	/* Init idr used for memory handle translation */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7c85bb9e270e7..b28b15e2d14c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -868,8 +868,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	*priv_data_offset += q_extra_data_size;
 
-	if (!pdd->doorbell_index &&
-	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+	if (kfd_alloc_process_doorbells(pdd->dev, pdd) < 0) {
 		ret = -ENOMEM;
 		goto exit;
 	}
-- 
2.53.0

