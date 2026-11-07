Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047200;
	b=bsNwmdfAjv7YQJHZVgN6OUPGMPgFxYeXcVYZVBbJHn9YjtVAnBNSpHqS6AHIYs3hkaH2
	 TjxNJa9YfLpzxVdHkZ3kLPvFthiZfJKOA119XtY/oLD+uCvkxrt+8UgeZSFHm5Qvo45yp
	 IyJ69reQamqKpjy22DDgDdlRvmS1tj3z5IQaT2HmWbCUDG9Ip5BbnHTfwhA2IdViSmDYM
	 qhNRgBdZlZE7aM6RxJ8/zWFmfh5MYikxjQE7aCfF5ceU+dsmHjtzFBSU5wsjjWL4BXa85
	 UskL5dvK0S59BUazfJ7DEZgOE0smwebLCW6RJSvj+JXEFSFtF2n9KmtF6XkUGOsbNKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LyPut7SJKwOIxWQcGjZuy6SfBuCmlywfqnduf9RlcEw=;
	b=U1Y34fssXrBuhSNxQx6DFs0Dhqbul9tCqN9hJADR+mcQ0IcrEauKEdAHI5zqZd9j9R0n
	 0ju6lnuyV/cB1+2e67Rbg+k3e2pnQ+eB8sZHo+Mj+8w59/nO/P+zQ2LOYq6iNXhe9CDEG
	 qG35KQTbDozBvS0SOHmYLBmA0MuAoBhLQCAJpNpJSDl5wTUhyCk1xXzWbsTlg4InM353w
	 ZLNm3wj3kLgEaB533MqlmlJmfVeAnz6wzgAkKCF62NLXClX9sdQY9IPQU54M1aTiMWN67
	 AqBtRJeXvLCLCgJThBkmcta/Q7U4volSH2YxYUcTELxaEoTL6h5Qug8v2Q3nhJZ9BrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRi7JS2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRi7JS2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D405F1F0089F;
	Sat,  7 Nov 2026 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047200;
	bh=LyPut7SJKwOIxWQcGjZuy6SfBuCmlywfqnduf9RlcEw=;
	h=From:To:Cc:Subject:Date;
	b=SRi7JS2K9yqeW5RNE3DhnPridNQ3KC2iKJpQsM+ON/sGT/WiCa/usgcwCkLecE9mD
	 PZjb00DitFX/vMzhJS3XzZ5O0raGVPQpn5XrhE/IyDtiLvsrFFZOdg+K14Nn9GN6pI
	 UuhEJimg3NO0DQ0Mvm5L+E7eS7KvqFSfam1HZpQPOYZ9NMxpGCwqoTpkzV7vk23+Ss
	 qD/P+o4SnUYoIf/tgZC4tFlhowwn28Exo9PcBG4eR38KmOOhBwTbOLj13mBJdJRHN3
	 b9xETsx6MkHp0K7JQUzrBSh8zOHO7s9EvpYpQGDGzu9nK79qhvNcTNtSSw84kLx526
	 1iULECBhiowMA==
From: Sasha Levin <sashal@kernel.org>
To: alex.lin.programmer@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:38 -0500
Message-ID: <20261107052638-failed-6.12-141a27750ec3@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 141a27750ec3d91ad9d1ad1764ebb5e51b963478
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052638-failed-6.12-141a27750ec3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




