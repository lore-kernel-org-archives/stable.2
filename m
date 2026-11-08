Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168481;
	b=S38WZhT1kGlounmcSPenzGyB5BD3kUNyh4p7bPwBz4I6cP5W3AFw2wM8rXejlUig49fQ
	 Yer02KRVBa4CaDe/UbRzDIQ66enian5dioXrU/hFnQjt2KMu19K/CHXxYuGq0Chvf9vyE
	 dSNu33Y7SUiYUAT7KFzm/39yl34FOYlduMAUYQRnnbSejLKQKIGQYIeHmpQNqd4KVzksz
	 9NmBc5Sax5pzAVBNFhPzhXwYdsXa8g5tlLpgqwbUqS9Ap8dXxvyYxWgjuHRDncGSArvXU
	 g0Oww9CQjjMtBdS2xK09atoBY3ONCj9UCcMf7W0nXcjmtTvLfJdlXjdP/Kha1RYX/YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168481;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ShjZWSXlkH+y2ozjDqdd1hUWXOLO8siRY81x9SqGvKI=;
	b=LWwPuXbWcgWeof1dWM+bRo5NWWQ5SyA9chGFrCG2pGaz4aHr0xg+BjXy/axONqcR4oCm
	 +95Nr6qLC0r2hlHuUhuR2Tla1+fCoyCKKfn4Priq24F9uDCYn9IoVAl77ppKYIxMPrgQZ
	 4X2+Bv5NNTjG0j3HpErtaVRc3vBMGeuS2uwrEuOzB36uitOLW3NN9NSrH6f+2d6YdKHch
	 Y7wNWFTmnQUARZX0NlJpf11cIJB3bZ/qLS8KZw4moSsB6/zpmWrDqTTzfkZn+NrvkQEMC
	 mMgV5UwuHo7g3y94WPW9sFPxJAJM1IlUazkXRUshky/3ucq4pKykOzIfSprqEcdNtoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbzvbtjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F5606A320;
	Sun,  8 Nov 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbzvbtjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5E1F0089F;
	Sun,  8 Nov 2026 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168480;
	bh=ShjZWSXlkH+y2ozjDqdd1hUWXOLO8siRY81x9SqGvKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WbzvbtjIzWQ7c02Bl5Fib9ZFDZ1XzfqzA6ircgqAtLzIDkRx6QcWk0L0RuI4rgXvk
	 OL5lxQa5NM66WuPGI0oxkxKVSmaLYQRXCteIyZuj7GEAfTGKyND6sz45AKlMuheSUW
	 4v5K/229Xrs4ZsyiXLfMGoc2Mb9UOUrTAPYKLaV1o+xH0iy+UUXfouHEcOv+Av4MLA
	 rVyN6xdHJBu69LD9G81PGh02S0d608F2expFmj3wfogR4DuWSQ9A4MhFgWWKlYzhBL
	 GPx4/JA9m48hoyROOCw8B9LVhTQGdRklUUKasS3GFAWV6ik/7xvhu4tV2Dq2ldSV4F
	 8ZEXZ8qNrK47Q==
Subject: Re: [PATCH] net/sched: sch_qfq: revalidate aggregate after peek
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 08 Nov 2026 20:07:59 +0000
Message-ID: <179416847962.994134.4238466491131411640@kernel.org>
In-Reply-To: <20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] The new `goto restart` in qfq_dequeue() can loop forever.
- [Low] The commit message omits the trigger mechanism and one
  behavioural change.

--

net/sched: sch_qfq: revalidate aggregate after peek

This patch makes qfq_dequeue() reload q->in_serv_agg after each
qfq_peek_skb() call. It restarts if q->in_serv_agg or cl->agg changed,
because a child peek can re-enter QFQ and free the in-service aggregate.
It also makes qfq_enqueue() recheck cl_is_active() and use cl->agg after
the child peek.

> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index e900890e9c544..517e9083b403e 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1103,17 +1103,24 @@ static void qfq_schedule_agg(struct qfq_sched *q, struct qfq_aggregate *agg);
>  static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  {

[ ... ]

> +restart:
> +	in_serv_agg = q->in_serv_agg;
> +	skb = NULL;
> +	len = 0;
>  	if (in_serv_agg == NULL)
>  		return NULL;
>  
> -	if (!list_empty(&in_serv_agg->active))
> +	if (!list_empty(&in_serv_agg->active)) {
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
> +		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
> +			goto restart;
> +	}

[Severity: High]
Can this goto restart spin forever when cl is linked on
in_serv_agg->active but cl->agg points to a different aggregate?

That state looks reachable through the child peek in agg_dequeue(), which
this patch leaves unguarded (see below). Take a netem child that feeds a
duplicating netem. The nested rootq->enqueue() lands in qfq_enqueue(). If
cl->agg->lmax < len, qfq_change_agg() moves cl from the in-service
aggregate A to aggregate C. A survives because it has other classes:

qfq_dequeue()
  agg_dequeue(A, cl, len)
    qdisc_peek_len(cl->qdisc)
      netem_dequeue() -> netem_enqueue(dup) -> rootq->enqueue()
        qfq_enqueue()
          qfq_change_agg()
            qfq_deactivate_class()   /* cl removed from A->active */
            qfq_add_to_agg()         /* cl->agg = C, cl on C->active */
    cl->deficit += agg->lmax;
    list_move_tail(&cl->alist, &agg->active);   /* agg is still A */

Now cl is on A->active with cl->agg == C. Once cl reaches the head of A,
qfq_peek_skb(A) returns cl and the cl->agg != in_serv_agg check is true.
The restart then reloads the same in_serv_agg and peeks the same head
class again.

For a qdisc_peek_dequeued() child, the peek just returns the cached
gso_skb, so nothing changes between iterations. Would qfq_dequeue() then
loop forever while holding the root qdisc lock?

C may also stay scheduled with an empty active list. A later
qfq_choose_next_agg() followed by qfq_peek_skb() could then call
list_first_entry() on an empty list.

> @@ -1151,6 +1158,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 */
>  		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
> +		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
> +			goto restart;
>  	}
>  	if (!skb)
>  		return NULL;

[Severity: High]
Is the fix complete? Right after this, qfq_dequeue() calls
agg_dequeue(in_serv_agg, cl, len). That does another child peek through
qdisc_peek_len() and then uses the cached aggregate without revalidating
it:

net/sched/sch_qfq.c:agg_dequeue() {
    ...
	else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
		cl->deficit += agg->lmax;
		list_move_tail(&cl->alist, &agg->active);
	}
    ...
}

qdisc_peek_len() calls sch->ops->peek(sch) directly. That is the same
re-entry point this patch guards after qfq_peek_skb().

Take a QFQ class whose child is netem N1, where N1's child is a
duplicating netem N2. The free looks reachable:

qfq_dequeue()
  agg_dequeue()
    qdisc_peek_len(N1)
      qdisc_peek_dequeued() -> netem_dequeue(N1)
        qdisc_enqueue(skb, N2) -> netem_enqueue(N2)
          rootq->enqueue(skb2, rootq, to_free)
            qfq_enqueue()
              qfq_change_agg()       /* cl->agg->lmax < len */
                qfq_rm_from_agg()
                  qfq_destroy_agg()  /* num_classes == 1, kfree(agg) */

The cl->agg->lmax < len condition can hold if lmax is lowered through
qfq_change_class() while packets are queued in netem.

After that, reading agg->lmax reads freed memory, and list_move_tail()
links cl into the freed agg->active. When agg_dequeue() returns,
qfq_dequeue() still updates the same aggregate without a check:

	if (unlikely(in_serv_agg->budget < len))
		in_serv_agg->budget = 0;
	else
		in_serv_agg->budget -= len;

This is the budget field from the KASAN report in the commit message.

The commit message says "After each child peek, restart qfq_dequeue() if
either q->in_serv_agg or cl->agg changed". Does the qdisc_peek_len() call
in agg_dequeue() need the same treatment?

A codel or fq_codel child that is emptied during the peek doesn't seem to
hit this. In that case qdisc_peek_len() returns 0, cl->deficit < 0u is
always false, and list_move_tail() is never reached. The netem path above
is enough to trigger it.

> @@ -1274,9 +1283,10 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	/* if the class is active, then done here */
>  	if (cl_is_active(cl)) {
>  		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
> -		    list_first_entry(&agg->active, struct qfq_class, alist)
> +		    cl_is_active(cl) &&
> +		    list_first_entry(&cl->agg->active, struct qfq_class, alist)
>  		    == cl && cl->deficit < len)
> -			list_move_tail(&cl->alist, &agg->active);
> +			list_move_tail(&cl->alist, &cl->agg->active);

[Severity: Low]
This isn't a bug, but could the commit message say more about the trigger
and about this behaviour change?

It only says "a child peek can re-enter QFQ and free it". It doesn't
describe the topology: a netem child whose qdisc_peek_dequeued() runs
netem_dequeue(), feeding a duplicating netem that calls rootq->enqueue().
It also doesn't give the free path (qfq_enqueue() -> qfq_change_agg() ->
qfq_rm_from_agg() -> qfq_destroy_agg()) or a reproducer.

The added cl_is_active(cl) recheck also skips the DRR requeue when the
nested path has deactivated the class. The commit message only says "Also
use cl->agg after the child peek in qfq_enqueue()".

Describing the mechanism would make it easier to check that every child
peek or dequeue site that can re-enter QFQ is covered. One example is the
qdisc_peek_len() call in agg_dequeue() mentioned above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106200236.716641-2-Jeremy.Jean%40oss.cyber.gouv.fr
