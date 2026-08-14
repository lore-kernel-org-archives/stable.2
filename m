Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685783D5673
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737999; cv=none; b=QDi71AOwt/5W8+LK9IXXwZZlr7do3yqxMlhrg3Els6q1NhoQ6V2e+Elgk5Aq8lQyQB9Nf6MFAOH7y4iRo1oCH1Sf/IZE2UeEhBFTp2J5q0A6QkMmlOQApaEivHiOOtFPuXN8ACpOJ2h7bxOPl/ZNpMBiWrn0ZHqvebQi37wQnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737999; c=relaxed/simple;
	bh=yhcZ1G2iM4MIK0Jb6mnbZ904HAhDwWSVELtIHajuFrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6+utoL6MSYGIRCCdQI5YAqBugE69TcxFCr3fSusGuMLiKVHeNHjyYYua/w5FcJinYRUIQQabg1Jg0ianK3BoJ9GyRLtyLkJPNVCnNseaZXZ8vckL9yBApTVp3l74PTAuBNRlWOOexK8nbrTS41kuHJitx2Ss+v8UUy/RwGzdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB/L8k1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB/L8k1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E807B1F00A3F
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737995;
	bh=79pIxoYm5mk7b3kAefC9hN4ARNrWNULO/5RLuPzCwU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nB/L8k1ZkMNgGRzZdax/nJQxNw1o2VOcvEXqE94H1G2Dtil/FrkBm+6vblVBvdLcO
	 HVTe3vrNvHtChFADOIkIjouNeQJ8oqfSehDcrm4R8Fo2+0lmeEDf3h5vLxWyhFDNl6
	 /fAEW943U6qy189bPgscEoZer5+csOMbUQxm1XnPUEc3zMKKgKPVVvvx4k/Q8EsbIZ
	 BFA88eC1GEZzn8F6SfbSyfvV6jIBXsSCFfkDnF5+iULzAZhqTnj4amXeg/F37P7r2O
	 uWl2yzCQWEFEUbOq3Afpf68NOWIX8cZRWSTDaQugpMeZmx3rYtq9GIL2NUqOfK4z1b
	 pAanEEZMA20og==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01146b205so1060474e87.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:06:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZZ+YKhUvfc+VwGJLrecgh4bfrwc2h1uEUkPsu9S0DBQWkFg+uWxQKDgj1c8Yj3hUEK/UY4R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMRkM2z9Bahm+Obnmbc4RLsnEqryupwRNmu7I4jTNUMzYRBIB
	CCf4R9bEd6uVpeGae4scZguN1fQ/ZHUqk+mVrXBDIHlY1sk9GRbQxG2Kd9WnD7zfEdsgdL7D5Zc
	N/G+H22n5dxWoFOYrXxB1jA+QEcFeU7M=
X-Received: by 2002:a05:6512:23a9:b0:5b0:ce5:a063 with SMTP id
 2adb3069b0e04-5b459188066mr1101451e87.42.1786737994716; Fri, 14 Aug 2026
 13:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:06:22 +0200
X-Gmail-Original-Message-ID: <CAD++jLm2vzq1t8c9664xKA+vPK69syMsnU-dyMEKnL6wbNhOcg@mail.gmail.com>
X-Gm-Features: AcwNN1Xj1Orrn3dsVyyoZswTmpjVuq_pyxwrJ_A4bvW94rRHITkMVbt7PIMfgB4
Message-ID: <CAD++jLm2vzq1t8c9664xKA+vPK69syMsnU-dyMEKnL6wbNhOcg@mail.gmail.com>
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use gpiod_set_value_cansleep
 for reset GPIO
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, stable@vger.kernel.org, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 1:01=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
>
>   WARNING: drivers/gpio/gpiolib.c:4030 at gpiod_set_value+0x44/0x80, CPU#=
1: kworker/u16:4/61
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
> Switch both helpers to gpiod_set_value_cansleep() so such a reset GPIO ca=
n
> be used without triggering the warning.
>
> The reset GPIO has been driven with the non-sleeping gpiod_set_value()
> since the driver was added in v4.19.  The call has since been refactored
> across several files - from realtek-smi.c / realtek-mdio.c into the commo=
n
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

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
