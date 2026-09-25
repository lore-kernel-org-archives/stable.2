Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7243DD847;
	Fri, 25 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319186; cv=none; b=BUypKkznl//29fQ4EP5ITBnrSx0VFtn2afFVhATN/kaOfRB3+YYyGx8krlO+a+3LTbzjt5oAvpHG0Thyvw0KZX8sbVIuOleO2/GOcUMfULDStsaVBqYoxggWjhM33/crD37ZqPTN5vRcOJad6uZtaLzGExaSlnwUsDiUrijeE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319186; c=relaxed/simple;
	bh=k0fyAKBmBijd0E8n/jKJ71dliHDFO3MimBr133OA0uE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p159+0wfgRjqm5xfsWsKQTrQrtzDEodn15A4F089B9WC2/olzJo4KwGXET+Efvf8E+NoOwZB6x7kPtE5cRuZCLqOBDdkfxpy6ILZXtt41RdcCMycUS9ypFWWpg9UnNx+8nEf0l3iOdaPXZCRoMUzzihztkS9qtMAfNcnk9oWbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgVeESaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgVeESaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B981F0089A;
	Fri, 25 Sep 2026 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319182;
	bh=DlfLtsQxFq1+FT3UcQH22EWwZwn1pUcLiR7iXk+z9wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VgVeESaE3echcKglp/KAzXiUZifxJMDO177IySTqcLHY/cbr3xqFyr9b7dE6GAQuC
	 vfGyqRu3QC1RO1EJNXOOMTRdn3Tnf5IKGHv4x13VXE/XMBUKPtNAUQG+Y4SW/MOPlm
	 3k56Ud9vOBGci6j+eT9uOlyOccEU21I+yKSuOl44NEKcKT7ITYOlWfUZ2lNVBeMqhG
	 XV27I1hs5BApLyjOGemjy+wXJiwcZI2W5CWz1bobTjMaxo/fM/gyPCsf4vTECagkU4
	 eXLgQ/m24P2+8BXHSK29Srd2nN3do5n10B9c/aeKkZ3mvYMtha/Q17+Z1Y0gVG6RC+
	 2J4Y2AEe4sHtw==
Subject: Re: [PATCH net v3 3/5] ip_gre: compute tunnel lengths absolutely
 instead of by delta
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 u9012063@gmail.com, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 06:53:01 +0000
Message-ID: <179031918107.2160803.12336993632886364252@kernel.org>
In-Reply-To: <20260923035217.179102-4-edumazet@google.com>
References: <20260923035217.179102-4-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the GRE header length changes, ipgre_link_update() now
  replaces the user-configured dev->mtu with the default computed by…
- [Medium] A changelink that publishes a new header length but carries an
  IFLA_MTU that do_setlink() later rejects leaves the tunnel with the…

Pre-existing issues:
- [Medium] Sibling changelink handlers publish a new encap_hlen through
  ip_tunnel_encap_setup() but never recompute dev->mtu or…

--

ip_gre: compute tunnel lengths absolutely instead of by delta

This commit changes ipgre_link_update() to recompute tunnel->hlen from
tun_hlen and encap_hlen instead of applying a delta. It adds
ip_tunnel_refresh_lengths() so that ip_tunnel_bind_dev() is the only
writer of dev->needed_headroom and dev->mtu. ipgre_changelink() now also
refreshes the lengths on the ip_tunnel_changelink() error path.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index df4d2f1f1d60c..27b3b4c584b1e 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c

[ ... ]

> +static void ipgre_link_update(struct net_device *dev, bool set_mtu,
> +			      int old_hlen)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> -	int len;
>  
> -	len = tunnel->tun_hlen;
>  	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
> -	len = tunnel->tun_hlen - len;
> -	tunnel->hlen = tunnel->hlen + len;
> +	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;

[ ... ]

> -	if (set_mtu)
> -		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
> +	/* Only reset a MTU that the header length just invalidated, so that
> +	 * a MTU configured by the user survives an unrelated change.
> +	 */
> +	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);

[Severity: Medium]
Can this overwrite an MTU that the user configured? Before this patch, a
change to tun_hlen reduced the current dev->mtu by the delta:

    WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));

Now, when hlen differs from old_hlen, ip_tunnel_refresh_lengths() writes
the value that ip_tunnel_bind_dev() computes from the underlay. The
current dev->mtu is not taken into account.

The ioctl path always passes set_mtu = true:

ipgre_tunnel_ctl()
    ipgre_link_update(dev, true, t->hlen)
        ip_tunnel_refresh_lengths(dev, true)
            WRITE_ONCE(dev->mtu, ip_tunnel_bind_dev(dev))

