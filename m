Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF5352031;
	Mon, 24 Aug 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574648; cv=pass; b=R86dXhDRUdnpZQNmYUzBwm9jw2FuS92LJiXoG4XmRHgLu8n3KlpQK9u0EWmDsxQ1JzETsvgTq5mhY466vbOq/BHV7aOXhpfyOX7dZn3/XTrZLid7T5KUn8ueSljqePKpAbxJ5JA6LzIjCz5izZ2utuDdSmlDnMLpP1gIDuNv4WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574648; c=relaxed/simple;
	bh=pNVnBdrLpuo1YSXINwKOs4MhRwi5tlLbSP+0RCTE7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAAI2cUpEg06E+NIHBW23mkuspnmteGrsfOpF6dj64kvq+u6cPG3bl696jzo3tIzoZ50Ev7nwKF/EwQSko9US6AfeI4kYTJP/GOzanyFlfXVteUg1yzpuv+Bt+Dc/f3xQelVpJAdvCF5of7o/w5/7D8Yzg3e4OyOd+IcQU201WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Y6nRdPBE; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Y6nRdPBE"
ARC-Seal: i=1; a=rsa-sha256; t=1787574631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RvEANc48T9hyFdkVwM8ehEmsZMjX6v69gkHlyNtGsS3doHk7D1EVt8VdjgqDhlezr0EwpzLwH04My42cBTKUd5AbcBjl0yEV/nt7NFX93iLDLfScS7y3TbTlivQfLIEkt43RxEFLSJ5K+ikTiB1nfoW+nYFPvm4RNj6Yz72JyBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787574631; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3inmB2Z2PbYZm0RylkoS9SCcCTHRnzUfcm31P9GssOM=; 
	b=WU3c+fHl/ropI9X63/pFfYe+yOiLTV0cHQJdBbIT3RXR9pA96BHCrT4ittZDHf0sXPMpTbQdDWufTx+cfE6XJSMrznYFic7x4GhVtNkaW5YXxZSzVfVFLcznuQE7FeDRchawaoIig5BS44qRbp5HjZFYys9tX0WnSX1F5f/22K8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787574631;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=3inmB2Z2PbYZm0RylkoS9SCcCTHRnzUfcm31P9GssOM=;
	b=Y6nRdPBEoXGUQsx5ub5kg7NhZF58pxax8ceFZTUBuzybh2rphS75An/g4pJRug2p
	D04XyO6a8/yTsE1uRJwAjIbyX/QQrlc/VuvqCvd+6xhmiYCpT4fuoaEvPMp0WfwVH0r
	lTn/gc5u+E0Vgdjz/HK6lw24ZTzQzRBqBx+3OYPE=
Received: by mx.zohomail.com with SMTPS id 1787574627310520.2698602900982;
	Mon, 24 Aug 2026 05:30:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id DECDB180830; Mon, 24 Aug 2026 14:30:23 +0200 (CEST)
Date: Mon, 24 Aug 2026 14:30:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
Message-ID: <aow2wbpZzN2oyWCv@venus>
References: <20260822072556.490594-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xv2tqlmurmywifm"
Content-Disposition: inline
In-Reply-To: <20260822072556.490594-1-marex@nabladev.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.552.98
X-ZohoMailClient: External


--4xv2tqlmurmywifm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
MIME-Version: 1.0

Hi,

On Sat, Aug 22, 2026 at 09:24:58AM +0200, Marek Vasut wrote:
> Some devices use combo PHYs (i.e. USB3 + DisplayPort), which also
> handle the lane muxing. These PHYs are referenced twice from
> the USB-C connector (USB super-speed lines and SBU/AUX lines)
> resulting in the mux being configured twice. Avoid this by
> dropping duplicates.
>=20
> This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
> duplicated mux switches"), with fix derived from usb: typec: mux:
> Fix typec_switch_match() .
>=20
> Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switc=
hes"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> - Extensive test by Jens https://lore.kernel.org/all/8bdf6062-8ec2-4c30-8=
463-0368d3a0f1ce@oldschoolsolutions.biz/

