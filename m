Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B03AFD0A
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907308; cv=none; b=J5WOP4Si/AgjErWJc8AQb2YClvp12r0BzG8XnSue6YMxM9917G8Fd68lNiy2zqwXLIc9nQKGu5Be8iUt8o8ziVC2gB1bVhm+DZIaI0cQsEQExqrf3kqJxUFYpwuOYcouElOaqPUMpDX7ELZoHDdErNauuGnXwh9csfHOn8hbfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907308; c=relaxed/simple;
	bh=67fh27xT/+1P0u2I89uA2j8hg4N6DBIXDwE3NlgRhR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv+hr9BZlw8evftb6aCClmlysO7p/G7YXpmbe5qe3KckUztwC5baHjfYkGAG4Qy3sqr8jtyeSFdJDo/FQGXCrpDocQM3mp4bG4TRTVev3rWWZHzMXmRTY085TwIxytE809ap1xm10jHUfEQl5ZsVfMvA1ac3MoERk0uQPuTCWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rz8/zOdr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1qFKTiP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rz8/zOdr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1qFKTiP"
Date: Mon, 8 Jun 2026 10:28:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780907302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GymDXHQrKOE1WW3FptMLpsrg6sy9q8dGsyj1wiLfiVk=;
	b=rz8/zOdrNI7B/45x+TltDRvnr95beh1kmj8SjtbEo5ri4EKi7WCi7bDtZwQ2biGP0nrZze
	l9hNhKkd9VpzhBOWPVj/FfLx6DwBltm+ikvl068SgWI2dVlCl/Zt0PRF5UdV8A8V5PSBRP
	GwJcvMy5F9ljdnIqwNdWk846Gze1kcnkyjjjHmKHkCICMm64m2W9f5tdqlLe2zG2BOl9KN
	/txqWyq1NIrLcs5Q0B7HvuL+SMAYF2ykudG427F1ycRy9AQQTWGaO7ISjnOkEAAPDmzitX
	fuPB9phA5Aje//1pDld6mLt3NEEmoRMikMT995Onf1P9V4X7EwvsZTAYylTm9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780907302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GymDXHQrKOE1WW3FptMLpsrg6sy9q8dGsyj1wiLfiVk=;
	b=O1qFKTiP2pX+543PW7DktQSn2zg0Z4wgJLe4Ln7XpzTlQGVevPQ1RnjztC67MWf2FhmxeL
	L9O2t42e28U9BIDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>, Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260608082818.LZiPJ9ot@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>

On 2026-05-11 15:53:53 [+0200], To stable@vger.kernel.org wrote:
> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
> 
> #1 and #2 are prerequisites for #3.
> 
> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
> 
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> 
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.

I noticed that the ARM64 patches I sent recently were picked up and
backported but this is still waiting.

I there something I can do to speed things up?

> Russell King (Oracle) (4):
>   ARM: group is_permission_fault() with is_translation_fault()
>   ARM: allow __do_kernel_fault() to report execution of memory faults
>   ARM: fix hash_name() fault
>   ARM: fix branch predictor hardening
> 
>  arch/arm/mm/alignment.c |   6 ++-
>  arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
>  2 files changed, 80 insertions(+), 26 deletions(-)

Sebastian
