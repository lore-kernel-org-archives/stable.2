Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B23E024F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476067; cv=none; b=Po2yc+doFROpJcbPIxCNg58OywVZoRN/K+bXQR4d5iKRYK19G2TYTusHwPZvQNR9qt8BO7GMfOYXiFd/mkJTl+SfvDoAmBlyq6eaKeWHeUm05TzXpM5OWvh7xKqDmmPQS6We+47ADPxlGHXkxPeZBNQJI0DD53+24OiDT2iUM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476067; c=relaxed/simple;
	bh=DGipEDR//5xFiqYeIajqbDpfVvLfvoccnKRmc+6KTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRQeQMZ5NjYPT+VGIvbgI50vTGNy969fQJdaPrV71qshiRiBHAOSz6k6aXQSWaUhBgHziqMVI6PtmhZxvoBWx0/58E3D0IfXKSTa8fU7GKUNXyjvZYOiA87Q9tr77kgFNcOYqkBC8FVAfhtDn5tQAogN1t8ab1GiOF7HuJJ35qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eKC6tbQi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eKC6tbQi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241a577d8so6914605e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782476063; x=1783080863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjl2FPPtqEHGhd+GEghxm12pdfamoCPEZKx/cBv47Y8=;
        b=eKC6tbQiXJiZEKA7RnqrzJ3KbzPldt0M1V3Yn1TOapo53cA1irduwyhU+Spn5tjNR6
         QsHK9vPwFhZo3S6DqWTk76ChXezueRWjDv4aVaiJejilco2vvybUJfHyxjG4m/SZd30i
         1fcrrfY+Tkeo4BMHJptvhRzP2doo+c0sOQkd4ruvJHRNMStU799Z2tH6B12VosZbIR0j
         Rtfdn2Ms/xpNqEmQjd+gjs3C9jJe1JlQ/xKGe3WkjXWZsOD+Klofdl+463zECBcGn3gr
         cqEajrdTJTvO2z7S1lr446L/R50UOeJhTj1ZIvofdS04XdiHodg8PJe3t7A6hKxooGHZ
         OD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476063; x=1783080863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjl2FPPtqEHGhd+GEghxm12pdfamoCPEZKx/cBv47Y8=;
        b=U+Lnmvoql3sSmHEvL9AgVKYi9wFGmUkrzzrx4aiEulhAefS3gIdIECe900M8uaSflf
         o7npCqgRXc0qx9fbhLpdu1LHFct7mj5YjEWDmMqaxcofI2dNyr9RQ15+wSDXKAaMaG/w
         8aR3Mchw8AjfjE+o/K3k3CCyM3KAScsWDfEKtL72YBGt3lGIisyBI6G4OvSF8alN7VxD
         taF5CFoTAFdItAbDmdA5Sma5tgDfLxflrBgYfg59inNfJMMt3WPrcEiTxWJDJDQtpHzz
         EuYz48+UpEcoP1f7OhnoJUbmJHQvT5apzF2fc7bbOm8V/45qfyklmMzDRMI8VxV9Xq5k
         8ilg==
X-Forwarded-Encrypted: i=1; AFNElJ/BA6h46iIkWclEToZLQbxJKK0T4nciN8jUiYw1o3LrS3EGa9Q9OrEm7knxX7UnQ4ISB5AKSpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOGtk/yEhRpf6/FGQiNCDAnMtTpoXyuRL/g0Uk/OVglvjCZ88
	MVU7MRuYJKL3vZzvsvwcsmirNJPHfxXoyzN2a1MTk9IC37NFh/e7oaVJR2svEOyEens=
