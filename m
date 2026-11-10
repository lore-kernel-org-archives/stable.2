Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338491;
	b=l/hgYGi8YsjMu9rVrQU55jXVJjYML+0D5oAqoXWa+BvPOhq0B/o3WtLDD1lZ9TuXaIXr
	 tyxe/CRmJdn7CyeKt28Kv1go1MdeH4mnHBwVCrfGzuyPL3jtj4JvIhpliy5zCyHBPvN/T
	 Gx7W3h2XwxRpJZ3RYW0P6RBEnRHdKyv8z8CMPeXWW045CzqEi5JacSgOVKA85/4yXe7Pt
	 hMQXAp6wrbNopJYutZ4tWfvWiuPKulonn/eKmiPiK+ESy8DbW7AEP+MGXjUEd+kdOUlEj
	 9p1S4nqNIyys2PNVDytmUmbpWHSg06FaCbb0bBbqoJzyXsTpxvkrhty2SPw97aqyEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fu8U1Wq/9JwI/SY1ys/7hcQq3ryu0gTJkf5e8ByLmD8=;
	b=KI1KpynHVxabo3EyNWdoHJz+yizT/IICZ9n87x2OjvaUONoO8Aftsd8iSV02AlYWKB8N
	 9SGZEHHygIPnlfGYBQUu/JzEQ764/obldW4GtWNwb4t/0pn6EY5i6ZbfDyuwiXmLnkxpb
	 f1fK/eNwRsm6Ccf/bCKVJSB47VO2dto7qCpE1hGhA6r3e32IZWYPsUCbpoOT4ymilwXE/
	 +WMNyc8NtDZpBOWDJ1+CRzkPR5yRiwMRBwPMrriPWSPwJaAJbz/NM6lJPH73vN8t0AMst
	 fCfOZ0NB/wBbhL1YQDTwc7zsGy8zlcWXuLsknvGrwy4WmiRd9bAmC1IzBmTguMqZy6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehiTqVOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017E606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehiTqVOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381711F008A1;
	Tue, 10 Nov 2026 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338490;
	bh=Fu8U1Wq/9JwI/SY1ys/7hcQq3ryu0gTJkf5e8ByLmD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ehiTqVOluaitXYH71kxwKsBr60zKDS2AsNoL8TUobQhbjbC4jgvZJomXEH8W23Qbi
	 T1P2BtbulnTL6jQPa31mGWnPNig9DuUrduWv2QSMQ3WimcegJsXT42kO18tZ+Z8q0X
	 ZHhQLSlhvOxYI21nlYpUomQhEGtsIHBGyDrf7lAD4RH05+JLcxWhTYrPccH8emiZ8l
	 r4AFUqG8GEcVaP4iXuMNFkzNshZDMEyPujLa2YZz3TiFauEmeb6x4qwVEz4gJxKhNd
	 2TLEGtuKybsMzGNQfRY7QWZ76fEyoUMSl1FeR2zvrovr/Ek2QBANcOY8I1s3xHTjLI
	 4IeqA1tGYsVpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdkfd: fix doorbell allocation race creating duplicate allocations
Date: Tue, 10 Nov 2026 14:21:27 -0500
Message-ID: <20261110192023.3506934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053743-failed-6.6-bebad4505094@kernel.org>
References: <20261107053743-failed-6.6-bebad4505094@kernel.org>
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
[ sashal: Adjusted context for older inline queue buffer handling and missing SDMA validation and process counter code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 18 +++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 57a41ff6ea930..44cd1b54d020e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -339,12 +339,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
-	if (!pdd->qpd.proc_doorbells) {
-		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
-		if (err) {
-			pr_debug("failed to allocate process doorbells\n");
-			goto err_bind_process;
-		}
+	err = kfd_alloc_process_doorbells(dev->kfd, pdd);
+	if (err) {
+		pr_debug("failed to allocate process doorbells\n");
+		goto err_bind_process;
 	}
 
 	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
@@ -2294,11 +2292,9 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (!pdd->qpd.proc_doorbells) {
-			ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
-			if (ret)
-				goto exit;
-		}
+		ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
+		if (ret)
+			goto exit;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index fdcf7f2d1b5b4..6af268a031f22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -239,11 +239,9 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 	struct amdgpu_device *adev = pdd->dev->adev;
 	uint32_t first_db_index;
 
-	if (!pdd->qpd.proc_doorbells) {
-		if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
-			/* phys_addr_t 0 is error */
-			return 0;
-	}
+	if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
+		/* phys_addr_t 0 is error */
+		return 0;
 
 	first_db_index = amdgpu_doorbell_index_on_bar(adev,
 						      pdd->qpd.proc_doorbells,
@@ -257,12 +255,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	int r;
 	struct qcm_process_device *qpd = &pdd->qpd;
 
+	mutex_lock(&pdd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (qpd->proc_doorbells) {
+		mutex_unlock(&pdd->doorbell_mutex);
+		return 0;
+	}
+
 	/* Allocate bitmap for dynamic doorbell allocation */
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
 		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto unlock;
 	}
 
 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
@@ -284,11 +291,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 		DRM_ERROR("Failed to allocate process doorbells\n");
 		goto err;
 	}
+
+	mutex_unlock(&pdd->doorbell_mutex);
 	return 0;
 
 err:
 	bitmap_free(qpd->doorbell_bitmap);
 	qpd->doorbell_bitmap = NULL;
+unlock:
+	mutex_unlock(&pdd->doorbell_mutex);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8f6fe5312b26e..b2683275ed017 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -752,6 +752,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 93740b8fc3f44..b860598d86f22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1061,6 +1061,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			pdd->runtime_inuse = false;
 		}
 
+		mutex_destroy(&pdd->doorbell_mutex);
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
@@ -1600,6 +1601,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
-- 
2.53.0

