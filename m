Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940250;
	b=n5aVlRL5FENM2/8I3UMVUiOWM8WxCGFMlP7303z5HzptE30zQDxH4usfav6l9578IipZ
	 QuqtRO/x4U5TpUtiwZjy1/ifMqDd8gE4ofC25rfmYorpACAfFkzEbk0kVcWgLw2fMuCcY
	 nY/KNkVA1+axOcrNXA8gkMhD2V3Az8iOOl4i5nnkkyeYtrruwzIvZninBj5fnOVoaySIf
	 4MJ6ANdWZBREpJ//RvdAHx5bWVsYiwvP9WX0sl9XvY41zFmtOhIMtQjHXG9oaJwNJRtRb
	 YvALSOtOMHS6vWN/QOY/OElb/unyddDs9YpXXM6d7yyDw8A6/P4EAbtFH19M6V3EhSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940250;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9OHpVTRaAtsxgAwyU7FqfKE7aswl1KowsIraapIR5A0=;
	b=1XfsJRBK+lKFgVjp/q/0CsL7sBc5Cg2SlVDWYwfBPLJ3ETe6K1juzsSjm2DQYDdrLmh3
	 1aARf0/FxtNxXQ6T7OwNVwUu8z9Y4T+mnHrpWlWMR7axagJqg3y5ijYMeCY+x3LqR9YdO
	 UVO2rnERZKrSGOH2QS4upIzaExdyvoC51m4bBewySnOBnTXqFLOPiyPMSsGRiAyzj58Vi
	 DivoHdJldlcQDjPKcJOwM7Z3lTIBPmtepOpIIcnzAjDdf5eDiBxZqdSDj990F9e/NKx3e
	 hTrR+mar3l70xQNDJ0SexxhZ+mm92KgH9Fc8HmzXLCA9D+gu/jN2K7LrAbr4GyxdESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Njg3S+5l;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFA606A32C;
	Tue, 17 Nov 2026 18:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84DFA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Njg3S+5l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9OHpVTRaAtsxgAwyU7FqfKE7aswl1KowsIraapIR5A0=; b=Njg3S+5liaJW+kh4Jq0SdPm+Lc
	svtA1ZJa22rh/T7J9LDZFAE4WJKOLoIYd96nRUzGrox1Ct4e7uLR+HHhRpzm52Ga/z1NXqYAwWBCE
	8Cd8An2WQ1BjR4D2Qv59udVpqP8Li6o5oXI9zaceAhh72lTpA0TXSeP2s3AmsuA2W9/imuzaB8dBa
	bW5101kU73uPAAtZ3Wn3F/W96NcPrmUtzHHHdnNqfiKX3jUSpYC1B5jyQ/DhshwaI/TsyE6WAJ1R2
	QEwrpzDdCek3IOYfT8PwdkRhcxuwTXjpuzIHxkuQYpD+szQU9CsoHInTTGxD36z8MeI/z1LvZUNPi
	knDb9l6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTNx6-00000003sry-12m3;
	Tue, 17 Nov 2026 18:30:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2099A300708; Tue, 17 Nov 2026 19:30:43 +0100 (CET)
Date: Tue, 17 Nov 2026 19:30:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
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
In-Reply-To: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>

On Mon, Nov 16, 2026 at 01:55:26PM -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in sd_init(), which can
> break the build with CONFIG_WERROR=y / W=e:
> 
>   In file included from kernel/sched/build_utility.c:86:
>   kernel/sched/topology.c:2008:29: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1998 |                 .last_balance           = jiffies,
>         |                                           ~~~~~~~
>    1999 |                 .balance_interval       = sd_weight,
>    2000 |
>    2001 |                 /* 50% success rate */
>    2002 |                 .newidle_call           = 512,
>    2003 |                 .newidle_success        = 256,
>    2004 |                 .newidle_ratio          = 512,
>    2005 |                 .newidle_stamp          = now,
>    2006 |
>    2007 |                 .max_newidle_lb_cost    = 0,
>    2008 |                 .last_decay_max_lb_cost = jiffies,
>         |                                           ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.7.9.23, the evaluation of the initialization list
> expressions in a designated initializer is indeterminately sequenced
> relative to each other, meaning any side effects in the initialization
> list are unsequenced.
> 
> Add a local variable to hold the value of jiffies before the designated
> initializer so that there are no unsequenced side effects while using a
> consistent value, clearing up the warning.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
> Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_numa_init()")
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Use a local variable with one access to jiffies before designated
>   initializer (Nick)
> - Link to v1: https://patch.msgid.link/20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org
> ---
>  kernel/sched/topology.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99878da03bce..60fad1690894 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1956,6 +1956,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  	int sd_id, sd_weight, sd_flags = 0;
>  	struct cpumask *sd_span;
>  	u64 now = sched_clock();
> +	unsigned long j;
>  
>  	sd_span = sched_domain_span(sd);
>  	cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
> @@ -1973,6 +1974,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  #endif
>  	sd_flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
>  
> +	j = jiffies;
>  	*sd = (struct sched_domain){
>  		.min_interval		= sd_weight,
>  		.max_interval		= 2*sd_weight,
> @@ -1994,7 +1996,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  					| sd_flags
>  					,
>  
> -		.last_balance		= jiffies,
> +		.last_balance		= j,
>  		.balance_interval	= sd_weight,
>  
>  		/* 50% success rate */
> @@ -2004,7 +2006,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  		.newidle_stamp		= now,
>  
>  		.max_newidle_lb_cost	= 0,
> -		.last_decay_max_lb_cost	= jiffies,
> +		.last_decay_max_lb_cost	= j,
>  		.child			= child,
>  		.name			= tl->name,
>  	};

I don't speak enough C legal to actually understand the Changelog, but
the actual change seems daft. Is this really needed?
