Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575762;
	b=fLF7ZrB8F6XbugmUYncsuGeHP7PyxEiJgZlQSl81izMq/EdVEwdoEZkox788fmWqCEj+
	 XxZWP558ENKl3VRSKKGDJfJ8JTNGMM4iYngIxo4Is8HGgaih4cu7xoqPbpdEo9Rqizdlt
	 IxUR1NUa6QIJx2VGjBGckA3okXeUphipwpUXbiQ1H6Bti5+6SMJVihdm6tyZPQ0AgV4tY
	 7ZYktwX0zMW+8XTU8NXogkJuCqKOxMx6NrpWjKSBCH6dT3VtOM5VL9HIhSoleQ+VriQA6
	 SiegQrwDwxMclfS+UCH3Abs3xMGSPNJ52Z7ro8ZWMlCImqptxf+zH+AejfupSXZp7LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575762;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nFxw9AaiafDozzb1SogZ5bKTz5V4jrrtgg7ISBPfEr8=;
	b=NowBaVSj9/IGufv0e+CYMcsuRYxrrWtuYslwOX0vAOcAyfa9nTXZZUX48TL7ZjYgPVge
	 z/JxHXv9wxO2Wao+HIdyiJGOpFekcv9ll/xwCfjgZncXtyu25kZiESLjUq0I/T1V3NSEK
	 sfs0Uivm+d7BsfSmZ92AOIJhxX3y6s8vuRH5jw076JKoRjV1jmopXwaD+tIy81KO/V2/R
	 ymMBjjZ2k11A7vgUkff9OfUkkTDDbmuUw90BzP6x3tgLoiWip+eWu7PRurs9EgKN+/Vzh
	 3rQm4QAsrtB+WQp2oFUiwLBKot77ybQYuppWnk+F7xpcR5ypaawtXOnADwaFyDreecg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GlMRPbL8;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED250606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED250606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GlMRPbL8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=nFxw9AaiafDozzb1SogZ5bKTz5V4jrrtgg7ISBPfEr8=; b=GlMRPbL8fHUWQ+R64TrQgevWFb
	9Gb0Si5M8IjzXBTd+ePCC7LpXLhSl2knayLH1LCzegj9Un3NcBRcQiVBT8yyGJvdBXgpBy4kLTUsW
	LLmp28ggU2w7AtuATkk1bm73QYfKva6mYJSpAKZitUY1UYdmwuGh7+z6k79zWDNMpOE8wqn5MdgGr
	YryN+rGXFaqdFB8wea6o7eQlR4KSgZt2YzM7PQTC8sx1EGotSRfrP9QqKrDWpbZiXAN4DTurxPVOB
	ngc1HaJh0z0o7Ciy/CLZuGB2N5oEbG1QMMKY3TdvE/su2W67DnfB3hgs7G0fVEDJmf2+boPL17S0J
	G2twCBpQ==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xJSq5-005Ueu-R5; Wed, 21 Oct 2026 11:42:29 +0200
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
Subject: [PATCH v2 1/2] drm/sched: Fix out of bounds entity priority check
Date: Wed, 21 Oct 2026 10:42:26 +0100
Message-ID: <20261021094227.48034-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
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

