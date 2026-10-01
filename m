Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77A37E5EE;
	Thu,  1 Oct 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851650; cv=pass; b=ojnFBsvgQqC8K9vQJsYv3U8sVM/h35SrrJVFAyVV2tNQM13vS3yOTbzBYQdWR9qsg8fDiJzjaILkV8uEar8M5pOSM9R+oMtvTUqjakuuriI91NwHyZVov0NyLXD8V9qaSRuoAbdxmNBWzU249fVwqn0NDOIqXa9cqyanxwlEwvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851650; c=relaxed/simple;
	bh=+lFWcyFQYb2mFHnHZisErL/qluZzCEXAFlVy42Uijm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFfCvb5VjrYMDrjOe4KmkoOlVGSY1PzF4b2vKSNkD+Y1UDQQwtcB5Hqh2ZrLQYOS/vJ4iPsGG3ESQxiTlCCrnuF79et65ypQuEu4aNLNIRxxp6SHLvdSSTQvKdNsAVDpEsHFICpFIoUV18otAyuYuUEOXaLNhTAN4HCiDWg38mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gYXz8WrX; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gYXz8WrX"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A554A201F0C;
	Thu, 01 Oct 2026 12:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790851637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7u4gC15OijOg67uF6YXbBQyJH91BBmCn2PR4YPMTrg=;
	b=gYXz8WrXc6NqBE+9eg1IzlaL9TvsmCSxL4si6K5m4feBFcnRandqBN/X3RKNs5ZV69zK3I
	vTNmpIcyimiSUSOO7cyXrrIEyLhWRR89pWAm7+o4tKB5Ng1iS0sqvfoPPvIjFiHB4b5aB7
	7+VSqG2N86K2CZX6VbgjC1LI61Dicp4a/UJ0tTxrKFcTM3z9m3VDlpQ5puiUty+X3gLvro
	KQ9/dGrJnwadMBeNRkH+STsjZkpoCHs/jw4QTqadDCfFqmXSX6MuhTdEwFydJUbU6I8zU+
	VJ/FwBP94dv81ixl56LTMUgkM+xClPKUaZ3diM6g7g+3o08W6ZCz2KlwTjCiQw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790851637; a=rsa-sha256;
	cv=none;
	b=aqZ+QyaQaaw5xtL3pI4YewxuueGwFP2DDy68nIjO6YKOcMeHd2H7kpQOUw9T5+jaZx5k3e
	KCtFN2rmeohOuVRSXvmdPgNlrOtdRJNxFbAN4gCl3scqC1I+yN5lOgTzMlOBJYmTKcB/0r
	A5aZm3rYPrrV0t4iFX0LXirRX7XVqQuKkYgVqictOEMGkjTDAnOhzK6ARcVoWZQc8VNWiH
	yWLr7SCd1o7IJ9NAToD5j5y2ATe3S9UHAkqHIEVMtcSNt0GXArCVXLHgtdEYJ+ZDWRNujE
	zlHLUf8czCRxJDXu3oG8qGvGi4GG9W74evLRfteyP18h4pUIzPvz5ZXmOJM6TA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790851637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7u4gC15OijOg67uF6YXbBQyJH91BBmCn2PR4YPMTrg=;
	b=Ck5CK2W488Fioy18IScWOoLyCZ/Q/Vmt/hVg5ajrJFElf+lBSephInbOTOKOmiIsZ9YuGI
	u72vo/AdncgNJdEWF2Deqlv0lk0QjJ7AEQtfFd1mFG5I6IyssYZI3hVXAi4kJcLliZ/c28
	jWlsZoEUS9OU5OvwdevoHJEbf3uBNteu1KlUhPUsf2fgqebaLn6PS2MG6jYleRfdJ9t3Te
	tLmGma/oy/eQwLvm71+sOeOFxKJsovkzMm/O27mCuiPXLsSofM3ob/T8lH/6YdnYkECHTt
	wDpEIz58LdFJ/NjcJSdBHxg7j1aJDKXQqmLSWNBUhDgrnZN21SMmR574Jjs3qA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCEJp-003iC3-1d;
	Thu, 01 Oct 2026 12:47:17 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 36A545B75DC;
	Thu, 01 Oct 2026 10:47:17 +0000 (UTC)
Date: Thu, 1 Oct 2026 12:47:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
Message-ID: <20261001-pristine-bird-of-tempest-80dd3c-mkl@pengutronix.de>
References: <20260923070352.487595-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtqnkg77tca34jth"
Content-Disposition: inline
In-Reply-To: <20260923070352.487595-1-fanwu01@zju.edu.cn>


