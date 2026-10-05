Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B025B094;
	Mon,  5 Oct 2026 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234394; cv=none; b=UiiAmScyB1dmkCmfZf5uc3Oo2dkgOP861zQJyq2QG0aZBaVKvhe13TBzTVl2O9+1iCCSye/5NTRbKXpb+OHEviBViMVYpvKoUG1hYWPByKgX6Les8SaqnCb7fDliz41Yh6hqxBPRxIl1i4tGRXoEFqAivc9/6q3e8CNPlJFtacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234394; c=relaxed/simple;
	bh=2vK3/pCd5wSr3buEAt8um8z9E85a66favZXRB/rXKVI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHwP0gN8MdytIqIvIOY4kselj9Us61i9e086HwzNFbDkYOHZeuR78k0F1Rkyd9emTSSDrn6h7lIwFIiv4c+fXJAKoUgS9C8QF5LiZJyJUVOSVvJIuDSQQJ0ahf+LEAoxURuQghzTK+9iNrCUZKK5xCkpQb5JF6s88qWIYZPZsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/pacUp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/pacUp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083B31F000FF;
	Mon,  5 Oct 2026 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234392;
	bh=bEXPh/gBLTg9XMtJ69jAnXwzbGULNfqTXAFztxkmtno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C/pacUp9d05vx4UkIUSUoqDaO5lIF2i/i2VcYK/4RdfrnteH9tBwc/VRElIuli5vc
	 7mDfD9kymOHPYQD/GtWwpOAXPn6NIFdPBU5goUbc0v53hoPF8X/vIO34ILncg2Eapt
	 Wn8QtMiM1KVMEa/srlZZ+45UsXSj804stTaX8cGoOx5xEJyEjoccU5gEF8TzfcFXBp
	 PeyMNcmyHUpG4tXjEo2kNwg96jSWQL8v2GEJ5IcUEXhcQ1JgbAuWMbXpOXKMKpGjX/
	 MT3YilnH691w/oDJswa2tXoHEIEK65o5V/LQQBXb9z2USn38lWowfOEnBBmquG/FVO
	 xAUvYbFY+4iIQ==
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for
 bridging
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 21:06:31 +0000
Message-ID: <179123439155.434549.10322630340184585592@kernel.org>
In-Reply-To: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch closes the cross-netns real-port privilege gap only in
  the bridge ndo callbacks.
- [Medium] The commit message says it will 'Require CAP_NET_ADMIN in the
  real device's namespace before ... removing a bridge'.

--

net: qualcomm: rmnet: require real-netns admin for bridging

An rmnet device keeps its link to the real device after it is moved to
another network namespace. This patch adds rtnl_dev_link_net_capable()
checks to rmnet_add_bridge() and rmnet_del_bridge(). With the checks,
changing the bridge state of the real port needs CAP_NET_ADMIN in the
real device's namespace.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf25..62d7acb13e0c0 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>  
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(slave_dev),
> +	 * but bridge mode below controls real_dev, which may live in another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +

[Severity: High]
The bridge ops are not the only rtnl entry point that modifies the shared
real port. Should rmnet_changelink() get the same check?

rmnet_changelink() looks up the port shared by every rmnet endpoint on
real_dev and modifies it. The only capability check is the one rtnetlink
does in dev_net(dev):

drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_changelink() {
    ...
	port = rmnet_get_port_rtnl(real_dev);

	if (data[IFLA_RMNET_MUX_ID]) {
		...
			hlist_del_init_rcu(&ep->hlnode);
			hlist_add_head_rcu(&ep->hlnode,
					   &port->muxed_ep[mux_id]);
		...
	}

	if (data[IFLA_RMNET_FLAGS]) {
		...
		port->data_format &= ~flags->mask;
		port->data_format |= flags->flags & flags->mask;

		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
    ...
}

Suppose an rmnet device has been moved into netns B while real_dev stays
in netns A. A user with CAP_NET_ADMIN only in B can then send
RTM_NEWLINK with IFLA_RMNET_FLAGS. That rewrites port->data_format,
which controls deaggregation, MAP checksum offload and MAPv5 handling
for every rmnet endpoint on real_dev in A.

The same user can also move the endpoint between port->muxed_ep[]
buckets by changing IFLA_RMNET_MUX_ID.

rmnet_vnd_update_dev_mtu() walks every endpoint on the port and calls
rmnet_vnd_change_mtu(ep->egress_dev, real_dev->mtu - headroom). So
setting a flag that grows the headroom, such as
RMNET_FLAGS_EGRESS_MAP_CKSUMV4, also shrinks the MTU of rmnet devices
in netns A.

macvlan_changelink() already guards shared lower-port settings with:

	!rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))

Would a similar guard in rmnet_changelink(), at least for
IFLA_RMNET_FLAGS and IFLA_RMNET_MUX_ID, be needed for this fix to be
complete? The other option would be to mark rmnet devices
netns_immutable.

>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +496,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(slave_dev),
> +	 * but bridge teardown also updates real_dev, which may live in another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;

[Severity: Medium]
The commit message says:

    Require CAP_NET_ADMIN in the real device's namespace before adding or
    removing a bridge.

This check gates only the ndo_del_slave path. Two other teardown paths
reach rmnet_unregister_bridge() and make the same real port change:

	real_port->bridge_ep = NULL;
	real_port->rmnet_mode = RMNET_EPMODE_VND;

The first is RTM_DELLINK on the rmnet device. rtnl_delete_link() calls
ops->dellink directly:

rtnl_delete_link()->rmnet_dellink() {
    ...
	bridge_dev = real_port->bridge_ep;
	if (bridge_dev) {
		bridge_port = rmnet_get_port_rtnl(bridge_dev);
		rmnet_unregister_bridge(bridge_port);
	}
    ...
}

The second is NETDEV_UNREGISTER on the slave, which fires when a
virtual slave is deleted or moved to another netns:

rmnet_config_notify_cb()->rmnet_force_unassociate_device() {
    ...
	} else {
		rmnet_unregister_bridge(port);
	}
}

Neither path has a real-netns capability check. Both are void or
notifier paths, so they cannot fail the same way.

A user who is admin only in the rmnet/slave netns would now get -EPERM
from "ip link set slave nomaster" or from a master change. In that case
do_set_master() returns after ndo_del_slave fails, before it attaches the
new master. The same user can still remove the bridge without
real-netns privilege by deleting the rmnet device, or the slave if it is
virtual.

Does the del-side check give any real protection here? The add-side
check already blocks unprivileged bridge creation. Would it make sense
to drop or rethink this check rather than block the clean unenslave
path?

> +
> +	port = rmnet_get_port_rtnl(slave_dev);
>  
>  	rmnet_unregister_bridge(port);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004203149.3042491-2-Jeremy.Jean%40oss.cyber.gouv.fr
