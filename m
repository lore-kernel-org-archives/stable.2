Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12C348C4C;
	Fri, 31 Jul 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514323; cv=none; b=ZsNgtpiZMee/ZyJXHpUYslBpms+KmS+Q/+DnTTJy+EhyKQPtAfruG876GNLBWdZb7HDzUuMtfVwxAJurPanlXi0WlPQfG5z7POOGpohIYYB7Hk+t7jpjoPGd10Zyj0X7+CROlvpXGUKIUyZ3y+4h3An6vg8RoGAPSAMKpBthsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514323; c=relaxed/simple;
	bh=ui8VDtI5yOAFU3S8ye/n7ySA6W76JGnaC2JuarKKSug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL6OLGs+lei0eic/IrmDz8Melnx2egWBFwWfJ0IPPFykrH7rfAq8vX81LS8kMC3g5QnqCTUCTWvp44oQuOrI2zvycMOYmtWJaK6KNRf3O44QO1jNz+zzjninxk3QXNwhzLXwhE9y2ftvPWN7iwG41eZLqO1aDxvub1HTZ4I5rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5+VHPiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5+VHPiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B31F00AC4;
	Fri, 31 Jul 2026 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514321;
	bh=+aY16cQD1yi/fI/iYzD2yH9asZaD/+RJNulXbhKPIL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5+VHPivrFG08eNk6jh85FQbBiRLs+GBo+x95+l61naVKO3k6qkgOGHlYzTzvq9LQ
	 c6RrJyw8TM2kMYdwe6bKJZRXZ+aaD3RK+E09W86CSjhzlr7SZylKMhsCzR+fcOBrJX
	 4JRs7vtkSELCKH2DcR3r3Z6OkbIouGAeQnVUQa8J7H9lUJ0nK1IcPj4ZhyQHIRPC6q
	 fYwUnX6InUkLpQ2464gk1ELegKQRzXVsEWXMAFuI3cMn/WlwpY5AsO/oISjeLQytmQ
	 LppNW7pmoGnuNt0wkTybBy5pLUI4kb3GbS4yPCpml9KjY79RtOG1CvOaCD/PczuW/j
	 WcWUVONYA1/xw==
From: Simon Horman <horms@kernel.org>
To: mhun512@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	qiang.zhao@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Fri, 31 Jul 2026 17:10:00 +0100
Message-ID: <20260731161000.334673-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728171545.49247-1-mhun512@gmail.com>
References: <20260728171545.49247-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728171545.49247-1-mhun512@gmail.com?part=1
---
--- Patch [1]: [PATCH net] net: wan: fsl_ucc_hdlc: release HDLC device on remove ---
commit 345f90c3e598219f0faf6e99ee38f97b8bd6452d
Author: Myeonghun Pak <mhun512@gmail.com>

net: wan: fsl_ucc_hdlc: release HDLC device on remove

The remove path previously freed the ucc_hdlc_private object without
unregistering or freeing the HDLC netdev. This patch adds
unregister_hdlc_device() at the start of ucc_hdlc_remove() and
free_netdev() before kfree(priv).

> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 809f21fb93f5..4c843c94cf43 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
>  {
>  	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
>
> +	unregister_hdlc_device(priv->ndev);
> +

[Severity: High]
The commit message says this "closes an active interface through ndo_stop,
which disables NAPI, stops the UCC, and frees its IRQ".  Is ndo_stop really
reached here?

unregister_hdlc_device() detaches the protocol before unregistering:

drivers/net/wan/hdlc.c:unregister_hdlc_device() {
	rtnl_lock();
	detach_hdlc_protocol(dev);
	unregister_netdevice(dev);
	rtnl_unlock();
}

and detach_hdlc_protocol() ends with an unconditional hdlc_setup_dev(),
which assigns dev->flags rather than or-ing into it:

drivers/net/wan/hdlc.c:hdlc_setup_dev() {
	dev->flags		 = IFF_POINTOPOINT | IFF_NOARP;
	...
}

So IFF_UP is cleared while the interface is still running.  Both the
unregister path and netif_close_many() in net/core/dev.c then gate the
close on that flag:

	if (!(dev->flags & IFF_UP))
		continue;
...
	list_for_each_entry_safe(dev, tmp, head, close_list)
		if (!(dev->flags & IFF_UP))
			list_del_init(&dev->close_list);

Doesn't that mean uhdlc_close() never runs, so none of napi_disable(), the
QE_GRACEFUL_STOP_TX/QE_CLOSE_RX_BD sequence, ucc_fast_disable() or
free_irq(priv->ut_info->uf_info.irq, priv) happen on the remove path when
the link was brought up with "ip link set hdlc0 up"?

>  	uhdlc_memclean(priv);
>
>  	if (priv->utdm && priv->utdm->si_regs) {
> @@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
>  		iounmap(priv->utdm->siram);
>  		priv->utdm->siram = NULL;
>  	}
> +	free_netdev(priv->ndev);
>  	kfree(priv);

[Severity: High]
Following on from the above: if uhdlc_close() is skipped, can this sequence
free memory that the hardware and the IRQ handler are still using?

uhdlc_open() installs the handler with priv as dev_id and enables NAPI:

drivers/net/wan/fsl_ucc_hdlc.c:uhdlc_open() {
	if (request_irq(priv->ut_info->uf_info.irq,
			ucc_hdlc_irq_handler, 0, "hdlc", priv))
		return -ENODEV;
	...
	napi_enable(&priv->napi);
	...
}

With no free_irq() anywhere else in the driver, the handler stays installed
after kfree(priv), and the first thing it does is dereference dev_id:

drivers/net/wan/fsl_ucc_hdlc.c:ucc_hdlc_irq_handler() {
	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)dev_id;
	struct net_device *dev = priv->ndev;
	...
			__napi_schedule(&priv->napi);
	...
}

Is that a use-after-free of priv, of the uccf freed by ucc_fast_free() in
uhdlc_memclean(), and of the already deleted napi_struct?

Also, since napi_disable() never ran, does free_netdev(priv->ndev) ->
netdev_napi_exit() -> __netif_napi_del_locked() trip its
WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state)) and tear down a NAPI that
may still be scheduled or polling?

And with the UCC left enabled, can it keep DMAing into the coherent RX/TX
rings and buffers that uhdlc_memclean() already returned via
dma_free_coherent()?

Would forcing the interface down before the protocol is detached, for
example netif_close()/dev_close() under rtnl, or an explicit
napi_disable()/UCC stop/free_irq() sequence in remove, address this?
