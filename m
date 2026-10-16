Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205E397944
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117085; cv=pass; b=Nc108ZuYDinLL5KLiyHXFwOlu43ejDofBDsl5fi0HB1rYwhunLUb79h6IzEEKOCGXnnhniPuAAzJiepwNR/y9VMD3sn2MbqOEif0TOLzPRbY9LOdKHknJUMsZb2aiRk0kYbvn7XrHBBrbr0Q4gwUf4uUQoSJtAKmlBI1qMaCH9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117085; c=relaxed/simple;
	bh=WMoaHnDN0Y06ITTfRIbQrAFTUkyQpyCsDLwooGLQ7rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cx3DgluOGuMHawqjyuFuUh7bww1tM5A5EBmqZp6n99nWKOjRYPd3A4aems7xyE3vzLI6ouIMAWoSn2L/gRc+PEzTXt8Z46VmTIVAHOHBdjvhsU4A2kNDLW4qxZ1/KCRT+FMlxZOXiPLrOMAFxRcRrDANz4GYdYT4WVxDOFPygSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvYRNRUg; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvYRNRUg"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6dde81a6820so2058997eaf.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792117083; cv=none;
        d=google.com; s=arc-20260327;
        b=Ka6i8M8+b8ONRHVAl0QMyHdV8yr0qBfLWt/pP1EDjzKc41zbs2r6jL5tU3g+KIRkiz
         NOsVi/szSP+5GNNWvNLDTWJJBHyWMCEOPou2BmXMADHPLJxj43IMX7pewvafjN+nbP1+
         5WXUgdxC69RV+ZQ+Tezo1vk9NneCP6qawkXyN9hFfS4j9I2671yVwO5lCG1J1148zQQl
         OM0Ar/a0i9FSiYT+HK9UaBqJ6wZ2Le7R1uQW3wU85MnAlNkdu1BKi+5yqQgpHoHRNkak
         1Ry1EgDG4G3v7PueXUrObQNeJMqz6ipnhW2NvN3DGla2H+Ku0AA9wE1koJ9DafR2tr9Y
         rgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        fh=kvUxI33MvvSwmaKhLNDN7occEsuQYRfQw7oV8aopsyo=;
        b=UZxg/ba139hoT7u5P01uvTMjb/Z75wDVEFmzXZ3fFYJQGoy6BWvjLcI9T7h0OXBzRc
         4Gvx3qrW5wFmLMG6U0La9+GNU6+UMvVJdYqEf2SWnLgCEpOag1WTbTpTe3A9f4ufCBOw
         I2mZGV5nQ0IL9uwaFkqlwG1nb8vFWxoeRQh5KRUvJ9noPd/waDCzG4VCt/9iAMOzsM4Y
         jKNWrH2iMJgsPRwQyvZVXNj0pO7pXgz6SoMRmnaoSeE/b9TkEYYa4NFRjWeeNjEGRJgY
         EXkCwtNAYZNJ/g7L+f8WUaoiQFBU3bFUQeVytdRTlfRInpT6YiEhC6+Ulbl9jhoF/AgV
         1iiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117083; x=1792721883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        b=CvYRNRUgqITnYdxa3GUa/JUT83QbbsI67Q2k+aDHB5dWQ8cO7uP3iJT17EDbEPoCt3
         CPQ6loVrAkmwyyAjL8iD1WyX+un4uXGZVriDDPegn9Bp5DF81j7IGkMtSRBaxjnzM0Vr
         A4cSZUZ1LQd5dQ6mQ+wFsyrkiZJlDn3yaxT1z9ZGPGS+XE7WfFs+E8Z4yO0v/xYXRAFt
         hoIvX8p1jEPLpeM3mdWQcx4YTudzOB7FuFe8UmeUyaOsXz23zZkAKc5Bnn8C07VVCB7B
         9GF3ePb5XYz+iKFqN+TGJVDp3IBOkWZYtfDYFgfYDpdWWs571mZfgyaJQPCyGd7RteRF
         x7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117083; x=1792721883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        b=s/7FkZpj/XqQsNv7uYb5W7fypWcRtp63zoR/7nmSdo9hfN6KOWhEE7nFFzhoHsxSmo
         qkMbhHE2obt2F7HZ36PjdWZibLY8FJySQupMYMblaMhZnedQpADIsfMAtRTxQY0pCoMA
         QY8SbS8eGlE/OoHNMmCLKVdaoHX1httoxQRT50prF3tE0nMuMhou+91cO2lDp6RkcOtB
         /OyXcgHfFw+iuW7+mS9ZG5GdX6TUIynEYX6URegmnKqvFeSAXjaG2zfeJwUJvM0na/JU
         tstZtzm0KAW2TagkJlc7JaJsKmD1A5Vxq6Wk0YYuDq6W3HXrBZ6TNE+E/UZk/LRa7wA6
         ckrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsd9NMW8CCzAKpUihFjBMdk7puj1wRXGc9qKrRChlxcngDwfuSN6Eg3iq03kBGvOv989dczpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW4XqiGd7VSKIizGBXrsFxMwWSdtY2th6VaskEtlPHlnCG2VWJ
	1us3HdmuBcQPrPpy+zI+TBqBe4rsquw62SEpZOnI5kTP1J9mq8uQv5apxDwoh63ijIY54YWId/T
	0vgsTsv/Io11r9PLNqbWpglK2trhbjKaqpUsN
