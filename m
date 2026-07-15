Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360234040E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151982; cv=none; b=F20FLoZxB7395k8p30VyN6rQjz06UoO5cr15WSVf+u1VKSq+EgJHxcJ7SHvJ5ivA696CbnuS0zEGS2xx0yM8zYHd16vM00FjxQKEIjrZ9b8F30nytDeTln3tlrgFdCKJkvi2FWHEgEFe7R4/mVxD0wRt+s3LxojZ6uWcLsUrCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151982; c=relaxed/simple;
	bh=GqZLlYvzb94ORE/rD1wVat5JpCAaEwH/QHaUfFxBi24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uwh8dackvdTbVfha0a70tY4ntBS2GSM3wHxPBWUAtvMo/7t0BPf5PsoMgSyScE5hGvcV4oHIjh+bEt4HVju4SDOsQtnHXB347KCz9L9zvC+YKWOfmR04opt4FEKA2nOtPVniJsahSzbp7P5hMs4O99MDNK4cjNQnR1oDH1la0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=iuW1Filn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="iuW1Filn"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92f03daaa97so373455285a.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784151980; x=1784756780; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVIF/EVfgZRuLP2uDuLbmiiZlQAtiovpRtZGImmG/o0=;
        b=iuW1Filn4F90czB+dntuGvWolne8v4r9OkQ8BuOjLuQe2kWTOrKA3eeZhw2wpZYOOl
         zzC963FHT2yXvgl7LLVuzJwRC0bgF93LeW6C58m87sbf7RfHLvAKvImJKmKrYlcsVvCn
         wjB1BezarVU8bDUqQs7pNmZFeLr0X0QHa6t6EbyAFW+Rp2HwXOgb3N8x8654VXL23mCZ
         tdlEp8eB2u9Pq3PFnKwNKViDkMYKJ/dcC4VEI6VQXi7UVdNwzIr2gQV4ZWf/X74ro8o9
         mTvVyaB7SBkpVAQAxrT3x3DdAWlsbvRvrQN4MMXMEJ7RZpXmn+FqInoDDQQoX+n23Yt3
         S02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151980; x=1784756780;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVIF/EVfgZRuLP2uDuLbmiiZlQAtiovpRtZGImmG/o0=;
        b=V3B4GbluidEPyc/cHOGFRsUHcXt82j6GJ5bwjYI3GMwQSV7/wLxmtw3Nv9VYrSEneD
         P6ugpu8PqZcC/AZyRyEx3NESGNOr+HYrLqLRtK4knFmKd9jEFsx/S5b0H995z/xhYF7P
         Zs2UqR8Aj3cFUYK9MgBSvyPqec5NJwp8OyU7Ej2yya1RUIcZYdtpsd3IPF+YvzSE0RYA
         AojBqL1TX9/wiks8DKtI516bEH6E7IZJlwWDM+RyiiMoHzxsRN1WU3KU+LmHxSGsk8xB
         2gJoRx6kLbH4nOoSqFzhx/ayZ1d+dwV9MJp/aGqRkILwzihNfvq9V+wLbsb7JRFXVLlE
         Ba/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5zPmWQ17Ey95+rYqlFys5nBfY3Kn9TTFRbjrey7sV0SIsZbf/s3DAnVVJqBcF1kLIazEWlJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGELu3EnhcTVWJkSjWfCmuHoVvXiI2gFpFWZc5RaDL4h/oo8Sb
	bU0oKeib6CxH0CHZtbglr2CGgaxH+z37H8o8Hg7BkjDJU6CwC2VZwMYhlC+c4zrvBVQ=
X-Gm-Gg: AfdE7ckgjmVH2QXeiR6aLz9mR4IjbOx9jJWYiNdOF2ay+2oadeNlI4UL9X0A2ngyUwE
	7S7lkiQk3xZh8PFQ7rtyotxf+xOABUsjRg6O+3GoDAaWm4GHnzX7bxFmuGcfc5MPdH0zuBCgs01
	mLC5e3ZQFybazrwPJ83il1dtkswzHMpYLePmzUBVrNa0CHRsRgx4g2DUUR3dTVxhS5VCqatGy9k
	TEavUiRwh2PWHk1lb7Rip9y6motiKHgXhhX2cccd4X9zLE0bOEjWyJ5LZNuF3zSxYnA6Zb2LmkC
	Gh081lcz5SlJ18GJCijGRKQ3/LyAFhG7REFXyvudnyKBBHLJ7YhKIpvTakTKL53PCrzqBnzpRIk
	cBi0s9T6GlXTfHutWObmetRRsoCe9EQG6oZi3KzeZDffcEyd6h+eOmQMx5W/upbTIo6zRVSnkuo
	iR+uVLd4k=
