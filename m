Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774492;
	b=odQCh8l3iyBIASPPdD0gTEawxOroiSjhSYRRUeBkXR2XJMzzbjeqmsaIXuT/Km5kqqIX
	 NnsvCMh7l6A9S+GJ5WzIJpjdO1/39UoxqxhA5+cdmFuur5tX4S3AU0BAXQw9iZqmZdiln
	 MIgsa5ZnkrZ9uAHhmwj51YctLuIhia/xsU5PImDM7XTNE5SKUUSzzM+l35a4DxdOKsZro
	 TaX0M4/GfsT4DmER7gEKG12FAsIMW9yujgdvrLpRNuRSV0vvTiYyGJ9a6e30yjaMZbznL
	 zw5+LjOVOCiqFuSbvOga1qHJ/9IM0IFSiKQYffEv7xTsLbcDzNmfBFkLBdILtG2Ed0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774492;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gfAz+igUaZQtqJ8U5CAAvNBQ49KsairTBI4/qgGsxOM=;
	b=BGv/lrJ1Xs3o+au9dOyyAA/Y1PUKWFh7X+jIdZcCXfD/Y6IfyZoHvGyRUqob5qF5p13R
	 X8CiXY/SPf3YYtMTH74+n3Ax511W8qarPCqVfjZFim8HzVK+8gPI2BCeEWo53trm9GwQz
	 u/beGWUoF0YWwgrq4/zQ+VoKKd7pp1oFezSdH8A/87r8FwFwSXIpbRsMq5HjZIXz0xg2l
	 jk4Qg+LxhB3R3s+JeLv97YzP1YvZQvyzHT1yAy4PcRc+n0/wqjo3uCNnbfFBIXxIuPp3P
	 gcMV5WViKP6+LS7UcEeKX0XnwMZSimHbU8HH9nLCSB3kA9wNGkzgWgjhpYRWzl8F6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jk6uF4BV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3D60A260C;
	Fri, 27 Nov 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jk6uF4BV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E951F0089A;
	Fri, 27 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774491;
	bh=gfAz+igUaZQtqJ8U5CAAvNBQ49KsairTBI4/qgGsxOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jk6uF4BVYxjpa7BcdvmvYO0JVlWJ7Aw+egsP7dUBAgWLZ60e6KchWnkoopl8FLOVJ
	 GxRJ021z8UCTo+6fv8LCv4iqLRMxFHVEqCNwNTp6dCgG87r6gy0PwbLWwA/Xkd3/4N
	 DWc2vfR7xkrqVaR0163e6i8NKA3f/eSkVI2kiIFf3XIlEGFK2rJb+4RrBL7XkaYVis
	 QeNqtXgW257auKS8pXzNeQxa+nXikiid1YHZdL6aLi18uI+6hpHhdyP57N+cLR67ty
	 sNfQIEZy6f6HUwojT6VaI4ri8G7N6SXk0VDNoeU52NbTR12ejOq5aPGiYaM3hg/Wpt
	 92vc15IHZ3BxQ==
Message-ID: <398670d0-809d-4cdc-b03f-80bc3b5faa2a@kernel.org>
Date: Fri, 27 Nov 2026 11:14:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
Content-Language: fr
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
 Victor Nogueira <victor@mojatatu.com>, Po Liu <Po.Liu@nxp.com>,
 stable@vger.kernel.org, sashiko-bot@kernel.org
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
 <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
 <20261124161258.vLyrm8Y4@linutronix.de>
 <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
 <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jamal,

On 24/11/2026 18:11, Jamal Hadi Salim wrote:
> On Tue, Nov 24, 2026 at 11:58 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 11:13 AM Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>>>
>>> On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
>>>> This is a followup of commit a51c328df310 ("net: qos: introduce a gate
>>>> control flow action") as reported by Sashiko.
>>>>
>>>> The issue:
>>>> fill_gate_entry() only rejects an interval of zero, but that interval is
>>>> the period gate_timer_func() re-arms the hrtimer at, and a few
>>>> nanoseconds is below the cost of servicing one expiry: the next is due
>>>> before the current one finishes, so the action holds a CPU in the timer
>>>> softirq for as long as it exists.
>>>
>>> The timer is programmed in the past, fires immediately and hogs the
>>> CPU.
>>>
>>>> On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
>>>> 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
>>>> few percent and it reaches zero by 100 us.
>>>>
>>>> The Fix:
>>>> Require at least 10 us per entry.  An act_gate schedule is not tied to a
>>>> device, so unlike taprio there is no frame time to derive a bound from;
>>>> the bound has to come from the cost of servicing one expiry, with room
>>>> for a kernel that services it slower.
>>>
>>> The 10us sound sane. With enough debug (say kasan, lockdep, …) this
>>> might become tight again.
>>>
>>
>> Agreed. Unfortunately, there is no way to derive a "good value" here
>> (it depends on workload, machine, utilization, etc, etc).
>> poor choice of wording on my part - should probably have said all of
>> what i said above for precisiness...
> 
> And now that you bring this up - this should really have been
> targetting net-next not net.
> I dont want to resend (unless sashikos find something sinister) - but
> Jakub/Paolo consider applying this to net-next instead when the time
> comes.

I'm sorry to say that, but a new version might be needed: it looks like
the new tests you added in this series are not passing:

  https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/928799/1-tdc-sh/stdout

It started there:

  https://netdev.bots.linux.dev/branch_deltas/net-next-2026-11-26--21-00.html

Or is it due to conflicts with other WIP patches or something missing on
the CI?

pw-bot: cr

Cheers,
Matt
