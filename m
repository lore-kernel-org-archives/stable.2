Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631669;
	b=4dHx0qsZlvLyGbKUFjyy0Nz3rYZuE6OSZqJNmChgVmkac3IMxwj0B6TSAipDclTZcyu+
	 pidB+4yfQugz/LP7x65qoDoXD4tp5G1vxjEHCr2gz4vpmRI/8hLaXO0yPZliPnFBqbAyw
	 YsCF1eInO/c30RKi4UBdN2nSMUp7ZwVqQ5gXSU+Dcxe9u1gsnIu55PcVw0cPa5yFpY1vV
	 Itq7buBikV1Zg+I2Ts/xs1HyLPWGxFA5bzxM/RxwFwkX/B4svOlnvaCMx0MnX0slnjgE5
	 4cJiiYvHg+iOb8CJEStrJh+W+t2e7eAWI4xEkTD0k5JDM69YOi1ubMVdz+4hx218kuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631669;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=huzeBJvajrnFnGcmiNNvCrPUFe7LS9oLcis6HMj9a6w=;
	b=hyjGO+ok/lePLKek3s+zWVLXAVK5jegdQD6q9CJQgRm8ygzWGkifUDrg6MTt6Dz/qQbR
	 WqzHNit87e47iM39SQ08A8HzKXVtikTpuqTHzzQ0/jA8oM2aKGwbujvVoWQCobuErtUif
	 JbY6l4ZcXyo4SvY/pmEeNqHrE/5UiguVoj1QxS4z/BtT6UENbpYrydgrsQS9KonrsF1Xj
	 fHRNOcvbegLfkp4Tk1IbTNktzr55i0Q6/290u8wnFSJacqEwt1YW/zP8LJ7AKMXYvNnJi
	 NERdUg92UbZvMcuxiAn5v0posNL0PVhVhR54jbBKm8wadrC0Q2w891GXQXE+KKRIciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvV6eomv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF869606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvV6eomv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619AC1F000EF
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631669;
	bh=huzeBJvajrnFnGcmiNNvCrPUFe7LS9oLcis6HMj9a6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WvV6eomvshfBYaxVP2E8vJChWGUgUidWuiSAraGC7pphvYd8gXCkxMI4XRKG8I6nC
	 SoGSAF+WYK5TfdUjHraRd4177HXaJDE13ty/oPYNDruB4ogn7OXoxMoLf1Wy1f7x/j
	 x+x3S/QOlDNzQpWzsl1Z/KE2dLjdblYlEPTUjv4WdJLrGoXsJ1ftnX59q5xP7rs2/5
	 r1KP+qYwD4Dp6Vors0XSU9/uH2SRpU+Mr+mMd2kTRlf/3oQUmZ2hETFGmzC1XteJeX
	 X6eRM6gFQL+WHKJlXficHxuZ47FMdanDt2/0RM6V4wauUzlCOPEtg/NgQ/p0YWgbbl
	 rkGAgMzgjYNQw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so3847679e87.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFLYdECG2oCkKkSacd//cqLhnFj8tzkEZSYDn0DxItWn1w5l/8fqyC0BZEAW0BhBYCnT1jlbUA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pvJIMO6eLsFRVPNeydcH0kwUT9cm6QKej/wSEmrLE0EUFmHWB
	tJUT6KyqGzfE1UgaUe5EzE1TK6Iavc7KhZgZjR4IQPfhsd3CmDHqLA9ziogc+PzoxnvlwcfKKYg
	1O+4mbuNbpbSg9CvD+2ac3HkeYWGmim4=
X-Received: by 2002:a05:6512:3a89:b0:5bf:a467:32a6 with SMTP id
 2adb3069b0e04-5c1bc7fbf45mr5538912e87.39.1795631668071; Wed, 25 Nov 2026
 10:34:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119204748.2558209-1-lee@kernel.org> <20261119204748.2558209-3-lee@kernel.org>
In-Reply-To: <20261119204748.2558209-3-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:34:16 +0100
X-Gmail-Original-Message-ID: <CAD++jLmaHrHeApcosC5SXZtTvFCw9+R0of4z9Z1XF2c0R1=f7w@mail.gmail.com>
X-Gm-Features: Aa3M54rQei-ItW5tY_E33jyA6MyDsSvvBdzkAVwW1NF7MU63WgvrrqmNxIHY0gY
Message-ID: <CAD++jLmaHrHeApcosC5SXZtTvFCw9+R0of4z9Z1XF2c0R1=f7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] pinctrl: ingenic: Fix element type of
 x1600_sfc_funcs array
To: Lee Jones <lee@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Olivier Louvignes <olivier@mgcrea.io>, 
	Paul Boddie <paul@boddie.org.uk>, zhouyanjie@wanyeetech.com, 
	"H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, linux-mips@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:48=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> ingenic_pinmux_set_mux() treats grp->data as a u8 array of per-pin mux
> modes (u8 *pin_modes =3D grp->data), and every other *_funcs array in the
> Ingenic pinctrl driver is declared as u8[].  Because x1600_sfc_funcs[]
> was declared as int[], indexing pin_modes[0..6] reads the first seven
> bytes of the int array (0, 0, 0, 0, 0, 0, 0) instead of reading mode 2
> for the seventh pin.
>
> Change the element type of x1600_sfc_funcs[] from int to u8.
>
> Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
> Closes: https://sashiko.dev/#/bug/linux-5dccd0ae-9450-440a-87d0-44cc86d1a=
f45
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch applied!

Yours,
Linus Walleij
