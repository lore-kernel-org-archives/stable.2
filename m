Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFF481FDF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725825; cv=none; b=r5dfrc2wCY9CUqKVTI0Y/0x0UloMLwxOv/StfXRp+glsmqPFhfWTptEyFs0OmSypUfdyRgL9Ln6KFXNRM3JRE1Yq8fpaOiO7kl2FK4UAFTTNXMxA6uHRPSN3XJzOjJxks6/gIsewsZQrcpeoxk06SFvWQ/1UsLj5BKh6523FDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725825; c=relaxed/simple;
	bh=3p5vN/K+tl5KFJkSkDuOeo+dPwt4fh+z5N6WbPTJuNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUeJgSzFqh8VfqCMnGQpnNPeG7NDYdd/Xz7LM0pFkxYYDoiUFPWBXqhpqOB7Mnv8/eishLubY5N24gzojhPYAxcAS74JTH/CQlb2Uh7dJs7d7CNmU+/2M7KUG5rSoTSJ0qQHGhTLdCTnoKghVA0S7Qip1E3HYqIetfTUJWAfxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mina86.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx94ZNl6; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mina86.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx94ZNl6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so83883066b.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725819; x=1790330619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sbMQAPQsa1PhAllTJIu6Zis/bac54ZxZcTnXaIMCgo=;
        b=jx94ZNl6CB/Q4S2uJ60LYvw/3K3HBfGkdAC6mno8Ygg8NV7bDdEBJjL8dtWRvzpLWe
         F6Ib6JBjVZJpkL/1C9q8aRMzXe74UQc3SZhYYfGJ63d3wxhsaAHPNsrrDLK0OE0gOwfe
         LLSXKdzAGbEpufccQBSgXCKQGt22kbpgn1sKKdzWbmZF8ZpNK+T8YBPJA8frOAP+U5j+
         jdLNh5ZEDOUXtpKY4N2CIqnGhtFAq+T8Utwqw9rRW0tU41/U1HBJq2Mf/HFzGKhG4BdT
         O3wJoqnZXSGX+7wnUlYX9PiHAE9MhlhKkvxnuFnwTTN3euVxRSsGLmVXQVT8J0nWEUq/
         kU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725819; x=1790330619;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sbMQAPQsa1PhAllTJIu6Zis/bac54ZxZcTnXaIMCgo=;
        b=ezxE8oO39+qtBYNAGJ8xJjXU6ariKIEkD33EVdw7lsjeajDBj+ZMDO1DqKb1sNCTSW
         KVgh865YgvQyp+OzBqU3Edad7UClU3WOLc9PEOsxUnpGaHpFO4ASVDbtGxMaDGtG9mV8
         zfC6wXosjDjKXroMVZILYzdYaCku1xviE4lovAv3tNproF1/hegNk+YzGeli7PnQ2z3+
         kDWBOo1vcqSJNPYw4sYcbU9Q/vlANAbqbpVr5+Mu/v2nagsL24qqYiX9aHeh/UMvGpz0
         ZdpM1XH492rzZvUdORbHtnBHau+yPqhzlW89XfXO4bpCRn0xr8/JbZZUNYZlzEZdVp9q
         XUyA==
X-Forwarded-Encrypted: i=1; AKwUvBy422aH3cCpWo5zqvNoBvIjxsQ3kUtpH1wzgyqVvSBozPDtAa2mJaKtx21cimaYAqnq1YovPGE=@vger.kernel.org
X-Gm-Message-State: AFuF++nwRg23XRG1owa4e8J4uhAPhqYtU5k9Q/RKu4RCm5g3t8bkP9ii
	+/6STyUwPhQqtKnRP09rUrQLsMyKB1nxH4+N0UqkwclTOvKbeoogVaMHWtcQrA==
