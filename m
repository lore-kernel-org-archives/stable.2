Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739440DB49;
	Thu, 17 Sep 2026 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678209; cv=none; b=ZNyjrn4a+BEebkk3UAx+FEkZ+DxJcJ7Ga007hFLA9LaHJgGfGXnuBVE+zpRmzmXIHqBJaZOvtqhRq6YPnoRa0ckZN4RSQINVJk//ymANcx6RwZqeFonGsSPVbdriWNKPzVJtn+jN2YHZ44BHzRRacR8sMs+WNIkMQ5NBoKk3E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678209; c=relaxed/simple;
	bh=3I67ru3zQ6JSYfl7FI9SD3hBhP7MbAKufd5kUe3hRFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=br2E9Whc2R2n9SCCV7N2Cnok93rX36FzZadSXgu/VB8VaqNStPckwpXdtrHXhcTsn95+8nTk1Fnp8gPc0Q4r57CdCzlLI0Rsu9jZFGEInwwNzqz+bRIYRsUfwg5zdBiIjzzM/bFmnkADcBWxFGS8ZgokDncof0ugxSLrReEGy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUihnvQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUihnvQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AB81F00893;
	Thu, 17 Sep 2026 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678206;
	bh=nTkTs7INuJGhkrArkZI4GklS4lL5iFoE1EJCsFhI22E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gUihnvQoUCYhNeNds6EwHbtB6HXVklmR2OeRHtpnRQWqk4qcpQO3+5dJYVC6AO8Q5
	 UHmyPGu//gdn31QNMqDUj2aek87axpqE02Nw799+bge9/ka2Ff2YpIpwpBEAMWsoAn
	 Ze4OrhZtSW0dx6gfRbsfFprhxrHNexNgQV0OMbObCtjlRzZWobQCJvhS72abWfBaQ8
	 8dY+WIAhPQ446WRVaMk9i1edeZNWUKfQU8dxUUYoAL0iPO15US1efPefSSliNH6AVd
	 ttZjxVREsjYD366cEBy9VXc4weIJrnLzt7SddR/y7s6c15phbcDQjdL11bln3UA+ly
	 GRehBBBToAO9Q==
Subject: Re: [PATCH] net: sxgbe: dispose IRQ mappings on device removal
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 siva.kallam@samsung.com, vipul.pandya@samsung.com, ks.giri@samsung.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 20:50:05 +0000
Message-ID: <178967820509.22033.14956659662376868592@kernel.org>
In-Reply-To: <20260916054841.2908429-1-lgs201920130244@gmail.com>
References: <20260916054841.2908429-1-lgs201920130244@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 2

- [Medium] The devres ordering guarantee claimed by the commit message
  can be violated by a probe/open race.
- [Low] Coding-style defects in the new code in sxgbe_platform_probe():
  the RX-queue devm_add_action_or_reset() call has a misaligned…
- [Low] All four newly added devm_add_action_or_reset() call sites in
  sxgbe_platform_probe() store the helper's return value in `ret` and…

Pre-existing issues:
- [High] Use-after-free window at unbind: every IRQ handler is installed
  with devm_request_irq(priv->device /* == &pdev->dev */, ...) in…
- [High] Unbalanced IRQ acquire/release across open/close: sxgbe_open()
  acquires all IRQs with devm_request_irq() but sxgbe_release()…
- [Medium] DT binding vs. driver mismatch for the LPI interrupt:
  Documentation/devicetree/bindings/net/samsung-sxgbe.txt documents…

--

net: sxgbe: dispose IRQ mappings on device removal

This converts the open-coded irq_dispose_mapping() unwind in
sxgbe_platform_probe() into a devres action registered right after each
irq_of_parse_and_map() call, so the common, TX, RX and LPI mappings are also
disposed when the device is removed after a successful probe.

A few questions on the new code and on the surrounding IRQ lifetime.

> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> index e4701b29e1a0f..cd8d39a1afff2 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c

[ ... ]

