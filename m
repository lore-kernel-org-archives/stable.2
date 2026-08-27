Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926802E8DE3
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828494; cv=none; b=V8UGSwtUzojZTUvXgbyAuFECEV4AadKPbX5hx9kUi3pumXSQlEu7sXCqHU8WPcsA15DaVBu4jmWgp+naJMtVRD72XtMExtR+OYzCnA7LSUkBo+9y+sebO9hqddSVOiMNE+Wp+J3VngGF9xJ8eKYYps013U8p+kZR6snL8fuJNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828494; c=relaxed/simple;
	bh=OYFg1Jou5x8E47a/FUTmdlvRqngXQBELcGZdIMaomGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmEmQNhpOSf036sJCvtz9eFmevcqsazlRvwFE13w5t1xQ2OefS+EjkSDgZonqczFK6TnHfcs8TwYrzn+d3Jc07fVCOiu6SKkIEf3xdftyfAvtAtSrsFb43z/Z5qrT9Cli6ZpxIwaTeuk6CVbpWi3VUmuCQHsV6iecQCeILGOg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdzNiryb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdzNiryb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787828491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgw61i5ygc+23hUMhfZfLn1I9aKNXr7tn4a/rdJfgHw=;
	b=PdzNirybTUDjieMBZq8OmUSd5DrjOAKpGBjvp2mw24q7gy32vm4bVoM54DsHBsTQXUCCm3
	6xRUSvO5RaVfpikdf/sWG6cJ3iIF9yPQ2dx1Yco6GaAlzwnV8TwUgs4T2y4MKSDllUbQsQ
	8HbGX6yBwTJ9QIm/NaUa1iVAxPRFIYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-1TonA37qO96TtBGRkIs2uw-1; Thu,
 27 Aug 2026 07:01:29 -0400
X-MC-Unique: 1TonA37qO96TtBGRkIs2uw-1
X-Mimecast-MFC-AGG-ID: 1TonA37qO96TtBGRkIs2uw_1787828488
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A7E3195605B;
	Thu, 27 Aug 2026 11:01:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.49])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B20231955F07;
	Thu, 27 Aug 2026 11:01:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	victor@mojatatu.com
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
Date: Thu, 27 Aug 2026 13:01:16 +0200
Message-ID: <20260827110116.180569-1-pabeni@redhat.com>
In-Reply-To: <20260825081403.133992-1-jhs@mojatatu.com>
References: <20260825081403.133992-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup

This adds QDISC_PKT_LEN_MAX (1 MiB) and clamps the value computed by
__qdisc_calculate_pkt_len() into the range [1, QDISC_PKT_LEN_MAX], with the
stated goal of preventing a crafted TCA_STAB size table from driving the DRR
and ETS deficit refill loops into a multi-billion iteration spin under the
qdisc lock.

A couple of questions about the fix and about the arithmetic it now
consumes.

> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 18a419cd9d949..90d3e7943b19a 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -12,6 +12,7 @@
>  
>  #define DEFAULT_TX_QUEUE_LEN	1000
>  #define STAB_SIZE_LOG_MAX	30
> +#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
>  
>  struct qdisc_walker {
>  	int	stop;
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65b35528d125f..90503e59e6e3b 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
>  
>  	pkt_len <<= stab->szopts.size_log;

[Severity: Medium]
This isn't a bug introduced by this patch, but the new clamp consumes the
result of arithmetic that is done entirely in a signed int on unvalidated
user input, so it may not bound what it is intended to bound.

In __qdisc_calculate_pkt_len():

	pkt_len = skb->len + stab->szopts.overhead;
	...
	pkt_len = stab->data[stab->szopts.tsize - 1] *
			(slot / stab->szopts.tsize) +
			stab->data[slot % stab->szopts.tsize];

	pkt_len <<= stab->szopts.size_log;

qdisc_get_stab() only validates tsize consistency and size_log/cell_log
against STAB_SIZE_LOG_MAX:

	if (s->size_log > STAB_SIZE_LOG_MAX ||
	    s->cell_log > STAB_SIZE_LOG_MAX) {
		NL_SET_ERR_MSG(extack, "Invalid logarithmic size of size table");
		return ERR_PTR(-EINVAL);
	}

The overhead field and the u16 data table are not range checked (the
changelog itself notes overhead 999999999 is accepted), and size_log may be
up to 30, so the shift overflows for any table entry >= 4.

Is the signed left shift here reportable under CONFIG_UBSAN_SHIFT, and can
that be reached by a namespace-local CAP_NET_ADMIN user?

With the usual wrapping behaviour, is the new clamp monotone in the
attacker-controlled inputs? For example data[slot] = 65535 with
size_log = 16 wraps to -65536, which clamp_t(int, ...) turns into 1, so
shaping qdiscs such as TBF, HTB and fq would account one byte for a packet
the table describes as huge.

Would doing this arithmetic in u64 (or unsigned with saturation) and
narrowing before the clamp make the new bound actually hold?

>  out:
> -	if (unlikely(pkt_len < 1))
> -		pkt_len = 1;
> +	/* A size table can inflate qdisc_pkt_len() beyond any real packet
> +	 * (via overhead, the data table, or size_log); cap it so deficit
> +	 * schedulers such as DRR/ETS terminate their refill loops.
> +	 */
> +	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
>  	qdisc_skb_cb(skb)->pkt_len = pkt_len;
>  }

[Severity: High]
Does this clamp actually bound the DRR/ETS refill loops, or only one of
their inputs?

drr_dequeue() round-robins the active class list, and each unsuccessful
visit advances only the head class by one quantum:

net/sched/sch_drr.c:drr_dequeue() {
	while (1) {
		cl = list_first_entry(&q->active, struct drr_class, alist);
		skb = cl->qdisc->ops->peek(cl->qdisc);
		...
		len = qdisc_pkt_len(skb);
		if (len <= cl->deficit) {
			...
			return skb;
		}

		WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
		list_move_tail(&cl->alist, &q->active);
	}
}

Since every active class advances at the same rate, isn't the iteration
count before the first packet becomes eligible roughly
nr_active_classes * (qdisc_pkt_len / quantum) rather than
qdisc_pkt_len / quantum?

The minimum accepted quantum is 1, since drr_change_class() only rejects
zero:

net/sched/sch_drr.c:drr_change_class() {
	quantum = nla_get_u32(tb[TCA_DRR_QUANTUM]);
	if (quantum == 0) {
		NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
		return -EINVAL;
	}
}

and drr_enqueue() re-arms the worst case on every reactivation:

net/sched/sch_drr.c:drr_enqueue() {
	if (!cl_is_active(cl)) {
		list_add_tail(&cl->alist, &q->active);
		WRITE_ONCE(cl->deficit, READ_ONCE(cl->quantum));
	}
}

So with quantum 1, the new 2^20 cap and roughly 1024 active classes (class
creation is not bounded, and drr_classify() maps skb->priority to a classid
so an unprivileged socket can steer packets per class), does a single
drr_dequeue() still run on the order of 10^9 iterations with the root qdisc
spinlock held and softirqs disabled?

The same shape appears in ets_qdisc_dequeue(), which is the other consumer
named in the new comment:

net/sched/sch_ets.c:ets_qdisc_dequeue() {
		cl->deficit += READ_ONCE(cl->quantum);
		list_move_tail(&cl->alist, &q->active);
}

with an added per-iteration scan of the q->nstrict strict bands.

Also, is this reachable with no TCA_STAB at all, for instance ~16k classes
with quantum 1 and ordinary 64 KiB packets? If so, the deficit-loop stall
does not appear to be gated on size-table amplification in the first place.

And can __qdisc_run() interrupt it?

net/sched/sch_generic.c:__qdisc_run() {
	while (qdisc_restart(q, &packets, quota)) {
		quota -= packets;
		if (quota <= 0) {
			...
			break;
		}
	}
}

The quota is only evaluated after qdisc_restart() returns, so it cannot
preempt the internal refill loop.

Would bounding the loop itself, either with an iteration limit or by
requiring a quantum that is sane relative to the maximum pkt_len, be
needed instead of clamping one of its inputs?
-- 
This is an AI-generated review.

