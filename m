Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180882;
	b=vlErl00NU5gN/NXynxtKErkRe3sZlt/L6xDO3D2blpiNvLDx8Nf1Bv21QUMB8rq+rf86
	 vEDs/mt/GlSUcxAKwWtMzRwvJq7l7n3IZ4bTbikR1kitr5SFJiU/RSGCKkwd2c0arUo2c
	 wQOBzEdadlPnPeEvpNnU/JTuxp/wndVnS9sS4ABu00yfnjIF/gVinuvGRJzpa9aIU34KD
	 0nLtDY6yunKSCaAfX29xl8D/jlCWnAdjtywQuiBlQ9ArtHr02WoMFo6ktJQkntHudumwv
	 4o/ueRz1MTzHyva6tp0Ug8eFoxvbtlciagJacY0GkRKk1oJOMXciKXHNMoJiimOd+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
	b=mb3eTwpYopQSu7Lwvt7XgGZfkdiLnx7ZcR4mr6az/5T9lNCYLgqM4j15lCWeS3JaV/Zo
	 wzSn8aXhA5UcTmrU5CezDuCEgefFXL4ujr8MR0FUnUQ3hhfD9npeH/rW/VZF0HoTEiQEf
	 b9iYRrGaGOqcpb4ZuSfgyrtUtjqrWKgpjpzqONV3qLxoIkEabZjA+zn7QwpAGXkY753+u
	 eb1fgllJfJPEBuREcAQ/mzedv7OyyMLae0kjcToyNCRDFXH3TRek6O3b9Le7ZimQDx3db
	 /uhaf1e7XgyRedN+n2MBji4dvP9XnLUxmZpUY0wBuWzA0/K79nPDvNcniZb05g5cNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SS536KN/";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935B606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5935B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SS536KN/
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so6835765e9.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
        b=SS536KN/FNb5ZcLsLsAYO46h/5MEOlP+vGqlqfGkkILFUt+I4S7V9CFmqXZF8Jf/4v
         JvOgGdgHX8kN0hPDIvDCbYR2Gv+V22vOuKrhezQQqWxTveWH1fOY3XdGaEH/PZlebHP8
         yb8TMuHEN+DBGkOWtVvqCc4SclYN6wEjUh0WE8WyavAPdJMvgwlmcmoK7ZNKUDnV6Q2y
         4hWdCi3ItZN5RJBEXjP/BgkmHI/a/J5nclWfU8V76GCE1KtEh3ns116DvOnStV3t9Yvc
         L7rWbxYybvUByz/fEzvWlKjprfc6u5ulkeTKtXKIUUQPf1xiTh3R04s1mhzjq2tQ6GK6
         6Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180881; x=1793785681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aN0PCVme+wt47kiYd4k29CFoRxw88qU3QpIuYf12IDE=;
        b=xh8QkOvlC4RIbBMUC7L+Aj1+vsKsrdDqgS3r7KiNuwiheFmm4iztRIR7g8FG9pwhv7
         /ShbNQkL04QnpM+bACtegj7ilIk+SugwGrObFBvY/71dcq/ACehrMLb8LMd5SHf9rcLt
         /J6enxVsE6c/EtPyE9TwWc3FnC0UuCm9TEci+en4rHc1n0wCFFIVlM1SJje8p054WvdC
         rCUQ/FNlSsHRcftJyHvdtoLAlQ3SefG19nJtEpAzdHnRUbKBADTHwSdOcfrJDKr+wud4
         y7uHo1RDB+0MTOA9yNxwlSfQGFF5ZBjwgQ/bvIB0sHNoj//9xJk8y9gPmiWxDTl2X11U
         2+xA==
X-Forwarded-Encrypted: i=1; AKwUvBwtB2n6tzQwOOWp7RFWf+ZnSBATk1J8bup3dBcdE3ei/YQ3EMTdXmJ1mN3QcAKI4gr7+2pIMcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVPOXZj2rHYdKuKsJE1sRggbE4tnSlOZu4VvNM4PSfDJAW9JbE
	o2if1uehmJmHU9AyatFu8a9bKBEgSptDS/5Z/jYehN7G86mw9me532uP
