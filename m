Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624858;
	b=v6yWxpkGrZGvvAfCa3d95QGEBO6BadTr2HCb2go9jLl96lBdd8k911ieEYhJjRUBSsdm
	 NlORBDD2eVOBhPx8SLl8UliZK5Uy0k9+TJvG/SwBtT3o9wE+mDgLBnFN7e7QvdXeFzRsY
	 Sk13+E7WBaXu6AICGqV1hK1fIuymyb/7oDeAsZb/kNhErKedseRrI3dp2zjlD7OcEveY4
	 zHC4DpoeA4khI0c3kv/L+Uwh2fBy7FiXPBmwFdPjwXue+JuAm7DflUMnZG5znqsXx8Oec
	 O+P28CuKPdLYStjHwgy5gb4aR1ulzIGyNfX9auP+KIjFpVDNzpqxo6Jc+Ko0G82uDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qSfqdzbvujU+FDqCegWxFi5CNZUvlPNo+IOnNi1oeaA=;
	b=bnwZ8qLIrr2NGEAAO62245OGZZa5dn1Gm+JMBs9U3dD6m/mMnbUakBfw2Xvtr2wkr6wc
	 ZWUwW1Cpf66x5uSZeJB9S6YCvkhY5msCQvCPUfqFDgVSCtoNKIIMEpzaN1CGnmVrVJR+v
	 FeY5GU7mDL1uj6RMfSyv4QqA5YTu2+h6NewW+d0OTHpPYJf6qmZQbWoKGyjp9dm/LlM27
	 QsF7Rc2ydH4E+voauPIA1MtHZ4st5mjN2pRWtA00ig/Q5OuZiWpk9KLKXtSYOezME+feF
	 ODwLJh9xRr02+GBHLDoqSMPsIp7GHe67BRwemHonyfZkNBFeJY6pHz9B2mvKaUvk6Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PprU1qNK;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145460A2602;
	Mon,  2 Nov 2026 13:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A145460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PprU1qNK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qSfqdzbvujU+FDqCegWxFi5CNZUvlPNo+IOnNi1oeaA=; b=PprU1qNK1fGwSZfOhecIzFqJZy
	Cto+++WcqbPQrJ3tfomrB5L+/34vvZPp1VfBo0rGWZW1XEX8kN9E/EgM4tsE0u3i+Kem/41jEksPq
	5rYI19ZURqOr9vwarP/ZykNe6bnguRGuvJq2S5KPUV51f9rtWB/JOZp+mztxENgawpgm8cmjDwTwW
	JwiStgYLlX50gB/7r2LeU+Hr/y5xF1TAP+q1qCeYOGYHU0xmUkvsSy+1B4wUNiQEq1/8ykGjr1T3m
	Wa/2bpy6gY9zktKucwbvwHlJFQz/fDHWneGA1Cxpjj0qkO//mtYT8L2Ieh5Bs+BPUQmpSDo2yq1Lm
	ye5po4Qw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNrl3-00000002XWm-1l5G;
	Mon, 02 Nov 2026 13:07:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 811E3300322; Mon, 02 Nov 2026 14:07:28 +0100 (CET)
Date: Mon, 2 Nov 2026 14:07:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ahmed Abdelraoof <araoof@amazon.de>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Vineeth Pillai (Microsoft)" <vineethrp@gmail.com>,
	Josh Don <joshdon@google.com>, Ahmed Abdelraoof <araoof@amazon.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: keep offline cpus out of core-wide selections
Message-ID: <20261102130728.GI1813469@noisy.programming.kicks-ass.net>
References: <20261101221219.118052-1-araoof@amazon.de>
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
In-Reply-To: <20261101221219.118052-1-araoof@amazon.de>

On Sun, Nov 01, 2026 at 10:12:18PM +0000, Ahmed Abdelraoof wrote:

>  kernel/sched/core.c       | 12 ++++++++++++
>  kernel/sched/core_sched.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d7c3b43158de..f55f6a0befcc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6413,6 +6413,9 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	 */
>  	max = NULL;
>  	for_each_cpu_wrap(i, smt_mask, cpu) {
> +		if (!cpu_online(i))
> +			continue;
> +
>  		rq_i = cpu_rq(i);
>  
>  		/*
> @@ -6448,6 +6451,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	for_each_cpu(i, smt_mask) {
>  		rq_i = cpu_rq(i);
>  		p = rq_i->core_pick;
> +		if (!p)
> +			continue;

Can't you do what you do in the last hunk for all 3 cases? It seems
unfortunate to have 3 different ways to iterate in one patch.

>  
>  		if (!cookie_equals(p, cookie)) {
>  			p = NULL;
> @@ -6760,6 +6765,13 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
>  
>  	if (rq->core != rq)
>  		rq->core = rq;
> +
> +	/*
> +	 * Core-wide selections skip offline siblings and rely on a NULL
> +	 * core_pick to tell them apart from participants.
> +	 */
> +	rq->core_pick = NULL;
> +	rq->core_dl_server = NULL;
>  }
>  
>  #else /* !CONFIG_SCHED_CORE: */
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index 43e0bde3038e..1efde88da76e 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -273,7 +273,7 @@ void __sched_core_account_forceidle(struct rq *rq)
>  		delta = div_u64(delta, rq->core->core_forceidle_occupation);
>  	}
>  
> -	for_each_cpu(i, smt_mask) {
> +	for_each_cpu_and(i, smt_mask, cpu_online_mask) {
>  		rq_i = cpu_rq(i);
>  		p = rq_i->core_pick ?: rq_i->curr;
>  
> -- 
> 2.47.3
> 
