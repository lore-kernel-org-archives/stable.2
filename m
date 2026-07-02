Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2C47DFA8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983387; cv=none; b=Pn4lzYluFHUKmr7Wb008arEfKhXuwrEBfrFtGXIhTDNqMGaVlY1PZ8GZha8xJ1rJFcOonVpk+nQ8Hh0ppMA2yWeIEaFVX77PtKHJSGKoka3kaUdMoMwmdWlLC70B8+JQAVRz8EDJlVpP2C2hyfxD6VDE5JSdR8sf3LH5jULnaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983387; c=relaxed/simple;
	bh=jjGiktjpEUOXpUi39FPhXVg1zuD4wYx1sfOWKctvD0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY2hfftSaboaaN6QKA9rogXC88MYEWivx762DXfXQ7HpXV/zjJDcsG3NiejjLNCjUIr2SLDNrh/1W/o1zxe8d6PB5H3lE4as7Su8KnTWCEWd/1jCbs2AKNfX+v7JICEano1VNTm9vbUmHFzrKWGcmkYKohKJQ5gC2xl0PxvuRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ky7caVHr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ky7caVHr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so13709555e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782983384; x=1783588184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ptox+JjM03OhvllsW2x9tH05PMT5+Q6t7YaDrA539A=;
        b=Ky7caVHr3NK/vKa4T6BqJdQ22huR5yN+Il5zkO2+hHgNFya2vrRV3YA1nqCojrt3p7
         HR0JG0WafU6sCJHpNDGMTYMaqnQk7J6rl+3+PhR8mGPWU2BIURVmqBAUpADlRzpcBi3L
         rQpTLTu2stl4vdVmKhlWBRlpDAs/mCynFEeDR0NiOr0PxoDMEm/6A+4twaql2x2UDsGb
         WmCcg6mZaTwETNU97pSP0t2Qzi5z5b3t+xzBKOKzV5V99m2kR5cbKGudk9TfwjRN+X39
         IevID4MpUXGDtH3Ezzj+zTkzAnuZL3aD0VMWBB1q6GOsAZN58Pk8lko4YTc0m5FNDL1P
         dfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983384; x=1783588184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ptox+JjM03OhvllsW2x9tH05PMT5+Q6t7YaDrA539A=;
        b=ZZXwB0UPu/Au/jolSrnNnY2XbFLjteO2No5Nhi5j6eS9vy0RlVScav5zxCstjwZUU9
         rnDDYv2qSDIc31fnbuAyWOwY0ctQMB0VNlcl5wum0PDA0pVzpXoxPmnHf/2dReyBplDK
         y2cKz9Wc7ubtrTRhJvoNSR7GdZ4/ZxOqzWsJakujoh9OdJHj7L4Te/xP+6AZCnriTLyk
         c8sfbA4x3ZY4zXZp8CDmsFxYFLOrUqLucgai4zJRDoDW2UJtScw112x1z2Wax/ORmut6
         qvI7juVsqF+vwcyofmA114zfWh+VYrf76xavNb1eg4EhCy3/bfYvhp8P6HKCjjVl0VSg
         vgtA==
X-Forwarded-Encrypted: i=1; AFNElJ8iGgZ0mDNAtBlWTA2ZrGxihKCVcBUWGyP4Ec047IEimvAyP1+R/nEgb3fvy9Iz27LjDhHHP+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8IHfNJoFXJpftPG/rA+FeXGenK0dWWzqRzfubMUiJeK18ESF
	NQDKvFLItKMFpACkCLd0nJ19CvdVU68mpqIsH5tqX95j+47lHUKQErBij4qPGivucrYWwpeTFv2
	ZZgvYCRI=
X-Gm-Gg: AfdE7cmRJ6ZHcDFgAziDL77cDe+g7fZzKFjFwdNlcxyChbWYTdv8agtCjDViXCStHl2
	LJ/QJwABLyHwEsnLQXlNIYnxxy1RX5yvgsDZXinS7sA1YCN99xaaGHI8gKtwQhxzokc7xRl7b38
	HSaMyXcSL1eHoA4QzhN70yH8LOckJjt/Fh+40u7zYQ1lkIuINMj+ei/ENrn0Se7jVRWNQXYOU4W
	aqJfUl9GtC4yoTciGCG3gwGtxtkvVDQiJeqUgsg9usE52ZdjYqg1cmfDkIJLQUIPt95AkUYzd9T
	tIeezdG5MHcd+JxW77mTC3iis51eDNPSBV/sajzah+FweJYl7VcFLUX3Yv14FIcTeEYeFC0aNN1
	epjK+8Aabm4FOBUnYLZYhXX1w+7RbzvS5t0jFxHQP+9gCbGZ/mY61nRkr50HBHV5mZVSVr60+fG
	p5cpBaUqPxWFnXcmU=
X-Received: by 2002:a05:600d:8649:10b0:492:6eff:7d02 with SMTP id 5b1f17b1804b1-493c2b974bamr64853005e9.30.1782983383910;
        Thu, 02 Jul 2026 02:09:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd0b1sm6982567f8f.35.2026.07.02.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:09:43 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:09:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
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
Message-ID: <akYq1YaCpZ0b4SBS@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
 <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>