X-Gm-Gg: AYBFou1Ox2PXTuiLXxSvbfD7chEr766mamzZvpi3XncmsqXYlqEmdjR7IV2XvE2QfuN
	n33y8hFv3OuP+saDRsIdCbCNnw3rD+ZE6jQ3sd8U4Ljr0mPvvY0Jb1b4huOwsJjDdDrEr4aMi0V
	ZL0RdyQCGP5e5h+FgUh1kUm2ZHcMjgCNMh837WYTQKay73Zv+CB5Mm8vWEDzaWi5IoQC3U4Fudo
	bgtYb5uNf+vtBA3zHpXWavFqTtEswVHEmopAVYfuwI5AwCqr6SaYC44w2JY9NLiNYJ2Yv1WioxC
	7cj9QK0y36GAQnCGwQGJ5DoJwAaAbK6NF8VxoETLNPCpzDL4hlMjzV5Jrb1nxXFu6f/NKJOVPN0
	6iVXO4pFIPkpF6HuHUkfPYalEeuwsPQ4NCt0zc0QAqIQljr5RjPT1iKQ=
X-Received: by 2002:a4a:ee10:0:b0:6d8:4e2e:9978 with SMTP id
 006d021491bc7-6ef0f7afeb5mr15006342eaf.21.1792117082607; Thu, 15 Oct 2026
 19:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015120654.241354-1-sono7ri@gmail.com>
In-Reply-To: <20261015120654.241354-1-sono7ri@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 15 Oct 2026 21:17:51 -0500
X-Gm-Features: AclHuK80oQQQEs0WnePVYvVi2mzpo5E302hrIEVEp9c_Zj1kKcbWADJ0Eg4LJ1s
Message-ID: <CACVXFVP5KQ3=cxKsJJ1ktqVdGa281kZ88SVxPgW5C=Yws7a=-g@mail.gmail.com>
Subject: Re: [PATCH] ublk: pin module while release work is pending
To: sonotri <sono7ri@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:07=E2=80=AFAM sonotri <sono7ri@gmail.com> wrote:
>
> ublk_ch_release() takes a device reference and queues exit_work.  The VFS
> module reference held through the file operations is dropped after
> ->release() returns.  A queued work item does not acquire its own module
> reference for the callback.
>
> Consequently, normal module removal can start while exit_work is pending =
or
> executing.  In addition to the worker callback itself, the final device p=
ut
> can invoke ublk_cdev_rel(), which is also module code.
>
> Take a module reference while ->release() is still covered by the file
> operations reference and drop it only after the worker has completed its
> final device put.  A rearming worker retains the same reference.
>
> Merely canceling exit_work during module exit is insufficient.  The worke=
r
> is the terminal path for the device reference taken by ublk_ch_release(),
> so its cancellation would strand that reference and skip the associated
> cleanup.
>
> Fixes: c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk cha=
r dev is closed")
> Cc: stable@vger.kernel.org
> Signed-off-by: sonotri <sono7ri@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e71..71556c34a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2613,6 +2613,7 @@ static void ublk_ch_release_work_fn(struct work_str=
uct *work)
>
>         /* put the reference grabbed in ublk_ch_release() */
>         ublk_put_device(ub);
> +       module_put(THIS_MODULE);
>  }
>
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
> @@ -2625,6 +2626,8 @@ static int ublk_ch_release(struct inode *inode, str=
uct file *filp)
>          */
>         ublk_get_device(ub);
>
> +       /* Keep the worker's callback and final device release code resid=
ent. */
> +       __module_get(THIS_MODULE);
>         INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
>         schedule_delayed_work(&ub->exit_work, 0);
>         return 0;

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
