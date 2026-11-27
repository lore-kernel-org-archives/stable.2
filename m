Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785261;
	b=PXM0CblLivVimtoYKd/GGI5ueuJudOlRzRPmwsIaezoi5tV6TLIuWHpuoBQpnQ4PL9sz
	 nC26SrCdcTiQIkITc6XVuREthdAHbpNtMbg7FeyKqJ2qSYqE5b7/u/oHyNs9U1xDKy/q6
	 PgK5F6namfk6yQ5ubeIr/lOB6qGA8JUmUP/nlXJuNi3IH5io73n7JV+VZZG+6lVbCYEfo
	 TKDdo86lu+FV6kiZR5bsp9zu6saviA8fTcpUoMSxqzyQ+g2VOoMDCO99iEuCCb4Vzzsbw
	 rVXZCVdkNpsl4E/pRwjQx/5BVHTFAUaqvrqbIU+znvejVqmZSBYaLh3kMmdt5gFJFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785261;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=opKcnubl27drJR5MynPgskxgraLdng2dtGTp3OwZnpU=;
	b=UWubF4hIl76g4zj8tf+1PlkB29Zkw8xx/aVRWEZYjuO1wk7YYHinMd+BNInvXUG5koZK
	 YDMA7afDgl3I207MlTqJaHBRvppE2RdhUxSFEJlLWvaPa7IHv1fj4gSxbptbcKceJHjsm
	 tp7r4hLnm8Y0c3uLvlWVD8n6F/Qr86tgcFciAT3QRErOd2XnVQVWtNz1xGVEj17wnTAxV
	 +EYwwOTkKk7eH0t1BMnFeKEnWb6jj4YCJCfgAmbv2QO2bOnRkV5fj3eRJa6e+aZkciPjX
	 Nb23oS03QXHFOiZDHkgM5CzgO6kSsZLLx84O4ym+Al0Covu48xg0hsUFuUP8xS5Pmwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLAPQUWY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50A606A31C;
	Fri, 27 Nov 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLAPQUWY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055491F0089A;
	Fri, 27 Nov 2026 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795785260;
	bh=opKcnubl27drJR5MynPgskxgraLdng2dtGTp3OwZnpU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hLAPQUWYkFM/KZOrTNUnsaiXz5u7Kf314rFLomEz7CYaDKFnNLXyy28tFd6oDLii2
	 90HfAxQ//Fw6ARfZzHBplLpeIpuE5RD30rNnWkAdnVEnS1h9z5F21FkiX2EG+F62oi
	 fINOvHt6mfDEG6cFTDVPJRCRnmWBT3QYI3PKGPhz5lZGyDs4gzuvWAgsttX3BASSrp
	 02VTUrES5vbhcfQW6c0lLhw2YJYU/T1drlR3+m/f3rLpb1k5NrelIRIOHAtymVjdCR
	 S+JqBlYOnSAsdpFJLYe6C0h2bsxGEit68/UV1tXanOv4ywPKUvNEKpYP0yuJAgh1/e
	 XeW9E6CbLhh9g==
Subject: Re: [PATCH net] net/sched: enforce the FQ-PIE memory limit
From: netdev-bot+sashiko@kernel.org
To: shawnq1@163.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 13:14:19 +0000
Message-ID: <179578525954.3135.976273510614457459@kernel.org>
In-Reply-To: <20261126122902.1504968-1-shawnq1@163.com>
References: <20261126122902.1504968-1-shawnq1@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] fq_pie_reset() (net/sched/sch_fq_pie.c:539-556) frees every
  queued skb with rtnl_kfree_skbs() but never clears q->memory_usage.
- [Medium] Before this patch, fq_pie never dropped packets because of
  memory_limit (since ec97ecf1ebe4).
- [Low] fq_pie now enforces memory_limit at enqueue, but fq_pie_change()
  still trims the queue only with `while (sch->q.qlen > sch->limit)`…
- [Low] The commit message is written as an email or bug report, not a
  changelog.

--

net/sched: enforce the FQ-PIE memory limit

This patch makes fq_pie_qdisc_enqueue() drop an skb when its truesize
exceeds the remaining memory_limit budget. Previously the memory_limited
branch only incremented the overmemory counter. The patch also rewrites
the check with subtraction so that memory_limit + truesize cannot
overflow.

> Hello,
>
> [ ... ]
>
> HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
> git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
> source version: Linux 7.4.0-rc4-g8d7fe9885c62
> compiler:       gcc 11.4.0, GNU ld 2.38
>
> The Gist contains the complete console output, kernel configuration,
> sender source, and initramfs/QEMU helpers:

