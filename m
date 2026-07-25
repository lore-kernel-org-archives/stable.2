Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D239C62F
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784971334; cv=none; b=tlHc8rvUPs3UIpmAlysjcL/kpFGoBGpTPhOiQ6wzB30dpYprLR/T+8H4gUegZ8NWFw94oFPAJ8Q3HIFaXCMmqPQrZiAqBwbDwErJPXq/s5uzpdsModetr/y6YOnse/UN1R7mt8JIlo50yo8i5tjuscEwYWff69brAOiagHj0QKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784971334; c=relaxed/simple;
	bh=RPDFRdWxVIW9S40pzEN5XZuqdsGYTf0D2/HjPnJLjSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smzO5WRTlCHtxh/p7nz3OBcf+0uLLhT99sGE3owBU+4RoW8xPxhFzA+6z5TvZrU4bMTRQ/KFWKIE8SEpxRm5xuffvW3ABryRMyt2/QkBV9dOAnklRLHosfekWgC/7jDhWLRBEofJo8DiO7rn1EUWpB/y1qc0A3ZbQorz9xH9KZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evfVgZ+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evfVgZ+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E11F00ACF
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784971332;
	bh=yeffZJ5O7jKGs/TLFEJVw8uSr4ijtSiArzHMzMUH3yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=evfVgZ+NvqPhkm2zem17DUpcWqWTEJbj0XeW6AMsN8v/mE9jnDRne8gb+1WYKr/Hr
	 57a/YGXe9CuB9WdTAkN1WDuE+CghA6EV1yKa+Yz4IScB3QvqnKh9tgpdhmUzx/0bQU
	 938lV+nLrTaEm7uTpZNikS+TvPjIVK9UMuY1QouI8tHC3a0gUvO6Nzgfery7VOVWkl
	 ANZOb4jt7h5xHts6Tcniyuu5JZCQQN1aMhg/fhuhv1nr56pkPKbBNRObL9BQAb1UdU
	 y6zNtKzR2qjru7XO8jpoQqEd6fXqLf7/keOGdlrtw4Jmw9mfCe37S0CeDUrXoS1IEa
	 knrobmKtS1kDw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1426539e87.3
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:22:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp5I/eKyhqWMRlYJr8+jU4U3Y1MgsUlgdFArUkjXpn8tsqtwKly3YQH/OupxOGLsmk+Gtegmuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoPOMpxFD9X6ot5rtoIV7m0O9emKItS4tvQXYceuMO6ZYjrHl
	qXIC7RvWCjPZwcv8nTmfzVMvOPn5jrWgspbpeYbiSpLkD4jJmBSQEHkTGDu3DsRWT2ckyv9FUI+
	9XHpPPaDmbBnTrnAzvO7IKyRdgI6aepQ=
X-Received: by 2002:a05:6512:15a1:b0:5ae:b2b0:4c15 with SMTP id
 2adb3069b0e04-5b2c1b20907mr265837e87.11.1784971330951; Sat, 25 Jul 2026
 02:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719094427.1328725-1-bennib@mailbox.org>
In-Reply-To: <20260719094427.1328725-1-bennib@mailbox.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 11:21:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLm8cqC2Y6nJLy4KULSbq8+p=+eTDH9Kz2dDSpfZH0Eb0w@mail.gmail.com>
X-Gm-Features: AUfX_mz1K-DO6jIR7qrurrfXV_-LnGCnet5e8Rx3EcWtnOYCGFlm6uPvx3txgt8
Message-ID: <CAD++jLm8cqC2Y6nJLy4KULSbq8+p=+eTDH9Kz2dDSpfZH0Eb0w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
To: Benjamin Boortz <bennib@mailbox.org>
Cc: andy.shevchenko@gmail.com, lee@kernel.org, vladimir.oltean@nxp.com, 
	colin.foster@in-advantage.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 11:45=E2=80=AFAM Benjamin Boortz <bennib@mailbox.or=
g> wrote:

> The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
> which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
> The Kconfig entry does not select REGMAP_MMIO, causing a build failure
> when no other driver in the config happens to pull in REGMAP_MMIO:
>
>   include/linux/mfd/ocelot.h:34:24: error: implicit declaration of functi=
on 'devm_regmap_init_mmio'
>
> Found by randconfig testing on arm64; tinyconfig reproducer below.
>
> Fixes: 2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Boortz <bennib@mailbox.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Patch applied for fixes.

Yours,
Linus Walleij
