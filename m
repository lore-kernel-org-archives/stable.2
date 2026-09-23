Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA259378D8D;
	Wed, 23 Sep 2026 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136621; cv=none; b=QnoJhYHOceAtiC2QxQcdGXOCFiG/FfNX6SH4SKN8dTms8nBR2ufDF2jiU/UD6bdbx4pEM3UD+hdvGv3K4Vg/bDJh5y41jGkFF5pf33xkTr15CgnLdnJvHCJuFRrmLBaG8TAOKNe/n1Q3YMdJZ4UTGDSAzGJbNuolrBpIJ1DeyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136621; c=relaxed/simple;
	bh=rrxEAGMbPQ318P3iSo+uv96jhQvKkno4sujQGu01i7E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYXi0lSvPQGrDs1p3quBTJoIIp70ZYFb0AcnsIrtdofNJlcI96bBgT+Gs3sJ1aBaZ1VLEyo3/qnodn8d5PtNwsl8764fYwc550KVXiRrWYhsi5b7PxVBJb5CEfxclWTjb9JjPxJ1Be+Q3KD9wEhpLcMIqk+gQLzf9dxwIybWFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0oSiwU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0oSiwU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53861F000FF;
	Wed, 23 Sep 2026 04:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790136619;
	bh=TalEhPCTxDw2gAV04MyEcBeXwpAPmQ1zF9G931nlQAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R0oSiwU1+Z6deyEq62fywJOP7g01d33L06LMptLSCK4udXX4/Ru36533HnBeXu+Xx
	 YUUcr+30iwost2RrEUT+QXNxzT+M5erATxqLcHICe41Inv73Q9KijlNNM+Mk6pnu1d
	 XmAdM2yRFS0DbsOO2F4oATE1fM7hNpLtices+2sd/EZ0mCmxlVPmLxwqiUyMEoxMy5
	 UWLm1denyWWTV1ixFQejyJbwXMh/sjnx4J/GMY4fBGRKqb7tWNoLCgH0rV8005Q3fV
	 WhsnhOm8epdNYJ1vRatrLwLSXc04gqTwH0fpTtcdcaIPQDn5SUq4AZ+CJohdX1nVlx
	 Kzg6eZW2r5PPA==
Subject: Re: [PATCH] net: bcmasp: fix MDIO child device leaks
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 23 Sep 2026 04:10:18 +0000
Message-ID: <179013661830.2160803.12247956687269166300@kernel.org>
In-Reply-To: <20260921130929.403129-1-lgs201920130244@gmail.com>
References: <20260921130929.403129-1-lgs201920130244@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The newly added of_platform_depopulate(&pdev->dev) in
  bcmasp_remove() (bcmasp.c:1388) runs after bcmasp_remove_intfs(), i.e.…

Pre-existing issues:
- [High] priv->intfs is traversed from the hardirq handler bcmasp_isr()
  (bcmasp.c:101-122) with list_for_each_entry() and no lock or RCU…
- [Medium] bcmasp_probe() calls of_find_node_by_name(dev->of_node,
  "ethernet-ports") without first taking a reference on dev->of_node.
- [Medium] bcmasp_interface_create() stores the reference returned by
  of_parse_phandle(ndev_dn, "phy-handle", 0) in intf->phy_dn…
- [Low] bcmasp_init_wol() calls device_set_wakeup_capable(&pdev->dev, 1)
  (bcmasp.c:1123), which sets dev->power.can_wakeup and merges the…

--

net: bcmasp: fix MDIO child device leaks

This adds an err_depopulate label to bcmasp_probe() so that failures
occurring after of_platform_populate() call of_platform_depopulate(), and
adds the same call to bcmasp_remove(). A few probe error gotos are
retargeted from err_clock_disable to the new label.

A few questions about the surrounding code below.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6bc..c4087408a8228 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c

[ ... ]

