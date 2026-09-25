Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA62448BB7;
	Fri, 25 Sep 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319184; cv=none; b=hRCRtJwDmKT9DDIUdPDxcCMFbgCexGC+ssRKHzFx9ZnFW1DuSM7c/MVLf3dPC/efNBgoyR3bPlOE7dCIvnOEzYIqt/aiw1HNwpiFAaUe29CGlZPwAUmq5Ym015poMYRdzGzXcvcSVRj4jfhBQolUAonmnhh9gdcoUEDIxKwveRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319184; c=relaxed/simple;
	bh=Bt8cFN/OIAsjw9657dJ2R62rZXrwR5WCo9t3t7m8Gg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4qZxDDV05ymGZiNtg+YLxKUD3AN4mka+FzNM8YYxFYzGW3P12zXLSmA5hbm3SXdnBuWSV6A8Fv0EUTNtOemQud9jQTa87nl07lyXB9dLI0DMxXOmMhPiuDudlBaWmaEpIW79r5tVUc2+joqEh4g0a62ckd9828bBhfOVPR8+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuwaQRqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuwaQRqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE81F00898;
	Fri, 25 Sep 2026 06:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319179;
	bh=sXMxmO8mKOJ2tLsFqe6P2hdzHFUtzubYW49oE1NFbbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GuwaQRqTlR2I1xrADKGPFHFvIji7oQRJEKx5pTt4ey2LKPZ3+ZkqSfcm6JPH+JK5T
	 1jm4n/7U1Uvlvku1/lgwG7hLECzd5rpAptwq+klsKt91S90vC4iAWdbgUHG9I9VBoG
	 bzzSo/xR1nZuO9MH4+7yzKU8N8kujwMfrL5H0RzckfW+a7WO7Dg2Sp9r521hmXRa+F
	 +eL+wUjlCgJ1HNcPjiGoJVm6Aw1v850d2pL9jtB65qmPDfxZ5JLLogKaaCi4jgmIMG
	 vPcZSbJnvpfz1JiPsDbtMsLDIYLHJ9kATK8PNwQuVfcnk+xGqr3FFmz7vGg8x25HIY
	 JS/Y4B3tnTypA==
Subject: Re: [PATCH net v3 1/5] ip_tunnel: do not clear the active encap
 before validating the new one
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 u9012063@gmail.com, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 06:52:58 +0000
Message-ID: <179031917882.2160803.2662236543443790926@kernel.org>
In-Reply-To: <20260923035217.179102-2-edumazet@google.com>
References: <20260923035217.179102-2-edumazet@google.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch only fixes the case where
  ip_tunnel_encap_setup()/ip6_tnl_encap_setup() itself fails.

Pre-existing issues:
- [Medium] ip_tunnel_encap_setup() and ip6_tnl_encap_setup() update
  t->encap.{type,sport,dport,flags}, t->encap_hlen and t->hlen one field…

--

ip_tunnel: do not clear the active encap before validating the new one

This patch removes the memset() of t->encap from ip_tunnel_encap_setup()
and ip6_tnl_encap_setup(). After this change, a request that
ip_encap_hlen() or ip6_encap_hlen() rejects no longer leaves the tunnel
set to TUNNEL_ENCAP_NONE with stale encap_hlen and hlen values. The patch
is tagged for stable.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..2a313b18134e2 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -491,8 +491,6 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
>  {
>  	int hlen;
>  
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen = ip_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;

[Severity: Medium]
This covers the case where ip_tunnel_encap_setup() itself fails. Can the
symptom described in the commit message still happen when encap setup
succeeds and the caller rejects the request afterwards?

The commit message says:

  "A rejected netlink request thus permanently disables FOU/GUE on a
  working tunnel while keeping its reduced MTU and extra headroom."

Once ip_encap_hlen() succeeds, ip_tunnel_encap_setup() writes
t->encap.{type,sport,dport,flags}, t->encap_hlen and t->hlen into the
live tunnel. In ipip_changelink(), the rest of the request is only
validated after that:

net/ipv4/ipip.c:ipip_changelink() {
    ...
	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
		int err = ip_tunnel_encap_setup(t, &ipencap);

		if (err < 0)
			return err;
	}

	ipip_netlink_parms(data, &p, &collect_md, &fwmark);
	if (collect_md)
		return -EINVAL;
    ...
}

