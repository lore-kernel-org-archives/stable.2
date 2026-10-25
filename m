Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918944;
	b=3E/Wa/p+Es7+M+u4znmNnM/UPyqwfGRKkd5l7rtIlOqxex99yLhEztskvMKUbwQ1ngDh
	 ofaAZBzoB4Ah/sh1ojIaVdPnkccg91H/spR9WN4JheQzoJ/93SDawnKSGt25R480lu6OK
	 naZYgiGPKRFf9RvgKyASujV7xz6k4w5K7VYxPknQa9i0+Wz3BTmHmSCGG7s0USMcea5p7
	 iJDjzVgjEthIOFZahUO+rZuxWJRMfIM308u05pVHI5ckqNUUgdnV/GqDGgwpdJuwIlcg5
	 tFPNcxiue0/MraZZx+0hWU7zaoOW5Sm/OGnqSIU3HBtbc0Cf8P91guCwFAa+P0di8vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918944;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fqJbvTGdqh7VqVzWzt3DZSgHVwGRSMEmH3rTArRygRE=;
	b=cX9WC2PTUh9q9qRebGeLCzU8shf4NKyUYQgbFOAV8mO0HMs6lii+EoXsL95Kc2Y2H4de
	 9mCuWHEMoBPvmyB7AATZ5jyfDJ3Ed9pnrrj9W03Mtfcgjy4H/EFu8/Dl6L03fa4suE5St
	 dQYLPqLCVxs/vzrUIYWULfByRv6BJUGpY3bkKKWbgJhb7JgeaXycpgiNPxrcmx9KjL7rt
	 Gi/B6oOboh4P95Y71cBdWhm7y4z6QpJk6oTuVJ1aOsKh4hFtugHW4xUtmz7uxTQ10xlh1
	 mSd2N2I7AcYn+C79a97mmrpKDxgNBaPYtQpIJLDPpSeoyVC8nCcdBu8GnfHBIwuQxDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLfq8KMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E9606A31A;
	Sun, 25 Oct 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLfq8KMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFCD1F01825;
	Sun, 25 Oct 2026 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792918943;
	bh=fqJbvTGdqh7VqVzWzt3DZSgHVwGRSMEmH3rTArRygRE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MLfq8KMT6EiphOaV1Pif+gzSu0jqWM1l7KeH0dO70OV9EnI6iqkirtl+S94ioOUHh
	 s7kLCossVRI5RMGVML7Qd2JMrQCVad0TxwET8bC5sUmjQ4+3r+GQb/D5DWF23vAEtW
	 w4V4ERPrDFaXaAWYuIvEwiCKWJi1ZN+yBpEewLib0F8ufU6F/GSd+k6QIcwHJ4QKT1
	 H+IEB9uBVc0mk3JoWaDjFd+/IFpIryH+5TbKgA7s2CC+TT+64WZ3f6jpCRYJ9ZzF8b
	 rmTXggxKT6OozcP0R2oc7FOMV2CMe0E0uNRGhO1carWKmNxg4cL5tynV+Ukk1v4tqJ
	 3orUAj+7Fk3Ng==
Subject: Re: [PATCH net] can: peak_usb: add missing dev_free callback to
 cancel restart_timer
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, s.grosjean@peak-system.fr,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com, kuba@kernel.org
Date: Sun, 25 Oct 2026 09:02:22 +0000
Message-ID: <179291894217.3130.4987191792366475143@kernel.org>
In-Reply-To: <20261023195400.3531721-1-tristmd@gmail.com>
References: <20261023195400.3531721-1-tristmd@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only shuts down the restart timer in the new dev_free
  callback, and the core never calls dev_free when pcan_usb_init()…
- [Low] The commit message says "If a bus error armed the timer via
  mod_timer()".

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pcan_usb_restart_pending() (pcan_usb.c:332-342) arms restart_timer…
- [Low] This problem wasn't introduced by this patch, but
  peak_usb_ndo_stop() never cancels restart_timer.

--

can: peak_usb: add missing dev_free callback to cancel restart_timer

This adds a pcan_usb_free() dev_free callback to the PCAN-USB adapter.
The callback calls timer_shutdown_sync() on restart_timer. The goal is
to stop the timer from firing on freed memory after
peak_usb_disconnect() calls free_candev().

