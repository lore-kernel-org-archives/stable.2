Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826D383C6E;
	Thu,  3 Sep 2026 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477882; cv=none; b=tUWcl8DN7CKCO/GXwaLpfwTj9/VGNbu5Bud2cjwPkJZVKjareV1rYB6PhM5TvN8/s6xgaF2HNaKEnlH7XWK/9vzByALv+Ai4SlzaUNdF+rwUByKwIhX9a4uAgQ3c+yO9nnbxM55+rF0Vcc7+iYbPSe/J7bHo5a88jrpKnWbYJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477882; c=relaxed/simple;
	bh=I8vK/xnJwji/H+K76XKA6oGWu4PVuJJ/rWaRqqzSn7E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCWqvtp/7M7GdKQ5thKVp2GWzLaDAW6yfr7tVFyBX8+QO7xhTwIQRErp4QrF0fSYeEPjNafcWqBMeFCrnHuZEn9wpQjyrpATcmGF/0K7LhPppZUrAwM66Nz5fcC/B4LdH1rYkdCPoIivP0YFNUUkMy57WBFvapGdGwNNsC0PF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsxcrze/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsxcrze/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770A61F00A3F;
	Thu,  3 Sep 2026 23:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477880;
	bh=zFT2zUt53aUu7qGPcRXVpBNsjYv+H5a81LT2gMX200M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hsxcrze/yDEVWvpMmH/CbDglq/W0G72xVPVFkM1FGjqvfu24l0imp6TQFvZyDnRWQ
	 ir73H6vqi7b054rAUuepPYILL3EndVbVlh8RXngxkVrN087Ski0Xl5AM1WKEUHEiQs
	 nVZ1kxYjBA9neExyGLTq+1btJezhSq3ZnvWBcZm+eC5UBA+TzSa1Z1Fm7jIzigBdd7
	 IQt7v7xRXlRYfWWcJUD1AZWsVJXlDszCfR7N+KdjF34B6wDAJJFQgaZLxGdtgtUj82
	 HBGaycSET7hbbFME/3Ujmy7H0Amwx9SSDhXrJNxb7g1BUU3rmeHbjWRSwt+o+sWjwa
	 ctFYVPblnmIhQ==
Subject: Re: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for config ops
From: netdev-bot+sashiko@kernel.org
To: suruurism@gmail.com
Cc: subash.a.kasiviswanathan@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sean.tranchetti@oss.qualcomm.com,
 horms@kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 03 Sep 2026 23:24:39 +0000
Message-ID: <178847787997.4131868.406911054016867942@kernel.org>
In-Reply-To: <20260901081441.632-1-suruurism@gmail.com>
References: <20260901081441.632-1-suruurism@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] Incomplete cross-netns authorization: the ethtool coalesce
  setter rmnet_set_coalesce()…
- [Low] The two new -EPERM returns that have an extack available carry no
  extended ACK message.

--

net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for
config ops

This adds an rtnl_dev_link_net_capable() gate to rmnet_changelink(),
rmnet_add_bridge() and rmnet_del_bridge() so that a caller privileged only
in the rmnet device's netns cannot rewrite the rmnet port state attached to
a real device living in another netns.  Two observations below on the set
of paths covered and on the error reporting.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf25..5d0a4a428e97a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
>  
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +		return -EPERM;
> +

[Severity: High]
Is the ethtool coalesce setter intentionally left out of this series?

rmnet_set_coalesce() in rmnet_vnd.c reaches the same shared port through
the rmnet device and rewrites it, with no netns check:

drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c:rmnet_set_coalesce() {
	struct rmnet_priv *priv = netdev_priv(dev);
	struct rmnet_port *port;

	port = rmnet_get_port_rtnl(priv->real_dev);

	if (kernel_coal->tx_aggr_max_frames < 1 || kernel_coal->tx_aggr_max_frames > 64)
		return -EINVAL;

	if (kernel_coal->tx_aggr_max_bytes > 32768)
		return -EINVAL;

	rmnet_map_update_ul_agg_config(port, kernel_coal->tx_aggr_max_bytes,
				       kernel_coal->tx_aggr_max_frames,
				       kernel_coal->tx_aggr_time_usecs);
}

rmnet_map_update_ul_agg_config() then stores into the real device's port:

	spin_lock_bh(&port->agg_lock);
	port->egress_agg_params.bytes = size;
	WRITE_ONCE(port->egress_agg_params.count, count);
	port->egress_agg_params.time_nsec = time * NSEC_PER_USEC;
	spin_unlock_bh(&port->agg_lock);

The authorization on that path is only against the netns the rmnet device
was addressed through: dev_ethtool() checks
ns_capable(net->user_ns, CAP_NET_ADMIN), and ETHTOOL_MSG_COALESCE_SET is
registered with GENL_UNS_ADMIN_PERM.  Neither consults
dev_net(priv->real_dev).

Can that value also stop the uplink traffic of the other netns?
tx_aggr_max_bytes == 0 with tx_aggr_max_frames >= 2 passes the validation
above, and the aggregation path in rmnet_map_tx_aggregate() then computes:

		size = port->egress_agg_params.bytes - skb->len;

		if (size < 0) {
			/* dropped */
			spin_unlock_bh(&port->agg_lock);
			return 0;
		}

which is taken for every nonempty packet on that port, for all endpoints
muxed on the real device, and is turned into -ENOMEM by
rmnet_map_egress_handler().

Would it make sense to add the same
rtnl_dev_link_net_capable(dev, dev_net(priv->real_dev)) gate to
rmnet_set_coalesce() with a Fixes: tag for the coalesce support commit, or
alternatively to note in the changelog why this op is excluded?

>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	if (data[IFLA_RMNET_MUX_ID]) {
> @@ -441,6 +448,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>  
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +

[Severity: Low]
This isn't a bug, but should these two -EPERM returns carry an extack
message?  Both rmnet_changelink() and rmnet_add_bridge() get a
struct netlink_ext_ack *extack and already describe every other failure
that way, for example "MUX ID already exists", "Invalid MTU on real dev",
"more than one rmnet dev attached", "more than one bridge dev attached" and
"slave cannot be another rmnet dev", while the new capability failure
returns a bare -EPERM.

The equivalent gate in macvlan does report it, in both
macvlan_common_newlink() and macvlan_changelink():

drivers/net/macvlan.c:macvlan_changelink() {
	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
		NL_SET_ERR_MSG(extack,
			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");
		return -EPERM;
}

rmnet_del_bridge() has no extack argument, so only the changelink and
add_bridge sites can do this without a signature change.

>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	/* If there is more than one rmnet dev attached, its probably being

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901081441.632-1-suruurism%40gmail.com
