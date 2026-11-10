Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333077;
	b=b9nI4JpIVzYTqJf6XGmkMQAs+3Kd7TkAzLKscqDbJl+rlT+MBzQtQdQG1kedhRcGOLwu
	 QfF1kyTANXMjLpafJ5k1ibXWVqtIkWoM9j8izspGz5au21L3b8SX1/B6DvYtXRCEANbf4
	 r3oH3+6PiHU5GrTMrhr1g5Rdj/UIWWEy6F2lZYBt2pYP2DuGCWwAE0ObIBEydlVvCTX0c
	 3onDCkGbxdUlW+FOHQrGY7viqKdIYG1u13oJl//pt8Ct7Akkl8EQsm/WvJ9+nRWdahNdZ
	 RF7OhH+mOuY6fCVBZ4rJ6BNMvQLYXj2l7AK649dooh8slRRrcbhjq8gGefhcuvkT26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333077;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xcY5AzBipNIRhCxgAr8uVvMhPPMWHzQIh0xHBQBfhVo=;
	b=oU0GzvjaxdahetyHeLiBkLZ3TRNR2jnoNVtiujp4asWg/u+6Tzysa1/Gq5RhPkXMIJOQ
	 3auABZdvTO+6+10/bo9wjo+fpKQtHDKBXyK6ri1wphzXvSAd7HU8RF5GpChfijSN279fA
	 C3p4JZvCXUl/RUsXTkpoRYs+bjdZSKDAtfbB+SwvADbcVWNXpmouItIixZ5kpelrHnXj4
	 AyC8TVHBZ5Pydb+j1Q8ORmoXjH1im0hP7oe+CJJnm5WMsHXHt1LKnAtqtT6MiKwc1vxq2
	 pPAvLezrZw0RcKODQBFx2zIbAYZ84K8U/THgozbNjSTegjX4XBs5o44ygTneEdmmlTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5XfCheP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E47606A31C;
	Tue, 10 Nov 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5XfCheP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C501F0089F;
	Tue, 10 Nov 2026 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333077;
	bh=xcY5AzBipNIRhCxgAr8uVvMhPPMWHzQIh0xHBQBfhVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5XfChePNKqAXxnGmaBCBPrutxW+EzsU49j7T1JNc3IsP206dkiF0VU9tf6FVdUI6
	 QvY7GV1IasWghxpL1m9GCX08tcfViKft8Ue4vRDdvYNGuN2+2glspsQ2hFxaN56zzu
	 4dgdonqI5ZQqSVsoqa07T+DatiUDGEBkrWp/atfQt1iDsasbHVH7D8SrdcRg8C/v3S
	 In2UPr7v8sllUwnS7YLXJD7wXkQZYrwDl7WaWyNtUWRTdTOktsAnwifvtHWtX0tj1k
	 mlUeGWIXZDkd1Luo1mfgCq3udWDhIT0mj5GPkVaJ9uJidErCvWAhZQIzNP4GwF8Uqv
	 gUNvFlYPSA5PA==
Subject: Re: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on
 free to avoid use-after-free
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 10 Nov 2026 17:51:16 +0000
Message-ID: <179433307644.488853.17304590823940051670@kernel.org>
In-Reply-To: <20261109044911.1163505-1-hj351016@gmail.com>
References: <20261109044911.1163505-1-hj351016@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete on the probe error path it claims to cover
  (the adap_dev_free label in peak_usb_create_dev()).
- [High] The dev_init() failure path in peak_usb_create_dev() skips the
  new dev_free() callback completely, so the restart timer is still…

--

can: peak_usb: pcan_usb: shut down restart timer on free to avoid use-after-free

