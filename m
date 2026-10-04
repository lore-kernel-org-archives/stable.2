Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED64503F6;
	Sun,  4 Oct 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118934; cv=none; b=q3a0tHB2UAMiHr3jqZvADe7dtdK+8YnoeFkn8EdBFl+oRwaRokke1sZXhbK3rz2uPB7Uz8vy/YdfxbZc8IRq1zIn8w03leZQBRzzZlZptZT1x9glBZ1z8k+LsycDFlArfuB/B655u6aA7GTqgnexX72mnsZ4wXFNQqgEmyDEvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118934; c=relaxed/simple;
	bh=btNln5m2QEKjVNAwyi8XeGvbM/leh9m3NyinsKwXeqE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYbj5CGECmQHWGTNxdkTkXpvCGC8gesUeAgFuribUjbX7EPz1eNz1v15KcDHPYAW+8455cl/JwUARwwp9N058UQXzNE0vnAOqAgU/SPXqrClW3l7GypkCFg3sjwpmx/pDUwJg2rK64dQngJOEwH+5J/77Ha05muIrE3WB4sUTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en7aTxkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en7aTxkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408CC1F00898;
	Sun,  4 Oct 2026 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791118932;
	bh=AaqKLiYRA3FKISSa+vqa0sNVCx3GBo+mJCVZAXJex/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=en7aTxkzEttMFZjRC9DIbKmnJSgxdk1++Q4OW2KLlD7BKKgnuxUuT+i6uq2uagqbL
	 AaQzS5wqPORjU8gYdfIek2AQs8Z1AzuBxqtMp0kHXw0T+dTlmig8xG6vjwfFo1n/f4
	 CDcPZjcmevoAQIFnCFzWc2nAz0JN4bTrB2es75R7lsVi7Qbl2fRLejgEIVxkDZzYQb
	 bwTKZZFvSRehOnRekgWX8tojxMQ0T4BQA5AVkUREzusHP0QWkS4ImesayliQH3F7S2
	 No84LimK/mKcsDBF6jM3TalyNVkVIb4pfY+uW5yXhPJSWTvviSzNisOq6KW+6/ScMS
	 Ik+vE2yuhqBqw==
Subject: Re: [PATCH net] net/sched: act_gate: reject oversized dumps instead
 of wrapping them
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, sashiko-bot@kernel.org, hybris@mojatatu.ai,
 stable@vger.kernel.org
Date: Sun, 04 Oct 2026 13:02:11 +0000
Message-ID: <179111893181.434549.13449660670267048994@kernel.org>
In-Reply-To: <QDISC-H19Z.v1.20261001053234@mojatatu.com>
References: <QDISC-H19Z.v1.20261001053234@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new nla_nest_end_safe() failures turn the filter
  notification path into a retry loop that cannot succeed.
- [Medium] The patch is incomplete on the classifier path, which is the
  only path where its inner-nest checks change behaviour.
- [Medium] For gates of about 1815 entries or more, the patch brings back
  the action lifecycle problem that cfa165cbfbed was meant to fix.
- [Low] The commit message and Fixes tag understate what the patch
  changes.

--

net/sched: act_gate: reject oversized dumps instead of wrapping them

This patch closes four nests that can wrap with nla_nest_end_safe():
TCA_GATE_ENTRY_LIST, TCA_ACT_OPTIONS, the per-action nest and
TCA_ACT_TAB. It follows up on cfa165cbfbed, which sized the gate reply
from the real dump without bounding the entry count. When a dump would
wrap, it now fails through the existing trim/error labels instead of
emitting a corrupt nla_len.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e45a63be397ce..c7e87491a9fce 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -1270,7 +1271,8 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
>  			tcf_action_dump_1(skb, a, bind, ref);
>  		if (err < 0)
>  			goto errout;
> -		nla_nest_end(skb, nest);
> +		if (nla_nest_end_safe(skb, nest) < 0)
> +			goto nla_put_failure;

[Severity: High]
Can this check make the filter notification path retry forever without
ever succeeding?

Suppose a gate's per-action nest (about 1815 entries) or its
TCA_GATE_ENTRY_LIST (about 1821 entries) is larger than U16_MAX. Then
tcf_action_dump() here, or tcf_gate_dump(), fails no matter how big the
skb is. On the classifier path that failure is reported as -EMSGSIZE:

fl_dump() / mall_dump()
  tcf_exts_dump()
    tcf_action_dump()
      nla_nest_end_safe() fails

net/sched/cls_api.c:tcf_fill_node() {
	...
	int ret = -EMSGSIZE;
	...
}

tfilter_notify_prep() then treats that as a buffer that is too small:

net/sched/cls_api.c:tfilter_notify_prep() {
	...
	if (ret <= 0) {
		kfree_skb(skb);
		if (ret == -EMSGSIZE) {
			size += NLMSG_GOODSIZE;
			goto retry;
		}
		return ERR_PTR(-EINVAL);
	}
	...
}

The number of retries has no limit. The loop only ends when alloc_skb()
fails quietly (__GFP_NOWARN) above MAX_PAGE_ORDER, and then it returns
-ENOBUFS. On 4K pages that is around 4MB, or roughly 1100 iterations.
Each one makes a larger GFP_KERNEL high-order allocation and serializes
every gate entry again. With 64K pages the loop runs much longer.

Before this patch the same loop stopped after about 18 iterations, once
the roughly 66KB dump fit.

RTM_GETTFILTER needs no capability. Once such a filter exists, any
process in the netns can trigger this, repeatedly and from many threads.

