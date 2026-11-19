Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084720;
	b=OEWbDRqRIp+DMexgWJQvQ0tt/r3iJIgtNBGpjnseJcUyPNgJODjdNsXNcqOeeh9BGHv8
	 He8/4Y1XqqG4f1+DrERR+EoRl7NSOS+bZfsBMdQ2RZNpM7CUUnTz6eHyZ8Ad7f1fAVAJ7
	 6wj4WdOmgsTkGdyD1gwxyuyZ7+mDsutPv1EHxEmLhDCTldZ5Jg9Sauttr5wBX0IvQw4I/
	 v1rw4PXBBC5+66ECAvndzOKxviBBCwJs1KnRZYLquvuBk17i2eiqkY7Ic6oA2/EQjtxdB
	 h9wTA+St19LUf82x7RXinFWvXOOCF3i8tZh/d0MQpLjs+d13rgXHel434676eeHV49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084720;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Er7R+lRdSvopXynFBt+niPP1ZQkZ289VWaNWEImXUo8=;
	b=b7IpRHX6wWCjcid34Q0QyMUibwSnMN6aEa1eGX8xED3C0vJiVpuSuDLVjGsk3d0Jojwg
	 5SIKFaAONebzJM6TZD2fRELJj56K0AEne4pA28Ik1EMzCKa2EslhhjPC/FC2et8UOB/WX
	 Z1nlyhvtlsKgqHTVBwV5jVH154/r+fS0Oz++1FTOOUNs2S5CEPsgjNS4ogKUgVQcZX9Si
	 iJRvz4WXkba+y3Ij/hrHlxA4UWhgLituIi4f91/jewBXMwYM5nNjwY6wimUJv2SpRZSFs
	 +iHhXH3azC05AvhgBHwed3bBmmBgLs2hPcMgbKk0aImmoGsm+/AS7pXzv3CUjHZV1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTcNsa2x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0ED606A320;
	Thu, 19 Nov 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTcNsa2x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BEF1F000C5;
	Thu, 19 Nov 2026 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084720;
	bh=Er7R+lRdSvopXynFBt+niPP1ZQkZ289VWaNWEImXUo8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LTcNsa2xJeJdejCs0dQTmZ1f78J583KlW8GI/67N4fglwoQstvomBrqKX7CZNaOCa
	 rRlQY1zBnO2tRWffnD8kKQLuf3saef3AgX2R0jiua6mj6O53xCoVzVbZcqoxcTENql
	 zOIBkBfsP3kgdnEuCKKUxk5bghAU2nYsTttbZwdDkppFjKge74ixBv0n9p+M6N+6nR
	 a77i8BNHjFt6Py3Cs90FdD9CvrhC6CpJS9qSLaUbml98p2GnQILt1PwnRZRlGP4TMt
	 4qAGh2Klt2XsUe1CJRLNO3zAyp755Ju9e9F8pUQNuTubtGv8gblMn6rNYNJ9LnXcmI
	 fFwkX9D4aPiRg==
