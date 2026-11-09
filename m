Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198301;
	b=3RMWAH0K+oq9E9ObIRLBx4BudxyfBDXjwUgDP1XMoKz08lQAatWDKnj3pIbba6rpoFEe
	 oH/fncC/tiZmbkMsa0akLZOhSQ+zuMMAAoKAaRDEepVLSIH/H0LUo32nDt1MEen/lUI5K
	 r65jwbnOY5+bRPenLwsqwDWSq1pbZGtTa98aG7x0BofgH0M6g5lqLVky9kChiITjSPUDv
	 2vzK1u11qssTiffbNLBBiugolPfrayIYyyKFEZvFPXQ+7w7Fccbwi3Qz+CNJKCyZvsKXc
	 vMuyhVHPKSohu0AijjKXsH65G8LY7RWuGB64gE3TK9BVEe9LdRr4W42bBO2G/D8I0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198301;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9TTdQg+VChIJZ1WMAMbqL/k5sHftYiJQ8gWyompvtUU=;
	b=HScqJIaaMWYVcnxmi0yBcv+zoy7W/a0zPi8dUrAq6N/PWjsgJtG+cxLvAUakC5HbSQPQ
	 H1VtvLae7c6SmgXuNnp6njT5L/K0CDcDFf1X97f6+8kvBM2Orda2/PjkQtoWgKmIiuSu0
	 Zt+IfRfBAav2vC3keelAQ4KdcYWT/ViCuuVeEkgogHi+lR7fmzCd+JCAdZvTTGrSKqHpQ
	 jn4PUXKQtZfqQ7B+vann2UVMTzCQb045YYx6afHQJv8yWTK0E/EOsyiGPhZlRnkUUxTaU
	 YD6yOw+roMCDNsDmUrcHv2hGIEp1QeCIUijhHTVrkHlk9OGS+wG551+En/K2tEQQZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/4OYLWX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF76606A321;
	Mon,  9 Nov 2026 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/4OYLWX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0C21F0089F;
	Mon,  9 Nov 2026 04:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198300;
	bh=9TTdQg+VChIJZ1WMAMbqL/k5sHftYiJQ8gWyompvtUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/4OYLWXtHjFh86N517QsWen/ECgj0gIrzlcfOpCp3EKZx7oFCzHB7Bt1tu3FmWii
	 oOpBt5xASNDupS6oiY7xi4QUtkOB08Wz7NT9Zsc6xw7gZy80QfXfiKTy272edCPR+r
	 8WVW71wbxNtgW+SBmZ9dXy8yOZHKcVrfQyM+DUOTADPNzdeAJ1T2cM00FXlYtubOqZ
	 FDCony/6KwIEizYcOq4NBljFFAo4R1gRjd0NhqMdVghlpcLUAV+iABxUeI1j0nfXga
	 dWkvnMRR/NylSX15TBSVuD7RGKiIb6xmv0VOG9k5iny+0ah6wls0Ewf0GTD6nZXh/l
	 FyMyRhMLDXYxA==
Subject: Re: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop to
 avoid use-after-free
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Mon, 09 Nov 2026 04:24:59 +0000
Message-ID: <179419829985.488853.2152109703584398675@kernel.org>
In-Reply-To: <20261107153319.3765325-1-hj351016@gmail.com>
References: <20261107153319.3765325-1-hj351016@gmail.com>
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

- [High] The fix leaves the use-after-free reachable, because
  restart_timer can be armed again after pcan_usb_stop() has deleted it.

--

can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-free

This adds a dev_stop callback to the PCAN-USB adapter. The callback calls
timer_delete_sync() on pdev->restart_timer, so the timer is drained in
peak_usb_ndo_stop(). The aim is to stop pcan_usb_restart() from running
on a freed struct pcan_usb after free_candev().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 8fd058c328564..4c131958b5aa6 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
>  	return pcan_usb_set_ext_vcc(dev, 0);
>  }
>  
> +static int pcan_usb_stop(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
> +
> +	timer_delete_sync(&pdev->restart_timer);

[Severity: High]
Can restart_timer be armed again after this delete?

The timer is armed by the restart URB completion, not by the timer
callback. The completion calls mod_timer() every time and never checks
urb->status:

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart_pending() {
	...
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
	...
}

pcan_usb_restart_async() submits that URB without anchoring it to
dev->rx_submitted or dev->tx_submitted:

	usb_fill_bulk_urb(urb, dev->udev,
			usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
			buf, PCAN_USB_CMD_LEN,
			pcan_usb_restart_pending, pdev);

	return usb_submit_urb(urb, GFP_ATOMIC);

So peak_usb_unlink_all_urbs() never kills it.

Suppose a bus-off auto-restart, or a manual restart through netlink, has
this URB in flight when the interface is brought down. The path is
peak_usb_set_mode(CAN_MODE_START) -> peak_usb_restart() ->
pcan_usb_restart_async(). peak_usb_ndo_stop() then runs as follows:

  close_candev()
    cancels only the restart work
  peak_usb_unlink_all_urbs()
    kills only rx_submitted and tx_submitted
  dev->adapter->dev_stop()
    timer is not pending yet, so nothing is deleted
  dev->adapter->dev_set_bus(dev, 0)
    synchronous usb_bulk_msg() on PCAN_USB_EP_CMDOUT

Bulk URBs on one endpoint complete in order. Would the queued restart URB
then complete and call mod_timer() after pcan_usb_stop() has returned?

Next, suppose the device is unplugged, unbound, or the module is removed
within PCAN_USB_STARTUP_TIMEOUT. peak_usb_disconnect() calls
unregister_candev() on an interface that is already down, so ndo_stop
and dev_stop do not run again. pcan_usb sets no .dev_free, so nothing
stops the timer before free_candev():

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_disconnect() {
	...
		unregister_candev(netdev);

		kfree(dev->cmd_buf);
		dev->next_siblings = NULL;
		if (dev->adapter->dev_free)
			dev->adapter->dev_free(dev);

		free_candev(netdev);
	...
}

pcan_usb_restart() -> peak_usb_restart_complete() would then write
dev->can.state and call netif_wake_queue() on freed memory.

No disconnect is needed for a related problem. Wouldn't the late timer
still move a stopped interface from CAN_STATE_STOPPED to
CAN_STATE_ERROR_ACTIVE and wake its queue after ndo_stop?

The commit message says:

  pcan_usb_restart() does not re-arm the timer, so a single
  timer_delete_sync() drains it.

That holds for the callback. Does it cover the case here, though, where
the timer is armed by the asynchronous URB completion?

Would a pcan_usb .dev_free callback that calls timer_shutdown_sync()
work instead? peak_usb_disconnect() calls it after unregister_candev()
and before free_candev(). By then, usb_unbind_interface() has already
flushed the endpoint URBs with usb_disable_interface(), because the
driver has no soft_unbind.

Another option is to anchor the restart URB and kill it before dev_stop
deletes the timer.

The probe error paths in peak_usb_create_dev() also reach free_candev()
with no restart_timer teardown for pcan_usb. These are the adap_dev_free
and lbl_unregister_candev labels. Would the dev_free approach cover those
paths too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107153319.3765325-1-hj351016%40gmail.com
