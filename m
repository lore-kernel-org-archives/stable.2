Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596416;
	b=lsmr6rBeIAJkZiBCLt+x+JsWrnd3PxsicRlnKYWeMfR429YYFD0ggcNY1yBvEYzuAZIq
	 UU29jDkwiEGE2vX1Ke9a1dGMJVQJipCeyIlxyBZb1ExWUzdLqJCYCmARCFpEIx1TIZTkl
	 W7TYM5L50DJvSkb8/dIgJgL2rZiKCdc5dR5Gqco68aG5CauAfybh9Go++Si0owejGl/x6
	 OMHbZjQXagGLqZhO8AL/mZjacaS0fu9W7Ka5wB1OeOjHTaZlpJY2jqLV/PnTpqmtHw2Kl
	 BkhJkt5fxDFmvy4aaBhhNecLxOEVwqoObJxKtbw5+pkwvAkeo13EuGxkQAF9bEibzxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gKIID75y2cmNlMXRd1MhTd86fNY6fAdmhSMsDM5aV/Q=;
	b=JHIeocM+N2ZOSjwzUMHqSMDcY8f1F4jWSCuBd5SyCSfwkBlGa7B2Mo+KQwPZB0KCAqaH
	 On5IGW0DoxpcxfCIA9LrOy2yqS9aobzOWfHzT4wXejJa2kGE2C3QL7QolTjhgT7sVJZB4
	 r7fcetHdqlF/atytzPM7DPSbteJHFciy60nJdtz72GPLIasS1ll4sZMqkhtXPxYuvmp8x
	 p7tb7cOfnviy8T7YMxPxAmx/n+ExENDc9eXOyYrJ3AutW4VZGsrcY6AhJzxoeoSLJxyk1
	 u5uQYZobfkWMqkGcONtkRKhxBC5/lRZsD/4y4iY8HwU/fOvGDSzn1mGirC3XOoc8O9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVJgIzVQ;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BB606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVJgIzVQ
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b4ab53a966so491368a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795596416; x=1796201216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKIID75y2cmNlMXRd1MhTd86fNY6fAdmhSMsDM5aV/Q=;
        b=fVJgIzVQUDo0SHmzV1oXinNoS3IEbtSaCl5C0hhFa6u4okslMXZuRPP1/sE1WiEaSt
         uGkBZpyVkBMM8TG3tNupmqxvXUF8tBlvl7FmAAd4t7c4tLlgget2lEK+3MnDSNWXpjIM
         LQiK+VY0JOprNjTxLMQ8HSLhKOACJPdkQOyvYu6tjxedmQgDeIB4szcK+Ks6OFgZILhd
         tGCllSv8DXP/lEEhUKk6YeHJvvHdIP/y6wYbt5WlwmtGUev3ODHIqUkrFT4fdlSxOCxe
         SOL0annlCqBUipJwv5paTKlpRq6+K65Z/PV6rXXu4pyBP5LDKlKHOk7YacECCkayebCZ
         XYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795596416; x=1796201216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKIID75y2cmNlMXRd1MhTd86fNY6fAdmhSMsDM5aV/Q=;
        b=pAzWwrLLsv+xn/HWSazXUT17PtmCyx1NeWh3PkSmI8BAykC0p05fXW/ESKM8n9vPDe
         p5vpdr0xnLzwwl1dMInRX9kE/4rPkSS+cqrl6PIuNrq6ohTEOiQwJ3Gl5JY8uDiHwE5T
         J/XR/b++gY+E47q3mJwWLYAcKGTLdjcGs3sMhrzWJt/tYxKUi0gSZqYpIUlMPedDUY2T
         JJYQss1AJ6aX46p1iMkNKM9VaAiZlA4Ia6nJrYeNsjMBX+EoAWM7Qk0eY7WJzQ77z5wf
         K+XBMPxOaDIG7REnqBajjyMZhPzjxuUVFgYcTwd5uhsjxfeGXLJc2Dt6IL+5jy46I61E
         6Mxw==
X-Forwarded-Encrypted: i=1; AL+hErF5HAfB0y8blOWJYKJRV+pqirN6J+dgVMJqhr5kMXKI8HFIsC3Xmm1OmVkamgeSLd4qBI7UP1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g1S8Yv1ujMqqgUf8WI34QRszmd2htdVWhiSwvkHlpVTY7XkrJ
	8M+Yh9BoSe5IIdA4ycqrit2weJu6IFyFgqlRc/usoG1a6ZqEnAhTMiPS
