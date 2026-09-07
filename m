Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA7488236
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786369; cv=none; b=l5Spye3mVJpJH7jefaQ1g+xjjlidBClfygsjfHrZPl/nAop8+gPYdnmfEHke+NA+Kqx71fVU5JGMWCqxAD0vOd30YN+zofNFu672Hg0eLendVS7eHOEGHJcPO8Q1q8h76OiWbOzsYJuxUt/m7zLbsib44boGQ9sb3tNTU1kFTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786369; c=relaxed/simple;
	bh=FTcIXy/8yjUK0uHtWba0Pj9LpVmToY9ISAFxDONj/dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ksl2Vy1qFIn8Z9R+1IjV0GlSEJqrFZWdV4ZUcOu05+48zxPUUnImjeMiQ8UpshXiqb5pfC+T/6KpPdRDy3XULnm3mN3eSA3pkXaI6IiY7otSgI6FUcX31vMvNFpMOmgoTOx9+6isUM0GalsoyoauTwDTkxG4P6Bwm86qf75+I5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JT8qQOdb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JT8qQOdb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=85HzFkneCzZ1dwH0wwKaOKHlHuGN3L2DB0zWPxUD0q4=; b=JT8qQOdb3HL2Ke4u0ATBJBl/ZA
	GqufTxG2Wt557p2kSlHHhAgKOxhRexhj84WfpsCMnQLGisXTULMbDnkdexdARs5TojBOLOm7O1pKO
	lva9Dv5GhIajz+FFufi0UvF7gBRDDcF/j6F6TWXdmeD6cTwyLo3oNJqYWin0XEFC8kV9YHAXtz1L8
	ejW+IlrgsGuKePm/aVGnVOxmMao5OYdN5AHWBZHS/3tewHzDoSe9plr7zsSFlugKLqM6rlWftOJEn
	OQ+oez4j+44zhpdypkAWUAqIhS4iN6KNGjYuweJ09t0S0l1ZsHfBjOr67S4ynbCSlMLlQno+hTmNQ
	W5HM171Q==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x3Z2W-00G2yR-8P; Mon, 07 Sep 2026 15:05:36 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Luke.Wildhardt@proton.me,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Do not restore unsaved virtual runtime
Date: Mon,  7 Sep 2026 14:05:27 +0100
Message-ID: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prevent pushing a new job to an entity seeing it being the first in the
queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
side in drm_sched_entity_pop_job() has de-queued the job but not yet
updated the saved virtual time.

We do this by pulling the locked sections out to encompass both the queue
push/pop and corresponding rbtree management.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Suggested-by: Luke.Wildhardt@proton.me # via Claude Opus
Tested-by: Luke.Wildhardt@proton.me
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: <stable@vger.kernel.org> # v7.2+
---
 drivers/gpu/drm/scheduler/sched_entity.c |  8 +++++++-
 drivers/gpu/drm/scheduler/sched_rq.c     | 20 +++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index bf97508a45b9..e4069fcb0272 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -563,9 +563,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 	 */
 	smp_wmb();
 
+	spin_lock(&entity->lock);
 	spsc_queue_pop(&entity->job_queue);
-
 	drm_sched_rq_pop_entity(entity);
+	spin_unlock(&entity->lock);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
@@ -651,6 +652,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	 * Make sure to set the submit_ts first, to avoid a race.
 	 */
 	sched_job->submit_ts = submit_ts = ktime_get();
+
+	spin_lock(&entity->lock);
+
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
 	/* first job wakes up scheduler */
@@ -661,5 +665,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		if (sched)
 			drm_sched_wakeup(sched);
 	}
+
+	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 0464d324d98d..23f46ec610e7 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -257,19 +257,17 @@ static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 {
+	struct drm_sched_rq *rq = entity->rq;
 	struct drm_gpu_scheduler *sched;
-	struct drm_sched_rq *rq;
 
 	/* Add the entity to the run queue */
-	spin_lock(&entity->lock);
+	lockdep_assert_held(&entity->lock);
+
 	if (entity->stopped) {
-		spin_unlock(&entity->lock);
-
 		DRM_ERROR("Trying to push to a killed entity\n");
 		return NULL;
 	}
 
-	rq = entity->rq;
 	spin_lock(&rq->lock);
 	sched = rq->sched;
 
@@ -289,7 +287,6 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 	drm_sched_rq_update_fifo_locked(entity, rq, ts);
 
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 
 	return sched;
 }
@@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
  */
 void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 {
+	struct drm_sched_rq *rq = entity->rq;
 	struct drm_sched_job *next_job;
-	struct drm_sched_rq *rq;
+
+	lockdep_assert_held(&entity->lock);
+
+	spin_lock(&rq->lock);
 
 	/*
 	 * Update the entity's location in the min heap according to
 	 * the timestamp of the next job, if any.
 	 */
-	spin_lock(&entity->lock);
-	rq = entity->rq;
-	spin_lock(&rq->lock);
 	next_job = drm_sched_entity_queue_peek(entity);
 	if (next_job) {
 		ktime_t ts;
@@ -375,8 +373,8 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 			drm_sched_entity_save_vruntime(entity, min_vruntime);
 		}
 	}
+
 	spin_unlock(&rq->lock);
-	spin_unlock(&entity->lock);
 }
 
 /**
-- 
2.55.0