X-Received: by 2002:a05:622a:1391:b0:51c:7b12:6002 with SMTP id d75a77b69052e-51e4f22e410mr44796391cf.78.1784151979625;
        Wed, 15 Jul 2026 14:46:19 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm140744181cf.18.2026.07.15.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:46:18 -0700 (PDT)
Message-ID: <99cac4207e627acca350b9ddb5d309755a243c07.camel@ndufresne.ca>
Subject: Re: [PATCH 3/4] media: mediatek: vcodec: free working buf on error
 path in vdec_vp9_slice_setup_lat()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, tiffany.lin@mediatek.com, 
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hverkuil+cisco@kernel.org, laurent.pinchart@ideasonboard.com, 
	p.zabel@pengutronix.de, benjamin.gaignard@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 17:46:17 -0400
In-Reply-To: <ac55379e5e84dd68146dac9cf38d1cc40c5f1691.camel@ndufresne.ca>
References: <20260506084203.202882-1-lihaoxiang@isrc.iscas.ac.cn>
		 <20260506084203.202882-4-lihaoxiang@isrc.iscas.ac.cn>
	 <ac55379e5e84dd68146dac9cf38d1cc40c5f1691.camel@ndufresne.ca>
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
	protocol="application/pgp-signature"; boundary="=-ppTn3qsVv2dDuNzXyobN"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ppTn3qsVv2dDuNzXyobN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 15 juillet 2026 =C3=A0 17:35 -0400, Nicolas Dufresne a =C3=A9cr=
it=C2=A0:
> Le mercredi 06 mai 2026 =C3=A0 16:42 +0800, Haoxiang Li a =C3=A9crit=C2=
=A0:
> > Add an error path label in vdec_vp9_slice_setup_lat()
> > and call vdec_vp9_slice_free_working_buffer() to free
> > working buffer to prevent potential memory leak.
> >=20
> > Fixes: 5d418351ca8f ("media: mediatek: vcodec: support stateless VP9
> > decoding")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
>=20
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

After consideration, I will drop path 3 and 4. The working buffer is
implementing a re-alloc scheme. Even when the alloc fails, some buffer rema=
ins,
which you didn't cleanup. In the end, its not very useful to clean them up =
as
closing the driver FD will do that (calling IF deinit). I'll pick the two f=
irst,
as its fair cleanup.

Nicolas

>=20
> > ---
> > =C2=A0.../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_=
if.c
> > b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_=
if.c
> > index 0f47b2671353..673b17d0dd8d 100644
> > ---
> > a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_=
if.c
> > +++
> > b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_=
if.c
> > @@ -1172,10 +1172,12 @@ static int vdec_vp9_slice_setup_lat(struct
> > vdec_vp9_slice_instance *instance,
> > =C2=A0
> > =C2=A0	ret =3D vdec_vp9_slice_setup_tile_buffer(instance, vsi, bs);
> > =C2=A0	if (ret)
> > -		goto err;
> > +		goto alloc_err;
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0
> > +alloc_err:
> > +	vdec_vp9_slice_free_working_buffer(instance);
> > =C2=A0err:
> > =C2=A0	return ret;
> > =C2=A0}

--=-ppTn3qsVv2dDuNzXyobN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalf/qQAKCRDZQZRRKWBy
9EzQAQDiVoRUElKz/0sSs5MKXnDN1ovXGYsSQ8nfQ9eu4Ww48gD/WlCA10wlGxfJ
wbiBdJUn/z/YeSOAt9q9KUFJ8Orc2Aw=
=bZm8
-----END PGP SIGNATURE-----

--=-ppTn3qsVv2dDuNzXyobN--
