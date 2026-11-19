Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105302;
	b=bE5AhO92FHwLEMVR+7qUXC/nfU0BuyovbBkBEh0F8G1t/fg5LsorwLQWYPXoq4qZC0No
	 +e//btgdU5whuR6G8xSSwPn2G1y7TqSaLnKbVHkCrGR4GLBja7CwskhKxVWB9/mQkBSCI
	 iuseC+mp7AojfQnsv8LkicyzYMFP/bGC3aECh4oqH6CCAPAbn0uncgV2C3jc/7wFG55RO
	 oT5/GiINSOauTikx/nlFHa0IHQuIp1O8K6kcIIJOqsmB34yRXPWZOKHOeNkzpFjJD8C1m
	 ps91TyK8oH8I+Miugg636ZzaZcjHrJfvQeZwH/l21Sp9fOdHUvEhqDfLs+vy5XaJfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105302;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ax5wFK1/QAbEDyO/3UGGlfePRTUbY1SVXNP1qt/Fk88=;
	b=FSnIMmm0CB7ZwOQtEWgA55IGK/2QU0JqGN6xCHWEl5IGbooTMjwjrelZV7XhGALiuppf
	 Wlcm2U+YCHIP+K7s5O3I1ekvPmR8oJKANJOX8BCdCdIwnBnd7bukYUumgyQ1RXGtG8eBi
	 vVEob2KLNLAc269dWL5K0ZoEXLgClPcuJYbPuvG+Im9jR0G974nioyUZ4UsIiACuTDYE4
	 5B1+zVAdEbxo7ihwhaz6D+TUPioaebg0w3CrX2Lx5avXWAbLpEYu75zlMrpaNyExRkGfU
	 iGZCmdbpUSrgpiRUZAtGqPSTF32zrMvKMfBmSYIN5/TfUPtUQUUyxUGjtjPdTnjFW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=r35La4Rj;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202A60A2613;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7202A60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=r35La4Rj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105301;
	bh=Ax5wFK1/QAbEDyO/3UGGlfePRTUbY1SVXNP1qt/Fk88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r35La4Rjn79+onCoeAN2r3AjZS+svx6bFCeB/ULnhmfX7cnfHo2J9+uO80lpGAKLx
	 Vj3CcZt9QHj+2YCFxJswsyayjB8Ccj0dZJUlaue7yPwxO+x6embWixUPcttiqJ5KmA
	 VihoSzTV4JAQN2DMI5fqdjhojpf9SbkVQ4h6EUl2FiL5w64yx2pvOyPH2H7MSSsMmX
	 SvI118MHHMvSn5rZ0RUQbCZUStTv5+A8I6GZACboGg40s9kJla8VeMZi7XZ8ig7/09
	 3z+QIlE+l8wm58igJQIJnTNdT8nfmspc75llOPad65K4TvveC5HIuM0zTwBynp+QBf
	 wt9p85jeFjwwQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHn0hKqzRqV;
	Thu, 19 Nov 2026 11:21:41 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 10/17] sched/deadline: Fix an overflow of the 0-lag time with long periods
Date: Thu, 19 Nov 2026 11:21:31 -0500
Message-Id: <abbad2aa0ec392b1b0ede00b66b2d177d2b7b2df.1795103339.git.mathieu.desnoyers@efficios.com>
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

When a deadline task blocks, task_non_contending() computes its 0-lag
time:

  zerolag_time = deadline - runtime * dl_period / dl_runtime

