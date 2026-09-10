Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36E425CEE;
	Thu, 10 Sep 2026 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074945; cv=none; b=br7Ur26Oevw7kJpSMPvYOHbRS8zjbcEQo6LfGdWfdiyH1cNrs9R1VD0ZSvo6GbIeyfszyLxnv5S+b5cEpFjdagTbJppSR3nZp0xsPHFq9vV7kmz3Qcfp74lkTrXV3AMdL+jOrz9l0JalTvM6rwbVlXkUGeSqy0rCphTNPNoI/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074945; c=relaxed/simple;
	bh=BF1l/gJGmJ2v2cGaXXpmqVDjtZ+m90GoBHwAP+Ywzvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8dwffmF21H43y2p8bgvbDmbjG3c2hQZFfrwwYjjVJ5mNBuP1kQlNNLyvUXg1d8bhQN4hqZxxhPNqpTYURmeyGaHzfIa7eSNSfJaxXx52+/y8E1wV/O8AktaGCkQnc14WPEDgfmVt7Cpge27oAOG4btY4Pzt6yb2bYuVmg179UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Q9OlQVqB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Q9OlQVqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789074913; x=1789679713; i=deller@gmx.de;
	bh=q1yOBrOw6Ws4g+7hn+GZPA284T4xzGrbHkZrFCYF/Yc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q9OlQVqBp7CHd7z+x7TtFkg1opwv0tPDZ1tNPfESLA5EHd22eutDjBW4Yc7xTWDW
	 wIMGqFYesi/TH0Brnb27eYOttphXgs3VpQk7AuCksLk6Vdn58+H/QR7knRz3ldZqv
	 vRDfJ9T8wQ4OVNR/ebIhXowjWKY6kdBZ2vCObP852OSpiHpAwn+ucXIWfKL2a5ZB+
	 NG+yuXVFDc9MysmkA38ULerXK06Z7akiZlZFMQ/Mc36BIlwvEibbYqu5Xr+5QJ413
	 uS/f3zhcqpad0Hn5Slls0TVf5em/HfmkCDQTryxYaZw9MgYGdzwbSUScBr05CgiK8
	 EM7RjyjuV6W6P6qM6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1xDwtb2u6Z-00Ua7G; Thu, 10
 Sep 2026 23:15:12 +0200
Message-ID: <72351d8f-289e-44d1-b241-e68d7d23145a@gmx.de>
Date: Thu, 10 Sep 2026 23:15:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Shixiong Ou <oushixiong@kylinos.cn>, Chintan Patel
 <chintanlike@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20260907021844.25497-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260907021844.25497-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3H+W5M3XrWOCbLt+28Y387nW4fT8T8jc9/trNMNJ7o3mi17aJd
 nD9W/BtiTuXzy9SF1nnpIfCgprq48fOiawnSLE6AhDbUceNdQjJ3TECxtrjapy1j2VfYMPv
 ftZIXsry7NL6WBwr/sRPLELAWzaUZet2jhEpifdp1aNhJCyMBBO5qlvSVKb4bXf+c1kLqLO
 fA4P73VSCupzs8IbHBz/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BNn4iYoVYWI=;ASBC221NBexMq+KJq4emwfnX4Op
 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
 mJFWTSwBqkFVto8a1W8/9ogtdPJTU6M6avA==

On 9/7/26 04:18, Karl Mehltretter wrote:
> The ovl_* files documented in
> Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
> longer exist.
>=20
> Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through drive=
r
> core") moved the attributes from each overlay's framebuffer device to
> the platform driver's dev_groups and renamed them overlay_*. There is
> now only one set of attributes for the whole LCDC. The callbacks still
> expect dev_get_drvdata() to return a struct fb_info, but the platform
> device holds struct sh_mobile_lcdc_priv, so they access the wrong
> structure.
>=20
> Restore the documented names and register the group on each overlay's
> framebuffer device with device_add_groups(). Remove it with
> device_remove_groups() before unregistering the framebuffer. Skip
> creation when info->dev is NULL, as the old device_create_file() calls d=
id.
>=20
> Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.
>=20
> Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through drive=
r core")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Found while reviewing the sysfs ABI documentation.
>=20
> Compile-tested only (allmodconfig, W=3D1), I have no SH-Mobile hardware.


