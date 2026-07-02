Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880633D4EC;
	Thu,  2 Jul 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016019; cv=none; b=HCRfoSGv7UzZH/PfWy1QxEWZyTHFGik6Nv4OP+gZuu23UGHTRPFJBA8eRaJQhmXLHDNnXjBChMJIma7DRSmUQZehJ72MBryyMRfjBXxNDcnoY0/TcVHMJB5VfouxeDz0oNecXLwdmz5zP4DjI6pf+egAlykmt1adq9A/JkZlqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016019; c=relaxed/simple;
	bh=ub5U5Slcr22Uyzzlejkfq3s5FZb5yuMVlTsdXqwoMAI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Dic4kyUcN5sO5OfCWvb/6t8EHeASryPdKgLQNFTrXqe5v7xs4BZZOR+QmUbt+EQ7pEPoL2YvigXPGpTgY5i62ezqEvkTpJbb3Pk7TrXkXHZVoX5+6YTLrc/vkDg5ol+eF+7Y2kqIyroqgwsKkOxLLMkCsVmUVHMl1cJ7sCtAShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=h11TFcjf; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="h11TFcjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783016007;
	bh=FxsLMBtnbEMHfYtH6sL2Gn7Yq7J6SKVu65F4DcQd6Vg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=h11TFcjfUi9mHZq41xzQqXfwpoMVnwksW52qt3V4Vd02fD5FyQLVEyygMYpCCl31l
	 94HCnAlC/ubfNXkR7TKlShc0VYjs4bdRVl+U1ZyPelp9Z6peABRVpK+v4HdzX1u4y8
	 LqOEEGW4JWdlOK6B5TJOB8ufaH9aOQbp+juBUJig=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4grlPM1TdTz6vNX;
	Thu, 02 Jul 2026 18:13:27 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4grlPL2KCqz4y2q;
	Thu, 02 Jul 2026 18:13:26 +0000 (UTC)
