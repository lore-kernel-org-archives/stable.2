Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFC1AC45D;
	Wed,  9 Sep 2026 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924824; cv=none; b=fmzdhSgzkMAszLKh/6+iqbjxmMLXNAd4eU8I3GuLPToIAmbYN4+vhmQrTDVi1Y3gHtI7STcIMwtqhyVH3fLmlY6VW8NwgTLHAQunLN31ENM6yAplJHtOGWjrjwhrjSFJh19VUspd1p7+P0RVpQqoNfvo6pSeBxb9CoFfDKKMHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924824; c=relaxed/simple;
	bh=DK4mu0Pw63e7p6zXsrdju4CFT92z1jrU6cbBAv3Y8WA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9howUIJ47KMSiehJKkX7fYB5LgstuubwLn0ptKGOgGBmI205Az/BFiF/d56wQM0HoMNuctc/dEm5hylp1yASGgwHaovXuVP3wzT31MvV3qiq2yHkVlnoVIguabZyvCsqJ/FcTW56KYosWhvIKqL1es569GsZM38wS+V4XSBKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAa1XXF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAa1XXF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3A81F00A3A;
	Wed,  9 Sep 2026 03:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924822;
	bh=gtFVeXUnNggdSWp9zATWwhd8DT2Rx8+SpBMIHiPNWHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IAa1XXF5USrr8RrgN6N4Lfkv+uopaJMh3lbV5mM9q+fndSyq179o/Gs1P3M/lcQSj
	 Ych9YRbFedp7r88NZQQwvpchanaJvf0u/42DHxSc9wMEnDpWAdGb4rrmIW4wfFkXGG
	 c+vmctIMiv5pbggof0nRkdCSuBaU5oncC4vHI2slBGgMyDblEq6ud1jVp8rZ1iJCF+
	 Qtg3oG42K+a+hTg/m5UgCKlJJMsE+Zr4ThxYepGzgzTEr+J2ww7sLz0vvWhndz/LXD
	 /lp2aeGnAbAIjdwblEGkZtdV8/hjLp0RzCLfzjp8RATx2ZGFOoFryTcK7Wq62dCSys
	 iOLn5cstl0Eaw==
Subject: Re: [PATCH net v5] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for config ops
From: netdev-bot+sashiko@kernel.org
To: suruurism@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 subash.a.kasiviswanathan@oss.qualcomm.com, sean.tranchetti@oss.qualcomm.com,
 horms@kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 09 Sep 2026 03:33:41 +0000
Message-ID: <178892482172.219967.16107253647054145522@kernel.org>
In-Reply-To: <20260906123212.10829-1-suruurism@gmail.com>
References: <20260906123212.10829-1-suruurism@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Wrong device passed to the netns gate on the ndo_del_slave
  path.
- [Low] Missing Fixes: tag for the third fixed site.

--

net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops

This adds capability checks in the real device's netns to three rmnet
config paths: rmnet_changelink() and the bridge add/del paths get
rtnl_dev_link_net_capable(), and rmnet_set_coalesce() gets an explicit
ns_capable() test.  Rejections are reported through extack where one is
available.

A couple of questions below.

> Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
> Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
> Cc: stable@vger.kernel.org

[Severity: Low]
The commit message enumerates three defective config paths, and the v5
changelog says the rmnet_set_coalesce() gate was added in this revision,
but only two Fixes: tags are present.

rmnet_set_coalesce() and the ETHTOOL_COALESCE_TX_AGGR interface it uses
came in with db8a563a9d9024 ("net: qualcomm: rmnet: add ethtool support
for configuring tx aggregation") in v6.3, so neither tag covers the
rmnet_vnd.c hunk.

With Cc: stable present, the oldest tag (60d58f971c1077, 2017) points
stable tooling at branches where rmnet_set_coalesce() does not exist and
the rmnet_vnd.c hunk cannot apply.  Would it make sense to add:

  Fixes: db8a563a9d9024 ("net: qualcomm: rmnet: add ethtool support for configuring tx aggregation")

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf25..7757fcb2fcc9f 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c

[ ... ]

> @@ -441,6 +451,16 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>  
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Attaching a bridge device requires CAP_NET_ADMIN in the real device network namespace");
> +		return -EPERM;
> +	}
> +
>  	port = rmnet_get_port_rtnl(real_dev);
>  
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +509,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but rmnet_unregister_bridge() below clears the bridge state of
> +	 * the real device's port, which may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port = rmnet_get_port_rtnl(slave_dev);
>  
>  	rmnet_unregister_bridge(port);

[Severity: Medium]
Should the first argument here be slave_dev rather than rmnet_dev?

rtnl_dev_link_net_capable() short-circuits when the device passed as dev
already lives in link_net:

net/core/rtnetlink.c:rtnl_dev_link_net_capable() {
	return net_eq(link_net, dev_net(dev)) ||
	       ns_capable(link_net->user_ns, CAP_NET_ADMIN);
}

so the dev argument has to be the device whose netns the rtnl core
already required CAP_NET_ADMIN for.  For ndo_add_slave/ndo_del_slave that
is the RTM_SETLINK target, i.e. slave_dev, not the master:

net/core/rtnetlink.c:do_set_master() {
	struct net_device *upper_dev = netdev_master_upper_dev_get(dev);
	...
		err = ops->ndo_del_slave(upper_dev, dev);
	...
		upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
		...
		err = ops->ndo_add_slave(upper_dev, dev, extack);
}

On the add path the master is re-resolved with
__dev_get_by_index(dev_net(dev), ifindex), so dev_net(rmnet_dev) equals
dev_net(slave_dev) and the two spellings happen to agree.  On the del path
upper_dev comes from the existing adjacency with no netns re-check, so
rmnet_dev can be in a different netns than slave_dev.

If rmnet_dev sits in real_dev's netns while slave_dev lives elsewhere,
does net_eq(dev_net(rmnet_dev), dev_net(real_dev)) make the new gate pass
without checking any capability, even though the caller was only
authorized against dev_net(slave_dev)?  rmnet_del_bridge() then goes on to
clear real_port->bridge_ep and real_port->rmnet_mode via
rmnet_unregister_bridge() and unregisters the slave port.

That topology looks constructible: rmnet_vnd_setup() does not set
netns_immutable, __dev_change_net_namespace() has no upper/lower device
restriction and preserves adjacencies, and rmnet_config_notify_cb() only
acts when rmnet_is_real_dev_registered(dev), so moving the rmnet device
into real_dev's netns leaves the master/slave link intact.

Passing slave_dev on both paths would keep the two sites consistent and
match what the core actually authorized.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 4f0ddcedfa979..1f4a3246f254a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c

[ ... ]

> @@ -240,9 +242,23 @@ static int rmnet_set_coalesce(struct net_device *dev,
> +	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Changing aggregation parameters requires CAP_NET_ADMIN in the real device network namespace");
> +		return -EPERM;
> +	}
> +
> +	port = rmnet_get_port_rtnl(real_dev);

This is the hunk referred to in the Fixes: tag question above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906123212.10829-1-suruurism%40gmail.com
