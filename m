Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC3438024;
	Thu, 17 Sep 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682019; cv=none; b=oNcofWVj2lNzh1keLu+JoC1VHigZaH604lmj1kn7VU1ZOX8xQ58P4ypMFmqlR+MWEZ1VOYyz4U8So2HIBVIb4McyrOr86sVx9zihpxqV95xe2WAGl7YuCKop0cx/OSzwNNhYjYIikfrtV/5YREe32tuMD6uHp7k70bUyI8mFYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682019; c=relaxed/simple;
	bh=H8XrNH+fUEw3blgIV6Nt1R8Z2HHWIsq9siATBTEbpTY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWdoEN7n7Au84lcieQxzwMI6tsQSNIDAubLEyglLI7WlsL3e0iOF9G4430RTUHTp/eY3sJmjz8YBFGPvSsNmKl9eKYGZHgvq4kXLymd7MU8ELNcNuZzEAvyzGiINTmAjE7zkdRR1js0M/dgQ+xUbAfDaIVydhCdHnP5yey2g2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKn6Iv5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKn6Iv5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085721F000FF;
	Thu, 17 Sep 2026 21:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682017;
	bh=dCWk4QMDYulxz3+qDqgM4HuxE6fTIAdbdD6Bq6SUqgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UKn6Iv5BVX8PfBPi5k0SDAZm7wjh4UDyXyUyzn2iILVn+5gAfHAVz/NKeXFiOjU2H
	 bAiasjZW0/9uGsTY5AEUqfkDVyWl2fja8NmGz1+b/ovS/MHyUTcodWMpQVMQ9YekQD
	 ju3/VsoRiSFksyuzSPgqZxB4MV8DMCQLIlSjV0L+yEqVuygFhbCSPZF38fmGEpcHhT
	 hMZsnaosYCqqSyG4xie9Yog7zSbu41Vk4A5V2Joeb4YF4F3y9S7tDLRcesYoA9/69/
	 YZXqtIUllsgXv8vQnxqPSfBPVqlDiTRSKRMUcWtWpnm35kempbLVWW55+IfYwj0lUp
	 rDToDfoUfXvIQ==
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: release resources on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: qiang.zhao@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 21:53:36 +0000
Message-ID: <178968201650.22033.96357301509901132@kernel.org>
In-Reply-To: <20260916065136.2926089-1-lgs201920130244@gmail.com>
References: <20260916065136.2926089-1-lgs201920130244@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1 (1)

- [High] Teardown ordering defect in the new code: ucc_hdlc_remove()
  calls unregister_hdlc_device(priv->ndev) as its first action.
- [Low] Coding style in the new code: the added
  unregister_hdlc_device(priv->ndev) is inserted directly after the…

