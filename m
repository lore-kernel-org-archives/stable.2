Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616952;
	b=lmLsKc4eNHMBAnIK2f8+w3T6lWP89YLoDS4pJnx2EQOEuPBK/oM8itvOzRydU0C+2Hao
	 mp+P3XMcKEX5srUU0h9wP+TAdyKRQFzFpobRQmERoaxz5CJPYyDO1rIShDyBisFcVS8zY
	 23tB0qCBdqmJGSvtMwUgxbZMJJ6yEUucmJtMx3kTA2e3NvYY4OEXuxEtZ5SwkQGPcxswN
	 NOSmzw/oh7nXhZJ2I8bPMu6eaFyz57Xim3lTijQsow5F2LaPuFjF5847PxS3+HrysmkaI
	 PmQwdSA2EoS3sZ91IZ3KQFbtFShFDzLuTY0WFb/Us5+i7htDJ4kLlbO5+ezSAyCHacw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5SaCsrXgsXpO42r7jAErG/+A4HfGNPTdZRilXAMhAh4=;
	b=Z3Gkyq+fv39LJMxzyGEgRFWSm+maKx6oKnRc2wWP+zF0aw/Y6nNSnCwhxUMY+ZS4YW12
	 6+muR+CaKp5dHrFZt2/eIapd1qevYDLgnw39IsZ4Da71WPOQ6LnsPPq1i92XdpN4YW1pl
	 3mt5qiXK+I0bO4+MiDO9wHMANA5opkxsJX7+xFjs5QtWwMXb5/U9AgqeLsCkcAkd+WwwV
	 1SE3dYK2fBepS+EMTWmwTJ4WEslXXPvxtRie6J8GatlHj/PTKQ+WPmv0ZlC/fJY0DUmsq
	 qbmm9qaaH337ZsxaPoPwD7Tqg0+v+bOpCaGZcD6f5BK+2QpL/h1njR2Q8ViyntGlDzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDSZv1kA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECA606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDSZv1kA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A731F000CA;
	Wed, 25 Nov 2026 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616952;
	bh=5SaCsrXgsXpO42r7jAErG/+A4HfGNPTdZRilXAMhAh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDSZv1kAckhapqizF5iPhkL3SNRRgaj2bIKAERS2LfyUjHqkCEIBz+AphV/Ww/GPH
	 KH5exlJBbAqv9fyUIU2NAT7oigDlHvZ/KZ/sFyt2dEPFWiJ1XNvjscZSwfyJxpszEo
	 8hrbJb3vRd1KfQCDa14jR3NlNwkT7dIi1JtW6QXR/5QVafudT0hjzyC33ftAxCliI8
	 0rG95t9soC2DACzVS6HXLn37Us7OeDnCzGGV6zZbyVM7+yfSIZVom3hCw1/bGhF1hC
	 emrz7jvXQwe1BGQnRZMsPForuZ9WzapFg6qaqF9x0uYhDziyUfy2dMGuhe51Ld29gO
	 klXe88vBynHYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hungyu Lin <dennylin0707@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tsacct: Keep task begin times stable across suspend
Date: Wed, 25 Nov 2026 09:29:10 -0500
Message-ID: <20261125142849.4036088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112551-crimson-possible-5207@gregkh>
References: <2026112551-crimson-possible-5207@gregkh>
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

From: Hungyu Lin <dennylin0707@gmail.com>

[ Upstream commit c49b3c20a2d0b22700e2100a527e68e829ece7f0 ]

bacct_add_tsk() derives ac_btime and ac_btime64 by subtracting a
CLOCK_MONOTONIC elapsed duration from CLOCK_REALTIME. MONOTONIC stops
during suspend while REALTIME continues, so querying an existing task
after resume moves its reported begin time forward by the time spent
suspended.

Calculate the begin time from the wall-clock boot timestamp and the
task's CLOCK_BOOTTIME start timestamp instead. This accounts for suspend
and adds the nanoseconds before truncating to seconds. Keep ac_etime and
ac_tgetime on CLOCK_MONOTONIC and retain the existing rebasing when the
wall clock is adjusted.

The new begin time can be negative: setting CLOCK_REALTIME is bounded
by CLOCK_MONOTONIC, which excludes suspend, rather than CLOCK_BOOTTIME.
A permitted backward clock adjustment after suspend can therefore put
the task's begin time before the epoch. Clamp ac_btime64 at zero too,
instead of wrapping in the unsigned field, and retain its positive range.

Fixes: f3cef7a99469 ("[PATCH] csa: basic accounting over taskstats")
Reported-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20130611200600.GA15168@redhat.com
Link: https://lore.kernel.org/r/alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de
Link: https://patch.msgid.link/20261030054227.35453-3-dennylin0707@gmail.com
[ sashal: Dropped the now_ns variable from the u64 now_ns, delta; context line, since this tree has no such variable, and the hunk offset shifted accordingly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/tsacct.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index fd2f7a052fdd9..f9d08a7dbd17f 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,7 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 delta;
-	time64_t btime;
+	struct timespec64 btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
@@ -34,9 +34,11 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
 	/* Convert to seconds for btime (note y2106 limit) */
-	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
-	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-	stats->ac_btime64 = btime;
+	getboottime64(&btime);
+	btime = timespec64_add(btime, ns_to_timespec64(tsk->start_boottime));
+	stats->ac_btime = clamp_t(time64_t, btime.tv_sec, 0, U32_MAX);
+	/* Setting the clock back after suspend can make btime negative. */
+	stats->ac_btime64 = max_t(time64_t, btime.tv_sec, 0);
 
 	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode = tsk->exit_code;
-- 
2.53.0

