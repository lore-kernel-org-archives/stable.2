Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C7266B46
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583430; cv=none; b=ltVPK7Xz16iVlsEfUTbnZVYyPpoNWogbm/KluVzMNHrGUHu9IWR1Saefwkmh2MFVTX6NdofVeO7/1E+ttQCnqE8O3yhjdF1Tk2pGydO67e3WZwMYr7kBbaHvR+fb83VeaGkxyuKHTX4ABKO103iCh69LmNI35C8/i6YurT09adM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583430; c=relaxed/simple;
	bh=pAvvI/ojsjbSZuKEi//8yxRn+b0LijdmoHGnwKKWdwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A32J/yZk2gUd1Zhxxqgio/RK+rHuyg+1X1MLRhFqvT/WgcCO0JA0rcmflxdGLGycos+N4EzLD/GGCVnd5AaLsQ3MWQvPUbVmfxK1Lg6UqbY8DICnMcwZfWi6ehUdqhTYkysS6ZMIdxbDbKpDM1Au44WaLRyCeTJUCDOnLfBFRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5GQV13/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5GQV13/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554B61F000E9;
	Mon, 20 Jul 2026 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784583429;
	bh=ZUCp6OK8gwf2WtcRP8tDuywpiixmkrGAxkWPF9aXy1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=j5GQV13/M8gxtLKwJa6ndkH57ZhCpNGR48E8AL6Z7b7n2Ms8UqiIjLaszYkog1wvN
	 5tT1kt8Qm3a5w18/WT9s1uvP3a53oQrcna4u5N4Qd6LUshJER3sKuMxFAb/hZc1p5a
	 R0aGSdO7rhGPIYXmGfA//+qWXuISvSKnZXnxWTaHk6lH8xsTBDbwsxT9znohyEPxiY
	 XU7dpigDAEq6ZZsVUH8tT78Ms2gA+JQwRQZazD+ExsrxJnMwJOkXxt4koOVIqTKoaS
	 45Hmv6QTt4ksKfATEYDJuCeWCF/oH2ue2opIP64OQijW/lDUUKwwUxqc/Uc58t7/+N
	 01usO+5ryylyQ==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, zhanxusheng1024@gmail.com,
 zhanxusheng@xiaomi.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y, 5.15.y] posix-cpu-timers: Use u64 multiplication in
 update_rlimit_cpu()
In-Reply-To: <2026072009-plural-agonizing-5276@gregkh>
References: <2026072009-plural-agonizing-5276@gregkh>
Date: Mon, 20 Jul 2026 23:37:06 +0200
Message-ID: <87pl0hl4vx.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

commit 26aff38fefb1d6cd87e22525f41cc8f1aa61b24f upstream.

update_rlimit_cpu() converts the RLIMIT_CPU value to nanoseconds with

        u64 nsecs = rlim_new * NSEC_PER_SEC;

On 32-bit kernels both rlim_new (unsigned long) and NSEC_PER_SEC
(1000000000L) are 32-bit, so the multiplication is performed in unsigned
long and truncated for rlim_new > 4 seconds before being widened to u64.

The same file already casts to u64 for the matching computation in
check_process_timers():

        u64 softns = (u64)soft * NSEC_PER_SEC;

As a result, the truncated value is installed into the CPUCLOCK_PROF
expiry cache (nextevt), causing the process CPU timer to be programmed
to fire prematurely for any RLIMIT_CPU soft limit >= 5 seconds. The
actual SIGXCPU/SIGKILL decision in check_process_timers() already casts
to u64 and is therefore correct, so limit enforcement is not broken;
only the expiry-cache programming is wrong. Apply the same cast here so
both paths convert rlim_cur identically.

64-bit kernels are unaffected.

Fixes: 858cf3a8c599 ("timers/itimer: Convert internal cputime_t units to nsec")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616112017.1681372-1-zhanxusheng@xiaomi.com
---
 kernel/time/posix-cpu-timers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -37,7 +37,7 @@ void posix_cputimers_group_init(struct p
  */
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
-	u64 nsecs = rlim_new * NSEC_PER_SEC;
+	u64 nsecs = (u64)rlim_new * NSEC_PER_SEC;
 
 	spin_lock_irq(&task->sighand->siglock);
 	set_process_cpu_timer(task, CPUCLOCK_PROF, &nsecs, NULL);
