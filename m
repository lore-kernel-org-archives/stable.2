Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347405;
	b=Lhvrq/pYA9Vic7+JLNUeAv5jng1hE+QhzDh//+Y6OVhnaOgak0ISBsGeGagGtgN/KRL6
	 AoJngbSH9qexCZGsby2NXHIW/y7y3d8MceUmE0XVBxnTsjYO6KzKuiXmOUH+/LHdanXCX
	 pLl00jttrs+/IediCm6Af+XAA7gRIyaVx7sr4ue/OsvUytqeFmdcOolK0cz1hGsXWOtdC
	 nPyYQDtH3dXkEd0AwLx6HA/cQPcKaDOokng1FwNjB3CeV1VmhKDGPGjNgBohHFTP2KSk6
	 ElbbW+KNAF0HiLq0JuDJbAqR/8u3xpQ+o2nlejpERpoEUULo6RdFLGDzu28MZmJfd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347405;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YJJfXC5ueSmApARbmgN+bIycFhSEHL95Tjj8W+dEiUc=;
	b=IT/lSgAoimhwh2+Bd0oFoKHY6LrYY5eNp/xl2foM1OYZwCA1WnxjiVBNRKWgLJVybFnz
	 m4M7iH9h64wOq/Tmlaxkdu2RMvcLdDLu/JjHYUBTZzZBTg7W1yjgXO6ut1iZtKna07/do
	 6lroBbNIbYDZhnFZZihWBTQMpgMgzCNECLxfEsINWUB9DnJ6xt21wWTlCReWfva49EzAd
	 G2VSpBl4CjDQ9h27SI0aIExfd3TMdIQ9TwsK4U6ol/1NNR2xsytykZAuNQ+YOeOB4PnMa
	 vXJ+fGRHsQ9hfB7sqtCrOGDDzfSJjs4T12gtXYgOKCmcvdKkRYmxhqt7UqgEBRt+kCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItCr9aR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAC606A31C;
	Fri, 30 Oct 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItCr9aR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6601F000C1;
	Fri, 30 Oct 2026 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347405;
	bh=YJJfXC5ueSmApARbmgN+bIycFhSEHL95Tjj8W+dEiUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ItCr9aR7/sDs54F65dtn/l5KvGDVP3wiIxh6cfhXrqtjEo9l1rBZU+tflioAtpkTV
	 pMQsTDGgoQBK36jmz9+FI70LZmMrc/4WMZaY2KfTZ7uq0wFFHXoWIKwdPMIpyka7Ax
	 X2XHSHOgbDSHML6Gp++PPylOVLUYQD7zmMYINEBheIdi1+TmtmqU5I6NkIFZZ4bfcW
	 U0Ks1gfSTGsoCvatL0W0T42gs5EYXUn+Qu5RpunhqKDlgjCReF+L78ySwpkFibZNmb
	 BGcB0TGLUOROPOd9j8XMajLhs/3AtItyKZvvo76nsHr+mvo/Y4JmW8Jt6acoyz5U4w
	 VSg0HQfLT5/XQ==
Subject: Re: [PATCH] net: phy: only remove owned topology entries
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: maxime.chevallier@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 30 Oct 2026 08:03:23 +0000
Message-ID: <179334740382.3134.15496907149210495059@kernel.org>
In-Reply-To: <20261028050312.126508-1-yaojiale02@163.com>
References: <20261028050312.126508-1-yaojiale02@163.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is titled "only remove owned topology entries", but it
  only adds the ownership check to phy_link_topo_del_phy().

--

net: phy: only remove owned topology entries

This commit adds an ownership check to phy_link_topo_del_phy(). The PHY
entry and its ports are now removed only when the entry at phy->phyindex
belongs to the PHY being detached. It covers the case where
phy_link_topo_add_phy() fails because the saved index is already in use,
and the attach error path then runs the normal detach code.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 214ccce23cf69..175eef44cf545 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -185,6 +185,10 @@ void phy_link_topo_del_phy(struct net_device *dev,
>  	if (!topo)
>  		return;
>  
> +	pdn = xa_load(&topo->phys, phy->phyindex);
> +	if (!pdn || pdn->phy != phy)
> +		return;
> +

[Severity: High]
Does this cover every topology entry the detach path removes? The caller
still removes the module port with no ownership check, right after this
function returns:

drivers/net/phy/phy_device.c:phy_detach_internal() {
    ...
		phy_link_topo_del_phy(dev, phydev);
		if (phydev->mod_port)
			phy_link_topo_del_port(dev, phydev->mod_port);
    ...
}

phy_link_topo_del_port() erases whatever is stored at port->id:

drivers/net/phy/phy_link_topology.c:phy_link_topo_del_port() {
    ...
	xa_erase(&topo->ports, port->id);
}

Like phyindex, port->id is kept after removal and reused when the port is
added again. A stale id can collide in the new topology:

drivers/net/phy/phy_link_topology.c:phy_link_topo_add_port() {
    ...
	if (port->id)
		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
    ...
}

Suppose a PHY's mod_port got its id while the PHY was attached to netdev
A, and the PHY is later attached to netdev B. There seem to be two ways
phy_attach_direct() reaches its error label and then calls
phy_detach_internal():

  phy_attach_direct()
    phy_link_topo_add_phy()    -> -EBUSY, saved phyindex is used in B
    goto error
      phy_detach_internal()
        phy_link_topo_del_phy()   -> now returns early
        phy_link_topo_del_port(dev, phydev->mod_port)
          xa_erase(&topo->ports, port->id)

In this first case, which is the scenario from the commit message,
mod_port was never inserted into B's topology. Can the xa_erase() then
drop some other port of B that happens to sit at the same id?

  phy_attach_direct()
    phy_link_topo_add_phy()    -> succeeds
    phy_link_topo_add_port(dev, phydev->mod_port)
                               -> -EBUSY, another port of B owns the id
    goto error
      phy_detach_internal()
        phy_link_topo_del_port(dev, phydev->mod_port)
          xa_erase(&topo->ports, port->id)

In the second case, is the other port's entry removed the same way?

In both cases an entry this PHY does not own is removed from the topology,
which is the problem the subject line says is fixed.

Would it be better to put the ownership check in phy_link_topo_del_port()
itself? For example, erase only when xa_load() returns this port, or use
xa_cmpxchg(&topo->ports, port->id, port, NULL, ...). That would cover
every caller, including the ports loop in phy_link_topo_del_phy().

Another option is for the attach error path to skip removing mod_port
when it was never inserted.

>  	list_for_each_entry(port, &phy->ports, head)
>  		phy_link_topo_del_port(dev, port);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028050312.126508-1-yaojiale02%40163.com
