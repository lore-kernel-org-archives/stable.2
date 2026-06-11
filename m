Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A93C988D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172895; cv=none; b=ra2x7Mg9G3bmzsh1t026TlcKXhtLSTqkBwrLF7d5j85N8DVyslevCT44AfSpasNzXDbZQcQP4xLMt0keFUnXDN64cngFv3henqigOPIEtHA3j4B7feidn5aDReV8xIIGSXpT9Y+vnDIe/DJzAvmEmK8oyrMRz+GVphiSZ3gfL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172895; c=relaxed/simple;
	bh=9eZNdwPNfhUP5WBjs6gZQh1KrkEXUZ82qFh22EZeSes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJn6jdfk30InKXSNAsME3MkelGM0GjPsPlZ9KnSZtbD0sI27CLMFf5rhKh9M/YSJQJtSuJSpUcpwzDI5WFihFPuR9w/h9PBpMrIFavQXRVEqp1HKHXah5f3U29vT+4HKVBC7uT87js77JHlNXLC01aznJnghhfL9hNKAe3CrNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mina86.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibPJU6bb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mina86.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibPJU6bb"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so1052180966b.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781172891; x=1781777691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLVj8HPnjQUPxr42XEggbTLDi52RglLjMQW50aq25TE=;
        b=ibPJU6bb3DAVPz1Kyvi2HLUag1BIJq8yMEbuhR57tYz5FoEk0TbZYmXqAqNbZZpqFX
         XE0o1XNT542PbEKiidKZcClUkNR3jqIwIpldnn6sqY0Opso81qcgvD0zIDDxM3DXODn7
         hMTDCqUpW3jC3KJU+IEQGEeuL4IxdkkyrrxlKvfsVd7fgGQo0pXQr3K2kh8ueYr4mu/1
         auogk/HY+HxY4I4lXKWMR3ufGL6uk2HcjFup537a53HG5q5yy4DtH0XZorQfJrULRsIW
         akTLyacvXp6uRoJGxswOOc05lfNhL7JTBvxoQ1ozD0Nr7bOwYAgBhGeJEgfaHDSCVpur
         1dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172891; x=1781777691;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLVj8HPnjQUPxr42XEggbTLDi52RglLjMQW50aq25TE=;
        b=BDRWmCal2b0Y14heSKLzv6ygfteJsrE7514Sec80wmWzHnk2qrJYT/UGK+OcnTGTC4
         7OPkR/lq4ScrRkFIWXNqXIut0WxSJ3tbVwm7uAJWenXP4va2eVTIOUPQZivXmEB0vFrP
         Ii+J+eegvYK+ouePPAXA3KGtkJ16nqwmjgh/uNb/1a8RaIto0esDHC+Sbl8MprMNE9WD
         NvcJJJwSgmZmrP0QJasvpDAsIoXJ6YOoGCmfRhQrpnFwr70jEKcgwIcbRbIdh1aXKIte
         f9RL+96PCQhMyHFCdmSRBRnZKO3HBFHymRhKvSdfrchPpQFnwnzpzqbgRFE3vpUMOEDe
         sqbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VeNKgRrvPUV/3zmswAq1SuwVc1t5k9JJCl7YDp9SsFbUdQ0cXHu2fThbtLeP1W44jG10UBLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncaIMINNx6APmcJ2/KEZ66WEVCRKgbsv24E73IrFOc+eoVINk
	sgPLyjbR/VbRguXjPqUKqtnVwHz16cbz1w7S+/hm97qIqZRyUbyNB8CW
X-Gm-Gg: Acq92OFJjDJ2xhCq7tnJSsAFMa/wJv5t9Vgj5wizQZeuXyujhuM55rfrj0VE3qwL7a1
	8X4LRNuFRyTvgauDeyuRCnt+4NyXg4+R9vcoberYCXV5J3PMnFhbBWO74hsSauI4AAQ4uHHlUyJ
	pUDs5+6jVpX5G4tMnY4G05jjgsrvdzlqA8192zz0M/Tw8BcEqOJp9Mt/JXVDUZUFbLJdtD3nGy3
	tgXuq5aany4dE/7qR1UsNhPnFvtl6MoFmK4DnPZNTFz10MM4l3ZSnziUPLPhaIqF72qLBmC7K+i
	I4QYCwH2EuDoqpQ1tSSPJP+Op/PNHLiiFnyEEZjKqz6YG3jfQCSUnmCzk9Lwg0yJkO9stPAsRkD
	PpOcHYlSPR35DC21ZI7kzjqwDcfK0pcfOWFKC46EJ6x1GXGPpfsJ7+AtATcPaaL2INdawDdAPO6
	M10YtHnJWQ/Qgda/RKbS4zdQMegpjnYG3baiV0VZhcKN8Fym58TQenhMo/iAah
