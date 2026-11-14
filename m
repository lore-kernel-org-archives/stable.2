Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794644324;
	b=dl4snjWhbv/NT9ihFM8jnoImv3VPOcoM1uMlS0IqL1iFfYvNv/8HL0eOE25Fd6w9l1li
	 zPC1JBcsicsa6Qw/4//9jfAxexG5MWdv+DLmF9XDUZ9iJW4CmR8nyQBgcBWofPcDs1IhF
	 1fsu3J7OisImiSO/Ip8AVlrcE3zc7F3jse+eojT8L8+1TWku1vkb8DOpA2+sJwI3AA9Ti
	 31TkJeWEIMO5tpqO7cWM19zMxz65NlsOjQs4zCrdmCf3M5QXV4yLK1dtT/34N6BYNUJyE
	 lUee+fyMvGJdIqIFpOmJrSj+2nopS+lb6H/XfJ1oirpk8UnUQ/8lpf/jkyxU26Sgi2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Yh2p04oNykfWrTijnUmHMSqYbxYNwj3PbOSWdtS/d/U=;
	b=UM+xYtycajbd9TS09TfMS1esrPXa0DfRMs9JWNf5bjMHHh9PzffKP9RDYP3rwCDNbV6O
	 VpxEGS9d0X00qc7cRodajMmlH1u61zywaqAF8omGR9DQXVjPZlCG3T8IXPqHY+3dYM21U
	 k9AFPRYBQ7t0VnWmxuvNUgPOsxR0oxIP1XOHQuuKgQJLjct116PD6zZU4YF9+sMkM4iPS
	 hOHUUj6YBTcEsJF6wUKooK8nyM0hWcZBrUHxShROZFZ1bCshKja/JgnCMt7tKKxEjoLf9
	 /KTewkbn6apQDQvCthaYhV2H8GO2xrIR+lFZ/u1MJZ/R9fKQ57LftiBV38s6ET4XrKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Idqi6ogX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402E606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E402E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Idqi6ogX
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso4346780a12.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794644322; cv=none;
        d=google.com; s=arc-20260327;
        b=RCRrpJIufms5+jM20HRtAgM2R1rmcHR0CN8IVp5YGPdH2pBey2rWAEvA1rJyCQTA1w
         HQEfzEoihYkbzkxFCIz/ulHset8l9FFtPQPGf4ymuUToIC5LevQH34YZBND+/GhyqIuU
         qIufhkXGR4f4L+vaUXlIhAxuOVkRkZq34dXTSwsxHoUmKRyYXq25H9WHi9qyNTOZEG82
         SfHKvZrP1e0vzkclB3efNyhJutYWGge1Pudfs1xEJvyAbYNaWOeOqmNrr7UByjs2xo79
         9b2PPT2ZDkYS7MWssta4+R1m+R8ctkVGnEDajwdFJSfk+3cZGcML3CEk/m1foe10Ssdo
         vshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Yh2p04oNykfWrTijnUmHMSqYbxYNwj3PbOSWdtS/d/U=;
        fh=iYmn1tDW1ahhI8JS2tOqDXdRMhwqk7g7BW1f7ncE+CA=;
        b=mGLBeIn3iwQMVxE+nHjOZtL9D1kWLG47TzJ/pt+vfD+Ry06VI0Pfc1ySt4trE8vRnW
         JzKpMTN21fF8onhq3tiYSsJXQiKwr1ORlarOrdw+jqPg57Oc2ZtJuR+dLvtAMwhKkFwn
         K30rEzQdfnnz4BSoYHblGy3oj3EegAJExGMITzjy+CzULJvULjz1i+Fcm4g38cxVNJJB
         sls3PuctmbB60Q24THyArZBwkjiOyOQKVYdAqiukbvWrI1TnLYVf4/mBwVvTOo1SYZtY
         9weSWYgh3SpQinsxvidvadUZ9LWkCqGUiec9mw2WjwfRdRb4oBKcQ/Y8909Yc8/kz0Ec
         9s1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794644322; x=1795249122; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yh2p04oNykfWrTijnUmHMSqYbxYNwj3PbOSWdtS/d/U=;
        b=Idqi6ogXvsl4ocrXkuQ1tQScmsPs/l1gOUdA6Jcr0IZWQqTDy3wxsT/GYDDzouv20i
         x+XiO8gpn5ETvWQqUROlkv8YxuGvx+uLX65XWGNjz7je2LkS49/DQC81jAw1gbl6hx9y
         hg4CunGM3qFQPPgDubaQs6e7pktE/BJJ5Z0mUIH70Uc3M/niW7FWltr/LhFdlVq87G0J
         TIQxf1ZAa6NNYSKXyvgFb0OEc6W2CxhBqie+ojvUTxsTFguS6OJf3+uMbd2ywUEQR4Yv
         WsabIMNEhNIc9PAvlMJT4+46PcRhJ4ldejdNuyg4P7N0HjP0rym5lIMFB7X2ykGbo6ck
         LP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644322; x=1795249122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yh2p04oNykfWrTijnUmHMSqYbxYNwj3PbOSWdtS/d/U=;
        b=OmJFdC1NRzlVELbPoCmYJGJYURExfHuCH6rB69Y/2itnpucG+5QTfTTPHY5yeWCOT6
         EHS9eIx+f/50fVH5O38GksWSAXoHDB2A+Qciv0YA2y9BlNjLlnPYT/zGTk6lX67lMjjt
         wBnWRDeWAKTfFJpVKLNu4vV39VnI0sauIQSF/DB39AUHIw2By0JgG0JE/bhsL54vopCu
         4ijcE+R7vps8S8c0VyHEW5HGvhKbeIaMuZM81QuDD3I5j/tiUO7w96x3oDcMDdQEVRUD
         8oedZqUcID7VJ4jJV4zSDILJbR2VS8wlhQJeps2ZffdpONQp1GBAfhpeh+zaSqfpfeof
         FV5w==
