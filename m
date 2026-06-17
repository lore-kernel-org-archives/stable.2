Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7424492538;
	Wed, 17 Jun 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712263; cv=none; b=uG6CddrkrNFj1j7lm4WM51CZVY+gryvcZIy6PhgRotLReOljCcpWg6WP+nOXry2badd9SghMJdIhtO0KXIpDaH0p3nooyJZBrF1/4rCbCc49MxmxJwnNBdMmpvjhnsViCRBNJOpXjCNZhncIOBBZlSmywJbr9N4hUb0wB2/jyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712263; c=relaxed/simple;
	bh=KG6e9Y2xf4noxyO5MAPevY2MJrB9TJ7JJod1rdTLo5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rhwMKLm47m2rQ8uIvrbdBd/k/0/u339QMak0z6huB74oqnEfUVR/9+x+bbzALIVcnUWNUyDNYb112qlOOoDPT1BrENe6lbi6+FoVxtxsiiBC1oQbXQZh9qdTMAHpJP+pjSgD8aJgMmilY8pqtaa1pAUy5O/r7N51e8rfhUxdGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fq6iKFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QloiBHsu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fq6iKFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QloiBHsu"
Date: Wed, 17 Jun 2026 16:04:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781712250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZREPk+Kuqp0M4Z9yXOBpLRFv/OOhpDllEOdLI3tIAw=;
	b=0fq6iKFwKrqdnyzHk3z2Kb6b1dVUJ+BhU/esD7cfTaOY1ePp6RrHR/U6kfBYn4V85Gm45D
	uZuBy+udQK/JBSYg8b7CK8pE7xFzZrcQR8PI/vlscBCJx0SPHdS80SXKgOmCX8eMcfn/Oy
	kl2N27PWn3dmZTqPMNZNlRyeF9hl/YpS6GCsXcttnPv/2zWesDb5ShmzbYp3EpSBPtVyuj
	EqcmDKuMW9ophHkTkhajYKaF1ppRPgaQ31MiDUTTjbsFobnJedIryaE34E92jn8/VFQmLA
	YH5URkssNc51rfgoPRQCk4c9BKd5I1aHNB0vIqIQoyFSBe4DN8lz37ZE6mamlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781712250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZREPk+Kuqp0M4Z9yXOBpLRFv/OOhpDllEOdLI3tIAw=;
	b=QloiBHsuCziAUy0IOYtRwhumhE2s/soXShYKRsFCmzq4a0e18LJhEj4Ceo/DSJ29+hP2gU
	LCmAtIE0i1AQ6DCg==
From: "tip-bot2 for Zhan Xusheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Use u64 multiplication in
 update_rlimit_cpu()
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260616112017.1681372-1-zhanxusheng@xiaomi.com>
References: <20260616112017.1681372-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178171224929.1650852.7915564871936236069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     26aff38fefb1d6cd87e22525f41cc8f1aa61b24f
Gitweb:        https://git.kernel.org/tip/26aff38fefb1d6cd87e22525f41cc8f1aa6=
1b24f
Author:        Zhan Xusheng <zhanxusheng1024@gmail.com>
AuthorDate:    Tue, 16 Jun 2026 19:20:17 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 17 Jun 2026 17:58:34 +02:00

posix-cpu-timers: Use u64 multiplication in update_rlimit_cpu()

update_rlimit_cpu() converts the RLIMIT_CPU value to nanoseconds with

        u64 nsecs =3D rlim_new * NSEC_PER_SEC;

On 32-bit kernels both rlim_new (unsigned long) and NSEC_PER_SEC
(1000000000L) are 32-bit, so the multiplication is performed in unsigned
long and truncated for rlim_new > 4 seconds before being widened to u64.

The same file already casts to u64 for the matching computation in
check_process_timers():

        u64 softns =3D (u64)soft * NSEC_PER_SEC;

As a result, the truncated value is installed into the CPUCLOCK_PROF
expiry cache (nextevt), causing the process CPU timer to be programmed
to fire prematurely for any RLIMIT_CPU soft limit >=3D 5 seconds. The
actual SIGXCPU/SIGKILL decision in check_process_timers() already casts
to u64 and is therefore correct, so limit enforcement is not broken;
only the expiry-cache programming is wrong. Apply the same cast here so
both paths convert rlim_cur identically.

64-bit kernels are unaffected.

Fixes: 858cf3a8c599 ("timers/itimer: Convert internal cputime_t units to nsec=
")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616112017.1681372-1-zhanxusheng@xiaomi.com
---
 kernel/time/posix-cpu-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 74775b9..5e633d8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -41,7 +41,7 @@ void posix_cputimers_group_init(struct posix_cputimers *pct=
, u64 cpu_limit)
  */
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
-	u64 nsecs =3D rlim_new * NSEC_PER_SEC;
+	u64 nsecs =3D (u64)rlim_new * NSEC_PER_SEC;
 	unsigned long irq_fl;
=20
 	if (!lock_task_sighand(task, &irq_fl))
