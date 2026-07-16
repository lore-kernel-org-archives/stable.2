Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72359175A8D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161316; cv=none; b=I7A5yTekl87B34sngppQ2b9XsumD2g7KQ/8SrkSuwxgooHbjxjWKwv+fvpcvamEa6r0u+XucUSD8U1sI/LcsHRbZy240ZaURpWFZ2BE/q5pY3hE8lzChNzwcGYk6vEDxkuNMZfklxxXy3ub1bWCtBIitexpprkgurWu0+3BPwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161316; c=relaxed/simple;
	bh=oh4LFguDXu97SMM8fIsn0hOFXs3CqGOdpfJtqN2IS2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqhADJa0QC713Qexca+pMvX5DvRjRQthupnZrEKGRRVDOlJolFdTByrtl8QWm2sLQyBuqHjhwFY4zSoHVRhQ1h3Ccnl9aPr1GHDLIxgfiZkJEdWNx6oskalhquuwLQHU4Zv517KBTDfyIkblHFTeFy+WOhuUjo8adHAbwD/bpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=RSUwwtTO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="RSUwwtTO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c16ac21acso19122391cf.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784161314; x=1784766114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxDOC+/uej/6RegQ8PrVVsXKUPdRyp36J+7o2AdC+N4=;
        b=RSUwwtTOVVFKcgsMT6Pk3m3NulcKDMMT3kBHcbVkyXBeA6NAsdbhNUc+ig2kSLiNWT
         8lddhL6+/ir3Zq60Z4aUNpUar7RNIA+C6oSm4IlFLbK/FYkJgmkP/2cjZNkeodZCM/ZX
         irnre2AGMq3LkVnxs2fvBJQ5ySZX6psfoBAgRMHDBPmP6eyVvJByx3cJFoSYV0Jt7+w/
         v+jhhhHOiW6bWLR71/RvQkAxrJnRps+x20hT69yf2dWG1xGDeSvJtZHX27UN9Vl5Om6A
         /qRxAsqQSL/uef2LFfvxaU5stStIAIstTdkBJNPJrTVoEPoYeQf+n6OInrrC1+s22qKE
         gXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784161314; x=1784766114;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxDOC+/uej/6RegQ8PrVVsXKUPdRyp36J+7o2AdC+N4=;
        b=rn/HJQnLLEfmhihoEnY1PXMc11OAzTvQIOlRjzaP8ftA9X944YpjzgdeQ/OYgDhpHC
         /tZG0QITQTFKAPqHaUWvcXylnHL92KhDUup92xW4t+7va1/0CjCJhD6DPAZpSBRjN30Y
         lLhuv7yPoxCo3++UwaLgjotS2TmITslmxB000Vo1BytDcw+JDPkBeDuyMXOxMJIP+Rsk
         MxhBrnDtBc9AZRXvSPVw/Oc8VxqpZxqhsgzSuwCwUpbIaiW83Y6Vo/LS2DbrZDGVH48E
         rUiLDFwwIFKp57v0qIECi2UXDmA1TAohHDoWuutWglSCXDJB1VQICZvjDaTGOaDl4q2Z
         Lcbg==
X-Forwarded-Encrypted: i=1; AHgh+RqDiPuWMJo8qxdyUUwuatkkZsgEv3NtKO/pAA2QnNQaiQwrGW8O9P5jMVbebwLHj+yCbGbiBSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oc+xb3G7fSANJIqvnZoS5yWvNGjO/XL57+TB71R471h7Zh7q
	7IX7JeSNahTIj2By43cZBM+ohpw2q0rLxSWm2MjLUUxVmRVFKxQy3/IK2EJtjEzwde0=
X-Gm-Gg: AfdE7clJ04o0j21myI2DE/N4y0jWTgGRfPUdnTpo9u7cp0x9jOne5TJOjJC1tlB9BNl
	bml2YMiBuHHFEUMv6j1HjVSxTiywMyvv6j3NvOL9yBQw/3WWB3eoULhiS+OIMMqWMN6sg3cJY1M
	E8Mc2GcCQBqm9lEFoW5B8kVKE1Nv8A7DfyzbuVRJfna4kJTyEOcvloTg6LQtLNV9AKxhMlE54/i
	DS6nszc18jGmFJQt4ESslBYYvMiRoytLt5sgDZ3um+u9JskDNCH0Ff9tVgJN1Ob+0Waf2+fCIyQ
	XoQ/p/NnQLyA5V81Do8e6jIaRBaKPH/433D1iu+IM0w1bXUpR6pF9UxoXL7k56XFAADqzMVHeXg
	uZSMg5vWzSiTLTKUM4mscf7FWxn1mfxMDIGI4vYIbQwz6HZV+S+mjTIucVj3DxLiYlf5ZB58iQP
	+k7aXeCsjlZhJTjRojLw==
