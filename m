Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52438A718;
	Mon, 29 Jun 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733260; cv=none; b=jOXMVnPEPE+u+ZEXzs8udh3bDE7C0DmmRiMcJ+v0wWuKUqOnIdYK+AuRN5/qO9BeeYI2e+TLFZpNNm5FooCd4wu2TnyQstVXCNsW8DDpwfPRJ3s2/e4xoRmy3obffURJF6G2V9ataGFxPbWK3lY1ZFpGuB/aIM5c+LXA25jjknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733260; c=relaxed/simple;
	bh=bc49tQ62+w9u87Y2vRsQ6BnJrlQPAHPk2VErB+vlkZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaTe+fXA07/P7mvKwdQLSS2pR1vu/dIgVEQCQEDg/vFpn7Fg6FbmdS7sIfWO/QXG+pBRkFqwGa36kToeD/CZ0Vf25HCRC7nUzbf2F9n4G9X10KqaTF6jK3OjZLBUfSf2boRF79ixzch6/2/8Idp/dhuO72yt1sN3MvBIi5rjPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NuJ+ikbN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NuJ+ikbN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782733255; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=IamwdDSMaD5+IxwQs2MbeKnGNJ8bxCpdX3TG62bS6SM=;
	b=NuJ+ikbN+TPDKP4Ox+G0yDVLn9HB5Wnz4JZ/B1fzU1iX4pC2GhWK0V7MA8JmfEeoBv9rUet34pghtxYkTUyaqcdI3yXMAiV2QkqxbDo4MDKUGN9WBmxzSCw+DhBwLVm24jECqu2Y/ci549kvVGsm0OGugNqhlvPkA/CY+O2hcXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5ss1KF_1782733252;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5ss1KF_1782733252 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 19:40:53 +0800
Date: Mon, 29 Jun 2026 19:40:52 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <include@grrlz.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj5tFiwhRqPkAkqU@pathway.suse.cz>

On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> > > other CPUs. Do not ask sys_info() to handle that bit again later in the
> > > panic path.
> > > 
> > > Use sys_info_with_filter() so panic_print=all_bt does not request more
> > > output after the CPUs are stopped.
> > > 
> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > > ---
> > >  kernel/panic.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 213725b612aa..eb842823df61 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> > >  	 */
> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > >  
> > > -	sys_info(panic_print);
> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> > 
> > Hmm, this prevents printing backtraces from all CPUs completely.
> > But what if they were not printed?
> > 
> > They might be printed by:
> > 
> > static void panic_other_cpus_shutdown(bool crash_kexec)
> > {
> > 	if (panic_print & SYS_INFO_ALL_BT)
> > 		panic_trigger_all_cpu_backtrace();
> > 
> > [...]
> > }
> > 
> > But it checks only "panic_print" variable. It won't do anything
> > when (panic_print == 0).
> > 
> > In this case, we might still want to print the backraces when
> > SYS_INFO_ALL_BT is set in kernel_si_info.
> > 
> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > 
> > Of course, we might fix panic_other_cpus_shutdown() to check also
> > kernel_si_info.
> > 
> > But it all becomes very hairy. We have several levels:
> > 
> >    + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
> > 
> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> > 
> >    + panic-specific si_info: panic_print
> > 
> >    + universal fallback for any layer: kernel_si_info
> > 
> > Now, we try to check all these variables back and forth to
> > trigger all backtraces or to avoid triggering them.
> > And it clearly does not work well and the code is more and more
> > hairy.
> > 
> > I think about another approach. The word "waterfall" comes to my mind.
> > Instead of checking all the settings back and forth, let's process
> > each setting one by one and just remember what has been done and
> > skip this in the next level.
> > 
> > All the si_info actions seems to dump a global system state.
> > So, it would make sense to remember the state in a global variable
> > even when it might be modified by more CPUs in parallel.
> > 
> > I am going to think more about it.
> 
> I have created a POC using Gemini. I haven't tested it.
> But it looks acceptable. And the logic seems to be more
> straightforward.
> 
> One drawback is that it requires adding the _reset()
> call for all sys_info() callers. It is fine in principle
> but it might complicate back-porting because all changes
> have to be done in one patch.
> 
> But honestly, this is a nice to have fix. Most people could
> live happily without it.
> 
> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Fri, 26 Jun 2026 13:55:41 +0200
> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent duplicate
>  backtraces
> 
> In watchdog, panic, and hung task detection scenarios, sys_info() can
> be called multiple times or alongside direct backtrace triggers like
> trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
> being dumped repeatedly from all CPUs, cluttering the kernel log and
> delaying or obscuring critical debug details.
> 
> Introduce a state tracking bitmask and associated helpers:
> - sys_info_done(mask): Marks specific sys_info bits as already printed.
> - sys_info_reset(): Resets the tracking state.
> - sys_info_is_done(mask): Checks if all bits in the mask have been printed.
> 
> Update sys_info() to automatically filter out already printed bits
> using this state. Integrate these APIs with the generic hardlockup
> and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
> and the panic core. This ensures that each piece of system information
> and backtrace output is printed at most once per lockup/panic event,
> and the state is reset cleanly when a lockup does not trigger a panic.
> 
> Races between sys_info() callers are ignored. It should be acceptable
> because the output from various watchdogs has never been synchronized.
> And panic() never returns.
> 
> Assisted-by: gemini-1.5-flash
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Yep. There are cases that people want panic on task-hung or sw/hw lockup,
and this could remove much duplication of sys info dump, thanks!

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

> ---
>  arch/powerpc/kernel/watchdog.c | 13 ++++++++++---
>  include/linux/sys_info.h       |  3 +++
>  kernel/hung_task.c             |  2 ++
>  kernel/panic.c                 |  4 +++-
>  kernel/watchdog.c              | 10 ++++++++--
>  lib/sys_info.c                 | 30 +++++++++++++++++++++++++++++-
>  6 files changed, 55 insertions(+), 7 deletions(-)
