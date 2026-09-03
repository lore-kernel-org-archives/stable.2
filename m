Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF6448BA8;
	Thu,  3 Sep 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435013; cv=none; b=s7zt/HkxjKrf8bUx0EthmsvV3pSyYEcyc3bARRwS3ojYwcx6ywVrFQUnET9WDiebwpox3CdH8l03M1vPpy2CSKNvATOajoOXI5Vt7zhjuYYt5XpfjMs/LxlUIVCvMifls6Izyj8jb7Ifloz37L8HEYUGiA4loN8c/2hrDpd6OHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435013; c=relaxed/simple;
	bh=7ZGfw3J4a5JEuBsfhXEXtex3jd2srNbwsVSYvVwVvc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKQAI6GsVMLz+eiPeFFtSMmqVWdESV257TmtUr6az6tQWaobj73/9/sCzR90x5GSZL6jPL1i5J1P9qwHjTuUU64Fythvu8Z9NQULuDqlb60DRFTLWuuTfTEmyZrTH9ox9zTXt5ijyOn3VCjgtFo//RfCZyUWdd05+hZ4BjluUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KSSZSWlE; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KSSZSWlE"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hbHQf2T2Tz90Sp;
	Thu,  3 Sep 2026 13:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788434890;
	bh=7ZGfw3J4a5JEuBsfhXEXtex3jd2srNbwsVSYvVwVvc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KSSZSWlEZION115+zIffE6KQv4G04pDl4s2ulqPuZ7AaW+xqwrDuelML/lL5qZOni
	 GzejeEqysl+0mKtsKIcFzD3QfzTjMoUlabvCW8HIz491fDRedAICNYbDmvqNZhnwvR
	 dwy4FmtokeNqUL/fFkPDM6RTt8/3/DKcwqJrBAhsnK2Gp4mij09355AgrESOoplkB+
	 Kbg9c3NLddWUkDp0GK2ABBFexnmYMwfHYzpmHiBYVOVNpXuOUoJNI2DEfQhFOltF0f
	 E4cvXSGdESDei0fbtPrMrct5T3VkqC/KOL7j4mnpsZP6K5SMxeuwOgKO+akJBtnNMK
	 45RaNoEMmnZpg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hbHQf1mS4z80c4;
	Thu,  3 Sep 2026 13:28:10 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hbHQc6cPzz8sZg;
	Thu,  3 Sep 2026 13:28:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 3F9D25F9C6;
	Thu,  3 Sep 2026 13:28:00 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info>
Date: Thu, 3 Sep 2026 13:27:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] sched/rt: NO_RT_PUSH_IPI causes multi-second
 PI-boost starvation in pro-audio workloads (dd29c017aed6)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Martin King <martin3kx@gmail.com>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-rt-users@vger.kernel.org
References: 
 <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
 <20260814183652.611e7ecf@gandalf.local.home>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260814183652.611e7ecf@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178843488063.2937962.11799557197795415206@mxe9fb.netcup.net>
X-NC-CID: k37XkMfNV148T8AaHZlocYgfG0Ej4NCBFhcSJKQwQzEPo4rKEWU=

On 8/15/26 00:36, Steven Rostedt wrote:
> On Fri, 14 Aug 2026 16:12:35 -0500
> Martin King <martin3kx@gmail.com> wrote:
> 
>> Commit dd29c017aed6 ("sched/rt: Have RT_PUSH_IPI be default off for non
>> PREEMPT_RT") causes reproducible multi-second audio dropouts on an ordinary
>> non-PREEMPT_RT desktop running a DAW.
> 
> Thanks for the report.

This made it to my list of tracked regression -- but it looks like there
was no progress for a while. Is that the case? Steven, did that maybe
fall through the cracks due to the travel you mentioned? Or was this
resolved meanwhile and I just missed it?

Ciao, Thorsten

>> Symptom
>> -------
>> Audio cuts to silence for 0.2-3.5s at irregular intervals (roughly one per
>> 2-3 minutes of use) while the machine is otherwise idle and responsive.
>>
>> Mechanism (as measured, not inferred)
>> -------------------------------------
>> REAPER runs one SCHED_RR prio 20 audio thread plus ~15 SCHED_OTHER "livefx"
>> worker threads. During a stall:
>>
>>   - the RT audio thread is blocked in rt_mutex_schedule() on a PI mutex
>>   - exactly ONE livefx worker holds that mutex, has been PI-boosted to RT,
>>     and is enqueued but never scheduled
>>   - its schedstat shows run_ns ~0 with wait_ns tracking the entire stall:
>>
>>         reaper/livefx tid=43910  run=0.0ms  wait=3406.6ms  slices=2
>>         (during a 3403ms dropout)
>>
>>   - meanwhile ~17 sibling threads run normally with wait_ns = 0, and no
>>     thread does meaningful work (largest run was 7.2ms across 3.4s)
>>   - the machine stays responsive throughout; unrelated SCHED_OTHER work
>>     proceeds at 84-94% of normal rate with 0-1ms runqueue wait
>>   - all 16 cores keep taking timer interrupts at normal rates
>>
>> So a single PI-boosted RT task sits on a runqueue, unmigrated, while other
>> cores idle. With push disabled nothing hands it to an idle CPU.
>>
>> Evidence
>> --------------------------------
>>   kernel  RT_PUSH_IPI  playing   dropouts >=25ms          xruns
>>   7.1.8   off (default)  19 min   8  (191ms - 3471ms)   bursts
>> 23/265/434 per min
>>   7.1.3   on             39 min   0                     0
>>   7.1.8   on             42 min   0                     0
>>
>> The third row differs from the first ONLY in the sched feature: Identical
>> kernel, toolchain, GPU driver, project and audio configuration. At the
>> observed broken rate ~13 dropouts were expected in that window; zero were
>> seen, at both 25ms and 10ms detection thresholds (10ms is ~2 missed audio
>> cycles at quantum 256 / 48kHz).
>>
>> Workaround
>> ----------
>>   echo RT_PUSH_IPI > /sys/kernel/debug/sched/features
>>
>> Applied at boot via a systemd unit.
>>
>> System
>> ------
>>   AMD Ryzen 7 5800X (8c/16t), Arch Linux
>>   kernel 7.1.8-arch1-3 (and 7.1.5, 7.1.6 - all affected; 7.1.3 is clean)
>>   PipeWire 1.6.8 + pipewire-jack, Focusrite Scarlett 18i20, quantum 256 @ 48kHz
>>   CONFIG_PREEMPT_RT not set
> 
> Unfortunately, I'm going to be traveling next week and I may not be able to
> look into this until I get back. I don't see anything that the normal (non
> PUSH) logic would fail in this case. Thus I'm thinking it simply has a bug
> that has been hiding because we've been using the PUSH logic.
> 
> I may be asking for some traces here when I get back to find out the exact
> cause. Use the workaround for now.
> 
> The RT_PUSH_IPI was added because of a "thundering herd" of IPIs when all
> but one CPU dropped its priority and the one still running had more than
> one RT task on it. That would cause all the other CPUs to send an IPI to
> that CPU to do a pull, but only would would get it. The RT_PUSH_IPI was
> created to pass around a single IPI to do the push for all CPUs wanting a
> new RT task to run.
> 
> The above use case doesn't look like it is having that. Thus, I'm thinking
> something else broke.
> 
> -- Steve
> 

