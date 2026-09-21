Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89854B1CE0;
	Mon, 21 Sep 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003443; cv=none; b=ayEEvnGuU3FFvOM7JysfAVuu4oYqNJm3tW0hkGlaCsRpEfkuNpI/ph+H6xngwCpL43AShXYIpfpbuQFdna82ebbBh/B0+MqBnphbzi2e+Ks7eZnV8uTQG8MG/Idz43CU/BpRADPAhi9MctBTnmEzmosmsu3PgiKlMzAK/x6SvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003443; c=relaxed/simple;
	bh=36Esa7CcXgqX1AjuV1cW/7LdzyOcnho1SS+p1s7K+AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1kjWJRwB2iX0jOQHEhzfpq4m9v3FfAUvVBEJHQ8eDuRN8hREFWqbgMLKOfUt4enpIhkUbxoaNMsQ6hMZ97g1gIQ92REI6PAc772ll/MFtc+m7gkWMw5rPgOPlM2xPn/LYwaZYFFyEzHkYqNJBdRbtvus46aWQKWvlJXSY9nxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0fN6Fy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0fN6Fy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14E61F000FF;
	Mon, 21 Sep 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003441;
	bh=yspVN2Kwlp43G8wnBeHwzNPYUg7ni2wqOpiDE7XfVYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0fN6Fy+z+tynKlrYvxj2KabvAl/ED48OvxuilaQMtIpmpex5rwSnqxDJnllNjxY5
	 VzNY9eUPe2uWszTnrAMqbZgCQG53Ws1HhNNlwh8Gd1dOM+kdY+dG/uksnKD/9yNNFs
	 tjsJcLN8WvgOF28mc78HIGIfqVpvYl/sE18sywz1yKIpZNn3RqJTI8e7PpYoKQVjYM
	 nNkxh+PyaKJKVPOpuo9xCkAkgniN3facNyvn2/Z9X/pFXGaZ9iX8mO+pvQL/PSf6ff
	 kgNAKDOO4OdVoDChvybC4Sy/h5W7HRo8PdJRClQa6VsWm7Km2yaJLN5xOHM5TzOx9R
	 cjjBsiNoy8V7w==
Date: Mon, 21 Sep 2026 17:10:36 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] char: hpet: prevent hard-IRQ divide-by-zero in
 hpet_interrupt() via HPET_IRQFREQ
Message-ID: <arFI5vCuzTrsurzm@quoll>
References: <20260919203515.2581203-1-benquike@gmail.com>
 <20260921022019.865442-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921022019.865442-1-benquike@gmail.com>


On Mon, 21 Sep 2026 02:20:19 +0000, Hui Peng wrote:
> In hpet_ioctl_common(), HPET_IRQFREQ computes the timer period as:
> 
>   devp->hd_ireqfreq = hpet_time_div(hpetp, arg);
> 
> where hpet_time_div() returns div64_ul(hpetp->hp_tick_freq + (arg >> 1),
> arg). Whenever arg > 2 * hpetp->hp_tick_freq, integer division truncates
> to 0 and stores devp->hd_ireqfreq = 0.
> 
> Although hpet_ioctl_ieon() (HPET_IE_ON) checks if (!devp->hd_ireqfreq)
> before enabling the timer interrupt, HPET_IRQFREQ neither rejects
> updates while HPET_IE is already active nor checks whether
> hpet_time_div(hpetp, arg) evaluates to 0. As a result, arming the timer
> with a valid frequency (for example, HPET_IRQFREQ with 1000 Hz followed
> by HPET_IE_ON) and then calling HPET_IRQFREQ with a large frequency (such
> as 0xffffffffUL) overwrites devp->hd_ireqfreq with 0 while the timer
> interrupt is active. When the next interrupt fires, hpet_interrupt()
> reads t = devp->hd_ireqfreq (0) and computes base = mc % t, crashing the
> kernel in hard-IRQ context:
> 
>   Oops: divide error: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0
>   RIP: 0010:hpet_interrupt+0x20f/0x360
>   Call Trace:
>    <IRQ>
>    __handle_irq_event_percpu+0x102/0x400
>    handle_irq_event+0xa6/0x1c0
>    handle_level_irq+0x205/0x5e0
>    __common_interrupt+0x60/0x130
>    common_interrupt+0x7a/0x90
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Reject HPET_IRQFREQ with -EBUSY when HPET_IE is set in devp->hd_flags,
> and return -EINVAL when hpet_time_div(hpetp, arg) evaluates to 0.
> 
> Tested in QEMU (-global hpet.hpet-intcap=0x0c24 with noapic) by opening
> /dev/hpet and calling ioctl(fd, HPET_IRQFREQ, 1000), ioctl(fd,
> HPET_IE_ON, 0), and ioctl(fd, HPET_IRQFREQ, 0xffffffffUL): on the unfixed
> kernel this immediately triggers the divide error panic in
> hpet_interrupt(), whereas on the fixed kernel HPET_IRQFREQ returns -EBUSY
> while HPET_IE is enabled and -EINVAL when hpet_time_div(hpetp, arg) is 0.
> 
> Fixes: ba3f213f8a31 ("[PATCH] HPET: make frequency calculations 32 bit safe")
> Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for delayed interrupts")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Add Cc: stable@vger.kernel.org and include the QEMU test procedure and
>   oops trace in the commit description per Greg Kroah-Hartman.
> - Add Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation
>   for delayed interrupts") for the mc % t division in hpet_interrupt().
> 
>  drivers/char/hpet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



