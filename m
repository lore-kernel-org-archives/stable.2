Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121438CFE9
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509982; cv=pass; b=TRaA5A1coV7LcWSu/8cnHPA9ovulSsanuWg1Yhz4HzTZ0ZIxU5WDe0UFmVJgBNEsv0vZnwn0BGDG73GNX6fHhMXphpWglCNpNt4Jf5KnqaYRcMzDGtBpRWA9VuR6WSfXOhJ296UG/IWTLf5UvZNCq17hSNzvhxXuE36ycl4OsfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509982; c=relaxed/simple;
	bh=oPHJcJlXWx9fnWI2yBrgmxJNTfinqFPRvlD/PhtE+3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT3ulJvPjrUq5ID/GxeJaHA7yPAEgjt2idRkBeYZg5XQuk4kgmk2rCf4C5h8y8hpe+oCMqymDAxdhCVefcXHrRQ4tHB6GWPqgEEfa4ehaU97LScOSBnM8NLcfqh+PRmllC05s7ti5DwyguAue6idGQJ6khy5QSRaqzTitYikoEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9VX2xeP; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9VX2xeP"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-660323f7b27so8029254d50.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 11:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780509980; cv=none;
        d=google.com; s=arc-20240605;
        b=Ar8MhPwmUCzEicrgyjkoOVLMjRZGjS8S5vOwmHGTgh0RSoeEoY6vX7O3jyET68qSxD
         8SXnJiIRqblD3uNjDj9R0ujEk3sCsoudI6OGsXMJuYGA5hLM5ZFJEg3k9jW+F1HTSv9u
         orjx7o7o9EzDVSX1YvKvGOrtFAunYmT0VzQlp43U1RUcCPa/yW9lnSeLFPOAI6NZ5332
         Ci4RUtB1FOuPbmW77QpsHAmuPfUlKdFxWtKttrIP+Rwv+A9NqpyVSdlMJ2z+9JNjMYDK
         Ot7XPgopyTAtTmr5IOGX0DJtjoUybwfDaVY//v+DjGcZzBULCuQgWhzGl2kfKCvCtNo8
         7fbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        fh=K1x0W2Uewz8N5XDL6pnMZudXcGwKpXhseaVSAgDMlHU=;
        b=DQIpWa7tKFGdbr0NtiSiezae5K7a3qxBaQ3DVH2DckqBysndgcOon6YKN8jIol6b5x
         DFyhW+gFj1NVklmnFaHoXPtQ//gs3HN9OLdDAJwjhJgzov7dXM8mha8YeJcpzzJpqQPK
         3ZvQlh+StvgSnoLd6ibgJZ3/nAPFiNTzHIzoaT1bGsKxq2hFW8cNLuQWppoag7FSrP+s
         Ovde2aqxj7QwdwmR875uov1j5hQ+3Vt9Zacy+tJ4RZTkibREhl8Siztry73XB5whwuZS
         LwCUy7kKbmsy2UyRehlVU3RTjPEbcSwyMK7ILt1521/wJX5CZ2DEE7JHrgwsRMfr3wZA
         ZK+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509980; x=1781114780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        b=W9VX2xePmZzpWaNwbbf5w4m0QL8ZzGzv2GbXyZXSmFSayg+YndiXg+2/oAt82PzPJz
         lqu0V/NlLGlzAQYjDgUHNEevl0SahKcdzcer7Si7/dV7ueEA7zWM6cN32TyL+3zcc4FB
         +O4Id7dhB32AdEmb/JlhC9ByYZIQj++SPdrxV9kyJNZHSJkVlVDOOSqGn16BE19iZP0d
         xdX5Js4V0FFaQ42XmblPiXbmElYhcrcvwFpUN7y1hLo5Qdi5tcx1rvX1lmZzEsOncymr
         fjoR8L+r7J8JPMWvFPqrTe1lpm3WHD7v8q90SJGY25o8+3q/c5Ad/U4bblvuK2YisC/n
         6IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509980; x=1781114780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        b=gqdtkQ6Q+3IzY/ImGK8PKNa1pYoQgNwS5TrUKq28e/SxrifBFv4RK4yR/FuRcRPSK6
         XEjKah1jAGwXmgBL0bnY/0MBOWXjYSRrSjkGxYxziGb3c/SH7VW8Ghz4ydnUVHYH1qf8
         ub0mYFMEzwDxMPAByIrJZLa3f0v9twD9boNBNKB8gJuIuEKSDooYx7rlgqUiRqJOE7hg
         VCH2jkbeTIb0ihNBbBLdtemlVG/9HAIH04Q8jvkF+yhdscwDP9UjoBtlH2NLhV3k5Q2Z
         tIOj6N9SuA5RPNUCxZc2aU8PXebj+47y25ZJ5AAazxdC1dArGZWpfLEEsW+ntJ+yhhDo
         yksg==
