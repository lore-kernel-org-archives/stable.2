Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413102;
	b=IQaI49LyeU4oq7vgg44Sy9tKrgd7R1ZGGP71GvR+lp+QSkoLYNSIFv6rew8rcOL8OWA9
	 yBtguOCtHOMfindeksOTP/ikAPglhbr1mUj0nOid2SbBk5UBpgKBb39mI+CeDNqM0olTv
	 nQuyZtuA0PoCtCJgJct1HwfbcKd9abQ8L0JiKzI8HyXzekAm4ufLybJvdbHjZFOeMvq+7
	 ziOPUH0fZYtKpw/Xh+E146aWjMhUGdWEB2XK1IIPa4S4JwLquOzDRgS0c63fB9sT9XjQn
	 pfEAhB1EyRst+1856AYEYLAY4nr1JEiizX8Qga603rf7ToBQ+uzLQiNoBeM3Pxr/Byg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tY+gAG6uyudpvGydGU4X4gEOwEnBEDcQaO9Aar5mGTM=;
	b=xOygr4Ke8F0owIoOfcuI4d/Ple4IaZQ/Xv9lAu+IlzcORejm+BZvELh9Cc5wxra0S8ZE
	 7g6OpWyWo07YXG+PQm83vwsfzkLYVh7uoi8h5idX0NKkNjOY+sMqUIuHpMh33QxK6G6hU
	 J8alruLmAnKXaYwvvmN2cqSG1ndvVj3iW9k6nFsJtmQVIqM7PO+vGPcbEnrKY+yq0Aak9
	 BqYZt7wwjcCOpMYFz9/wYKgEfjjCDN4uNRleerKnDKNJgonjWajXKwbWPHVJnCdLXtp+1
	 AtZroq2tJKqFBUS3e1R+tQPyDsKLUXew1fmi8oXjO1vb04wCX9+fWs8aI0qcNym5a3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cd8cP1Y6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06804606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cd8cP1Y6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259A1F00A09;
	Wed, 11 Nov 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413101;
	bh=tY+gAG6uyudpvGydGU4X4gEOwEnBEDcQaO9Aar5mGTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cd8cP1Y62sRH5gefsCSI4Qe8gWmJuKMV7U5QUFuQH1Qt+SEcyeXDgKS7fMa4nPRqu
	 fKP3/eABK0CN9bQ6Kveq5pOdI42u3Nt8GFXeyLagidI0g0kez3WNrtKUlxIOqDxwTO
	 ERqdgkqXP77gep4FXSZfg3K7TvJxWNjYn0Jec0zXCrivYCuRwOVX4ixsLYIYLF5BHY
	 0BpwmGg3Ko1T943dyBuEfG/sOubQmVkyidBIW/vUDI6piWhFNTjBMAIji9qiNya7kS
	 yhSMld7JbPTLCCZ2ymdGir96HHKDC/kbtzF5QhFDgG4YGVa/MdpCxZhaaqpG1DIe0U
	 mnf89vnPeEaAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hung-Jui Lin <alex.lin.programmer@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
Date: Wed, 11 Nov 2026 11:04:59 -0500
Message-ID: <20261111160411.2760021-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160411.2760021-1-sashal@kernel.org>
References: <20261107051445-failed-6.18-141a27750ec3@kernel.org>
 <20261111160411.2760021-1-sashal@kernel.org>
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

From: Hung-Jui Lin <alex.lin.programmer@gmail.com>

[ Upstream commit 141a27750ec3d91ad9d1ad1764ebb5e51b963478 ]

SIGEV_NONE timers are never queued. common_timer_get() emulates their
expiry by computing the remaining time from the stored expiry value.
Because an armed SIGEV_NONE oneshot timer is not queued, its it_status
stays POSIX_TIMER_DISARMED. So common_timer_get() cannot use it_status to
skip a disarmed SIGEV_NONE timer and evaluates the stored expiry value for
all SIGEV_NONE timers.

Disarming a timer with timer_settime() and a zero it_value cancels the
timer and sets it_status to POSIX_TIMER_DISARMED, but leaves the expiry
value unchanged. As a consequence, timer_gettime() on a disarmed SIGEV_NONE
timer reports the remaining time of the previous arming until that time has
passed, instead of zero as POSIX requires for a disarmed timer. Example
with a CLOCK_MONOTONIC timer armed with it_value = 10ms and it_interval =
100ms, then disarmed with an all-zero itimerspec:

  armed:    it_value = 0.009999000  it_interval = 0.100000000
  disarmed: it_value = 0.008700792  it_interval = 0.000000000

SIGEV_SIGNAL timers and SIGEV_NONE CPU timers report zero in the same
situation. All clocks which use common_timer_get() are affected, including
the alarm timer clocks.

Mark SIGEV_NONE timers as POSIX_TIMER_ARMED when they are armed, so that
common_timer_get() returns early for every disarmed timer. Forward
SIGEV_NONE interval timers in common_timer_get() regardless of it_status,
as they are never queued and therefore never forwarded by the expiry code.

After the change the disarmed timer above reports zero. Armed SIGEV_NONE
oneshot and interval timers on CLOCK_MONOTONIC, CLOCK_REALTIME,
CLOCK_BOOTTIME and CLOCK_BOOTTIME_ALARM still report their remaining time,
and the posix_timers selftest passes.

Fixes: becf8b5d00f4 ("[PATCH] hrtimer: convert posix timers completely")
Signed-off-by: Hung-Jui Lin <alex.lin.programmer@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023151411.28685-1-alex.lin.programmer@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 3d39f77423afb..03bf012fae539 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -702,16 +702,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	if (iv) {
 		cur_setting->it_interval = ktime_to_timespec64(iv);
 	} else if (timr->it_status == POSIX_TIMER_DISARMED) {
-		/*
-		 * SIGEV_NONE oneshot timers are never queued and therefore
-		 * timr->it_status is always DISARMED. The check below
-		 * vs. remaining time will handle this case.
-		 *
-		 * For all other timers there is nothing to update here, so
-		 * return.
-		 */
-		if (!sig_none)
-			return;
+		/* Nothing to update for a disarmed timer */
+		return;
 	}
 
 	now = kc->clock_get_ktime(timr->it_clock);
@@ -721,7 +713,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && timr->it_status != POSIX_TIMER_ARMED)
+	if (iv && (sig_none || timr->it_status != POSIX_TIMER_ARMED))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -921,8 +913,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	if (kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none)) {
-		if (!sigev_none)
-			timr->it_status = POSIX_TIMER_ARMED;
+		/*
+		 * SIGEV_NONE timers are not queued, but mark them armed
+		 * so that common_timer_get() can tell them apart from
+		 * disarmed timers. An expired SIGEV_NONE timer stays
+		 * armed, which is harmless: common_timer_get() reports
+		 * zero remaining time for it and it never reaches the
+		 * signal delivery code.
+		 */
+		timr->it_status = POSIX_TIMER_ARMED;
 	} else {
 		/* Timer was already expired, queue the signal */
 		posix_timer_queue_signal(timr);
-- 
2.53.0