Date: Thu, 02 Jul 2026 19:13:26 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <akYq1YaCpZ0b4SBS@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local> <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net> <akYq1YaCpZ0b4SBS@pathway.suse.cz>
Message-ID: <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 2, 2026 10:09:41 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
>> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
>> wrote:
>> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
>> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> >> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before
>stopping
>> >the
>> >> > > other CPUs. Do not ask sys_info() to handle that bit again later
>in
>> >the
>> >> > > panic path.
>> >> > > 
>> >> > > Use sys_info_with_filter() so panic_print=all_bt does not request
>> >more
>> >> > > output after the CPUs are stopped.
>> >> > > 
>> >> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys
>> >info on system lockup")
>> >> > > Cc: stable@vger.kernel.org
>> >> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >> > > ---
>> >> > >  kernel/panic.c | 2 +-
>> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> > > 
>> >> > > diff --git a/kernel/panic.c b/kernel/panic.c
>> >> > > index 213725b612aa..eb842823df61 100644
>> >> > > --- a/kernel/panic.c
>> >> > > +++ b/kernel/panic.c
>> >> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>> >> > >  	 */
>> >> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> >> > >  
>> >> > > -	sys_info(panic_print);
>> >> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
>> >> > 
>> >> > Hmm, this prevents printing backtraces from all CPUs completely.
>> >> > But what if they were not printed?
>> >> > 
>> >> > They might be printed by:
>> >> > 
>> >> > static void panic_other_cpus_shutdown(bool crash_kexec)
>> >> > {
>> >> > 	if (panic_print & SYS_INFO_ALL_BT)
>> >> > 		panic_trigger_all_cpu_backtrace();
>> >> > 
>> >> > [...]
>> >> > }
>> >> > 
>> >> > But it checks only "panic_print" variable. It won't do anything
>> >> > when (panic_print == 0).
>> >> > 
>> >> > In this case, we might still want to print the backraces when
>> >> > SYS_INFO_ALL_BT is set in kernel_si_info.
>> >> > 
>> >> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>> >> > 
>> >> > Of course, we might fix panic_other_cpus_shutdown() to check also
>> >> > kernel_si_info.
>> >> > 
>> >> > But it all becomes very hairy. We have several levels:
>> >> > 
>> >> >    + watchdog-all_bt-specific option, e.g.
>> >sysctl_hardlockup_all_cpu_backtrace
>> >> > 
>> >> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>> >> > 
>> >> >    + panic-specific si_info: panic_print
>> >> > 
>> >> >    + universal fallback for any layer: kernel_si_info
>> >> > 
>> >> > Now, we try to check all these variables back and forth to
>> >> > trigger all backtraces or to avoid triggering them.
>> >> > And it clearly does not work well and the code is more and more
>> >> > hairy.
>> >> > 
>> >> > I think about another approach. The word "waterfall" comes to my
>mind.
>> >> > Instead of checking all the settings back and forth, let's process
>> >> > each setting one by one and just remember what has been done and
>> >> > skip this in the next level.
>> >> > 
>> >> > All the si_info actions seems to dump a global system state.
>> >> > So, it would make sense to remember the state in a global variable
>> >> > even when it might be modified by more CPUs in parallel.
>> >> > 
>> >> > I am going to think more about it.
>> >> 
>> >> I have created a POC using Gemini. I haven't tested it.
>> >> But it looks acceptable. And the logic seems to be more
>> >> straightforward.
>> >> 
>> >> One drawback is that it requires adding the _reset()
>> >> call for all sys_info() callers. It is fine in principle
>> >> but it might complicate back-porting because all changes
>> >> have to be done in one patch.
>> >> 
>> >> But honestly, this is a nice to have fix. Most people could
>> >> live happily without it.
>> >> 
>> >> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00
>2001
>> >> From: Petr Mladek <pmladek@suse.com>
>> >> Date: Fri, 26 Jun 2026 13:55:41 +0200
>> >> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent
>> >duplicate
>> >>  backtraces
>> >> 
>> >> In watchdog, panic, and hung task detection scenarios, sys_info() can
>> >> be called multiple times or alongside direct backtrace triggers like
>> >> trigger_allbutcpu_cpu_backtrace(). This results in identical
>backtraces
>> >> being dumped repeatedly from all CPUs, cluttering the kernel log and
>> >> delaying or obscuring critical debug details.
>> >> 
>> >> Introduce a state tracking bitmask and associated helpers:
>> >> - sys_info_done(mask): Marks specific sys_info bits as already
>printed.
>> >> - sys_info_reset(): Resets the tracking state.
>> >> - sys_info_is_done(mask): Checks if all bits in the mask have been
>> >printed.
>> >> 
>> >> Update sys_info() to automatically filter out already printed bits
>> >> using this state. Integrate these APIs with the generic hardlockup
>> >> and softlockup watchdogs, the PowerPC watchdog, the hung task
>detector,
>> >> and the panic core. This ensures that each piece of system
>information
>> >> and backtrace output is printed at most once per lockup/panic event,
>> >> and the state is reset cleanly when a lockup does not trigger a
>panic.
>> >> 
>> >> Races between sys_info() callers are ignored. It should be acceptable
>> >> because the output from various watchdogs has never been
>synchronized.
>> >> And panic() never returns.
>> >> 
>> >> Assisted-by: gemini-1.5-flash
>> >> Signed-off-by: Petr Mladek <pmladek@suse.com>
>> >
>> >Yep. There are cases that people want panic on task-hung or sw/hw
>lockup,
>> >and this could remove much duplication of sys info dump, thanks!
>> >
>> >Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
>> 
>> Thanks,
>> 
>> im feeling a new file to do all the force panic jazz, but putting tape
>> on sys_info.c isn't bd either.
>
>I wonder how to move forward with this.
>
>Honestly, I am not sure what exactly you mean by creating another
>API for tracking the reports so I could not judge it. Feel free
>to sent some POC.
>
>Otherwise, I would go with my proposal to remember the printed states
>by the sys_info API. I am not sure whether I should send a proper
>patch or you would like to somehow improve it.
>
>Best Regards,
>Petr
>