A task that ran at its reserved bandwidth would use up its runtime left
at that time. Until then, the task still counts in running_bw. A task
that leaves SCHED_DEADLINE also keeps its bandwidth in total_bw until
then. This comes from commit 209a0cbda7a0 ("sched/deadline: Improve the
tracking of active utilization"), which adds the inactive timer of the
GRUB algorithm.

The product runtime * dl_period is computed on 64 bits, then divided as
an s64 by div64_long(). With a period of 4s, it passes S64_MAX once the
runtime left is above 2.3s. The default limit on the period is about
4.2s, so no sysctl change is needed. The quotient is then negative, and
the 0-lag time lands after the deadline.

On 32-bit, div64_long() also truncates dl_runtime to an s32. A
dl_runtime above about 2.1s then gives a wrong 0-lag time too. If root
raises the period limit, a dl_runtime that is a multiple of 2^32 ns
would divide by zero. This was found by reading.

The bandwidth is then released seconds late. Until then, the root domain
refuses deadline tasks that would fit. In an x86-64 guest, a task took a
reservation of 3.1s every 4s, then went back to SCHED_OTHER at once.
Another task asking for the same reservation got EBUSY for 5.95s.

Fix this by multiplying on 128 bits with mul_u64_u64_div_u64(). Its
operands are unsigned. So take the magnitude of the runtime, which is
negative after an overrun, and add or subtract the result. With the fix,
the second task got its reservation at once.

The quotient must still fit in 64 bits. On x86-64, mul_u64_u64_div_u64()
traps with a divide error otherwise. After a change of parameters, the
runtime and the deadline stay those of the old parameters until the
next period. The 0-lag time uses the new dl_runtime and dl_period. So
the runtime left can be far above dl_runtime. For example, root can
raise the period limit and give a task 150s every 300s. The task can
then shrink its runtime to 1024ns. Before the division, compare the
runtime left with the runtime that the parameters give until the
deadline. If it is larger, the 0-lag time has passed, and the bandwidth
is released at once. Otherwise, the quotient is at most the time to the
deadline.

The params_switched_asleep and params_shrunk_long_period cases of
deadline_bw_test, added later in this series, test this second part.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d6d2657dcddd..5e4aff28e9bc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -411,7 +411,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct rq *rq = rq_of_dl_se(dl_se);
 	struct dl_rq *dl_rq = &rq->dl;
-	s64 zerolag_time;
+	s64 zerolag_time, left;
 
 	/*
 	 * If this is a non-deadline task that has been boosted,
@@ -425,15 +425,40 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 
 	WARN_ON(dl_se->dl_non_contending);
 
-	zerolag_time = dl_se->deadline -
-		 div64_long((dl_se->runtime * dl_se->dl_period),
-			dl_se->dl_runtime);
-
 	/*
-	 * Using relative times instead of the absolute "0-lag time"
-	 * allows to simplify the code
+	 * The 0-lag time is the deadline minus the runtime left, scaled by
+	 * dl_period / dl_runtime. The product of the runtime and dl_period
+	 * can overflow s64 with periods of a few seconds, so multiply on 128
+	 * bits. Compute the 0-lag time relative to now.
+	 *
+	 * After a change of parameters, the runtime and the deadline stay
+	 * those of the old parameters until the next period. The 0-lag time
+	 * uses the new dl_runtime and dl_period. The runtime left can then be
+	 * far above dl_runtime, and the quotient too large for 64 bits. So
+	 * first compare the runtime left with the runtime that the new
+	 * parameters give until the deadline:
+	 *
+	 *   (deadline - now) * dl_runtime / dl_period
+	 *
+	 * If it is larger, the 0-lag time has passed, and the bandwidth is
+	 * released now.
+	 *
+	 * The runtime is negative after an overrun. The next tick throttles
+	 * the task, so the overrun is short and its quotient fits.
 	 */
-	zerolag_time -= rq_clock(rq);
+	left = dl_se->deadline - rq_clock(rq);
+	if (dl_se->runtime < 0)
+		zerolag_time = left +
+			mul_u64_u64_div_u64(-dl_se->runtime, dl_se->dl_period,
+					    dl_se->dl_runtime);
+	else if (left < 0 ||
+		 dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
+						      dl_se->dl_period))
+		zerolag_time = -1;
+	else
+		zerolag_time = left -
+			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
+					    dl_se->dl_runtime);
 
 	/*
 	 * If the "0-lag time" already passed, decrease the active
-- 
2.47.3

