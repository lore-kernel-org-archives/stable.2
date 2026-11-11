Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416769;
	b=Zn4R+hkWCsnoigQFmkOUrsYMz7bx3gH394AmjEclm4hmSBFIA47yVyRhXGiZ1r13KfL6
	 +O4C4ylMfZeUYMR2fBrkh4l1/fNNFfQzaYgjR2MtyKXKQLiFaKwDhSXSrFI8+pG6YRLyv
	 ChkKOtz7by2dtx+Jz+q8iaqRrIXcAlh5iQF1GyHg0Fwcv52PztEKcX/Pg5oidaqhQ68QC
	 GD6K1VFnSo4ZL5bDOCjNBrVVv+OisH19mqtenZ2zVQMLK52uNXhrlampg7YUHZj0L+9GM
	 681n2+7q3gmzxIBFbr6Qp7Z6FcdNlNN1BaSn+0zlcrHA8938ATj36jJFDYRYXRE57eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416769;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=A6N6m0qW3yIxjKSp7U7uVNjBd3wWLQIrayrMA06twuQ=;
	b=ZZlpPC0jXgKfcZHqMNQyfLLFSs/gkZ49500lT1UgUS7vTl/q5ZbidANvoVL9j8T7DmGc
	 0YC78fSc5zGUfJuppRM/wBeOu4LBOdObYKaZEOd/3LyOl0l8z9YlcM6EVWZ4X4/DWHCBL
	 9XHwjY9AHd3KoOJKP+iiEz/l/B9snLZ4788z2D7QsE7y6NiJ0lHjPBUUBEao7qNRzelY2
	 1bawyyaKvLU2oydNs+zrNX+yJ2Ia9QCMcJnW/U3sAJ5y3NBQsBwbcUlAeWMxkbws2cUK5
	 nGsxUUbcuBjoq63U3PZSAdKO66emnzlfDyqkmut66RoycTxmRG6zVuv2y+z2C33mgYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ly0OFOvQ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5E606A321;
	Wed, 11 Nov 2026 17:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F5E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ly0OFOvQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A6N6m0qW3yIxjKSp7U7uVNjBd3wWLQIrayrMA06twuQ=; b=Ly0OFOvQAbh1Fx0woCgwdzl4JN
	IqhyJ02ZWh1sH6Y60OeSUyaTxEe4zvEbIiO5jUgAIJqQ7N1FrHRSTSdEIrTTlqoK44EOSWh5/exRb
	5Fl0/laB8l4pLvLdxHFGJAS3lmR5tgT/u08JtvLHdRN9NUb7f9HoFjKhUAZoTt+wSRtNjLAwopClU
	o0DGfIVxFfBJCzJTukpVP86uXjrt4XvS2HRxbogLMjPjzt5KB79aAKN6vqbcx5aaaCoJbWfmPqFRz
	j39TwPGH1a2pFYyYURkIbkRJPH4ZyNxGdi8156kmC6oPk4vJFnmNTs7gA5/ILZxqidjOdkM00yBBh
	D0eYKEuA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBlp-0000000Blaz-10Mh;
	Wed, 11 Nov 2026 17:06:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CB0F230031E; Wed, 11 Nov 2026 18:06:00 +0100 (CET)
Date: Wed, 11 Nov 2026 18:06:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
Message-ID: <20261111170600.GS1779021@noisy.programming.kicks-ass.net>
References: <20261111092421.3771992-1-chenhuacai@loongson.cn>
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
In-Reply-To: <20261111092421.3771992-1-chenhuacai@loongson.cn>

On Wed, Nov 11, 2026 at 05:24:21PM +0800, Huacai Chen wrote:
> When CONFIG_DEBUG_PREEMPT is enabled on a Non-SMP (single-core) kernel,
> calls to smp_processor_id() in preemptible contexts trigger some false
> positive "BUG: using smp_processor_id() in preemptible" warnings, which
> are harmless noise because the process always executes on CPU 0 and CPU
> migration is impossible.

The check is still valid, you don't want to have any code that uses
smp_processor_id() outside of preempt_disable(). Such code would be
invalid on SMP, even when ran on UP.

All code must be SMP ready.

Aside from that, nr_cpu_ids is the wrong number to check.