X-Gm-Gg: AfdE7cktjYePCW754zwRLrpJdtC4Uh3cW8sWcZf4atc3of20//IaL6+jcxxZ+5kPZMJ
	OZMBrdgRlg+pt16K7acfbOi3BMBcyHgmQEm08jAtY2qIG6obJMYLDzHJGbty1VAhc3BjBw98ooZ
	LJ1cYHQhmQSIsTmxc2iJ5CoXO9NIYdVluTAZGguPQke/3WDe2x7WS/4PcBCYnOUHDD/80sUVuM3
	Q3z3hDeUwUZ858b+9BVX1A9aYLOmmg8ybFnWAqIa3BN1Da47yUeMzFQejL7r5cyT8bNZ0eYzzsb
	+ZZq6OCoIwwsYs7bkiT7FGQIQEyPMrJdSWqKFbkyDJs96iamjmdY9qaCpNr08tux9nUfRVssrbG
	LMrpQULPqhFyhOcnmIojURPk1roDokF9LZ9IGFXna2POAOtVgBxMlaDqIrJJ1YtzqrUH8NNnvod
	GExR2YujlZRtnQQBM=
X-Received: by 2002:a05:600c:a013:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-49266892207mr98845105e9.33.1782476062967;
        Fri, 26 Jun 2026 05:14:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c2954efsm33944365e9.2.2026.06.26.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:14:22 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:14:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <aj5tFiwhRqPkAkqU@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj5TNB8cRtMNTtIT@pathway.suse.cz>

On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> > other CPUs. Do not ask sys_info() to handle that bit again later in the
> > panic path.
> > 
> > Use sys_info_with_filter() so panic_print=all_bt does not request more
> > output after the CPUs are stopped.
> > 
> > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/panic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 213725b612aa..eb842823df61 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> >  	 */
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >  
> > -	sys_info(panic_print);
> > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> 
> Hmm, this prevents printing backtraces from all CPUs completely.
> But what if they were not printed?
> 
> They might be printed by:
> 
> static void panic_other_cpus_shutdown(bool crash_kexec)
> {
> 	if (panic_print & SYS_INFO_ALL_BT)
> 		panic_trigger_all_cpu_backtrace();
> 
> [...]
> }
> 
> But it checks only "panic_print" variable. It won't do anything
> when (panic_print == 0).
> 
> In this case, we might still want to print the backraces when
> SYS_INFO_ALL_BT is set in kernel_si_info.
> 
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> 
> Of course, we might fix panic_other_cpus_shutdown() to check also
> kernel_si_info.
> 
> But it all becomes very hairy. We have several levels:
> 
>    + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
> 
>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> 
>    + panic-specific si_info: panic_print
> 
>    + universal fallback for any layer: kernel_si_info
> 
> Now, we try to check all these variables back and forth to
> trigger all backtraces or to avoid triggering them.
> And it clearly does not work well and the code is more and more
> hairy.
> 
> I think about another approach. The word "waterfall" comes to my mind.
> Instead of checking all the settings back and forth, let's process
> each setting one by one and just remember what has been done and
> skip this in the next level.
> 
> All the si_info actions seems to dump a global system state.
> So, it would make sense to remember the state in a global variable
> even when it might be modified by more CPUs in parallel.
> 
> I am going to think more about it.

I have created a POC using Gemini. I haven't tested it.
But it looks acceptable. And the logic seems to be more
straightforward.

One drawback is that it requires adding the _reset()
call for all sys_info() callers. It is fine in principle
but it might complicate back-porting because all changes
have to be done in one patch.

But honestly, this is a nice to have fix. Most people could
live happily without it.

From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 26 Jun 2026 13:55:41 +0200
Subject: [POC] sys_info: Introduce state-tracking APIs to prevent duplicate
 backtraces

In watchdog, panic, and hung task detection scenarios, sys_info() can
be called multiple times or alongside direct backtrace triggers like
trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
being dumped repeatedly from all CPUs, cluttering the kernel log and
delaying or obscuring critical debug details.

Introduce a state tracking bitmask and associated helpers:
- sys_info_done(mask): Marks specific sys_info bits as already printed.
- sys_info_reset(): Resets the tracking state.
- sys_info_is_done(mask): Checks if all bits in the mask have been printed.

Update sys_info() to automatically filter out already printed bits
using this state. Integrate these APIs with the generic hardlockup
and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
and the panic core. This ensures that each piece of system information
and backtrace output is printed at most once per lockup/panic event,
and the state is reset cleanly when a lockup does not trigger a panic.

Races between sys_info() callers are ignored. It should be acceptable
because the output from various watchdogs has never been synchronized.
And panic() never returns.

