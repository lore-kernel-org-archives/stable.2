Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617565;
	b=0PCVIG/oSFD6q3CuiOL3DrASVLrP5SHpE23gg/uhJa+x6NJmfz8/ACZJw/1Atat6ivah
	 IcRhuUXOROZrm6MDkT/PZ6kk6HaUfHHq3FHzB7SWeD4JUNNbBIStH295O3s/9Uzhz0wyY
	 PyLYXPSm2LN+84v1pohk8LyprVPZJiHnKBhzZwpkW/pL4xxTdMAfxVR7pew43W9/A822P
	 KxXRThUFrbdxjT/Gz2dHoW53HJRfWxJIPpe53/YPR4uwLXQgdMij3R1rBz/w5CgPVIMAc
	 5MFdA3nOptcJKZIB0GNxtOhoszja2ogMxJkPBaRmccolIhU6gFRXs99SBiIagnwE8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OHYAweQuxjWb5lK3Be9JeIAN588o67p/wvSODKla0II=;
	b=1o3Z6G8wuqmMGXvd4E5rmxh/PVOLMI0GJDYfgU+dR6NeUBKb14XQP44x1ZG3NhT7AH/G
	 W7hrbJOQVhKRmviPhp91HzevWVM8sFNUC0Qn6/FExCARJAyZVarAKIP0ts0l/vXGSzxkn
	 amuyAIwuunC8Uf6jOf00ksCk3HKgfv7hJH6Tz81vP20IrQyTXoFT3L6JQrwkpHsPP7D4c
	 zdOHmRrJs9gteWFBFHQ14QZQ8RdR6LHNAD6fB4wbL7CEX56ODSjKHiExoAN94ybqSOjGA
	 egtuTofSlVc5pT72E925Q87ij8kF0FipCFXkvEry3JMXceeuEvpf5YdTK/OY+SffMIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6egAHmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6egAHmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D821F000D0;
	Wed, 25 Nov 2026 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617564;
	bh=OHYAweQuxjWb5lK3Be9JeIAN588o67p/wvSODKla0II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6egAHmNYfWeBQ4JJ21n0qz1AJXPRqB2bhEkh0iueIAU2Gwa4Eg51ZDNH5dIPRx4k
	 95uD2hYIsxudy0D2Lr/PwO4QWC4aaa+XwLKxz5+HIhv50b+tE/axBrbNP0PdhhxAAb
	 +TlBvy30C0ysCnsK0EterIL/t2w56dJkXa6hdpFrEu5zi+icwDV07t/sxJWZku3Z3r
	 x7RjhysbsLDsNXSs2aaq4aqwei6v7GVHmAo0xLAAsIGSBACSF6b8uxTK50thsRVlxd
	 FVo8W+4TWilg2C/cA8kCvBzYE+DRKDjKx99lTpNJ/cmjg7vUf2CkEvn3u9X+GdwkYT
	 mwtZknlvVJycA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hungyu Lin <dennylin0707@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tsacct: Keep task begin times stable across suspend
Date: Wed, 25 Nov 2026 09:39:22 -0500
Message-ID: <20261125143855.4152835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-oversleep-submitter-9603@gregkh>
References: <2026112552-oversleep-submitter-9603@gregkh>
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
[ sashal: Replaced the upstream now_ns variable with a struct timespec64 btime declaration, adjusting the context lines for this tree's older bacct_add_tsk(). ]
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

