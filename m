Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437684;
	b=ZgWnOYH65X/BlYagb5FuPWh20gVFvKz/t0z6u9kvtLHwFCT/H9SkbLHomF9LQjFsLQw3
	 Oa8Bstrl0tLK8SmABYJjz7LLXqFHyroVDFbUWOTZC4EP4xUDseRRYMHByIAwDppgfVmmT
	 5LqVelTdOePv67i6qgj1Ctzu7ePMKDe4OpmKM65xV9/7jcCdCot+s4VqIo63+mE+lqOAv
	 /3ZJdb8LAQUHaPXddojjVpdGGZNxpn29ITTqYHG8epN2YSjeBep+YpSr/9fxPxXUEOQqD
	 59LXotQAJxerfQaSOLToOU7NQyTswLdjP34eZgPMFnwoxNHDh4YdN2vyVv1qzpHkLjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437684;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mhvjTmuuVsjUkxpEAPNOTcDxmrBni2pTIT0QskenBEc=;
	b=MuAj+XwrBmSAVmaiTfvvmamYNg7z1svP7w2PQMXuO4zJIi8OjMHQJmxUMX8TIqtIvxWI
	 hlboLX7NGGTXDihmD/4590ApzzfDFgP+Z5fkNnGYoNr/HUzYchjNtcaEACqkN4MwkZ6zt
	 trmLLu1Nq7afJYX1yjgDEj7t4LltZFZTCVPcVD8t5DP1gPAf0SrK+4akJD/r1y5nSy7wp
	 lk0dGhVAUF0ngeQx0J3dQGIW5ajdUdP04Lj5sRhYxQbBZ0k/Bs+QvfT9w2+GF8Rk5shYU
	 an/UyWiWGfY3BSRrkYOiZItSLiRyrGJw14LjsJYi+77EihVoLdldF+cOdmm9KD+c8KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moZGZQn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A7606A321;
	Wed, 11 Nov 2026 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moZGZQn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CE41F00A07;
	Wed, 11 Nov 2026 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437684;
	bh=mhvjTmuuVsjUkxpEAPNOTcDxmrBni2pTIT0QskenBEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=moZGZQn3tacM1W9OrsISfnfN/V4zXrXTRKj7PugF3DN57hZRsv8rpyP0x56g/u6EW
	 QlLzOa1mnAN21+nIsjzPTgmsa1kUh633Xv+1uT58HjbjL1yX5F4htKpxZ1Xd+GYEYs
	 PC7DBJtsILNLM8dwzEEuacJdJvY710AvT/iYGj8o9wW4Og8qVItXQ867jsGLgEGvbi
	 2Lm8RBEJkrYuXL0xt8T7Pgtde46wxGRFgCyAft/JruROIeL5iZya0rD2uekvmWjbMG
	 VZhx8OJfYS47t3iFo422chTG/KxPKnHjZUJ2E9tJ9ylOZp9dZm6COxbTFrJSVuuL1F
	 b8o4kHPfT/2HQ==
