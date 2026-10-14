Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C33C3F54;
	Wed, 14 Oct 2026 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946761; cv=none; b=NMq7RoCuQniASR2OEUymactio6Zh+2TvwpUrEBDd20+ODW6v04HkLRXOCs1dy96SzlIxGEE+RfIcTMP5oQAnicWNA+Yqg+DDI5fi0del5Q5ujbXVOquk2eSP31RVTWR7N0GxDa71uNS7n53fVUH2sPhCzTp8VC2udLHVSvsT/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946761; c=relaxed/simple;
	bh=QP0kAHnZYMZm9q2NDEtKpKFBAvMXOHavv4R3aBlA060=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlrlCcizxbeoFj8yt2KQOtPIZL6BjbJaI+AdWlMMwE6vkq+IHFF69Myv9qAaPlEko4jg9GSvGwN2mnPx8kCXfrKE0C35IRLlg9dSCMfFmlFahWx63pV0S94Rum0efcm0yt5pCO1FtgCMe7OZLddZE4P1LfknOaYK0ZnJAcDsVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkouZ8N3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkouZ8N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926F1F000FF;
	Wed, 14 Oct 2026 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946759;
	bh=o5J3qMfu6cuSt5R4zTOTwHH6387Pn2psBV2ewz3WMas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EkouZ8N3VC4dn2Df7E0ztWOB9Q6LaUO6IOjze4cjts1QCOFwQ16W79SgtE4Xi0Va9
	 6K3UdF/GTSljAli0Xu/TLCpNFMCntqUh1j63QQ1HVOXUDsSaOo55odk8GopA7Ibslu
	 yzDzFy8Ga1R7aVjRzBVxVu6seQWrtCJzoG5JhlqVbXAYZi9HH/eZKFQdSEM+K9R5Gw
	 HF84tcr12YGPZ+49BNAcOjb4/nvzLl26K9qR+OrK/pTMiGS2zcrPTSQLCbPdGa8Nw6
	 +Z37r3r1wgvcCPTjFHn6ZBZzLeprJ93M6EOneLvi8ExmkkM51p64bpx2LVN+DfWU+T
	 qlpq3WEVhqYSw==
Subject:
 Re: [PATCH net v5 1/2] nfc: nfcmrvl: publish UART state before registration
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cuissard@marvell.com, sameo@linux.intel.com, oe-linux-nfc@lists.linux.dev,
 linux-kernel@vger.kernel.org, gio@octane.security, stable@vger.kernel.org
Date: Wed, 14 Oct 2026 02:59:18 +0000
Message-ID: <179194675840.434549.3384038215557625758@kernel.org>
In-Reply-To: <20261013025746.41292-2-shubham@octane.security>
References: <20261013025746.41292-2-shubham@octane.security>
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

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch sets the TX-side UART state (nu->drv_data, nu->ndev)
  before nci_register_device(), but the RX side is still attached late.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  leaves it in place: the SPI transport has the same publish-after-…
- [High] Concern: on the normal teardown paths, nu->drv_data and nu->ndev
  are never withdrawn.
- [High] This problem wasn't introduced by this patch, but the USB
  transport has the same publish-after-registration bug, and it crashes…

--

nfc: nfcmrvl: publish UART state before registration

This commit adds nci_ready() and nci_unready() callbacks to
nfcmrvl_if_ops. nfcmrvl_nci_register_dev() calls nci_ready() before
nci_register_device(), so the UART transport now sets nu->drv_data,
nu->ndev and priv->support_fw_dnld before the NCI device is exposed. The
same function calls nci_unready() if registration fails, and it now calls
nfcmrvl_chip_halt() before registration.

> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 6efa832191172..3d26a54ef51b4 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c
> @@ -154,20 +154,25 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
>  
>  	nci_set_drvdata(priv->ndev, priv);
>  
> +	/* Ensure that controller is powered off before exposing the device. */
> +	nfcmrvl_chip_halt(priv);
> +
> +	if (priv->if_ops->nci_ready)
> +		priv->if_ops->nci_ready(priv);
> +
>  	rc = nci_register_device(priv->ndev);

[Severity: High]
This is a pre-existing issue and this patch didn't introduce it. The SPI
transport seems to have the same publish-after-registration problem. spi_ops
in drivers/nfc/nfcmrvl/spi.c has no .nci_ready, and nfcmrvl_spi_probe()
still sets its state only after registration returns:

drivers/nfc/nfcmrvl/spi.c:nfcmrvl_spi_probe() {
    ...
	drv_data->priv = nfcmrvl_nci_register_dev(NFCMRVL_PHY_SPI,
						  drv_data, &spi_ops,
						  &drv_data->spi->dev,
						  pdata);
    ...
	drv_data->priv->support_fw_dnld = true;

	drv_data->nci_spi = nci_spi_allocate_spi(drv_data->spi, 0, 10,
						 drv_data->priv->ndev);
    ...
	init_completion(&drv_data->handshake_completion);
}

nfc_register_device() calls device_add() before it takes device_lock(). If
an NFC_CMD_DEV_UP arrives in that window, can this path reach
nci_spi_send() with drv_data->nci_spi still NULL?

nfc_dev_up()->nci_dev_up()->nci_open_device()->CORE_RESET->nci_cmd_work()
  ->nfcmrvl_nci_send()->nfcmrvl_spi_nci_send()
    ->nci_spi_send(drv_data->nci_spi == NULL, ...)
      hdr[1] = nspi->acknowledge_mode;

