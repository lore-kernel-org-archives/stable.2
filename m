Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471237;
	b=dXNJfc/+GkYYKD2rXSFefdUVdUrSCZ17vbUe9LUpnep0WPti6yPsHXDs0qM5OdH5rAFU
	 Ir99pTuJoNzoodgkCzpP1LG6+vn4HWQPuJjeRITtpFt9suskBXO4JnoZzTpX8rIi/QMnU
	 eEJO7vKnAPsTWgbuLM/0rvC3M/3TdvarycfEDPVlk6w15LqXzmF4XIkEXG1ogLKNOE/ev
	 gYsUxgyvs2M8h0kTZp1iM8FDgeJ3YpS7iLfDk4dEmShc+iwAp2P560QsVa/EsM4Y2cd8i
	 F9gWbxSKp5X+t8igsoXB7V+fyIba9Bw//DO03nGhHi6TQDPWb41T+Sk1Yw2/fVglYxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471237;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=AAYDr7E9radjTyRXS1eA7bh71I8p+v4ZRugl/5oWIR4=;
	b=VxrCmNDwo5HkpkVLSDHxfPjxm4WT8MCh1PTl+gCGCLBrcjwac3mVOrnV/R+p6WUcgMBy
	 jZE9us1PkomNRXZpeMIl8LondMw4pnV9K7mjd4/c2tcX/N70YOFqehjASdqW3UV1hN2my
	 NcwTPIh1M3gioMRSFYxZa1IqmloDsiWa3ZIDG6EIDKPZ5JHa/ZyckUbqvGJcw7lXIfEhH
	 LdorEM1o29nSzFpL3fQ1lu8sFfQxQTL5TY5O0z0Ey8laWbtZ21/AcR8vMCUFu80rp/yJh
	 XjCBBkYDoyDxFDUwYI8z0+KY3qbkZLO5WTsOMZxTM2+TdjbL7OFq5P31hK/hkTOkpNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Z3ToNYQn;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30C606E96A;
	Thu, 12 Nov 2026 08:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E30C606E96A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Z3ToNYQn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AAYDr7E9radjTyRXS1eA7bh71I8p+v4ZRugl/5oWIR4=; b=Z3ToNYQnxFAsoPoDDgVrvhhZNL
	dtjRUB7EHRxJZcB12yPrzJEf3Ngqlw0EknhtanbLagP2BHoXEGt5bkNXybMgX1AFqdPDnlwyIYsaF
	H4bhBvmrXcKoUorNBozISvXJ5bZ2o3hq0gCZ3Isj3aTArlk9ceAL7hw+dkarnLLHOQB9HxEcTTACx
	B9Oi/xmXR1TfWIEuLoMJi7VPKCzjqBpupX5tUsfflexYI1n9tFkaSPksVvapKky60sOoCErsG9M9z
	bPLDER2K1Dp3oFnvUzQkKjjdpGFAtTwVOQ5JFF5PM4nqvaV+JAmj6r92L10ZOglAf1NIN4Gj9yK58
	Ldn54HbA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPwK-00000004ted-44CE;
	Thu, 12 Nov 2026 08:13:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 831CB30066A; Thu, 12 Nov 2026 09:13:48 +0100 (CET)
Date: Thu, 12 Nov 2026 09:13:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
Message-ID: <20261112081348.GB2668804@noisy.programming.kicks-ass.net>
References: <20261111092421.3771992-1-chenhuacai@loongson.cn>
 <20261111170600.GS1779021@noisy.programming.kicks-ass.net>
 <CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>

On Thu, Nov 12, 2026 at 11:14:57AM +0800, Huacai Chen wrote:
> Hi, Peter,
> 
> On Thu, Nov 12, 2026 at 1:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 11, 2026 at 05:24:21PM +0800, Huacai Chen wrote:
> > > When CONFIG_DEBUG_PREEMPT is enabled on a Non-SMP (single-core) kernel,
> > > calls to smp_processor_id() in preemptible contexts trigger some false
> > > positive "BUG: using smp_processor_id() in preemptible" warnings, which
> > > are harmless noise because the process always executes on CPU 0 and CPU
> > > migration is impossible.
> >
> > The check is still valid, you don't want to have any code that uses
> > smp_processor_id() outside of preempt_disable(). Such code would be
> > invalid on SMP, even when ran on UP.
> Thank you for your reply.
> 
> At first I also think that smp_processor_id() should always be called
> in preempt disabled context, but after investigation, I found:
> 
> There are 5 existing skip conditions.
> 
> 1. if (likely(preempt_count()))
> 2. if (irqs_disabled())
> 3. if (is_percpu_thread())
> 4. if (current->migration_disabled)
> 5. if (system_state < SYSTEM_SCHEDULING)
> 
> Condition 1 and 2 is to make sure smp_processor_id() is called in
> preempt disabled context, but Condition 3, 4 and 5 is not.
> 
> Condition 5 can make sure no context switching since the scheduler
> hasn't begun to work, but Condition 3 and 4 can not.
> 
> In other words, Condition 3 and 4 can only make sure the current
> execution will not be migrated to another CPU, and I think my new
> condition is exactly the same.

It is not; your patch would suppress any and all checks when ran with
just a single CPU. Even when the code is clearly buggered.

> > All code must be SMP ready.
> This is why I use "if (nr_cpu_ids == 1)" rather than "if
> (!IS_ENABLED(CONFIG_SMP))".
> 
> >
> > Aside from that, nr_cpu_ids is the wrong number to check.
> Correct me if I'm wrong, do you mean checking num_online_cpus()?

num_possible_cpus() is what I was thinking of. Notably, there is no
requirement that the CPU bitmap is dense. You can have nr_cpu_ids at 256
and use 255 for your boot CPU. It would be completely daft to do so, but
it is still valid.
