Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD7406261;
	Fri, 11 Sep 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123752; cv=none; b=mHID9VKcjHQiYLbvjz7J3X6OReFkx9YnXOROa5FaP3Mx4r7+ZVuaupoMQlYfJskYQBY+JPsDiXnCFx9JcD2H6R+6qmgfBjQJ7UzfKzSh9y6826P9gj4uiotTTBJBv2Y/+0fk6oW3ZCL1bLLrZ+3+RtTDAZ2d8bsi6qzHOKstm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123752; c=relaxed/simple;
	bh=RwRtP4Lcq0BV+opg54mfK4Ls3dmbz/L53U9120/hdnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUks2GxXae6Kifq5nTKH4kriPN+XEGcFTsowBPZyVRlLIkCmBIw3DuDbv4SRp94Ygb3EdJphDLuJd9q4dXsXp/bTjMem90nQxG9MiaSzVqxNuhknxdeu9TkK/MGjPknUl3acHGOr9ceCnVlQXa0xAq2u7AdJmz+pV7wIsBQP/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuKqc86t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuKqc86t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AD71F00893;
	Fri, 11 Sep 2026 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123750;
	bh=45+Ft2ZAJDuHr7rFRHIETQgmiTQPSrUEooULEMW8brA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RuKqc86tYs/hwCpVsjKj2QXihaZ05u1oaWB2qbPumW4wzoQgevco56iZBiyyIlEYk
	 j3Oaxy60u6jsyAoNh70MG0FGm0zl9Ele7IBa7lxKCIMKkxD2pwCqtyKNnXFZVWsHqZ
	 qNe283slfFDxcAecXp4nD6PwzBkRecUMOW1Tpj9RVf4bPrHZGnyz5YQD6PDUW6zhrp
	 VXTPMGucithm/sb8ZAHlZaccSU9//9h32YqfR/FCaY2qby2OfQgfhVtSlLZGXmuR/x
	 2Tc8QD2fN9dQWoLxuH9ShWUxNdQt/CezWyeTU22TrlnGfb6x435Fauisg/0JXTNpRO
	 mnoLJLI9xHu2g==
Date: Fri, 11 Sep 2026 11:49:06 +0100
From: Simon Horman <horms@kernel.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	subash.a.kasiviswanathan@qualcomm.com, sean.tranchetti@qualcomm.com,
	dnlplm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v7] net: qualcomm: rmnet: require CAP_NET_ADMIN in
 the real device netns for config ops
Message-ID: <20260911104906.GC48209@horms.kernel.org>
References: <20260910082643.14437-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910082643.14437-1-suruurism@gmail.com>

On Thu, Sep 10, 2026 at 11:26:42AM +0300, Abdifatah Suruur wrote:
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
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
> v7:
> - state explicitly in the commit message that the dellink and notifier
>   teardown paths are out of scope, per the Sashiko review
> - drop the master-moved-into-the-real-device-netns rationale from the
>   rmnet_add_bridge() comment: on the add path do_set_master() resolves
>   the master in the slave's netns, so the rationale only applies to
>   rmnet_del_bridge(), where the master comes from
>   netdev_master_upper_dev_get()
> - use the netdev comment style in rmnet_set_coalesce(), per the
>   Sashiko review
> v6:
> - gate rmnet_add_bridge() and rmnet_del_bridge() on slave_dev, the
>   RTM_SETLINK target the caller was actually authorized against,
>   instead of rmnet_dev: a master moved into the real device's netns
>   short-circuits rtnl_dev_link_net_capable() through the net_eq()
>   check, so a caller only privileged in the slave's netns could
>   otherwise attach or clear the bridge state of the real device's
>   port
> - add the Fixes tag for the commit that introduced rmnet_set_coalesce()
> v5:
> - also gate rmnet_set_coalesce(), the ethtool setter that rewrites the
>   port aggregation parameters of the real device's port, per the
>   Sashiko review
> - report the new capability rejections through extack where available
> v4:
> - use the netdev comment style, per Subash Abhinov Kasiviswanathan
> v3:
> - cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
>   they mutate the same real-device port state via ndo_add_slave/
>   ndo_del_slave and have no capability check of their own
> - correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
>   real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
>   rmnet_vnd_change_mtu(), not on the real device
> v2:
> - drop Reported-by: (implied for the author), per Jakub Kicinski

Reviewed-by: Simon Horman <horms@kernel.org>