The SPI IRQ is also requested before registration. If SPI_INT falls before
probe finishes, nfcmrvl_spi_int_irq_thread_fn() would call
nci_spi_read(drv_data->nci_spi) and nfcmrvl_nci_recv_frame(drv_data->priv,
skb) while both pointers are still NULL.

The I2C transport also sets support_fw_dnld only after registration, in
nfcmrvl_i2c_probe().

Should SPI implement the new nci_ready hook as well?

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch. The
USB transport looks like it has the same window, and there the crash would
happen in URB completion context. usb_ops has no .nci_ready, and
nfcmrvl_probe() in drivers/nfc/nfcmrvl/usb.c sets drv_data->priv only after
registration:

	priv = nfcmrvl_nci_register_dev(NFCMRVL_PHY_USB, drv_data, &usb_ops,
					&intf->dev, &config);
	if (IS_ERR(priv))
		return PTR_ERR(priv);

	drv_data->priv = priv;

An early DEV_UP goes through nfcmrvl_usb_nci_open(), which submits the
bulk-IN URBs and sets NFCMRVL_USB_BULK_RUNNING. nfcmrvl_bulk_complete()
guards only on this check:

	if (!test_bit(NFCMRVL_NCI_RUNNING, &drv_data->flags))
		return;

NFCMRVL_NCI_RUNNING and NFCMRVL_USB_BULK_RUNNING are both bit 1, so the
guard passes. The handler then does:

		skb = nci_skb_alloc(drv_data->priv->ndev, urb->actual_length,
				    GFP_ATOMIC);

When the controller answers the CORE_RESET in that window, does this
dereference a NULL drv_data->priv?

>  	if (rc) {
>  		nfc_err(dev, "nci_register_device failed %d\n", rc);
>  		goto error_fw_dnld_deinit;
>  	}

[ ... ]

> diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
> index 9aedd168759c7..d688071f4b26d 100644
> --- a/drivers/nfc/nfcmrvl/uart.c
> +++ b/drivers/nfc/nfcmrvl/uart.c
> @@ -44,6 +44,23 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
>  	return nu->ops.send(nu, skb);
>  }
>  
> +static void nfcmrvl_uart_nci_ready(struct nfcmrvl_private *priv)
> +{
> +	struct nci_uart *nu = priv->drv_data;
> +
> +	priv->support_fw_dnld = true;
> +	nu->drv_data = priv;
> +	nu->ndev = priv->ndev;
> +}

[Severity: Medium]
This sets the TX-side state before registration. Is the RX side still
attached too late?

nci_uart_set_driver() in net/nfc/nci/uart.c sets tty->disc_data only after
nu->ops.open() returns, and open() is the call that exposes the NCI device:

	ret = nu->ops.open(nu);
	...
	tty->disc_data = nu;

Until then, nci_uart_tty_receive() drops all incoming data:

	if (!nu || tty != nu->tty)
		return;

nci_uart_tty_wakeup() also returns early in that window.

nfc_dev_up() holds device_lock() across the whole nci_dev_up() reset
request. Meanwhile, the registering task waits on device_lock() in
nfc_register_device(), after device_add(). In the early DEV_UP case this
patch targets, the CORE_RESET goes out, but the response seems to be lost.
open() cannot return and set disc_data until the reset request times out.

Would the early DEV_UP then fail with a timeout instead of crashing, with
the NCIUARTSETDRIVER ioctl stalled for that time? Does tty->disc_data also
need to be set before the device is exposed?

> +
> +static void nfcmrvl_uart_nci_unready(struct nfcmrvl_private *priv)
> +{
> +	struct nci_uart *nu = priv->drv_data;
> +
> +	nu->drv_data = NULL;
> +	nu->ndev = NULL;
> +}

[Severity: High]
This is a pre-existing issue, not one this patch introduced, and the next
patch in this series ("nfc: nci: uart: quiesce write_work during teardown")
appears to fix it. The issue: nu->drv_data and nu->ndev are cleared only on
the registration failure path, never on normal teardown.

In nci_uart_tty_close(), nu->ops.close() runs before write_work is
cancelled:

	nu->ops.close(nu);
	nu->tty = NULL;
	module_put(nu->owner);

	cancel_work_sync(&nu->write_work);

nu->ops.close() reaches nfcmrvl_nci_unregister_dev(), which frees the
nci_dev and priv without quiescing UART TX. The try_module_get() failure
path in nci_uart_set_driver() calls nu->ops.close() and kfree(nu) without
cancelling write_work at all.

Say write_work is pending or running, for example because
nci_unregister_device()->nci_close_device() sent a CORE_RESET. Could
nfcmrvl_nci_uart_tx_start() or nfcmrvl_nci_uart_tx_done() then use the
freed priv, ndev or nu?

The later patch addresses this. It adds an nci_quiesce hook that calls
nci_uart_tx_stop() and nci_unready() in nfcmrvl_nci_unregister_dev() before
kfree(priv). It also adds a CLOSING check in nci_uart_tx_wakeup(). Finally,
it moves nci_uart_tx_stop() earlier in nci_uart_tty_close() and adds it to
the open error path in nci_uart_set_driver().

> +
>  static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
>  					   const void *param)
>  {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013025746.41292-1-shubham%40octane.security