X-Forwarded-Encrypted: i=1; AFNElJ/MoY6J+u/cjiaf4XhuG7vjj0gEAbwGZhIjCGTHsMAYvtroGfpVIDF+gYhMYlQykc3mcGCef+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuM9pqwF5DlxwPt9GXULFM+08WEVcEXvJENfHAuDFbLe3xJ44
	dCDB4zJP2Wz+M+GAl1eBWcUVp4vxtippaNJlcInUR46xXSHtNOX2fnpn8KJYSPvwooPs1lRArL0
	oJgZVvat6b3co3vlF5UJdYMltsqblhiU=
X-Gm-Gg: Acq92OE/1LVrSAd4VhRATTRfXObJLFEwQtT+7OmrMgaPdxQkYC2kjfV75tXA4nGQu6U
	VONW6hF0MkL0KqHEWpJmN281nqBH6Gyb26vl4o9rusqlbVWT7dQPehmpbunu263Bpi/rhpOK6P3
	AKlcrd00kLk7Nz9baxWjzDoPny1OfLr3J054UaabFuPziLNi3LKI5qLyebnVnokxFad4ryRiGsU
	FQVUldxN76cppH5+Jozh8vb+/oTlVUrl5uIPEypgCzkbSMDueowWgbIoYQVkDrUzVUfUlsB9jY2
	MR/r1H6IOf6DPA4HjKR4YOGD29XPr+yHzWUfDvC8rCSqvckBxfI2cCt4qKUOZ7DWRCd885ieW5Q
	Y023w
X-Received: by 2002:a05:690e:1515:b0:658:84f5:3c6f with SMTP id
 956f58d0204a3-660dc592265mr3698991d50.58.1780509980194; Wed, 03 Jun 2026
 11:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603143643.2514595-1-johan@kernel.org> <20260603143643.2514595-4-johan@kernel.org>
In-Reply-To: <20260603143643.2514595-4-johan@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jun 2026 14:06:08 -0400
X-Gm-Features: AVHnY4I7qeJh3_0bF4A64AstA3PsaegUMrcykbj28ibp2b7nDS7F-sCKT8_NtNA
Message-ID: <CABBYNZLr+kLHkjRGOEgyVK7RSfvu0KGjJNrnp5mh-sM66i=5WQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 3/5] Bluetooth: btusb: fix wakeup source leak on
 probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Jun 3, 2026 at 10:37=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to disable wakeup on probe failure to avoid leaking the wakeup
> source.
>
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Cc: stable@vger.kernel.org      # 4.11
> Cc: Rajat Jain <rajatja@google.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/bluetooth/btusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d0a83a1ffdf2..622df2fff497 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4181,7 +4181,7 @@ static int btusb_probe(struct usb_interface *intf,
>         if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
>                 err =3D marvell_config_oob_wake(hdev);
>                 if (err)
> -                       goto out_free_dev;
> +                       goto err_disable_wakeup;
>         }
>  #endif
>         if (id->driver_info & BTUSB_CW6622)
> @@ -4427,6 +4427,9 @@ static int btusb_probe(struct usb_interface *intf,
>         }
>  err_kill_tx_urbs:
>         usb_kill_anchored_urbs(&data->tx_anchor);
> +err_disable_wakeup:
> +       if (data->oob_wake_irq)
> +               device_init_wakeup(&data->udev->dev, false);
>  out_free_dev:
>         if (data->reset_gpio)
>                 gpiod_put(data->reset_gpio);
> --
> 2.53.0

This seem to trigger a compilation problem according to sashiko:

The goto statement targeting err_disable_wakeup is wrapped in an ifdef
CONFIG_PM block earlier in the function, but this label is defined
unconditionally here.
[]https://sashiko.dev/#/patchset/20260603143643.2514595-1-johan%40kernel.or=
g

--=20
Luiz Augusto von Dentz
