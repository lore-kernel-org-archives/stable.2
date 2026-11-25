Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605986;
	b=sS9+npjmZtNr0Jj0aQGyxlkhqVDJw8JkT8/F7Ci6ztInCljORMprGh5PVMr7UKXOxN4V
	 Jj1iLFUPJkGsb02JPTF1mqOkcsPtd/W8+PscJA/tTvFPJGN1aqoGffOFiloXz0BrcnOjY
	 vhuqbwEWpE0ZLdg22xW/WHFGHaqfeou232RTJXmVmOQpIIauSeBC3Wlovh+KsvVYP5fJA
	 Xz8yNt0sgyrStHwQ8PBKkGh8K1/EfM7VU0IILA0b/XeklCC2Sl0r2M+a9sbjY6ah8/ruN
	 gehRdV4eCB1O4fsfBV7zElrWZPfYbzE9D4XrYOKP59aZ2SayB4+pK0Cjh5MNC7qKixQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
	b=NuhHeY74ft4XJ/i9pZclHZLEGRgPlRj/sItgllas2zFupl1BxoPG74XvcQQ0XJA7Jqqo
	 42nzd31y+dHRpLatjf8j6x7d8Q2JfbtEn854KHExWT//+D96+2U0Wv5uLT9D2JMqWmHUm
	 Mmle6tsMnZbf2Y85atDC3lRX6CmRUhPrkNhMOTrf1gOt2YXfY0t30aGPL1v3ca6j059ns
	 SpAROlLJ0/AOFyQvLfebaSwu1Ya20INNEm5/Y8pXnUinfY14vjeGj3u2d9bIi3EmZE+3z
	 9n9tL7HwoYCvj7lU9ADRdTWXmxo1+gSByJndTDX7ifOvy7OqsWu2AKX5tfrIPesIn/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Puer5IEp;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDDD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Puer5IEp
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so5530636eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605985; x=1796210785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
        b=Puer5IEpNe0hOLhrLAeFd7whyqwOxFxxpiWI3U7+E/Q2K7E/uVVcVStw0QGs5LlI6V
         iE+TvplTmpuiBQBLcHL8UyWaKNhW7ZGcbsEZqzbgn+U7MQ0NxykCdSCDplTY8VTz/Sap
         4i/LbTNWu0dE/qU5izHWHeXUzJ7cOsyXNUsUJDssYN+eNgOk1Jg5qCBMGEWGiLAIJe5k
         4TrpvX+bNMsvmlCYe+VyLf+wcoSt+8rJ8NlLLiqj+rSccHyDeqRsHZt8YLMddTKR44W8
         3FrORcJUC58mNzHxxHQ+nVCjoasdhf/2ekrzHq+zEhvUzCT4P7FNbjEwvGQoYVICDnxm
         y5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605985; x=1796210785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPpoQE6KUvyWN2jX7u+574bkZWMVb7HlyPTqHT4GBCQ=;
        b=o/RMSDMsiD8HoxcFUAogv6xCXgwM2QJ9cQIWkvr6J2KAa4gyYFDg0bRRl58LC4cTrI
         YKAgPB54MJYEM9V/HdfrPX2liBfXVP1hctbAC0RLymeE0naDcAdZO0T8Le9SUd+fboWu
         6cK4KLfZFemsNQlyonFPdbA6mVnLzptDxKixbGUBPx5+RhumLbCSczKSOcCZNT9nqiaD
         PhcC8YZebeisg99cUlnTXduRYfLz/fdxjIqsv63VyWMSB1ItoyZEn/k8LpTKoHISpLnt
         1ltVc6NLhe0r3bBhFiB+d4Fz8FPWyFtN06tUOdhdSzJWtPY62o0xZ/rDIU1avTK7TzFY
         a7Kg==
