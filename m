Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870679;
	b=y3jtU26RBzXn5+pf+ko4kOkHDrMLGyV7LkxNbUvHLwE8rLtsHNSVuLsh2jd61dQixpda
	 +el/Sg2SimkKTGDCORDZLi90eWcFxCDQc+nU8A+4FwwxWBT0VRAAwE4xnbFrn0qZBkLO6
	 VfuE10LHwJ7BxEzJhNn05Hi2iBcP7YcuBKeMw0zzEEivZ9xkDv3XElO5ksXog01vVhzNJ
	 l2QpeQ4VOmITb2FKDcMe4o6wvJdFxO4ZC5ekSvZBauwusZKLiueP/aksCfItcYFseWdnc
	 049EQstUme9WSSJ7Kt/Zq+MKBDav2aOTpRlf216jmJQIR8mb0jwkcuknM7HFOIqZ3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870679;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tTqFMC2jfQkWpp4eCpCGIoJ+qOTGr5oTYuPt6Wn0ReQ=;
	b=du6DjvrLwmsEKuElL99BFpsjHP6sFhtMz0VvQqOaqiZe1tYZ8JeZbgKxZRaTNa4xY3sB
	 Kgv90hqGmjSW1WY5AOMyVrYEPGjrIMQvP/H2p08GCS5foPvNT1KCp6dt3XP6F0j2WuJDF
	 QwLq0PFxnEn2yZ/95IKLmgEQdQJOqhmgVUR8sssUf6dCcuGMWuWTAYuoFtwBXZnI5OKWK
	 o5yQdcyg6U11j8CxZWFI9AVf9zShZILgLexce4rOzo+yVAhwCBPn0+VtzbnIFWw//PoRN
	 fSRPLSMeXP/4QqT81QWjCTtbylx8/7lwKLhjPP5Irjfw675htm+/o4fYBLX8bv8uSWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkakNWVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C523606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkakNWVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB271F00A1D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870678;
	bh=tTqFMC2jfQkWpp4eCpCGIoJ+qOTGr5oTYuPt6Wn0ReQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NkakNWVrpeJsHpQJZkDxNGNiBhdjE5CTeu0BAedaN9KKhqePQp6RTOZf4Bek5pCVN
	 bVJwEl6wMnv6pqrJVQ4so2nmQ+AnR2RQnxHTv92qHB+7P/ijwgoJyNXhi+YMHvtPVF
	 H/IPvS22QXuSFDaizD8YzQCYn3REuSABlBf6sklJqw4ZbDNLbkzKhkjHG/2iaoZ5wd
	 LWRdvXjuk24Zl30+q8nxvnaty1AX5vsSfYRlAXL3bG5h71c9Jvcb6k3aMcV5nqYuL/
	 q2iZfTm+9naaoTCsOhcA08yYYVPZJ4sqyp9qqb1aEdubjBKDlGqdPBNRRoWPJMmhBw
	 ZV5HMsbtriN6w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so1739251e87.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 01:24:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy/krDULWrOcKcPIXwtMvU92LL9VIoBTIJTwrXArqRkLMbHweOc6SnHe3mmB7eLn/5bcsJJGaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rrP6F2tMKo0+IJvws206t2Ev/BMIt8d3LfrUIchH9/RmCJcKw
	ZippN7VsRH9yv4cq41GHaj3QkzSpsO0rxLVGkaY9ILZJ6V5SirvazIDo8EML98ASbx9/qRIUAAk
	g9F6LDEn1bHRPs1d8VNohjVgobTAr/4c=
X-Received: by 2002:a05:6512:3f17:b0:5bf:d1c4:a01d with SMTP id
 2adb3069b0e04-5bfd95206b9mr6296528e87.2.1793870677493; Thu, 05 Nov 2026
 01:24:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103213002.1673560-1-lee@kernel.org> <20261103213002.1673560-7-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-7-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:24:24 +0100
X-Gmail-Original-Message-ID: <CAD++jLn0vx9bv7ZUvcPX+Q_E4o+zb-rtfEmsZgw00gMGTVY3Zw@mail.gmail.com>
X-Gm-Features: AclHuK8yYE1rSjLkW5nBivqJEc5ZKlRnSUlmLXkEBc7bHuzlAPbz8NNmplKC7xw
Message-ID: <CAD++jLn0vx9bv7ZUvcPX+Q_E4o+zb-rtfEmsZgw00gMGTVY3Zw@mail.gmail.com>
Subject: Re: [PATCH 06/10] pinctrl: realtek: Fix bit shift when configuring RTD_HIGH_VIL
To: Lee Jones <lee@kernel.org>
Cc: James Tai <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.com>, 
	Tzuyi Chang <tychang@realtek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-realtek-soc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:30=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> In rtd_pconf_parse_conf(), the RTD_HIGH_VIL case prepares mask as
> BIT(hvil_off) for regmap_update_bits(), but sets val =3D 1 without
> shifting it to hvil_off.  Whenever hvil_off is non-zero,
> regmap_update_bits() masks val with BIT(hvil_off) and clears the high
> VIL bit instead of setting it.
>
> Set val to BIT(hvil_off) so that the target bit is set as intended.
>
> Fixes: dcc9334435b0 ("pinctrl: realtek: add support for slew rate, input =
voltage and high VIL")
> Closes: https://sashiko.dev/#/bug/linux-e7077311-3f30-4b77-844b-1447519d0=
c84
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

This patch 6/10 applied for fixes!

Yours,
Linus Walleij
