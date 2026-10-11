Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2B276050;
	Sun, 11 Oct 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700888; cv=none; b=E/xpKvSDyhLgftTL6ix+OgFPNtzn9o2gHw1gvxYcHkWCeUPWQE/3If7zgZfAGtO5MseaNL0I02Q9mMaqp9iwmp/tGbcEQEdlMZn036KNB5oKe3wCs5/ishy59w6JmuW7aRwMlVyXcTqkxi33gOF8BrD0/6PUrfmbTP42H/3tqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700888; c=relaxed/simple;
	bh=o1Cfjj4mgiFLSD4ehTkQrXze+HXV0jTSSUbP7u03vuA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebn/M8SkaXcwuLY5ZYaCvMDpBb4bWcUCFHLRjGK2FaQ+wWcQ4zJSgoVRxsHLjPv5Oj4vJaOH2MYp1oCkdSD2H0KI8n1SQn9AdU90FZTjccoONBOshQzUZVI7JYX2ZpO7xsL/S5tzofOsC1ydfGg3E+IsMVnb6g5Yq+RgJJ6zW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9chI6SV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9chI6SV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB51F0089B;
	Sun, 11 Oct 2026 06:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791700886;
	bh=RmCZH95ehgU540OjvnS3MFoFEkyabpFbTjwYQ0ORD6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c9chI6SVxwWEhR9Gnfx7+wVHgTLMyFaMMMbouAiIIJ8tXrXAdCLpGVEGAI7GQiQ8V
	 bkAwVt+B8Vvg5BPbs06QDrVTVF2oSORR708zdASXpEYMYiyGYqWkx8vqMG43SPf+lv
	 IU2deCmPlDX3X7Ry72gkooZM7a12Tl5wl8Mbhj8ueMDaUdlovJCptQjjVq05yfHvbt
	 rEe56RR8P0fOBWrZ0ATTZQmjsFwt/XB+2xIhX+1bHPnCQymMYSq0+NunDQvpFAJaW0
	 DpC/mDB7+yGOmi4Qi4gQ39m6HrMfFCrP/pf8JTdvC97PE8c4OSRn5u0NksoXC26okx
	 vFW5mpoM6PP9Q==
Subject:
 Re: [PATCH net] macvlan: require lower-netns admin for IFLA_MACVLAN_FLAGS
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 11 Oct 2026 06:41:25 +0000
Message-ID: <179170088566.434549.4699134797461783473@kernel.org>
In-Reply-To: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
References: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] macvlan: incomplete CAP_NET_ADMIN check allows traffic
  interception