ipgre_changelink() does the same whenever IFLA_MTU is absent.

Take gre1 over a 1500 byte eth0 with MTU 1300 set, and run
"ip link set gre1 type gre okey 1" or "ip tunnel change gre1 key 1". The
MTU becomes 1472 instead of 1296, which is larger than the value the
user chose.

If ip_tunnel_bind_dev() finds no underlay device (daddr == 0 with no
link, or a failed route lookup), the MTU falls back to
ETH_DATA_LEN - t_hlen. A jumbo MTU of 8976 would then drop to 1472.

The comment says the header length change invalidated the MTU. A user
MTU that is still below the new maximum still looks valid, though. The
later patches in the series do not appear to change this.

This is tagged for stable. Should the commit message describe this
behaviour change? Or should the user's MTU be kept when it still fits?

[ ... ]

> @@ -1509,17 +1524,35 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (err)
>  		return err;
>  
> +	link_changed = t->parms.link != p.link || t->fwmark != gparms.fwmark;
> +
>  	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;

[ ... ]

> -	ipgre_link_update(dev, !tb[IFLA_MTU]);
> +link_update:
> +	/* ipgre_newlink_encap_setup() has published a new encapsulation even
> +	 * if ip_tunnel_changelink() failed, so the lengths must be refreshed
> +	 * on that error path as well.
> +	 *
> +	 * IFLA_MTU only defers the MTU to do_setlink(), which rtnl_changelink()
> +	 * does not reach if we return an error, so it must not hold it back.
> +	 */
> +	ipgre_link_update(dev, err || !tb[IFLA_MTU], old_hlen);

[Severity: Medium]
What happens if IFLA_MTU is present but do_setlink() then fails to apply
it?

When ip_tunnel_changelink() succeeds and tb[IFLA_MTU] is set, set_mtu is
false here. dev->mtu is left alone on the assumption that do_setlink()
will set it. However, rtnl_changelink() only calls do_setlink() after
ops->changelink() has committed the new encap and hlen, and do_setlink()
can still fail:

net/core/rtnetlink.c:do_setlink() {
    ...
	if (tb[IFLA_MTU]) {
		err = netif_set_mtu_ext(dev, nla_get_u32(tb[IFLA_MTU]), extack);
		if (err < 0)
			goto errout;
    ...
}

For example, IFLA_MTU = 0 passes the NLA_U32 policy and
validate_linkmsg(), and netif_set_mtu_ext() then rejects it. Other
do_setlink() steps that run before the MTU step can also fail.

Take a bare GRE tunnel over a 1500 byte device and add "encap fou" in
such a request. The MTU would stay at 1476 instead of 1468, which is the
stale MTU this patch sets out to fix.

A later changelink without a header change would not repair it either,
because old_hlen would already equal the new hlen.

The comment covers rtnl_changelink() not reaching do_setlink() on error.
Does it also need to handle the case where do_setlink() is reached and
fails? The same pattern also seems to be copied into erspan_changelink()
later in the series.

>  
> -	return 0;
> +	return err;
>  }

[ ... ]

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 2a313b18134e2..dd1b2f719f216 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> +void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
> +{
> +	int mtu = ip_tunnel_bind_dev(dev);
> +
> +	if (set_mtu)
> +		WRITE_ONCE(dev->mtu, mtu);
> +}
> +EXPORT_SYMBOL_GPL(ip_tunnel_refresh_lengths);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Other
changelink handlers that call ip_tunnel_encap_setup() seem to have the
same stale length problem. At this commit that includes
erspan_changelink() in net/ipv4/ip_gre.c, ipip_changelink() in
net/ipv4/ipip.c and ipip6_changelink() in net/ipv6/sit.c.

For example, ipip_changelink():

net/ipv4/ipip.c:ipip_changelink() {
    ...
	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
		int err = ip_tunnel_encap_setup(t, &ipencap);

		if (err < 0)
			return err;
    ...
	return ip_tunnel_changelink(dev, tb, &p, fwmark);
}

ip_tunnel_update() only calls ip_tunnel_bind_dev() when the link or
fwmark changed:

	if (t->parms.link != p->link || t->fwmark != fwmark) {

So "ip link set ipip0 type ipip encap fou ..." would leave dev->mtu and
dev->needed_headroom stale.

The later commit "ip_gre: recompute erspan header lengths after a change"
fixes the erspan part. It adds erspan_link_update() and calls it on both
the success and error paths.

ipip_changelink() and ipip6_changelink() still do not call
ip_tunnel_refresh_lengths() at the end of the series. Would it make
sense to use the new helper there as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923035217.179102-1-edumazet%40google.com
