Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AB3DA7C3;
	Thu, 17 Sep 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635697; cv=none; b=hYZ9BrSWG5cfYA0oP2Hloy48psnwiffkFoS6XUB2GXTplOHmgMjgeujew6KzhZtMd7uBCZkA6GN8mCWb6U2wPlBfjhWRNpFuO4zVzTVUCUsX+DhX4FXXFA5BYIsxyPrtcKV04EjgHpI4IIvB55n+ml+A5KiXC9hSuR2KF7oGGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635697; c=relaxed/simple;
	bh=QuOYhjLMQw64lqyFNfRHJDyjmarwM1Yy/Rpu2KWWtbM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzH0LDaE+HBFGbIKu/Za7jEKNg6MccVJpmXbBb5pHXCF2YDbSReu4AOfbzjamnXqw1EUMhSjLS9fFpq7DAV+UIVPo3xx1MUXowyGBJ3HbN6S4wx9XvGd2LHY6b+i5MwXAVe7YSPBnnZAZmnWew0Wkc6YXORdCV2ktQPp1wXvaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1MD3Cvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1MD3Cvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7219D1F000FF;
	Thu, 17 Sep 2026 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635696;
	bh=JGT0mNCC9MBKh4dUPSdSGAzYw8ijktGlEee/ewVv4sc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G1MD3Cvx+J7HFupK+e9/miYH/UiZc0tZsJIhe7JkJjYH9CAL39L4oBLj1GsMNl6jg
	 vB89ez7/inZUaN0TZJZ6qqjDiNn8YaWw2RYdtNPtaeDoBbK2a3H5MheD6B5n7bTuyn
	 uxRgXDghcmRpoqFaW1i0p+UF/F0Gqj4epE9bu9KG+f7wI968UD8hLG9jfn5qx7sZzs
	 pjZAoJs7DXmCrAOLsqPjfnKYE+kFhGh5mg9Z5c+2cU7qnTb17ksKAku5biYJz/mYyE
	 NUZHipYw56NAflJ6la/Mr0zgjwZ16lPwY43+n1kTmwtoRSC3hL37zhL3iMuiKkIyEV
	 iMHX0PCn/8CwA==
Subject: Re: [PATCH] net: sungem: disable PCI device on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, shaojijie@huawei.com,
 u.kleine-koenig@baylibre.com, ruoyuw560@gmail.com, j.raczynski@samsung.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 09:01:35 +0000
Message-ID: <178963569501.22033.1329921162379894027@kernel.org>
In-Reply-To: <20260916055913.2910349-1-lgs201920130244@gmail.com>
References: <20260916055913.2910349-1-lgs201920130244@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch only balances the probe-time pci_enable_device(),
  but the driver takes a *second* PCI enable reference per interface-up…

--

net: sungem: disable PCI device on remove

The patch adds a pci_disable_device() call at the end of gem_remove_one()
so that the pci_enable_device() done in gem_init_one() is balanced after a
successful probe. Previously only the probe failure path disabled the
device.

> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index dc5638d105dbb..6abf4d292802c 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -2806,6 +2806,7 @@ static void gem_remove_one(struct pci_dev *pdev)
>  		iounmap(gp->regs);
>  		pci_release_regions(pdev);
>  		free_netdev(dev);
> +		pci_disable_device(pdev);
>  	}
>  }

[Severity: Medium]
Is one unconditional pci_disable_device() here enough to guarantee the
device is actually disabled at unbind?

sungem takes a second enable reference every time the interface is brought
up, in gem_open():

	/* Make sure PCI access and bus master are enabled */
	rc = pci_enable_device(gp->pdev);
	if (rc) {
		...
		gem_put_cell(gp);
		return -ENXIO;
	}
	return gem_do_start(dev);

If gem_do_start() fails, that reference does not appear to be released.
The request_irq() failure path there unwinds only the chip state and the
cell:

	rc = request_irq(gp->pdev->irq, gem_interrupt,
			 IRQF_SHARED, dev->name, (void *)dev);
	if (rc) {
		netdev_err(dev, "failed to request irq !\n");

		gem_reset(gp);
		gem_clean_rings(gp);
		gem_put_cell(gp);
		return rc;
	}

and gem_open() returns that error verbatim.

__dev_open() in net/core/dev.c does not call ndo_stop when ndo_open fails:

	if (!ret && ops->ndo_open)
		ret = ops->ndo_open(dev);

	netpoll_poll_enable(dev);

	if (ret)
		clear_bit(__LINK_STATE_START, &dev->state);

so gem_close(), which holds the matching pci_disable_device(gp->pdev), is
never reached and pdev->enable_cnt stays at 2 for the rest of the binding.

In that case, does the new call in gem_remove_one() only drop the count
from 2 to 1?  pci_disable_device() in drivers/pci/pci.c is reference
counted:

	if (atomic_dec_return(&dev->enable_cnt) != 0)
		return;

	pci_host_bridge_disable_device(dev);
	do_pci_disable_device(dev);
	dev->is_busmaster = 0;

which would leave memory decoding and bus mastering enabled on a device
with no driver bound, and no warning, since the dev_WARN_ONCE there only
fires for enable_cnt <= 0.

Should the gem_open()/gem_do_start() failure path also drop its enable
reference, for example a pci_disable_device() in the request_irq() error
block of gem_do_start(), or in gem_open() when gem_do_start() returns an
error?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916055913.2910349-1-lgs201920130244%40gmail.com