> @@ -116,6 +123,11 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
>  		goto err_drv_remove;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
> +				       (void *)(unsigned long)priv->irq);
> +	if (ret)
> +		goto err_drv_remove;
> +

[Severity: Low]

Is ret read anywhere after these assignments?  All four new
devm_add_action_or_reset() call sites in sxgbe_platform_probe() store the
return value and then jump to err_drv_remove, which falls through to:

err_drv_remove:
	sxgbe_drv_remove(priv->dev);
err_out:
	return -ENODEV;

devm_add_action_or_reset() returns -ENOMEM when the devres node cannot be
allocated, so a transient allocation failure is reported to the driver core
as -ENODEV, which is the same value used for an unparsable DT interrupt.

Would it make sense to return ret on the new paths?

>  	/* Get MAC address if available (DT) */
>  	of_get_ethdev_address(node, priv->dev);
>  
> @@ -124,38 +136,43 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
>  		priv->txq[i]->irq_no = irq_of_parse_and_map(node, chan++);
>  		if (priv->txq[i]->irq_no <= 0) {
>  			dev_err(dev, "sxgbe tx irq parsing failed\n");
> -			goto err_tx_irq_unmap;
> +			goto err_drv_remove;
>  		}
> +		ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
> +					       (void *)(unsigned long)
> +					       priv->txq[i]->irq_no);
> +		if (ret)
> +			goto err_drv_remove;
>  	}
>  
>  	for (i = 0; i < SXGBE_RX_QUEUES; i++) {
>  		priv->rxq[i]->irq_no = irq_of_parse_and_map(node, chan++);
>  		if (priv->rxq[i]->irq_no <= 0) {
>  			dev_err(dev, "sxgbe rx irq parsing failed\n");
> -			goto err_rx_irq_unmap;
> +			goto err_drv_remove;
>  		}
> +		ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
> +					       (void *)(unsigned long)
> +				       priv->rxq[i]->irq_no);
                                 ^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]

This isn't a bug, but the continuation line carrying priv->rxq[i]->irq_no is
indented with less whitespace than the identical TX call just above and does
not line up with the open parenthesis, so checkpatch reports "Alignment
should match open parenthesis" here.

In the hunk below, the blank line that separated the LPI interrupt handling
from platform_set_drvdata() is also dropped, so the new if (ret) goto
err_drv_remove; runs straight into platform_set_drvdata().

> +		if (ret)
> +			goto err_drv_remove;
>  	}
>  
>  	priv->lpi_irq = irq_of_parse_and_map(node, chan);
>  	if (priv->lpi_irq <= 0) {
>  		dev_err(dev, "sxgbe lpi irq parsing failed\n");
> -		goto err_rx_irq_unmap;
> +		goto err_drv_remove;
>  	}

[Severity: Medium]

This is a pre-existing disagreement and not something this patch introduces,
but since the LPI error path is being rewritten here it may be worth a look.

Documentation/devicetree/bindings/net/samsung-sxgbe.txt describes the
interrupts property as:

  index 1 to 25 - 8 variable transmit interrupts, variable 16 receive interrupts
  and 1 optional lpi interrupt.

A DT that follows that wording and omits the 26th specifier makes
irq_of_parse_and_map(node, chan) return 0, so probe logs "sxgbe lpi irq
parsing failed", calls sxgbe_drv_remove() and fails with -ENODEV.

sxgbe_open() on the other hand is written to cope with the LPI line not
being distinct:

	if (priv->lpi_irq != dev->irq) {

Which of the two is right, the binding or the mandatory treatment in probe?

> -
> +	ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
> +				       (void *)(unsigned long)priv->lpi_irq);
> +	if (ret)
> +		goto err_drv_remove;

[Severity: Medium]

Can the ordering guarantee in the changelog be broken by a probe/open race?

register_netdev() runs inside sxgbe_drv_probe(), which sxgbe_platform_probe()
calls before any of this IRQ setup:

	ret = register_netdev(ndev);
	if (ret) {
		pr_err("%s: ERROR %i registering the device\n", __func__, ret);
		goto error_mdio_unregister;
	}

