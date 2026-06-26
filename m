Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C7369D64
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483977; cv=none; b=NGjdXSVNrBGFW1wyUq5t0EdZ5Y6Br54ZghL4jEPTSGvvh97CG9d70bgxwIrKOENBZEZOBceRDO4ytXrouF1WngkHvNrQlMe1+/WIE3JMzQqvXVr7/KxBd9B+Uo7Hpi/z68AWCv52Fmz7QNvuYnENSUQAvI8Nxv4S9ScigbKYEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483977; c=relaxed/simple;
	bh=SkSupaXHlzkEqXiDNaHuO2DkZqcG3uLR0lEheitZjT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnfKmYTxpZyNLfejsJd5TE+y3RsPcBem6Wg6eG9B83r/bSJ9Zzcbls8qQ6deMMXbm+E5a0QPV9uoOEGORY+4ekQqqkUkEda/eyOUjmF9zl+lBlo9Mt3/3IQ1GxapKNQRkva61ezi6ITPveMHjVaQ3lTENck7awenXdydXMImnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EObO6ND9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EObO6ND9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49258ac7294so7097535e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782483974; x=1783088774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93zgvkxuh49PA0NOJqu92O8AFgIa3mgcrkcaggpnEck=;
        b=EObO6ND9sT8EmvVykVm/aFz+xxFnSv4emT8/wDyCGDj098VP1pbFmA/MonbpJmW7Mu
         pPlEALWZRgLhT56mUNPudGbgJJVk16FVDEAeaxZ74sFqd2HGqAumHhmR2I3+uYDt9lWK
         U8iEhLU6wknN36YBLgXVD+e29CqLx6N5GrQGnDIBo3iRUWj2OWDMHXA5P/fHwyWyAnjX
         E77RTcpLETR9bRPaIpfWFZJKBvzdzAsYd/S+NrqZ1My7SnxX8fgMRBnSZy4luvMw77aH
         3quJ1bJdeBZ1Gc/nL6J8+nj1d0aXua38YwJKwmTXjDvKHA2rpPyyGpQKkC5Kv8di0GYE
         lE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782483974; x=1783088774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93zgvkxuh49PA0NOJqu92O8AFgIa3mgcrkcaggpnEck=;
        b=WU11bSGq0oYkXdb1+r6g5iC97WQhLdZUGfOUZ918EW518QeGeHjvx3dr3YfJtwIGki
         g1gNYtaONedaqCbOUsyb4BoW4AFUHpec+fdw7zUW1IDyJEfMnlJdzhsrsKTEjsMYQY7c
         VBE9ONDGO6dgJ0t5xIkDGzzjwV3mzDrFEl9UsoO6Gd+sXQh4NsYNX/Qu5j9jfab+Ytk2
         luQ9qgBcyyKzbqWIUF9tMh01XswUEcAwHwWIx9cLs/5yuDeeDf3alccp2LJbjzjcdzlP
         +D119eNre9MD6jp1Blrxd/iIvC9pkTpxxdSTFqeQxJNn/+1XsncRAv9b6/bYPEL9PLaT
         zRvw==
X-Forwarded-Encrypted: i=1; AFNElJ8SrQb4Dj0uXOiWA0I7ZxuEZTi8AsOpXn2ww9K+l37AT7OEXFd54/puy1cg0eQiR9iWIjm4p2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09q7uyCdR/eIfoSFkKJbCiXL4PHdn6JZ6k/E+H4X6pSHSU/4L
	41fvylMhDIaZjs59Hu0GCpPGvCq6IrhVD+hbnEZRU3fG8tuO3N+tVgt8ytBkcZmQT3g=
