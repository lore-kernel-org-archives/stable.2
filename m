Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47B3A4267;
	Tue, 29 Sep 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716273; cv=none; b=jqeiSCWWX15JFLMbHt5GLcQ//RVkipEZ07w1UsJTwOZ+6BBIN7XojgIcYbWhp4mquv6nGCNf4cH8bv7RV3C8SWEk3fXN6mMzks56kZjA15d7Q4oUkg30AhGWp2978NTgLUUpUfN1c8AYSQF6eUAEXH/P2ZiV6mej9+pqLWlgTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716273; c=relaxed/simple;
	bh=OJHK3wW5ArguXbjLgPCeX7+D0gjNCSr/9bwfhXsKji4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9F2/zYTQ6UEVGo9Vt8cPePuy/NOFRS66z9wnfFH+36xqays0wsnFRqb4X3A3xaU1Mb6J/pKy8HCDqmtbxyv/FtuZCkW64A9IuZKWJMtOQjS0cldVgV4gOxQ0CaYxRtOiETl6gy8HkHxx/kmn3EIywMwTpbaN5MMLxUttfVVU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YjjWYb+F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YjjWYb+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790716270;
	bh=OJHK3wW5ArguXbjLgPCeX7+D0gjNCSr/9bwfhXsKji4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YjjWYb+F7ntVNqsBOrNRkIabv3brgPYVxGRCJ+c1u7teeLF+YAbmOWh4O6jjRYHH7
	 HRBTPlrC8C4m0dNLXij4Cq0D1XXktLyiaJfdEgMR4mNqOdKAuD9in8StQ6fzJ0ha08
	 Sd9qfHyTk/JZPt+BuOb2u8PCFcBREiUFgPsXQdadDaCCOQ6L/0HCz3+tyaf0tDXcQC
	 5sIcSW8CND6vUM/YkE7nFt7IeP4UKUDqlEv8m2rE2WMq30TL7BqLwr2cXxc7QTdDeA
	 a83bI7ukhAE4KIBs7b31sgl7YyvEnsVMsbGNdO4Ge0wChkJkbNOlbmCb+G/FABfQeT
	 BCqvzTFdiH4qg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1797717E0203;
	Tue, 29 Sep 2026 23:11:07 +0200 (CEST)
Message-ID: <1db4cc111dcfcdff0042841ff71ca0e0740e5072.camel@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: destroy core workqueue on
 remove
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Tiffany Lin	
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Matthias Brugger	 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>, Fei
 Shao <fshao@chromium.org>,  Kees Cook <kees@kernel.org>, Chen-Yu Tsai
 <wenst@chromium.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,  Steve Cho
 <stevecho@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 17:11:06 -0400
In-Reply-To: <20260915115753.2411047-1-lgs201920130244@gmail.com>
References: <20260915115753.2411047-1-lgs201920130244@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-rz/nb+3HJ76xRI+V+kAt"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-rz/nb+3HJ76xRI+V+kAt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 15 septembre 2026 =C3=A0 19:57 +0800, Guangshuo Li a =C3=A9crit=C2=
=A0:
> The decoder probe allocates core_workqueue for latency-based decoder
> architectures. The probe failure paths destroy the workqueue, but the
> normal remove path only destroys decode_workqueue.
>=20
> As a result, removing a latency-based decoder leaves core_workqueue

LAT is an abbreviation to for the core responsible for entropy decoding. I =
don't
know what it translate to, but its not "latency", I'll do the minor edit. I=
t
does reduce decoding latency though :-D

> allocated after the device lifetime has ended.
>=20
> Destroy core_workqueue during remove for latency-based decoder
> architectures, matching the cleanup performed by the probe failure
> paths.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware=
 decode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>


Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.c
> index e936ed8dffba..426d060d937c 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -570,6 +570,8 @@ static void mtk_vcodec_dec_remove(struct platform_dev=
ice *pdev)
>  	struct mtk_vcodec_dec_dev *dev =3D platform_get_drvdata(pdev);
> =20
>  	destroy_workqueue(dev->decode_workqueue);
> +	if (IS_VDEC_LAT_ARCH(dev->vdec_pdata->hw_arch))
> +		destroy_workqueue(dev->core_workqueue);
> =20
>  	if (media_devnode_is_registered(dev->mdev_dec.devnode)) {
>  		media_device_unregister(&dev->mdev_dec);

--=-rz/nb+3HJ76xRI+V+kAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarwpagAKCRDZQZRRKWBy
9DH8AQDi1rdmJFjoheKwH20vfJzgzCvgVYU5PBPqraReB1W2sgEAnGKrT/vDeefh
OzjBK1cPvD9/FeMAd3jcnge8XJbQnQc=
=10sJ
-----END PGP SIGNATURE-----

--=-rz/nb+3HJ76xRI+V+kAt--
