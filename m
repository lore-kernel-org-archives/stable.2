Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616169;
	b=076mNFy+Z6M8zR5Qiz/hT5gjPTU4RMU90z+FOitLHHzCSR1NA8c58/5jpSGxYF6MzVzc
	 VqYNamYXZpG7t/1PTo11tLJFKYjviMCraj3XzzodP3VPBz4yHKmY9qfpDlmrOklTO494N
	 xds41HL48WXPBQP8hxNgkxHxgCn40GBwOuF8aGGtjdoCkQstQZyIChry3uONEmqSvl0M6
	 1dqQYpbp9kdv/xARORelGDuF/7vW6sdQBJSpPTSTCrn1NwyyTN3dXyqv7a1zwU1dWyzQ/
	 CvFL6NU3SIGaW5h27c2VPMrdGkyD9FslZ3EkCfYTAiCWEfBVQ7ixx2h2yQGNqk9bV3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616169;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=mMaVZ5dFPhI7ea1hZPLNuaqG6WnMEb7dPu4JlaIOODg=;
	b=1dt7txDJPFn1S1y2w6k5wSiOZK+mfIdes423acIUFJpeCZo6HHRVDQbtKfpHq+jMpUi0
	 OHZiMzXE17MKW2Bd6qcirlYVuplaNNRyyqX/PjapIFVj4agmyRnGhjlip6/Y2gUBTmKW6
	 xRquNwBZdYc77X/2Y0zntfml4cFaW4w5pK6lr2//X8QNOnxUyodlMFXP7RL6rcEx+xLQ4
	 V6IU07LQ4CSiHxDAXbQkiYQHLJjj5fdZULDj36s0QT41BneVp5B7UbbqhnyMbXcHMKCMo
	 kxiuIbC7ewx/+rLy4b+NRw85Jiy2YluZRKmJ/NbP6ld8Q2GtbP54S7YYbaprHmdvLsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail2 header.b=UtVJlH3R;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E05606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49E05606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail2 header.b=UtVJlH3R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail2; t=1795616163; x=1795875363;
	bh=mMaVZ5dFPhI7ea1hZPLNuaqG6WnMEb7dPu4JlaIOODg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UtVJlH3R74vREbXn9+g8M8hIK6cFDjImNsEdSvxcF76Bw2g6OAQVShQSyKJtQUu/W
	 +g/40aWbG1dwdgp5VIx9KP9KkFtl0vL+OBQo8kzCojnlUxLmG11ZuFIsM8COY3U2VR
	 PIxwOLR4YL3I9eyMn4gZ1ZdyVLSGQafResZqxBcio/XC1Wm1aVoyuVAi6UAlVI7sGj
	 OmyiC0w6ac25LryNxF58f0X8agv29mbJ8G1YSyMf9FxBPLj6oHfXwQK3ADPeajErE/
	 hRqeTc/ZwDyDe7tewS78K2ceuEFZv0TwYIWz/l3Prly83bzPQGEHfhOFuYRcOjag95
	 yMQCa0L6rvXaw==
Date: Wed, 25 Nov 2026 14:16:00 +0000
To: Pavel Skripkin <paskripkin@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Yasushi SHOJI <yashi@spacecubics.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, stable@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcba_usb: Fix double free of RX buffers in mcba_urb_unlink()
Message-ID: <YzORDJ6g27PstCrzykJe0VfFOAHc6ldlm4jPwzG-5fc3mrb79JxuFpIgDcpjPGdlj9W4NkXSq42xWNr-FqPDOjq-hrcGqRAxp3i12qFUtks=@becholey.ch>
In-Reply-To: <5205f6b8-66a7-4869-bc94-1c8831b1ec24@gmail.com>
References: <20261119085329.539894-1-alex@becholey.ch> <5205f6b8-66a7-4869-bc94-1c8831b1ec24@gmail.com>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: f2583886a52e5b187f5cc1f9705cc2b546cffb38
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sunday, November 22nd, 2026 at 10:51 AM, Pavel Skripkin <paskripkin@gmai=
l.com> wrote:

