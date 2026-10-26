Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048584;
	b=NoARF7zA29XEn4kk3KfDVsWHlqP6GVbJnp43Gu/XJesYyjN7NchcwZAkPXR2s9jNMyYD
	 Qs5Ye1EWL/smxP/N8uTxWD8/+aDpTmCM8e0qQejaJtQKS240QITHXS3b+tYdqLzYZtadd
	 jnQNHCZawOL5R3SDyCjBn5GWcbLCl3oOkFf7wQcfuxNZrKJqtuqP+ks4IlsGTn2+RPs/F
	 8FPCQVj/KlR65eijeSr5I5Z9vIkShiuEnth0DCACDI4J/FeId8qzBZvZ0ezyrussHXMSP
	 e5fwgG2uVR5Vw/dbfsuD/f9swofcEAyqfcf4VE0Ph69CfvQfQ4pD/XBxiPk1pvu1dmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048584;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LFkqjIv81T19voHWzA/o75LZt0tWb9aNUnrHiNKDn5I=;
	b=VGwwCIksKDGLidkcy0ud0C9NZd9ekIwkH0ZI6wfPFPNusUOkMQYXH+urlasbhflh1Y7x
	 bwhfgdhyieGcasi6QX9nfbX41wulXtYT9ONRUAoYk5AtxBzWeefiHv5nexj6CqLS3QJD4
	 0CiheXtqy27xP+NT8+b3rvImdWiBvMziBZg4IaQbsheV2Im79ve3t13LQjPA1bTwpnxKY
	 Osq1MLVBAwQJX88dQPzTMGpO4G6KM2jQA2RNq4D4jb7fMwKNoaBQZyZoEI3s0/ed+i7kX
	 JVemZF22z5MZj+VKEWEa+xP7mWkCuYgBW8Rmtk6bJGwVpvRRRjf/AZ21hgI4h6xfSag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BahwtOYa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA7606A31A;
	Mon, 26 Oct 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BahwtOYa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1691C1F01828;
	Mon, 26 Oct 2026 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048584;
	bh=LFkqjIv81T19voHWzA/o75LZt0tWb9aNUnrHiNKDn5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BahwtOYaM95Vgk0WiLVqlRl9+bpMG/sIr8J6xiuG1xOsiUrIFEnszBL4HvRdIr/e9
	 vQx3NS1MKmmiLjKkr5U9GkN9oWuRcpyS36+3sr4Yke2unNsrufw9ZnHYGN1askVpuc
	 hkKHsk0gxqhwTavh4Mxepa7+4TUjv/LzzMixdVYz5ihjgNW4Sv+SDfCCSa4AthaK/+
	 HZ7PUDBxL+c3V/HBcqL8jJpB0VaikwCQf2z4fEgdPveIYU2hzFadtI92uT1Qouthcg
	 OQp0C8v+uN/cW5nRtok95KIToq0hxcsajYl52tp4PlEf2r2BP1gX3aY4S9ubUQohGt
	 JoMDzAsbxwNiA==
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB
 disconnect and init failure
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, s.grosjean@peak-system.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Mon, 26 Oct 2026 21:03:03 +0000
Message-ID: <179304858361.3134.1029344134259623994@kernel.org>
In-Reply-To: <20261025210256.629830-1-tristan@talencesecurity.com>
References: <20261025210256.629830-1-tristan@talencesecurity.com>
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

- [High] The patch does not fully fix the init-failure use-after-free it
  claims to fix.

--

can: peak_usb: fix use-after-free on PCAN-USB disconnect and init failure

This patch adds a pcan_usb_free() dev_free callback that shuts down the
restart_timer with timer_shutdown_sync(). It also shuts the timer down
directly in pcan_usb_init() when reading the serial number fails. The goal
is to stop the timer firing on freed memory after disconnect or after a
failed init.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 8fd058c328564..440d8e2cfb6fe 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c

[ ... ]

> @@ -901,6 +909,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
>  		dev_err(dev->netdev->dev.parent,
>  			"unable to read %s serial number (err %d)\n",
>  			pcan_usb.name, err);
> +		timer_shutdown_sync(&pdev->restart_timer);
>  		return err;
>  	}

[Severity: High]
Does this fully close the init-failure use-after-free? An asynchronous
restart URB can still re-arm this timer after pdev has been freed.

In peak_usb_create_dev(), register_candev() is called before dev_init():

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
}

So the netdev can be brought up while pcan_usb_init() is blocked in
pcan_usb_get_serial(). If a bus-off restart happens in that window
(restart-ms or CAN_MODE_START), this path runs:

peak_usb_set_mode()->peak_usb_restart()->pcan_usb_restart_async()

and pcan_usb_restart_async() submits a URB with pdev as its context:

	usb_fill_bulk_urb(urb, dev->udev,
			usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
			buf, PCAN_USB_CMD_LEN,
			pcan_usb_restart_pending, pdev);

	return usb_submit_urb(urb, GFP_ATOMIC);

This URB is never anchored. Only rx_submitted and tx_submitted are
anchored, so peak_usb_unlink_all_urbs() neither kills it nor waits for it.

If the serial number command then fails, the timer_shutdown_sync() added
here only waits for the timer callback. The timer is not armed yet,
because the URB has not completed.

The unwind then goes through unregister_candev() and free_candev(). The
probe failure path in usb_probe_interface() does not flush the interface
endpoints either.

When the URB completes later, from a late device ACK or from an unplug
that flushes the endpoint, can pcan_usb_restart_pending() touch the
freed pdev?

static void pcan_usb_restart_pending(struct urb *urb)
{
	struct pcan_usb *pdev = urb->context;

	/* the PCAN-USB needs time to restart */
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
    ...
}

Once the memory has been reused, the shutdown marker on the timer is gone.
That means mod_timer() could enqueue a timer that lives in freed storage.

The disconnect path looks fine, since usb_unbind_interface() flushes the
interface URBs before calling ->disconnect. The init-failure path the
commit message names does not look closed, though.

Would it work to delay register_candev() until dev_init() succeeds? The
other option is to anchor the restart URB and drain it before shutting
down the timer and freeing the candev.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025210256.629830-1-tristan%40talencesecurity.com