sup petr, here's my poc


This should make my entire thing make sense

From eb587ed749ff5993c517f29799b369185c5ee7d8 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Thu, 2 Jul 2026 18:09:23 +0000
Subject: [POC] sys_info: Introduce incident state-tracking to prevent
 duplicate diagnostics

In watchdog, panic, and hung task detection scenarios, sys_info()
can be called multiple times or alongside direct debug output
functions (like trigger_allbutcpu_cpu_backtrace(), print_modules(),
print_irqtrace_events(), and dump_stack()). This leads to identical
diagnostics and stack traces being dumped repeatedly, cluttering the
kernel log and delaying critical panics.

Introduce a state tracking bitmask and helpers in a new file,
lib/sys_info_filter.c:
- sys_info_filter_and_set(mask): Atomically tests which bits in a mask
  have not yet been printed during the current incident, marks them as
  printed, and returns that subset.
- sys_info_reset(): Clears the printed mask state.

Add SYS_INFO_MODULES, SYS_INFO_IRQTRACE, and SYS_INFO_STACK flags to
include/linux/sys_info.h, and handle them inside sys_info's diagnostic
dispatch.

Update the watchdogs, hung task detector, and panic core to call
sys_info_filter_and_set() to deduplicate their diagnostic printouts, and
sys_info_reset() when a warning incident concludes (e.g., when a stuck
CPU recovers, or a new hung task check round begins).

This ensures each piece of system diagnostic is printed at most once per
lockup/panic event, preventing console log spam.

Assisted-by: Gemini:gemini-3.5-flash
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/powerpc/kernel/watchdog.c |  21 +++++-
 include/linux/sys_info.h       |   6 ++
 kernel/hung_task.c             |   4 +-
 kernel/panic.c                 |   9 ++-
 kernel/watchdog.c              |  24 ++++++-
 lib/Makefile                   |   2 +-
 lib/sys_info.c                 |  38 ++---------
 lib/sys_info_filter.c          | 120 +++++++++++++++++++++++++++++++++
 8 files changed, 184 insertions(+), 40 deletions(-)
 create mode 100644 lib/sys_info_filter.c

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..31035e28676a 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -160,6 +160,10 @@ static void wd_lockup_ipi(struct pt_regs *regs)
 	else
 		dump_stack();
 
+	/* Mark what we already printed so panic() won't repeat it. */
+	sys_info_filter_and_set(SYS_INFO_MODULES | SYS_INFO_IRQTRACE |
+				SYS_INFO_STACK);
+
 	/*
 	 * __wd_nmi_output must be set after we printk from NMI context.
 	 *
@@ -238,7 +242,8 @@ static void watchdog_smp_panic(int cpu)
 
 	if (sysctl_hardlockup_all_cpu_backtrace ||
 	    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
-		trigger_allbutcpu_cpu_backtrace(cpu);
+		if (sys_info_filter_and_set(SYS_INFO_ALL_BT))
+			trigger_allbutcpu_cpu_backtrace(cpu);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	} else {
 		/*
@@ -254,6 +259,8 @@ static void watchdog_smp_panic(int cpu)
 	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
+	else
+		sys_info_reset();
 
 	wd_end_reporting();
 
@@ -416,15 +423,23 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 		print_irqtrace_events(current);
 		show_regs(regs);
 
+		/* Mark what we already printed so panic() won't repeat it. */
+		sys_info_filter_and_set(SYS_INFO_MODULES | SYS_INFO_IRQTRACE |
+					SYS_INFO_STACK);
+
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
 		if (sysctl_hardlockup_all_cpu_backtrace ||
-		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
-			trigger_allbutcpu_cpu_backtrace(cpu);
+		    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
+			if (sys_info_filter_and_set(SYS_INFO_ALL_BT))
+				trigger_allbutcpu_cpu_backtrace(cpu);
+		}
 
 		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
