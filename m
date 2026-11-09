Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240483;
	b=brb9brN1uoW9K+DoNmoqPlsXnJr8VNMuOYPQvw2kR8gkrvhYxc/amT//v3iDylhjrdJ3
	 OUM0oLrToqCAY0jbkWg1rcZskJTma2SFHufackJ//RPPMieWqL2vTSwDipdtIDLxJObYz
	 RkgdKn4gq9ccNo78bAePZqzJAZC84AysXiPKaSySI7jHphrPhFI5rVn4iWqzsJgcW1dN9
	 DpRvxTtq27q9jIcHFOye58fhMOPKb05jXwz2lMSN43Z57rfpBLAqNCYpPxKSzd9lxPrL1
	 YdwJmtwQ2heOGAbHsVvvPoPVaQhiu534ZgWuu+wM6ODY00B9xSfccxb2tPvkwNi70VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240483;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z1QALcT9YcY855Aj6PsigUBHSBfEix7sXDBjfUwG7Cs=;
	b=XDe9/yZJmQbeNA9jNXvNwkYNviPB8NquXhrEVQxeRbbV96dKUiKnl3rObh3Spj6ebnVQ
	 x7kRefY71J+PcUTb3D0jmZtDMKsWfIAY5Walzp1aQxdsq4eT523Fl08xu1+naFDoTiZBI
	 MJG5HfN0y4bJ6wGVjYDDz0mqouDTlSEJROePNiVxNAEXixw56uITAGvPgQpY+lLV8IPoC
	 krwP/Cslk6hheNs2vfRDnuOCOBWAMqU5C9QqFLv0uN+ecw7nyTD0/Cxqk7BdwytiP/2db
	 Ok6qbFWOsBGgVSUwrxBMNNrSBBMguDPTf3AzinTvpI4MHLBQ5b2OKoW7WywHqIw+kJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=B6yRv5I3;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D080606A331
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D080606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=B6yRv5I3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=z1QALcT9YcY855Aj6PsigUBHSBfEix7sXDBjfUwG7Cs=; t=1794240482; x=2109600482; 
	b=B6yRv5I3kUYEWXcHZMgNHFfLMEfnipd8hQtvHsX5+5eG4ZVI0YFX3vFIoE+5UYVvqEo3OeVHIDZ
	5gb0hGjhTVpgWNq4LCofgwM32WhVHmfhcP2D3a6Ff6YubrbQLywELMleRwPaMV2Mg3jhOiqU64rTI
	aYvjDCjqU/2xnlQdeQlMxFSPQ3UnESPGiJEaC0k0eCMxli69VUuYYPKUIIhJusHX0vtHv2Q9IUTHJ
	TRxHeFMfOqO+atgitKKzjBJDczBFn8d4TzKNy9bEMfNcPj+VjQhOKgorli3w8e1+12ZV4VJ8miJQK
	FjZhmoEiKRxjCZ8Y4D8wUDX7nlDuBAnT2aqA==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xQRuL-007QWE-Pi; Mon, 09 Nov 2026 17:07:45 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Ensure stopped entity cannot be re-added to the run-queue
Date: Mon,  9 Nov 2026 16:07:43 +0000
Message-ID: <20261109160743.17020-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
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

When entities are torn down in drm_sched_entity_kill() a multi-step
process is undertaken to synchronize with a drm_sched_run_job_work()
consuming jobs from the same entity.

First the entity is marked as stopped and removed from the run-queue,
with both the entity and run-queue lock correctly taken. The process then
waits for the entity idle via the completion after which point it assumes
it is the only accessor to the entity in question.

What can happen however in drm_sched_run_job_work() if there are at least
two outstanding runnable jobs on an entity, is that
drm_sched_entity_pop_job() can re-add it to the run-queue due the
unconditial add to the rbtree via drm_sched_rq_update_fifo_locked().

What is required is that the teardown starts after the run job has
selected the entity and that it gets to it's completion waiting stage
before the run job goes to dequeue a job, and for the run job to be able
to de-queue a job before teardown has consumed too many.

Run job will then see there is another job pending (after the one about
to be de-queued) and it will re-add the entity to the run-queue. Run job
will then signal the completion and entity teardown will proceed
incorrectly thinking it's removal of the entity was final.

End result is a pointer to an entity about to be freed dangling forever in
the rbtree.

  drm_sched_run_job_work()	drm_sched_entity_kill()
    drm_sched_select_entity
				  stops and removes entity
				  wait_for_completion
    drm_sched_entity_pop_job
	-> re-adds to run-queue due more jobs
    complete_all
				  drm_sched_entity_queue_pop
				  ... fini entity ...
    drm_sched_run_job_queue
    drm_sched_select_entity - UAF

This race existed ever since the FIFO policy was first added.

Lets mirror the guard from drm_sched_rq_add_entity() in
drm_sched_rq_pop_entity() and close this gap.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: https://sashiko.dev/#/patchset/20261020154123.33631-1-tvrtko.ursulin@igalia.com?part=7
Fixes: 08fb97de03aa ("drm/sched: Add FIFO sched policy to run queue")
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/scheduler/sched_rq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 23f46ec610e7..6f67a146d99c 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -345,6 +345,13 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 
 	lockdep_assert_held(&entity->lock);
 
+	/*
+	 * If entity is getting torn down via drm_sched_entity_kill() we need
+	 * to ensure it does not get re-added to the tree behind it's back.
+	 */
+	if (entity->stopped)
+		return;
+
 	spin_lock(&rq->lock);
 
 	/*
-- 
2.56.0

