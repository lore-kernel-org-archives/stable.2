Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665948;
	b=5pRobUP4wMGzE4sM9x1MwUUx7MuA5b9rf7Ir0gs4nsdwDPmuqYgbKRspUNmnyj5twB7f
	 jXTYgelm01twR0dTNoBgl4mxkbt1t9wxHSgj8Bjnz8Zau1FjbmjPkNnrMHPSGOijZ8YJ3
	 GNjKaEHcZ4hceR1Hax81euf5/ufoPSJ+wALubbhIgmrUKGKdmR4z4DaL4cJIdDcOUVY5J
	 +YFuuMPst5QY6fysvciLS3z9ikZNfPSVKDUt5ahZToU2kb0pgh6z/BediQY1qtgJRzbUa
	 1fYTgGL7Kl4PsVcIHEMCVmGu0oFOSFu3b8KBLQcZMpkpaO1vU6I8qrETsd39J/AbmTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mbi96igc2n0483c/SqG4t1PVFDZn4uBg/WQ+jK8IEKc=;
	b=KHax3+cK3n8ksUlTgFDfCwVHm+rVHfY+S9TIfAteUUaVQhfTOdeEECRo6U510U/L9OHD
	 GPnUqr2JeRVw8Opd3dFS0scCAb5aJu15/7Jf/fysGSHczQTYjjIoiph5Kk+Xsu61kYLPb
	 3p5jGuh4kp8I6jEcIEfF6fBBzW28UqLl4EFQR5ubXqVXjmSy0wDIIDewIx2CqJmap0GXJ
	 AiAijZayEnJggHQ7sViD0Np/nk7EGMBW3rWbpsXF6NIqLzYMVQawqppeUfUSrYju1eJPV
	 r6Wdnwl/Lyigj2ixSNnLDvw13j5svWThUu1wif6o96BW1yrx0Y/Cy6HHQbIWgfc0Dfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Amtu/ZFl";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82797606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 14:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82797606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Amtu/ZFl
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ae17c535so51853c88.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665948; x=1795270748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mbi96igc2n0483c/SqG4t1PVFDZn4uBg/WQ+jK8IEKc=;
        b=Amtu/ZFllK4PUX+JONp25BBuOdYUDDn4gbON8ZJPC5Va9gZ+vSQSFg2wJEj0k4U35B
         1E3rKMZm1r8HZqedQPc7/jeAlKOOE1cYf5eK7vNt89pq+gGG2eB/DEv6BqFv8fetEcmM
         kWQZta66qQnYT9+/4reaSM/7eADczHthvUtex8Ay49garOlJ0mB5pRloZ/JLRL0X5yST
         V68CDZMV9kAEWDwNsMrZgdT8eu6+KxnjjZIC9UGMdQQIfRCwYuCY1jw4lcalnb1PyJDq
         jcXde1nbefobjTAv+EdCJpkC24NolRECIJyyFuzON2aUFoNyCNqhyNRepdM+J4N1Yhe7
         hWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665948; x=1795270748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mbi96igc2n0483c/SqG4t1PVFDZn4uBg/WQ+jK8IEKc=;
        b=hTPUbZc/wmL7eG7H4QxJ3dKqCILNZoD6/sZtC04E1QwdQZYAqR8TmVJZ+DpdxfuH2s
         m/LxRKUZWPkLyQ23X0SKQVNeLfMvjV8H7aQdbrDcBtOWfl+rMGquCD4qVeIzZ57t6qFq
         USsoh2B8LAnjqrYr9/8vI7YSqJ6TB60qK7FVN1lQHX6g1kBRO5te/D7XIcpHttfUgvNm
         A70BLm+2hlpx2c9ZEMMvacFVM3Gh8nPpZJzFe//jgn8yrFBP0Gj/Hx7gyW3VAGPJShdT
         ZwBLFRwskdku/RgM3rbmFg/+hCB5FZEmnSNk8lZxYMVaHbDUYaLr+9olIkOZh0Aj3vQE
         sAjA==
