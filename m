Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105302;
	b=JH92hNZbOD/7Ms0LLSnpOhoOcFTTY0ZCb3p6ZwQPsO7VrAx9s8ehfLRPLKrVpPlzG2VX
	 QUoHomKZ6eUrmJhTbz7zUGjO12eMPqqcoh7Wvygv+0fIiJtihZl1ICspM8D0DD74q0hWV
	 lLRrDD3BzjYElhM6+MPXGEBLVard3ug2mWbPOtzEuwy4aYiHEzzgeBNiLzRkhGOkcpeym
	 c2OafD+2UiCwd+IKO0ICdwOFoJA3EpQoe2zPGf31Q9Y8On9Djue1Cy0FnAJgoOVMxjcht
	 MjYxCE8i3hCV0HlFRScRmvdKWwTXaKhVKAkhsVePEGGfgHbDUNJyrTtTmZ7FokoMHlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105302;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/0vNi3WzQ0meDFvL7gP2Mj945lYjPQyLZhg0rrA4/Ew=;
	b=mlTtlTkqHn5AfMsqdpoPIidEs4yCoMOFHARAyKilAQ6+bfdyCN1JfberbQNK61tHw2Vn
	 iPH6HFk9xbtPePLbbdfimHrYWXUGFBRPEK3eLb92NSarwMgx25hT/+W0LTeiNLYghSfkM
	 DsBJ15QXmeCVotP2Eu2T/nkFAUq+NJz/1ZBrEjSuEoZwN9a9XnXVHCbp1Hl00c+BTo+z1
	 o82zrSbmNrQWKAa2G1OIC1+ZhrQFXnyExYDaRTlqqV/DCV3SaPRAvBkzHvZh2pVE6jDt+
	 9w7zAbQdAqHeazXbMablRn27/dyTZdavemne++2joPvIbv8RZfTT8gURzQuWOaDApAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=BJDCKv+a;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE63606A325;
	Thu, 19 Nov 2026 16:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE63606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=BJDCKv+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105300;
	bh=/0vNi3WzQ0meDFvL7gP2Mj945lYjPQyLZhg0rrA4/Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJDCKv+awM5ru/0tZTIQpTqxGAvfyaqTjN/LMI5Ds2ciPTHAavoLtZepRwG5O4Cz/
	 Qtm2dIWN2pJvp6bSgZYkXymNjqFwIm8OIFXbK0sGBFL0R5RSjjdrpoY0UwQs/49kVr
	 Cc2dH03IkX9nV0oNqTu5QaiPLF6yxCjCghJKYkJoYe5un7+5Ex37LKJZr50MRNveQT
	 6TmRl9AHcIvJPzplCucCXcFyZc9P3ZUaBJ6XoqsDUKipSvU2pDLL+NZ9fftW+pYtWh
	 HYe8MUdqK/RhhEYMrBwc81hFFRVcWgwNKdJ+B7dRtpdytlYdKwjrpb3LYV5T3n51YM
	 UUP4f8+BSUvtQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHm0rFKzSF2;
	Thu, 19 Nov 2026 11:21:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/17] sched: Refuse SCHED_FLAG_KEEP_PARAMS that would change the policy or the class
Date: Thu, 19 Nov 2026 11:21:22 -0500
Message-Id: <ba41e54ddc52f13b1889c204220882fb79e9099d.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

A sched_setattr() request with SCHED_FLAG_KEEP_PARAMS can ask for
another policy. __sched_setscheduler() then applies only half of the
change, and returns 0:
- SCHED_OTHER to SCHED_BATCH leaves the policy as it was.
- SCHED_DEADLINE to SCHED_OTHER sets DEQUEUE_CLASS. switched_from_dl()
  then runs on a task that stays in the class. It would release
  bandwidth the task still uses.
- SCHED_DEADLINE on a task of another policy reserves bandwidth in
  sched_dl_overflow(). The task keeps its policy and a dl_bw of 0, so
  nothing releases that bandwidth. For a task boosted into the deadline
  class, it is not even a class change.

SCHED_FLAG_KEEP_PARAMS came with utilization clamping. With
SCHED_FLAG_KEEP_POLICY, it lets sched_setattr() change only the clamps
of a task. So __sched_setscheduler() skips __setscheduler_params(),
which sets p->policy, and the sched_class assignment. Nothing checks
that the request keeps the policy.

In testing on v7.4-rc2, a deadline waiter boosted a SCHED_OTHER mutex
owner with a 40ms slice. One such call on the owner left 0.4 CPU in
total_bw, until the next rebuild of the root domains.

Fix this by refusing a request for another policy or class with
EINVAL. Move sched_dl_overflow() after it, as the last check. Nothing
gives back the bandwidth it reserves. A refused request also leaves
sched_reset_on_fork alone.

With this patch, that call is refused and total_bw does not change. The
params_keep_boosted case of deadline_bw_test, added later in this
series, tests it.

Juri Lelli found the class change, from a report by Tejun Heo. The
Sashiko AI review of this series found the policy change and the boosted
case.

Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-3-dd761fe005b4@redhat.com/
---
 kernel/sched/syscalls.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0ec401af80d1..89b0d5787f45 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -647,17 +647,6 @@ int __sched_setscheduler(struct task_struct *p,
 		goto recheck;
 	}
 
-	/*
-	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
-	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
-	 * is available.
-	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		retval = -EBUSY;
-		goto unlock;
-	}
-
-	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
 	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
@@ -677,9 +666,38 @@ int __sched_setscheduler(struct task_struct *p,
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(policy, newprio);
 
+	/*
+	 * With SCHED_FLAG_KEEP_PARAMS, the change below skips
+	 * __setscheduler_params() and the sched_class assignment. The
+	 * policy and the class stay as they are. Refuse a request for
+	 * another policy or class, rather than carry out half of it.
+	 *
+	 * The class depends on the priority, which priority inheritance
+	 * can raise. It also depends on whether a BPF scheduler is in
+	 * charge. So test the class too, not only the policy.
+	 */
+	if ((attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    (policy != p->policy || prev_class != next_class)) {
+		retval = -EINVAL;
+		goto unlock;
+	}
+
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
+	/*
+	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
+	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
+	 * is available. Keep this check last. If a later check failed,
+	 * nothing would give back the bandwidth it reserves.
+	 */
+	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+		retval = -EBUSY;
+		goto unlock;
+	}
+
+	p->sched_reset_on_fork = reset_on_fork;
+
 	scx_prepare_setscheduler(p, policy);
 
 	scoped_guard (sched_change, p, queue_flags) {
-- 
2.47.3

