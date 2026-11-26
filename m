Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708089;
	b=4PPou/RAZ77YxDZJnR6KiPLr98xbtS5rOOTq4fH5nxk5ar7BPsBxMQbdGv3cr+F/DjTT
	 uFhB4GeuFRpqzAPIqM2FyG3csYnz0AARaqasK5XODhOQd96I45LGHsBkBwGRHdky6O74I
	 9HZTCxOXZ96gux83rnZCsfQnMljGwuck6tw+1svXshulVWWjExnJTuWJW1Yi/1MYrsPBS
	 r1guK09nHk+lJcHdIXPW5kYZbP+ZwbDZ3ba6czjgLntOA1gvPglr6R2eKf4oqtmXtwYKq
	 jqApbXmnM1yUSH9VeCRz2NLarSAxdKcLj1KpZ8/i9soYzA42Go1I84n/iM/susfZVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708089;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ih8tzc09CooWgckjqEd6PhiYBuj8ZOLowYuFuY6jsT4=;
	b=W9fDEzgWxzaL1tn3XkP83CR1tUKKV/2qYYNKdDRMQHqz7CKpoWU0eSwNw6uHcOIWwVkZ
	 b25KBDRKkVBX4UuqhHe+zKqBR3AI9hJLWIZK5/pppAYD84hfSn4bn6HeLMbcaDwtlvSTC
	 A0ScJ8nGQ/n2lOvttlUEyd9CmHYn0zVHjIAbQwZdUQEDzAeXoj/P8JoPBGQiubFAa/eeZ
	 X7jyzY+6S2c6dQY8rKezxh8O6w1yXuNtzuheJrbrQjlZDol8f5wfnsV2M2yzK/Q/Br9Jd
	 w4tuR43tunmh7z+oW4R6Et0o9ZyuzpjuCEjX3o0C5aBrNRahHXyZAwF1PkPFCKaVpBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CZuc94Lx;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAD606A31C;
	Thu, 26 Nov 2026 15:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CZuc94Lx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ih8tzc09CooWgckjqEd6PhiYBuj8ZOLowYuFuY6jsT4=; b=CZuc94LxPGCIcwUtE7XLmnQHPJ
	T0hnaVTlz8rWvJfIVlqGpaoDPa1A2VbCUby39FEXpAqvwnvKXR1iQDXnL1Fr9QDx0kpoX0FHB9bCi
	InIvchiEdbUJRhTQqpyWsWgQTB1PNpqv+fzhkcI9INz3PA4acZpDNLr8uxsXEHB7wRypWboVe/J7s
	cD0nlzioGgOt9Zvmfyi3JeNV0mGsN2etcNEreo3I0MnSRVVm+56Ec5d+a6DNdlyF/L/32zMtFBFwG
	BN/qgJaGU8q8QbTGLo8xhPRaeOATgaaloQiKxB/VFfK7d9+xV31axp2Sol7/AVHzWOnXgsi9hfoaK
	aY1Wl0sw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbhd-00000006pCp-2nHy;
	Thu, 26 Nov 2026 15:48:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CAEF302186; Thu, 26 Nov 2026 16:48:04 +0100 (CET)
Date: Thu, 26 Nov 2026 16:48:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, mt4022@columbia.edu,
	Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/7] sched/wait: always queue new waiters at the tail
Message-ID: <20261126154804.GK49833@noisy.programming.kicks-ass.net>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>

On Tue, Nov 24, 2026 at 12:46:30PM -0500, Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 23 Nov 2026 16:48:44 -0800
> Subject: [PATCH 5/7] sched/wait: always queue new waiters at the tail
> 
> Non-exclusive waiters have been added at the head and exclusive ones at
> the tail, so that an exclusive wakeup stopping early still woke every
> non-exclusive waiter.
> 
> That only matters for waiters that mix both kinds on one queue like
> read() and poll() on a pipe - and even then it doesn't actually buy
> anything but complexity and fragility of the code.
> 
> An exclusive reader consumes the event, the poller had nothing to see,
> so there's no real point in keeping the two ordered.
> 
> The pointless ordering results in a special rule for everybody adding
> themselves to the wait queue, and that rule has not been consistently
> followed anyway (see for example do_wait_intr() and do_wait_intr_irq())
> 
> So just queue everyone in FIFO order.  LIFO might be better for
> throughput, but every time we've ever tried that optimization in real
> life, it has caused fairness issues, so let's just do the obvious thing
> and add new waiters at the end of the list.
> 
> Priority entries (used by the hypervisor code - questionable special
> case) are still placed at the head by add_wait_queue_priority*().
> 
> And because epoll is a pile of stinking manure that I am afraid to touch
> this leaves __add_wait_queue_exclusive() alone and it adds its entry at
> the head for epoll's ep->wq so its own wakeup order doesn't change.
> 
> Now that it isn't a "real" exclusive wake event, its ordering thankfully
> doesn't actually matter for anybody else.  It should be fixed, but it's
> now basically just an internal epoll thing (and that will be made more
> obvious in following patches).

I like this :-)