> @@ -1327,7 +1327,7 @@ static int bcmasp_probe(struct platform_device *pdev)
>  	if (!ports_node) {
>  		dev_warn(dev, "No ports found\n");
>  		ret = -EINVAL;
> -		goto err_clock_disable;
> +		goto err_depopulate;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but since the error handling of
this exact block is being reworked, does the lookup just above it drop a
reference the driver never took?

bcmasp_probe() does:

	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");

and of_find_node_by_name() ends with an unconditional put on its "from"
argument:

drivers/of/base.c:of_find_node_by_name() {
	...
	for_each_of_allnodes_from(from, np)
		if (of_node_name_eq(np, name) && of_node_get(np))
			break;
	of_node_put(from);
	...
}

So every probe, successful or not, appears to release one reference on the
controller's own OF node. On CONFIG_OF_DYNAMIC=y, repeated bind/unbind would
then reach of_node_release() on a node without OF_DETACHED, which prints
"ERROR: of_node_release() detected bad of_node_put()" with a stack dump.

The same helper also walks the flattened all-nodes list rather than only the
children of dev->of_node, so a match outside this controller's subtree can be
returned. Would of_get_child_by_name() be the right API here, with the
matching of_node_put() as today?

> @@ -1369,6 +1369,8 @@ static int bcmasp_probe(struct platform_device *pdev)
>  
>  err_cleanup:
>  	bcmasp_remove_intfs(priv);
> +err_depopulate:
> +	of_platform_depopulate(dev);
>  err_clock_disable:
>  	clk_disable_unprepare(priv->clk);

[Severity: Medium]
This is a pre-existing issue, but while this epilogue is being extended, does
the interface teardown it invokes leak the PHY OF node?

bcmasp_interface_create() stores an acquired reference:

	intf->phy_dn = of_parse_phandle(ndev_dn, "phy-handle", 0);
	if (!intf->phy_dn && of_phy_is_fixed_link(ndev_dn)) {

and the only two exits from the interface lifetime never release it. The
creation failure paths only free the netdev, and normal teardown does:

drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c:bcmasp_interface_destroy() {
	if (intf->ndev->reg_state == NETREG_REGISTERED)
		unregister_netdev(intf->ndev);
	if (of_phy_is_fixed_link(intf->ndev_dn))
		of_phy_deregister_fixed_link(intf->ndev_dn);
	free_netdev(intf->ndev);
}

of_phy_connect() does not consume the caller's reference, so every
external-PHY port would leak one device_node reference per probe/remove
cycle. Note that in the fixed-link case intf->phy_dn is set to the borrowed
ndev_dn pointer instead of a newly acquired reference, so a fix would have to
skip the put there.

[Severity: Low]
This is a pre-existing issue as well, but is the wakeup capability set
earlier in probe ever reversed?

bcmasp_init_wol() does:

	priv->wol_irq = irq;
	priv->wol_irq_enabled_mask = 0;
	device_set_wakeup_capable(&pdev->dev, 1);

That runs before the ethernet-ports lookup, so both the new err_depopulate
path and err_cleanup leave the platform device advertising wakeup capability
with no driver bound; bcmasp_remove() does not clear it either. Should
device_set_wakeup_capable(&pdev->dev, 0) be paired with this on the error
epilogue and on remove?

> @@ -1383,6 +1385,7 @@ static void bcmasp_remove(struct platform_device *pdev)
>  		return;
>  
>  	bcmasp_remove_intfs(priv);
> +	of_platform_depopulate(&pdev->dev);
>  }

[Severity: Medium]
Is this depopulate running with the ASP clock gated? The matching populate in
bcmasp_probe() is deliberately inside the clk_prepare_enable() window:

	/* Enable all clocks to ensure successful probing */
	...
	/* Register mdio child nodes */
	of_platform_populate(dev->of_node, bcmasp_mdio_of_match, NULL, dev);

and the new probe-side call added by this patch is likewise above
err_clock_disable. Here, though, bcmasp_remove_intfs() has already run
unregister_netdev() for every port, so the per-interface
clk_prepare_enable()/clk_disable_unprepare() pairs from ndo_open/ndo_close
are balanced and probe ended with clk_disable_unprepare(priv->clk).

The child being destroyed is the UniMAC MDIO block, whose register window is
a sub-range of the ASP block and which has no clocks property of its own
(binding example: mdio@c614 reg = <0xc614 0x8>), so mdio-bcm-unimac's
priv->clk is NULL and all of its MMIO depends on the parent sw_asp clock.

Any MDIO transaction issued during child teardown would then hit a gated
register block, for example:

bcmasp_remove()
  of_platform_depopulate()
    of_platform_device_destroy()
      device_del()
        unimac_mdio_remove()
          mdiobus_unregister()
            phy_device_remove() -> device_del() -> phy_remove()
              phy_leds_unregister() -> led_classdev_unregister()
                led_set_brightness(led_cdev, LED_OFF)
                  bcm_phy_led_brightness_set()
                    unimac_mdio_write()

PHY driver .remove() callbacks (mscc, marvell10g, nxp-c45) are a similar
path. Would bracketing the teardown the same way the populate is bracketed be
appropriate?

	clk_prepare_enable(priv->clk);
	of_platform_depopulate(&pdev->dev);
	clk_disable_unprepare(priv->clk);

[Severity: High]
This isn't a bug introduced by this patch, but the patch extends this
teardown sequence, so: is priv->intfs safe to mutate here while the ASP L2
interrupt handler is still installed?

The hardirq handler walks the list with no lock and no RCU:

drivers/net/ethernet/broadcom/asp2/bcmasp.c:bcmasp_isr() {
	...
	/* Handle intferfaces */
	list_for_each_entry(intf, &priv->intfs, list)
		bcmasp_intr2_handling(intf, status);
	...
}

and the teardown called just above the new depopulate deletes and frees
entries from process context:

bcmasp_remove_intfs() {
	list_for_each_entry_safe(intf, n, &priv->intfs, list) {
		list_del(&intf->list);
		bcmasp_interface_destroy(intf);
	}
}

Neither bcmasp_remove() nor bcmasp_shutdown() calls
bcmasp_intr2_mask_set_all() or frees priv->irq before this, and the
devm_request_irq() resource is only released after remove() returns. On a
multi-port device (or on the register_netdev() failure path, where earlier
ports are already visible to userspace and may have been brought up), port N
can have RX/TX interrupts unmasked via bcmasp_enable_rx_irq() /
bcmasp_enable_tx_irq() while port 0 is being destroyed.

Can a handler that is mid-walk then read LIST_POISON1 from intf->list.next,
or dereference intf->ndev->phydev in bcmasp_intr2_handling() after
free_netdev()? Would masking intr2 and synchronizing the IRQ before touching
the list close that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921130929.403129-1-lgs201920130244%40gmail.com
