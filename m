Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE6435AAF
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346701; cv=none; b=XnhSjLjMET7b+KoEZaaqK+CU5f9ifndX4T8nlMog1Runyi45rDGwW8DccOVs1TbVnllo3JmheIh2oWQYnOnbtSMRyNBOmwJZRtmgW+CposAvGBeKljPZwPA3ryYnFnR0kVuIn8i6j4HJR4CywLhYeNzKqMiZbNqmbGXpWIdpYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346701; c=relaxed/simple;
	bh=x7o79AvVWCeq0EQbu96gTjgDogKxKZ9kvlnJFJDcFFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1v1m0rM1D4XEiPL0JEjLchQ68T1l9vNWZ9xuFyA5os8ON6X3HYGYgbAVHQmlmpxrOrD2HJn0kG0CE88n26YXLJhRoUfp2Pe3PWCL97GUZ3AHjVVvOlvnayZt0biy8XiGmLFhONLyhu0/AThyYBoGQLe4vg2DkE/uSgjzy7FFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZAHOWp9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZAHOWp9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1003774a91.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788346699; x=1788951499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKOzquW3shhpHe9E1Zxbxrv1dgTm0ijUX8KBrUVXtfI=;
        b=pZAHOWp9zYWnaUCv00XthNTQplf2AmBj/6hR9IH5F5wmF0dfneBKcOcn+gHZ810XZv
         D9qaJxemS10i7TbQLj5/QEh/3t03TX7xEwcmy6cJYNa7VEw4P+/hGfA4Xs28I+8i1DGc
         Ydd2V2aSQDIFBqORj71K8tawQlV7hUMp2ZIfqz2Qm8NAi+4febrTY7jXkJJiXZypZxov
         GIgD3Baa5Da540Ogs5VStjoe+fOy29Qf4eDEbgBMfPqeqpn7naSKsFG2fJWTH+vFD3Fl
         Q+TkSFEcCt/ef39mPR2U9rLQXyu0Ep0x2uqv2dzcFJ6w1WvpOy0cFoINPkb4cH26E1li
         7urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346699; x=1788951499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cKOzquW3shhpHe9E1Zxbxrv1dgTm0ijUX8KBrUVXtfI=;
        b=F3jAAc+CONvgl2QFK55eMDazNxY8qy040WG74IWy7h5CRabLF2aVH8IHMFiyT6Bx23
         5NLDd79k5ELSr92sNfpwKun/QPek2TNv9S3yUar7W1RD6Ix/HtFs4BybDTIPJi3NzTD6
         nEIdsS9qhLC6q2mcGOIbFawogXy2CjlZhWrWRhuUNQEqNeTQ52rjXRhgQ8W6yCEWB7Iy
         hakfCrptdPfubrQxs1RQHVMUcbYInI8Y65lNx/62iHf3PKJ+AD4+gJ9EtlASttVgmOK1
         AyUrKhvMogWIfgOqtl5VoJ6wJajWAGiMMnm6uMer1M6EQGcv4ZjLRREQDP8w0u6cmOoA
         LtGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC4tTgygzB11KQedS8uv4use5TIvuORnk3kszPSi7XtNaGrVqqA7OW5ydZuv0G4wQfOmVdkq4=@vger.kernel.org
X-Gm-Message-State: AFuF++nzgOcshcbgpvbnOE1XDbBfhKfkhA8PwN2ATF/LSv62oqLR30LB
	IEL8rq5mmtKQyNOZ2IsmtQhoMk1x05+MzyycgBMCwtzp8zcV1bek4HI=
X-Gm-Gg: AYBFou17wEvsfkG6PIpG6Jug8abaj240BsC3lXrpIOEu3mod10AZElxy+3g/ICiW+Ga
	gTDUSpCti/fdFggtC2DekeXJLNQDCzgcgkv9rOw5fvDqf1kb+Lhvwk3B1sxmYpSVpTMRzwRXcqV
	Ujo8eEZcrViSH6bzywynAs74eYvc0USo+I69zhdbewijR+rvtnN/s2f9IemFsPkU2KoQo1bs2jF
	iIJnsBWVyrN33Efb4C14GNNRbu8XVGUtc6uSD6oP0Tn4D66rD6gwH6+6JOaXy5lLxwATOrfmYjg
	pOQ1MSFNBd1+BCm9BMRtKXubk2UdQ70V51mqhrcnOXOXMfnKyzrbppBXFGRzoizWaRNsRPUe5JA
	0ZE0RffRcG6q9X2h8G7izJusbw63uf6Oex7FShqXSLYtshyTdHEsNcZ0taZRtM/pflWiLJ7e7ua
	RDTTzngEupze12K45kt7PfBA29eoH7Wad/EUZ4YADIVY9Jbx7E+hsgVFX1KF/ITsvVPbToVtoKi
	FvuQLCrQh5hlQQ53WFLdx8HEmY=