--vtqnkg77tca34jth
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
MIME-Version: 1.0

On 23.09.2026 07:03:52, Fan Wu wrote:
> gs_usb_disconnect() destroys the channels one by one via
> gs_destroy_candev()/free_candev(). gs_can_close() disposes the RX bulk
> URBs on the shared parent->rx_submitted anchor only when the last
> active channel is closed. With two or more channels up, the earlier
> channels are freed while their RX URBs are still submitted, and a
> completion in gs_usb_receive_bulk_callback() accesses the freed struct
> gs_can and struct net_device.
>
> Fix this by killing the anchored RX URBs in gs_usb_disconnect() before
> the first netdev is destroyed, and in the error path of gs_usb_probe()
> before the previously created netdevs are destroyed.
>
> usb_kill_anchored_urbs() waits for running completions and a killed URB
> completes with -ENOENT, so the completion handler returns without
> resubmitting the URB. The kill in gs_can_close() of the last active
> channel then operates on an already empty anchor.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

The netdev review pipeline has some remarks about the
usb_kill_anchored_urbs:

| https://netdev-ai.bots.linux.dev/sashiko/#patch-15522

Please have a look and send a v2 patch.

regards,
Marc

--- Patch [11]: [PATCH net 11/16] can: gs_usb: kill RX URBs before destroyi=
ng the netdevs ---
commit 4b68d32240b11c912a1f8bfe710a965b66660960
Author: Fan Wu <fanwu01@zju.edu.cn>

can: gs_usb: kill RX URBs before destroying the netdevs

This patch moves usb_kill_anchored_urbs() in the gs_usb_probe() error
path so that it runs before the previously created candevs are destroyed.
It also adds a kill in gs_usb_disconnect() before the first netdev is
destroyed. The goal is to stop RX completions in
gs_usb_receive_bulk_callback() from touching a freed struct gs_can and
struct net_device.

Link: https://patch.msgid.link/20260923070352.487595-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3b9b2f104d868..f604358c8259d 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *int=
f,
>
>  			/* on failure destroy previously created candevs */
>  			icount =3D i;
> +			usb_kill_anchored_urbs(&parent->rx_submitted);
>  			for (i =3D 0; i < icount; i++)
>  				gs_destroy_candev(parent->canch[i]);

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: sashiko-gemini =C2=
=B7 Ranked Critical by: gpt-6-astra
Is the probe error path still exposed to the same use-after-free?

usb_kill_anchored_urbs() kills the URBs once but does not poison the
anchor. The netdevs canch[1..icount-1] stay registered and can be opened
while canch[0] is unregistered and freed. The endpoints are also still
enabled during probe, so new submissions succeed.

A possible sequence:

gs_usb_probe() error path
  usb_kill_anchored_urbs(&parent->rx_submitted);
  gs_destroy_candev(parent->canch[0]);
    unregister_candev()
    free_candev()
                              ip link set can1 up
                              gs_can_open()
                                if (!parent->active_channels) {
                                  ...
                                  usb_anchor_urb(urb, &parent->rx_submitted=
);
                                  rc =3D usb_submit_urb(urb, GFP_KERNEL);

A gs_can_open() that is already running when the kill happens is not
serialized with it either, so it can keep submitting URBs after the kill.

If the device then sends a frame with hf->channel =3D 0, it passes the
range check, and gs_usb_receive_bulk_callback() does:

	dev =3D parent->canch[hf->channel];

	netdev =3D dev->netdev;

Both of these reads hit freed memory. The canch[] slots are never cleared,
so the device_detach loop could also call netif_device_detach() on the
freed netdev.

The disconnect path doesn't seem to have this problem, because the
endpoints are disabled there and resubmission fails.

Would usb_poison_anchored_urbs() work here, or unregistering every netdev
before freeing any of them? The later HScanT workaround commit in this
series doesn't appear to change this teardown logic either.

>
> -			usb_kill_anchored_urbs(&parent->rx_submitted);
>  			kfree(parent);
>  			return rc;
>  		}

Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =C2=
=B7 Confirmed by: gpt-6-astra =C2=B7 Ranked Critical by: gpt-6-astra
This isn't a bug introduced by this patch, but
gs_usb_receive_bulk_callback() only checks that hf->channel is in range
before it dereferences the slot:

	if (hf->channel >=3D parent->channel_cnt)
		goto device_detach;

	dev =3D parent->canch[hf->channel];

	netdev =3D dev->netdev;

