Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964859;
	b=HDwePDRsyz2LVcMOeSNL7ytfgyS40a3zJepDAebNz2WZIjILg9arw6WSTEYtYR6yGTuH
	 RRlGFN0p301hUKgH4w6cW4QrBsG3L3IdlteixaiARvtY0+9tkSsbnsLxTzStK/pLg0trj
	 C73vUambLZCUlHVmBSoDCspeNT8qLj4gqZg1PA6qTe7HuskojZaLK5ciML9gng89KmyiG
	 gDJQgXRgGS9vIDj4tkg6R8JJKNcMbizxWYI+O/y7xsmASE/T72LwV8/Nmc9n/Kvlt9TTs
	 UoHXgeQEhg0+9mw2PRuPd4ubBe88TLuFUmULsdwcXMSKaChDSIvWB+W2D6DmV+npeSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964859;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Po+P3UQ08D9N3DsXVmM/mspqswp3zgG3zZTFpOBu4BY=;
	b=TjP5ACsxdOgu58HXMwpATtnRBPP56F03JUqTuLfjR/yfO5kuouVLyBLtzF1wHEY5o/nw
	 BqZWK2xIlk0vAgFDrhL3wG65fKa5hfwJi79NMLxQXBayX0FCRu+4GjhVnSMmCdyPkay8l
	 0SB3nOF5EygChOi4HXM6U68G/87uU8wxTkXT8feZK5qNXh72Z4IAlRAWHuFR78YBXVcIg
	 lhh1UlEcNV3OHToSW23dD/bfiLxj8O7D/nb1I/wKc5rUFuxmu0531yyTa5EuMw8bAapJj
	 31Tg+A5t1K4KgMbr23hx0Z3edUz3cdQ5ZCsrKcMPW+zVqWgLjCTDbhjA+TYS+qBHkjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VZ0aoyDN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=OP+Y954I;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023E606A32A;
	Sun, 25 Oct 2026 21:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F023E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VZ0aoyDN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=OP+Y954I
Date: Sun, 25 Oct 2026 21:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792964835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po+P3UQ08D9N3DsXVmM/mspqswp3zgG3zZTFpOBu4BY=;
	b=VZ0aoyDN8zdzwlWuneebqDI8JPJtZb7fsYmLCnufbsAWqYk3JtiP+ZRHKCeP68yQsoziky
	+4dNzlBvh/km3PESvWkun1GXg1ht0v36aG2Kd5mfJRYIIJgICWrB55CQjBPpLGzZBv6sGn
	Qiy+nM7XahAi9TEAf1xNeMZs9NUt9nVAnyqU/GZANOULIjlpg4DeKwMOSpiJ7GlkzlT/xj
	48uG6gZKKrWG+QvakRywLmGUk9WZSI5kMsb2GQ3t3M/Gtx+f7v4pu39v/LGSG8fYxQOuHO
	FUyQOG3w+yggaMbSxkt9AY6ColauJMDdk9hGF/+nCrDXX7ZgQG6PB7oIYq06/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792964835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po+P3UQ08D9N3DsXVmM/mspqswp3zgG3zZTFpOBu4BY=;
	b=OP+Y954IKYZxbeXrQ3OCpm2txcHLw0gAwgTVZPqgzoGyZofyR4kv3Pj/7aYSecLw8MhwgR
	H8dWfam/5BN23/AA==
From: "tip-bot2 for Hung-Jui Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-timers: Report zero remaining time for
 disarmed SIGEV_NONE timers
Cc: "Hung-Jui Lin" <alex.lin.programmer@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261023151411.28685-1-alex.lin.programmer@gmail.com>
References: <20261023151411.28685-1-alex.lin.programmer@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179296483384.4109677.7753345893123552623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     141a27750ec3d91ad9d1ad1764ebb5e51b963478
Gitweb:        https://git.kernel.org/tip/141a27750ec3d91ad9d1ad1764ebb5e51b9=
63478
Author:        Hung-Jui Lin <alex.lin.programmer@gmail.com>
AuthorDate:    Fri, 23 Oct 2026 23:14:10 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 25 Oct 2026 22:43:19 +01:00

posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers

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
with a CLOCK_MONOTONIC timer armed with it_value =3D 10ms and it_interval =3D
100ms, then disarmed with an all-zero itimerspec:

  armed:    it_value =3D 0.009999000  it_interval =3D 0.100000000
  disarmed: it_value =3D 0.008700792  it_interval =3D 0.000000000

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
Link: https://patch.msgid.link/20261023151411.28685-1-alex.lin.programmer@gma=
il.com
---
 kernel/time/posix-timers.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 436ba79..4c80c2d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -694,16 +694,8 @@ void common_timer_get(struct k_itimer *timr, struct itim=
erspec64 *cur_setting)
 	if (iv) {
 		cur_setting->it_interval =3D ktime_to_timespec64(iv);
 	} else if (timr->it_status =3D=3D POSIX_TIMER_DISARMED) {
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
=20
 	now =3D kc->clock_get_ktime(timr->it_clock);
@@ -713,7 +705,7 @@ void common_timer_get(struct k_itimer *timr, struct itime=
rspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && timr->it_status !=3D POSIX_TIMER_ARMED)
+	if (iv && (sig_none || timr->it_status !=3D POSIX_TIMER_ARMED))
 		timr->it_overrun +=3D kc->timer_forward(timr, now);
=20
 	remaining =3D kc->timer_remaining(timr, now);
@@ -915,8 +907,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none =3D timr->it_sigev_notify =3D=3D SIGEV_NONE;
=20
 	if (kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none)) {
-		if (!sigev_none)
-			timr->it_status =3D POSIX_TIMER_ARMED;
+		/*
+		 * SIGEV_NONE timers are not queued, but mark them armed
+		 * so that common_timer_get() can tell them apart from
+		 * disarmed timers. An expired SIGEV_NONE timer stays
+		 * armed, which is harmless: common_timer_get() reports
+		 * zero remaining time for it and it never reaches the
+		 * signal delivery code.
+		 */
+		timr->it_status =3D POSIX_TIMER_ARMED;
 	} else {
 		/* Timer was already expired, queue the signal */
 		posix_timer_queue_signal(timr);
