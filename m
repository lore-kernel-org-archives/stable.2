Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C8355049;
	Tue, 22 Sep 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085822; cv=none; b=ORjc4NG6un6Q1ChBO/yq341y3l/aMmb+7JpCrgroQi2YHmdodkruGAHVpuKV2ZPaJI13EYmfPPeitJSYUM/Z4t485tZbB6D4SAKun6hi7grvg5ootABwSoL89ICFZCjacmxhNd7JR75BQi94MgpM0QcAsW0Y/TpGBsDOcMmDMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085822; c=relaxed/simple;
	bh=VteDioE9EKgPhL1HmKnMvQIBLW6tFZwEmG5fda6ugTg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNqlRYU+9kGS0Q2JE4BPVwsFOcyeEZyXZmFWGI5Yums8zeMlK3ogcsqNSjOnta0Cf6MSqK+lsXvcVbTBVx+ffLn9Sp1dTQ/KdH+SkbtkCtV+iT87n8vCjViTqS3po5nMXOgh6BfK72i+h8EQex0W3ZtzceT2oCZ28hDYiuzhRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giVhRNNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giVhRNNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA981F00893;
	Tue, 22 Sep 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790085820;
	bh=PZmFwgh0hVDeZa3TgR4QqJqkWaKALIRY2ecMMmXWkGY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=giVhRNNhgVntMadv7JcylznJvXWAIZcvEsiHudgRRECnIsY6oDWfbjFcgxHz3y0S6
	 ceeo1cHAvQZxyTRBrqrwSIKA5FeQIPqW9vEDCGkvf8HMrcyNTFcQSFfUu663ofvSsd
	 v7iQ+TxjrtEvfFD6IgP5lCpKJW6ZcgOrg8qrRIACbyJyT0EWyGxBPAkg3peJSqkfcb
	 a1FzTAhv1JrgtBhKondeSZweI8xQtJ7lzJf7aDM9QUoZl+lJoZPjIz/FdIkEbhS9Yt
	 9ihnF/fadBhQcUAdIWCS5/JyCSM/jzZTE8UTQyH7Wy8tlljCjt+iffiLg0KpduHJoq
	 4T7UwMl51kRrg==
Subject:
 Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 vinicius.gomes@intel.com, horms@kernel.org, victor@mojatatu.com,
 xiangxia.m.yue@gmail.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai,
 stable@vger.kernel.org
Date: Tue, 22 Sep 2026 14:03:39 +0000
Message-ID: <179008581937.2160803.7117814290574262942@kernel.org>
In-Reply-To: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message's justification and reproducer cannot reach
  the code the patch changes, so the patch's stated bug (and its…

--

net: cap skb->queue_mapping when the tx queue is picked

This stores the value returned by netdev_cap_txqueue() back into
skb->queue_mapping in netdev_tx_queue_mapping(), so that later readers of
skb_get_queue_mapping() on the xmit path see an in-range index. The
changelog attributes the out-of-range mapping to an skbedit + mirred
egress redirect from a device with more TX queues to one with fewer.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index c67900354fa64..736b3664b6354 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
>  static struct netdev_queue *
>  netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
>  {
> -	int qm = skb_get_queue_mapping(skb);
> +	int queue = skb_get_queue_mapping(skb);
> +	int capped;
>  
> -	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> +	capped = netdev_cap_txqueue(dev, queue);
> +	if (unlikely(capped != queue))
> +		skb_set_queue_mapping(skb, capped);
> +
> +	return netdev_get_tx_queue(dev, capped);
>  }

[Severity: High]
Can the reproducer in the changelog actually reach this function?

netdev_tx_queue_mapping() has a single caller, and it is gated on the
per-CPU (or per-task, on PREEMPT_RT) skip_txqueue flag:

net/core/dev.c:__dev_queue_xmit() {
	...
	if (static_branch_unlikely(&egress_needed_key)) {
		...
		netdev_xmit_skip_txqueue(false);

		nf_skip_egress(skb, true);
		skb = sch_handle_egress(skb, &rc, dev);
		if (!skb)
			goto out;
		nf_skip_egress(skb, false);

		if (netdev_xmit_txqueue_skipped())
			txq = netdev_tx_queue_mapping(dev, skb);
	}
	...
}

The clear at netdev_xmit_skip_txqueue(false) runs unconditionally at the
top of that block, in every egress-enabled frame.

The described redirect enters the target device through a nested
__dev_queue_xmit():

tcf_mirred_forward()
  tcf_dev_queue_xmit(skb, dev_queue_xmit)
    dev_queue_xmit()
      __dev_queue_xmit()   /* for qb */

Since clsact on qa has already raised egress_needed_key, that nested
frame for qb takes the same block and clears the flag that skbedit set
while running on qa. netdev_xmit_txqueue_skipped() is then false, txq
stays NULL, and qb's queue comes from netdev_core_pick_tx(), which caps
and rewrites the mapping itself:

net/core/dev.c:netdev_core_pick_tx() {
	...
		queue_index = netdev_cap_txqueue(dev, queue_index);
	}

	skb_set_queue_mapping(skb, queue_index);
	return netdev_get_tx_queue(dev, queue_index);
}

So by the time taprio_enqueue() runs:

net/sched/sch_taprio.c:taprio_enqueue() {
	queue = skb_get_queue_mapping(skb);

	child = q->qdiscs[queue];

the index it reads looks already in range for qb, on the patched and the
unpatched kernel alike. Does the quoted "BUG: KASAN: slab-out-of-bounds
in taprio_enqueue", the read 0 bytes past the 16-byte taprio_init
allocation, really come from this skbedit + mirred sequence?

A second point on the rationale:

    So the decision is to cap the value where it is first trusted and
    result is it fixes all downstream readers at once.

Is this site where the value is first trusted? The only in-tree setter of
the flag validates against the same device before arming it, and stores an
already capped value:

net/sched/act_skbedit.c:tcf_skbedit_act() {
	...
	if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
	    skb->dev->real_num_tx_queues > params->queue_mapping) {
#ifdef CONFIG_NET_EGRESS
		netdev_xmit_skip_txqueue(true);
#endif
		skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb));
	}

and tcf_skbedit_hash() ends with:

	return netdev_cap_txqueue(skb->dev, queue_mapping);

With that, capped != queue in the new code seems to require either
real_num_tx_queues shrinking concurrently (the index still being below
dev->num_tx_queues, so still inside dev->_tx[] and taprio's q->qdiscs[]),
or something rewriting skb->queue_mapping later in the same egress run.

A path that does look able to deliver a genuinely out-of-range value to
the new statement is a tc BPF program writing skb->queue_mapping after
skbedit armed the flag on the same device, since
tc_cls_act_is_valid_access() permits BPF_WRITE of that field and
bpf_convert_ctx_access() emits the store. Would describing that (or a
similar in-frame rewrite) instead of the cross-device mirred path make the
Fixes: tag and the reported scenario verifiable for reviewers and stable
backporters?

Also, this isn't a bug, but the changelog says:

    Another approach was to cap it in skbedit;  cannot work: the
    redirect target, whose queue count bounds the mapping, is not known
    when the action runs, and act_mirred sets skb->dev afterwards.

there is a double space after the semicolon.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v1.20260921065103%40mojatatu.com
