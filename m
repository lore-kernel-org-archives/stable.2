Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784482;
	b=uv4bWMcWdlGRUoRXPcy/LtFc9Mwxq4oS9WxnknaIyA/53j0ontm8HzB3piuOcKehudQ3
	 l1S5tIkzFmB5Dez0U3XCXExCffTtnGjg/soGZpD0x3hsfLLDU+liYW00sEsjaK7ymIiFP
	 124qyeAOd4ogDnkDPcDe6EF02OP0i2Hv5kST3N//WL8Oj0BOtZqKTg9fi8aA+d9kb42a8
	 w71Cz1XYBH2VHOlOBI32v31N6MhqkOT4A8l63TbALhiTtP3+eDO/m+n06RQP7az8wvZdA
	 hNDY7fO6NgnhRRQIPjxiqz21mUdInMfEabnu4px/OxVwOqwE1SyMnaLuiQPYDhqmqQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784482;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=MS+Zl98UemzRj0HPRRcjU9fwcq9bP8rG8TLmxOqYCw4=;
	b=RV047j5LBNg/z1T2b5hLps3j+It3aTncOPUcpLOKXktqxFfMLH3mfg//rHsUa5wCS8hg
	 19RjaHI8l253t5JQ8gLUCloe6GKLxT6dEfJGCTeTcsL2y1J+k6CTS196FA/YVPZbHAW+0
	 /c9H7qrIrSTCLhBitlvXzY2QhvpY+fUNtjBvw9bLz1sBuOKkb6eFJe60QDVymPByfPqrv
	 m3K4p/IjpQpyv/66lM5w5MBYz77+qb6bquDS8bPsCtsgt3U4bwLSOTrU4w5QZ37eLoTtE
	 0+towq1icUxXfqzclBS/uyLE3al/JpJsaN+nU4JBds0x0tW1RhNufU6ddhFRY+YxKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="pz/XwlIA";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gUX8qQYk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF51606A32C;
	Fri, 23 Oct 2026 19:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF51606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pz/XwlIA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gUX8qQYk
Date: Fri, 23 Oct 2026 19:41:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792784480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MS+Zl98UemzRj0HPRRcjU9fwcq9bP8rG8TLmxOqYCw4=;
	b=pz/XwlIAq+UBzM0DM0I1HgezGcHBs7T6VeAfcL9Awr8nRmGJ96OKUtpjYjvfFPrFuHFeQt
	U2hmK7kFn1UZN14x8ez5X4dZoX4XiS7Vp2QP64TO+oOZ44AzRIQi+2zTOmf/Rb3oY+m9V2
	We6Kuc5JZ2oxVqBdmIS2GKXdL1wWyibFi+nhBxt4fzcVvzS52v+gLvIT3F6QAU+kw/B92C
	W0uH01JXzbLV0mVyvmAxnOX8LSch/p7xjRl0rdnYiDtnx71fjJaJTuq+5qfouXUJeL5bC/
	/maTMQB7iMl/1zCZm5kucof2LSMECAaqP1pTtXN1tVg6WbHC2pikzsLnHdI98Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792784480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MS+Zl98UemzRj0HPRRcjU9fwcq9bP8rG8TLmxOqYCw4=;
	b=gUX8qQYk4o3CTlNsrELUFQOxPR2x1C+R1Jy7eroBxihwICSIFjeUbl0B8zOhFm2kex6MOJ
	KkEYeNow3E3reEBg==
From: "tip-bot2 for Cen Zhang (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Fix pid refcount leak in
 do_cpu_nanosleep() signal path
Cc: AutonomousCodeSecurity@microsoft.com,
 "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261012235149.66531-1-cenzhang@linux.microsoft.com>
References: <20261012235149.66531-1-cenzhang@linux.microsoft.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179278447731.3012171.3831148416947105196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     8ccd731b63a0183ca2b0e18f3ca15864b3f37eda
Gitweb:        https://git.kernel.org/tip/8ccd731b63a0183ca2b0e18f3ca15864b3f=
37eda
Author:        Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
AuthorDate:    Mon, 12 Oct 2026 19:51:49 -04:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 23 Oct 2026 21:35:02 +02:00

posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path

do_cpu_nanosleep() sleeps on a temporary k_itimer whose reference on the
target's struct pid is taken by posix_cpu_timer_create() and dropped by
posix_cpu_timer_del(). When a signal ends the sleep, the timer is
disarmed with posix_cpu_timer_set(), but posix_cpu_timer_del() is only
called for a result of 0 or TIMER_RETRY. If the target thread or process
has exited in the meantime, timer_lock_sighand() finds no task,
posix_cpu_timer_set() returns -ESRCH and the pid reference is leaked.

An unprivileged user can trigger this: sleep on the CPU clock of a
thread, let that thread exit, then signal the sleeper. Each round leaks
one struct pid. Repeating it exhausts unreclaimable slab memory
within minutes:

  Out of memory: Killed process 150 (poc) total-vm:789292kB, anon-rss:484kB
  Kernel panic - not syncing: System is deadlocked on memory

Fix this by also calling posix_cpu_timer_del() on -ESRCH. With the
target gone, the deletion is safe. It finds no task either and only
drops the pid reference.

Fixes: e26d70d271ee ("posix-timers: Cleanup reaped target handling")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261012235149.66531-1-cenzhang@linux.microsof=
t.com
---
 kernel/time/posix-cpu-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0bf4fcd..65cc612 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1600,8 +1600,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock=
, int flags,
 		 */
 		expires =3D cpu_timer_getexpires(&timer.it.cpu);
 		error =3D posix_cpu_timer_set(&timer, 0, &zero_it, &it);
-		if (!error) {
-			/* Timer is now unarmed, deletion can not fail. */
+		if (error !=3D TIMER_RETRY) {
+			/* Unarmed or target gone (-ESRCH), deletion can not fail. */
 			posix_cpu_timer_del(&timer);
 		} else {
 			while (error =3D=3D TIMER_RETRY) {
