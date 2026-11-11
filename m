Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415895;
	b=J9nIlz06iQcziwjWqReVcjs4u8e4EwTLYQRBGHP+DbcDvZ/ZoaXBkY9Giy6O/wM24KPH
	 JuISqK1uzu7sWsqSPB/0MFGNeAxeSopJ2N0tn46QL8ZTSqe+xbZIy+UVcQc0E3e/Ji0Yk
	 Q0eykTdpoUFUYq7STksGPqwLMt9guCqmIx3h7Lzq53w4SXTM9zrJROBmYbn0VahanOgnJ
	 tpDh02EJxOGl+LKm2RRAoY090OJAUGXqErzx7ieArFAaai4AGQR792sWnSgBcnrp4Y2mS
	 RX0RWJKcloH8Pn9kNzYyGnTkadgnWBszneHz4SbpVd2EtaJidcMmoZdLLp4OHDT1aVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C9pcx1fHpOz5nBgicIlLlPF1WY/0ltx2cYcEdCmBUsY=;
	b=fB4Nm4+rpVIEbhbfqg5Qcpfecet81FbZ1biPsX/QIQR0s7cDxjwKiLUUV1Tel7GmRNVi
	 yvcFJf5hAVXKxRqTGhi4ZGrwsN3KrBSx9tTNiflcxKzee2M1AFuITjgs2n2bcNQCHkB11
	 RdqZH3FOTIW7xwuE7nZ6B0hmzg0kmHypRNNSnpy7ktjuLLoVvrQV/sWZJsIbdVmiOCopJ
	 SaIlNYEjIwPfhQjO7kghLKEslBP0WbV5eGPfeh1AZxcrmkLaqaXj3SeFOV+nLFlHtgzU8
	 dV5PCYNVnSS5xsDmkNXsO3zWzGZW5jQixmB3CrI3TJjQRFYx1bdaNE/vSL8MJ7+pDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwaXhrdA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2B606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwaXhrdA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714771F00A05;
	Wed, 11 Nov 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415894;
	bh=C9pcx1fHpOz5nBgicIlLlPF1WY/0ltx2cYcEdCmBUsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwaXhrdAdf6BbrS0a4tgAU27ihXunDKpfMIT6W1bBZVoH4mzEM8PfNqSt1fyLhUdT
	 tFX0winpME9r0K91lPsLF9+9yafncbuPTxz0Up9dgtrQSvE43QKcRP84e8ok3UK/zo
	 sz0KlUEKzoROMKMUb6BkpcSWsFgDA94ynfcAoHqHxRUMINLU9TfgTQbHYpBnQUTAwl
	 1qaCiJbQlitJ/ZSPJoyKFGh+dWGJZI3uOx+Y4K9wRkuux5bQ+R2Y6+f8kQ3aR131NC
	 6ReB0Rd2ZzRGtgckcPcvGv2xJKF30QBEhHi2YPRnzJiblyhZVhSW1pQ+Tb6imrfB8d
	 xms68uasDc9wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hung-Jui Lin <alex.lin.programmer@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers
Date: Wed, 11 Nov 2026 11:51:33 -0500
Message-ID: <20261111165103.3363896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061201-failed-5.15-141a27750ec3@kernel.org>
References: <20261107061201-failed-5.15-141a27750ec3@kernel.org>
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
[ sashal: adapted it_status state handling to the it_active flag ]
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

