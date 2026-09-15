Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394982AE7A;
	Tue, 15 Sep 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433752; cv=none; b=UulCIQ8iuWHpsNYFXY5xeRreMIZlqZH3GdCx9gnPKtxdFFGGSSQJ8+Ugc2jyQWfi7teT0o8kyPy9FhYLA7eRmKqRWaoFAKE8oMzYtQqfWLX2ovFNKkMn7NSC2iRJ0S63u/wUFHFIa7X/jF1JxWY/MlnL3bxH7kp0DflCWQaj7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433752; c=relaxed/simple;
	bh=z3tMke5E4wtzZ/Yebo9aQAWYtJvz2BzT1Nui1mbcpac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gj1gamhldKIgwIkKl8j1J9h/BZVw/ZgKyxsr5ktYlYQVcW3UDtxSdCR1wxPoJEK/586OcIIc9xowNziaMF03YJfG+qMHtownUknnY8aPx8ucWecaR4//9BfVla0fSqxMKpgJEXuvbZCXs9l/FCftKt5dXfz0T8WjpqOm7aLSDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCYAIz/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCYAIz/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9056A1F000FF;
	Tue, 15 Sep 2026 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789433750;
	bh=1cxApxyp/D6KXegiU2EYaYMdphfxzvIlPfz2MbfxpmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GCYAIz/mv2I9KUPeX5NF+Kqr+XLjFVQGH2edsrNusvGHfhS88+hagBQE9LEEYLoO/
	 hZVs4OYcOKYd/1POPUEX8ji8r0cQ+9iORQe0nB68dH8vRIkIw7Z1A2WbMh0F7T+5g4
	 cXKOCKexT44rhrhNGvgIbP9Vma9LRy+eh8iV7R/1TxCT3i1t89QtoQfbK1UZ4U2/ic
	 EiXkVZqanVC1B0KCxarBfXYNqTREY9p5n9JAznUyksHrZxJzdj3Kf2JtuCOpR24QPk
	 DhigidB/y7Hy5YVYctv59ay1smU5fZlbUO1kn1AVWibAzZWgRevExBaMs6NJEutr3G
	 Xx2cqnBSxjIMw==
Date: Mon, 14 Sep 2026 17:55:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, subash.a.kasiviswanathan@qualcomm.com,
 sean.tranchetti@qualcomm.com, dnlplm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v7] net: qualcomm: rmnet: require CAP_NET_ADMIN in
 the real device netns for config ops
Message-ID: <20260914175550.4889da87@kernel.org>
In-Reply-To: <20260910082643.14437-1-suruurism@gmail.com>
References: <20260910082643.14437-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:26:42 +0300 Abdifatah Suruur wrote:
> An rmnet device may be created with its real device in a different
> netns than the rmnet device itself (rmnet_newlink() resolves it in
> link_net), and the config paths below only check CAP_NET_ADMIN against
> dev_net(dev), while mutating rmnet port state attached to the real
> device:
> 
> - rmnet_changelink() rewrites the endpoint mux table and
>   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
>   MTU of the rmnet endpoint netdevs.
> - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
>   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
>   port->rmnet_mode and port->bridge_ep on the real device's port; with
>   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
>   forwards real-device ingress frames to it.
> - rmnet_set_coalesce() rewrites the port aggregation parameters via
>   ETHTOOL_SCOALESCE (ioctl) or ETHTOOL_MSG_COALESCE_SET (netlink),
>   whose capability checks likewise only cover dev's netns.
> 
> A caller privileged only in the rmnet device's netns can therefore
> rewrite the shared cellular data-path state owned by another netns, and
> steer its ingress traffic.
> 
> Gate the rtnl paths with rtnl_dev_link_net_capable(), matching the
> "require CAP_NET_ADMIN in the device netns for changelink" series
> (vxlan/geneve, CVE-2026-68432), and gate the ethtool setter with
> ns_capable() in the real device netns, mirroring the check dev_ethtool()
> already applies to dev's netns.  Report the new rejections through
> extack where one is available.
> 
> The gates cover the configuration paths only.  Teardown (RTM_DELLINK
> reaching rmnet_dellink(), and rmnet_config_notify_cb() unregistering
> the bridge when the slave device is deleted) is intentionally left
> ungated: link deletion is normal netdev lifecycle behaviour, and the
> changelink series this matches (vxlan/geneve, CVE-2026-68432) gated
> only the configuration paths.
> 
> Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
> Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
> Fixes: db8a563a9d9024 ("net: qualcomm: rmnet: add ethtool support for configuring tx aggregation")
> Cc: stable@vger.kernel.org

Please drop the Fixes and stable tags, it's not that deep.

> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */

Please drop all these slop comments.

> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Changing the port settings requires CAP_NET_ADMIN in the real device network namespace");

way too long, how about:

	NL_SET_ERR_MSG_MOD(extack, "request modifies device in another netns");

in all the extacks.
-- 
pw-bot: cr