+		else
+			sys_info_reset();
 
 		wd_end_reporting();
 	}
diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..f5a1b699143b 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -16,8 +16,14 @@
 #define SYS_INFO_PANIC_CONSOLE_REPLAY	0x00000020
 #define SYS_INFO_ALL_BT			0x00000040
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
+#define SYS_INFO_MODULES		0x00000100
+#define SYS_INFO_IRQTRACE		0x00000200
+#define SYS_INFO_STACK			0x00000400
 
 void sys_info(unsigned long si_mask);
+unsigned long sys_info_effective_mask(unsigned long mask);
+unsigned long sys_info_filter_and_set(unsigned long si_mask);
+void sys_info_reset(void);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9..7a3738279503 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -557,8 +557,10 @@ static int watchdog(void *dummy)
 		t = hung_timeout_jiffies(hung_last_checked, interval);
 		if (t <= 0) {
 			if (!atomic_xchg(&reset_hung_task, 0) &&
-			    !hung_detector_suspended)
+			    !hung_detector_suspended) {
+				sys_info_reset();
 				check_hung_uninterruptible_tasks(timeout);
+			}
 			hung_last_checked = jiffies;
 			continue;
 		}
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..94ce7a94f118 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -550,8 +550,12 @@ static void panic_trigger_all_cpu_backtrace(void)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_BT)
-		panic_trigger_all_cpu_backtrace();
+	unsigned long mask = sys_info_effective_mask(panic_print);
+
+	if (mask & SYS_INFO_ALL_BT) {
+		if (sys_info_filter_and_set(SYS_INFO_ALL_BT))
+			panic_trigger_all_cpu_backtrace();
+	}
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
@@ -649,6 +653,7 @@ void vpanic(const char *fmt, va_list args)
 		panic_this_cpu_backtrace_printed = true;
 	} else if (IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) {
 		dump_stack();
+		sys_info_filter_and_set(SYS_INFO_STACK);
 		panic_this_cpu_backtrace_printed = true;
 	}
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..3bc6f5fd5380 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -280,8 +280,13 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		trigger_single_cpu_backtrace(cpu);
 	}
 
+	/* Mark what we already printed so panic() won't repeat it. */
+	sys_info_filter_and_set(SYS_INFO_MODULES | SYS_INFO_IRQTRACE |
+				SYS_INFO_STACK);
+
 	if (hardlockup_all_cpu_backtrace) {
-		trigger_allbutcpu_cpu_backtrace(cpu);
+		if (sys_info_filter_and_set(SYS_INFO_ALL_BT))
+			trigger_allbutcpu_cpu_backtrace(cpu);
 		if (!hardlockup_panic)
 			clear_bit_unlock(0, &hard_lockup_nmi_warn);
 	}
@@ -289,6 +294,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
 	if (hardlockup_panic)
 		nmi_panic(regs, "Hard LOCKUP");
+	else
+		sys_info_reset();
 
 	per_cpu(watchdog_hardlockup_warned, cpu) = true;
 }
@@ -792,6 +799,8 @@ static int softlockup_fn(void *data)
 }
 
 /* watchdog kicker functions */