This adds a pcan_usb dev_free callback that calls timer_shutdown_sync() on
pdev->restart_timer. The goal is to keep the restart timer from running
against a freed struct pcan_usb once free_candev() has run. The commit
message says this covers disconnect and the probe error path that reaches
the adap_dev_free label.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 8fd058c328564..113b2e7453310 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -882,6 +882,19 @@ static int pcan_usb_start(struct peak_usb_device *dev)
>  	return pcan_usb_set_ext_vcc(dev, 0);
>  }
>  
> +static void pcan_usb_free(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
> +
> +	/*
> +	 * The restart timer is armed from the restart-command URB completion
> +	 * (pcan_usb_restart_pending()), which is not anchored and so outlives
> +	 * ndo_stop/unlink_all_urbs. Shut it down -- not just delete it -- so a
> +	 * late completion cannot re-arm it after free_candev().
> +	 */
> +	timer_shutdown_sync(&pdev->restart_timer);

[Severity: High]
Does this cover the adap_dev_free probe error path in peak_usb_create_dev()?
The commit message says it does.

On disconnect, usb_unbind_interface() calls usb_disable_interface() before
->disconnect(). That flushes the unanchored restart URB before dev_free()
and free_candev() run.

On probe failure, usb_probe_interface() takes its err: path, which does not
disable the interface endpoints. Nothing in peak_usb_create_dev() kills the
restart URB either:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
    ...
	if (dev->adapter->dev_set_bus) {
		err = dev->adapter->dev_set_bus(dev, 0);
		if (err)
			goto adap_dev_free;
	}
    ...
adap_dev_free:
	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);
    ...
lbl_free_candev:
	free_candev(netdev);
}

register_candev() has already run at this point, so can0 can be brought up.
A bus-off followed by auto-restart or a manual restart then reaches
peak_usb_restart()->pcan_usb_restart_async(). That submits the bus-on
command on EP_CMDOUT with urb->context = pdev. The URB is not anchored, so
peak_usb_unlink_all_urbs() never touches it.

If the device delays EP_CMDOUT, the synchronous dev_set_bus(dev, 0) queued
behind it can time out, and probe goes to adap_dev_free. When the restart
URB completes later (the device finally ACKs, or an unplug flushes it with
-ESHUTDOWN), we get:

pcan_usb_restart_pending()
    struct pcan_usb *pdev = urb->context;
    mod_timer(&pdev->restart_timer, ...);

and pdev has already been freed by free_candev().

timer_shutdown_sync() only makes mod_timer() a no-op while the timer_list
memory is still valid. Can it stop this write to freed memory? If not, the
comment above ("so a late completion cannot re-arm it after free_candev()")
does not hold on this path.

The commit message says "by which point the endpoint URBs have been flushed
by usb_disable_interface()". That also seems to apply to disconnect only.

There is also a smaller window on this path. dev_free() runs before
unregister_candev(), so the interface can stay up with a timer that has
been shut down. The only guard against a new submission is this check:

pcan_usb_restart_async()
	if (timer_pending(&pdev->restart_timer))
		return -EBUSY;

After shutdown that check is always false. Can new restart URBs be
submitted in that window that never reach peak_usb_restart_complete()?

Would anchoring the restart URB and killing that anchor before
free_candev() on every path be a better fix than relying on the timer
shutdown alone?

> +}
> +
>  static int pcan_usb_init(struct peak_usb_device *dev)
>  {
>  	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
> @@ -1051,6 +1064,7 @@ const struct peak_usb_adapter pcan_usb = {
>  	.dev_decode_buf = pcan_usb_decode_buf,
>  	.dev_encode_msg = pcan_usb_encode_msg,
>  	.dev_start = pcan_usb_start,
> +	.dev_free = pcan_usb_free,

[Severity: High]
Does a dev_init() failure still leave the restart timer live at
free_candev()? In peak_usb_create_dev(), this path jumps past the
adap_dev_free label, so pcan_usb_free() is never called:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
    ...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
	}
    ...
}

pcan_usb_init() calls timer_setup() on restart_timer and then calls the
synchronous pcan_usb_get_serial(). That call can block for up to
PCAN_USB_COMMAND_TIMEOUT and then fail:

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_init() {
    ...
	timer_setup(&pdev->restart_timer, pcan_usb_restart, 0);
    ...
	err = pcan_usb_get_serial(dev, &serial_number);
	if (err) {
		...
		return err;
	}
    ...
}

register_candev() has already run, so can0 can be brought up during that
window. A bus-off and restart can then submit the restart URB, and its
completion arms restart_timer.

When pcan_usb_get_serial() fails, unregister_candev() and free_candev() run
with no timer teardown. The timer may still be pending, or the restart URB
may still be in flight. If the timer fires,
pcan_usb_restart()->peak_usb_restart_complete() writes dev->can.state and
calls netif_wake_queue() on freed memory.

Should pcan_usb_init() shut down the timer (and kill the restart URB) on its
own error return? Alternatively, the core could call dev_free() on this path
too.

>  	.dev_restart_async = pcan_usb_restart_async,
>  	.do_get_berr_counter = pcan_usb_get_berr_counter,
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109044911.1163505-1-hj351016%40gmail.com