X-Forwarded-Encrypted: i=1; AL+hErF4fPB9pjVbAvz0l8t6LBECT52Ygl9WW9U3mmONULjBi6DWqNjhDd1S6B6FIlK1gWvHwzgxdD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fQHNSohbir9v5KzrezKOKn7fytmt63HhTlbh1+KkX9tzer+s/
	Ce0UL82r9XUh311mGQ1MZbWLegqB1QlTNG/r2m0y23W2O0xKgCZGwcKZ
X-Gm-Gg: AYBFou0NP9aBGnl9kHV7WQybkZXdvNvDLSSuFBYXvwKs9G6FiaOD1S3002ppXIJivy2
	mjRnBPWH/S/cOQblkFxtZ+0WgQHv5+14BYm9JVOZl4WrlTIqGgxzour7tEg5g1rUhBXqT7wAGN0
	5cyCtETkTCst0IFd0pMqYJhMfk8T304V+aWxncyc67PGUR44luQvrdYt0nuOpl1eKnWWbpDWR55
	14caICIISDeMtIabSZ3sy4xeyZX/crP9HszZCvyifE+huu7Om0e6dcqH5msQrt0QwloKTGMsH5U
	2LDxy67skQmMcfbosP+cBYFMRG4YGQREksCqTrVdHBwy9nAK/L2HnYDJsVC2xzpF6drvH7l+HIR
	1MJLPNaz7HeSIlH+4NNCvHSQGtks+PtBFnH7H17UURURP+CMPANts+w1nm9CtVb/2Huxp5ajAMk
	z1tAVqtj1pastqjPHW09g6lLISSbYhvQQN52Wix9WrUDaXSfXurvokF/T/R/0YAvitKYLZjIh0y
	XcSnVKwM5fONtmVBqrn5aNZ5BkXW58KlwFk6hdNo8ffAlE6RmwPa6RyuXOnJUSn4jobRyuHn3sH
	Gp3qT/TaHOLHfVJesrsHsq7QfqO+exbzsAakOl1ql509V2CmpyFnoR+Klg5nhjt7KtaZT2gUNbk
	Gasc=
X-Received: by 2002:a05:7022:283:10b0:17f:641e:7f6b with SMTP id a92af1059eb24-1b503086f3emr8214426c88.1.1794665947348;
        Sat, 14 Nov 2026 06:19:07 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:19:06 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>,
	Julius Bairaktaris <julius@bairaktaris.de>,
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
Subject: [PATCH v3 1/3] drm/msm: Release the pins and ops of a killed VM_BIND job
Date: Sat, 14 Nov 2026 23:18:49 +0900
Message-ID: <20261114141851.134290-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114141851.134290-1-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
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
vm_op_enqueue() took for them, and unpins the BOs of the job. When the
entity of a job is killed, e.g. on SIGKILL while the process exits, the
scheduler frees the job without running it. msm_vma_job_free() then
frees the queued ops without applying them and without dropping their
references, and leaves the BOs pinned. Besides the leaks, the VM no
longer matches its pgtables: for example, the pages of a VMA that was
unmapped from the VM are still mapped.

The scheduler only frees a killed job once its dependencies have
signalled and the job queued before it on the same entity has run or
been killed, so the updates of the jobs that ran before it have all been
applied by then. In msm_vma_job_free(), apply the queued updates the way
msm_vma_job_run() does on error: skip the maps, but apply the unmaps, so
that their references can be dropped without freeing pages that are
still mapped, and mark the VM unusable. Killed jobs can be freed
concurrently, but as they only unmap, their order does not matter. Move
that part of msm_vma_job_run() into a helper for this. Also clear
bos_pinned once msm_vma_job_run() has unpinned the BOs, as msm_job_run()
does for submits, and unpin the BOs of a job that still has them pinned,
taking the object lock, as the job's fence does not keep them busy
anymore.