+static DEFINE_PER_CPU(bool, watchdog_stuck_previously);
+
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	unsigned long touch_ts, period_ts, now;
@@ -864,6 +873,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	touch_ts = __this_cpu_read(watchdog_touch_ts);
 	duration = is_softlockup(touch_ts, period_ts, now);
 	if (unlikely(duration)) {
+		__this_cpu_write(watchdog_stuck_previously, true);
 #ifdef CONFIG_SYSFS
 		++softlockup_count;
 #endif
@@ -893,8 +903,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			dump_stack();
 		printk_cpu_sync_put_irqrestore(flags);
 
+		/* Mark what we already printed so panic() won't repeat it. */
+		sys_info_filter_and_set(SYS_INFO_MODULES | SYS_INFO_IRQTRACE |
+					SYS_INFO_STACK);
+
 		if (softlockup_all_cpu_backtrace) {
-			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
+			if (sys_info_filter_and_set(SYS_INFO_ALL_BT))
+				trigger_allbutcpu_cpu_backtrace(smp_processor_id());
 			if (!softlockup_panic)
 				clear_bit_unlock(0, &soft_lockup_nmi_warn);
 		}
@@ -905,6 +920,11 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		if (softlockup_panic && thresh_count >= softlockup_panic)
 			panic("softlockup: hung tasks");
+	} else {
+		if (__this_cpu_read(watchdog_stuck_previously)) {
+			__this_cpu_write(watchdog_stuck_previously, false);
+			sys_info_reset();
+		}
 	}
 
 	return HRTIMER_RESTART;
diff --git a/lib/Makefile b/lib/Makefile
index 7f75cc6edf94..521644a140c8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -40,7 +40,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o iomem_copy.o sys_info.o
+	 buildid.o objpool.o iomem_copy.o sys_info.o sys_info_filter.o
 
 lib-$(CONFIG_UNION_FIND) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..e188c5d924cb 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -2,12 +2,9 @@
 #include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
-#include <linux/console.h>
 #include <linux/log2.h>
 #include <linux/kernel.h>
-#include <linux/ftrace.h>
-#include <linux/nmi.h>
-#include <linux/sched/debug.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sysctl.h>
 
@@ -22,6 +19,9 @@ static const char * const si_names[] = {
 	[ilog2(SYS_INFO_PANIC_CONSOLE_REPLAY)]	= "",
 	[ilog2(SYS_INFO_ALL_BT)]		= "all_bt",
 	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
+	[ilog2(SYS_INFO_MODULES)]		= "modules",
+	[ilog2(SYS_INFO_IRQTRACE)]		= "irqtrace",
+	[ilog2(SYS_INFO_STACK)]			= "stack",
 };
 
 /*
@@ -29,7 +29,7 @@ static const char * const si_names[] = {
  * If a kernel module calls sys_info() with "parameter == 0", then
  * this mask will be used.
  */
-static unsigned long kernel_si_mask;
+unsigned long kernel_si_mask;
 
 /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
 unsigned long sys_info_parse_param(char *str)
@@ -136,31 +136,7 @@ static int __init sys_info_sysctl_init(void)
 subsys_initcall(sys_info_sysctl_init);
 #endif
 
-static void __sys_info(unsigned long si_mask)
+unsigned long sys_info_effective_mask(unsigned long mask)
 {
-	if (si_mask & SYS_INFO_TASKS)
-		show_state();
-
-	if (si_mask & SYS_INFO_MEM)
-		show_mem();
-
-	if (si_mask & SYS_INFO_TIMERS)
-		sysrq_timer_list_show();
-
-	if (si_mask & SYS_INFO_LOCKS)
-		debug_show_all_locks();
-
-	if (si_mask & SYS_INFO_FTRACE)
-		ftrace_dump(DUMP_ALL);
-
-	if (si_mask & SYS_INFO_ALL_BT)
-		trigger_all_cpu_backtrace();
-
-	if (si_mask & SYS_INFO_BLOCKED_TASKS)
-		show_state_filter(TASK_UNINTERRUPTIBLE);
-}
-
-void sys_info(unsigned long si_mask)
-{
-	__sys_info(si_mask ? : kernel_si_mask);
+	return mask ? : READ_ONCE(kernel_si_mask);
 }