Take a changelink on an existing FOU/GUE ipip tunnel that sends
IFLA_IPTUN_ENCAP_TYPE=TUNNEL_ENCAP_NONE together with
IFLA_IPTUN_COLLECT_METADATA:

- ip_encap_hlen() returns 0, so the encap is cleared and t->hlen shrinks.
- The collect_md check then returns -EINVAL.
- Userspace gets an error, but FOU/GUE is now off.
- dev->mtu keeps its reduced value, because ip_tunnel_update() never ran.

These other rejections also happen after the encap has been committed.
None of them roll it back or refresh dev->mtu or the headroom:

- ipip on the fallback device: "ip link change tunl0 encap fou ..."
  applies FOU to tunl0. ip_tunnel_changelink() then returns -EINVAL at
  "if (dev == itn->fb_tunnel_dev)".
- ipip_changelink() and ipip6_changelink(): the IFF_POINTOPOINT/daddr
  -EINVAL check, and the -EEXIST returns from ip_tunnel_changelink() and
  ipip6_tunnel_locate().
- ip6_tnl_changelink(): the "if (p.collect_md) return -EINVAL;" check and
  the -EEXIST from ip6_tnl_locate(). Both skip ip6_tnl_update().
- ip6gre_changelink_common(): the -EEXIST from ip6gre_tunnel_locate().

Later in this series, "ip_gre: validate netlink attributes before
changing the tunnel" fixes ip_gre. It moves ipgre_netlink_parms() first
and refreshes the lengths on the ip_tunnel_changelink() error path. At
the end of the series, ipip, sit, ip6_tunnel and ip6_gre are unchanged.

The commit message says callers still call ip[6]_tunnel_encap_setup()
before validating the rest of a changelink request. The patch is tagged
Fixes/Cc: stable for this symptom. Should these callers also validate the
whole request before they commit the new encap?

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac017..c918c2b0ad81b 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1818,8 +1818,6 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
>  {
>  	int hlen;
>  
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen = ip6_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;

[Severity: Medium]
This isn't a bug introduced by this patch, but it concerns the same
fields. ip_tunnel_encap_setup() and ip6_tnl_encap_setup() update
t->encap.{type,sport,dport,flags}, t->encap_hlen and t->hlen one at a
time with plain stores under RTNL. The transmit paths read those fields
with no lock and no snapshot.

In ip6_tnl_xmit(), encap_hlen is read on entry and later sizes
skb_cow_head():

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
    ...
	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
	unsigned int max_headroom = psh_hlen;
    ...
}

Much later, ip6_tnl_encap() reads t->encap.type again to pick the
callback, and it passes the mutable t->encap:

include/net/ip6_tunnel.h:ip6_tnl_encap() {
    ...
	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
	if (likely(ops && ops->build_header))
		ret = ops->build_header(skb, &t->encap, protocol, fl6);
    ...
}

Suppose a changelink switches from NONE to GUE between these two reads.
Could headroom be reserved with encap_hlen == 0 while a GUE header is
pushed? If the skb had only the minimum headroom, this might reach
skb_under_panic(), though it is not clear that such skbs reach this
path.

Could fou6_build_udp() also read a dport/flags pair from the next
configuration after the callback has already been chosen?

The IPv4 side has the same pattern. ip_tunnel_xmit() reads
tunnel->encap once for the header and again for the headroom:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
    ...
	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
		goto tx_error;
    ...
	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
    ...
}

None of these accesses use READ_ONCE()/WRITE_ONCE(), so KCSAN would
likely report them. Removing the memset makes the window smaller, because
readers no longer see a temporary TUNNEL_ENCAP_NONE. According to the
commit message, the net-next commit 88b84cae6b94 adds WRITE_ONCE() only
on the IPv4 side. Should the readers, and the IPv6 writer, get matching
annotations or use a consistent snapshot of the encap?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923035217.179102-1-edumazet%40google.com