So the interface is visible to userspace while the mappings and these new
dispose actions are still being registered.

If userspace brings the interface up in that window, sxgbe_open()'s
devm_request_irq() nodes land in the &pdev->dev devres list before the
still-pending dispose actions.  release_nodes() unwinds in reverse insertion
order:

list_for_each_entry_safe_reverse(dr, tmp, todo, node.entry)

which would run irq_dispose_mapping() for those IRQs before the devm
free_irq() that removes and synchronizes the handler on them.

In the same window, a failing devm_add_action_or_reset() immediately runs the
dispose action, tearing down a mapping on which a racing open may already
have installed a handler.

Would moving register_netdev() after the IRQ setup remove the need to rely on
devres insertion order here?

>  	platform_set_drvdata(pdev, priv->dev);
>  
>  	pr_debug("platform driver registration completed\n");
>  
>  	return 0;
>  
> -err_rx_irq_unmap:
> -	while (i--)
> -		irq_dispose_mapping(priv->rxq[i]->irq_no);
> -	i = SXGBE_TX_QUEUES;
> -err_tx_irq_unmap:
> -	while (i--)
> -		irq_dispose_mapping(priv->txq[i]->irq_no);
> -	irq_dispose_mapping(priv->irq);
>  err_drv_remove:
>  	sxgbe_drv_remove(priv->dev);
>  err_out:

[Severity: High]

This isn't a bug introduced by this patch, but it sits in the same IRQ
lifetime the changelog reasons about, so does the handler-versus-netdev
ordering also need attention?

sxgbe_open() installs every handler on the platform device with
device-lifetime devres, using the netdev or the queue structures as dev_id:

	ret = devm_request_irq(priv->device, priv->irq, sxgbe_common_interrupt,
			       IRQF_SHARED, dev->name, dev);

There is no free_irq() or devm_free_irq() anywhere in the driver, and
sxgbe_release() (ndo_stop) only stops the PHY, DMA and MTL.  The handlers
therefore stay installed until devres_release_all(), which the driver core
runs from device_unbind_cleanup() after .remove has returned:

drivers/base/dd.c:device_unbind_cleanup() {
	...
	devres_release_all(dev);
	...
}

By then sxgbe_platform_remove() -> sxgbe_drv_remove() has already done:

	kfree(priv->hw);

	free_netdev(ndev);

and priv, priv->txq[] and priv->rxq[] live in the netdev private area.  An
interrupt taken on one of those still-registered lines in that window (the
common and LPI lines are IRQF_SHARED, so a co-tenant device on the same line
is enough) enters:

	struct sxgbe_priv_data *priv = netdev_priv(netdev);
	int status;

	status = priv->hw->mac->host_irq_status(priv->ioaddr, &priv->xstats);

which reads priv->hw and writes priv->xstats in freed memory.  Should the
driver free and synchronize the IRQs before free_netdev()?

[Severity: High]

This is also pre-existing rather than something this patch changes, but it
follows from the same asymmetry: can the interface be brought up more than
once per bind?

sxgbe_open() requests the TX and RX DMA interrupts with flags 0:

		ret = devm_request_irq(priv->device,
				       (priv->txq[queue_num])->irq_no,
				       sxgbe_tx_interrupt, 0,
				       dev->name, priv->txq[queue_num]);

sxgbe_release() does not free them, and devres entries are only released at
unbind, so a second open re-requests a virq the driver already owns and
__setup_irq() takes the mismatch path:

kernel/irq/manage.c:__setup_irq() {
	...
		if (!((old->flags & new->flags) & IRQF_SHARED) ||
		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)))
			goto mismatch;
	...
}

so ip link set dev X down followed by ip link set dev X up returns -EBUSY,
after the shared common and LPI handlers have been installed a second time
as extra devres nodes.  Would releasing the IRQs in ndo_stop fix both this
and the free_netdev() ordering above?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916054841.2908429-1-lgs201920130244%40gmail.com
