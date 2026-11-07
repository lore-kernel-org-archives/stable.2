Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048764;
	b=f8hzkCXtcfxWz5dkEf2carnehNUsqdu0GCee/2pokqyHE5q9Hb11I7+MKnavgBnQ5kbK
	 f/G0fKUs3KAhp3R7GroR9ahiBY0ddBfc/nihSAaVKg6Zz4bjxYeDi+wIjSZYmgvdUUKDK
	 F7SOLuYx8o+g8fxfhvYFFRz57EsYi8sdSiLRx3gG9UWLixuGuqE/n5HJISsdZYV4QSKW3
	 YPpP0/pgog5weQ3KfgY3kslMy0ziEomPpF9pn2UUWgLWea9a3FodA4cNXL5pVPrDbATRk
	 5hLtTV7/s62iMAT0YEIYVWrUUNUifs+s2bo0wOhPgCtfFCQJTY4MiLeCCgiesbz49PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A6RT8G3hwQJnR+ef7SA60t58wbzsbjnkgpiCVExbNoA=;
	b=ZPfXzC+3zeBX8vhq+5uaGpfBvmsSuasDJl52XgF2N/9fkRF0UCwrMN9HzhVETTZC7iCL
	 GGMqXN8g0S9N5j1Zc6eyyNROoMaRRKjkYTBryEFcMXb+u3BO6UKSjR4GyE9Up9whnBOgP
	 +tiONoqTxSCMi1oykiGFtTGnz5wck/m37v3azJLzHIJ2OVAPKeT7mj6vI6oWUjTR1EmxL
	 HGFO3Qok6hXmMmCzLL6ne2mHAcdiynKWHWkfg6leEzJp72XObC8W0EZfsi4uxDS5/SV4R
	 m+eNFoqtYMlQ+aoKUKVFON8P8g17dV9JR4g4cIvKMxed4mPiwlceZPhAjsr2B89F2NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEcv4o+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEcv4o+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36E1F0089F;
	Sat,  7 Nov 2026 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048763;
	bh=A6RT8G3hwQJnR+ef7SA60t58wbzsbjnkgpiCVExbNoA=;
	h=From:To:Cc:Subject:Date;
	b=nEcv4o+ohb09rdZ1OSB6PbCAIAPT7wCn1BxWIwOAG5CqhTp8Xa8EIb8XrWeyBaCyW
	 1qA5xwoscq4+TsHUyreEBlvkb14SvRpRxgFP0zaaF/1JtYgtxZSPOV1P4T9Ev+RbIL
	 pQ/RLR49hiTvIe8dSNIlOfkhj3IG1jkCJ05KCOW8pUQThaE+MASwFwB7Ir7qBjkCSB
	 nTZ6nqkRj+9C5M2TdI7PIKTCueo5/+ulVeOm2mSAQqq0iw/1+l42mJe4K8zaXH5Sj9
	 Jf2Awrv/Jc8zeyQv4SvXXlARS/oz0z5ryTpQLWcy9cgr0CYIVqwZPhJ/SZUD7lGxoA
	 qsoOwGiKab43g==
From: Sasha Levin <sashal@kernel.org>
To: bsdhenrymartin@gmail.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdkfd: fix doorbell allocation race creating duplicate allocations" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:42 -0500
Message-ID: <20261107055241-failed-6.1-bebad4505094@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bebad45050945a3d668d6701fb77ae2571c5d44b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055241-failed-6.1-bebad4505094@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bebad45050945a3d668d6701fb77ae2571c5d44b Mon Sep 17 00:00:00 2001
From: Henry Martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 11:02:30 +0800
Subject: [PATCH] drm/amdkfd: fix doorbell allocation race creating duplicate
 allocations

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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 18 +++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 344da6c0e96ad..3081d9aaf053a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -427,12 +427,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		}
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
 
 	err = kfd_queue_acquire_buffers(pdd, &q_properties);
@@ -2455,11 +2453,9 @@ static int criu_restore_devices(struct kfd_process *p,
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
index b9a31489b1c89..e102086ac49a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -784,6 +784,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e849..51b0df4984945 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1233,6 +1233,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		}
 
 		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
+		mutex_destroy(&pdd->doorbell_mutex);
 
 		kfree(pdd);
 		p->pdds[i] = NULL;
@@ -1802,6 +1803,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
-- 
2.53.0