Thanks for the fixed version. It looks mostly good to me, but it
should also take the other fix into account and initialize
mux_devs to {} in fwnode_typec_mux_get():

https://lore.kernel.org/linux-usb/20260804083434.20885-1-i@4t.pw/

Greetings,

-- Sebastian

> ---
>  drivers/usb/typec/mux.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 2bc7e8edb3cbd..afa6fc1813978 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -277,7 +277,9 @@ static int mux_fwnode_match(struct device *dev, const=
 void *fwnode)
>  static void *typec_mux_match(const struct fwnode_handle *fwnode,
>  			     const char *id, void *data)
>  {
> +	struct typec_mux_dev **mux_devs =3D data;
>  	struct device *dev;
> +	int i;
> =20
>  	/*
>  	 * Device graph (OF graph) does not give any means to identify the
> @@ -292,8 +294,18 @@ static void *typec_mux_match(const struct fwnode_han=
dle *fwnode,
> =20
>  	dev =3D class_find_device(&typec_mux_class, NULL, fwnode,
>  				mux_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> =20
> -	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
> +	/* Skip duplicates */
> +	for (i =3D 0; i < TYPEC_MUX_MAX_DEVS; i++)
> +		if (to_typec_mux_dev(dev) =3D=3D mux_devs[i]) {
> +			put_device(dev);
> +			return NULL;
> +		}
> +
> +
> +	return to_typec_mux_dev(dev);
>  }
> =20
>  /**
> @@ -318,7 +330,8 @@ struct typec_mux *fwnode_typec_mux_get(struct fwnode_=
handle *fwnode)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	count =3D fwnode_connection_find_matches(fwnode, "mode-switch",
> -					       NULL, typec_mux_match,
> +					       (void **)mux_devs,
> +					       typec_mux_match,
>  					       (void **)mux_devs,
>  					       ARRAY_SIZE(mux_devs));
>  	if (count <=3D 0) {
> --=20
> 2.53.0
>=20

--4xv2tqlmurmywifm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqMOVgACgkQ2O7X88g7
+pojhg//YZzo6unqhGvO9Hmxu0MNjXVlQetPuewYf8o0P7hEHF7ZwrWZ2cCowTkm
305UYsckiFGj8/X1CCHdOkdDKGnxDddVk0q/3UJBpUZU+kdMEOYEgAIq/XC3h9+y
KZOn3ddZjHTB6KHDW3qsfM0lkOvWDCgzNEGr+cNwy21zue/NBofdMB+BgxhLAWIP
rgEGz8r0xvuS5zpUcHi9Dq9iXicmh4X+1rmetN39Om6dJdAPXK7TTotZrVTY7+3c
ZK6dEZJTB5/A/KyOHYuRqsuADrLjTpnoBsr2BvL+BqPBLN/GjuFkt9rfI2y3+8Ag
f84Gai54zJ96sQiXlgb2PU5dKELaPT2XYF+smiWUG6XRJ62dA0vyium2bi9m1EGE
BM1sM8TdX+HcAy75g4/kT60tgir/1hxHCQoH84LE6w/q43fYkWBAcmMK/5072uO6
ezeU6Oln9rxGWDoq7eWC3Q37jIXShuhBQDv2bYW9lqIx4iWxgtC9Atn+ZY+juPZ+
6FHvWul3xxN5l3t1+N+dFglGgfO8cBY17fBc4P4T7LVzlFkR0XLC/2Df/bBpLbCD
MkUaEBWkLjion8a0CVpaJST+5bszsHhhfbqSWwjsmgAMHyws23vH75jx1VzhGCHl
yFIfpqcl6BkbPq6YSdZntzl4bGVTtNQfflqN271gFqfU79GNAMM=
=g7r5
-----END PGP SIGNATURE-----

--4xv2tqlmurmywifm--