X-Gm-Gg: AfdE7cktLNX4OFiWRqXj9v3EF5wSsBSW1S4/XM5jR+P8CtkPJYsUowDGq/bDZMKb9N7
	vIKPjjRArupqySmRY9J2x8AyzTKvUI+hJA8CrTs1GzOo32ij7j5CQsBwLMsWhfzukkLy1DfRdEq
	nsaLtv0dNKY/K1zRyyZjdFr392w1pyA2d6kBqyug0qcFJowj+6l64mchBJs8cbP2Q8mHwR3qSp4
	GZURTdUyvaD+1B9Y1k4Y9UTc3mTl88sqWz/IXfqVk0bX1xlIylvHDIDvN+ZXk6wf6OgPdcBnQIm
	REsWKOdQg5xMWrx0XgiW38bTP8VcGrHfHOZYmtLYHKrasuGHoO1ukS1tddaTrFXeZO9WwDwf5ta
	AUp1W8Tq/ODUH8YNvSx1287+pxWMdjFF2zX5NoGf1uqzei1d+eVgHaZaodqzu25Hj8BZu+UCYug
	2d+1C12s1+Oc2KXj0=
X-Received: by 2002:a05:600c:8114:b0:492:7024:11c8 with SMTP id 5b1f17b1804b1-492702411d5mr10254015e9.32.1782483974505;
        Fri, 26 Jun 2026 07:26:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c02081bsm44449055e9.0.2026.06.26.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:26:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:26:11 +0200
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
Message-ID: <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net>
 <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>

On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
> wrote:
> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> >wrote:
> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >>> But it all becomes very hairy. We have several levels:
> >>> 
> >>>    + watchdog-all_bt-specific option, e.g.
> >>sysctl_hardlockup_all_cpu_backtrace
> >>> 
> >>>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >>> 
> >>>    + panic-specific si_info: panic_print
> >>> 
> >>>    + universal fallback for any layer: kernel_si_info
> >>> 
> >>> Now, we try to check all these variables back and forth to
> >>> trigger all backtraces or to avoid triggering them.
> >>> And it clearly does not work well and the code is more and more
> >>> hairy.
> >>> 
> >>> I think about another approach. The word "waterfall" comes to my mind.
> >>> Instead of checking all the settings back and forth, let's process
> >>> each setting one by one and just remember what has been done and
> >>> skip this in the next level.
> >>> 
> >>> All the si_info actions seems to dump a global system state.
> >>> So, it would make sense to remember the state in a global variable
> >>> even when it might be modified by more CPUs in parallel.
> >>> 
> Hmm.. new idea 
> 
> kernel/dump_filter.c ?
> 
> What this file could do is to handle a generic lockup state machine
> so any subsystem can log what it already dumped?
> 
> I know it may bloat, but it's better then cramming fixes in.

I am not sure what exactly you would like to achieve but it sounds
a bit scary ;-)

Anyway, we should not synchronize the watchdog reports against
each other, definitely. They are running in non-compatible contexts
(task vs interrupt vs NMI). Also we should not add any locking
because they usually print something when the system has enough
troubles.

Also I think that it is not worth preventing duplicated backtraces
or reports from a single CPU. IMHO, it is not a big problem
in practice.

So, we are down to large reports, like backtraces from all CPUs,
timers, locks, ... which are handled by sys_info(). So, I think
that it should be enough to handle this inside the sys_info() API.

I do not want to say that my proposal was the best solution.
I am sure that there are better ones. But we need to consider
the gain vs. complexity.

Honestly, I am already a bit scared by the complexity which
we the sys_info() API added. And it is hard to imagine that
adding another API would make it easier. But I might be wrong.

Instead, it might make sense to integrate the conflicting
subsystem-specific calls under the sys_info() API.
I mean that, for example watchdog_hardlockup_check() won't
call trigger_allbutcpu_cpu_backtrace() directly but
it would call it via sys_info() API so that sys_info()
could keep track of it. Something like:

void sys_info_allbutcpu_bt(int cpu)
{
	trigger_allbutcpu_cpu_backtrace(cpu);
	/*
	 * The caller likely printed backtrace of the given @cpu
	 * on its own. Prevent duplicate backtraces from all
	 * CPUs with potential next sys_info() call.
	 */
	sys_info_done(SYS_INFO_ALL_BT);
}

But I am not sure if it is really easier to follow
than calling sys_info_done() from the watchdog code.

Some watchdogs try to optimize the output and print backtraces
only from CPUs which are relevant for the given lockup.
We should keep the logic for selecting the set of CPUs
in the watchdog code. We just need to solve how to elegantly
make sys_info() aware of it or at least about the more massive
reports.

Anyway, I would prefer to keep it simple until we see some problems
in practice.

Best Regards,
Petr