gs_usb_probe() sets parent->channel_cnt to the full icount before it
creates any channel. gs_make_candev() also calls register_candev() before
the next channel is created.

Suppose can0 is brought up while gs_make_candev(1) is still running its
control transfers, each with a 1000 ms timeout. Could a frame with
channel =3D 1 then dereference the NULL canch[1] in URB completion context?

Something similar happens when gs_make_candev(i) fails, because
gs_usb_probe() stores the ERR_PTR in parent->canch[i]:

	parent->canch[i] =3D gs_make_candev(i, intf, &dconf);
	if (IS_ERR_OR_NULL(parent->canch[i])) {

A completion with hf->channel =3D i would dereference that ERR_PTR. This
applies to a completion that runs before the kill, or to one from URBs
resubmitted after the kill as described above. The device_detach loop
only checks "if (parent->canch[rc])", so it would also pass the ERR_PTR
to netif_device_detach().

Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =C2=
=B7 Confirmed by: gpt-6-astra =C2=B7 Ranked Critical by: gpt-6-astra
This is a pre-existing issue, but gs_make_candev() calls register_candev()
before gs_usb_probe() has finished setting up the channel:

	parent->canch[i]->parent =3D parent;
	...
	parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);

If the netdev is opened before dev->parent is assigned, gs_can_open()
reads a NULL parent. It then dereferences it at
"if (!parent->active_channels)".

There is a second problem with hf_size_rx. Take a classic, non-timestamp
can0 that is opened while later channels are still being probed.
gs_can_open() allocates its RX buffers with
kmalloc(dev->parent->hf_size_rx), which is 20 bytes at that point.

A later channel that reports FD and HW_TIMESTAMP raises
parent->hf_size_rx to struct_size(hf, canfd_ts, 1), which is 80 bytes.
The resubmit path then reuses the old buffer with the new size:

resubmit_urb:
	usb_fill_bulk_urb(urb, parent->udev,
			  parent->pipe_in,
			  hf, parent->hf_size_rx,
			  gs_usb_receive_bulk_callback, parent);

Can the device then DMA up to 80 bytes into the kmalloc-32 object? These
URBs keep being resubmitted until all channels are closed.

> @@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interface =
*intf)
>  		return;
>  	}
>
> +	usb_kill_anchored_urbs(&parent->rx_submitted);
> +
>  	for (i =3D 0; i < parent->channel_cnt; i++)
>  		if (parent->canch[i])
>  			gs_destroy_candev(parent->canch[i]);

Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =C2=
=B7 Confirmed by: gpt-6-astra =C2=B7 Ranked Critical by: gpt-6-astra
This isn't a bug introduced by this patch, but should gs_usb_disconnect()
cancel parent->timestamp before the kfree(parent) that follows?

The shared work is started and stopped based on the feature bits of
whichever channel opens first or closes last.

In gs_can_open():

	if (!parent->active_channels) {
		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
			gs_usb_timestamp_init(parent);

In gs_can_close():

	if (!parent->active_channels) {
		usb_kill_anchored_urbs(&parent->rx_submitted);

		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
			gs_usb_timestamp_stop(parent);
	}

dev->feature is read per channel from the device's BT_CONST reply. Say
can0 has HW_TIMESTAMP and can1 does not. The sequence open can0, open
can1, close can0, close can1 then leaves gs_usb_timestamp_work()
re-arming itself with nothing to cancel it.

If can0 is reopened, gs_usb_timestamp_init() runs spin_lock_init() and
INIT_DELAYED_WORK() on a work item that is still armed. On disconnect,
kfree(parent) runs with the work still pending. gs_usb_timestamp_work()
would then use parent->tc_lock and parent->tc, and issue a control
message through parent->udev, all on freed memory.

In the opposite ordering, cancel_delayed_work_sync() runs on a
delayed_work that was never initialized.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vtqnkg77tca34jth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar46MgAKCRDMOmT6rpmt
0tSLAQCWXabEKLFj5YDcGsKjT6qqYj5jxTBnAOxGnoCqIPCr4wEAnwUg4EiB/Wku
8OX1luDjDim/pOqetm6ha2ixp/NHygU=
=z4oW
-----END PGP SIGNATURE-----

--vtqnkg77tca34jth--
