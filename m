Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09E846AA6C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945201; cv=none; b=qMSDiS7VfeSC8Cfdr7WRAGr3k/7PZtOHBFp/ss59xLsEYKZ2uJy6AnL0WX1Ug+nRk/h6nBhMhzZaAbdXQpHArudF6NiV9Nhx6Ixr7ToyDq4szsEBQe+eBXyT0+hE/351CszSQGOBXjw2/K9x8Svd2cvQUwQW+Fl5lwFMkSyPOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945201; c=relaxed/simple;
	bh=dpQ7sXuBfEYAO0HjvF6fhea1EYkGoOu4n3X/Wm7YYrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEj/pI1qvgCE9Rj3qQ1BI5N7298umT5996ME+BDzBze4qMgljMTw6cfDyeCEWgTCMTythIIFdJhNd1WxHYsgzYmbuac7FPLMpN73A8Zw+NjdPGw1wiybWCSQTlkUcTYixn3ZshvFZb26f6UIwm8JV0trmxbudYsBXQ1zNtDgH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FCbTc2vZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FCbTc2vZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=9dF54tKEr/G9cdNYBClqpJLRpoMx/nXC3p6bg34WrDs=; b=FCbTc2vZ6ChmDNAlnF//J9B2Dg
	+Z6LAs/4s9VS7srU3belNRf/6wy8YXLdLEv7QVgWv3iNn/xmAL7LJvR2+YeWEBOHu8YPepZR4HLvU
	P4hpZezUtkabKEoGyrPmS3/FGfQa0yh+Pl/Wh7FfzrSPVH2x9UdS9g6k5asd50mZJX0Uhy6WQvww6
	bWmsXDK05cojgFBTglq65bS1uKKxVX+2cd99wnscclfFSxbnP3c1O6cHwdeSLpXul+nXqpGlcY7dY
	rcgtK0JtS8JVho7Rp2BKyRUHEJWBFCG69L5POYOYlT2TG10sgLVU5MZBkwjEWT0iWyz2f1HY9GyWV
	+U0gBj7Q==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xCceg-00AbRi-Vo; Fri, 02 Oct 2026 14:46:27 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Fix out of bounds entity priority check
Date: Fri,  2 Oct 2026 13:46:22 +0100
Message-ID: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the out of range priority at entity init time is clamped to the
number of run queues in the supplied scheduler the internal run-queue
priority needs to be adjusted as well.

There is no impact since none of the drivers hit the clamping path, but
we still need to address it by moving the entity->rq_priority assignment
to after the clamping is done.

Note that a lot of this will hopefully get removed once again when the
single run-queue simplification lands.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 27 +++++++++++-------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 7be0387bac3c..e12709b7bd0c 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -130,10 +130,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 
 	INIT_LIST_HEAD(&entity->list);
 	entity->guilty = guilty;
-	entity->priority = priority;
 	entity->last_user = current->group_leader;
-	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
-			      DRM_SCHED_PRIORITY_KERNEL : priority;
 	entity->num_sched_list = num_sched_list;
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RB_CLEAR_NODE(&entity->rb_tree_node);
@@ -144,25 +141,25 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 		 * not to do this and to fix their DRM calling order.
 		 */
 		pr_warn("%s: called with uninitialized scheduler\n", __func__);
-	} else {
-		enum drm_sched_priority p = entity->priority;
-
+	} else if (priority >= sched_list[0]->num_user_rqs) {
 		/*
 		 * The "priority" of an entity cannot exceed the number of
 		 * run-queues of a scheduler. Protect against num_rqs being 0,
 		 * by converting to signed. Choose the lowest priority
 		 * available.
 		 */
-		if (p >= sched_list[0]->num_user_rqs) {
-			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
-				p, sched_list[0]->num_user_rqs);
-			p = max_t(s32,
-				  (s32)sched_list[0]->num_user_rqs - 1,
-				  (s32)DRM_SCHED_PRIORITY_KERNEL);
-			entity->priority = p;
-		}
+		dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
+			priority, sched_list[0]->num_user_rqs);
+		priority = max_t(s32,
+				 (s32)sched_list[0]->num_user_rqs - 1,
+				 (s32)DRM_SCHED_PRIORITY_KERNEL);
+	}
+
+	entity->priority = priority;
+	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
+			      DRM_SCHED_PRIORITY_KERNEL : priority;
+	if (sched_list[0]->sched_rq)
 		entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
-	}
 
 	init_completion(&entity->entity_idle);
 
-- 
2.55.0