Subject:
 Re: [PATCH net v2] net/sched: sch_qfq: revalidate aggregate after peek
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 11 Nov 2026 22:54:43 +0000
Message-ID: <179443768349.2199510.12975726279458330465@kernel.org>
In-Reply-To: <20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully fix the use-after-free it targets.
- [Low] qfq_dequeue() puts a `restart:;` label (a label on a null
  statement) before its local declarations with initialisers (`struct…

--

net/sched: sch_qfq: revalidate aggregate after peek

This patch makes qfq_dequeue() restart when a child peek re-enters
qfq_enqueue() and changes the in-service aggregate or the class's
aggregate. It moves the DRR requeue logic out of agg_dequeue() and into
qfq_dequeue(), after the service charge, using cl->agg. It also rechecks
class activity after the peek in qfq_enqueue().

> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index e900890e9c544..82903f9e58504 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c

[ ... ]

> @@ -1103,6 +1095,7 @@ static void qfq_schedule_agg(struct qfq_sched *q, struct qfq_aggregate *agg);
>  static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  {
>  	struct qfq_sched *q = qdisc_priv(sch);
> +restart:;
>  	struct qfq_aggregate *in_serv_agg = q->in_serv_agg;
>  	struct qfq_class *cl;
>  	struct sk_buff *skb = NULL;

[Severity: Low]
This isn't a bug, but the restart label sits in front of the local
declarations, so the backward gotos run their initializers again:

restart:;
	struct qfq_aggregate *in_serv_agg = q->in_serv_agg;
	...
	struct sk_buff *skb = NULL;
	...
	unsigned int len = 0;

This relies on declarations following a statement. Mainline no longer
passes -Wdeclaration-after-statement. This patch has Cc: stable and a
Fixes: tag going back to 2012, though.

Would older stable trees that still use that flag (5.10, 5.15 or 6.1, for
example) warn here, or fail to build with CONFIG_WERROR?

Would a loop around the selection step, or assigning these variables
after the label, be a simpler way to write the retry?

[ ... ]

> @@ -1151,13 +1147,15 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 */
>  		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
> +		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
> +			goto restart;
>  	}
>  	if (!skb)
>  		return NULL;
>  
>  	qdisc_qlen_dec(sch);
>  
> -	skb = agg_dequeue(in_serv_agg, cl, len);
> +	skb = agg_dequeue(cl, len);

[Severity: High]
Can the child dequeue here still re-enter qfq_enqueue() and free
in_serv_agg?

The new restart checks only come after the two qfq_peek_skb() calls.
agg_dequeue() calls qdisc_dequeue_peeked(cl->qdisc). That helper only
takes the skb from gso_skb if the child's ->peek() cached one there.
Otherwise it calls the child's ->dequeue() again.

sch_prio is one such child. prio_peek() caches nothing at the prio level,
and prio_dequeue() calls qdisc_dequeue_peeked() on each band, starting
from band 0.

Here is an example setup. The QFQ class child is prio. Band 0 is a netem
A0 with a delay, whose child is a netem B with duplicate. Band 1 is a
pfifo.

At peek time, A0's head is not due yet. The peek returns band 1's skb
without re-entering QFQ, so both restart checks pass. Suppose A0's head
becomes due before agg_dequeue() runs, and lmax was lowered while packets
were queued:

qfq_dequeue()
  agg_dequeue(cl, len)
    qdisc_dequeue_peeked(prio)
      prio_dequeue()
        qdisc_dequeue_peeked(A0)
          netem_dequeue(A0)
            qdisc_enqueue(skb, B)
              netem_enqueue(B)
                rootq->enqueue(skb2, rootq, to_free)
                  qfq_enqueue()
                    qfq_change_agg(cl)
                      qfq_deactivate_class()
                        qfq_deactivate_agg()
                      qfq_rm_from_agg()
                        qfq_destroy_agg()
                          kfree(agg)

qfq_deactivate_agg() and qfq_destroy_agg() update q->in_serv_agg. They
cannot update the local copy in qfq_dequeue(), and that copy is then
used after agg_dequeue() returns:

	if (unlikely(in_serv_agg->budget < len))
		in_serv_agg->budget = 0;
	else
		in_serv_agg->budget -= len;

The pr_debug() that follows also reads in_serv_agg->F.

Is this a write to the freed aggregate? And if the aggregate is not
freed, does the service still get charged to an aggregate that is no
longer in service?

Could q->in_serv_agg and cl->agg be revalidated after agg_dequeue() too?
Alternatively, the code could be restructured so that no aggregate
pointer is used after any child dequeue or peek.

>  
>  	if (!skb) {
>  		qdisc_qlen_inc(sch);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110222946.2147440-2-Jeremy.Jean%40oss.cyber.gouv.fr
