Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414530;
	b=hzJcGt8JHouwLv6jW3eHi9E4IabsRRqlOepGU3/Nm8mQYwURsmbsGSDzsw8NgqNYPZ+a
	 dvjfzJrAdi5+gArmxyEx5zDOLv/NLyq8qB082fA2OhHrnkT80hCFuOQ9JHRS1VyKQlZYr
	 GeNUgi/mBVOf4TjJCATyAKdaJ5b4f8+WrKDRWSY/wOfxX1KzWIfcQLgS2vLcpTFACrW9R
	 QnGlnfttr+MEIhxV7zQlgwWkeVvKmlCa0Ckf7Arwr+7+FNIoK6E2F8mDPx8biFMOaahZM
	 bo/G8CfL160sgomNIyl1ZeT/7ydSOfqyQATn580ND2jRdOsRE+RX0723Psx2k5Gfrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NdmV1kyGt5F5R+ciWfbYycq4p7UHIAsfEORxrUphXSQ=;
	b=THSUhycp7nhpXAOcmJqXotWAqXTyWzlybYTAtQwBTAYGaVqDuKorMpFVHgALG3NGMhh1
	 mh9DMJPT9IAVtccA4xgEHnGgu61JaL85cM33fJkSGf6uu+prfqLA77KjZSkXr0Ys4CI5Z
	 aZCnLOvsMPrIvJIOTRqUlztPy1bI5ElCmVA3CU2JiuV+2maKc5vUK7TudGV2YGJ3m7fEX
	 uZrTdn/AK01PMKT5d0Y0pH0h4o9mf1t9DYP6iUzAdQho+S/j1ReUZfUnDvAkNdRjJPou3
	 gyrvYhj1ir7m5SRus69wvTG2RObW40znWFDv3JBHZK5EVdaBmESih9QjpDl3a3Onclg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPTrSB5m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E760A380E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPTrSB5m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532731F00A08;
	Wed, 11 Nov 2026 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414529;
	bh=NdmV1kyGt5F5R+ciWfbYycq4p7UHIAsfEORxrUphXSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPTrSB5mFDH7rqzTyawz9rPtLREaFAqnCpf+68o3Q/u/e3+np2D6qcqHR138uLC+Q
	 26Xgqbq/xNKbIdrSWrxxxqS+oEihieiyNFL+hTMZ0i3hA3ya8V2/oM/Sz+Jyom+6SZ
	 Ye8PB7EFCUsnw846eq5nd0r16pgHe00WbBmajkPUd52F2ZCFLwvIbieY+Y+2F6CPEC
	 uevg2vBafM+L45RtEbPtC6loVEG2uqEF24sLZzyQ7qefjgUki73BgMBAw6EkVjiE7B
	 kaX93iBhDhf6/q77SwhAJxMFSoTkbMNRFrbtEWW70mO2vHI4N29ULFAyU5knRh7um3
	 TSZxBxqb5Pemg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hung-Jui Lin <alex.lin.programmer@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
Date: Wed, 11 Nov 2026 11:28:48 -0500
Message-ID: <20261111162829.3280831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053924-failed-6.6-141a27750ec3@kernel.org>
References: <20261107053924-failed-6.6-141a27750ec3@kernel.org>
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
[ sashal: adapted timer state handling to use the it_active flag instead of it_status constants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 7534069f60333..ffaf5f6c8eb40 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -648,16 +648,8 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
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
@@ -894,7 +886,15 @@ int common_timer_set(struct k_itimer *timr, int flags,
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

