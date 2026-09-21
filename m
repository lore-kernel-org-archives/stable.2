Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A356355F46;
	Mon, 21 Sep 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992631; cv=none; b=F369kTWclndjX2ktm6WKG1WtP+qcJxy00sUxecgKW39P2BqhVb/OFzrB53wz8YVRDo0T5XTuUYIgnCB2o3XKdGnoJveRzHCs1P+gISo9EFBtjP7SaKsTXrIUdzZX4OiZl8OeMbMUHDakSJxfjNNYIha0+V5ix1mETJd88jd5r84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992631; c=relaxed/simple;
	bh=F0khSI8haFqLwK8ha/fAvJOllIzErtVACmDY7oV2nlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzEYsYA9g9cGf4d67H1/cHpE62X7ICSMHz8MawkolFw29ZxOJwB3hTPgLWEJzH8yGt6VXxh/5arTj242D7aT7s5oJzQCjxVKNSk5LPZjmnDuBofddB3+e+KPJTzx+f5Iduzjzi/06sWLZ7JUQFqZxUomy5dA3jVKZ0QQ1JP52jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxy+sPTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxy+sPTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A8B1F00899;
	Mon, 21 Sep 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789992629;
	bh=UeJmK4kWg3yRR+nNOTmEncPuh0kbRpSvlgt4fWTbY4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxy+sPTRpEbn+bWgh5JVaBkxYM6mn5vCclm7e4wB9isF7kbmExMGjCop/YetyovxP
	 H90i5RIKCj5J/onxpK1LhKpCciGvuOr+o0xycc2SWAr/IZrq+OklA8XEe8hZYXuUlX
	 I+htxKgKiMoz7gkhnwlQ4UR8RoGmPKKDZ/zIc8SReXIv91IHrYLly9mh3+dHJ6Hp+V
	 piL08opKJXO2ai3CO1L1iafs9+b6IGcBmb4FLujNypc0DYRP+B9IlkHQDtqJCTWytG
	 eVRho14dm5tAIZ4t5yrikoCHgzAtEObVJ9fy8nSJ3Sq3WsUgE2/WLyns6ipOg1uDte
	 ELPzRDRoX+yEg==
Subject: Re: [PATCH] fsl/fman: Fix fm_pdev reference leak in fman_port_probe()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linmq006@gmail.com, linux-kernel@vger.kernel.org,
 madalin.bucur@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.anderson@linux.dev, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 12:10:28 +0000
Message-ID: <178999262869.2160803.15157689217656066895@kernel.org>
In-Reply-To: <20260917110726.2148318-1-vulab@iscas.ac.cn>
References: <20260917110726.2148318-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix plus inaccurate commit message in
  fman_port_probe(): the commit claims the of_find_device_by_node()…

Pre-existing issues:
- [High] fman_port_probe()
  (drivers/net/ethernet/freescale/fman/fman_port.c:1864-1873) treats a…

--

fsl/fman: Fix fm_pdev reference leak in fman_port_probe()

This adds a put_device(&fm_pdev->dev) on the success path of
fman_port_probe(), so the reference taken by of_find_device_by_node() is
dropped before returning 0.

> diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
> index 1b8fef69114ed..f44a890165127 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_port.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_port.c
> @@ -1868,6 +1868,8 @@ static int fman_port_probe(struct platform_device *of_dev)
>  
>  	dev_set_drvdata(&of_dev->dev, port);
>  
> +	put_device(&fm_pdev->dev);
> +
>  	return 0;
>  
>  put_device:

[Severity: High]
The commit message says the fm_pdev reference "is released on the error
paths, but the successful path returns without dropping it".  Is that
accurate for all error paths in fman_port_probe()?

The __devm_request_region() failure branch jumps to free_port:, which sits
below the put_device: label:

	dev_res = __devm_request_region(port->dev, &res, res.start,
					resource_size(&res), "fman-port");
	if (!dev_res) {
		dev_err(port->dev, "%s: __devm_request_region() failed\n",
			__func__);
		err = -EINVAL;
		goto free_port;
	}
	...
put_device:
	put_device(&fm_pdev->dev);
return_err:
	of_node_put(port_node);
free_port:
	kfree(port);
	return err;

Does that branch still leak the fm_pdev device reference after this patch?

Would a single put_device(&fm_pdev->dev) right after the last use of
fm_pdev/fman cover both returns instead?

	port->dts_params.fman = fman;
	put_device(&fm_pdev->dev);

	of_node_put(port_node);

Note that redirecting free_port: to the existing put_device: label does not
look workable, since return_err: would then run of_node_put(port_node) a
second time after the of_node_put(port_node) already done just before
__devm_request_region().

[Severity: High]
This isn't a bug introduced by this patch, but right above the newly added
put_device() the devm_ioremap() failure is only logged and probe still
returns 0:

	port->dts_params.base_addr = devm_ioremap(port->dev, res.start,
						  resource_size(&res));
	if (!port->dts_params.base_addr)
		dev_err(port->dev, "%s: devm_ioremap() failed\n", __func__);

	dev_set_drvdata(&of_dev->dev, port);

Can this publish a port with a NULL register base?  fman_port_bind() hands
the drvdata to mac_probe() in fman/mac.c, and dpaa_eth_init_tx_port() /
dpaa_eth_init_rx_port() then call fman_port_config(), which derives the
register windows from that base without checking it:

drivers/net/ethernet/freescale/fman/fman_port.c:fman_port_config() {
	void __iomem *base_addr = port->dts_params.base_addr;
	...
	port->bmi_regs = base_addr + BMI_PORT_REGS_OFFSET;
	port->qmi_regs = base_addr + QMI_PORT_REGS_OFFSET;
	port->hwp_regs = base_addr + HWP_PORT_REGS_OFFSET;
	...
		reg = 0x00001013;
		iowrite32be(reg, &port->bmi_regs->tx.fmbm_tfp);
}

With base_addr NULL, does that iowrite32be() for the A005127 errata (rev >=
6, 1G TX) dereference a near-NULL __iomem pointer, followed by the
ioread32be()/iowrite32be() calls in fman_port_init() and
fman_port_enable()?

Should the devm_ioremap() failure set err = -ENOMEM and take the cleanup
path like the other fatal probe errors?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917110726.2148318-1-vulab%40iscas.ac.cn