X-Received: by 2002:a05:622a:909:b0:51c:1d67:379 with SMTP id d75a77b69052e-51cbf0c476bmr207834671cf.23.1784161314258;
        Wed, 15 Jul 2026 17:21:54 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm206884396d6.21.2026.07.15.17.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:21:52 -0700 (PDT)
Message-ID: <79f19fa34a875dc4b6944ec8df498d9862b5d3f6.camel@ndufresne.ca>
Subject: Re: [PATCH] media: vicodec: fix out-of-bounds write on capture
 buffer
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Junrui Luo <moonafterrain@outlook.com>, Hans Verkuil
 <hverkuil@kernel.org>,  Mauro Carvalho Chehab	 <mchehab@kernel.org>, Dafna
 Hirschfeld <dafna3@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
	 <danisjiang@gmail.com>, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 20:21:50 -0400
In-Reply-To: <SYBPR01MB7881A4E2AC434488ABFA775CAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: 
	<SYBPR01MB7881A4E2AC434488ABFA775CAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="=-KiacoAbzGr4Wo+lwF2YP"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-KiacoAbzGr4Wo+lwF2YP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 01 juin 2026 =C3=A0 20:30 +0800, Junrui Luo a =C3=A9crit=C2=A0:
> The vicodec stateful decoder handles its first resolution change in
> vicodec_buf_queue(), which calls update_capture_data_from_header() to
> set q_dst->sizeimage to the new, possibly larger, format. Unlike a
> subsequent change in job_ready(), it does not set ctx->source_changed,
> so the m2m scheduler still runs a job. buf_prepare() validates queued
> CAPTURE buffers against q_dst->vb2_sizeimage.
>=20
> A CAPTURE buffer allocated before the source change still passes
> buf_prepare(), and device_process() then decodes q_dst->sizeimage bytes
> into it with no clamp to the buffer's actual size, leading to a
> controlled-content out-of-bounds write past the vmalloc-backed capture
> buffer.
>=20
> Guard the write at the decode site in device_process() against
> q_dst->sizeimage, the number of bytes the decode actually writes. The
> destination buffer is completed with VB2_BUF_STATE_ERROR by the existing
> device_run() error path.
>=20
> Fixes: 3b15f68e19c2 ("media: vicodec: Add support for resolution change e=
vent.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> =C2=A0drivers/media/test-drivers/vicodec/vicodec-core.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/=
media/test-drivers/vicodec/vicodec-core.c
> index 318e8330f16a..2950d42c8c63 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -321,6 +321,8 @@ static int device_process(struct vicodec_ctx *ctx,
> =C2=A0		q_dst =3D get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> =C2=A0		if (comp_frame_size > ctx->comp_max_size)
> =C2=A0			return -EINVAL;
> +		if (vb2_plane_size(&dst_vb->vb2_buf, 0) < q_dst->sizeimage)
> +			return -EINVAL;

The analyses is just incorrect. At this point, the driver is entering DRC,
meaning the queue will be drain and will stop until streamoff/on cycle happ=
en.
If there is a out-of-bound bug, it would be that that q_data->sizeimage is =
not
match to be smaller or equal to the vb2 buffer size at streamon time, not d=
uring
processing.

NAK

Nicolas

> =C2=A0		state->info =3D q_dst->info;
> =C2=A0		ret =3D v4l2_fwht_decode(state, p_src, p_dst);
> =C2=A0		if (ret < 0)
>=20
> ---
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> change-id: 20260601-fixes-452ce98d76d8
>=20
> Best regards,

--=-KiacoAbzGr4Wo+lwF2YP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalgkHwAKCRDZQZRRKWBy
9C/GAPsHWmIIGnAbah5asQrVgy7zw/9W3kCj67i18MOF2Zd3kgD/RZ85ZfiaolEr
9Ea3ozkO1l8zbYA+oef/BuOtO5ymygM=
=OqLK
-----END PGP SIGNATURE-----

--=-KiacoAbzGr4Wo+lwF2YP--
