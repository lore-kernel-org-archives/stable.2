Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644359;
	b=ZE9gLpZrD/oPSKmXz4WOn9kUCPax7g4Nbc8NlS9rme0DM0SluZRS03cGonnh7Cao6KWe
	 0sKhh0aERjRWPwHL1aJldWkjVRjTIJ5hdXGfLdqAu/8pREgoV8v+b12SVrlSXVv7A364P
	 FUcJ0XMmQUDbW93n6EfRDjmwe3/kE07JN/YPNDIgYANVlF16SIE5U7oleBp3yA4ru2b6m
	 RJcLbgoDVAxHcWOIr3V3ZiT3Wb8vR1p2L5lF6LJwUOJeeQ/2wgut4MX8qOZlWAiNruln1
	 eolWMxTZtDI5oFRfPTZiDf6KCSGHWClX0/MDV1P5A/1tYAeLnWMWVYPmYtLehnJdnSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F88s34t6HgwaWc7KrjRKtNSJ/J1MLEeihPOI9axIS0Y=;
	b=x9cCFen2EB/Dvat6BDzJ9AvGWp0Lvdn+GQ489yv2f7kd5RDfv5/SHV/uULcZFgqcbowk
	 +wnin/gXYm4cxnlVL9NExcf35AYOjV9RCLw1AthJIMAn2PG2uErjV4BwJR3hjqEuJxHRC
	 zQIcuuxce2GA75y5ASrB6HyXpudG2Ti2jlJcriuj2vDMiB2/+e5NMaHSSxjG3ki9jfQO3
	 eGurmNV8Lc7ZWFsgUd/Ii0XBd9s4ki+Atfh2xZU8S/8iPzmSiF6L/qgvrBBTJVmULs6DQ
	 rEVUQmjk1xyNYZnT0w5qcQrOH6WDYym2ncdiJpC4jPOFoxMoTOdToCzkPqCMryd4NUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFNz83mT;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3C606A338
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB3C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFNz83mT
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36ecc11bd26so225904eec.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644358; x=1795249158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F88s34t6HgwaWc7KrjRKtNSJ/J1MLEeihPOI9axIS0Y=;
        b=SFNz83mTcOPA3L7JSEyJ8LE8yDR/LmyRE4ocGf+ufqZMrtJYjCOsx7Eiq6jc1sq11P
         BtM4cpYHk3vO1Nrs3lziT0EVlW+N59TOsGut+vCLDEFCyYmekQsJD9xGI/c+pVbuX14M
         GIDoB6wGo1SoPXoYgNG2jvSxfL4l83t34FE7t7CLlQ5OpSQ8Sg6hYdMc+yQsf5AL9sir
         FkaA9K66OUMpCzXIjcPmb/ns751UeJukzieZ5gZjo1l3nv4uEFclv1U/iceveItZhhuh
         kbkl91Rb7uU9tbT6y/U2weZwvb6CpTdbuNfgAjpizMYppqHMYY8PDYd81sRXLBPTCXLf
         V6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644358; x=1795249158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F88s34t6HgwaWc7KrjRKtNSJ/J1MLEeihPOI9axIS0Y=;
        b=QvbVJ3EG9Xsp+jbvav5fpZ9fjQ+pgUP7lJmbbkXl8ikTKAqDBAUIna+W5hKmBklpym
         T/eAof1wmR/kBkrv+eFyBiHrTnFahUo+lbzkdrVUHVUNc8KLhc0xVGJh0Opb8CWKeRWz
         skR5X3ZwmQNRSo+fRM9f0OdHDAdd922tZIC5V79UXKCLzXu2s7LZ1D5BYbU1M2v6Vgqx
         DTMGkWP3SZFv2W7P08A7sckOIT5n95zyrF/WbxUW5scYRAkjEKb+R+9dbEBIzzkaGKft
         jy52ty2tbpbPKGOfUL8XEJqGJDv45GLTG+1QTdAkwE/vHrcnTKGPsiZ5GGRQY39FNCGn
         E2Mw==
