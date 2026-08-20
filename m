Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428A37DE89;
	Thu, 20 Aug 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242482; cv=none; b=rqw/BXg+B+ZcG6eeq6KQSEDUVpfm2DUqq6qGjYxqtJyXDsB1ITM28pN8ZebU9BOmkjO2oH2XW6fc+jMqiC3cmb345NvzoI2trlDKLvx+iWYJu3n2vY0Gl/ZxUcxFGFe8ey/t67M1vwkP+cbY6njNXZzBLSplv7yQRD5j5mzCJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242482; c=relaxed/simple;
	bh=ZRGVDy6MVJpyH4vl/WPe3NwbmgOMxB4GnKQDVJdwC6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gmHk8i3DEyARTODElhmEgJt/qmIpRhPPO3mkSK6yMLpvMKlXFqMMUF0nhK71iJqAiQAzvnqisgvxkZSOS7U+bcQuyxLRowa4zZSSsC3ZOb17UssmTJtkveP7HMaWzv370EPKAMUXvn65uk4titbAbXReati0sfgZW2kzGDCk26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aen8I0X+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aen8I0X+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1731F00A3A;
	Thu, 20 Aug 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787242480;
	bh=ecDs6nQW5H+UbsG7tzPB5R+FTyp3bqV3LZLa1PG4xPM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Aen8I0X+40a2p6XyyQO2Hw8i09xDP8Q50/PLDZYtsauhD7Qt2MfVF43CiQUlzCCCz
	 qvjD9E2+OuDbVeCcQ5pFKDpoFrGlZfTRLemLoADinbCGecN+jop3GaykcXzn8Wl572
	 D6q+Yx35UvmAcS8WvJslRbamZ4vrSuht9b00OjoaYkJjhmWUutDYBCpjsYtxHhTQFA
	 P1AHVePcifZxYGQgBmzmmEobALpHQmAN3vAUBMuQVzgMXXPx/W/j7+yyUF6ds9rYJE
	 YorbmHYHR7fD3BouDAWN4qRC/yohnIdkJ6/82zF/LNCcT0iDADQzDUmGiz5Kns6MxM
	 MjwH0A8V0oLnw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 18:14:37 +0200
Message-Id: <DKTWKZFYC6TL.2ZESRE0NWAV2T@kernel.org>
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached
 knode_driver
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Nguyen Quang Le Kien" <khiemtranzo532001@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <2026082042-coma-moody-5b4e@gregkh>
 <20260820084557.129908-1-khiemtranzo532001@gmail.com>
In-Reply-To: <20260820084557.129908-1-khiemtranzo532001@gmail.com>

(Cc: linux-usb)

On Thu Aug 20, 2026 at 10:45 AM CEST, Nguyen Quang Le Kien wrote:
> Fixes: 94e7b1c5ff20 ("[PATCH] Add a klist to struct device_driver for the=
 devices bound to it.")

This is not the correct commit to reference, this commit seems fine.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 60c005223..4154b4499 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1354,7 +1354,8 @@ static void __device_release_driver(struct device *=
dev, struct device *parent)
>  		device_unbind_cleanup(dev);
>  		device_links_driver_cleanup(dev);
> =20
> -		klist_remove(&dev->p->knode_driver);
> +		if (device_is_bound(dev))
> +			klist_remove(&dev->p->knode_driver);

This looks like band-aid for the underlying design tension in the USB core
(which we should address instead) and does not belong in the driver core.

It's not visible from the above diff, but with this patch the control flow
becomes:

	if (dev->driver) {
		if (device_is_bound(dev))
			klist_remove(&dev->p->knode_driver);
		...
	}

but dev->driver already indicates that the device is bound to dev->driver i=
n
this context.

The reason we "need" this check regardless is that usb_driver_claim_interfa=
ce()
(ab)uses dev->driver to indicate that a certain USB driver claimed, or rath=
er
reserved, this device.

There are two cases in usb_driver_claim_interface():

  (1) The device to claim is already registered with the driver core, in wh=
ich
      case device_bind_driver(dev) is called and dev->driver is correctly s=
et
      during the bind attempt.

  (2) The device to claim was not yet registered with the driver core. This=
 can
      happen when the USB interface the driver actually binds to is registe=
red
      (and hence probed) before the additional interface the driver wants t=
o
      claim is registered. The USB core sets dev->driver independent of the=
 bind
      state to indicate it has reserved the interface.

The first case is perfectly fine, but the issue with the second case is tha=
t now
dev->driver is semantically overloaded:

The USB core treats it as "dev is reserved for dev->driver" and the driver =
core
treats it as "dev is currently binding or bound to dev->driver", but that's=
 not
actually the case yet, since device_bind_driver() hasn't been called yet.

IOW, dev->driver should only be set under the device lock before calling
device_bind_driver(), and, in case of failure, should be cleared after
device_bind_driver() with the device lock still held.

Besides the reported crash, another implication of this is that all other
functions from device_release_driver() are called as well, even though
device_bind_driver() was never called before, and there is no guarantee tha=
t
this does not cause other unexpected side effects already or in the future.

I think one solution could be to add a new claimed field to struct usb_inte=
rface
to indicate that the interface is reserved for a certain driver and make
usb_device_match() reject the device if ever probed otherwise.

Another solution (but that's a bit more work) would be to separate interfac=
e
registration from interface probing in usb_set_configuration(). Of course t=
hat
needs help from the driver core as well, but it would also get us rid of th=
e
slightly odd situation that a driver may operate a claimed device already, =
even
though it is not yet registered with the driver core.

I'd suggest going for a claimed field in struct usb_interface first to fix =
the
immediate problem and then take it from there.

That said, I wonder if there's more to think about with the
usb_driver_claim_interface() / usb_driver_release_interface() API.

After having a brief look it seems that drivers have invented various diffe=
rent
approaches to protect against the case where userspace could write the clai=
med
interface's name to:

	/sys/bus/usb/drivers/<driver>/unbind

I think this could be much cleaner if the driver core would support "claime=
d"
devices" natively. OTH, there's only ~20 drivers across USB and PnP though,=
 so
probably not worth.