X-Gm-Gg: AYBFou3EI51kgjC1SvKoxEGkXDYgNt4MH1kGq5YHC8XqgoS4nRNGeQX+AGUkZho/SmS
	agCtzer8NKvHEu1FPylsd6Do3V9BIuPOqKkrJIWITH95hwJZ3guQ3GBxgXy+OYRbxjk6M9dLMS6
	1KLvk2XODwblJAcLuo9PPu5jnoRKqlrdpdMQ/0Td3C9+kz/k/GCE8Dk9DsXpSkjHgB7DT1Nbs3J
	j+9MeHGtfRpu6obktflbo4YvZ7jNJFY4x5yEPbSdegQtRACN/+ua5+j5XtqlYpbbNMfO9xig3UW
	qMA5lsx6mhyr+bqBJcFjoeLSsVhl1qR1WjZKhJI77rB7gUIf5HDNQscxM/pXcuGuYlkS/qpTW/o
	KZ5cjruZzUe8kcCSFRXGttcf75AlmdPZlIV95AfyKvO+S5SNJ6aIZIMNtxnTXyPodEnWffHAvin
	uKrJkcw344kMHaWaLCJx0pzPqcUUPrcTDMBDV3EDl+Y5ueOd6Ius0T8l327E/JrVQLn2qnCDMsp
	7KJiA66vTPB/Qx3HbEkDwIfIF5JHU+l1QKhOerQkEDMxi89yMv2GHDXHqRuTEMwDqYpboh38Mg1
	n37ox8v348zRRIXGB30wWCF1m6Q26VXoE/Nbsjx6yCU0wPpQw81lGzBcHAVqQKOdBSKiOj0uQLD
	2cKUIlg==
X-Received: by 2002:a05:600c:8b63:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4a961892781mr34341255e9.0.1793180880339;
        Wed, 28 Oct 2026 02:48:00 -0700 (PDT)