X-Forwarded-Encrypted: i=1; AL+hErHbI+5Ga4ioEQxVdDp3POEW8No8b/3wIb5w39ajM/A7nOVBsKaE2mYLhtt1/vzmBfbQxyyb2Sc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CsaOyUwDXVCG1kyiMqiGEOBHVlmcIT6warAfhC8ay2GFNCgTx
	ZLY8Z6l00w65alOCOrMU3rtyj9uayRLslt4e01ifL9tRpjDWcw7TgyT1
X-Gm-Gg: AYBFou1rzRCQrWmvHgsFQ5QvN/X3CyHCAQstH9L/JexxDy555H/bowy+eMZfeVmBlv8
	vTrBZjxuy1VioSMPB9Wc7qZ0bIKbMJJSWbpT7zB/Q0tIn4xpSjcMJ7itUm8+3EnWjx/o6mA4GJi
	5S1rMUaVhlNqO25NQhzThUqavBitXQitHCkPgnXtt5VxoHLT4xOI+++7TC+REP3hTxgaTnNjYxD
	WXD4xvqnN8iXizYdeNQOZsOMm+c2JUX8tojoW4Y2FOsG1E+LpeConH/87m7RzVG/y1WqR3R8lC3
	67jocrTssqUJPNkCcA/2Obl9M35vPiJA1+BYmD7hw2gSBcmG+VazrUMq23+9/65rhc79LeFY3Qj
	qEWHBpj1kK4vEKobcb85JcSlavCITBoY7GXLXUIAO+ORAkll5lz8EFYBKd4L1+EfLrsrdJyDEYB
	VUGe+1nBC48n9g8v9GyhonspJLh536y+wwpmGCllUCzti5F2RAmxoqaOLeXdhawBcJyI8/Hcx/W
	D+YCpDpI0gafhAmY4lVI4jIwStkJC/sTkIH/+OfjHJ5nZPgxPZfe8nyrgDsn8J6edvatpx9SzxZ
	prN4VVYjxEnjYgO+ktIiE9sz3BCmPPkNm4pyXXv22P0Fztn9oJfEPGzd4xR5TVHImpMw+2r38P3
	b9Ao=
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id 5a478bee46e88-3796038259fmr6915918eec.0.1794644357643;
        Sat, 14 Nov 2026 00:19:17 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:19:17 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Antonino Maniscalco <antomani103@gmail.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/msm: Release the pins and ops of a VM_BIND job that never ran
Date: Sat, 14 Nov 2026 17:19:00 +0900
Message-ID: <20261114081902.1669-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
References: <20261114081902.1669-1-arpe1618@gmail.com>
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

msm_vma_job_run() applies the pgtable updates that vm_bind_job_prepare()
queued for a VM_BIND job, drops the GEM object references that
vm_op_enqueue() took for them, and unpins the BOs of the job. A job can
also be freed without having run: when its entity is killed, e.g. on
SIGKILL while the process exits, and when msm_ioctl_vm_bind() fails
part-way through vm_bind_job_prepare() or after it. msm_vma_job_free()
then frees the queued ops without applying them and without dropping
their references, and a killed job also keeps its BOs pinned. Besides
the leaks, the VM no longer matches its pgtables: for example, the
pages of a VMA that was unmapped from the VM are still mapped.

In msm_vma_job_free(), apply the queued updates the way
msm_vma_job_run() does on error: skip the maps, but apply the unmaps,
so that their references can be dropped without freeing pages that are
still mapped, and mark the VM unusable. Move that part of
msm_vma_job_run() into a helper for this. Also clear bos_pinned once
msm_vma_job_run() has unpinned the BOs, as msm_job_run() does for
submits, and unpin the BOs of a job that still has them pinned. The
job's fence does not keep them busy anymore at that point, so take the
object lock to unpin them.