This all seems correct, but since it reverts a few of the last patches
I'd prefer that some other person could also review it....

 =20
>   drivers/video/fbdev/sh_mobile_lcdcfb.c | 37 +++++++++++++++++---------
>   1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbde=
v/sh_mobile_lcdcfb.c
> index e8324b01700f..18fc4e465283 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct de=
vice_attribute *attr,
>   	return count;
>   }
>  =20
> -static DEVICE_ATTR_RW(overlay_alpha);
> -static DEVICE_ATTR_RW(overlay_mode);
> -static DEVICE_ATTR_RW(overlay_position);
> -static DEVICE_ATTR_RW(overlay_rop3);
> -
> -static struct attribute *overlay_sysfs_attrs[] __maybe_unused =3D {
> -	&dev_attr_overlay_alpha.attr,
> -	&dev_attr_overlay_mode.attr,
> -	&dev_attr_overlay_position.attr,
> -	&dev_attr_overlay_rop3.attr,
> +static struct device_attribute dev_attr_ovl_alpha =3D
> +	__ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);
> +static struct device_attribute dev_attr_ovl_mode =3D
> +	__ATTR(ovl_mode, 0644, overlay_mode_show, overlay_mode_store);
> +static struct device_attribute dev_attr_ovl_position =3D
> +	__ATTR(ovl_position, 0644, overlay_position_show, overlay_position_sto=
re);
> +static struct device_attribute dev_attr_ovl_rop3 =3D
> +	__ATTR(ovl_rop3, 0644, overlay_rop3_show, overlay_rop3_store);
> +
> +static struct attribute *overlay_sysfs_attrs[] =3D {
> +	&dev_attr_ovl_alpha.attr,
> +	&dev_attr_ovl_mode.attr,
> +	&dev_attr_ovl_position.attr,
> +	&dev_attr_ovl_rop3.attr,
>   	NULL,
>   };
>  =20
> -#ifdef CONFIG_FB_DEVICE
>   ATTRIBUTE_GROUPS(overlay_sysfs);
> -#endif
>  =20
>   static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  =3D =
{
>   	.id =3D		"SH Mobile LCDC",
> @@ -1513,6 +1515,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mob=
ile_lcdc_overlay *ovl)
>   	if (info =3D=3D NULL || info->dev =3D=3D NULL)
>   		return;
>  =20
> +	device_remove_groups(info->dev, overlay_sysfs_groups);
>   	unregister_framebuffer(ovl->info);
>   }
>  =20
> @@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobi=
le_lcdc_overlay *ovl)
>   	if (ret < 0)
>   		return ret;
>  =20
> +	/* The framebuffer device is optional, see fb_device_create(). */
> +	if (info->dev) {

I think this needs to be:
	if (dev_of_fbinfo(info)) {
to avoid compile error when CONFIG_FB_DEVICE=3Dn.


> +		ret =3D device_add_groups(info->dev, overlay_sysfs_groups);

same here. dev_of_fbinfo(info).

> +		if (ret < 0) {
> +			unregister_framebuffer(info);
> +			return ret;
> +		}
> +	}
> +
>   	dev_info(lcdc->dev, "registered %s/overlay %u as %dx%d %dbpp.\n",
>   		 dev_name(lcdc->dev), ovl->index, info->var.xres,
>   		 info->var.yres, info->var.bits_per_pixel);
> @@ -2637,7 +2649,6 @@ static int sh_mobile_lcdc_probe(struct platform_de=
vice *pdev)
>   static struct platform_driver sh_mobile_lcdc_driver =3D {
>   	.driver		=3D {
>   		.name		=3D "sh_mobile_lcdc_fb",
> -		.dev_groups	=3D overlay_sysfs_groups,
>   		.pm		=3D &sh_mobile_lcdc_dev_pm_ops,
>   	},
>   	.probe		=3D sh_mobile_lcdc_probe,
>=20
> base-commit: 986c24e0fe44f844b44d365b71ce831947f50298