[ ... ]

[Severity: Low]
This isn't a bug, but several parts of the commit message would end up
in git history permanently:

  - the greeting
  - the build metadata
  - the seven gist URLs
  - the QEMU/initramfs reproduction steps

Could these move below the --- line or into a cover letter?

> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 5982847df8f85..2e14467ae6585 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c

[ ... ]

> @@ -152,7 +152,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	sel_flow = &q->flows[idx];
>  	/* Checks whether adding a new packet would exceed memory limit */
>  	get_pie_cb(skb)->mem_usage = skb->truesize;
> -	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
> +	memory_limited = skb->truesize > q->memory_limit ||
> +		q->memory_usage > q->memory_limit - skb->truesize;

[Severity: Medium]
This still charges the full skb->truesize for every skb, including skbs
owned by local sockets. With the new goto out, that accounting now causes
drops under the unchanged default from fq_pie_init():

	q->memory_limit = SZ_32M;

fq_codel has the same 32 MiB default. Commit 150061a20651 ("net/sched:
fq_codel: local packets no longer count against memory limit") found that
default was not reasonable in practice. fq_codel_enqueue() now does:

	get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;

Consider a busy host with fq_pie as root and many local TCP/GSO bulk
flows. Once usage passes 32 MiB, could this tail-drop whatever packet
arrives next, including packets from thin flows? Those hosts previously
only saw overmemory increase. fq_codel drops from the fattest flow
instead.

Since this is tagged Cc: stable, should the commit message mention this
change in behaviour? And should fq_pie follow the fq_codel accounting?

>  
>  	/* Checks if the qdisc is full */
>  	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
> @@ -160,6 +161,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		goto out;
>  	} else if (unlikely(memory_limited)) {
>  		q->overmemory++;
> +		goto out;
>  	}

[Severity: High]
Can fq_pie end up dropping every packet after a reset? fq_pie_reset()
frees all queued skbs but leaves q->memory_usage unchanged:

net/sched/sch_fq_pie.c:fq_pie_reset() {
    ...
	for (idx = 0; idx < q->flows_cnt; idx++) {
		struct fq_pie_flow *flow = q->flows + idx;

		/* Removes all packets from flow */
		rtnl_kfree_skbs(flow->head, flow->tail);
		flow->head = NULL;
    ...
}

The generic qdisc_reset() only zeroes q.qlen and qstats.backlog. The only
place that lowers memory_usage is fq_pie_qdisc_dequeue():

	q->memory_usage -= get_pie_cb(skb)->mem_usage;

Before this patch, a stale memory_usage only made the overmemory and
memory_usage stats wrong. Now suppose the queue is close to memory_limit
when a reset happens. The leftover memory_usage sends every later enqueue
down this goto out path. Nothing gets enqueued, so nothing is dequeued,
and memory_usage never comes back down. The interface keeps dropping
traffic until the qdisc is replaced or memory_limit is raised.

qdisc_reset() is reached in three ways:

  - dev_deactivate() via dev_reset_queue(), on link down or carrier loss
  - a parent reset such as tbf_reset()->qdisc_reset(q->qdisc)
  - graft

The sibling qdiscs clear their counter on reset. fq_codel_reset() does:

	q->memory_usage = 0;

and dualpi2_reset() does WRITE_ONCE(q->memory_used, 0).

Should fq_pie_reset() also clear q->memory_usage now that enqueue depends
on it being accurate?

[Severity: Low]
Now that enqueue enforces memory_limit, should fq_pie_change() also trim
the queue when memory_limit is lowered? It updates q->memory_limit from
TCA_FQ_PIE_MEMORY_LIMIT, but the trim loop only checks qlen:

net/sched/sch_fq_pie.c:fq_pie_change() {
    ...
	/* Drop excess packets if new limit is lower */
	while (sch->q.qlen > sch->limit) {
    ...
}

fq_codel_change() also trims on memory:

	while (sch->q.qlen > sch->limit ||
	       q->memory_usage > q->memory_limit) {

dualpi2_change() does the same with q->memory_used.

If tc qdisc change sets memory_limit below the current memory_usage,
fq_pie keeps the excess until the queue drains on its own. That can take
a long time if dequeue is stalled, for example behind a slow TBF parent
or a stopped txq.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126122902.1504968-1-shawnq1%40163.com