Received: from gandalf.magpie-herring.ts.net ([90.251.75.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd35c2sm26957431f8f.39.2026.10.28.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:47:59 -0700 (PDT)
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Doug Smythies <dsmythies@telus.net>,
	linux-kernel@vger.kernel.org,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Wed, 28 Oct 2026 09:46:59 +0000
Message-ID: <20261028094659.2321491-1-zakbrightonknight@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
References: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
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

On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
the CPUs stop using turbo after every suspend to RAM when intel_pstate
is in passive mode with the performance governor: they stay at the
2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
policy limits change or the system is rebooted.

During resume, the platform firmware sets each CPU's P-state request
register, MSR_IA32_PERF_CTL, to the base ratio (28).  Without
hardware-managed P-states (HWP), nothing in the passive mode writes it
again afterwards:

 - When the nonboot CPUs go offline during suspend,
   intel_cpufreq_cpu_offline() bails out because cpu->suspended is
   set, so the cached P-state (cpu->pstate.current_pstate) and
   policy->cur keep the values from before suspend.

 - When they come back online, cpufreq_set_policy() does not start the
   governor, because cpufreq_suspended is still set at that point.

 - cpufreq_resume() then calls intel_pstate_resume(), which does not
   touch the register without HWP, and starts the governor.  The
   performance governor asks for policy->max, which is equal to
   policy->cur, so __cpufreq_driver_target() returns without calling
   the driver.  Even if it did, intel_cpufreq_update_pstate() would
   skip the write, because the requested P-state matches the cached
   one.

Governors that change the request often, like schedutil, write the
register again shortly after resume, so they mostly hide the problem.
In the active mode, intel_pstate_set_policy() writes the register for
the nonboot CPUs when they come back online.

Fix this by adding a ->resume() callback to intel_cpufreq that writes
the cached P-state back to the register when HWP is not used, before
calling intel_pstate_resume().  The governor of the policy is not
running at that point, and the write is done under the policy rwsem,
so it cannot race with updates of the policy limits either.

The problem was found and root-caused, and this patch was drafted, with
the help of an AI coding assistant (Claude, by Anthropic) during a
performance review of the machine described above.

Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
---
Changes in v2:
- Only restore the request in the passive mode, from a new ->resume()
  callback of intel_cpufreq, and do it there unconditionally, as
  suggested by Rafael.  v1 did it in intel_pstate_resume() for both
  modes, where it could race with the active-mode util update hook, as
  reported by Sashiko.
- Hold the policy rwsem around the write.  The governor of the policy
  is stopped at that point, but cpufreq_resume() has already cleared
  cpufreq_suspended, so a policy->update work item (handle_update() ->
  refresh_frequency_limits() -> cpufreq_set_policy() ->
  cpufreq_governor_limits() -> ->limits()) can still get to
  intel_cpufreq_target() for the same CPU, for example after a limit
  change during resume, and its write could then be overwritten with
  the stale request.  This is the second case in Sashiko's report;
  please drop the lock if that cannot happen there.
- Describe the suspend/resume flow in the changelog, based on Rafael's
  explanation.  When the nonboot CPUs come back online during resume,
  cpufreq_init_governor() and cpufreq_start_governor() return early
  because cpufreq_suspended is still set, so the request is only
  dropped later, by the target_freq == policy->cur check in
  __cpufreq_driver_target() (see the debug messages below).
- Fixes: 4adcf2e5829f, after which the nonboot CPUs no longer go
  through ->init on online.  Before it, intel_cpufreq_cpu_init() reset
  PERF_CTL and policy->cur to the minimum when they came back, so the
  request after resume was written.

v1: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/

Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
with v7.3 plus this patch and a temporary module parameter, not part
of this patch, to turn the new write off, built with PROVE_LOCKING.
intel_pstate.c and the cpufreq core functions involved are the same
in v7.3 and in the base commit below.  Passive mode, performance
governor, one suspend to RAM and resume per row (rtcwake -m mem
-s 25), PERF_CTL read on all eight CPUs:

  fix  before resume   5 and 17 s after resume   single-thread clock
  off  38 on all       28 on all                 2.8 GHz
  on   28 on all       38 on all                 3.8 GHz
  on   38 on all       38 on all                 3.8 GHz

The second row started from the state the first one left: the restore
writes the cached request, which was still 38.  No lockdep reports,
and debug_locks was still 1 after the three cycles.

With dynamic debug enabled for cpufreq.c, cpufreq_performance.c and
intel_pstate.c, the online part of resume logged "governor switch" and
"governor change" for CPUs 1-7, but no cpufreq_init_governor() or
cpufreq_start_governor() messages and no frequency requests.  After
"Resuming Governors", every CPU logged cpufreq_start_governor(),
"setting to 3800000 kHz" and "CPU n: cur 3800000 kHz -> target
3800000 kHz", and there were no transition notifications at all, so
intel_cpufreq_target() was not called during resume.

In v1's testing, the active mode was back at 38 on all CPUs after
resume on this machine even without a restore.  Doug Smythies saw the
same on an i5-10600K with HWP disabled (passive mode affected, active
mode fine) and tested v1 there; v2 has not been tested on that
machine yet.  sparse was not run.
The tests were scripted and run by the same AI assistant.

 drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb..67a3015 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3408,6 +3408,27 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int intel_cpufreq_resume(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	/*
+	 * Without HWP, PERF_CTL is only written when the requested P-state
+	 * changes, but the platform firmware may have changed it during
+	 * resume, so write the last request back.  The governor is not
+	 * running yet, and holding the policy rwsem serializes this with
+	 * updates of the policy limits.
+	 */
+	if (!hwp_active && cpu->suspended) {
+		guard(cpufreq_policy_write)(policy);
+
+		intel_cpufreq_perf_ctl_update(cpu, cpu->pstate.current_pstate,
+					      false);
+	}
+
+	return intel_pstate_resume(policy);
+}
+
 static struct cpufreq_driver intel_cpufreq = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_cpufreq_verify_policy,
@@ -3418,7 +3439,7 @@ static struct cpufreq_driver intel_cpufreq = {
 	.offline	= intel_cpufreq_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.suspend	= intel_cpufreq_suspend,
-	.resume		= intel_pstate_resume,
+	.resume		= intel_cpufreq_resume,
 	.update_limits	= intel_pstate_update_limits,
 	.scale_freq_ref = intel_pstate_scale_freq_ref,
 	.name		= "intel_cpufreq",

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.56.0

