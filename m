Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793535224;
	b=q2FFRzIHpeIFFXOplNM0im5bcAC9N0Fo7pdhZ6k1PERdm4rvi/TvhPtjRZpx+7jTl3sY
	 RQAFASmBsZU4fYP8rGcxQ9balEF47RTU8DmOAP4zRJ9ebU+WsY2QJrS+urQ7FkEA2e5Fl
	 EJ56sFVFuO4JFXO/Xmg4ENntazviGFvOjWs00hZ3ztacSVQSbgwakzFV/oc6epdAxUcbE
	 nVaf670KeA9i50bApFHCKnVveNv8Bt7XLiS89EGFV9/qYt5r158C2yyeeRxndzaWQJlpW
	 sZPSpJBamYOOY4qlCgM4JUhw/3oh9e4VW6E+R6dNjs0QmNALzMZOdVS488JAxmC0N1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793535224;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1LUjoU7LhfawNBSFJRVYyEuEFoOTE4Tdh1v5GSHCaYY=;
	b=gZSlJV682lxa+YTChbLGMRce/j1ilBh2u7jKqV/AtIS0gBW09QyHXAAvdaNrVhoC/pZN
	 tGUnpjZu9Y7GYmfRwqjNctB1AtHn9GQqXmhGt5CpMPzzYmZUYCcT4kzoF+mUtPELux9GJ
	 zT6ii4CWNRWqL9bF4Dl4zc7l0nEAbLQt5l4NY3sEOY3W0mu2e/CcYKhQAYkAYSvEOb4fp
	 SRaGrSs0dFivnYdjK8rfVFY9jJ6JUAUFxTvYbgbRk955TrKYLlJHSP+CcDJ2eIaCOBqFe
	 q45cfmF1pnoAp2UJec95uO2dAh7E/Gw1Pd6ha0wVO/wXtYRS4zUsvNZmx8CTQrpKiCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxWl5M0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB7606A324;
	Sun,  1 Nov 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxWl5M0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B89F1F000C1;
	Sun,  1 Nov 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793535223;
	bh=1LUjoU7LhfawNBSFJRVYyEuEFoOTE4Tdh1v5GSHCaYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VxWl5M0cpyPKi6+3dLZ4o12dVvl+ce4mmsw4KPtQlvygPFEHN4UNFgnqrLQtl0lMS
	 2Ba2vwa8TQr5BBFIFOMV0RGyzKiNqSx1nWvKW6wv0pIgkjTrOhhNytMjp+Zi7XzB7E
	 TuAlgc7ib0rRIeP6dDOGJF6PqrZQT7IsSOVrHqdhT9dJfYQgY5XbbdqY5EIAHJ4jbe
	 jdjbRxatZZ7OU79Y2avDzJvjry3nDMyS5HH0eGImvbl5+7FMQH/sEyAwtrfPB8fqPM
	 zBoC1C27cNfkK2SONEDtC8H5u4uREDE689yzpUwXa0oLnmdN3zkCr4CUT25+0Hddv3
	 +vUUmakofwgpg==
Subject:
 Re: [PATCH net] ip6_gre: fix changelink conflict checks for L2 tunnels
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, xeb@mail.ru,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com
Date: Sun, 01 Nov 2026 12:13:42 +0000
Message-ID: <179353522212.3131.3721818848581323546@kernel.org>
In-Reply-To: <20261028115710.27806-1-yanxia@cmss.chinamobile.com>
References: <20261028115710.27806-1-yanxia@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Changelink on a non-collect_md L2 tunnel (ip6gretap/ip6erspan)
  can now fail with -EEXIST because an L2 collect_md ("external") tunnel…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ip6gre_changelink_common() calls ip6_tnl_encap_setup(nt, &ipencap)…

--

ip6_gre: fix changelink conflict checks for L2 tunnels

