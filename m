Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED35C1A0;
	Thu, 10 Sep 2026 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027529; cv=none; b=jNOtb+6gEa+MUphaoj4/vaUK9A4O32KokRsmHCMjftjL1rRxVmlva+z7dBvnfdRwQVM3ztDxzc1rkTzEyckr8KUNGo+xlbI+m3txQz/h3Vb/J3bsK6z4CYDSeXPEvTB2fJSfQiNUcfu0ai2r7er9dEk8CB4Ml87QIR7Nqa/xe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027529; c=relaxed/simple;
	bh=3RDGPU6bGsZ14L3riXDm7gY0+rSpHepu8gHgUIuendI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnSRB2Cq7s1Chp8u7rjen3aZ/XUi0xUAx+Vztk1SU9V3HF72EOX1K2JRYvW07PtT9KwVMx2i8xmOz1xnZ1qszkADm2Db1ZxT0KYeoM2HkFay9b6kjV8oGXfaJadBuF811qQuADGcBdsTBUeQJJh3I+FBkeu82rFg4qF/jTP7pEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atYr8uvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atYr8uvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD241F000FF;
	Thu, 10 Sep 2026 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027526;
	bh=QmwmPduBKKpwSdcwtwcmpDRWItA4tTbHzr7ajk09GRc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=atYr8uvjTugnQOV5dS+LX6n4aqCmGee0CP83N0qmUQHqqH9vx0CTBLzPvtni0O8iD
	 5lC+erHqv9KawJqU3qLl4qfFTbnJkFIrYciEhxO6OdQKJHCT0HS+5p0MqqZSYdQoBm
	 cEZSB3Q+XXwZFlywWEg898NlFUQJci0npKrxqGlaxuBtlMBnIuSCQx3TVqfnkIq0KZ
	 QBZQG6/AxlsFXrRoR+4gCdyhVm04YYQC5IagDGe1fS5xooqefZJE92XyN8c37bnJU6
	 rVH9l5LwqTMKaJtuMLhi+8hN6AYkibtGCyA+7aTtDycfS+dGKXLZ74ym1f4R1AHoCq
	 0EKpKq1d8JSkQ==
Subject: Re: [PATCH net v6] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for config ops
From: netdev-bot+sashiko@kernel.org
To: suruurism@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 subash.a.kasiviswanathan@oss.qualcomm.com, sean.tranchetti@oss.qualcomm.com,
 dnlplm@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 08:05:25 +0000
Message-ID: <178902752591.219967.4056338734976657724@kernel.org>
In-Reply-To: <20260909080209.6348-1-suruurism@gmail.com>
References: <20260909080209.6348-1-suruurism@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 2

- [High] The new rtnl_dev_link_net_capable() gate in rmnet_del_bridge()
  (rmnet_config.c:519-529) does not close the bug class the commit…
- [Low] The comment added above the new capability gate in
  rmnet_add_bridge()…
- [Low] The v4 changelog states 'use the netdev comment style, per Subash
  Abhinov Kasiviswanathan', but the block comment newly added in…

--

net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops

This adds capability gates so that rmnet config operations which mutate the
rmnet_port attached to the real device also require CAP_NET_ADMIN in the real
device's network namespace.  rmnet_changelink(), rmnet_add_bridge() and
rmnet_del_bridge() are gated with rtnl_dev_link_net_capable(), and
rmnet_set_coalesce() with ns_capable() on the real device's user namespace.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..8df9e455110d 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c

[ ... ]

