Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510902;
	b=wZA/kp5KuBu0FBFtawvqIQMLkcEGJLWLSDVv2whdvbpF/DSB2kDEanzMuN8cpCGtgKZo
	 MyX5rJNr/D5aAaFUlE4gdzVoSkCxKwFbPlZTQT/gj7AWUWgvjtnUB5QcMw9MKUbMLUbqU
	 xVnHMN5X7i43K1pgonoJku1eoX/IXi2u3lBFsdgcpwAI7Mq4KMIa2LN0BU4LpzNHyoa7J
	 5EQAwCRBEp8T9NAU+JuWKBhCuT+k+oGl+EFMSzZPP5rAnoxLNRs6EDm4KTqnr4+zAQB4a
	 boCXTT43GQ+apWVbRe1vVcPGuJUIxqIUkrTb3ZDS0vpBog0vHDfP9k+Do8NogACKHgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510902;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nFxw9AaiafDozzb1SogZ5bKTz5V4jrrtgg7ISBPfEr8=;
	b=4+J2Pz+5eBbX0obkL9ufNbMF05plrPnYNaH6Cv+XrwgduNsS7coyJwI4bUI+J7BH5cUs
	 GURYVQzDVL3lRlseT8e82QGWUe6xWALw5qN/j+HaKfPkrDUvHP7vLuIANE2N18ouNNfA1
	 ILHg/ZfMdnG1zDCBit6FVYAl0//4LBjUAk7PCinuYks43bPC0osEnDNdwG5Qj30tyKYwl
	 1PYMGAKboSe4B96koMAOj+rpiFJ76klH9fkdPOlylNoBXitaopk80Afh5c+skvyO6surq
	 fWbJK+8K7dYEl4YtpPQPz3IwXQGniD7cl6Zgpv65/rRKloaXlS3ebnXQWmy01stS6QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=osjvVZKs;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809760A2603
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5809760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=osjvVZKs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=nFxw9AaiafDozzb1SogZ5bKTz5V4jrrtgg7ISBPfEr8=; b=osjvVZKsN7OQpHeyJx5G0Owd8T
	eJXdLZj85/JKWrqQEdQXyovAVisoYuSbPbBKTM6weCXEKlQh7AE3mLpB4VKHaPu8RBuNGikkZLxhy
	8Ls0THR+nBYeKMLIdZDhH8XKKNi0SO0fzjgaD8HvnnqgsuRvu6VOHI1fNb8qA9qI1OygtEPX23XfJ
	hRFhnpTAjSZA2yqvMer7+4QWYgZCxxD669q4gg5urvFEq8AW/oluOaqzNM7EJFtIu3I9Ja4t6SGz+
	f5rsAmla2PjnJmvqVgncyNEO408ya8SYCISDiQ7+PuWmQL8pEL5GmdARYos5XBlgRK+j8KVw/mWra
	mxBlH8kw==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xJBxu-004idZ-DO; Tue, 20 Oct 2026 17:41:26 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] drm/sched: Fix out of bounds entity priority check
Date: Tue, 20 Oct 2026 16:41:16 +0100
Message-ID: <20261020154123.33631-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
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
2.56.0