tfilter_del_notify() also builds the notification before it deletes:

	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
				  RTM_DELTFILTER, portid, rtnl_held, extack);
	if (IS_ERR(skb)) {
		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
		return PTR_ERR(skb);
	}

	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);

RTNLGRP_TC accepts listeners without privileges. One such listener would
now make RTM_DELTFILTER for this kind of filter fail after the long
loop, where it used to succeed. RTM_NEWTFILTER notifications would also
be lost.

Doesn't this contradict "no configuration that works today changes
behavior" in the commit message?

One option is to report nest overflow with an errno other than -EMSGSIZE
and pass it up through tcf_exts_dump() and tcf_fill_node(). Another is
to cap the retries in tfilter_notify_prep(). Would either of those work
here?

[Severity: Medium]
Can the classifier path still emit wrapped nest lengths?

This checks each action's nest on its own. The enclosing nests on the
filter path are still closed with plain nla_nest_end():

net/sched/cls_api.c:tcf_exts_dump() {
	...
			if (tcf_action_dump(skb, exts->actions, 0, 0, false)
			    < 0)
				goto nla_put_failure;
			nla_nest_end(skb, nest);
	...
}

fl_dump() and mall_dump() close TCA_OPTIONS the same way.

Take a flower or matchall filter with two gates of about 1000 entries
each. Each per-action nest is about 36KB and passes the new check, but
the exts->action nest adds up to about 73KB.

A single gate of about 1805-1814 entries is well formed on
RTM_GETACTION. On a flower filter, though, the extra key attributes can
push TCA_FLOWER_ACT/TCA_OPTIONS past U16_MAX.

tfilter_notify_prep() keeps growing the skb until the fill succeeds. So
RTM_GETTFILTER would still return a gate dump inside a nest with a
wrapped nla_len.

The wrap itself is older than this patch; it comes from the retry loop
added in 369609fc6272c2. Still, the new inner checks only change
behavior on this classifier path. tca_get_fill() already checks
TCA_ACT_TAB, and tcf_dump_walker() uses skbs of about 32KB.

Should tcf_exts_dump(), fl_dump() and mall_dump() also use
nla_nest_end_safe(), so that "reject oversized dumps instead of wrapping
them" also holds for filter dumps?

>  	}
>  
>  	return 0;
> @@ -1684,7 +1686,8 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
>  	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
>  		goto out_nlmsg_trim;
>  
> -	nla_nest_end(skb, nest);
> +	if (nla_nest_end_safe(skb, nest) < 0)
> +		goto out_nlmsg_trim;

[Severity: Medium]
For gates of about 1815 entries or more, does this bring back the
add/delete lifecycle problem that cfa165cbfbed was meant to fix?

In tcf_action_add(), tcf_action_init() has already committed the gate
to the IDR before the notification is built:

	ret = tcf_add_notify(net, n, actions, portid, attr_size, extack);

	/* only put bound actions */
	tca_put_bound_many(actions, init_res);

Consider the case where there is an RTNLGRP_TC listener (tc monitor, for
example) or NLM_F_ECHO is set. tcf_add_notify_msg()->tca_get_fill() now
fails here, so user space gets -EINVAL but the gate stays installed.

The message of cfa165cbfbed describes this exact case: "RTM_NEWACTION
then fails the add-notify with -EINVAL while the action is already
committed to the IDR".

The delete side also builds the message before it deletes:

net/sched/act_api.c:tcf_del_notify() {
	...
		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
					 extack);
		if (IS_ERR(skb))
			return PTR_ERR(skb);
	}

	/* now do the delete */
	ret = tcf_action_delete(net, actions);
	...
}

With a listener present, RTM_DELACTION by index can no longer remove the
gate. Only a flush (NLM_F_ROOT) or netns teardown frees it. RTNLGRP_TC
accepts members without privileges, so an unprivileged listener is
enough to cause this.

In the parent tree both operations succeeded, though they sent a wrapped
notification. Is the statement "no configuration that works today
changes behavior" accurate for this case?

The init-time entry cap that would avoid this has been deferred to
net-next.

[Severity: Low]
This isn't a bug, but the commit message and Fixes tag look narrower
than what this hunk changes. The commit message says:

  this patch closes only the malformed uAPI the sizing fix introduced.

The TCA_ACT_TAB check in tca_get_fill() is core act_api code, so it
applies to every action type. That wrap could already happen without
cfa165cbfbed. Since 8e2efb3f45a5c6 ("net/sched: add get_fill_size
callbacks for actions missing them"), tcf_bpf_get_fill_size() budgets
this:

		size += nla_total_size(prog->bpf_num_ops *
				       sizeof(struct sock_filter));

For a classic BPF action with 4096 instructions that is up to 32KB.

tca_action_gd() adds up the fill sizes of up to TCA_ACT_MAX_PRIO
actions. tcf_get_notify() and tcf_del_notify_msg() then allocate
max(attr_size, NLMSG_GOODSIZE).

So an RTM_GETACTION or RTM_DELACTION that names two large classic BPF
actions by index already overflowed TCA_ACT_TAB. This patch now turns
those replies into -EINVAL.

The filter-path wrap of the gate's inner nests also goes back to
369609fc6272c2, not cfa165cbfbed.

Could the commit message mention the effect on other action types, and
could the Fixes tags point at the commits that introduced these wraps?
8e2efb3f45a5c6 and cfa165cbfbed both carry Fixes: 4e76e75d6aba and will
probably be backported together, so the practical impact is small.

>  
>  	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v1.20261001053234%40mojatatu.com
