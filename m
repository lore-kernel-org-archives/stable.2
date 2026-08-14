Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEA3D3CE5
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740762; cv=pass; b=ntjwmGSvoQd+9bDDxJYQjmQ8zOAhfJqP0xcJj8ZMJRnbj/bm2H17LRqukk9r8VL35SDIqXaXD8+0TaC+C+sRg9A/Kxvh5Kwd61XMB6fdfiQS+2oEY33l7SPxGo6Ig0KXgQskFkrbQWVLdhKnX+mLI4xbo4kdFJIOgspn745uBJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740762; c=relaxed/simple;
	bh=sCXphBC86pYZZvHSb0Fr8gFS0TiY8BtblF7I6Bksz7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoJ4Ca3kTwILgOKpVTESSRqALCjnsA7ooHY64pwW2SYs/IrI6Wz+cVt9a1p0OIjZnlt8BELgKCeBHzatii9dC+nhFHYSLwMyTfL2S3iO4cmb9u4FiOPtT6Q6L+tfoMFwD2qGNcV1hM/QM2/38XtgshXEvhk14s0LxpIkuO6OLaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THsSwmBm; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THsSwmBm"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2074710751so231774666b.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740759; cv=none;
        d=google.com; s=arc-20260327;
        b=XaKF9LBCP3stvblsSiI4xUfyPAGk0QGPZEqaMsK/ktagK5SEIGkEfwIMFIFZzS891x
         KlQCPJoODtWEbk+0GbHbma2bYcA96qQseA/qSCmVwg4+L7T3zKsCp3JKbt9ktsq3fLBi
         STxjIIlmIixEqePymRf8/6mHCGXW7TqcE0+P6CiNwf/CYc2IzrkAJfVNi+Cq6la8zJQ9
         Rl2Sq+Jz2ATNXMgKfNX4CDX5gkJH86kUlDVcIXK35RdSM38r4S6cN/J0VsLdgCmMQRiF
         ImcpAe8xvuRX7WF7eagLm80q73mIt1LEitubLv774rhHMd9KqAIEMbUFZyEJPPbBvSYV
         cXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        fh=N7ss4HiSraXJ8x/sDBfpXazqvzvVE7NtOHB5O1+eZno=;
        b=IzKUa1hO7RTBOfHWrVGHussHuj93o98CNHPWTh/x94RT+FUySkBq2iAznV8IjdNkgU
         Kn92XtD08OpFsLdtCkMtY0xTZD97khZX7V7+IgVmSEcEYWD/23QqUQAJ9n9DX5W1sbkQ
         yLrWiGM4qeXH1oJ4jUU5aNnDDWd+x/8wm9PNOH4ZREh2R5fCI28GZkI3abWUUWi+TZYm
         Qn4ykOCBRfCkKdWzu709956bXI0r2YpWJFYcPQh2ushnpqTqcxu/cJ73mSfnKpo+gOsG
         MZBiD5/7yLqgRGPujtki8/PQlEZk8kQsoMyHRJsBxC32V6FnCMT8M/UE3ir322mL0MI4
         ySLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740759; x=1787345559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        b=THsSwmBmk8bh9FNq0l4VcYRmSW6dxBEkzeIW0mVDrhCCQZa4qjIfu//KQweoZfdTqu
         7Ewwk+poj4XA0r+dqv8eFGEQ1XN0D5FPW8rbzqNLpeFBNyQsCKu21goQ9NHsIm7dxyi8
         bAqkYJtD+du9CJDb25qRW8vHr/MtFms56HvEDXOajl94E5XUXLadHX20lYIGmWiHT3Of
         WgVLPnQ2xrRldmuNkRH65GLKOI7Az0uslHuPiZ3X5dJ8iG/j8bMs2cWOQRwt2fB5L1PD
         lvmmJsKbafgxcUq9g0YyoK7HaDA1DSXVkpuV4owrZ9modR2/bJus/rXDO42q5qMY1mUM
         zd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740759; x=1787345559;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HhJM1+u+XBDc26vzSs4VoT6h5ApyY8D1IUkRZCnGVMU=;
        b=j/BPzP7fASl6jsOLD7qGHyx7y0gX7ADFxH7meuRhcr1voAgE/1fc+DmVdRzmtaxLjG
         g8rrokn4ZdSyDtb7ksv87OuhYV27qk4B9Y2TqPnANprd8JQdsoqWS+Ohla3b0c7B+DeA
         gKEKu7UQ6AVvoZjls3iaW/hBhwqPUEl3K5Dv1gSeiUNXgl2Ic01w0c+P1cmzcCgk9XvB
         mjN1kov4LPV9pwLHahNY1O9dcW4ZZB863zUZPNtI8KpzCe1MCTUbdy0kwubopdh629eq
         9RfwS8+0NP2f5T6qsXduorNEgTuzAUzQYAa6p5IT87nWFaQC57onP7GWkLXoLhKpQpd8
         1ANw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9zZrXtzCvRnE50vlEMqVuIUm5c9zLW9STG+VBHqW9+33i1gIRY999mfL6qul6XHaru7pqTmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ecvtVoslnH1XwAZT9OqmiarRhjH4ZQTenJXir3XDfRlOTeQp
	Eh7S5A3gZYYjuBA7GTQ6NLwqf7h/wDGuE6iNBlyqoe+PYIfM0mpmRt9SWypZOkUe4ca5YyZh+hq
	ZSlL8abrTc3T761tvx+avVJyw6WLr26o=
