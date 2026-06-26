Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C653FC5A2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485244; cv=none; b=aBIabWAHkvYC/oVGGjIYnyDj2WfXYU+7vKDCYlsPzp/5Vkthf1pWB7yUGFdMZMZvtNRJtU/RD/1UQNsqqbNtH+L1Im6Md2htAJmhX5WO9Ruwt0LSknoDyY/eifCnC9Gk+AZBMxGKk/48t0Yg2IIAhKMFlXGkbwKh3XIz6u8SdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485244; c=relaxed/simple;
	bh=xDkHSkzopZwkSPwv+BN4MT5f+6RvZQ28IrxJHisZ+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwOBtYflg80fdq46FL28oYVIXXTak3xhBo5YhqkQngU5AbAcHyurjtGEDXtG+kkaE5hYM9WqBbQXS8QH6+pfM7VbxE/c+cOZamhMtjuPuifu+DoWAG/wns+tG79jDEyEa+Dk3tMzZkq5EmQu2cPMGbq+ccXxI0oPXAJV5pLKvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsLv1Ka0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsLv1Ka0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso7570965e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782485240; x=1783090040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsD3Uuhb7V4xwmN32D9oiv/QfdIeYjME+PsD06WdL4s=;
        b=NsLv1Ka0u6zoMJg1VJfl0E75wZrwgvdqX1mcDM1Sb+PNVCxLWw1NazGBZIiENXEeXc
         eaENxC+Xo3d+HVfqUGpb2M6KNWQkv0eMw2UqqMrlRONjsgLFaZylfyKwhkYVhNgy14j1
         Ucp1w8E2fXgIvd2obdMW2TJgabRy9gljZvimTVHW/S5otBH1zzyivZQGMKQY9g3j3aht
         t+LHBDxLGk555FitrWREBOf2oNBKuby1b5f4BB5+03CBSyGpw5BdGlZkhZJpF3bNitmn
         1JsjD7flTB2tAKFH0/icbQaxEZmzCqiG8zcKMjMvF4jfBrDb9KE2qqeQE4zsFFYOE+s5
         U0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485240; x=1783090040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsD3Uuhb7V4xwmN32D9oiv/QfdIeYjME+PsD06WdL4s=;
        b=qxJzEfRQZII7L81Dp5ndhSItprQicEhcmYEjCf0Oh6xcW7+N6uq9P9qbVZ1udzrWM2
         bO7aQxEAIan4/r/kKXHa4CT9LmgFXFfdXWunzcsu0fEq3TjF3VD/bRQSYzEALoN+Nhs3
         v0GZ8xzKhbibLgbWBIZq6G7xQMYwDIL0yxGS9FI/Zug4ti8gzAjImCkTxnaJ+GR219Yf
         iUZJIOyYY4fDszM8xyxFR6GUiQG/+lICjQnPRZSc03q1u41gb8o8vA/ZvNKD4yeuUVjG
         WRFHFIL6W8i4/0cphyS4c33eWtAqIi/RmekkBDq7RzQ5RclDyFLLdqt8o0c5qDVikKBc
         Hm8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ateeEZFvQSIcGK07NaN7hlTAZ7mcbrU4ddZU0l98i33NWettdH5Sg83TPX4jV1gX8sX9/TIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8xDljs2BsyAauCqpTXiLnJl9oSqwmZppfOdX9xuYi9REfxt3
	wtEDFg+KdL9ZOqx69eSGP8MOHvkkvBRNcWc9YqEzXN/zS0jzMCnezR7CiXvnifA03CM=
X-Gm-Gg: AfdE7clRr3XW5UQe+33rF+khKVYJQUrlEpSMg63Q0RnOW3+UIvQ14GxmFLwLCYv6SKN
	Wd5jL8bUjMMge+vxA1JSBF5ofF8fiNA79qi2P+4Umoi9k1BUc0QGPh6SPXa6X1MyxZwi1x8/d8/
	4MlX/+H8tnWKYi0+zQ2xTfIYtiesGn35z0YePzIqVr34ghIpqt7zybpx6n/9G+Eqpa1nvaXcPJL
	8ArffrECobJrdJlqAbYXRpF/1TZ+DNbF/HwBTHRIvpndn/RS5hU6Kr0/2GWiHx1iv6sog73avLs
	DO/b2pjAfbCq3lNwZCh6m3I7UXG2l9/NPqCn6HKwgTXqri47cg9T1FUGqIrul6yXoSiHUjq/IJe
	hJqOEPns9XKYjtVGSqcTXr1DoqKe16+DczJO0cgjOKdpS49bil4GwJalVHuCNmOP6C37ZVkOa7K
	LmIWvH+eMGgHk7eTI=
