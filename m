Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FE3845CF
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991550; cv=none; b=Pvfoq+ZZyYtHqfkOJPywCEcOX8zg4Csh7okJhNhtkEmr3Fhd6Gs9BqvqvhgTyuckIgA9wD0/92E9nLJguQc+hxwWSrMquKyLNRfj0tA3ogdmwBgMGQygh//i6s0KJdWDRNeqLaXbAdzZL0+4e3WyoL0uAGlU9YVk9+SgAQtP97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991550; c=relaxed/simple;
	bh=ssuIe92Jb3zbLPYd0Ue2HT9YCpzmK5OO0K4/PKeZbh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHqbRGhBIbuo8591M3yku/R+w3MB4D/r2nhR7esb0qIQ6QJAManB1SVWMoQMUC3ZvbCBHKDg9OSt+KOMpmydnWSg82fjInAEGkSRboDy4bsQMr+ETocmhIEsEURWvAY3Wi525wz52LqDR9orUV42ypN3+sua+esylNt3qiBagnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=yQAU7FDI; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="yQAU7FDI"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-747355a8565so1046036137.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1786991548; x=1787596348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IqloalWg3pznt5tRuupiewafun2w+jHDCWLW7mmd4xg=;
        b=yQAU7FDIAa/WVt/UNxzCFeiXPuYFFsin0TlsQgvqqAt0X+VQDH4HPPWfXkf5FLVDzW
         FUm+Ym0QCktXMHRNXWIngO4lEyRFFpBXwglXSh0O6/WYePIQyzTIalBuN/eClYppSLzC
         q6oAz3V91gtAjg36b4zdZZjAn5JxxVkngT9+Xq8nCHmk5+LnubOsKENuB8pJUFi/dxhF
         BzSyeIPvuNiK9UgxFx4/6OhT84y9RaexfJv9HtNfKvWhTP4udLsD/5E19992WYSueakE
         VVbCb+Q+WUWeAOjWpXORderQkoWdVwP9fENU/eE2ouwS01DQtDj+GA+54iIbbon7kJc7
         MfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786991548; x=1787596348;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqloalWg3pznt5tRuupiewafun2w+jHDCWLW7mmd4xg=;
        b=EdeaXdY+U+XHmzlUVw9JjGLmhnLujjSnm/4UsVMC+EyMZJ+uGLdpfmfb+712IbShVT
         LSIfnZkskPHBT56huEL+cLlta0R1Zl2maEV/G6RKBCFmci+h35ObZjFcW077QugikPhx
         PlndzRedUHax5ftFfshhhPwKFU5A+zIO+eIrjaHRkiqe99PiFC1Nxi+osxuw9OKUHb8T
         QkMHHSv6RoheQPv8y1TCpUtRjTg4NNxSVrIMFOKX7MPSt8UsxY3PDlPtQDGUKC++zTjc
         V+qRQuFyNHxgwjG/zVyfh0gMiHD4WozC5S5hZE4pIzgFLvlJP4UswLhFIzLcG0b6+2xk
         33QQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYCszUJajhj4cbmG+UpAg+gKLUy1hVhGxcQzpqCndy9k9LCN/LdwXv3xR17upx1eII1+Wy7Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyjT9vfe5eTj59Nfqx8+InjzVwaWJlo2EbxljQyHCStyTl/zA
	hVQSg1rimD8cR14kubAOEeyi7aBJwzCmlfAevpLzSCcjJPX8iuwtZbZI7EgB+IR+2kMTLvunmQF
	WtKohfHM=
X-Gm-Gg: AR+sD12I0W/THuM1hjvf2C8Xbn4Z6seNbfpwL7Ql4JTMwi53l7GubU+S92IeaQuOTja
	nnH2k+p4eyh8344K00iINBFphZzjtK94d6xjfQu4frwsK8JYopNeh0hcRX6jfUWHCZCIy6peYfy
	Ii10Ssrc1SUilWCFdnWakh1gESoJcCTCz/eg61F73NEkOigS6euSgqnZCrLZvSnPFuOqq3tavwU
	C336eD3F1AmrVUefH4a0uRO/eQj9QasaI8SfojELGVu6tKmvaYymtM5y26RzvxAeB9y+ccJ9lRx
	uQcq8EShJYudmNHsZseFrjIPCkOeSbkGKmfgckqIpujtb8nhUN9Xaso0zq94uYmpVYKkxlJ/+R5
	umvBDSfPBto6Ko1D+Nl8k36RUlkNX+ujq6woCUgFOYJMp0EIyPkQtlT6zRRW+5vhghqVO831Dg7
	9B8RM/rQowQk+ksZGnWcEaytwAcuU7sVhdGsspslCe7Hvf6ndSz40nPxAH+nbm+dHJ