Pre-existing issues:
- [Medium] Probe error-unwind asymmetry: the labels reached after
  uhdlc_init() has already succeeded ('free_dev:' at…
- [Low] ucc_hdlc_probe() creates a virq mapping with
  'ut_info->uf_info.irq = irq_of_parse_and_map(np, 0);'…

--

net: wan: fsl_ucc_hdlc: release resources on remove

The patch makes ucc_hdlc_remove() unregister the HDLC netdev, free the
netdev after the hardware teardown, and free the separately allocated
struct ucc_tdm before freeing the private data.  A few questions about the
ordering and about the surrounding teardown paths below.

> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 809f21fb93f56..ffc8b989e33a7 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1254,6 +1254,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
>  static void ucc_hdlc_remove(struct platform_device *pdev)
>  {
>  	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
> +	unregister_hdlc_device(priv->ndev);

[Severity: High]
Can uhdlc_close() be skipped here when the interface is administratively
up at unbind time?

unregister_hdlc_device() in drivers/net/wan/hdlc.c detaches the protocol
before unregistering the netdevice:

void unregister_hdlc_device(struct net_device *dev)
{
	rtnl_lock();
	detach_hdlc_protocol(dev);
	unregister_netdevice(dev);
	rtnl_unlock();
}

detach_hdlc_protocol() ends with hdlc_setup_dev(), which assigns
dev->flags directly:

	dev->flags		 = IFF_POINTOPOINT | IFF_NOARP;

That clears IFF_UP.  netif_close_many() in net/core/dev.c then drops the
device from the close list:

	list_for_each_entry_safe(dev, tmp, head, close_list)
		if (!(dev->flags & IFF_UP))
			list_del_init(&dev->close_list);

so ndo_stop (uhdlc_close()) is not called during unregistration.  Since
uhdlc_close() is the only place that does:

	napi_disable(&priv->napi);
	...
	free_irq(priv->ut_info->uf_info.irq, priv);

does that leave ucc_hdlc_irq_handler() still installed on the virq, with
dev_id == priv, while the code below frees the DMA rings, the netdev and
priv?  The handler starts with:

	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)dev_id;
	struct net_device *dev = priv->ndev;

Would it be safer to close the device through the networking core (while
IFF_UP and hdlc->proto are still intact) before calling
unregister_hdlc_device()?  A related side effect is that the
request_irq()/free_irq() pair stays unbalanced, so a re-bind would get
-EBUSY from request_irq() in uhdlc_open() on the same non-shared virq.

Reproducer would be: attach a protocol via SIOCWANDEV, ip link set hdlc0
up, then unbind the platform device via sysfs.

[Severity: Low]
This isn't a bug, but the new call sits directly after the declaration of
priv with no blank line between the declaration and the first statement,
which checkpatch.pl flags as "Missing a blank line after declarations".

>  
>  	uhdlc_memclean(priv);
>  
> @@ -1266,6 +1267,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
>  		iounmap(priv->utdm->siram);
>  		priv->utdm->siram = NULL;
>  	}
> +	free_netdev(priv->ndev);
> +	kfree(priv->utdm);
>  	kfree(priv);

[Severity: Medium]
This isn't a problem introduced by this patch, but while the two teardown
sites are being brought into agreement: the probe error labels reached
after uhdlc_init() has already succeeded never call uhdlc_memclean():

free_dev:
	free_netdev(dev);
undo_uhdlc_init:
	if (utdm)
		iounmap(utdm->siram);
unmap_si_regs:
	if (utdm)
		iounmap(utdm->si_regs);
free_utdm:
	if (uhdlc_priv->tsa)
		kfree(utdm);
free_uhdlc_priv:
	kfree(uhdlc_priv);

If alloc_hdlcdev() returns NULL or register_hdlc_device() fails, does the
kfree(uhdlc_priv) drop the only handles to what uhdlc_init() allocated,
i.e. the two coherent BD rings, the coherent RX/TX data buffer, the QE
MURAM parameter area plus the riptr/tiptr MURAM allocations, the
ucc_fast_private from ucc_fast_init(), and the rx_skbuff/tx_skbuff
arrays?

The commit message says:

    The probe failure paths release these resources, but the remove path
    does not.

Is that accurate only for the netdev and the ucc_tdm struct?  The label
name undo_uhdlc_init suggests it undoes uhdlc_init(), while the code
under it does not call uhdlc_memclean().

[Severity: Low]
This is a pre-existing asymmetry rather than something added here, but
ucc_hdlc_probe() creates the virq mapping with:

	ut_info->uf_info.irq = irq_of_parse_and_map(np, 0);

and neither the probe error labels nor ucc_hdlc_remove() call
irq_dispose_mapping().  Should the mapping acquired at probe time be
disposed in the remove path being completed here, given that
request_irq()/free_irq() are balanced by uhdlc_open()/uhdlc_close() but
the mapping itself is not?

>  
>  	dev_info(&pdev->dev, "UCC based hdlc module removed\n");

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916065136.2926089-1-lgs201920130244%40gmail.com