Subject: Re: [PATCH net v5 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 10:38:39 +0000
Message-ID: <179508471960.3136.3982985100644358215@kernel.org>
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927-2@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927-2@mojatatu.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New regression in neigh_update_process_arp_queue()
  (net/core/neighbour.c:1343-1345).
- [Low] The commit message describes sch_teql as parking the skb "naming
  the slave", with skb->dev differing from n1->dev.

Pre-existing issues:
- [Medium] neigh_update_process_arp_queue() re-homes skb->dev only when
  n1->dev has no header_ops.

--

net: neighbour: reinject a parked skb through a headerless output device

This patch changes neigh_update_process_arp_queue() so that skb->dev is
set to n1->dev before n1->output is called, when n1->dev has no
header_ops. With that, neigh_direct_output() transmits on the device the
neighbour belongs to, not on whatever device the producer left in
skb->dev. The motivating producer is sch_teql, which parks skbs on the
slave's neighbour.

Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> sch_teql is the producer that hits this: it parks the skb on the slave's
> neighbour while the top-level neighbour is the master's, so skb->dev and
> n1->dev differ and the reinjection has to come back through the master to
> leave with a header.

[Severity: Low]
Is this accurate for the tree this patch applies to?

At this commit, teql_master_xmit() sets skb->dev = slave only inside
case 0, right before netdev_start_xmit(). It then restores skb->dev = dev
at the end of each iteration. So the skb that __teql_resolve() parks via
neigh_event_send() still names the master, and n1->dev == skb->dev.

That makes the new assignment a no-op for teql at this commit, and the
"Conditions to recreate the bug" recipe does not reproduce on this commit
alone.

The last patch in the series, "net/sched: sch_teql: keep skb->dev
consistent on the arp-queue path", moves skb->dev = slave ahead of
teql_resolve(). Its message says this neighbour change has to be applied
first, so the ordering is fine.

This patch carries Fixes: and Cc: stable. Could the message name the
sch_teql patch it depends on, and say that the behaviour it describes
only exists once that patch is applied? The phrase "reached once sch_teql
parks the skb naming the slave" hints at this, but it is easy to miss.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..1b556fa17c57c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		/* headerless output transmits on skb->dev, not n1->dev */
> +		if (!n1->dev->header_ops)
> +			skb->dev = n1->dev;

[Severity: Medium]
Can this gate send nft fwd ... neigh and bpf_redirect_neigh() skbs back
through the original device's egress path?

nft_fwd_neigh_eval() in net/netfilter/nft_fwd_netdev.c is allowed on
NF_NETDEV_EGRESS. It decrements the TTL or hop_limit and then does:

    skb->dev = dev;
    skb_clear_tstamp(skb);

    nf_dev_xmit_recursion_inc();
    neigh_xmit(neigh_table, dev, addr, skb);

It does not drop the dst of the original route first.

bpf_out_neigh_v4() and bpf_out_neigh_v6() in net/core/filter.c do the
same when explicit nexthop parameters are passed. The dst is only
replaced in the !nh branch of __bpf_redirect_neigh_v4/v6().

If the neighbour of the target device B is unresolved, the skb is parked
on B's arp_queue with the dst of the original device A still attached.
When B resolves:

neigh_update_process_arp_queue()
    n2 = dst_neigh_lookup_skb(dst, skb);   /* A's neighbour */
    if (!n1->dev->header_ops)              /* A is ppp, p2p GRE, teql */
        skb->dev = n1->dev;                /* skb->dev goes from B to A */
    READ_ONCE(n1->output)(n1, skb);        /* neigh_direct_output() */
        dev_queue_xmit(skb);               /* A's qdisc, nf/tc egress */

The skb then goes through A's qdisc, netfilter egress and tc egress a
second time:

- nft fwd neigh decrements the TTL again, so packets that arrive with
  ttl == 2 are now dropped.

- Counters, limits and quotas are charged twice.

- Non-idempotent rules (mark-guarded, an exhausted limit or quota,
  numgen) can let the packet leave on A, the device the redirect was
  meant to steer around.

Before this patch these skbs left B without a link header, which was
also broken. Running A's egress hooks a second time is new, though.

The commit message acknowledges this:

    Those forwards supply their own device and nexthop and do not consult
    the retained dst, so dropping it at those two sites is where that is
    fixed; that is a separate change to the producers.

That change does not appear to be part of this series. The last patch,
"net/sched: sch_teql: keep skb->dev consistent on the arp-queue path",
only touches sch_teql.c.

Since this patch is tagged for stable, could the dst drop in
nft_fwd_neigh_eval() and bpf_out_neigh_v4/v6() go into the same series,
ordered ahead of this change?

>  		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
This isn't a bug introduced by this patch, but the same mismatch between
skb->dev and n1->dev remains when n1->dev does have header_ops.

neigh_resolve_output() and neigh_connected_output() build the header
from neigh->dev and then transmit on skb->dev:

    err = dev_hard_header(skb, dev, ntohs(skb->protocol),
                          neigh->ha, NULL, skb->len);
    ...
    rc = dev_queue_xmit(skb);

Take an nft fwd neigh redirect, or bpf_redirect_neigh() with nh, from
Ethernet A to Ethernet B. Would the frames queued while B resolves leave
B carrying A's source and next-hop MACs?

Re-homing skb->dev unconditionally here would be wrong for those
producers. This case would probably also be fixed by the producer-side
dst drop that the commit message defers.

>  		if (n2)
>  			neigh_release(n2);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v5.r0.20261116052927%40mojatatu.com