This patch changes the duplicate check in ip6gre_changelink_common().
It used ip6gre_tunnel_locate(net, p_p, 0), which only matches ARPHRD_IP6GRE
devices. It now uses ip6gre_tunnel_find(net, p_p, dev->type), so
ip6gretap and ip6erspan devices are checked against other L2 tunnels.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index b5d6ed8f0c369..df490798355de 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2055,7 +2055,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
>  
>  	ip6gre_netlink_parms(data, p_p);
>  
> -	t = ip6gre_tunnel_locate(net, p_p, 0);
> +	t = ip6gre_tunnel_find(net, p_p, dev->type);
>  
>  	if (t) {
>  		if (t->dev != dev)

[Severity: Medium]
Can this reject a valid changelink on a non-collect_md ip6gretap or
ip6erspan device when an "external" L2 tunnel has the same lookup key?

ip6gre_newlink() and ip6erspan_newlink() skip ip6gre_tunnel_find() for
collect_md devices. They still link those devices into the hash buckets:

net/ipv6/ip6_gre.c:ip6gre_newlink() {
    ...
	if (nt->parms.collect_md) {
		if (rtnl_dereference(ign->collect_md_tun))
			err = -EEXIST;
	} else {
		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
			err = -EEXIST;
	}
    ...
		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
    ...
}

ip6gre_tunnel_find() does not check collect_md and stops at the first
match:

	hlist_for_each_entry(t, head, hash_node) {
		if (ipv6_addr_equal(local, &t->parms.laddr) &&
		    ipv6_addr_equal(remote, &t->parms.raddr) &&
		    key == t->parms.i_key &&
		    link == t->parms.link &&
		    type == t->dev->type)
			break;
	}

ip6gre_tunnel_link() uses hlist_add_head_rcu(), so the first match is the
tunnel that was linked most recently.

For example, create a wildcard ip6gretap device tap0 with no remote. Then
create "md0 type ip6gretap external". Both devices end up in the same
wildcard bucket with all-zero parameters and type ARPHRD_ETHER.

A later changelink on tap0 that only changes ttl would go:

ip6gre_changelink()
  ip6gre_changelink_common()
    ip6gre_tunnel_find(net, p_p, ARPHRD_ETHER)  -> returns md0
    t->dev != dev                               -> ERR_PTR(-EEXIST)

Before this patch the lookup used ARPHRD_IP6GRE, so md0 could not match
and the update went through. The same happens for ip6erspan, and between
ip6gretap and ip6erspan, since both use ARPHRD_ETHER.

The commit message says changelink now does what the newlink paths do.
Newlink never runs this lookup for collect_md devices, though. Should
changelink handle collect_md tunnels in these buckets in some way, for
example by skipping entries with t->parms.collect_md set?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but
the new EEXIST cases here make it reachable in more situations.

ip6gre_changelink_common() applies the encap attributes to the live tunnel
before the duplicate check and the unregistering check run:

net/ipv6/ip6_gre.c:ip6gre_changelink_common() {
    ...
	if (ip6gre_netlink_encap_parms(data, &ipencap)) {
		int err = ip6_tnl_encap_setup(nt, &ipencap);

		if (err < 0)
			return ERR_PTR(err);
	}

	ip6gre_netlink_parms(data, p_p);

	t = ip6gre_tunnel_find(net, p_p, dev->type);
    ...
}

ip6_tnl_encap_setup() clears t->encap, then rewrites t->encap,
t->encap_hlen and t->hlen.

Suppose the lookup then returns another tunnel (-EEXIST), or the tunnel
is unregistering (-ENODEV). rtnl_changelink() returns that error with no
rollback:

	err = ops->changelink(dev, tb, data, extack);
	if (err < 0)
		return err;

Could a rejected request that has IFLA_GRE_ENCAP_* attributes (for
example ENCAP_TYPE=NONE on a FOU/GUE tunnel) plus conflicting addresses
or key still change the tunnel's encapsulation? Would it make sense to
run the conflict checks before ip6_tnl_encap_setup()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028115710.27806-1-yanxia%40cmss.chinamobile.com
