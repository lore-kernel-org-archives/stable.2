Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105303;
	b=gci1n0rvbho534pTGFzWENbdjPZ5uy7IG6Sf93z2nAcDz1fteOO1O4l2rovbhWOyHNfh
	 8JSAonb+BXxzbO04Zqwyw0Fh/njeHlKx+LL6hZULeWSkESarWBSWiw0CMs0kJhapqrXRv
	 ednc+NEYz8ne3DpoRXTD5Mh8Jdgwre1Axmtn3f+fdOlIOY7rBqRYaM5+NUVVJtgu8KFuG
	 gGojHuKkxwtHioV23hlHSm5XN3lZM43P8/+qOXdyH/eS6sQ4NJ9WhYhEnXrbuxi+qFv2u
	 7eWiUNujYg/CC1Tn11EzSz0OxaINOVjTXQ8GzfsoEqsvNbTNrbhcCTIOKcyB74q4Nvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105303;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ecolJmUIVAvJpPgaxFVFIXgCSCdtlmKz+g0qabV5LGI=;
	b=pmcSk6F79YxV4PhpGIFQa24GL+KmKeCI2/CA4AZEUmDN3JDgIbWixAPtPMRHfbCqQI3I
	 iGjBuB5VRrP9/mi8bsHZkpEjeJ+5Y5L5m/FEPU3EpghKghphmkGtkCnKGti9/EQuyHKXb
	 GG0PFlmRF1q67dHK2v6lUd6Awx9PUwGUrebc9gk4/HmB+CE3Lkw/hKmksmj9iFCyPId3b
	 /QAFDqySfyANTfAPAwOdvNz1WxJaYJwINERotwHemrxU3erCQxSLiWtpZAUHi3dK6CY/3
	 cULhntWG2gtfIKFZ0onEJ5JeSmVFIxreennTuTKBN/nwbIkuWjV1E3XI3HmTqPFaIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Oo+DkpY8;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43860A261B;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E43860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Oo+DkpY8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105301;
	bh=ecolJmUIVAvJpPgaxFVFIXgCSCdtlmKz+g0qabV5LGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo+DkpY8UYYie6tJVNgIBiAikBCRpS12Km0lVuxzZhwazsQo7i0vQLpsSBMkOlfly
	 auB4igmGfQViDM9azhnhST+zMHxwstGg9ym9wPVqU8TvhXdt2nT5hiE0FBI9E1uZK4
	 Dsk5vpS38mZ3Q0cGPNNpBinG1R3cA1HXWcieUwW/lh4Jmjyj89K7SkOnTFC3+JOYZG
	 TmbUR1m0dDUM7hOFsZxuyKGUW4eH9cDgnt7DABBtu+OQSPjDa1Gdl5G5bmG9Ld+w6u
	 KAwPzhXzAJY3Xs7UFcuDDUfxzaezMvbD29IKTg6GLsUZDxsAYs3DoXi2ZSp7Le9x8a
	 f6lD4FmSaw7hg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHn1QydzRqW;
	Thu, 19 Nov 2026 11:21:41 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 11/17] sched/deadline: Release the bandwidth of a task that leaves the class asleep
Date: Thu, 19 Nov 2026 11:21:32 -0500
Message-Id: <890f50eb9b802f09440aa1a4ef17abc7bda8ca68.1795103339.git.mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE while it is not queued can keep its
bandwidth in total_bw until the next rebuild of the root domains.
Repeated, this fills total_bw up to the admission limit. Then
sched_setattr(SCHED_DEADLINE) and CPU offlining fail with EBUSY.

A task that leaves the class keeps its bandwidth until its 0-lag time.
Releasing it earlier would allow temporary overloads. For a queued task,
switched_from_dl() calls task_non_contending(). It releases the
bandwidth if the 0-lag time is past. Otherwise it arms the inactive
timer, which releases it then. For a task that is not queued,
switched_from_dl() relies on the timer armed when the task blocked.

But the timer is not always pending when the task leaves the class:
- The task blocked after its 0-lag time. The timer was not armed.
- The timer fired while the task was still in the class. It only
  removed running_bw.
- The task was woken up on another CPU and is not enqueued there yet.
  The wakeup cancelled the timer.
- The task came back to the class asleep. switched_to_dl() cancelled
  the timer.

Then nothing releases total_bw.

Fix this in switched_from_dl(). For a task that is not queued and has
no timer pending, call task_non_contending(), as for a queued task. It
arms the timer if the 0-lag time is ahead. Otherwise it releases the
bandwidth now and clears the parameters, as inactive_task_timer() does.

Clearing the parameters keeps later paths from releasing the bandwidth
again:
- A timer handler that already started finds a dl_bw of 0.
- The deboost of a later priority inheritance boost finds no
  parameters.

An owner that the task boosts as a waiter can find the parameters
cleared too. "sched/deadline: Do not replenish a boost from cleared
parameters" handles this, so a backport needs it first. Without it, the
owner's CPU can lock up as soon as the waiter leaves the class.

Before this patch, a task that left the class asleep kept its
parameters. That hid a bug of the rtmutex chain walk. The walk can stop
before the end of a chain. An owner then keeps as its donor a deadline
waiter that left the class. With this patch, the parameters of that
donor are cleared. Until the owner unlocks, each refill gives it no
runtime and a deadline of about now. This is the bail-out of
"sched/deadline: Do not replenish a boost from cleared parameters".
Other deadline tasks keep their bandwidth, but run late. Real-time and
fair tasks on that CPU could starve. The pi_chain_top_moves case of a
later series has the steps. With this patch, the case fails in every
run. It passes on v7.4-rc2. Two rtmutex fixes of that series make it
pass with this patch.

Juri Lelli's first fix, since dropped from tip, released the bandwidth
here without clearing dl_bw. The bandwidth of a boosted task was then
released twice.

Juri Lelli suggested the call to task_non_contending() in review.

The Sashiko AI review of this series found the two cases with the 0-lag
time ahead. deadline_switch_test, added later in this series, tests
the release in asleep_round_trip.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Reported-by: Tejun Heo <tj@kernel.org>
Closes: https://lore.kernel.org/all/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761fe005b4@redhat.com/
---
 kernel/sched/deadline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5e4aff28e9bc..bdeb2ecc9255 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3620,6 +3620,14 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 		if (p->dl.dl_non_contending)
 			sub_running_bw(&p->dl, &rq->dl);
 		sub_rq_bw(&p->dl, &rq->dl);
+		/*
+		 * Without an armed timer, nothing releases total_bw. Do as for
+		 * a queued task: arm the timer if the 0-lag time is ahead, or
+		 * release the bandwidth and clear the parameters now. Call
+		 * task_non_contending() after sub_rq_bw(), which needs dl_bw.
+		 */
+		if (!p->dl.dl_non_contending)
+			task_non_contending(&p->dl, false);
 	}
 
 	/*
-- 
2.47.3

