Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39800181334
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784972055; cv=none; b=NyfVHtKwRW6co/NyW063UhymEFUMPcbkrPMq/4z5bmkl1CF9xl7/qqVqYFb652tGOTV23/OdFHQkD4RGMfKbLQhMjy9GNjYNGYbbF7IcOPVcTHoKtiWqoYGbAJ3Xi8uNeVMrTh9BBy2M05Z3aaPWw5vx7nxQXLhh2irZz87YCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784972055; c=relaxed/simple;
	bh=ITZjcQRn95u6VCpDPPTnBvVga4zbrsqIoFwfm2Q546Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLZ31M2jXUirqt3d5TaMTqcBVAbWttVF9l2Hn+bK1aosm8b2I0oHq5WAKcgMf1I7Inwbl930VP1Kle7EbpmeuVu8829o1d2H52bNaphmOTctNqTCnkKEhw+Zu8JFPjUdkWgvPz09gLscMbDqXtsp8FtswUFrdXLkRruie4xaZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrg/NXqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrg/NXqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B671F000E9
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784972052;
	bh=7UupwUNjMRAke2Z1V/NRbotbWdSBA0PD7YbseISQQtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Yrg/NXqpIw0L3adbgN8AMPtnM4ZSfqEBQNvJ9xCe2xQRK2wXt8k2IS3EXoAjmTMFC
	 dEBL9zJpKY74ZjSPR2I1hRin80mEqx6TRL8FXBT7CyJxrgnfza5i8ePLmbzDhzTEJp
	 aazcqYG4IvPiraQT0g/mE1GBhVo7viiR+ygt5oo4LbRGtNn8OdCwJEEXiDwDsk2sSR
	 DAZM4etNk0wufu9sgRffUGRVrlKOwV4U+JKiHF/RHqJo270socE9YKCz+7s7CmoQNH
	 owRR4ENeHqcTYr0v8Y1JCJQu6umHY3STTXzwRTz0Ms6W4JUj4EoladLjLtOUWm8we4
	 Lx+tzGi9pf++Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1240699e87.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpfXOLdp5p+STzLh0mOXQK4gchcsASbcWpRfW1zryLSi+nqvieaqXrglHpTnbpzwR9DDhSLAuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgU+ZaOkwII04cSuFdgJEcStW4USIQ3LzuM0Ww5YN8MZbX4qwZ
	pHfu1MlA4i1nNI5Ww7EDUnFMclz9XDeJdjKc362/AU2PNJJIwXI778hNxZ24MDfOKeBM/+C/+UF
	ajjaYsmDr32nkfojd8cnzprXDH4M1npo=
X-Received: by 2002:a05:6512:1148:b0:5b0:d0d:1f10 with SMTP id
 2adb3069b0e04-5b2c1b089e3mr215924e87.27.1784972051572; Sat, 25 Jul 2026
 02:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720175611.2294418-1-bennib@mailbox.org>
In-Reply-To: <20260720175611.2294418-1-bennib@mailbox.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 11:33:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLmVvYFYF9dA5060oQEfeejvKukw3B5H0TkJ=A_qnnugZg@mail.gmail.com>
X-Gm-Features: AUfX_mxXVXUm_Y2opU4d2ZTx2uh9TD7qPFdqWuTUDuky-yGOj5GObdCvk5boT6I
Message-ID: <CAD++jLmVvYFYF9dA5060oQEfeejvKukw3B5H0TkJ=A_qnnugZg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bm1880: add missing select GENERIC_PINCONF
To: Benjamin Boortz <bennib@mailbox.org>
Cc: linux-gpio@vger.kernel.org, mani@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 7:57=E2=80=AFPM Benjamin Boortz <bennib@mailbox.org=
> wrote:

> drivers/pinctrl/pinctrl-bm1880.c initialises its pinconf_ops with
> .is_generic =3D true, but that field is only present when
> CONFIG_GENERIC_PINCONF is enabled (guarded by #ifdef in pinconf.h).
> The Kconfig entry for PINCTRL_BM1880 never selects GENERIC_PINCONF,
> so any config that enables CONFIG_PINCTRL_BM1880=3Dy without
> CONFIG_GENERIC_PINCONF=3Dy fails to compile:
>
>   drivers/pinctrl/pinctrl-bm1880.c:1288:10: error: 'const struct pinconf_=
ops' has no member named 'is_generic'
>
> Found by randconfig testing on arm64; tinyconfig reproducer below.
> Add the missing select to fix the build.
>
> Fixes: 49bd61ebce5f ("pinctrl: Add pinconf support for BM1880 SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Boortz <bennib@mailbox.org>

Patch applied for fixes!

Yours,
Linus Walleij
