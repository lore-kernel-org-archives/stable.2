Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F93B38BC;
	Fri, 14 Aug 2026 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747003; cv=none; b=rwwNh4NWtMosRUn4zwPqLn06sQcbK5j3uGSrKKdQDP8Bw6LbLjgbRfqEhCOwXNBBOfjeyK13rWpcs6PAzX7Q08FitFDr5Qdwe2v56+VxwnfhvCfFMwuCcSjOFQlxwaB0OSD6EaAQ4Ulz/Lpewpel+4hIiUO+5WVN7l3pUGjCjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747003; c=relaxed/simple;
	bh=BceV66EnWz59YURs+8efrBdywEgij0xOiNunywLSDW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRZjY6nBDWOkLyvrM9Z7ZtnFIyZbLHmEuZEdiYuGOQTW8DrcqCHtaaJP57SG11gY7mQ3TjsvYzbIMR60KJ4WTiGD3+v+Qvnm2BeL2XzgumSD2Y14Khqu55mjswSAhOfewtzB/HYbMm1a5+/oJBp8M+OUtYyYZw6n3j5VxefkI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Wr1FLkxy; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Wr1FLkxy"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 211C31A029D;
	Fri, 14 Aug 2026 22:36:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 3C63E20016;
	Fri, 14 Aug 2026 22:36:33 +0000 (UTC)
Date: Fri, 14 Aug 2026 18:36:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin King <martin3kx@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION] sched/rt: NO_RT_PUSH_IPI causes multi-second
 PI-boost starvation in pro-audio workloads (dd29c017aed6)
Message-ID: <20260814183652.611e7ecf@gandalf.local.home>
In-Reply-To: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C63E20016
X-Stat-Signature: ytma34o3w57adsjk8e8ni3d5a1bjin68
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19+hD91LTdTXLMydKNjVmf+aEAIjoILDDw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ZVC5z6mICC41AJMAiEfDy14gM55qP2OXVwwg9/8vLx4=; b=Wr1FLkxyDERdO00K2rgNNAJ2BjdZc53JfVeUPHnk2US6112f5dCCbCattXgRYdTp3mVRKTfZ1KQyXVl7UeJe1r1jhzNX54EVRpOUbDDNT9m3CVsUupi4wqhwKejzx6g9wDfE8IAcVV+g83yw2e9/oCSjjVU6L4ZWkurAYKbldJU=
X-HE-Tag: 1786746993-996614
X-HE-Meta: U2FsdGVkX1/O42CM1fwpH5/5PZQlqikAgF43ao53NhvAY7G6tWaGZ60O5WsR31ZJn3bkiHvvdlBby1JhLI8B63hOMNz4m8x2xwKB7ohj3FXFiUABfQNCXMYdpxAasgicikP6k1FWF9iIybXTnLOihjws0eHI+S+aNteDUNHf4cqC7yEc9rlND30m9IthZ8heYg2UJQ14kwysWBr7RmnqhwtoYSr+ZKG+W/HoON/fzmgtsu/MPZta3En+Zt6+wmUA5aik3jJ89/wW8mO4/yQjkl2Bx939HFnK5HfTnI12Mc8vGbv+IYn/UeuS6FhJNiGd0ag81M2If9kAEHYEdq23x7o07NeoPDt9

On Fri, 14 Aug 2026 16:12:35 -0500
Martin King <martin3kx@gmail.com> wrote:

> Commit dd29c017aed6 ("sched/rt: Have RT_PUSH_IPI be default off for non
> PREEMPT_RT") causes reproducible multi-second audio dropouts on an ordinary
> non-PREEMPT_RT desktop running a DAW.

Thanks for the report.

> 
> Symptom
> -------
> Audio cuts to silence for 0.2-3.5s at irregular intervals (roughly one per
> 2-3 minutes of use) while the machine is otherwise idle and responsive.
> 
> Mechanism (as measured, not inferred)
> -------------------------------------
> REAPER runs one SCHED_RR prio 20 audio thread plus ~15 SCHED_OTHER "livefx"
> worker threads. During a stall:
> 
>   - the RT audio thread is blocked in rt_mutex_schedule() on a PI mutex
>   - exactly ONE livefx worker holds that mutex, has been PI-boosted to RT,
>     and is enqueued but never scheduled
>   - its schedstat shows run_ns ~0 with wait_ns tracking the entire stall:
> 
>         reaper/livefx tid=43910  run=0.0ms  wait=3406.6ms  slices=2
>         (during a 3403ms dropout)
> 
>   - meanwhile ~17 sibling threads run normally with wait_ns = 0, and no
>     thread does meaningful work (largest run was 7.2ms across 3.4s)
>   - the machine stays responsive throughout; unrelated SCHED_OTHER work
>     proceeds at 84-94% of normal rate with 0-1ms runqueue wait
>   - all 16 cores keep taking timer interrupts at normal rates
> 
> So a single PI-boosted RT task sits on a runqueue, unmigrated, while other
> cores idle. With push disabled nothing hands it to an idle CPU.
> 
> Evidence
> --------------------------------
>   kernel  RT_PUSH_IPI  playing   dropouts >=25ms          xruns
>   7.1.8   off (default)  19 min   8  (191ms - 3471ms)   bursts
> 23/265/434 per min
>   7.1.3   on             39 min   0                     0
>   7.1.8   on             42 min   0                     0
> 
> The third row differs from the first ONLY in the sched feature: Identical
> kernel, toolchain, GPU driver, project and audio configuration. At the
> observed broken rate ~13 dropouts were expected in that window; zero were
> seen, at both 25ms and 10ms detection thresholds (10ms is ~2 missed audio
> cycles at quantum 256 / 48kHz).
> 
> Workaround
> ----------
>   echo RT_PUSH_IPI > /sys/kernel/debug/sched/features
> 
> Applied at boot via a systemd unit.
> 
> System
> ------
>   AMD Ryzen 7 5800X (8c/16t), Arch Linux
>   kernel 7.1.8-arch1-3 (and 7.1.5, 7.1.6 - all affected; 7.1.3 is clean)
>   PipeWire 1.6.8 + pipewire-jack, Focusrite Scarlett 18i20, quantum 256 @ 48kHz
>   CONFIG_PREEMPT_RT not set

Unfortunately, I'm going to be traveling next week and I may not be able to
look into this until I get back. I don't see anything that the normal (non
PUSH) logic would fail in this case. Thus I'm thinking it simply has a bug
that has been hiding because we've been using the PUSH logic.

I may be asking for some traces here when I get back to find out the exact
cause. Use the workaround for now.

The RT_PUSH_IPI was added because of a "thundering herd" of IPIs when all
but one CPU dropped its priority and the one still running had more than
one RT task on it. That would cause all the other CPUs to send an IPI to
that CPU to do a pull, but only would would get it. The RT_PUSH_IPI was
created to pass around a single IPI to do the push for all CPUs wanting a
new RT task to run.

The above use case doesn't look like it is having that. Thus, I'm thinking
something else broke.

-- Steve
