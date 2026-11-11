Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413101;
	b=YxYIs3D3odq2thwKzDJPOS6GN/SSycsWtSvZvTp6jt0ON4cNEs7mumdDEGIImH+dDQv4
	 dqPU0FEX7Dx4iMQEkboKB/KCuonHr5zR4eupQ3kz4Ap2cSMyoSwP8kBmLQxnd6tfjs/Wu
	 xXaCNWpC9klWiOB4WF9RDcXfIc0eiXekpULss5L4VCyFoerCF9owpwaqLpjv51fwS7Ul1
	 zBjcq/K6PLXgR+1Rw/XTCgta4D5B2b1hff9aiCFL5qLl8h8mEK2ctzFblWFB7KkUu5Bjy
	 4/LhBqCE064MUmkwTxz3RNC88bJmp2My79kjXHsZiMPk90h+PZvTuYi+GlXXfF3Ihpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XIdGflJshFROwAkwtRtLA4SHc/Nm3hnyzRnbREQSpuM=;
	b=baHPVsfhMkEhpMpbproU+5ewnN0qO0Zs3pMAuBWxWERvxljXquzN6uTLBag/kkZE79l9
	 BgXmc6J//ASvdCM0n23PqRzjxcXJu9+qj89fCCEisofxmd3bOJgjcxKNShzFDd5fvkt/1
	 uTSU9I0pjTa8U/6eoc06WURDpeWMgUdB/kKN49PMMaOddo4KKeytHVjGW352PgM+k+ZYl
	 KWqweBHSCgYpGdE31qPuOUVWvXUIG6eRjsSGfznO3VJ97K1Yc+7FVxdNjNivQ/JkXbjIB
	 DpIjodLUkLMwMQAzBEGYwe+TFSMwzvYOoC7wjAFOeWN3WI3uHuCKFmKi7D3Jg9p/CwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPLkzNSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2D606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPLkzNSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6731F00A05;
	Wed, 11 Nov 2026 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413101;
	bh=XIdGflJshFROwAkwtRtLA4SHc/Nm3hnyzRnbREQSpuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPLkzNSqO8wmbzePcdHwWz/0bIZdDEfNQcSZEEyxJQ4EGTJ3wzkwM8MDzwvkQvNhB
	 dhY6FYrbdfBkcNYvdEZFuCwNH7oZabDqyB4HYbnlvfjcSt+TD0u2jpDovLvzTP/ptE
	 +BWdrBp11PKzsv9kt/jyX9/9xvKRZiWP5Sfr3GiboEZnSVXcZSY9vitinlpKRAyCpX
	 +zEgBEjqqpdCCOTbqVB744q2tWDXqh7HvYF2Or4OWBMjQgx2csVIYgWh7ImK82lc3a
	 O0zd1mYpc5ncodTJ4ZuzYWV1GlWQcp2lKDF6jxNoC/fhaRiuSfweJ9MIdk7ZVZ7umC
	 bApXPcfCSPuKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] posix-timers: Handle the timer_[re]arm() return value
Date: Wed, 11 Nov 2026 11:04:58 -0500
Message-ID: <20261111160411.2760021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051445-failed-6.18-141a27750ec3@kernel.org>
References: <20261107051445-failed-6.18-141a27750ec3@kernel.org>
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

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit cfb7fe3fdd4ca1d37da1ed15a1897d4a27c47a8a ]

The [re]arm callbacks will return true when the timer was queued and false
if it was already expired at enqueue time.

In both cases the call sites can trivially queue the signal right there,
when the timer was already expired. That avoids a full round trip through
the hrtimer interrupt.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260408114952.198028466@kernel.org
Stable-dep-of: 141a27750ec3 ("posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 3082129d836c2..3d39f77423afb 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -306,6 +306,8 @@ static bool common_hrtimer_rearm(struct k_itimer *timr)
 
 static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_itimer *timr)
 {
+	bool queued;
+
 	guard(spinlock)(&timr->it_lock);
 
 	/*
@@ -319,12 +321,18 @@ static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct k_it
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
 		return true;
 
-	timr->kclock->timer_rearm(timr);
-	timr->it_status = POSIX_TIMER_ARMED;
+	/* timer_rearm() updates timr::it_overrun */
+	queued = timr->kclock->timer_rearm(timr);
+
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1LL;
 	++timr->it_signal_seq;
 	info->si_overrun = timer_overrun_to_int(timr);
+
+	if (queued)
+		timr->it_status = POSIX_TIMER_ARMED;
+	else
+		posix_timer_queue_signal(timr);
 	return true;
 }
 
@@ -912,9 +920,13 @@ int common_timer_set(struct k_itimer *timr, int flags,
 		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
-	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	if (!sigev_none)
-		timr->it_status = POSIX_TIMER_ARMED;
+	if (kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none)) {
+		if (!sigev_none)
+			timr->it_status = POSIX_TIMER_ARMED;
+	} else {
+		/* Timer was already expired, queue the signal */
+		posix_timer_queue_signal(timr);
+	}
 	return 0;
 }
 
-- 
2.53.0

