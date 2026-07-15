Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DA3191D0
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151346; cv=none; b=gEEbIEOFxhhsckYOgk5AEL37JdPABgNLZFxjLhr9wzfI/Ah+b/WzmDPK4XakFCCfDwOFwMoemJSIMouZ0b7IMrGmoqt3CCQYD/Ipqjp0aR+xzvcYVuneekeU/C+fRr6gN9MyrZH7wIqhF3JruoAZ/vBUj84XvgnJAP/9P+IznJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151346; c=relaxed/simple;
	bh=nwMq4gqBjyrquwvu7cVHnFNyFGaf+hTcAdlgLVAREOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAWO3IPdRPIDrtqt9EXAPTA1Wfl5604xABt34CjZY3XZhbeLqXERFEeTrUotpn/iB4OW1BddnzegfvMkpxLoTtEEIuHCnL/kmS2ich19zrPKJmVg+asyPLVTpvo00tRu8Jl8hSKg0rBE4cXBjJFhyEBru+wwEkXITau1LFJFOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=xMxgnVaI; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="xMxgnVaI"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-73720e58dafso1580447137.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784151344; x=1784756144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+EpaaRrGWCXRWSePMszE17K/2eaVd5bxTxAyXQa/8ro=;
        b=xMxgnVaIb3SQxN5DKv36qb/cDxGKBttQ+Uqm0nDX5YYJen2K5OCM2yMYxDEFfKdLEe
         0LFuqMOrzBkGEf3TtS0EUauAfFDQ2hTnCZ5eA8le6WXfKrJMlmFDU/+BYue0png7kRpW
         iUx+b+yvYsuDT0jHpmm5x1SlcsVBrznfNyfGJ+BIZAYX9cqBFA9RKYtlwdthItSQT9lC
         S26D4jZN2C4kAfBEpwVc/mCsYWC4nisQEZppNDQ9XSt5Yn+ZOhCO29AX5Vz8sVrumXUR
         L7O6rbv9J99D0OyeL+GcZVYZ2PrvCMNtkIHrSc2l2F7au+dS5jXUtxW7OwxXzRu6uAab
         JZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151344; x=1784756144;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EpaaRrGWCXRWSePMszE17K/2eaVd5bxTxAyXQa/8ro=;
        b=kwiAxeIOUEBcPe6/4L9/3GHlhWMFyK0d9p7kk+PQ7otnivAPphVI21D9nao68cwz2h
         c7wqCrjWxlUqB/QUKPQP/KcyB3prA/UAQl4gS2y52cH33r8z38PmVBdUWdeCRFZ39ee0
         qTwdDsey5JFhHZmRoVEaICQwA/mhNQ683qkv4t+gQ8Od9NYqnSQVYPDfLIzyVNaONC0r
         oJAey5OdoTVYcMZ4TA08M6/v1SPN7H/OFbP6j3OUxba/Wk+9uPqGi/tNkC+zUaBG2Bwb
         ab6PEwiDs59yxgH7KSZA/eWB8zw0QqNIAG4JOHbaC03pdgMybsI4joU/gmeE54BJ6VQ6
         FroA==
X-Forwarded-Encrypted: i=1; AHgh+RoL75wLFiWj4mq0bURRCu6UkOousO2Iy8lHvXvtXiw+EchTTHYIrqHxsVr7H1CsLqeV9vs+WhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJr/mONuEXRWV8iHEC6NlOSvnfGbOReSdELMhvUllzeAPBCFk
	bsRnxch0oSUPAByTtvtYcyIaLvzXtiWjiPT6QkexAcWZh5ppL0CoVUZ5MmW0+z5UJ0k=
X-Gm-Gg: AfdE7cl8STyH6LDbcMr4dRlOFthOkUmzrBhxZDTI/WTMB9C6M5UVZEk9pXc/6iEqxsH
	B1dgNdA2RCVVALdtZA0+pMK7dDm55N/DSNwjYGVzBZAUn+YPajpW5ZxRnTVsUw0u3luIcw1gFbW
	Wz6pUSTov8O/SHj2Blkeguw0PLWfNTrwAgVTM2Mui6g6oZmmzyLIyztiujSI9DGnODiAEr1QDnU
	FTYYUmQOv8KUuAWGDtu0XBFLglK4XTbFnztuCXTT/n+BmwQfx0psGxIYqJVdqoqPnCfg/EgxcQO
	WGrUGSVX7TD3Bzv/iwBupRnsW+uEjVCmegR3TP85s2ho08vElv7uVZe2G3l/utk50K4S8a0oplh
	2wwnuz9jdjewX9ar2jf5v6RLLYn/O3bVG8J8ppKelboR0dzHYq2LeL36tOeGherF7SvCQDzFDKu
	QXaGxbUUo=
X-Received: by 2002:a05:6102:26cb:b0:729:affa:70fd with SMTP id ada2fe7eead31-74533bd8d76mr12786250137.8.1784151344161;
        Wed, 15 Jul 2026 14:35:44 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed2c94ba7sm11813347241.4.2026.07.15.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:35:43 -0700 (PDT)
Message-ID: <21427625c59d10a309beb656f9971e350f3e8e3d.camel@ndufresne.ca>
Subject: Re: [PATCH 4/4] media: mediatek: vcodec: free working buf in
 vdec_vp9_slice_setup_single()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, tiffany.lin@mediatek.com, 
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hverkuil+cisco@kernel.org, laurent.pinchart@ideasonboard.com, 
	p.zabel@pengutronix.de, benjamin.gaignard@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 17:35:42 -0400
In-Reply-To: <20260506084203.202882-5-lihaoxiang@isrc.iscas.ac.cn>
References: <20260506084203.202882-1-lihaoxiang@isrc.iscas.ac.cn>
	 <20260506084203.202882-5-lihaoxiang@isrc.iscas.ac.cn>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
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
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DMD/oOwECZhtXySoMRZA"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-DMD/oOwECZhtXySoMRZA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 06 mai 2026 =C3=A0 16:42 +0800, Haoxiang Li a =C3=A9crit=C2=A0:
> Add an error path label in vdec_vp9_slice_setup_single()
> and call vdec_vp9_slice_free_working_buffer() to free
> working buffer.
>=20
> Fixes: b0f407c19648 ("media: mediatek: vcodec: add vp9 decoder driver for
> mt8186")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0.../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> index 673b17d0dd8d..1dd0f7fd642f 100644
> ---
> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> +++
> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> @@ -1806,10 +1806,12 @@ static int vdec_vp9_slice_setup_single(struct
> vdec_vp9_slice_instance *instance,
> =C2=A0
> =C2=A0	ret =3D vdec_vp9_slice_setup_tile_buffer(instance, vsi, bs);
> =C2=A0	if (ret)
> -		goto err;
> +		goto alloc_err;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> +alloc_err:
> +	vdec_vp9_slice_free_working_buffer(instance);
> =C2=A0err:
> =C2=A0	return ret;
> =C2=A0}

--=-DMD/oOwECZhtXySoMRZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalf9LgAKCRDZQZRRKWBy
9GDcAQDsL1aA2cI34yx6YSzNqYl+sD31FYancPkFZfRBlYrukAD/WzwcjF0ymzwX
P1Lo2EOnXxeofKa8WzaogpsiOaZONAs=
=cUx0
-----END PGP SIGNATURE-----

--=-DMD/oOwECZhtXySoMRZA--
