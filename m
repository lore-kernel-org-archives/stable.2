Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7D355F46;
	Mon, 21 Sep 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992251; cv=none; b=BdAxWYQ6tN62un/z1Ga9tQlwxwBFj4ZE9P+jmRX+JfuisWUzS3zvHKDI4HDr3wMTQt0gy/e597VtAZERy8eOWYGNz6KetASJkH/mj08MA1hEZGiOg3+Fd6Fwbl2/RJgmCdiQErSDqmUEWf1DR9dAtb0Vl7fKROXogucJYUOK/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992251; c=relaxed/simple;
	bh=ZGTi9h6SFleZ7mTCAa31fA/gFkDp9itBKqDTH+eKi0c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCqSO2nKKSsOGZ21ST7EBc+IRBtQznWNgmY9P6qfr4fpv9FyVb6+Fn1S9s/MEz7OY71cKcsElNwnnhdDOzM0WIPkcSKxJ7S0fz2XGxXkgEUkoERx3lruK01tw0p3f3AihUO4OcsYsWu0AVSzCileCQrKMD/SfZTAx83OuvUj8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2MAKrrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2MAKrrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FD11F000FF;
	Mon, 21 Sep 2026 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789992249;
	bh=1EuaCpVYCA591cNz3vckVy5/ZHFLXZkad3uSzRD9xkg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J2MAKrrgf4HQzs2/tWDfLhA0/6cCMkMEtaY+zzWFPYhoNcW0/yuCpPEK4vFNdA0Hc
	 rD5cEkbkU92cpnbp4f3aP9R8T1W+VousFBAOEEi50c7gUNW0CSOYwTOD6CO7tZO9gL
	 QIPFbOTmy5izsAsrjegiZ3o9Ovjvlo9ZEg0OBH0Xo6tNsmmIRaldp1viQT/ggBvKa0
	 cUuIFuLaWRdRS8SxCbJq2YcqUSrsSF0J09cEP3lp88v9qhwzLwdKTL7WjzAjCOS6QW
	 E0Ui+PheviASQqblSQ15T5gLVTrdA5gFA6tBpog6RDq2dddXIN3ZGb5HoKyWPtm1KI
	 yy+pMZq5FTudw==
Subject:
 Re: [PATCH] net: dpaa: Fix tbidev reference leak in dtsec_initialization()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, madalin.bucur@nxp.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sean.anderson@linux.dev,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 12:04:08 +0000
Message-ID: <178999224836.2160803.9651628345883455355@kernel.org>
In-Reply-To: <20260917110554.2148240-1-vulab@iscas.ac.cn>
References: <20260917110554.2148240-1-vulab@iscas.ac.cn>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In `dtsec_initialization()`
  (drivers/net/ethernet/freescale/fman/fman_dtsec.c:1506) the patch…

Pre-existing issues:
- [Medium] The dTSEC MAC has no teardown path: `mac_remove()`
  (drivers/net/ethernet/freescale/fman/mac.c:325-336) only drops the…

--

net: dpaa: Fix tbidev reference leak in dtsec_initialization()

The patch adds a put_device() on the TBI PCS mdio device at the end of
dtsec_initialization(), on the grounds that the reference taken by
of_mdio_find_device() is only dropped in dtsec_free() on the error paths.
No other change is made.

> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> index b8d70c0ecb6c6..4f1e3900cebdb 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -1499,6 +1499,12 @@ int dtsec_initialization(struct mac_device *mac_dev,
>  	dev_info(mac_dev->dev, "FMan dTSEC version: 0x%08x\n",
>  		 ioread32be(&dtsec->regs->tsec_id));
>  
> +	/* The PCS device is registered as long as the FMan device, of which
> +	 * mac_dev holds a reference, so the reference taken above is not
> +	 * needed anymore.
> +	 */
> +	put_device(&dtsec->tbidev->dev);
> +

[Severity: High]
Can this put_device() lead to a use-after-free of dtsec->tbidev?

The pointer is not cleared here, and it stays in struct fman_mac and is
dereferenced for the whole lifetime of the interface, including from the
phylink state machine, which polls once per second because
dtsec->pcs.poll = true:

drivers/net/ethernet/freescale/fman/fman_dtsec.c

static void dtsec_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
				struct phylink_link_state *state)
{
	struct fman_mac *dtsec = pcs_to_dtsec(pcs);

