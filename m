Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B24766B7
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898605; cv=pass; b=VbxEbY3Fvi9jnVEk/ssAm3ys3lPbmnOhrcbh7K5F6LlZ5MjRDYFZ8Fg3ZcOgo3+cHHzJujjQtYmOIspBIJ8NzhlcWclmWGjrgYJe/nNA/mu0EwGzQLyx6KFqaMegk8IhB0DxjQ1TF2RoMSkpFpM78uytmDDOXruo2FZrcF+jRlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898605; c=relaxed/simple;
	bh=tTc9z7FYsgGlwJPZrMfkGMhg4VwSkixsGCk/z8dgvNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgeAa3v/VnqisqpKEGRXomz2bD9+UeraEuQ9cCbaPv/bSaxrwzrhqu7J65S8iJMg+VTP0WhXgkwpACEWaIBNBTf2Cm6aeIV/suxlHVsnFP19YHMpU3wIT5S8OkSkw05oGN8qQHy3MDJ+Wq/8QAzbDJlxNWnKPfkY7pPWRRnux+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nextdimension.cc; spf=pass smtp.mailfrom=nextdimension.cc; dkim=pass (2048-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b=g/MoVTUx; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nextdimension.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nextdimension.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b="g/MoVTUx"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4f560d928f0so34550b6e.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790898601; cv=none;
        d=google.com; s=arc-20260327;
        b=PVKmX1NzNz5FEAY3Y+9irDnioyjhEnxn6KhiY97TGxx003KwNDd7pKiaJ+l9Q+lSKt
         pnzHpqXZKYS7JohfqwTZM2iRwwmxUbTqKXRcOKeTkN38Kol/GvIv3ZTtF7hoghFlU9Te
         spYryW/uv8qMrxWc81ENazEJEoJC1eXMRvaMTueGbTsd56nx3JZiSWBQvfNmRtUWzwR2
         YxSnTV99PgD1SSzlLVb+tkValOCfJfRHFYnDvjalhB7EbM3Fxdczt0N3KseR0iRiwYE0
         mxULAS88J9AiVMAN1nXfQc0N1jBmCri/VRR25yjGZ3i2atwGtaQKe/rwC13KVARCbou4
         PUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MKY9cPJJozKGHFrfmhUD53rTouOcT3tjSvoX5iN+R5Y=;
        fh=B7m8WmpCjoYcoNMJ4kiYwMaSPBXmvLqAOznsw3ftnPI=;
        b=gAzkOi+VnImkib4qlEXzs67vgZl4n9lx+GLGCCHJuB7UBGOOHQS/PiwGZR0mRlYrUC
         X2b3t2Osi0i3Ro+EI8lC2dtlSGBLu5rG5E2PYj6uFliCyTPS87UhbDOkt7iSlKVzT6Kt
         M3NM/6j8R/6iDmIs7Z4K9vyTfWbe3dsLXiHPOJjnDDrvSLv5aTPHCLmcI7Li3efCUEgR
         C3Vjlmybx8IIKgC3e+NI+dcnoFjGXdfuo0PZHBzCN5qCQZ3CEqqOxjKoWH7Lmy2miJUA
         r1FWoq1fMFpVyYIHJvSr61nDRBNoV5wrA+wPPcB3CZUxcK69RUaXsPhPPWQMk54g/r3I
         yjgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nextdimension.cc; s=google; t=1790898601; x=1791503401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKY9cPJJozKGHFrfmhUD53rTouOcT3tjSvoX5iN+R5Y=;
        b=g/MoVTUx8H/5A9Jwk/t2momBlaXQpJJpMPN+UMkr52+EaCMHlrmXNLEIJleMz+CUST
         Hj+a/RV4spFrb149E+HBsJoyDeAMiY/uaU4P6/yXEuR4nF+XrioSvvPSafTCJNjf27oj
         k68WkbThAPHEK6X+mKE7vRnOhokFE3yTFirqfW6uh6SHDp9MoWBJLoBMY3l5kbohkoJ4
         1lsArFB7FzjIEclfk/REv8+tvKQU/TtMX+VD2addalWm6tuUFzpz2juyGuhECm3mxTvJ
         UlauTj+RH94dmf4t3g0S9FgEkHgt95szXah6liCjRoDus9bAvHvEuFBQdLgcGSuSTp3G
         /45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898601; x=1791503401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKY9cPJJozKGHFrfmhUD53rTouOcT3tjSvoX5iN+R5Y=;
        b=eXNey/UW8QoVPiMYz+KgOZg43PsVhTwvzhxEbfWGumM6/gifD5MdAJ1dLKCGZ0LlO6
         DsbAfeaDNtqsq3p6RO6JFQpkj8OI0+fSukKc1pn/u6c6dnSQ9JtMSsrrByb7WmX5A9QT
         qnixvXXh1dYHpLo93rHQ7/a2W83g5O+HlxqKy4BNKrsUwrTZcK0riY7aBNa33IqMTDcs
         D+y8dovjmZFLnkdoxl1nV2ZTAS+OxE8CISixvz8VAcu5cxPMsflG8x4Ce7z7J6qzw3oM
         b+kTaSxxZ9fCSVKnpEzVDefWOAsiNojTjvQM+c3tBpc6KBlFpKHUCZ9tppo7pqmpqamM
         PeFw==
X-Forwarded-Encrypted: i=1; AKwUvBwm9+TWMP2Hp1ZT3SSLj+Cufwj58rqhPBbvJTcBy4kX3NYS+68K09pMjlLkBk/2udmxHUhmeQo=@vger.kernel.org
X-Gm-Message-State: AFuF++lDuS/M9YWRrf3i9pYQ5yS9HYIXxotHuqshQrAa3xi75pbwJbok
	UAEQim1sqWTmIR112f6MWtHUv/L7+s80zRSrysxJtxVHfwQ30yUw48lSxoVCD95uZ0Ozy0bLQ3h
	pF1WeFmUhG5nGka1atXFKS39P9aWTZ3kuFVmLoa21Mw==
X-Gm-Gg: AYBFou1br8jqkovy/td4/9z2nfDq2rjk0tnzjrAl7im8nAEIzuPXDHyj5ajcCT7Qg2S
	BIOLVCtPraP0c1ucHf0pUEEJHA2Pu9przqtpMfX7EbGL3mLKSbKykDpMtf+Mny9ESlDBERwhwnI
	3VsIPKY7NJH+eS3A6i5NxLee76+5ww1Kx1n+oYQepftwxsWihCKNF2TW1xzjBMupVc+FzO+Gdgy
	jjm8+QyOztSL5wXB71FUTxxrw3CYHzQfNa5MjEdcHhu5Hk0f+xJ0V3CNsdPrBELUJRzCd5qRzzM
	i3u5YXMPufWB2Wabn0Bh4vAxZzx5/A29pMJzUi4GbjtreeVi6j0YqUoTsQ==
X-Received: by 2002:a05:6808:6f8b:b0:4f3:e98f:fa27 with SMTP id
 5614622812f47-4f529c28115mr654041b6e.16.1790898600864; Thu, 01 Oct 2026
 16:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930020010.85250-2-chris@kode54.net>
In-Reply-To: <20260930020010.85250-2-chris@kode54.net>
From: Bradford Love <brad@nextdimension.cc>
Date: Thu, 1 Oct 2026 18:49:49 -0500
X-Gm-Features: AclHuK8gO8mr_tN_8askeYsS8qGi_AKhcozyXpVKRtdSd-d60e84_diX5L1-c8s
Message-ID: <CAA0YaJRW_q4HhSaMR0WzmHiRzLvNtNfUcruT7qZnHFHVb5VVLA@mail.gmail.com>
Subject: Re: [PATCH] media: em28xx: fix inverted tuner capability check for
 VBI device
To: Christopher Snowhill <chris@kode54.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

Just a couple days ago I plugged in one of our products with video/vbi
and no tuner and saw this message. I had not gotten around to fixing
it though. Thank you for catching this and submitting a patch.

Regards,

Bradford


Reviewed-by: Bradford Love <brad@nextdimension.cc>


On Tue, Sep 29, 2026 at 9:01=E2=80=AFPM Christopher Snowhill <chris@kode54.=
net> wrote:
>
> Commit 8e53399c63c3 ("media: em28xx: Add support for Empia em2828X
> bridge") changed the condition for setting V4L2_CAP_TUNER on the VBI
> device from "dev->tuner_type !=3D TUNER_ABSENT" to a check of the video
> device's capabilities, but inverted it: the VBI node now advertises a
> tuner only when the video node does not have one.
>
> On boards without a tuner (e.g. the MyGica iGrabber, card=3D105) the VBI
> device's device_caps therefore contain V4L2_CAP_TUNER, while the shared
> vidioc_querycap() correctly omits it from cap->capabilities. This trips
> the sanity check in v4l_querycap() whenever the VBI node is queried,
> for example by udev's v4l_id on every hotplug:
>
>   WARNING: drivers/media/v4l2-core/v4l2-ioctl.c:1119 at v4l_querycap+0xff=
/0x110 [videodev]
>   (cap->capabilities & (vfd->device_caps | V4L2_CAP_DEVICE_CAPS)) !=3D (v=
fd->device_caps | V4L2_CAP_DEVICE_CAPS)
>
> It also leaves the tuner ioctls enabled on the VBI node of tuner-less
> boards and disables them on boards that do have a tuner.
>
> Restore the intended logic so the VBI device has V4L2_CAP_TUNER exactly
> when the video device does.
>
> Fixes: 8e53399c63c3 ("media: em28xx: Add support for Empia em2828X bridge=
")
> Assisted-by: LLM
> Signed-off-by: Christopher Snowhill <chris@kode54.net>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/usb/em28xx/em28xx-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/=
em28xx/em28xx-video.c
> index c418add65bb5..cdf1dc692b08 100644
> --- a/drivers/media/usb/em28xx/em28xx-video.c
> +++ b/drivers/media/usb/em28xx/em28xx-video.c
> @@ -3001,7 +3001,7 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>                 v4l2->vbi_dev.queue->lock =3D &v4l2->vb_vbi_queue_lock;
>                 v4l2->vbi_dev.device_caps =3D V4L2_CAP_STREAMING |
>                         V4L2_CAP_READWRITE | V4L2_CAP_VBI_CAPTURE;
> -               if ((v4l2->vdev.device_caps & V4L2_CAP_TUNER) =3D=3D 0)
> +               if (v4l2->vdev.device_caps & V4L2_CAP_TUNER)
>                         v4l2->vbi_dev.device_caps |=3D V4L2_CAP_TUNER;
>
>                 /* disable inapplicable ioctls */
> --
> 2.55.0
>