> The PCAN-USB adapter uses a restart_timer for bus error recovery
> but does not define a dev_free callback.  When the device is
> unplugged, peak_usb_disconnect() calls free_candev() without
> cancelling the timer.  If a bus error armed the timer via
> mod_timer() and USB disconnect races with it, the timer fires on
> freed memory.

[Severity: Low]
This isn't a bug, but is "If a bus error armed the timer via mod_timer()"
fully accurate? The only mod_timer() call on restart_timer is in the
completion handler for the async bus-on URB:

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart_pending() {
	...
	/* the PCAN-USB needs time to restart */
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
	...
}

That URB is only sent on the bus-off restart path:

peak_usb_set_mode(CAN_MODE_START)
  -> peak_usb_restart()
    -> pcan_usb_restart_async()

The timer also stays armed for only PCAN_USB_STARTUP_TIMEOUT (10 ms).

Could the commit message mention the bus-off restart (CAN_MODE_START)
path and the 10 ms window? That would help stable backporters judge
how reachable this is.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 8fd058c328564..b0b3c76b2ccb8 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
>  	return pcan_usb_set_ext_vcc(dev, 0);
>  }
>  
> +static void pcan_usb_free(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev =
> +		container_of(dev, struct pcan_usb, dev);
> +
> +	timer_shutdown_sync(&pdev->restart_timer);
> +}

[Severity: High]
Does this cover every path that frees struct pcan_usb? In
peak_usb_create_dev(), dev_free is only called under the adap_dev_free
label, and a dev_init failure jumps past that label:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
	...
	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
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
	...
}

pcan_usb_init() sets up the timer before a USB command that can fail:

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

pcan_usb_get_serial() does a blocking usb_bulk_msg() with a 1000 ms
timeout. It can fail with -ETIMEDOUT, -EPIPE, -ENODEV or -EPROTO.

The netdev is already registered during that window, so something like
udev or systemd-networkd can bring it up. Suppose the controller then
goes bus-off and is restarted, either through restart-ms or by hand.
The bus-on URB completes into pcan_usb_restart_pending(), which calls
mod_timer() without checking urb->status. So the timer gets armed even
if the device is unplugged mid-probe.

If pcan_usb_init() then returns an error, free_candev() frees the
private area holding restart_timer while the timer is still pending.

Can pcan_usb_restart() then run on freed memory? That would be the same
use-after-free the commit message describes for disconnect.

A dev_set_bus failure goes through adap_dev_free, but a dev_init failure
does not. Should the timer also be shut down in the pcan_usb_init()
error return, or on the lbl_unregister_candev path?

[ ... ]

> @@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
>  	.dev_decode_buf = pcan_usb_decode_buf,
>  	.dev_encode_msg = pcan_usb_encode_msg,
>  	.dev_start = pcan_usb_start,
> +	.dev_free = pcan_usb_free,

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch:
peak_usb_ndo_stop() never cancels restart_timer. pcan_usb has no
dev_stop callback, and the restart URB is not anchored, so
peak_usb_unlink_all_urbs() does not kill it.

If the timer is still pending after close, it can fire and overwrite
the stopped state:

peak_usb_ndo_stop()
    dev->can.state = CAN_STATE_STOPPED;

pcan_usb_restart()
  -> peak_usb_restart_complete()
       dev->can.state = CAN_STATE_ERROR_ACTIVE;
       netif_wake_queue(dev->netdev);

Is it expected that a downed interface can end up reporting
CAN_STATE_ERROR_ACTIVE and have its queue woken?

On disconnect, the new timer_shutdown_sync() only runs after
unregister_candev() in peak_usb_disconnect(). The callback can therefore
still run against a netdev that is being unregistered. This is not a
use-after-free, because free_candev() comes after timer_shutdown_sync().

[Severity: Medium]
This is also a pre-existing issue that this patch does not introduce:
pcan_usb_restart_pending() arms restart_timer without checking
urb->status.

Suppose the set bus on command failed or was cancelled (-EPIPE, -EPROTO,
-ENOENT, -ESHUTDOWN). Ten ms later, peak_usb_restart_complete() still
marks the controller CAN_STATE_ERROR_ACTIVE and wakes the TX queue.

Could the driver then report error-active and accept TX frames while
the SJA1000 is still bus-off? The state is no longer CAN_STATE_BUS_OFF,
so the CAN core would not try another restart.

This same unconditional arming is what lets the timer be armed during an
unplug in the dev_init failure case above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023195400.3531721-1-tristmd%40gmail.com