> Hi Alexandre,
>=20
> Alexandre Becholey <alex@becholey.ch> says:
> > mcba_urb_unlink() frees the RX buffers but leaves the stale pointers in
> > priv->rxbuf[]. It runs from both mcba_usb_close() and
> > mcba_usb_disconnect(), so once the interface has been up, the buffers
> > are freed twice: on unplug after "ip link set can0 down", on unplug
> > while can0 is up, or on a second up/down cycle. No special device
> > behaviour is needed; on a host controller without DMA the double
> > usb_free_coherent() is a double kfree().
> >
>=20
> Sounds reasonable.
>=20
> I wonder, tho, did you test on real HW or used emulated one via usb gadge=
ts?

Emulated on a raw-gadget program on dummy_hcd that behaves like the
adapter. I don't have a real hardware to test with.

>=20
> What caught my eye is that mcba_usb_open() never reallocates URBs closed
> in mcba_usb_close(). So I'd expect device to not work properly after
> second "ip link set can0 up".

Indeed "still works" only meant that the second "ip link set can0 up"
succeeds. After down/up the adapter no longer receives. It seems that
has been the case since the driver was added (51f3baad7de9) and this
patch does not change it.

>=20
> Maybe it shouldn't close them at the first place?

That would fix both: if mcba_usb_close() only kills the TX URBs, the
RX URBs keep running across down/up, as they already do before the
first up, and mcba_usb_disconnect() becomes the only place that frees
the RX buffers, so the double free goes away as well. The other way is
to set up RX in mcba_usb_open() and free it in mcba_usb_close() only.
However, the firmware version requests sent at probe rely on RX running.

Would you prefer a v2 that keeps the RX URBs running in close (fixing
both issues), or this minimal fix for stable and the RX restart as a
separate patch?

>=20
>  > Clear each rxbuf[] pointer after freeing it, which makes the
> function> safe to call twice again, as it was before commit 91c02557174b
> ("can:
> > mcba_usb: fix memory leak in mcba_usb").
> >
> > The bug was found, and the reproducer and this fix were written, by AI
> > agents (Claude Mythos and Claude Opus models). The analysis and the
> > patch were reviewed by a human.
> >
> > Fixes: 91c02557174b ("can: mcba_usb: fix memory leak in mcba_usb")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexandre Becholey <alex@becholey.ch>
> > ---
> > An emulated adapter on dummy_hcd: "ip link set can0 up/down", then
> > unplug, gives a KASAN double-free in hcd_buffer_free() on v7.3.1 and
> > master 9d66f26fefac; the two other sequences as well. All clean with
> > the fix, and a second "ip link set up" still works.
> > Reproducer available on request.
> >
> >   drivers/net/can/usb/mcba_usb.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_=
usb.c
> > index 04170326dc7e..b40b323da9d3 100644
> > --- a/drivers/net/can/usb/mcba_usb.c
> > +++ b/drivers/net/can/usb/mcba_usb.c
> > @@ -718,9 +718,11 @@ static void mcba_urb_unlink(struct mcba_priv *priv=
)
> >
> >   =09usb_kill_anchored_urbs(&priv->rx_submitted);
> >
> > -=09for (i =3D 0; i < MCBA_MAX_RX_URBS; ++i)
> > +=09for (i =3D 0; i < MCBA_MAX_RX_URBS; ++i) {
> >   =09=09usb_free_coherent(priv->udev, MCBA_USB_RX_BUFF_SIZE,
> >   =09=09=09=09  priv->rxbuf[i], priv->rxbuf_dma[i]);
> > +=09=09priv->rxbuf[i] =3D NULL;
> > +=09}
> >
> >   =09usb_kill_anchored_urbs(&priv->tx_submitted);
> >   }
>=20
>=20
> With regards,
> Pavel Skripkin
>=20

Kind regards,
Alexandre
