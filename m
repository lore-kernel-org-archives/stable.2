Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252030;
	b=G23TNcbmFNA3PXEhbGTmOduw0syYbNlk3GL7UQKrsSghQ36d3WDYsAvSsAxs3n9wfES8
	 y7QBGpQypqpXpR8qiwoBz1XPMaV2PnCGZH6r+BAOIaKRVZ5A+h+v+/0ZjHozTNKdnhZL4
	 pJ26YujA2DNFz6E1L+qQTCLUr9b1FBJB9uFztDcQ2/99Mz9x00IkDM1YxjrhXktCX4b0J
	 CnfKtqqiIDgXOj34LKtI/FIeJxFZBB48ativtXlNE7av4IxifvbSELrFEHrirwYUVLEYq
	 wVP892JGiW2HaT0zRJn1AGrwIfwVCoi1XJwTrD9fT0t9A27ZqInS0zQLOQ12MsaA1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252030;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=mqmzqHy+K6xqClxPJ0pw3vTOjRyHVjEU8LMpqi7wpRU=;
	b=c1iyWe8YVPdtSdFnKojtlSMAled2gVGP+VNUX6rZMi3/24+EX0tPfUerJd6Le68TRgYC
	 LowRWd8VWv78P6l6hqqyrk9K1OzoH4HOK3Sq/dw5iGJqJrjYMfrHgRG1jursXfl3PJczq
	 +97gnHBoLmonAn/Isv4nbvTLZTkeTcYzXoXI1TEo2VJK7vGIropYIDApQyfRscR5gM/Z8
	 L8HJGw6ZSl+nN3RjMmJ0fVgHYGenAsGWVAEgt5bG40FTPxz2c9q0swXNThKMHi9CkYGeZ
	 NY834+dm1LrGAnSWBoBv6I0PiSfjfx87ibjnhuo5uENlQ/a+FdzlkkPNl4FMlxRX6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="xp7Ws/J2";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SGxk5KLm;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2489606A331;
	Mon,  9 Nov 2026 19:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2489606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xp7Ws/J2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SGxk5KLm
Date: Mon, 09 Nov 2026 19:20:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794252028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqmzqHy+K6xqClxPJ0pw3vTOjRyHVjEU8LMpqi7wpRU=;
	b=xp7Ws/J26aBS1MXvODxi/xgGazICgW0x3e8oYY4bt8SDQB/8t0LjvJX/cIygTm4QCCoH3H
	yy9uBrAJ5yBvq5MXlnAe/xEZljUKiVoyFc3aUuzQ4/Ux7k2p19lwiLxMYIa9s6dpEkOKGG
	Ft5P6JMEecJH0bzhOgyZdPxofMH6xGjx7khJ2qdnsIKg82gmX24ubDhaYC7nKv1Mx+oeVa
	hw40ufNz0UZfMfmkWnfDiNueU+7m64mlEAg7kglR5LjDsfIff94NEQ4vShYjuM9PGRGwYD
	V5eP+/I6CUvV1Y2UrD7EfVG5bCcuL/xTdoUh5xMqjMLzmCcvSojSGiCB3qp3ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794252028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqmzqHy+K6xqClxPJ0pw3vTOjRyHVjEU8LMpqi7wpRU=;
	b=SGxk5KLmjD7RopxlSJM/JL2iF0fjOX5BMOqpPD/hoclIrW+GE5El7u+iY2lAqsF3ftDZOc
	Jhkfdsy7Qk2ju4Aw==
From: "tip-bot2 for Hungyu Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] tsacct: Keep task begin times stable across suspend
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Hungyu Lin <dennylin0707@gmail.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030054227.35453-3-dennylin0707@gmail.com>
References: <20261030054227.35453-3-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179425202666.2093942.10369104068455461255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c49b3c20a2d0b22700e2100a527e68e829ece7f0
Gitweb:        https://git.kernel.org/tip/c49b3c20a2d0b22700e2100a527e68e829e=
ce7f0
Author:        Hungyu Lin <dennylin0707@gmail.com>
AuthorDate:    Fri, 30 Oct 2026 05:42:27=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 20:15:58 +01:00

tsacct: Keep task begin times stable across suspend

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
Link: https://lore.kernel.org/r/alpine.DEB.2.21.1911071335320.4256@nanos.tec.=
linutronix.de
Link: https://patch.msgid.link/20261030054227.35453-3-dennylin0707@gmail.com
---
 kernel/tsacct.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 5c15310..4832068 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,7 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 now_ns, delta;
-	time64_t btime;
+	struct timespec64 btime;
=20
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
=20
@@ -39,9 +39,11 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime =3D delta;
 	/* Convert to seconds for btime (note y2106 limit) */
-	btime =3D ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
-	stats->ac_btime =3D clamp_t(time64_t, btime, 0, U32_MAX);
-	stats->ac_btime64 =3D btime;
+	getboottime64(&btime);
+	btime =3D timespec64_add(btime, ns_to_timespec64(tsk->start_boottime));
+	stats->ac_btime =3D clamp_t(time64_t, btime.tv_sec, 0, U32_MAX);
+	/* Setting the clock back after suspend can make btime negative. */
+	stats->ac_btime64 =3D max_t(time64_t, btime.tv_sec, 0);
=20
 	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode =3D tsk->exit_code;
