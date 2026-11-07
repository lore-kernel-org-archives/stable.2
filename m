Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047966;
	b=zMA/3WUftCj8qRo+gSMtlhz0rlW+aOJe2Vs7/ILDYq7jPHr6M5CehRhypKMP1n9JnnX9
	 XifM10p4CASHKi+C3m4lApB+bFyIL32ycxAfMXHh/qcA4umCefncDIgtFEYfjeyVDp2CD
	 XH0nql6IJm7EPl1aaSI9VrTD7BmxVWwXNzSTgdGrVcsOq+gVyvbSw7p9iLAL2Od5vZlWd
	 J4wLzc2A2+mziXXKNwejsc7R7iIpQyzRZx/Iep8udC4/iy0+TuQit86CZAHRO/uROM9bH
	 ZgvNTrrKKoKN37q12zjGRD8TORW6X0OynZVqXfPyagJmzyB5wkkyXrfZwG1FGZLIHZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gum5sO/WCb5FYxqPGHUcqvWqeacKeYKuNuco6Jf67EU=;
	b=GAQXeTFlsK2dAnkjnKlHr1zPkFykikdqFnWQH6jgOaQP+9VzsojLl2uW/3ZsaGtpnWII
	 28SixPs+MzSlyR4rjCAAEYHkuiBRrdHmAKeTS/Co2nXnU0mpZhl+3cg1D62v3QMsXKtc8
	 ip967Z8bsv98SO8JLV9NbkVBUBwFkqbcvpkdMgoMIMuY6k4JOTzepiO7X6ALEcTSjk22G
	 z99rSVHaOP2PKTIw7exT/Pzon3SLDavBaq/7czlRmJQzuaYua57WNBHWquYFirPP/PowR
	 6yqRWnRRhFoowgF9xZbZBRqltl2REFvYsnMoKEAzq3Aj/gGryz+eWPO5o6kNmuR1RNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjVyqPdv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjVyqPdv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72D81F0089F;
	Sat,  7 Nov 2026 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047966;
	bh=Gum5sO/WCb5FYxqPGHUcqvWqeacKeYKuNuco6Jf67EU=;
	h=From:To:Cc:Subject:Date;
	b=SjVyqPdvMA34gvtKXYOzuFyVmEid6IIRpj2hETB7F1z8M9R74SDRFi8v43WV6T4Vt
	 EpSGIMZA391pYHL/YNgNTT7vOQ6iq4J1ThNgmWy7ix4hSXJeSM8qLex4+qb9rLCSPl
	 qseQlSpB1QqcglLhrFxE9nhFlbOyyZISBPCOoOis7Xvw65VT78jWC4glqGIpmD+3OU
	 JXXM8HeGpHCzygOSpDRWgzHo0XWCodWY+UCjDmTk+DDOmcYw6B21fUM6/xV2JirobR
	 umO5oXljiYXyG9xqG2pV/IFEUFrBvz5nVMOvaWAzOQgw8jBTGEzCntqDCLiW6BdzM7
	 ZrT9FezV/c8ww==
From: Sasha Levin <sashal@kernel.org>
To: alex.lin.programmer@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:24 -0500
Message-ID: <20261107053924-failed-6.6-141a27750ec3@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 141a27750ec3d91ad9d1ad1764ebb5e51b963478
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053924-failed-6.6-141a27750ec3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




