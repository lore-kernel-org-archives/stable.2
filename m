Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F084379EF7;
	Sat,  5 Sep 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570608; cv=none; b=M86kSG0JR3fwRUJnrKskqp/D3VZYMfqfhNdrLDByBfrZUhWPQ04TOtBJjN6Njs8xIlP9dsx95DhpoW4mHEHJX3vzwjcP74ZqmYxtZ+MSDUszb7ucCHtQhQWyG2AQMhJDS2HMQjdrDnrioknrCLBNl2wd9YmAKuFxjFXRZmF2GVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570608; c=relaxed/simple;
	bh=tlA9aB7k9IKC+tBq4GlEBjLQ3+WiRiJGsv8ty6hpn2E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+ja97vonDt3/M+JVjggPTKm5YQC7R++V+ocSVkrnUQNPotUMhyOoBAsdsPaOUosXOGsob6JyWzlpboNe/ymVZvsxGEyJ9HDHfhgQa2CJawSZfsI7J2QvcBQsOilF+Umfu4y+liXqffkRU57CyW9JfcYUytLvFlRzIwDxjM01tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5TeeKLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5TeeKLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629471F00A3E;
	Sat,  5 Sep 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570607;
	bh=1mzfnW4bfFcWOSv5dLw7FI1RvskCKOTX4VeWZGHwY8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z5TeeKLcX2qz0LbnhG9fk/i0wdfk9JHVSKi4xErEP+cR3O1phwtKZ22xaVcsEoy1s
	 CYxy+F2ovYN7ElYrP6+vWtMY7iez1C2colyqczvdYCc7tyivOvrM+8S4l9v00Q5W5P
	 KdytBPRnIqJAm1giWGCEWcb1zB9G3Msi6fWQimw9+3ypwFKqeGV7OQNmjExJnzl409
	 aqrYJ9a3toZJBUInBIRQ/ah2G2PkSR/VYSfM5DhHthwsETP+f+sg+T//k7kZgo4fc8
	 cj99Kvda6KM1HH3FxY5XxHq1E6UpLD3+Oq58C9zpheXKW3tKZ0RHUwq61IF62pnt5m
	 MsfkU5QjQmB1A==
Subject: Re: [PATCH net v2 2/3] net: reject oversized tx_queue_len at netlink
 parse time
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, xiyou.wangcong@gmail.com,
 shuah@kernel.org, vega@nebusec.ai, victor@mojatatu.com
Date: Sat, 05 Sep 2026 01:10:05 +0000
Message-ID: <178857060595.219967.9305578627338926756@kernel.org>
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com.2>
References: <QDISC-2899.v2.20260901233641@mojatatu.com.2>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The changelog of "net: reject oversized tx_queue_len at
  netlink parse time" misstates which paths and which sinks were…

--

net: reject oversized tx_queue_len at netlink parse time

This moves the tx_queue_len bound into ifla_policy so IFLA_TXQLEN is
validated against a netlink_range_validation of 0..S16_MAX at parse time,
covering the rtnl_create_link() path that assigns dev->tx_queue_len
directly. The rt-link.yaml spec gets a matching max check.

No Link: tags in the commit header.

One question about the changelog, quoting the parts in question:

> rtnl_create_link() assigns IFLA_TXQLEN directly to dev->tx_queue_len
> without going through netif_change_tx_queue_len(), so a device created
> with "ip link add ... txqueuelen 500000" bypasses the S16_MAX cap and
> still triggers the oversized ring allocations in pfifo_fast, tun and
> tap. The veth peer nest (rtnl_nla_parse_ifinfomsg()) and the
> RTM_NEWLINK-on-existing-device path reach the same sinks.

[Severity: Medium]

Is the tun sink actually reachable through the rtnl_create_link() bypass
described here?  drivers/net/tun.c refuses every rtnetlink creation
attempt:

drivers/net/tun.c:tun_validate() {
	NL_SET_ERR_MSG(extack,
		       "tun/tap creation via rtnetlink is not supported.");
	return -EOPNOTSUPP;
}

so rtnl_create_link() never runs for a tun device, and the remaining
writers of an existing tun's tx_queue_len (do_setlink(), sysfs,
SIOCSIFTXQLEN) all funnel through netif_change_tx_queue_len(), which
already returns before touching state:

net/core/dev.c:netif_change_tx_queue_len() {
	if (new_len > S16_MAX)
		return -ERANGE;

	if (new_len != orig_len) {
		WRITE_ONCE(dev->tx_queue_len, new_len);
	...
}

The tap half of the claim does hold, since macvtap/ipvtap are created via
rtnetlink and rtnl_create_link() can overwrite the TUN_READQ_SIZE default
that tap_open() later uses to size the ptr_ring.  Should the tun mention
be dropped?

Similarly, does the RTM_NEWLINK-on-existing-device path reach the same
sinks?  __rtnl_newlink() dispatches an existing device away from
rtnl_create_link():

net/core/rtnetlink.c:__rtnl_newlink() {
	if (dev)
		return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, data, extack);
	...
}

and rtnl_changelink() -> do_setlink() handles the attribute as:

net/core/rtnetlink.c:do_setlink() {
	if (tb[IFLA_TXQLEN]) {
		unsigned int value = nla_get_u32(tb[IFLA_TXQLEN]);

		err = netif_change_tx_queue_len(dev, value);
	...
}

which is the already-capped helper above.  That leaves the raw assignment
in rtnl_create_link():

net/core/rtnetlink.c:rtnl_create_link() {
	if (tb[IFLA_TXQLEN])
		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
	...
}

as the only genuine bypass, reached from rtnl_newlink_create() and the
veth/vxcan/netkit peer nests.  Could the changelog be narrowed to that?

> at parse time and rejects the attribute with -ERANGE plus a proper
> "integer out of range" extack message before any device state is
> modified (the RTM_SETLINK half-application wart is gone with it).

Is the parenthetical too broad?  do_setlink() still applies attributes
one at a time and can leave earlier attributes committed when a later one
fails, so this only removes the half-application for an out-of-range
IFLA_TXQLEN rather than making RTM_SETLINK atomic.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 81c5a6104dea..be9d1625bac3 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2287,6 +2287,11 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	return -EMSGSIZE;
>  }
>  
> +static const struct netlink_range_validation txqlen_range = {
> +	.min = 0,
> +	.max = S16_MAX,
> +};
> +

[ ... ]

> -	[IFLA_TXQLEN]		= { .type = NLA_U32 },
> +	[IFLA_TXQLEN]		= NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range),

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-2899.v2.20260901233641%40mojatatu.com