X-Received: by 2002:a17:907:9689:b0:bef:d3a1:5065 with SMTP id a640c23a62f3a-bfc863dffeemr91864566b.18.1781172890398;
        Thu, 11 Jun 2026 03:14:50 -0700 (PDT)
Received: from erwin (109241130011.warszawa.vectranet.pl. [109.241.130.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb6785ef3sm44632866b.59.2026.06.11.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:14:49 -0700 (PDT)
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
From: =?utf-8?Q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Robert Baldyga <r.baldyga@samsung.com>,
 Felipe Balbi <balbi@kernel.org>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>, stable@vger.kernel.org, Loic
 Poulain <loic.poulain@oss.qualcomm.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@oss.qualcomm.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: initialize reset_work at allocation
 time
In-Reply-To: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
References: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 12:14:48 +0200
Message-ID: <gocsn4hb4w977+wspbo8l48+@mina86.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09 2026, Tyler Baker wrote:
> ffs_fs_kill_sb() unconditionally calls cancel_work_sync() on
> ffs->reset_work when a functionfs instance is unmounted:
>
> 	ffs_data_reset(ffs);
> 	cancel_work_sync(&ffs->reset_work);
>
> However ffs->reset_work is only ever initialized via INIT_WORK() in
> ffs_func_set_alt() and ffs_func_disable(), and only on the
> FFS_DEACTIVATED path. That state is reached solely by ffs_data_closed()
> when the instance is mounted with the "no_disconnect" option, so for the
> common case (no "no_disconnect", or mounted and unmounted without ever
> being deactivated) reset_work is never initialized.
>
> ffs_data_new() allocates the ffs_data with kzalloc_obj() and does not
> initialize reset_work, and ffs_data_reset()/ffs_data_clear() do not touch
> it either, so reset_work.func is left NULL. cancel_work_sync() on such a
> work then trips the WARN_ON(!work->func) guard in __flush_work():
>
>   WARNING: kernel/workqueue.c:4301 at __flush_work+0x330/0x360, CPU#3: um=
ount
>   Call trace:
>    __flush_work
>    cancel_work_sync
>    ffs_fs_kill_sb [usb_f_fs]
>    deactivate_locked_super
>    deactivate_super
>    cleanup_mnt
>    __cleanup_mnt
>    task_work_run
>    exit_to_user_mode_loop
>    el0_svc
>
> On older kernels cancel_work_sync() on a zero-initialized work struct was
> a silent no-op, which hid the missing initialization.
>
> Initialize reset_work once in ffs_data_new() so it is always valid for
> the lifetime of the ffs_data, and drop the now-redundant INIT_WORK()
> calls from the two deactivation paths.
>
> Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Acked-by: Micha=C5=82 Nazarewicz <mina86@mina86.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index 75912ce6ab55..1ee21e29ef73 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -288,6 +288,7 @@ static int ffs_acquire_dev(const char *dev_name, stru=
ct ffs_data *ffs_data);
>  static void ffs_release_dev(struct ffs_dev *ffs_dev);
>  static int ffs_ready(struct ffs_data *ffs);
>  static void ffs_closed(struct ffs_data *ffs);
> +static void ffs_reset_work(struct work_struct *work);
>=20=20
>  /* Misc helper functions ***********************************************=
*****/
>=20=20
> @@ -2221,6 +2222,7 @@ static struct ffs_data *ffs_data_new(const char *de=
v_name)
>  	init_waitqueue_head(&ffs->ev.waitq);
>  	init_waitqueue_head(&ffs->wait);
>  	init_completion(&ffs->ep0req_completion);
> +	INIT_WORK(&ffs->reset_work, ffs_reset_work);
>=20=20
>  	/* XXX REVISIT need to update it in some places, or do we? */
>  	ffs->ev.can_stall =3D 1;
> @@ -3775,7 +3777,6 @@ static int ffs_func_set_alt(struct usb_function *f,
>  	if (ffs->state =3D=3D FFS_DEACTIVATED) {
>  		ffs->state =3D FFS_CLOSING;
>  		spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -		INIT_WORK(&ffs->reset_work, ffs_reset_work);
>  		schedule_work(&ffs->reset_work);
>  		return -ENODEV;
>  	}
> @@ -3806,7 +3807,6 @@ static void ffs_func_disable(struct usb_function *f)
>  	if (ffs->state =3D=3D FFS_DEACTIVATED) {
>  		ffs->state =3D FFS_CLOSING;
>  		spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -		INIT_WORK(&ffs->reset_work, ffs_reset_work);
>  		schedule_work(&ffs->reset_work);
>  		return;
>  	}

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A3=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