X-Gm-Gg: AZFdTZfk/4mazC7szXNSkn5LgW4sDCvvnCgmZjiiw7osfAJLoogTlsM/kiJcs2N4y5w
	DzALDe1nFMbGY1lOVg9N04W080tbi3n/Ps1TR15mwDxzF4HuL08lFqfepNYsDWjt8bthYqWN4kY
	BZXwYeBqcYrpzMF4AAyV6qziwOCgCIsEwIc9FL6S3j7z2N54OVLEEiHCuI6JACH3T20AiuZiBBH
	riMIMbHjMTOU+ZRaFszeEBss/dyVTr4H3e31BD7cLc2vSR/4nEwdEqCFtXgrpWpivpVW5Q4P88I
	YopPak5Ots5yGLvtgOlL/MokfjaHP3nBazr/Wqnta3Y0pG9s9pBtal2LuveRF0D0HkRmqTzfj1S
	2XVoHCpHmsW92adxVU8vvKLZJQFb0KADfW/NkZII9BQ7Zrmx2ua+lf+15WDWR9GXhJ2OW1dI37d
	0+sGje7E2lNQcp77TG8yH2Co+8XP+sVGmEDTxIV67KUqjY5aIJQXMxvwktV7Wef5i4foWtBmDiF
	77rExoAxAbUeI7cC0RVaNltuPqQSPift9ZJdoLf8rx0EmuaJJHzg9BDGrHh3pAcKtSjLu4/TNN0
	jRZ76k78+eP5OHOAY4LBmTV+LaCZnNPTAHOkepFKpR6fYIETP6ggGRs=
X-Received: by 2002:a17:90b:442d:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b41c98a095mr26665706a91.6.1795596415710;
        Wed, 25 Nov 2026 00:46:55 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm28973549a91.13.2026.11.25.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:46:55 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	frederic@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of setting its affinity
Date: Wed, 25 Nov 2026 16:46:00 +0800
Message-ID: <20261125084600.2306377-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

start_single_kthread() sets the affinity of the kthread it just created
before waking it up, but kthread_affine_node() overrides that mask on the
first wake-up. See commit 60ba9c38b931 ("kthread: Comment on the purpose
and placement of kthread_affine_node() call").

In round-robin mode, move_to_next_cpu() compares save_cpumask against
current->cpus_ptr, sees the replaced mask, and switches the tracer to
MODE_NONE on its very first iteration:

  hwlat_detector: cpumask changed while in round-robin mode,
  switching to mode none

So the tracer no longer migrates across tracing_cpumask. More importantly,
tracing_cpumask is not honoured at all, and with isolcpus=/nohz_full= the
thread cannot run on the isolated CPUs it is meant to sample.

Use kthread_bind_mask() to preserve the initial affinity, including
isolated CPUs. Clear PF_NO_SETAFFINITY once the single sampler thread
starts to allow userspace affinity changes and cgroup migration.

The mask is now computed and validated before kthread_create(), which also
avoids creating a thread when tracing_cpumask has no online CPU in common:
cpumask_first() returned nr_cpu_ids there and cpumask_set_cpu() then wrote
past the end of the mask.

Tested on a 4-vCPU KVM guest, bit 0 of the mask is CPU 0:

  mode        mask    before                    after
  none        0b0101  Cpus_allowed_list: 0-3    0,2
  round-robin 0b1111  mode -> none, no migrate  migrates 1 2 3 0
  round-robin 0b0101  mask 0-3, no migrate      migrates 0 2
  per-cpu     0b0110  2 threads, cpus 1,2      2 threads, cpus 1,2

Fixes: d1a89197589c4 ("kthread: Default affine kthread to its preferred NUMA node")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
Changes in v2:
- Clear PF_NO_SETAFFINITY under current->pi_lock when the single sampler
  thread starts, preserving userspace affinity changes and cgroup migration.
  Keep PF_NO_SETAFFINITY set for per-CPU threads.
- Update the commit message

v1: https://lore.kernel.org/linux-trace-kernel/20261111020755.1422284-1-hwenwur@gmail.com/

 kernel/trace/trace_hwlat.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3fe274b84f1c2..52478ad8030d0 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -353,8 +353,21 @@ static void move_to_next_cpu(void)
  */
 static int kthread_fn(void *data)
 {
+	unsigned long flags;
 	u64 interval;
 
+	/*
+	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
+	 * affinity from being overridden by kthread_affine_node(). Clear it
+	 * now to allow userspace affinity changes and cgroup migration, but
+	 * keep per-CPU threads bound to their CPUs.
+	 */
+	if (hwlat_data.thread_mode != MODE_PER_CPU) {
+		raw_spin_lock_irqsave(&current->pi_lock, flags);
+		current->flags &= ~PF_NO_SETAFFINITY;
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	}
+
 	while (!kthread_should_stop()) {
 
 		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
@@ -423,15 +436,12 @@ static int start_single_kthread(struct trace_array *tr)
 	if (kdata->kthread)
 		goto out_put_cpus;
 
-	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
-	if (IS_ERR(kthread)) {
-		pr_err(BANNER "could not start sampling thread\n");
-		cpus_read_unlock();
-		return -ENOMEM;
-	}
-
 	/* Just pick the first CPU on first iteration */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	if (cpumask_empty(current_mask)) {
+		cpus_read_unlock();
+		return -EINVAL;
+	}
 
 	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
 		next_cpu = cpumask_first(current_mask);
@@ -440,7 +450,14 @@ static int start_single_kthread(struct trace_array *tr)
 
 	}
 
-	set_cpus_allowed_ptr(kthread, current_mask);
+	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		cpus_read_unlock();
+		return -ENOMEM;
+	}
+
+	kthread_bind_mask(kthread, current_mask);
 
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
-- 
2.43.0

