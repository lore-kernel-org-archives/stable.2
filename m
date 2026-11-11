Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413919;
	b=mchQkBHt+h/bGcDtDhh9b480tzsIr15zD55kJIJ6m2EEsx10RaIUyTMXRliVp6xIQYDL
	 gZrHkOLfIDc6LZZ5YeGJXG/7DVoQuIQWHneI1IfQ+Bnj7k5Msso2WNhZa5cMY0V+b9mY9
	 GkdWP1ZoQnofGRo9YZHueWE/Q7MZTu0cY9KDtjNIxIrAZg7FK5jpLvDyC3kiY6ShXgYAZ
	 zHu2zTgxeucSjuh+r1y18KI73wfacMSi8F33//Qx38E6q9F4RzA48NJVaAImpFH7xpvYu
	 sVF5NZrjrMGmG2+GiJ/zrc3oIgV7p2Vb9IfTsT5Baqw+aQwUKtqnzC85Ttxh6/ZvtOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=paS6kO+igYd5rlcbgVNspmjd0pQAlqGoqxF0Haxxop8=;
	b=GKNIvDp32tArN502y+tDEZMEF3VQOx12O0ijpfQu8VwQ7jimfCkCO+KEel/+Hv/BoC6s
	 0ZyqX3y1M72j8CwPeNK4UQ55AGRz22YLKiysq2C6cMPQWHbAE/Qcqkua9NvJ9T9gjlQDT
	 9dEt6DV3pt4z368nyj0lQLNulV5UhZLqlOIRMFrZxkAuIX+QjLDLqXnoBOlz7J9/tR17W
	 +o3kkoC8DGZepGUYgLwMbgdN6NU4I5oh/LRS4vGsGxr1Zz1Be3dXCv9AhB671HY1saYK0
	 niWfqIp+scJFqhTxlouZkC8pXPu+j+TpOW42r1N5qLAngz26KURAKLZTza2n9ZetzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9fzDE4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E836606A8AF
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9fzDE4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EC1F00A08;
	Wed, 11 Nov 2026 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413918;
	bh=paS6kO+igYd5rlcbgVNspmjd0pQAlqGoqxF0Haxxop8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9fzDE4Uzxo4q7skr8wPU7Cye2VsOFKEsjgUnIbkSp/ex0Ec/ilNtAluMhG7GZeA3
	 cvQWWrIXqIj/MYAk9stp9M48bUiyVmAHLcOGJxAeGsR7LY2R/GXfo0HM4GpALA8XW7
	 dK/lJcKwx+Dta4VjdK9Xvt1sftPCipiCCyYE3Xt+U5257W+kh/7ZtdU1CnIQT0wol0
	 bBfafyqev1wq2xxP3wOr3m/XP/nHoqQ7B8oSK6hz/N7PZK4Q83DwLb6PhC6GQpQ4Bf
	 agmwOGiZJm+fR/BfgDZQvS8bLNVZtb/YdK4mahtbUnRpKoWiUtYIRr738uPWs9uADT
	 ldf4zZnnV0vrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hung-Jui Lin <alex.lin.programmer@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
Date: Wed, 11 Nov 2026 11:18:36 -0500
Message-ID: <20261111161818.3251664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052638-failed-6.12-141a27750ec3@kernel.org>
References: <20261107052638-failed-6.12-141a27750ec3@kernel.org>
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
[ sashal: adapted timer state tracking from it_status to it_active using the existing void timer_arm() callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index c5d9bfbb082b8..1e7f01c3daaa0 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -656,16 +656,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	if (iv) {
 		cur_setting->it_interval = ktime_to_timespec64(iv);
 	} else if (!timr->it_active) {
-		/*
-		 * SIGEV_NONE oneshot timers are never queued and therefore
-		 * timr->it_active is always false. The check below
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
@@ -916,7 +908,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	timr->it_active = !sigev_none;
+	/*
+	 * SIGEV_NONE timers are not queued, but mark them armed
+	 * so that common_timer_get() can tell them apart from
+	 * disarmed timers. An expired SIGEV_NONE timer stays
+	 * armed, which is harmless: common_timer_get() reports
+	 * zero remaining time for it and it never reaches the
+	 * signal delivery code.
+	 */
+	timr->it_active = 1;
 	return 0;
 }
 
-- 
2.53.0