	phylink_mii_c22_pcs_get_state(dtsec->tbidev, neg_mode, state);
}

dtsec_pcs_config() and dtsec_pcs_an_restart() use it the same way, and
dtsec_init() writes MII_TBICON through mdiodev_write(dtsec->tbidev, ...),
so the handle is the access path to the TBI registers rather than a
transient lookup.

of_mdio_find_device() documents the ownership rule this way:

drivers/net/mdio/of_mdio.c

 * If successful, returns a pointer to the mdio_device with the embedded
 * struct device refcount incremented by one, or NULL on failure.
 * The caller should call put_device() on the mdio_device after its use

Is the lifetime claim in the comment and in the commit message ("The
device stays registered for as long as the FMan device, which mac_dev
holds a reference to") accurate?  The TBI mdio_device lives on an MDIO bus
owned by a separate platform device (compatible "fsl,fman-mdio", driven by
the tristate module drivers/net/ethernet/freescale/fsl_pq_mdio.c):

drivers/net/ethernet/freescale/fsl_pq_mdio.c

static void fsl_pq_mdio_remove(struct platform_device *pdev)
{
	...
	mdiobus_unregister(bus);

	iounmap(priv->map);
	mdiobus_free(bus);
}

mdiobus_unregister() then does, for each child:

drivers/net/phy/mdio_bus_provider.c

		mdiodev->device_remove(mdiodev);
		mdiodev->device_free(mdiodev);

which is the final put once the driver's own reference is gone, and
mdio_device_release() kfree()s the object.

The reference mac_dev holds is only a struct device refcount on the FMan
platform device:

drivers/net/ethernet/freescale/fman/mac.c:mac_remove() {
	for (i = 0; i < PORT_NUM; i++)
		put_device(mac_dev->fman_port_devs[i]);
	put_device(mac_dev->fman_dev);
	...
}

Does that pin the descendant MDIO platform device or its bus in any way?
After an unbind of fsl-pq_mdio (or rmmod fsl_pq_mdio), phylink would keep
calling phylink_mii_c22_pcs_get_state(dtsec->tbidev, ...) on freed memory,
and would also walk tbidev->bus whose registers have been iounmap()ed.

Before this change the retained reference kept the object allocated, so
the symptom was a refcount leak rather than a freed dereference.

Would it be better to keep the reference and release it from a real
teardown path, the way fman_memac.c does it in memac_free() via
pcs_put()?

>  	goto _return;
>  
>  _return_fm_mac_free:

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but is it
the reason the reference is never dropped on the success path?

dtsec_free() has exactly one caller, the _return_fm_mac_free label in
dtsec_initialization():

drivers/net/ethernet/freescale/fman/fman_dtsec.c

static int dtsec_free(struct fman_mac *dtsec)
{
	free_init_resources(dtsec);

	kfree(dtsec->dtsec_drv_param);
	dtsec->dtsec_drv_param = NULL;
	if (!IS_ERR_OR_NULL(dtsec->tbidev))
		put_device(&dtsec->tbidev->dev);
	kfree(dtsec);

	return 0;
}

and mac_remove() performs no MAC-specific cleanup at all, so after a
successful probe nothing releases mac_dev->fman_mac.  On unbind the whole
fman_mac allocation, its hash tables and dtsec_drv_param leak, and the
FMan MAC/1588 interrupt callbacks registered through fman_register_intr()
stay installed pointing at the leaked dtsec whose regs mapping
(mac_dev->vaddr) has been unmapped.

fman_memac.c has the same shape, with memac_free() only reachable from the
error label in memac_initialization().

Should the fix add the missing teardown path instead, so the tbidev
reference (and the rest of the state) is released when the MAC goes away?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917110554.2148240-1-vulab%40iscas.ac.cn