> @@ -441,6 +451,19 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>  
> +	/* The rtnl path authorizes the caller against the RTM_SETLINK
> +	 * target, slave_dev, but the port state mutated below is attached
> +	 * to real_dev, which may live in a different netns.  Check the
> +	 * capability against slave_dev so the master's netns, which the
> +	 * caller was never checked against, cannot short-circuit the gate
> +	 * after being moved into the real device's netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev))) {

[Severity: Low]

Is the second half of this comment accurate for the add path?  The scenario
it describes is the master having been moved into the real device's netns so
that the net_eq() test inside rtnl_dev_link_net_capable() short-circuits.

On the ndo_add_slave path the master is resolved in the slave's netns by
do_set_master() in net/core/rtnetlink.c:

	upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
	if (!upper_dev)
		return -EINVAL;
	ops = upper_dev->netdev_ops;
	if (ops->ndo_add_slave) {
		err = ops->ndo_add_slave(upper_dev, dev, extack);

Here dev is the slave, so dev_net(rmnet_dev) == dev_net(slave_dev) always
holds by the time rmnet_add_bridge() runs, which makes
rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)) and
rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)) equivalent at this
call site.

The same wording is accurate in rmnet_del_bridge(), where the master comes
from netdev_master_upper_dev_get(dev) with no per-netns lookup.  Would it be
clearer to keep the "moved into the real device's netns" rationale only in
rmnet_del_bridge() and leave a shorter note here?

>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +512,22 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path authorizes the caller against the RTM_SETLINK
> +	 * target, slave_dev, but rmnet_unregister_bridge() below clears
> +	 * the bridge state of the real device's port, which may live in a
> +	 * different netns.  Check the capability against slave_dev so the
> +	 * master's netns, which the caller was never checked against,
> +	 * cannot short-circuit the gate after being moved into the real
> +	 * device's netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port = rmnet_get_port_rtnl(slave_dev);
>  
>  	rmnet_unregister_bridge(port);

[Severity: High]

Does this -EPERM actually close the teardown direction described in the
commit message?  The same mutation of the real device's port looks reachable
via RTM_DELLINK with CAP_NET_ADMIN only in the rmnet device's netns.

rtnl_dellink() resolves the victim in tgt_net and checks nothing against
dev_net(real_dev):

net/core/rtnetlink.c:rtnl_dellink() {
	...
	if (ifm->ifi_index > 0)
		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
	...
	if (dev)
		err = rtnl_delete_link(dev, portid, nlh);
}

rmnet_dellink() then reaches into the real device's port unconditionally:

drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_dellink() {
	real_port = rmnet_get_port_rtnl(real_dev);
	bridge_dev = real_port->bridge_ep;
	if (bridge_dev) {
		bridge_port = rmnet_get_port_rtnl(bridge_dev);
		rmnet_unregister_bridge(bridge_port);
	}
	...
	netdev_upper_dev_unlink(real_dev, dev);
	rmnet_unregister_real_device(real_dev);
}

so real_port->bridge_ep and real_port->rmnet_mode are cleared, the mux
endpoint is removed, real_port->nr_rmnet_devs is decremented, and
rmnet_unregister_real_device() can call netdev_rx_handler_unregister() on
real_dev and free the port.

The precondition is the same one the patch assumes for changelink: the rmnet
device is created by an admin privileged in the real device's netns and then
moved into another netns, after which "ip link del rmnet0" from that netns
reaches the sequence above.

Deleting the bridge slave device looks similar:
rmnet_config_notify_cb() -> rmnet_force_unassociate_device() also calls
rmnet_unregister_bridge(port), which follows port->bridge_ep into the real
device's netns with no check against dev_net(real_dev).

If those paths stay ungated, is the net effect of the new check in
rmnet_del_bridge() limited to rejecting the clean IFLA_MASTER=0 unenslave,
while the commit message's statement that

  "A caller privileged only in the rmnet device's netns can therefore
   rewrite the shared cellular data-path state owned by another netns"

remains true for the teardown direction after the patch?

Teardown-on-delete is normal netdev lifecycle behaviour, and the vxlan/geneve
series cited in the commit message gated only changelink, so gating dellink
may not be the right fix.  Could the commit message state explicitly that the
dellink and notifier teardown paths are out of scope, so stable backporters
can judge the coverage?  The add direction, where bridge_ep is pointed at a
caller-owned device and rmnet_rx_handler() steers the real device's ingress
frames, does look closed by the rmnet_add_bridge() gate.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 4f0ddcedfa97..1f4a3246f254 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c

[ ... ]

> @@ -240,9 +242,23 @@ static int rmnet_set_coalesce(struct net_device *dev,
>  			      struct netlink_ext_ack *extack)
>  {
>  	struct rmnet_priv *priv = netdev_priv(dev);
> +	struct net_device *real_dev = priv->real_dev;
>  	struct rmnet_port *port;
>  
> -	port = rmnet_get_port_rtnl(priv->real_dev);
> +	/*
> +	 * The aggregation parameters live in the port attached to
> +	 * real_dev, which may reside in a different netns.  The ethtool

[Severity: Low]

This isn't a bug, but this block comment opens with a bare "/*" on its own
line, while the v4 changelog says "use the netdev comment style, per Subash
Abhinov Kasiviswanathan".

The three comments this patch adds to rmnet_config.c use the netdev form,
for example in rmnet_changelink():

	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),

and the existing comments in rmnet_vnd.c do too, for example above
rmnet_vnd_setup():

	/* Called by kernel whenever a new rmnet<n> device is created. Sets MTU,
	 * flags, ARP type, needed headroom, etc...
	 */

Note that checkpatch.pl in this tree has no networking block comment check,
so this is only an internal inconsistency with the rest of the patch and the
rest of the file.

> +	 * paths only require CAP_NET_ADMIN in dev's netns, so require it
> +	 * in real_dev's netns as well before mutating the shared port
> +	 * state.
> +	 */
> +	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Changing aggregation parameters requires CAP_NET_ADMIN in the real device network namespace");
> +		return -EPERM;
> +	}
> +
> +	port = rmnet_get_port_rtnl(real_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909080209.6348-1-suruurism%40gmail.com