- [Medium] The commit message presents commit 5b782a811e73 ("macvlan:
  require lower-netns admin for shared port settings") as covering…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  macvlan_changelink() (drivers/net/macvlan.c:1665-1678) calls…
- [Medium] This problem wasn't introduced by this patch, but the new
  check relies on rtnl_dev_link_net_capable()…

--

macvlan: require lower-netns admin for IFLA_MACVLAN_FLAGS

This patch extends the rtnl_dev_link_net_capable() check in
macvlan_changelink() to IFLA_MACVLAN_FLAGS. Changing that attribute now
requires CAP_NET_ADMIN in the lower device's network namespace. The
reason given is that toggling MACVLAN_FLAG_NOPROMISC in passthru mode
calls dev_set_promiscuity() on the lower device.

> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index afad90b9222a2..d30cffddb1e1b 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1641,7 +1641,8 @@ static int macvlan_changelink(struct net_device *dev,
>  	int ret;
>  
>  	if (data &&
> -	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF]) &&
> +	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF] ||
> +	     data[IFLA_MACVLAN_FLAGS]) &&
>  	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
>  		NL_SET_ERR_MSG(extack,
>  			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");

[Severity: High]
This isn't introduced by this patch. Since the guard is being
extended here, though, does it still miss the attributes that let a
child netns admin receive traffic from the lower device?

IFLA_MACVLAN_MODE and IFLA_MACVLAN_MACADDR_MODE are not covered by the
rtnl_dev_link_net_capable() check. One changelink request is enough
for root in the macvlan's netns to do both of these:

  1. Switch a non-passthru macvlan to MACVLAN_MODE_SOURCE. set_mode is
     applied before the IFLA_MACVLAN_MACADDR_MODE branch.
  2. Pass MACVLAN_MACADDR_ADD with an arbitrary MAC address.

macvlan_changelink_sources() then calls macvlan_hash_add_source().
That inserts the entry into vlan->port->vlan_source_hash, which
belongs to the shared struct macvlan_port, not to the upper device.

On receive, macvlan_handle_frame() calls macvlan_forward_source() for
every frame on the lower device, keyed on eth->h_source. For each
matching entry, macvlan_forward_source_one() delivers a clone to that
vlan. Nothing restricts the MAC to stations that belong to the child
netns.

A container that only owns the upper device could therefore add the
MAC of, for example, the gateway on that segment. It would then get a
copy of every frame that station sends on the lower device. That
includes frames addressed to the lower device itself or to macvlans in
other namespaces.

If MACVLAN_FLAG_NODST is already set on that vlan, consume becomes
true in macvlan_forward_source(). The frame is then dropped instead of
reaching its real destination.

5b782a811e73 treated mode as a per-upper setting. Does that still hold
once MACVLAN_MODE_SOURCE fills a port-wide hash?

Should the check also cover IFLA_MACVLAN_MACADDR_MODE, and maybe the
switch into MACVLAN_MODE_SOURCE? Or is source-mode filtering meant to
be allowed for an admin of the upper's namespace alone?

[Severity: Medium]

The commit message says that 5b782a811e73 "only covered
IFLA_MACVLAN_BC_QUEUE_LEN and IFLA_MACVLAN_BC_CUTOFF". That reads as if
flags were overlooked. However, 5b782a811e73 left flags ungated on
purpose:

    rtnl_dev_link_net_capable() short-circuits when the lower
    device shares the macvlan network namespace, so an ordinary
    single-namespace configuration is unaffected, and per-upper settings
    such as mode and flags stay available to an administrator of the
    macvlan's own namespace. This is the model ipvlan has used since
    commit 7cc9f7003a96 ("ipvlan: disallow userns cap_net_admin to change
    global mode/flags").

That commit also said the passthru-only port state cannot be reached
from a second upper, since passthru requires port->count == 0.

Should the commit message say that this reverses the earlier decision,
and explain why that reasoning no longer holds?

The extack text is reused unchanged. IFLA_MACVLAN_FLAGS is stored in
vlan->flags in struct macvlan_dev, not in the shared struct
macvlan_port. Is "Changing shared macvlan port settings" accurate for
this attribute?

The new check also covers more than the problem described. In the flags
branch below, only this path touches the lower device:

	if (macvlan_passthru(vlan->port) && promisc) {
		...
			err = dev_set_promiscuity(vlan->lowerdev, -1);
		...
	}
	WRITE_ONCE(vlan->flags, flags);

On a non-passthru macvlan, or for a change that leaves NOPROMISC alone
(for example a NODST-only change), the branch only writes vlan->flags.
After this patch, an admin of the macvlan's own netns without
CAP_NET_ADMIN in the lower netns gets -EPERM for those changes too.

Is this uAPI change intended? Could the check be limited to passthru
mode when MACVLAN_FLAG_NOPROMISC actually changes?

[Severity: Medium]

This isn't a bug introduced by this patch, but the IFLA_MACVLAN_FLAGS
branch in macvlan_changelink() changes the lower device's promiscuity
without checking netif_running(dev):

	if (data && data[IFLA_MACVLAN_FLAGS]) {
		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
		if (macvlan_passthru(vlan->port) && promisc) {
			int err;

			if (flags & MACVLAN_FLAG_NOPROMISC)
				err = dev_set_promiscuity(vlan->lowerdev, -1);
			else
				err = dev_set_promiscuity(vlan->lowerdev, 1);

Otherwise the passthru promiscuity reference is held only while the
macvlan is up. macvlan_open() takes it:

	if (macvlan_passthru(vlan->port)) {
		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
			err = dev_set_promiscuity(lowerdev, 1);

macvlan_stop() drops it:

	if (macvlan_passthru(vlan->port)) {
		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
			dev_set_promiscuity(lowerdev, -1);

What happens if NOPROMISC is toggled while the macvlan is down?

Clearing NOPROMISC while down adds 1. A later open adds another 1, but
stop removes only one. Does the lower device then stay promiscuous for
good?

Setting NOPROMISC while down drops a reference that was never taken.
That could take away another holder's reference. If the counter was 0,
__dev_set_promiscuity() would wrap it to UINT_MAX with IFF_PROMISC set,
and later +1 requests would fail with -EOVERFLOW.

This goes back to df8ef8f3aaa6. With this patch applied, reaching this
path needs CAP_NET_ADMIN in the lower netns, or both devices in the
same netns.

[Severity: Medium]

This is a pre-existing issue, but the check extended here depends on
rtnl_dev_link_net_capable(), which only looks at current's credentials:

net/core/rtnetlink.c:rtnl_dev_link_net_capable() {
	return net_eq(link_net, dev_net(dev)) ||
	       ns_capable(link_net->user_ns, CAP_NET_ADMIN);
}

The other cross-netns checks in rtnetlink use
netlink_ns_capable(skb, ...). That also requires the socket opener to
hold the capability (the CVE-2014-0181 hardening).

Could a confused deputy get past the lower-netns check here? For
example:

  1. An unprivileged user who owns a child userns opens a NETLINK_ROUTE
     socket in the child netns.
  2. A privileged program (for example a setuid-root one) is made to
     write an attacker-controlled RTM_NEWLINK message to that fd.
  3. netlink_net_capable() in rtnetlink_rcv_msg() passes, because the
     opener is privileged in the child userns.
  4. rtnl_dev_link_net_capable() in macvlan_changelink() passes,
     because current is global root.

Nothing checks that the opener lacks CAP_NET_ADMIN in the lower netns.

The helper came from 8165f7ff57d966. Other callers such as ip_gre,
vxlan and geneve share it, so a fix there would probably be a separate
patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010062944.2671656-1-bsdhenrymartin%40gmail.com
