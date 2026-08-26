Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8447D93A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787778191; cv=none; b=fhno2jMz8heR2zrejUiPl4LWZrxcv7gffMzc6VbLZHEnWUMa4iNnyCXlmwaTD+SqzDpcdcjA+IhfYsssHo4O9z3LL26mL0se1W4AQSVLz5TAuh8H/S82GFsBiyJrgD+ePC1TVoyYEeN1JX9P/i2YOHULVfGfezaG2ITeQxRA0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787778191; c=relaxed/simple;
	bh=G95DSJvyvHD4TuyBwIEBp3aTZlrEO0waUgZ97+t02SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxqHvMAwlfPVIymwgkPRgp/4QeLEruyVU4SspYYD4s3znt4X2WPoNxDGDJmFKI/ASC3+PS5//JRKnPAXeqFoZ/r0yhypkJ3aFxgZGHc1kxTumNDS1Ti0hPUwBmF/uuImXWsWWIS9y/oPeYyKwRnFXknoPeLTQJcitqMb9wi2Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey0ti1W8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey0ti1W8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d53197d8b5so111745ad.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787778189; x=1788382989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LjM9GmdvyoqfoPm8mJ1pDYW08lI1V210DwwMkEe2Ph0=;
        b=ey0ti1W8Fqt6eYwkxHe8/9accoG/aNgjIXYvmPZwZjWWkgpJae8DwtBvi5ko7Xz7JY
         jCFCA3GqejcgkHhAAfWj64jyUAtjGpU/giFdlpGuHR/gLjM41wMggL0crZm/azQjq0WG
         LdzzzViCUwgVwSITo8N+t20jIlaGLnAs/9je5Pke4ogFvE4rBrrfXWDWu9W4hQ44mf5z
         RlsviL9MMd8QSjFYokQ8y3Vt3xnJTUoSZoZAEDTCkn9o83gdSQAo2fJh0JiMUCezOKfs
         xyUU7HExsE9ur9Vi5IxcS/x6Vy0eqdQHGTs8FxtHNt5yDlK7hVP38mfZiM7w8vFDjsX7
         Aw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787778189; x=1788382989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjM9GmdvyoqfoPm8mJ1pDYW08lI1V210DwwMkEe2Ph0=;
        b=B477KvBbwxkkYnvKCD6MYpAY9ERxvgoceqw59rLmsoyBb+nSB26R8j7TTV9gi6xkzz
         nWCofcYlRTDpQL+yCb4O599WlLl57GfA7p0gXluF/jHENg3El2NfhJLYo1s/dnLKJ6ty
         n+FqRIWU/8dInH3fgZQ2KVs1HEdWqhzjmObje0uDy5MrXh2lNVXf5HWCTVgAHAxKF6nP
         YyKIv6g4DxBvPybo6OzYS9Q1XCVVRDp2JTlf9xlEwGZPPrLR99joPQUcwzQ5VoWwvH1R
         38Mg59T8CqlhSsZByM7MIyrVISytVCNnuh/YMZl7FJvKDCdpfrqwsCG6fkSupx5aFNgx
         CotA==
X-Forwarded-Encrypted: i=1; AHgh+RrxORsL8BpvP71ZEQ+KfT4C/sdZ0SHRUl2YsG8l+HAv5ZmfseYZqKtuud090XmHt/1vMYUG/2c=@vger.kernel.org
X-Gm-Message-State: AFuF++n6ZZgmI+TGGXxqWlVfUy3Td9cixnvnKpopHPDbZmS2AApX+sGV
	7SQ/ZlTV7EtWImZc0dMi0GfySqlEQvMecZB0ZJlQRtBlQri1X0eAhU9LflEASeTD9Q==
X-Gm-Gg: AR+sD13JkrT5RlUTBRSO5sJpeC3MdE9R1HPaFp14hqJMUdtE34KQ3UmjkFjmLjCphYl
	afGKjMeps91m7P/6SjyOKq3eXzbRE3zls3lcJgRpQ09ZzQG9XsCZTmoc+RWkV1ATk/Jk/v6nWWr
	7f93Wd4D1G8w/LWnn/vp3Bs/chXPjmvdzuQTNCovXpXfRsY+V6irqfwD8UBqIC4dn3LZUNm1Iwi
	P8sU0/q5dHbyU6BJYUqHsTQEX5Tdy5s7xSwfG1HIejTPdsKtx82Zwfxh4CNuuM0UPZkPf4ibbFs
	8pUKW6zaEqVbYy1+yZTFCVCNZYAKbJRBcyOV+XbeO7tv8s/ZhtDR6vtiWNvFxHCYXuxgFVthcc1
	JWhl700jD4C5RkldeUAzIngmk6LelaaULpaIlFNs2hZthNEXvDcTe2E97sub7zzW9KIOGC1hHZh
	7BxFe4SVCf02xtEsyDSQDkSGej9o1iuC4doY1cb2pnYO8ZY5zRc0cGWhUdcVDbnZyVmfozX+cOp
	kprYfOr4PU4hMtL6St0dg==
X-Received: by 2002:a17:902:f549:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d707a501e5mr124136705ad.6.1787778188443;
        Wed, 26 Aug 2026 14:03:08 -0700 (PDT)
Received: from google.com (51.86.127.34.bc.googleusercontent.com. [34.127.86.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c1a0a2sm10897065ad.66.2026.08.26.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:03:06 -0700 (PDT)
Date: Wed, 26 Aug 2026 21:03:04 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <ao9UiKAEtsyEt7ZZ@google.com>
References: <20260825234545.2076049-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gz09TSVTsWtWbuFW"
Content-Disposition: inline
In-Reply-To: <20260825234545.2076049-1-jthies@google.com>


--gz09TSVTsWtWbuFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:45:45PM +0000, Jameson Thies wrote:
> The UCSI displayport driver indexes the connector's port altmode array
> with the GET_CURRENT_CAM response after checking it is not 0xff. The
> port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> not equal to 0xff, the kernel may crash with an array index OOB error.
>=20
> Update the UCSI displayport driver to verify the current cam is less
> than UCSI_MAX_ALTMODES before accessing the port altmode array.
>=20
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/displayport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucs=
i/displayport.c
> index 7067f2561b84..8d2032d0762c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -74,7 +74,7 @@ static int ucsi_displayport_enter(struct typec_altmode =
*alt, u32 *vdo)
>  		cur =3D 0xff;
>  	}
> =20
> -	if (cur !=3D 0xff) {
> +	if (cur < UCSI_MAX_ALTMODES) {
>  		ret =3D dp->con->port_altmode[cur] =3D=3D alt ? 0 : -EBUSY;
>  		goto err_unlock;
>  	}
>=20
> base-commit: e1e6e541c5c9cf548e9fdc35fc26808c82074440
> --=20
> 2.55.0.860.g4b6b3295ed-goog
>=20

--gz09TSVTsWtWbuFW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCao9UiAAKCRBzbaomhzOw
wgCoAP4vqDkDyluInYvf3CtI7ierjfnXdyn9lyg3gLa1LpKzLAEAg29Lc21QUG3O
a/cl6MGV6xYVAH0zkyRyP62oiHFrmgA=
=CSC7
-----END PGP SIGNATURE-----

--gz09TSVTsWtWbuFW--
