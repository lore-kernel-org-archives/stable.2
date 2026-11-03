Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737252;
	b=addtBbBDxsHYmeby6TiEpPZShjUMbAxgyFweBhOzRrty7FxanYkeO9BVCkVFgWh4p+EW
	 b83R5llJ2W9SXP0otGW8TpLWm33TVsej3aImMcI+uefcWvZy8/neO6fVNsZBPvckTZc2G
	 oIIwKJwoPut1gGSaucmZVS9/WdyZugFdf2vmAnpoFuszkFoEOGkzhmlSdsq3DLaPcfVxt
	 7bhPtpRaMaqG9qqZjM6xzG9AVJ7whHUPnvweNG5MhBrE8/6R6SUNeOkQCEWfisfYTFSX+
	 c+kGbNBLuiBV77j6GCjp/yN5dOtglak0u67WCYITFUtekvehkV8MjDP8gTU8DupZXlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=sDo6TDFkQ9uSctLBPvuoBtBBuRJVFhbyIu0XzsnfNOE=;
	b=YSdYxjKPQIAnDnHKsg1tMTnonb88ugx2h7CmBYUNcG/PWW+0QAJpj4ZDQoKCTrT4pr57
	 fn2YIgeME0P6Rft9dEthRh/9JqDeTwvcyR1D5IrR0Gp8EBYdbGr0srMMX9zeGPa74RDHm
	 KBPvHbmYG+09nog2couJXhN+LuZ3vkOzc7UHzHD3+6f73z22kTYUwn3paYlJghKz9rRVF
	 cGQQkVKoWewSNyCrHXA0FosWkPCLNR06XMzJIjfvNqOxfOp/4ZYXBvD62P1BkRcZkuBKc
	 qB6NnqQkJhaokrpK42fMT9MDBhDlvS0z6LQc7ygb/4ygaR/QMrGtB7O0mk8vWwWvvzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iqV0/Y4y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59120606A324;
	Tue,  3 Nov 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqV0/Y4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667571F000C1;
	Tue,  3 Nov 2026 20:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737252;
	bh=sDo6TDFkQ9uSctLBPvuoBtBBuRJVFhbyIu0XzsnfNOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iqV0/Y4yOOhqqN30gEsyj0UsLqtz3B6eNqLqbFkI6IpiCECIAWPEYYLaPInNpVr+z
	 7/IIiRAKxzKPE9iBv8JNxKwHzLcKxWktsWgBZG/FurB3A5FT69Gl06TQN5M7+q+ZL6
	 uMIhCcTEunW22ow9cvMa3B94SkUsUvKvdhLFT9rbI8oLpkV47GWpjF4DKmqUyQh82s
	 x6VfP19jqdUnFwYrbueI8McuqdCLbk0RYF6yRHINgFiECmViS6lC/EpF/OjkXymT8y
	 ytlxow1WTFuDRgSYK4tLy5eG/cG2Z+aP5AhLo5hlt3pEiMQ6W1hTYYLyPP3R6T6apT
	 xtGfRdG/Vudxg==
From: Thomas Gleixner <tglx@kernel.org>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, John
 Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Srikanth Aithal <Srikanth.Aithal@amd.com>, Borislav Petkov <bp@alien8.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org, Mani Tofigh
 <mt4022@columbia.edu>
Subject: Re: [PATCH] clocksource: Use the clocksource under test for the
 skew check timeout
In-Reply-To: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
References: <20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu>
Date: Tue, 03 Nov 2026 21:20:49 +0100
Message-ID: <878q39y8da.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 02 2026 at 16:45, Mani Tofigh via wrote:
> watchdog_check_skew() waits for the remote CPU with interrupts disabled
> and gives up after a timeout measured with ktime_get_raw_fast_ns().
> While the clocksource is still jiffies during boot (or with
> clocksource=jiffies) that timeout can't expire, because only the boot
> CPU's tick advances jiffies and that's the CPU spinning with interrupts
> disabled.
>
> The boot then hangs when the remote CPU can't answer, eg in the
> stop_machine() of the switch away from jiffies:
>
>   CPU0                                  CPU1
>   multi_cpu_stop()                      multi_cpu_stop()
>                                           local_irq_disable()
>                                           /* waits for CPU0 */
>     <timer interrupt>
>       clocksource_watchdog()
>         /* sends CSD to CPU1 */
>         watchdog_check_skew()
>           /* waits for CPU1 forever */
>
> Nothing gets printed.  With the hard lockup detector on in a KVM guest:

The above explanation is enough. No need for this backtrace.

> Measure the timeout with the clocksource under test instead, which
> keeps counting with interrupts disabled.  With the fix, the watchdog
> gives up after the timeout and the boot goes on.  A 2-vCPU guest on one
> host core hung in 4 of 150 boots without it, and it didn't hang at all
> in 400 tests with the fix applied.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 80s on a kernel booted with clocksource=jiffies.
>
> Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Srikanth reported silent early boot hangs of large KVM guests that he
> bisected to the same commit [1].  I think it's the same bug but it was
> never confirmed.  Srikanth, would you mind giving this a try on your
> setup?

Yes. I gave him a similar patch which simply uses sched_clock()
instead. That solves the problem, but I was reluctant to post it due to
the lack of explanation why this ends up in a situation which does not
allow to make progress.

So your reproducer does:

  while true; do echo 0 >/sys/devices/system/cpu/cpu1/online; echo 1 >/sys/devices/system/cpu/cpu1/online; done

right?

Unfortunately it does not reproduce here within a reasonable amount of
time (still going strong after one hour...).

But yes, your explanation makes sense and triggering it with the hotplug
code is obviously a matter of probability.

Though one thing I thought about before looking at your mail while
reasoning over the possible causes of Srikanth's report and the possible
consequences is that such a timeout might in the worst case result in a
stale CPU state which is silently ignored. The consequence is that the
watchdog wont run on a CPU with such state ever again.

So something like the below delta patch on top of your fix (or the
sched_clock()) variant might be appropriate.

Can you and Srikanth please run that on top to validate that we don't
end up with that?

Thanks,

        tglx
---
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -250,6 +250,7 @@ enum wd_result {
 	WD_FREQ_RESET,
 	WD_FREQ_SKEWED,
 	WD_CPU_TIMEOUT,
+	WD_CPU_STALLED,
 	WD_CPU_SKEWED,
 };
 
@@ -398,7 +399,7 @@ static void __watchdog_check_cpu_skew(st
 
 	wd = per_cpu_ptr(&watchdog_cpu_data, cpu);
 	if (atomic_read(&wd->remote_inprogress) || wd_csd_locked(wd)) {
-		watchdog_data.result = WD_CPU_TIMEOUT;
+		watchdog_data.result = WD_CPU_STALLED;
 		return;
 	}
 
@@ -590,11 +591,16 @@ static void watchdog_print_freq_skew(str
 	pr_warn("Clocksource %20s interval: %16lluns\n", cs->name, watchdog_data.cs_delta);
 }
 
-static void watchdog_handle_remote_timeout(struct clocksource *cs)
+static void watchdog_print_remote_timeout(struct clocksource *cs)
 {
 	pr_info_once("Watchdog remote CPU %u read timed out\n", watchdog_data.curr_cpu);
 }
 
+static void watchdog_print_remote_stall(struct clocksource *cs)
+{
+	pr_warn("Watchdog remote CPU %u stalled\n", watchdog_data.curr_cpu);
+}
+
 static void watchdog_print_remote_skew(struct clocksource *cs)
 {
 	pr_warn("Marking clocksource %s unstable due to inter CPU skew\n", cs->name);
@@ -635,9 +641,13 @@ static void watchdog_check_result(struct
 
 	case WD_CPU_TIMEOUT:
 		/* Remote check timed out. Try again next cycle. */
-		watchdog_handle_remote_timeout(cs);
+		watchdog_print_remote_timeout(cs);
 		return;
 
+	case WD_CPU_STALLED:
+		watchdog_print_remote_stall(cs);
+		break;
+
 	case WD_CPU_SKEWED:
 		watchdog_print_remote_skew(cs);
 		break;