X-Received: by 2002:a05:6102:148e:b0:738:472f:2cb1 with SMTP id ada2fe7eead31-76f2b9179b0mr4062102137.8.1786991548083;
        Mon, 17 Aug 2026 11:32:28 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::c41? ([2606:6d00:15:e221::c41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c29e3aesm1729135241.1.2026.08.17.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:32:27 -0700 (PDT)
Message-ID: <be5e2864e6e38f7e1a8949531134e2b6f88adb28.camel@ndufresne.ca>
Subject: Re: [PATCH 3/4] media: vicodec: clamp visible dimensions on S_FMT
 to coded bounds
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: moonafterrain@outlook.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Dafna Hirschfeld	 <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab+samsung@kernel.org>, Yuhao Jiang
 <danisjiang@gmail.com>, stable@vger.kernel.org
Date: Mon, 17 Aug 2026 14:32:26 -0400
In-Reply-To: <20260815-vicodec-fixes-v1-3-12101572eba7@outlook.com>
References: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
	 <20260815-vicodec-fixes-v1-3-12101572eba7@outlook.com>
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
	protocol="application/pgp-signature"; boundary="=-fS91JV423HXD2e7gmtEu"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-fS91JV423HXD2e7gmtEu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le samedi 15 ao=C3=BBt 2026 =C3=A0 22:56 +0800, Junrui Luo via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> Setting a smaller CAPTURE format on the stateful decoder lets the visible
> dimensions exceed the coded ones, and decode_plane() then writes past the
> end of the capture buffer -- a kernel heap out-of-bounds write
> controllable from unprivileged userspace.
>=20
> vidioc_s_fmt() writes coded_width, coded_height and sizeimage but never
> touches visible_width or visible_height, which vicodec_open() initialised
> to 1280x720, so shrinking the coded pair leaves the visible pair larger.
> job_ready() compares the bitstream header against the stale visible
> dimensions, so no source-change event fires and decode_plane() iterates
> over the visible height at a stride derived from coded_width.
>=20
> On a KASAN-enabled kernel, a 1280x720 I-frame decoded into a 640x368
> CAPTURE buffer triggers:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in decode_plane+0x1bb8/0x34b0
>   Write of size 1 at addr ffffc900004b8080 by task trigger_bin/69
>=20
>   Call Trace:
>    decode_plane+0x1bb8/0x34b0
>    fwht_decode_frame+0x173/0x620
>    v4l2_fwht_decode+0x595/0xea0
>=20
> Clamp visible_width and visible_height to the new coded bounds after
> every S_FMT, maintaining the invariant visible <=3D coded that
> update_capture_data_from_header() relies on.
>=20
> Fixes: 3b15f68e19c2 ("media: vicodec: Add support for resolution change e=
vent.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/media/test-drivers/vicodec/vicodec-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/=
media/test-drivers/vicodec/vicodec-core.c
> index 318e8330f16a..36b92f68ac42 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1029,6 +1029,11 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, s=
truct v4l2_format *f)
>  		return -EINVAL;
>  	}
> =20
> +	q_data->visible_width =3D min(q_data->visible_width,
> +				    q_data->coded_width);
> +	q_data->visible_height =3D min(q_data->visible_height,
> +				     q_data->coded_height);

This is obviously a nack, neither you or your AI seems to have read how the
TRY_FMT/S_FMT implementation works together. I'm not denying the bug of cou=
rse.

Nicolas

> +
>  	dprintk(ctx->dev,
>  		"Setting format for type %d, coded wxh: %dx%d, fourcc: 0x%08x\n",
>  		f->type, q_data->coded_width, q_data->coded_height,

--=-fS91JV423HXD2e7gmtEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaoNTugAKCRDZQZRRKWBy
9K+BAP9lcoIyR2Dj8NloR9ldSGZ+dfHs3k5WrsG21ipLzdwF7QD8CWas6VZIMUlh
fXU/TL2O9ZZKhRgH2Qj6tm8Qd4cTCQg=
=iV8W
-----END PGP SIGNATURE-----

--=-fS91JV423HXD2e7gmtEu--
