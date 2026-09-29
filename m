Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C33A4F58;
	Tue, 29 Sep 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713625; cv=none; b=ACEElr9E4koVESeyKbYG9vQEP8ko07vFxk0uxuAGecb56sofJ9BVLkZ9t/KUltRkdkIA8X/DiyKxp72kFaRSQhJSs5Wd36nz1nvARxq+uN/jsP6LBDLB5OT0eUC6ew+6RUZS6Pd5nxRys1S50uXsAfxgysAEA89qjEnnPnp94iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713625; c=relaxed/simple;
	bh=DkHl216R8HsWOjEtGTLQqdSyQom/zGA2tKkvsdwDZYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RB+SthpFZ40/FCCEQNArPBzymemFKzl2/MvjKbYfxOqEBw7LxAltNCKDlKhlhv6eIRz3YqMpMkeo8yKbCbeAYxaYxJz/vh18OcYkV6DReRuEpiz1MxKcdcA00XqKE//uS4nyK72bcZ3HGz2jpcmRp2u6n+FzKi61Um/pRI5Jn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TvFU9C9P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TvFU9C9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790713618;
	bh=DkHl216R8HsWOjEtGTLQqdSyQom/zGA2tKkvsdwDZYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TvFU9C9Pbg/JzO7ElZRPimssQgIEjJ2O+y47e02mjN7B5re1GnOWJ2BbvYWhNNp17
	 T1Akjncag7PuCiEoPPfIgVDUzYd3K36JyRBSSy1aiIU5w/msMQugPDcHBt8mH7x1oP
	 GDfogMllekTuriiWr+Eo8jW4OC4m44QDMWYdGspci/W+OJ7Gdxt1i4mfXicmrZYp37
	 tcMnhLzHJNNzkkt78qjieaQWD6O7YSwK7vp5kVpiTY+enHh8SPxuR/5uobMpxfg9+2
	 Y1qT8xbzt77mkxXoZzgqqLW+x64NaHWHoVz8PYVlRYS1Z3VNk+bmFswyYVKDQOFwdL
	 nR3ngVmlMXtOg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D56F17E0B21;
	Tue, 29 Sep 2026 22:26:56 +0200 (CEST)
Message-ID: <90a604622a614a2de95820bdc73372a3e1d7fb41.camel@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: fix decoder child device leaks
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Tiffany Lin	
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Matthias Brugger	 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>, Hans
 Verkuil	 <hverkuil+cisco@kernel.org>, Kees Cook <kees@kernel.org>, Tomasz
 Figa	 <tfiga@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, Steve Cho	
 <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 16:26:54 -0400
In-Reply-To: <20260921090808.336112-1-lgs201920130244@gmail.com>
References: <20260921090808.336112-1-lgs201920130244@gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rV4yfsU2n0WfwiE+CTHf"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-rV4yfsU2n0WfwiE+CTHf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 21 septembre 2026 =C3=A0 17:08 +0800, Guangshuo Li a =C3=A9crit=C2=
=A0:
> mtk_vcodec_probe() populates decoder hardware child platform devices on
> platforms that support decoder subdevices. These children must be
> removed with of_platform_depopulate() when they are no longer needed.
>=20
> If initialization fails after the children have been populated, the
> probe error path releases the parent decoder resources without
> depopulating the child devices. This leaves the child platform devices
> registered.
>=20
> The remove path has the same issue and leaves the child devices
> registered when the parent decoder driver is unbound.
>=20
> Depopulate the child devices in the probe error path and in the remove
> path before tearing down the remaining parent resources.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fixes: c05bada35f01 ("media: mtk-vcodec: Add to support multi hardware de=
code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c    | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.c
> index e936ed8dffba..592685ad522c 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -517,6 +517,8 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
>  err_dec_mem_init:
>  	video_unregister_device(vfd_dec);
>  err_reg_cont:
> +	if (dev->vdec_pdata->is_subdev_supported)
> +		of_platform_depopulate(&pdev->dev);
>  	if (dev->vdec_pdata->uses_stateless_api)
>  		media_device_cleanup(&dev->mdev_dec);
>  	destroy_workqueue(dev->decode_workqueue);
> @@ -569,6 +571,9 @@ static void mtk_vcodec_dec_remove(struct platform_dev=
ice *pdev)
>  {
>  	struct mtk_vcodec_dec_dev *dev =3D platform_get_drvdata(pdev);
> =20
> +	if (dev->vdec_pdata->is_subdev_supported)
> +		of_platform_depopulate(&pdev->dev);
> +
>  	destroy_workqueue(dev->decode_workqueue);

This was first for a reason, please keep first.

Nicolas

> =20
>  	if (media_devnode_is_registered(dev->mdev_dec.devnode)) {

--=-rV4yfsU2n0WfwiE+CTHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarwfDgAKCRDZQZRRKWBy
9FakAP4vcR8SMhV7pVZIdxreL/3W6hen9hQOFj6cC3ZEarcA2wD+LAwK/qdsJ85/
pSIKX2XUmKWpyl2obUYqdo/NDZ69UQU=
=Asfv
-----END PGP SIGNATURE-----

--=-rV4yfsU2n0WfwiE+CTHf--
