Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564419;
	b=LjQyLYXMmdNM/jqCDdwOXROIUpmRKjUGdZeshRqD3A8WpC4RgR12oZJnFcrW2MS/uOyg
	 fB1NR7Vxq6LiC5Oikf2I87kJ0/402ChrCqxh42W+75uXvqgRFoT1aYOVfD+zzJdVCbZ03
	 W7Jcw0OjAKP3UYqJ6oU8e3EfF6yXbBMT6YvL7+HNcpSgQOg2WFa/MVwsaUk2HYjfyyGsr
	 XJXDjn1hfUgQcoaIfaQdNUvxl7jadqxlx4rZhW0ZRQ0IrAV0Yyfy1bZB519LoTJDI/r+o
	 0vpbcQSq+WFf40BX8KDga08fa64CTs9/vd2cqmDY1OOwLdaBokFQMIdGuhjs1ItOkIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564419;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zyRN6kg9/ATn1G8Z14YW7umkFVQ53HKSrppdRtXaoZo=;
	b=0clZvreO4N3lvvc4eJ5fIeUJFQeuEvJQ78kjqf9i0efy6RL15WYPLFPalmkCPv4WBXRA
	 TxBbAZfsK/DiaBWTKWP8vqyBTVL3n/kqNjWV/21ZbOhUJeRL7LrgPJrtU97tjRFBQWJal
	 U/zvhbARqJk/M6xZN0CxMd0W88tjb/ZYkFQY+haGjBSRhUMqOqQIyg6SSggsfWs46QxN4
	 LdOWefgoS+5Ol1jPuWp+YSTkfLm9Id+2Hz8bB7GvkFM4qXNt9JzqvwIHs5uOpCOJQNUm4
	 HJXkmWt7EwzQX0c4fcjacrmNkYWzitFjvtq7QicGm2UcK8v8u+zTZ7IGUtZhrCqaRIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AL+vqfXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F219606A325;
	Sun,  1 Nov 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AL+vqfXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E6F1F000C1;
	Sun,  1 Nov 2026 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793564419;
	bh=zyRN6kg9/ATn1G8Z14YW7umkFVQ53HKSrppdRtXaoZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AL+vqfXx8V+n8mSHlPQBbqJ2wOEM7Y5XMBR5amUzuRNF7eu1Hfs7ssGVCTnImepgv
	 KsqJNpnBMfG7pbgtDwl/tEJd+CCvFRGR9l0koJI8oSbXGwdkDFHGehfr1tdv1u5Kfm
	 mxIubGTA4S53kQm5dx92AzD5Wc2y5ADCgUPFnkeOePCT75N9o+eSn97FBiY9eA3OTQ
	 vlvzh1us+2INW7Bh4KJWEwboaenJbUj/Rew0/6jWt9PMNtLdGvtDCYUPjCdnYbL9PA
	 MGiR3v4ShcuLf1pmT+Hb5wiIoA4dYi6CqjmsNhk+3nt4ouYHDLAa6qKGhBeuLg1Eh4
	 5xEKrKN0YhUxg==
Subject: Re: [PATCH net 3/3 repost2] net/sched: sch_teql: reject qdiscs from
 another network namespace
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Sun, 01 Nov 2026 20:20:17 +0000
Message-ID: <179356441771.3131.1618449912961461255@kernel.org>
In-Reply-To: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix checks that a teql slave and its master are in the
  same netns only once, in teql_qdisc_init() (net/sched/sch_teql.c:211).
- [Low] tc-testing case 124e ('Try to add teql as a child qdisc',
  tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json) no…

--

net/sched: sch_teql: reject qdiscs from another network namespace

This patch rejects a teql qdisc in teql_qdisc_init() if its device is in a
different network namespace from the teql master. It also moves
skb_queue_head_init() ahead of all validation, so every failure path sees
an initialized queue.

Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 70c948a26f809..c5f171a66060f 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -200,12 +200,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,

[ ... ]

>  	if (m->dev == dev)
>  		return -ELOOP;
>  
> +	if (dev_net(dev) != dev_net(m->dev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: Medium]
Is this same-netns rule only checked at attach time? The check compares
against the current netns of m->dev. But nothing seems to keep the teql
master in init_net, because teql_master_setup() never sets
dev->netns_immutable:

net/sched/sch_teql.c:teql_master_setup() {
    ...
	dev->flags		= IFF_NOARP;
	dev->hard_header_len	= LL_MAX_HEADER;
	netif_keep_dst(dev);
}

__dev_change_net_namespace() refuses a move only when netns_immutable is
set. So "ip link set teql0 netns X" would still succeed after slaves on
init_net devices have attached.

During the move, dev_shutdown() tears down only teql0's own qdiscs. The
slave qdiscs on the init_net devices stay linked in master->slaves.

After that, CAP_NET_ADMIN in netns X (possibly granted by an unprivileged
user namespace) can bring teql0 up. teql_master_xmit() would then send
that netns's packets through netdev_start_xmit() on the init_net slave
devices. __teql_resolve() would also create neighbour entries on those
init_net devices.

Moving teql0 needs CAP_NET_ADMIN in init_net, so the unprivileged
reproducer in the commit message can't reach this path.

The commit message says:

    The teql master devices are created once in the initial network
    namespace and their Qdisc_ops are global.

They can still be moved to another netns after creation, though. Bonding
handles the same case in bond_setup():

	/* Don't allow bond devices to change network namespaces. */
	bond_dev->netns_immutable = true;

Should teql_master_setup() also set dev->netns_immutable = true, so that
this attach-time check is enough?

>  	if (sch->parent != TC_H_ROOT) {
>  		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
>  		return -EOPNOTSUPP;

[Severity: Low]
Does the new check now hide the root-only check from tc-testing case 124e
("Try to add teql as a child qdisc") in
tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json?

That case requires nsPlugin, which moves $DUMMY into the test netns and
runs every command under "ip netns exec". The teql0 master is registered
in init_net.

For 124e, the hard_header_len check and the -ELOOP check both pass. The
new netns check then fires before the sch->parent != TC_H_ROOT check.
Both checks return -EOPNOTSUPP, so tc exits with 2 either way. The test
only checks expExitCode 2 and an empty child list.

As a result, 124e would keep passing even if the root-only rejection were
broken. No tdc case covers the new cross-netns rejection either, since the
other teql cases run without nsPlugin.

Would it make sense to put the netns check after the parent check, run
124e in init_net, or match the extack string? A separate test case for
the cross-netns rejection might also help.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050%40mojatatu.com