X-Gm-Gg: AYBFou3aAmYFjX+52G9Nly+SXA5i2UukvFnHMLv6lvJOeaPhEBQcMtpiPj1hUVgov6H
	aAdxfwOg9o13zOJ97KEMbdeLqxwVfJak5m7rwjrydtvt5WSTi/p3Z4/6/O4yLsZgEuFrLnxrShI
	hZ1ALM3SJPm++rua5U4gd5Ca/noLfI+faPOx3Crj8ydncz633gSvFLo/0tSm/IcGdxrsCNerogo
	BwQztKFtZu3/sLZzoku+UlFPU73+WEUVTAfK58DuejEShCIJJjIKY17WmQHOaOo9eS650sni0bK
	2uH9V/6YuwT8udlljU/sG65nWiR/+SqU6cOTI9SzEUJAuz45pMQb6CE0YqV7U77HfZUENUeXeMN
	3csT9Xy0Ri2iwJrQE9/isPpUVMj8XB1nZsDjPg5O18QN/lROOZq80J3dBcDmHoAVgb/LKjdjD8U
	NgXs9a4rF4gYTGatWKHL7djglinVr1SPRKAUg+FUF+ZXSbRbREGX3VsOpwv64HqSMinkFkA9pew
	jo4n/o90AjJwLem+7vCMBEL
X-Received: by 2002:a17:907:7b9f:b0:c29:4cb4:8582 with SMTP id a640c23a62f3a-c2a1582a81emr214270166b.47.1789725819049;
        Fri, 18 Sep 2026 03:03:39 -0700 (PDT)
Received: from erwin (109241130011.warszawa.vectranet.pl. [109.241.130.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6830sm39654466b.52.2026.09.18.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:03:38 -0700 (PDT)
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
From: =?utf-8?Q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>
To: zjamg <ndaugoing@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Robert Baldyga <r.baldyga@samsung.com>, Felipe Balbi <balbi@ti.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Yuchao Zhang
 <ndaugoing@gmail.com>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH 1/1] usb: gadget: f_fs: Fix NULL pointer
 dereference in FUNCTIONFS_ENDPOINT_DESC
In-Reply-To: <20260918005438.81263-2-ndaugoing@gmail.com>
References: <20260918005438.81263-1-ndaugoing@gmail.com>
 <20260918005438.81263-2-ndaugoing@gmail.com>
Date: Fri, 18 Sep 2026 12:03:37 +0200
Message-ID: <ag6hspo092vj0q0uehcbkf4f@mina86.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18 2026, zjamg wrote:
> From: Yuchao Zhang <ndaugoing@gmail.com>
>
> Fixes: c559a3534109 ("usb: gadget: f_fs: add ioctl returning ep descripto=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>

Acked-by: Micha=C5=82 Nazarewicz <mina86@mina86.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index 43962e05eacf..c64a268e98a4 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1877,8 +1877,9 @@ static long ffs_epfile_ioctl(struct file *file, uns=
igned code,
>  		break;
>  	case FUNCTIONFS_ENDPOINT_DESC:
>  	{
> +		const struct usb_endpoint_descriptor *desc;
> +		struct usb_endpoint_descriptor desc1;
>  		int desc_idx;
> -		struct usb_endpoint_descriptor desc1, *desc;
>=20=20
>  		switch (epfile->ffs->gadget->speed) {
>  		case USB_SPEED_SUPER:
> @@ -1892,7 +1893,17 @@ static long ffs_epfile_ioctl(struct file *file, un=
signed code,
>  			desc_idx =3D 0;
>  		}
>=20=20
> -		desc =3D epfile->ep->descs[desc_idx];
> +		do {
> +			desc =3D epfile->ep->descs[desc_idx];
> +		} while (!desc && --desc_idx >=3D 0);
> +
> +		if (!desc)
> +			desc =3D epfile->ep->ep->desc;

IIUC, this will never be non-NULL if all the descriptors are NULL.  Then
again, it probably won=E2=80=99t hurt, so dosen=E2=80=99t matter one way or=
 another.

> +		if (!desc) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
>  		memcpy(&desc1, desc, desc->bLength);
>=20=20
>  		spin_unlock_irq(&epfile->ffs->eps_lock);

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A3=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