Assisted-by: gemini-1.5-flash
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/powerpc/kernel/watchdog.c | 13 ++++++++++---
 include/linux/sys_info.h       |  3 +++
 kernel/hung_task.c             |  2 ++
 kernel/panic.c                 |  4 +++-
 kernel/watchdog.c              | 10 ++++++++--
 lib/sys_info.c                 | 30 +++++++++++++++++++++++++++++-
 6 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..0eab7894b9dc 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -239,6 +239,7 @@ static void watchdog_smp_panic(int cpu)
 	if (sysctl_hardlockup_all_cpu_backtrace ||
 	    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
 		trigger_allbutcpu_cpu_backtrace(cpu);
+		sys_info_done(SYS_INFO_ALL_BT);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	} else {
 		/*
@@ -251,10 +252,12 @@ static void watchdog_smp_panic(int cpu)
 		}
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info(hardlockup_si_mask);
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
 
+	sys_info_reset();
+
 	wd_end_reporting();
 
 	return;
@@ -419,13 +422,17 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
 		if (sysctl_hardlockup_all_cpu_backtrace ||
-		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
+		    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
 			trigger_allbutcpu_cpu_backtrace(cpu);
+			sys_info_done(SYS_INFO_ALL_BT);
+		}
 
-		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info(hardlockup_si_mask);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
+		sys_info_reset();
+
 		wd_end_reporting();
 	}
 	/*
diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..ad43548c75dd 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,9 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_done(unsigned long si_mask);
+void sys_info_reset(void);
+bool sys_info_is_done(unsigned long si_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9..dbb6a27770f5 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -354,6 +354,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 
 	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
+
+	sys_info_reset();
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..86ce17f03da2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -550,8 +550,10 @@ static void panic_trigger_all_cpu_backtrace(void)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_BT)
+	if ((panic_print & SYS_INFO_ALL_BT) && !sys_info_is_done(SYS_INFO_ALL_BT)) {
 		panic_trigger_all_cpu_backtrace();
+		sys_info_done(SYS_INFO_ALL_BT);
+	}
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..f431087c68a7 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -282,14 +282,17 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 
 	if (hardlockup_all_cpu_backtrace) {
 		trigger_allbutcpu_cpu_backtrace(cpu);
+		sys_info_done(SYS_INFO_ALL_BT);
 		if (!hardlockup_panic)
 			clear_bit_unlock(0, &hard_lockup_nmi_warn);
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info(hardlockup_si_mask);
 	if (hardlockup_panic)
 		nmi_panic(regs, "Hard LOCKUP");
 
+	sys_info_reset();
+
 	per_cpu(watchdog_hardlockup_warned, cpu) = true;
 }
 
@@ -895,16 +898,19 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		if (softlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
+			sys_info_done(SYS_INFO_ALL_BT);
 			if (!softlockup_panic)
 				clear_bit_unlock(0, &soft_lockup_nmi_warn);
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info(softlockup_si_mask);
 		thresh_count = duration / get_softlockup_thresh();
 
 		if (softlockup_panic && thresh_count >= softlockup_panic)
 			panic("softlockup: hung tasks");
+
+		sys_info_reset();
 	}
 
 	return HRTIMER_RESTART;
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..f8e6176fae75 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -160,7 +160,35 @@ static void __sys_info(unsigned long si_mask)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
+static unsigned long sys_info_done_mask;
+
+void sys_info_done(unsigned long si_mask)
+{
+	sys_info_done_mask |= si_mask;
+}
+
+void sys_info_reset(void)
+{
+	sys_info_done_mask = 0;
+}
+
+bool sys_info_is_done(unsigned long si_mask)
+{
+	return (sys_info_done_mask & si_mask) == si_mask;
+}
+
 void sys_info(unsigned long si_mask)
 {
-	__sys_info(si_mask ? : kernel_si_mask);
+	unsigned long mask;
+
+	if (si_mask)
+		mask = si_mask & ~sys_info_done_mask;
+	else
+		mask = kernel_si_mask & ~sys_info_done_mask;
+
+	if (!mask)
+		return;
+
+	__sys_info(mask);
+	sys_info_done(mask);
 }
-- 
2.54.0