X-Gm-Gg: AR+sD12QBrmxaqn0C23Lrf/REEBPFIC8IGgZ8rvlor77rt3GIVC3nwXgi4l34XTElqF
	X/hk9wKCC6zAGSB11sHkot8BidxYd0JhB4zH/9jeX85xIgvx/xIr2gj51GZ8++99UeeEMW7NlmK
	ct+SYsh8or7c5sTqoS4DrnpJ73mYom7dSngjuGzXyVFzBBxA9bGzxC+tbZd1q72DM0P5zCc9nvR
	6ZMeXVw1ETX5siaBxz3arycohwUgapGYIHM3n2tELqtpVSWT7b0vn2lct2c+kkAYyDjGzVGkR/A
	cqQetzOyyhrVQ7Pga4S575sb/N74TnkdHWU9fOhcoCLa+g==
X-Received: by 2002:a17:906:6a16:b0:c15:ffd3:da25 with SMTP id
 a640c23a62f3a-c212a227198mr373446366b.28.1786740758577; Fri, 14 Aug 2026
 13:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 14 Aug 2026 17:52:25 -0300
X-Gm-Features: AcwNN1XSoGZ8XocejXkOXlwfv9yvHFGD5JzSQPVIQnEYHTUZK0vIvcyD9MEc8z0
Message-ID: <CAJq09z6RuFCDtaYLMavR8prsjw4mQM3br4jO09uHv0S8yUGK-Q@mail.gmail.com>
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use gpiod_set_value_cansleep
 for reset GPIO
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
>
>   WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#1: kworker/u16:4/61
>   Hardware name: B&O MAP CA33 Rev f (UNKNOWN) (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pc : gpiod_set_value+0x44/0x80
>   lr : rtl83xx_probe+0x1d8/0x3a0
>   Call trace:
>    gpiod_set_value+0x44/0x80 (P)
>    rtl83xx_probe+0x1d8/0x3a0
>    realtek_mdio_probe+0x24/0xa0
>    mdio_probe+0x38/0x78
>    really_probe+0xc4/0x3e0
>    __driver_probe_device+0x15c/0x1b8
>    driver_probe_device+0xb4/0x120
>    __device_attach_driver+0xb8/0x1a0
>    bus_for_each_drv+0x88/0xf0
>    __device_attach+0xa0/0x1d8
>    device_initial_probe+0x54/0x68
>    bus_probe_device+0x38/0xa0
>    deferred_probe_work_func+0xb8/0x120
>    process_one_work+0x184/0x4e8
>    worker_thread+0x188/0x308
>    kthread+0x130/0x150
>    ret_from_fork+0x10/0x20
>
> Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO can
> be used without triggering the warning.
>
> The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> since the driver was added in v4.19.  The call has since been refactored
> across several files - from realtek-smi.c / realtek-mdio.c into the common
> rtl83xx.c module and then into the rtl83xx_reset_assert() and
> rtl83xx_reset_deassert() helpers (both in v6.9).  This patch therefore
> applies as-is only to kernels that carry those helpers (v6.9+); older
> stable kernels need the same gpiod_set_value_cansleep() conversion at the
> corresponding open-coded call sites.
>
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/realtek/rtl83xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 09fd64880232..8121ec12fd8b 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -334,7 +334,7 @@ void rtl83xx_reset_assert(struct realtek_priv *priv)
>                          "Failed to assert the switch reset control: %pe\n",
>                          ERR_PTR(ret));
>
> -       gpiod_set_value(priv->reset, true);
> +       gpiod_set_value_cansleep(priv->reset, true);
>  }
>
>  void rtl83xx_reset_deassert(struct realtek_priv *priv)
> @@ -347,7 +347,7 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
>                          "Failed to deassert the switch reset control: %pe\n",
>                          ERR_PTR(ret));
>
> -       gpiod_set_value(priv->reset, false);
> +       gpiod_set_value_cansleep(priv->reset, false);
>  }
>
>  /**
> --
> 2.47.3
>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Regards,

Luiz
