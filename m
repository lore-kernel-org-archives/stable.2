Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886988;
	b=QmgWWphi+oWVPTv4pAEtBPSu7XyO1uTYd6kSetjqKvrKnatl5nMcqw5D3HXzud9/Etyt
	 fjyM2FfVhg70pyKYeOF5JJh7m+d1yPjoYL4Og86VVjZEZaU6fwMTjFp4Zh+Eazzdj2iw8
	 lqIft1Of32B33McM2/xWx3JCV9uTR0Dbdm52HspwF/co3OJd5jb7VI1darejoh0zuU8Bo
	 4s4NPRyX1oJqK+BHpn7qOYVZxa7WoGSy/n0RKfDTqWMD+jZfOFsGXmUZHZRlefPXXBpK9
	 nhnqKJ/tnizpqqwpViSKX4Z9JJYy8hV8rh2g7sxT94LIXkW7ObmlCwyAtpMVDrYfJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886988;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DgaNB918DvS/9e6kGL7HQ5e3QKA2xYrp9dfDsZ8DbFk=;
	b=LhiXP5AOiX0et3jcdASYq9KE7FkOO/BiaWZWk8X1F706Vlt890FzfSlBeL9D26cG9Hju
	 GceD2koz4WTyZK6ywzpOLGvLagxXLL0wx/elpALCT8mZRCisrIp3nlAFE+FDJybarfd2G
	 hzr8qyuJ5MHw2Uq2a7Kc/IVoLsBuVmABOx7kP9sUtNHUENjLfj0tMO3BFdiOtI8uiLjDE
	 nkX5N8TXSazbxunCX+/kOm5Dpmmcc1bNDDQH1XOU4vkAYe+iwetdcckbYQWIyFlpJspL4
	 HaF4LgzF96XbqU26n9SQncIZywpdUor5kMqJyyaOz95V0FJ87qiPLLqlAZVBueBUHMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwdO0XoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E70606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwdO0XoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564801F000C1
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886987;
	bh=DgaNB918DvS/9e6kGL7HQ5e3QKA2xYrp9dfDsZ8DbFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PwdO0XoI+xCqt9JcXnjbffFCF88c8/RWnV9n8+Sb6snUovYGGZ9rR6l6vuMQN4Wcq
	 5sUf5w8H/5y25/kIR3ABjhT1hu8CuB9VXtgs4RKQwJ7cBeNvtnUlbCp/OKlSvA94kI
	 +ujcDjZMuHcIEtc92k8W5JnUrzM7T2gDpB1Db7B6Iy51Cmqyef0PtVpi7GcsCeUCdB
	 dfhxJr/q6CCYUddat/EaQwOAoYMSnQnh2h2bQq4zMRqBc6O+Lt3PbcSJYFE5a7J+XN
	 ARISxm3Fwj+Q+EqG13Jgf3p4Kbk0Xh1edfbQsQDSklrWF23RM/osXQgDN17+GTmamf
	 wTuuT/yAGePmA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfc346401aso1423130e87.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:56:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwgzNDnA+8hJOMDGx5uLfghvNwBVxzQPCPbF3+x+3M9p2cMM7wEziKlXOT1QXoSxWqI6Sja8gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I9P7SvgDUcj6a5kW9FUR49cwNQfDs99bSnWTYlEvlTInjc9ik
	f7jYzV7X/RCA46UuTDqsc6ZN/XmIXfcDy/ryctm9AtGwpSVny2mYyi/nxL5ShcYi4HMSvfcERpH
	Te4Yd/pE4LSg4h2BcLtYFexnXOYEDaXs=
X-Received: by 2002:a05:6512:10cf:b0:5be:5394:162d with SMTP id
 2adb3069b0e04-5bfd954b775mr5824256e87.3.1793886986138; Thu, 05 Nov 2026
 05:56:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
In-Reply-To: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 14:56:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLk1_uAS4spZLg0pJuxd6KxQdLkXpxFe-DeUy4E-5sHp6Q@mail.gmail.com>
X-Gm-Features: AclHuK_gydN3uFHqfkkpDZEjIzl9q_s993fpDvscnpCYeIU9fTXTp3QVFVyy_To
Message-ID: <CAD++jLk1_uAS4spZLg0pJuxd6KxQdLkXpxFe-DeUy4E-5sHp6Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: sodaville: fix use-after-free bug when registering
 the irqchip
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:14=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> In sdv_register_irqsupport(), if irq_domain_create_legacy() fails during
> device probing, a generic IRQ chip is left registered in the global gc_li=
st
> while its underlying memory is freed, leading to a use-after-free. Use
> the managed variant of irq_setup_generic_chip() to ensure that the chip
> gets unregistered before the memory it uses is freed.
>
> Cc: stable@vger.kernel.org
> Fixes: 9381fc5d655d ("gpio: sodaville: Convert to use managed functions p=
cim_* and devm_*")
> Closes: https://sashiko.dev/#/bug/linux-2f7ac8b6-5034-4ff1-9afa-5700ff44e=
3e9
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