This also marks the VM unusable when msm_ioctl_vm_bind() fails after
vm_bind_job_prepare() has queued updates, i.e. when the first op fails
part-way or when sync_file_create() fails. The VM is then left
partially updated, as when a later op fails.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-214234@kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
At commit 2e6a8a1fe2b2, msm_vma_job_run() still unpinned the BOs under
the object lock, and msm_gem_vm_unusable() did not exist yet, so older
stable trees need an adapted backport.

 drivers/gpu/drm/msm/msm_gem_vma.c | 65 +++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..a6f106d0cdef 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -700,16 +700,16 @@ static const struct drm_gpuvm_ops msm_gpuvm_ops = {
 	.sm_step_unmap = msm_gem_vm_sm_step_unmap,
 };
 
-static struct dma_fence *
-msm_vma_job_run(struct drm_sched_job *_job)
+/*
+ * Apply the pgtable updates queued for a job, and drop the references that
+ * the ops hold.  If ret is an error, or one occurs, the remaining maps are
+ * skipped, but the unmaps are still applied, as the pages they unmap must
+ * not be freed while they are still mapped.
+ */
+static int
+vm_bind_job_apply_ops(struct msm_vm_bind_job *job, int ret)
 {
-	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
-	struct drm_device *dev = job->vm->drm;
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
-	struct drm_gem_object *obj;
-	int ret = vm->unusable ? -EINVAL : 0;
-
-	vm_dbg("");
 
 	mutex_lock(&vm->mmu_lock);
 	vm->mmu->prealloc = &job->prealloc;
@@ -740,6 +740,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	vm->mmu->prealloc = NULL;
 	mutex_unlock(&vm->mmu_lock);
 
+	return ret;
+}
+
+static struct dma_fence *
+msm_vma_job_run(struct drm_sched_job *_job)
+{
+	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+	struct drm_device *dev = job->vm->drm;
+	struct msm_gem_vm *vm = to_msm_vm(job->vm);
+	struct drm_gem_object *obj;
+	int ret;
+
+	vm_dbg("");
+
+	ret = vm_bind_job_apply_ops(job, vm->unusable ? -EINVAL : 0);
+
 	/*
 	 * We failed to perform at least _some_ of the pgtable updates, so
 	 * now the VM is in an undefined state.  Game over!
@@ -753,6 +769,8 @@ msm_vma_job_run(struct drm_sched_job *_job)
 		msm_gem_unpin_active(obj);
 	}
 
+	job->bos_pinned = false;
+
 	mutex_unlock(&dev->gem_lru_mutex);
 
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
@@ -766,26 +784,41 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 
+	/*
+	 * In error paths, and if the job was killed before it ran, we could
+	 * have unexecuted ops.  Their changes were already made to the VM, so
+	 * apply the unmaps, and give up on the VM.
+	 */
+	if (!list_empty(&job->vm_ops)) {
+		vm_bind_job_apply_ops(job, -ECANCELED);
+		msm_gem_vm_unusable(job->vm);
+	}
+
 	vm->mmu->funcs->prealloc_cleanup(vm->mmu, &job->prealloc);
 
 	atomic_sub(job->prealloc.count, &vm->prealloc_throttle.in_flight);
 
 	drm_sched_job_cleanup(_job);
 
+	/*
+	 * A job that was killed before it ran still has its BOs pinned.  The
+	 * job's fence does not keep them busy anymore, so take the object lock
+	 * to unpin them.
+	 */
+	if (job->bos_pinned) {
+		job_foreach_bo(obj, job) {
+			msm_gem_lock(obj);
+			msm_gem_unpin_locked(obj);
+			msm_gem_unlock(obj);
+		}
+	}
+
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
 	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
-	/* In error paths, we could have unexecuted ops: */
-	while (!list_empty(&job->vm_ops)) {
-		struct msm_vm_op *op =
-			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
-		list_del(&op->node);
-		kfree(op);
-	}
-
 	wake_up(&vm->prealloc_throttle.wait);
 
 	kfree(job);
-- 
2.43.0