diff --git a/lib/sys_info_filter.c b/lib/sys_info_filter.c
new file mode 100644
index 000000000000..b07b5dc3ce3c
--- /dev/null
+++ b/lib/sys_info_filter.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sys_info incident diagnostic engine.
+ *
+ * Centralises the dispatching and deduplication of system diagnostic
+ * output (task lists, memory info, backtraces, module lists, etc.)
+ * that is requested during lockups, hung tasks, and panics.
+ *
+ * A global bitmask tracks which categories have already been printed
+ * during the current incident so that duplicate output is suppressed
+ * when multiple subsystems request the same diagnostics (e.g. a
+ * watchdog fires, prints sys_info, then calls panic() which tries
+ * to print sys_info again).
+ */
+#include <linux/console.h>
+#include <linux/ftrace.h>
+#include <linux/kernel.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/sched/debug.h>
+
+#include <linux/sys_info.h>
+
+/*
+ * Bitmask of sys_info categories already printed during the current
+ * incident.  Accessed locklessly via cmpxchg — races between CPUs
+ * during a lockup are tolerable because the output from different
+ * watchdogs has never been synchronised, and panic() never returns.
+ */
+static unsigned long sys_info_printed;
+
+/**
+ * sys_info_filter_and_set - atomically claim unprinted sys_info bits
+ * @si_mask: requested diagnostics bitmask
+ *
+ * Returns the subset of @si_mask that has NOT been printed yet during
+ * the current incident and marks those bits as printed.  Returns 0
+ * if everything requested was already printed.
+ */
+unsigned long sys_info_filter_and_set(unsigned long si_mask)
+{
+	unsigned long old, new;
+
+	if (!si_mask)
+		return 0;
+
+	do {
+		old = READ_ONCE(sys_info_printed);
+		if (!(si_mask & ~old))
+			return 0;
+		new = old | si_mask;
+	} while (cmpxchg(&sys_info_printed, old, new) != old);
+
+	return si_mask & ~old;
+}
+
+/**
+ * sys_info_reset - clear the printed-state bitmask
+ *
+ * Called when an incident is over (lockup recovered, hung-task check
+ * round starts fresh) so that subsequent incidents produce output.
+ */
+void sys_info_reset(void)
+{
+	WRITE_ONCE(sys_info_printed, 0);
+}
+
+/*
+ * Dispatch the actual diagnostic output for each bit in @si_mask.
+ */
+static void __sys_info(unsigned long si_mask)
+{
+	if (si_mask & SYS_INFO_TASKS)
+		show_state();
+
+	if (si_mask & SYS_INFO_MEM)
+		show_mem();
+
+	if (si_mask & SYS_INFO_TIMERS)
+		sysrq_timer_list_show();
+
+	if (si_mask & SYS_INFO_LOCKS)
+		debug_show_all_locks();
+
+	if (si_mask & SYS_INFO_FTRACE)
+		ftrace_dump(DUMP_ALL);
+
+	if (si_mask & SYS_INFO_ALL_BT)
+		trigger_all_cpu_backtrace();
+
+	if (si_mask & SYS_INFO_BLOCKED_TASKS)
+		show_state_filter(TASK_UNINTERRUPTIBLE);
+
+	if (si_mask & SYS_INFO_MODULES)
+		print_modules();
+
+	if (si_mask & SYS_INFO_IRQTRACE)
+		print_irqtrace_events(current);
+
+	if (si_mask & SYS_INFO_STACK)
+		dump_stack();
+}
+
+/**
+ * sys_info - print system diagnostics, suppressing duplicates
+ * @si_mask: requested diagnostics bitmask (0 = use kernel_si_info default)
+ *
+ * Resolves the effective mask (falling back to the kernel-wide default
+ * when @si_mask is 0), filters out anything already printed during this
+ * incident, and dispatches the remaining diagnostics.
+ */
+void sys_info(unsigned long si_mask)
+{
+	unsigned long mask = sys_info_effective_mask(si_mask);
+	unsigned long filtered = sys_info_filter_and_set(mask);
+
+	if (filtered)
+		__sys_info(filtered);
+}
-- 
2.53.0



NOTE!!: This is AI generated!! This **MAY** not be the finished product,
this is ONLY the model!




Thanks!