X-Forwarded-Encrypted: i=1; AL+hErFIpwnfeoD1zSrRk4UlE/2zd4GTF1S7QJh7UUUTj+a7aaOV5FL07bzzBAA1GO9XL1PFmx+AzWw=@vger.kernel.org
X-Gm-Message-State: APuU4Z83OHTXC5eGlTdLwdvP2tDmSYUTlS/ZXaZw73DttWWr76C0IeRW
	gEOPdSAN1sGUor97z9qKTyyMiWGtx6jS6WaRoj1fH4r79zWCLJDNMEJE
X-Gm-Gg: AZFdTZfZ7t6Ysx1q4eguG3eXWRbVfnuY7zsoYT5heM2XIYY3t+cWDUbJmMCV3wa5RwP
	TwRaXNvSPQhJe7MAvlCJHjr6LFxaLDSuCISAqk+JAD6lcQ0KNmNJSxBLbKfnjmDRj4BCTS10pW7
	hSURwbFJhn6bgU1mWoxIrg21WyADv13FNp91Pf08fbzCwRD+v51LozDjXC5QUPm03/ffwIoPqRe
	kFpW1CidbTi8MgTSPrwId3XVjlJ9U8LByQvCOAj325cThgAZuyZHpQWokw4WTt4OnFJcRQNQwGY
	ID0GaAQXKwi13vOJzWbR5dau2UnG4n6r6rrzfP++XK8re7lGnfokPZyFeHxbcjAgFiU/BIwKCZs
	S3AXzXzdEfND6cXim1Cw6AqhFg8YVHV2NNqFpSftc85sgBj6SwYLo3dVXTPe3CVl21ft6iVCXUA
	UkukP/e0KcCW9PKI2gOYtuLgiAQcv1XOR4wcL66CUqNSsgQvFl/W/eHwGVgyQZ0lp5cllk1DXjQ
	ThwKQcukMCF4L1HdYVHaxM9LJ4xQEh8JzVjdm5/NU7gp4G/cvUeJL06cbaHa7MhwrJcqbMuuhYx
	lE7WU896HeEAtHheNZHVC75KtNEePX8eB5QVHIt0tpQDhU+S3DPqUm0=
X-Received: by 2002:a05:7301:618f:20b0:386:ad3b:a48a with SMTP id 5a478bee46e88-386ad3ba7cfmr10073158eec.5.1795605984884;
        Wed, 25 Nov 2026 03:26:24 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv4 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Wed, 25 Nov 2026 16:56:04 +0530
Message-Id: <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

touch_nmi_watchdog() can be called from preemptible context, e.g.
sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
smp_processor_id(), so with DEBUG_PREEMPT we get:

  root@buildroot:/# echo w > /proc/sysrq-trigger
  sysrq: Show Blocked State
  BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
  caller is arch_touch_nmi_watchdog+0x3c/0xd4
  CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
  Call Trace:
   dump_stack_lvl+0x138/0x150 (unreliable)
   check_preemption_disabled+0x120/0x158
   arch_touch_nmi_watchdog+0x3c/0xd4
   show_state_filter+0xf0/0x338
   sysrq_handle_showstate_blocked+0x24/0x38
   __handle_sysrq+0x134/0x3a8
   write_sysrq_trigger+0x178/0x22c
   proc_reg_write+0xf4/0x150
   vfs_write+0xfc/0x71c
   ksys_write+0x8c/0x150
   system_call_exception+0x310/0x590
   system_call_vectored_common+0x15c/0x2ec
  ---- interrupt: 3000 at 0x7ffd01755b98

Unlike the generic version, which only sets a flag, we update the CPU's
timebase stamp and its SMP watchdog pending bit, so a migration in
between touches the state of a CPU we are no longer on.

Disable preemption across the update to fix this.

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 44f178e07531..1a8514b2d853 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -459,9 +459,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu;
 	u64 tb;
 
+	/* Callers may be preemptible. Stay on this CPU for the update. */
+	guard(preempt_notrace)();
+	cpu = raw_smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;
 
-- 
2.39.5