X-Received: by 2002:a17:90b:4d82:b0:398:9be8:ea65 with SMTP id 98e67ed59e1d1-39aee1ab4c4mr5010188a91.18.1788346698548;
        Wed, 02 Sep 2026 03:58:18 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfcd65sm4963143a91.3.2026.09.02.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:58:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net,
	phasta@kernel.org,
	matthew.brost@intel.com,
	dakr@kernel.org
Cc: christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/sched: cache the timeline name to fix a use-after-free
Date: Wed,  2 Sep 2026 19:58:07 +0900
Message-ID: <20260902105808.1541063-2-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902105808.1541063-1-malhyuk97@gmail.com>
References: <20260902105808.1541063-1-malhyuk97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
drm_sched_fence ops keep a .release callback, so the fence is not
ops-detached on signalling (dma_fence_signal_timestamp_locked() only clears
->ops for fences without .release/.wait). The callback therefore stays
reachable on a long-signalled, userspace-held finished fence and
unconditionally dereferences fence->sched.

A driver that allocates a drm_gpu_scheduler at per-context/per-queue/per-VM
granularity and frees it on an unprivileged context/fd close, while
exporting the resulting finished fence to userspace (drm_syncobj /
sync_file / dma_resv), leaves fence->sched dangling after the free. A
subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name()) then
reads the freed scheduler:

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name

This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
(VM_BIND) are still affected in mainline, so fix it in the core to cover any
per-context-scheduler driver at once.

Cache the scheduler's name pointer in the fence at init time, while the
scheduler is guaranteed alive, and return the cached value from
get_timeline_name() without dereferencing fence->sched. The timeline name is
not guaranteed by the contract to outlive the scheduler, so document in
struct drm_sched_init_args that the @name passed to drm_sched_init() must
follow the dma-fence safe access rules and outlive any exported fence. Every
in-tree driver passes a string literal, which satisfies this; drm/xe's
299bc6d50b1b keeps its dynamically-allocated name alive across the RCU grace
and can be simplified on top of this.

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 16 +++++++++++++++-
 include/drm/gpu_scheduler.h             | 18 +++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..a944eeeb25bd 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-	return (const char *)fence->sched->name;
+
+	/*
+	 * Do not dereference fence->sched here: a userspace-held finished
+	 * fence can outlive a per-context scheduler. Return the name cached
+	 * in drm_sched_fence_init() instead.
+	 */
+	return fence->sched_name;
 }
 
 static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
@@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = entity->rq->sched;
+	/*
+	 * Cache the scheduler's timeline name. The finished fence may be
+	 * exported to userspace and outlive @sched (per-context schedulers are
+	 * freed on context teardown), so get_timeline_name() must not
+	 * dereference @sched. The name is required to outlive any exported
+	 * fence (see @name in struct drm_sched_init_args).
+	 */
+	fence->sched_name = fence->sched->name;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7a64cc11de08..412b8c4643f1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -322,6 +322,17 @@ struct drm_sched_fence {
          * belongs to.
          */
 	struct drm_gpu_scheduler	*sched;
+	/**
+	 * @sched_name: the timeline name of @sched, cached at init time.
+	 *
+	 * &drm_sched_fence.finished may be exported to userspace (via a
+	 * sync_file or drm_syncobj) and can outlive @sched: a driver using a
+	 * per-context scheduler frees it on context teardown while a
+	 * userspace-held finished fence still references it. The
+	 * get_timeline_name() callback must therefore not dereference @sched;
+	 * it returns this cached name instead.
+	 */
+	const char			*sched_name;
         /**
          * @lock: the lock used by the scheduled and the finished fences.
          */
@@ -646,7 +657,12 @@ struct drm_gpu_scheduler {
  * @timeout: timeout value in jiffies for submitted jobs.
  * @timeout_wq: workqueue to use for timeout work. If NULL, the system_wq is used.
  * @score: score atomic shared with other schedulers. May be NULL.
- * @name: name (typically the driver's name). Used for debugging
+ * @name: name (typically the driver's name). Used for debugging, and as the
+ *	dma-fence timeline name of the scheduler's fences. It must follow the
+ *	dma-fence safe access rules: a &drm_sched_fence.finished exported to
+ *	userspace can outlive the scheduler, so @name has to outlive any such
+ *	fence - use a string literal, or free it only after an RCU grace period
+ *	past the last exported fence. See drm_sched_fence_get_timeline_name().
  * @dev: associated device. Used for debugging
  */
 struct drm_sched_init_args {
-- 
2.43.0

