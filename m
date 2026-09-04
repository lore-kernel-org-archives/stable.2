Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627683CDBD3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509190; cv=none; b=ou0RLzekLc4RbBrCoJKUAwdNBsI4fkvzRc5zTNm0MFFPShsK6fOaqNJpGUt+755bapXJdm+4vmPwk8VZa6xLJrLhc4dj5mQEymYwOpCnDGA8ildgwgBWfClhn4iEURZYCikN+kT/wxz1qlb6qG+a2HcKxvhAXpQN5MFI9OpNxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509190; c=relaxed/simple;
	bh=566pGj/JIlarQnjQku7K9YiHj6xZhXg/CQfHU+iJ6cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhmLyQiZcidGgnzPzFCBsOZAq68QjqHqAzuyvwZY48o8xHV5B2zymmdwj/UGypY/tqRBNpOmYOi6ooQSuyl+whFtDiQYpHdFYhaqQIUfAL1yv+uT8gVvFRP9qcD2fibL0j2JPrq4QPxeiTcdaty1U7gYmCxomWsFXDX4i0pLlEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8xYTChI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8xYTChI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso817555a91.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788509189; x=1789113989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLEldnOCQedCUETCWprtecBudZpW3CKJjf9frld/ASI=;
        b=k8xYTChI64+l3BJLKiJ51OZEBJDYq2aqGmNL+YeFmkvFwKrl5jMs0h1LFBfrwkg4mZ
         o+DRr9+BBBKKsJG1WyGFthddkwQOaifqPidMXPvyc3t3gUvTlCG0nDbBUtFKtf0gHhDY
         Pyijrz2MOOg8bVhssx9s9HBTfccCUEZa6e5lRtpZ6VSbGEzln0xcvzAKIZQyuvQIIuGS
         I+4MKk/366/VEzYIMzZTBy3q4hNK34pgUTMIc/gs0DYdudmsY55Lvk2Qh4HUlQzRyj/f
         h2VSl8MFOzRYTyCyk6cgdTM97ZK9uXKBakkalxCTC0U5uWo6zEiUGqYcFwx8ns9yiXzp
         i1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509189; x=1789113989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLEldnOCQedCUETCWprtecBudZpW3CKJjf9frld/ASI=;
        b=ggsr+Hrsgv6n05WY3HHQjI57u48ioZN+uM797U5MdC271+YH5G6Uj6vfRo7UDNIxUC
         XLBFpUkvaZMUTVAzEhN7z/kvKJk8jMdZ332wrY3VQfajnOEHotYyOopLwG/JKWG0N/bQ
         93IC9K8Nzck/HOR3KB+KS7AeIQksJ27+f2cD4yoMhPVynhMQeDasFjicdbjrnfzi2lUs
         PTCUFplcJYqS3KzkO6ttv16wdw3imVD6aZdL1+XSjFX/F7xKn/8Xko8ibChmWhQB4lTB
         YAnhSuG+4YmRru2UVKyU1isR3R3xjyuQYT/fpf7eGGdiypMajdvT1T7fo1N4BAmoFA8z
         burA==
X-Forwarded-Encrypted: i=1; AKwUvBzYa14AgZXGC9SvVkZwFGMMaG0be/l0PpTpqKVmyKU3Uj8XpZL0Xtw2bc7XypAGVYy/UIK8eUg=@vger.kernel.org
X-Gm-Message-State: AFuF++lAEVd/BOwjGIQPjCdYVxeX6sE9xhMOXaGkiD9uPlh7YAIfdEzn
	+VlOcCxLXRyglfGY/+Dq7fBcR81b/4Vn0Q19iTD2S2s+wGXLiEdsDtg=
X-Gm-Gg: AYBFou1nexNbOuhJDrjyFXeqw0HaiCcKOBidQkqKHMn9qgAYZm4uylqFhVCAzdl2Zz5
	XZ4Fv78YE217zoADQlz9xjrB3BMVMk8xKNqmfIzf+XFyClgeVkoZRgAKX9eJhxMYVA9JWFRxSfI
	bC7RySh0yWg5vcnEucVkEbZeawk2lkabRpR9hHFQ+vB1wBQhJ8JpiBM0xitq9YMwRIvTYEiv0r9
	mliss4v0TBd353YBga0QCxDP1OzZnfoHLwU/rB3DSkyuQre8LkZJR3MMCeKme98ot9mcEIKj691
	2iBnXBXvG92YNOOr+AQimoa1DqUoaxMMuVwSQaCrtlwmShzdLhGnYJcOGRpq3MigvQmajkPtU6D
	plOcaDQqalEJzxKbMXqhsJPElHwi+4KDWGDmaIAWqDomSDlWAaY6iegcKE471hxV5XSf3kk5Wog
	6/Ihq6ygBkAsGH7aETNvSlSUPj+6h/4Aj77pTnX1aoYHtvBOXZiSQevUm+2M3I1vgrPi6Wqp3ti
	g1EJyrNdFKzH0Rnjh5JQVseCi8=
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr6201345a91.6.1788509187124;
        Fri, 04 Sep 2026 01:06:27 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b261549f3sm3181153a91.16.2026.09.04.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:06:26 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org,
	christian.koenig@amd.com,
	tursulin@ursulin.net,
	matthew.brost@intel.com,
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mdaenzer@redhat.com,
	alessio.belle@imgtec.com,
	luigi.santivetti@imgtec.com,
	"Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a use-after-free
Date: Fri,  4 Sep 2026 17:06:16 +0900
Message-ID: <20260904080618.2098450-2-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904080618.2098450-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
drm_sched_fence ops keep a .release callback, so the fence is not
ops-detached on signalling (dma_fence_signal_timestamp_locked() only
clears ->ops for fences without .release/.wait). The callback therefore
stays reachable on a long-signalled, userspace-held finished fence and
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
(VM_BIND) are still affected in mainline, so fix it in the core to cover
any per-context-scheduler driver at once.

Cache the scheduler's name pointer in the fence at init time, while the
scheduler is guaranteed alive, and return the cached value from
get_timeline_name() without dereferencing fence->sched. The timeline name
is not guaranteed by the contract to outlive the scheduler, so document in
struct drm_sched_init_args that the @name passed to drm_sched_init() must
follow the dma-fence safe access rules and outlive any exported fence.
Every in-tree driver passes a string literal, which satisfies this;
commit 299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
keeps drm/xe's dynamically-allocated name alive across the RCU grace and
can be simplified on top of this.

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
Cc: stable@vger.kernel.org # we don't know since when
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 24 +++++++++++++++++++++++-
 include/drm/gpu_scheduler.h             | 18 +++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..b2a842a1c9ba 100644
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
@@ -180,6 +186,14 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
 		dma_fence_set_deadline(parent, deadline);
 }
 
+/*
+ * TODO: Both fences implement .release, so dma_fence keeps their ops attached
+ * after signalling. Dropping the callbacks would let dma_fence detach the ops,
+ * after which neither get_timeline_name() nor get_driver_name() can run against
+ * a freed scheduler or an unloaded module - the complete fix. It first requires
+ * auditing every to_drm_sched_fence() caller, since ops-detach makes the helper
+ * return NULL for a signalled fence. See Documentation/gpu/todo.rst.
+ */
 static const struct dma_fence_ops drm_sched_fence_ops_scheduled = {
 	.get_driver_name = drm_sched_fence_get_driver_name,
 	.get_timeline_name = drm_sched_fence_get_timeline_name,
@@ -228,6 +242,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
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