msm_ioctl_vm_bind() frees a job that fails right away, before its
dependencies and the previous jobs of its queue have completed, so the
queued updates of such a job must not be applied. Move the freeing
itself into vm_bind_job_free(), and call that directly from there.

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

Julius Bairaktaris' "drm/msm: Keep objects of queued VM_BIND unmaps
busy" keeps the objects of queued unmaps busy with the job's fence:
https://lore.kernel.org/r/20261111080619.244138-1-julius@bairaktaris.de
For a killed job, the scheduler signals that fence before it calls
free_job(), so with both patches, these objects are no longer busy for
the short time until this patch applies the unmaps. Without this patch,
the unmaps of a killed job are never applied. Closing that window would
need the objects to stay pinned until their unmaps are applied. The two
patches apply in either order.

Not addressed here, as before this patch:
- The error path of msm_ioctl_vm_bind() still frees the queued ops of a
  failed job without applying them or dropping their references. Their
  unmaps could only be applied after the job's dependencies and the
  previous jobs of its queue, i.e. by queuing the job anyway.
- The issues in the error handling of vm_bind_job_prepare() that
  Sashiko listed for v2: a VMA left in the VM when vm_op_enqueue()
  fails, which a later remap of a MAP_NULL area turns into a NULL
  dereference, and the vm_bo reference in msm_gem_vm_sm_step_remap().

 drivers/gpu/drm/msm/msm_gem_vma.c | 87 ++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..0b9f2e8916b7 100644
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
@@ -753,16 +769,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
 		msm_gem_unpin_active(obj);
 	}
 
+	job->bos_pinned = false;
+
 	mutex_unlock(&dev->gem_lru_mutex);
 
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
 	return NULL;
 }
 
+/*
+ * Free a job, whether it ran or not.  Ops that are still queued are freed
+ * without being applied, and without dropping their object references, as
+ * the pages of their unmaps may still be mapped.
+ */
 static void
-msm_vma_job_free(struct drm_sched_job *_job)
+vm_bind_job_free(struct msm_vm_bind_job *job)
 {
-	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 
@@ -770,7 +792,20 @@ msm_vma_job_free(struct drm_sched_job *_job)
 
 	atomic_sub(job->prealloc.count, &vm->prealloc_throttle.in_flight);
 
-	drm_sched_job_cleanup(_job);
+	drm_sched_job_cleanup(&job->base);
+
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
 
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
@@ -791,6 +826,29 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	kfree(job);
 }
 
+static void
+msm_vma_job_free(struct drm_sched_job *_job)
+{
+	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+
+	/*
+	 * A job that the scheduler frees without having run it was killed,
+	 * e.g. because its entity was destroyed.  Its queued updates were
+	 * already applied to the VM's address space, but not to its pgtables.
+	 * The scheduler has waited for the job's dependencies, and for the job
+	 * before it on the entity to run or be killed, so apply its unmaps now,
+	 * before the references to the unmapped objects are dropped, and give
+	 * up on the VM, as its maps are skipped.  Killed jobs only unmap, so
+	 * the order in which they are freed does not matter.
+	 */
+	if (!list_empty(&job->vm_ops)) {
+		vm_bind_job_apply_ops(job, -ECANCELED);
+		msm_gem_vm_unusable(job->vm);
+	}
+
+	vm_bind_job_free(job);
+}
+
 static const struct drm_sched_backend_ops msm_vm_bind_ops = {
 	.run_job = msm_vma_job_run,
 	.free_job = msm_vma_job_free
@@ -1607,8 +1665,13 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (!IS_ERR_OR_NULL(job)) {
+		/*
+		 * Not msm_vma_job_free(): the job's dependencies and the
+		 * previous jobs of the queue may not have completed, so its
+		 * queued updates must not be applied here.
+		 */
 		if (ret)
-			msm_vma_job_free(&job->base);
+			vm_bind_job_free(job);
 	} else {
 		/*
 		 * If the submit hasn't yet taken ownership of the queue
-- 
2.43.0

