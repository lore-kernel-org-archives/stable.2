Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415666;
	b=F+U+dzTzuqH1+df7n5+A+0GZKEor+m/zyQsXiRKT5yK3q/jzQDTwAqzyxTazMzKKz10/
	 BkxyuHuwvYZ3x6GtDO9tziITgR16liLbXvqWTzZS7N/zHprWgeXm62fxgiLIqUGViTm04
	 Jj1JiCyVhS06uI6iMuwzzYLSvEqNLZChW0bYCtnfotE8Fvp6yg4z9dzaBaTOKCwxsP/EK
	 gMTTDaLmZq2J5VVB9q1Av74piusnrvQ/br+vy5O5ly8zXLrvOKPnwPd3UlnW3jNICVzme
	 sz0h1yUZWy1Yn+A8+PdDixE9M85Ag/+QJjymXzl+mCwjVVXgiWpN9rv2w0gjVCrq3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J3tpifRijT4+pk7e2hNJcEEFVR4m4Uqn25qM1IhLC4U=;
	b=AVMByA4er7JRoEbs7CYaaFtJGMrH0pcorUzvPA0e7zTGmfoXTSj2z6okNDxDAFkGoYrx
	 ElQWukZbclhWweCDKKURhNMqeLv4tb/9XbJtv2WElqmOI0bKOntUfd0S+z9yS5UycaDJt
	 z6oDDQQ1YKebp3eVOpz1z2vGkTHSWlf75RY10LbLCfW0xUmRjqTJVcr9Cfk2Lz2qwGU9m
	 7tjhBU9RQvuIIX+LquBeCqjMpQRqUykLWSD9lyDUOSboH12ZMDeqOXo0vLgoGgbUZyVXe
	 oZaGhYBiAQ0qJwR9yV4At/0iBe1FEJxBlOUGCg2b0f9gOkoej2twa/pta3l0T4sTnjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jq9QCUb6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C5606A88E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jq9QCUb6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EF01F00A0C;
	Wed, 11 Nov 2026 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415666;
	bh=J3tpifRijT4+pk7e2hNJcEEFVR4m4Uqn25qM1IhLC4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jq9QCUb6jlJA851gnLI25IT549uDAfAXyY7+OVkialmRoCsjPd3GHv3L7coTt8JAD
	 cm/eHAuw9JbKGo3zBRj5gcoW0+ok7I7GF/+YZIzOKg3/Xl62hRuLJW32j2sUjDEH9A
	 HSSLRyNFnDTIovwoIgXwpRKJrN5waic4jvg5vA7WvK3duIzzZ0M/Ou9XSjaepp+a6f
	 38ujFHDNJE/V8kJRKzh/3y+avqx0hVMBV8G6Y7OOPBVbjPs2rmlWXQz8hIjPxS1kby
	 yZewNu6McT+vH1eKZG9FAAghJpEOMBDe3anqWdYezD5MRiBMj2EyT7zPY2H9kIV79D
	 Bbou2Tq2ShssA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hung-Jui Lin <alex.lin.programmer@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
Date: Wed, 11 Nov 2026 11:47:44 -0500
Message-ID: <20261111164724.3309939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055507-failed-6.1-141a27750ec3@kernel.org>
References: <20261107055507-failed-6.1-141a27750ec3@kernel.org>
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
[ sashal: adapted it_status-based state handling to it_active around the void-returning timer_arm() callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fc08d4ccdeeb9..23683372ddcb1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -686,12 +686,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	if (iv) {
 		cur_setting->it_interval = ktime_to_timespec64(iv);
 	} else if (!timr->it_active) {
-		/*
-		 * SIGEV_NONE oneshot timers are never queued. Check them
-		 * below.
-		 */
-		if (!sig_none)
-			return;
+		/* Nothing to update for a disarmed timer */
+		return;
 	}
 
 	now = kc->clock_get_ktime(timr->it_clock);
@@ -901,7 +897,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
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