X-Forwarded-Encrypted: i=1; AL+hErG3LM8gH0Y7EiunBAAn9Kq2afnVClXRQxrpT6SD8s5GbZMxDicvd4598Ko8+tzTSLid3szkx6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+cSm1UOxWseMNk/LXa+jhZYiqQLxtlMWErv2mM5rVb+Pp3v8n
	ly/mgaya51Sg3jvTnlX14dFJHn4lvjUo6C9qrJ/qdrkGGVAv2lbwHaZT2pE9coBClgweGKugydv
	KXKXAvC8xpQN5AQ70YljxUla9o396R3vY9Do1yhORvA==
X-Gm-Gg: AYBFou0boBg0fxiLXAtdmMJPfDHLWnerTSeMkZYxdA0RaReZw/MK/FIXxKFZPVpJm8o
	k+KW5HEI9GyYF9jBzTitTHzl6WUe4ee538n6LV+4wcFkY+6+a5x+i5e8GLX1sZQO4EMWeL32oBW
	N3a2wncof5YLYIiJeyV3EsA35xhA9R8tvtEX3afftPZiZ+4N++48xKFYl97NoTYN4t4cTDXP5H7
	Dr7Flv/B1Ox51JTZ2Tdb0T588NqxZzFjxFxQ4Lt0rrylkMMvl1IRQ7tPpFC40hvnD7hvyN7vNPA
	DwuLFw3I2uRwFpqTrzChgwDtdhNmjQ3b77J8pz+xOmCttedrK9zlOZTmfVpDxinLR6ltUpO+WQz
	QARYf2bggIsR3uxpuC8X8wZ1r43JEQbV1dO8JXC8Me8j2egpeh6Hv+ys6IyeRqPYVFhK1Gg==
X-Received: by 2002:a05:6402:23d1:b0:6b1:ca87:c588 with SMTP id
 4fb4d7f45d1cf-6b7c0d03742mr3423273a12.37.1794644322116; Sat, 14 Nov 2026
 00:18:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113153157.2495664-1-usama.arif@linux.dev> <eba9d3df71f3f37bf7a318854a1ab6bf1cfb1981.camel@surriel.com>
In-Reply-To: <eba9d3df71f3f37bf7a318854a1ab6bf1cfb1981.camel@surriel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 14 Nov 2026 09:18:30 +0100
X-Gm-Features: AclHuK-DWsESdLIexmafJNcsytV_5m9A9eaCCw2GnljLrt9_-nMsnLRu-KG7fPU
Message-ID: <CAKfTPtCJLci=Yzq6B0-hK5L0m5iQPw1Y0NDQhKEaV6reg-690g@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to select_idle_capacity()"
To: Rik van Riel <riel@surriel.com>
Cc: Usama Arif <usama.arif@linux.dev>, peterz@infradead.org, mingo@redhat.com, 
	kprateek.nayak@amd.com, arighi@nvidia.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, samuelcrossley@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kas@kernel.org, 
	Arnav Aghav <aghav@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 20:32, Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2026-11-13 at 07:31 -0800, Usama Arif wrote:
> >
> > On a 72-CPU NVIDIA grace arm64 server, small reported capacity
> > differences
> > (1013-1024) within the single LLC activate asymmetric selection. Both
> > the reference and affected kernels were observed with a zero scan
> > hint. The reference kernel ignored it and still searched the domain.
> > A latency-sensitive, wakeup-heavy production workload saw its
> > reported
> > minute p50 latencies average 129 ms on the reference kernel and 223
> > ms
> > on the affected kernel.
> >
> > Disabling SIS_UTIL reduced the aggregate involuntary context switch
> > rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> > raised the rate to 73.7k/s.
>
> Afaik, the asymmetrical selection is supposed
> to solve a very specific problem: when a task
> requires X amount of CPU capacity to run, we
> try to avoid scheduling it on a CPU that has
> only a fraction of X available.
>
> This creates the issue that a task that appears
> to "need" exactly X, because it's been running
> on a CPU with full available capacity, ends up
> not being scheduled at all when the available
> idle core has X-3% available capacity, because
> that CPU happens to spend 3% of its time handling
> interrupts, or running something else.

The task will be scheduled on this idle cpu/core of (X-3% capacity) if
no other idle CPU with X capacity is available.
The selection in select_idle_capacity is:
- Idle core with enough capacity
- Idle core with enough capacity but doesn't fullfill uclamp_min
- Idle core that doesn't fit
- Idle CPU with enough capacity
- Idle CPU with enough capacity but doesn't fullfill uclamp_min
- Idle CPU that doesn't fit

>
> In that situation, it will be better to run the
> task on the CPU with 97% capacity right now,
> than to not run the task until a CPU frees up
> later.
>
> Things like SMT and power-driven hardware
> scaling complicate the matter further, because
> we simply cannot see the full amount of capacity
> that is available on each CPU.
>
> That makes me wonder if we should simply accept
> any CPU that's "close enough to X" when dealing
> with asymmetrical placement.
>
> Say, anything that's above 3/4 of the capacity
> of X would be considered good enough to run the task.
>
> That still prevents us from placing a CPU intensive
> task on a little core in a big.LITTLE system, or
> from placing a task on a CPU that spends 80% of its
> time handling interrupts, but it will allow a task
> to run right now, when the capacity imbalance is small.
>
> Does that make sense, or am I forgetting something
> important?
>
> --
> All Rights Reversed.