On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
> wrote:
> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping
> >the
> >> > > other CPUs. Do not ask sys_info() to handle that bit again later in
> >the
> >> > > panic path.
> >> > > 
> >> > > Use sys_info_with_filter() so panic_print=all_bt does not request
> >more
> >> > > output after the CPUs are stopped.
> >> > > 
> >> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys
> >info on system lockup")
> >> > > Cc: stable@vger.kernel.org
> >> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
> >> > > ---
> >> > >  kernel/panic.c | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > > 
> >> > > diff --git a/kernel/panic.c b/kernel/panic.c
> >> > > index 213725b612aa..eb842823df61 100644
> >> > > --- a/kernel/panic.c
> >> > > +++ b/kernel/panic.c
> >> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> >> > >  	 */
> >> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >> > >  
> >> > > -	sys_info(panic_print);
> >> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> >> > 
> >> > Hmm, this prevents printing backtraces from all CPUs completely.
> >> > But what if they were not printed?
> >> > 
> >> > They might be printed by:
> >> > 
> >> > static void panic_other_cpus_shutdown(bool crash_kexec)
> >> > {
> >> > 	if (panic_print & SYS_INFO_ALL_BT)
> >> > 		panic_trigger_all_cpu_backtrace();
> >> > 
> >> > [...]
> >> > }
> >> > 
> >> > But it checks only "panic_print" variable. It won't do anything
> >> > when (panic_print == 0).
> >> > 
> >> > In this case, we might still want to print the backraces when
> >> > SYS_INFO_ALL_BT is set in kernel_si_info.
> >> > 
> >> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >> > 
> >> > Of course, we might fix panic_other_cpus_shutdown() to check also
> >> > kernel_si_info.
> >> > 
> >> > But it all becomes very hairy. We have several levels:
> >> > 
> >> >    + watchdog-all_bt-specific option, e.g.
> >sysctl_hardlockup_all_cpu_backtrace
> >> > 
> >> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >> > 
> >> >    + panic-specific si_info: panic_print
> >> > 
> >> >    + universal fallback for any layer: kernel_si_info
> >> > 
> >> > Now, we try to check all these variables back and forth to
> >> > trigger all backtraces or to avoid triggering them.
> >> > And it clearly does not work well and the code is more and more
> >> > hairy.
> >> > 
> >> > I think about another approach. The word "waterfall" comes to my mind.
> >> > Instead of checking all the settings back and forth, let's process
> >> > each setting one by one and just remember what has been done and
> >> > skip this in the next level.
> >> > 
> >> > All the si_info actions seems to dump a global system state.
> >> > So, it would make sense to remember the state in a global variable
> >> > even when it might be modified by more CPUs in parallel.
> >> > 
> >> > I am going to think more about it.
> >> 
> >> I have created a POC using Gemini. I haven't tested it.
> >> But it looks acceptable. And the logic seems to be more
> >> straightforward.
> >> 
> >> One drawback is that it requires adding the _reset()
> >> call for all sys_info() callers. It is fine in principle
> >> but it might complicate back-porting because all changes
> >> have to be done in one patch.
> >> 
> >> But honestly, this is a nice to have fix. Most people could
> >> live happily without it.
> >> 
> >> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
> >> From: Petr Mladek <pmladek@suse.com>
> >> Date: Fri, 26 Jun 2026 13:55:41 +0200
> >> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent
> >duplicate
> >>  backtraces
> >> 
> >> In watchdog, panic, and hung task detection scenarios, sys_info() can
> >> be called multiple times or alongside direct backtrace triggers like
> >> trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
> >> being dumped repeatedly from all CPUs, cluttering the kernel log and
> >> delaying or obscuring critical debug details.
> >> 
> >> Introduce a state tracking bitmask and associated helpers:
> >> - sys_info_done(mask): Marks specific sys_info bits as already printed.
> >> - sys_info_reset(): Resets the tracking state.
> >> - sys_info_is_done(mask): Checks if all bits in the mask have been
> >printed.
> >> 
> >> Update sys_info() to automatically filter out already printed bits
> >> using this state. Integrate these APIs with the generic hardlockup
> >> and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
> >> and the panic core. This ensures that each piece of system information
> >> and backtrace output is printed at most once per lockup/panic event,
> >> and the state is reset cleanly when a lockup does not trigger a panic.
> >> 
> >> Races between sys_info() callers are ignored. It should be acceptable
> >> because the output from various watchdogs has never been synchronized.
> >> And panic() never returns.
> >> 
> >> Assisted-by: gemini-1.5-flash
> >> Signed-off-by: Petr Mladek <pmladek@suse.com>
> >
> >Yep. There are cases that people want panic on task-hung or sw/hw lockup,
> >and this could remove much duplication of sys info dump, thanks!
> >
> >Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
> 
> Thanks,
> 
> im feeling a new file to do all the force panic jazz, but putting tape
> on sys_info.c isn't bd either.

I wonder how to move forward with this.

Honestly, I am not sure what exactly you mean by creating another
API for tracking the reports so I could not judge it. Feel free
to sent some POC.

Otherwise, I would go with my proposal to remember the printed states
by the sys_info API. I am not sure whether I should send a proper
patch or you would like to somehow improve it.

Best Regards,
Petr
