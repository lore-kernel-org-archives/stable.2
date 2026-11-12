Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496079;
	b=2Ju2MDpGMO6oen/h9HR07OaAlDyuDqKbTCz8wTFHSX5ip6LGP0Dcj1hA65PsrkDvAoot
	 wlatFsqKhNA12z08In6T0Pfa7ty4rzHGkXv81BBUzJpEP3FM8asF5vstnXgMGu4MG+Zb6
	 qtDFvpR4hdOBZMgGzq8FEeViPDnIfdwKRL1Wk+IZ0f5iAnbNUNoDHUGYq3s/2SQAi4ZLU
	 0qvZWOr0cd6fl/WoOLLtecubGm7h3PqfwDFyLRm+IwEK+oVg5QJCj0lVzMSSDBhh2Mt5q
	 /Ae/sHBciqxHz0KuHrTGrfkv0rhGrXwWtVsNmscPdwU/f1fNvxhhvlo7128wa5GF3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6opaRvcpYR6ER81jsMzDjvR9PJZQhTjt+6UYrb+STEQ=;
	b=nTSJAlH2BR5YjapnrY9JCf334Com3lm7slf92xTA0fZxCOEoQQoVNjX1B9pMVJFHBGlW
	 iFURGPBvLCkP3zxCd1hOv2y8xFygZqBJ0AGMODmnMNhcFIsXQpUukAKOabzu9uL72pGMX
	 whArDijOmlHQ0Km3yTGVBMSPV/TPtN3HQgZXoqJcp8P3Ya/BFH53ysLS+nLUOysVwbp3N
	 A3Pbj9TvzaTtDDVY7yC1kLjGgcRQHLiBK8CuynXF4s46QZBZFRAB7AHp6YVWhgZ1I3oqW
	 /wzbu/BuOW3KZUOtPTGOuCCl8UlSylkLENoZbrQ5Hml0cys5cxIVlo16sXTcDR37Z4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=XKFkU1s1;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B7606A330;
	Thu, 12 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9B7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=XKFkU1s1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6opaRvcpYR6ER81jsMzDjvR9PJZQhTjt+6UYrb+STEQ=; b=XKFkU1s1WLuQPbtURXoArtJ7j7
	o9pwHo3e6AdR8Zgtb6oRujApHL3gysKUnm6lDE0R7s1iTknyaH74HuyPtjCmuEoIGR3T+kN23iBZ/
	KlC8uFl6aqsVrqrxFqFnM5qZQtQR+WRpfY7ztO0HcKJKXGWlRTCs/Y8GwaDEVsUt8sXtElrY1Gp5f
	uACRXsOItxvIZI7gScaYKe66Qxz8TJE5h1mZ6Thk3x0sk28ZJmbOjryXKSMUK7zjjSn7aaN3r8lOG
	q6ISBbgwj1rpG85dXSwLafePK2XjQK1CNNQ7Y+S3vUAsU2M3nNQuw5l9OUmUQ8djIDj4r0kubq30z
	9X5y0OfA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWP0-00000008PHw-0kFR;
	Thu, 12 Nov 2026 15:07:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42E64302FBC; Thu, 12 Nov 2026 16:07:49 +0100 (CET)
Date: Thu, 12 Nov 2026 16:07:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
Message-ID: <20261112150749.GA1813469@noisy.programming.kicks-ass.net>
References: <20261111092421.3771992-1-chenhuacai@loongson.cn>
 <20261111170600.GS1779021@noisy.programming.kicks-ass.net>
 <CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>
 <20261112081348.GB2668804@noisy.programming.kicks-ass.net>
 <20261112094059.18f66c2a@fedora>
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
In-Reply-To: <20261112094059.18f66c2a@fedora>

On Thu, Nov 12, 2026 at 09:40:59AM -0500, Steven Rostedt wrote:
> On Thu, 12 Nov 2026 09:13:48 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > num_possible_cpus() is what I was thinking of. Notably, there is no
> > requirement that the CPU bitmap is dense. You can have nr_cpu_ids at 256
> > and use 255 for your boot CPU. It would be completely daft to do so, but
> > it is still valid.
> 
> Hmm, I was under the impression that there would always be a CPU 0.
> 
> Is it possible to boot with a non zero CPU setup?

Yes. Voyager did that -- although that code is now long gone.

In general we must not assume boot cpu is 0 -- although I don't know of
any architecture that currently doesn't have that. Might be fun to have
it as a debug option to catch out assumptions.
