Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587674;
	b=piSggT1uuIw5U7sWdfEVLY+LRaSioCq4ZYvM9RSx3d0vLHj2xfti77lnleCn+gnZdTNF
	 Pi2c4VXj1ORzfaryN9RxWdwXZvFHWpDwcgf02moI8a5w6Z7jsfOzw7Dd1LDti06tvcEJd
	 CYIm4F8cIXFvrja66LMBCQCKgcYMc/sDMWldA2Y0tigCyffRl8hu6o94MNV/Leki9F19M
	 4WBA064prS9i/aBNSeBZicisfnFhxjyTYTe+HOlMFhNyUX3ZQTkObfhMoRNnczCkpPArC
	 hdOLDrRi69OUHJtlG7dTw7vgaURVJs8024sYehbYKuQLHFQkqCsKsv3rPAFWLQ3zxvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KatTboVYHTOFS+WeUH6IR4wWb3sfCCLqcnNg5x+lxU0=;
	b=RRQSrScrpt44zrGJ0pBXT76sx8w60TWnvvYvAyv4nVQh1emIlROwPTAhLCAbUXWft2LU
	 wUVaiGTeYHpVbVi+JzQibg0D1Mbm6Oe/AsSVNNMURNHixjJuXSzdMj+pkP3tJJJCnJGS7
	 wEulsa7bC9Nu+sZN+ASacL5F30a9WgqarsgaNy2nfyuWY1Gi67DP2sk2fj5X8NocIn6BV
	 p33EijPBPlPEPT68d6CG5AP76PfLlHPxH/4TPPB/z714X68ixkYv/WWJ6BpU6MwhrNS9M
	 tN3fn/S6109NCSmstah2waa2jCUnEZvhOk96IiWcRSQssxA4LQnM1guTFbkyQX95F6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8i6Xk1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33869606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8i6Xk1V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2F61F000C6;
	Fri, 13 Nov 2026 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587674;
	bh=KatTboVYHTOFS+WeUH6IR4wWb3sfCCLqcnNg5x+lxU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8i6Xk1VZMEayo8qRWlYddeIokontwGsso1Le+lpWdBuBzRJ7fIamOSb7cXpzzaSX
	 JyBvrpflqj1xXnJ+cYAkJhWEmPsoaAJHEGx7d0hc0w84NfOJeyeTPvlaROjyTAEM0J
	 d3q+w+F5/Ec6YwouTRHxccAJzrHSdxdCGUm+OtbKZYOeNISA5ljtheLzvJwaIa6i5Y
	 eEedtq8E+HyyEty30Vvd023tDvAg415N/Z7jsKqLiEHj5FVq4M/85sjua6YLERBT0e
	 GXJQ3isNxHK+WOi/m2QlWEoUb5QDFuxyYgs7XiebKCxcqytsUiZf05gU52UjEUeSYH
	 TqqkDGSvPSc3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] sched/fair: Clear throttle state when leaving the fair class
Date: Fri, 13 Nov 2026 11:34:30 -0500
Message-ID: <20261113163420.2086653-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113163420.2086653-1-sashal@kernel.org>
References: <20261109200556-failed-6.18-c282051fc2ca@kernel.org>
 <20261113163420.2086653-1-sashal@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit c282051fc2cae2ea54770ebe435dbea090272c25 ]

Task-based CFS bandwidth throttling removes a task's fair sched_entity
while the scheduler core still considers the task queued. p->throttled
carries the fair-specific state across dequeue/enqueue operations.

DEQUEUE_CLASS removes the task from cfs_rq->throttled_limbo_list
but retains the bit. If the last finite CFS quota is disabled while
the task runs in another class, it is absent from the unthrottle walk and
the bit survives.
Returning to fair while cfs_bandwidth_used() is false then performs a real
fair enqueue with p->throttled still set.

After bandwidth is re-enabled, a class-change dequeue treats the
stale bit as limbo state and skips __dequeue_task(). p->se.on_rq therefore
remains set, and put_prev_task_fair() places the entity in the EEVDF tree
while the task moves to RT. On exit, the fair picker can select the
TASK_DEAD task. __schedule() then returns to do_task_dead(),
which hits BUG().

Keep p->throttled across migrations and group moves, but clear it on
DEQUEUE_CLASS because fair-specific state must not outlive fair-class
membership. A later return to fair uses the normal enqueue path. That path
still respects a throttled cfs_rq.

A KASAN, LOCKDEP and DEBUG_LIST v7.3 kernel reproduced the do_task_dead()
BUG in 3/3 root and 3/3 delegated uid-1000 runs with CapPrm=CapEff=0 and
RLIMIT_RTPRIO=1. The fix passed both matrices plus a 3/3 class-switch
control with bandwidth continuously enabled, without a scheduler warning,
KASAN report, lockdep splat or crash.

An AI coding assistant analyzed the state mismatch and drafted the initial
reproducer, fix candidate and this changelog. The source paths, trigger,
controls and results were rechecked against the cited revisions.

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261022235234.150957-1-4ncienth@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbc277c6963c5..a063e302fbf8e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5988,8 +5988,8 @@ static void dequeue_throttled_task(struct task_struct *p, int flags)
 	WARN_ON_ONCE(p->se.on_rq);
 	list_del_init(&p->throttle_node);
 
-	/* task blocked after throttled */
-	if (flags & DEQUEUE_SLEEP) {
+	/* Task blocked after throttling or is leaving the fair class: */
+	if (flags & (DEQUEUE_SLEEP | DEQUEUE_CLASS)) {
 		p->throttled = false;
 		return;
 	}
-- 
2.53.0