X-Received: by 2002:a05:600c:4e55:b0:492:70af:1c35 with SMTP id 5b1f17b1804b1-49270af1d9emr2971675e9.35.1782485235337;
        Fri, 26 Jun 2026 07:47:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm145508505e9.15.2026.06.26.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:47:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:47:12 +0200
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
Message-ID: <aj6Q8JcogaIaQit4@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net>
 <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>
 <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
 <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net>

On Fri 2026-06-26 15:35:19, Bradley Morgan wrote:
> On June 26, 2026 3:26:11 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
> >> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan
> ><include@grrlz.net>
> >> wrote:
> >> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> >> >wrote:
> >> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> >>> But it all becomes very hairy. We have several levels:
> >> >>> 
> >> >>>    + watchdog-all_bt-specific option, e.g.
> >> >>sysctl_hardlockup_all_cpu_backtrace
> >> >>> 
> >> >>>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >> >>> 
> >> >>>    + panic-specific si_info: panic_print
> >> >>> 
> >> >>>    + universal fallback for any layer: kernel_si_info
> >> >>> 
> >> >>> Now, we try to check all these variables back and forth to
> >> >>> trigger all backtraces or to avoid triggering them.
> >> >>> And it clearly does not work well and the code is more and more
> >> >>> hairy.
> >> >>> 
> >> >>> I think about another approach. The word "waterfall" comes to my
> >mind.
> >> >>> Instead of checking all the settings back and forth, let's process
> >> >>> each setting one by one and just remember what has been done and
> >> >>> skip this in the next level.
> >> >>> 
> >> >>> All the si_info actions seems to dump a global system state.
> >> >>> So, it would make sense to remember the state in a global variable
> >> >>> even when it might be modified by more CPUs in parallel.
> >> >>> 
> >> Hmm.. new idea 
> >> 
> >> kernel/dump_filter.c ?
> >> 
> >> What this file could do is to handle a generic lockup state machine
> >> so any subsystem can log what it already dumped?
> >> 
> >> I know it may bloat, but it's better then cramming fixes in.
> >
> >I am not sure what exactly you would like to achieve but it sounds
> >a bit scary ;-)
> >
> >Anyway, we should not synchronize the watchdog reports against
> >each other, definitely. They are running in non-compatible contexts
> >(task vs interrupt vs NMI). Also we should not add any locking
> >because they usually print something when the system has enough
> >troubles.
> >
> >Also I think that it is not worth preventing duplicated backtraces
> >or reports from a single CPU. IMHO, it is not a big problem
> >in practice.
> >
> >So, we are down to large reports, like backtraces from all CPUs,
> >timers, locks, ... which are handled by sys_info(). So, I think
> >that it should be enough to handle this inside the sys_info() API.
> >
> >I do not want to say that my proposal was the best solution.
> >I am sure that there are better ones. But we need to consider
> >the gain vs. complexity.
> >
> >Honestly, I am already a bit scared by the complexity which
> >we the sys_info() API added. And it is hard to imagine that
> >adding another API would make it easier. But I might be wrong.
> >
> >Instead, it might make sense to integrate the conflicting
> >subsystem-specific calls under the sys_info() API.
> >I mean that, for example watchdog_hardlockup_check() won't
> >call trigger_allbutcpu_cpu_backtrace() directly but
> >it would call it via sys_info() API so that sys_info()
> >could keep track of it. Something like:
> >
> >void sys_info_allbutcpu_bt(int cpu)
> >{
> >	trigger_allbutcpu_cpu_backtrace(cpu);
> >	/*
> >	 * The caller likely printed backtrace of the given @cpu
> >	 * on its own. Prevent duplicate backtraces from all
> >	 * CPUs with potential next sys_info() call.
> >	 */
> >	sys_info_done(SYS_INFO_ALL_BT);
> >}
> >
> >But I am not sure if it is really easier to follow
> >than calling sys_info_done() from the watchdog code.
> >
> >Some watchdogs try to optimize the output and print backtraces
> >only from CPUs which are relevant for the given lockup.
> >We should keep the logic for selecting the set of CPUs
> >in the watchdog code. We just need to solve how to elegantly
> >make sys_info() aware of it or at least about the more massive
> >reports.
> >
> >Anyway, I would prefer to keep it simple until we see some problems
> >in practice.
> >
> >Best Regards,
> >Petr
> >
> 
> 
> I understand it's scary. To make a new file in the first place.
> 
> But I was a bit vague of what I wanted, and I'm sorry.
> 
> So, the reason why I'd suggest a new file, is because if any subsystem
> Theoretically bypasses sys_info to log a lockup, this completely misses
> the filter and duplicates the dump
> 
> My file would act as a generic lockless state machine that any
> subsystem can update regardless of how they dump logs.
> 
> If you have any questions, feel absolutely free to ask! :)
> 
> Discussion is a way to make everyone happy!

Honestly, I am more and more wondering whether your are a real person
or AI bot.

Best Regards,
Petr
