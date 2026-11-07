Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050942;
	b=bmkhJDJdrao99AM8ypr/6smHTyl/IC7izDJC/+VUl9Sga3MN8UfrLPhM45EjBcecYx2/
	 YTBROF2OmvSSq2gtBDNn7HxDPRweDFdK3qoST2jGf99SOhXr+a2PKmWvzz5/noQuwnlP3
	 WnsnSc5R7UNOGHt6W8gOnqgl8QfBNF5UggMz9Km8+vc2paWCmf1fLUU118bNRo7JXj9/l
	 xEN/cNHhBLAbbYE6exOoKpiggMV9EVusGSxJMi2OUeZkIM1z4wgBR5NlmD66PmsK/Xi7B
	 gN7d5ELFPorbQyF/ecYnL3lAiJvPFvDz5LWFOXJA52f6mpbV5WAp1dSiTTOlh/b9BCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yrp1hkZt0eLold7prReumXZBppBmzAsL0qfHhee7lFA=;
	b=kr4zkGAlOXPeKscIdST19QUGresjSG4JXTewC6l/gCkpeduWuoK4sKplQrsKR7GerEzA
	 028LqPr4/uaeGBGa9D8AYujFRa9zjJ9fKk1nTksGxdd/cgl3S6Hg+9zWtePMWtorS2AwK
	 ZIB6EtU+kmCbpOtaKkbF5Z99dP1yGF3JeMB2BKW4czjadwckFg3myhdHP8buN+zgAfvUv
	 CP50fhZ2cUdKi1DYdNoI9/8NVO9Mh8ElIkueRIADXeehshTOXy6pLgBVVuOJ82qZ4G59x
	 pfV05RthxouZ1QrxosEYamnW3Q25Vc3m76I/18Ij+ohDo3vGFcxcHNdfBgDopYMvgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fs72fuoP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EAB606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fs72fuoP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850711F0089F;
	Sat,  7 Nov 2026 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050942;
	bh=yrp1hkZt0eLold7prReumXZBppBmzAsL0qfHhee7lFA=;
	h=From:To:Cc:Subject:Date;
	b=fs72fuoP5dYCW0a6MaF2W+qVCbclVlPkUelq6KPGC3HIfgBSPx8f+LMQYdospv/Xp
	 xUD2ezG1aCudyN3OqL98AVQ3t1qSmnWKnz6QaeJTbtWqjDjBcdycx5yR9DPfL4N+Mo
	 rPH9ZeRDC6d2jLS7mkk0Ms7Pi2AOprILsNx3CVutlOT24YSAJMXFoj6dun08EmAP7O
	 oT2Xc3t5ZoXtuwhnElio/HVXPKEPuOMQ2wnvnDH2+QczHvv++3YxPvsZN/PU3EPONW
	 L1dtzs6MjGUfEOZC2QRAWkOH96rz6S9W9BEL1MJHQN6EhJOuUMq6SSwKzRDW0za0MK
	 XP47R/49M6XFg==
From: Sasha Levin <sashal@kernel.org>
To: alex.lin.programmer@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:00 -0500
Message-ID: <20261107062900-failed-5.10-141a27750ec3@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 141a27750ec3d91ad9d1ad1764ebb5e51b963478
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062900-failed-5.10-141a27750ec3@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 141a27750ec3d91ad9d1ad1764ebb5e51b963478 Mon Sep 17 00:00:00 2001
From: Hung-Jui Lin <alex.lin.programmer@gmail.com>
Date: Fri, 23 Oct 2026 23:14:10 +0800
Subject: [PATCH] posix-timers: Report zero remaining time for disarmed
 SIGEV_NONE timers

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
---
 kernel/time/posix-timers.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 436ba794cc0b5..4c80c2dada9d3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -694,16 +694,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
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
@@ -713,7 +705,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && timr->it_status != POSIX_TIMER_ARMED)
+	if (iv && (sig_none || timr->it_status != POSIX_TIMER_ARMED))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -915,8 +907,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
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




