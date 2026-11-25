Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629370;
	b=RUmR9V2csYYhyBwLKlkiJxStzhcCRptmNr+BQ8Ho0WVq3d3TFF1iBYRice1XzszbebY4
	 6mCIOJhccP8ua9FnHZivYcCALkOjnulyEe5PFy6JQSWv6MATNbFR8fdmSQV+XV2lKIq6M
	 K6GDSPWO0nUqmkggHB4STZDzJSmc3UqUm5jaFpgx6QINGruovYMdh94rydccbcKp7mZlL
	 uyO1vEc0b8x2185PiuT+nArQ5KReA0GNot44WTS3PqKFAOu4bttSEAhWDhXc3sr54Yggi
	 qwWOMMue47jK32anGVEYDPwgSdnwXTwg+B23VLvn26tW+TJoYS/Nb9f/sD/eioIdQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629370;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f6MAiA1tU1RJJu+ItJqpHXoF/3Y5pGSsfxpH8J2NIlI=;
	b=ncWCIHsY46vEoFtbF3Y45iCEYl5xtPNAN4LMQR6D/ox9rsCLjiRj+6l9V5Hrnjzlt3QH
	 Sr4VMOncyGfM162y8XdwZV/b8gGzCDb31nK17U+3tDK4uZue+fG4YY0qTconf//v07NGq
	 09O/oCLwT4r0MGkL/Bwzkk+lycWJotKYC7DJUQ6OBp6kYVPPIYv1jH1Bd3YOacQkru6bk
	 ALPX+VHFcDLP0h++EkFkJtT+GDPEV6A16TVUp62nsVclAW+noyHrhbAqu+MgTCcnVFyxo
	 sJkAF2WIGRvHahSzwKztKAgQxPrmtGXn5NTxvbX7B0z4JKBqdDPoN36R4vFYJ1LK2vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdVePdR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E4606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdVePdR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8861F000E0
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629370;
	bh=f6MAiA1tU1RJJu+ItJqpHXoF/3Y5pGSsfxpH8J2NIlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AdVePdR9Juw+mex6/WfIGFmOG5lH+g7wvLnxsLNNl63ExwWNN/+KTfBWylHaRkbK+
	 1JD/L16FcBtDMT6o0BriKvlzsyEw5zJeFjgk5t23j3y0SB0OppAyGYBQHQ0IQRo/tu
	 NkDnmuF4csUTaHNnYgmmBJPuBWaUi/G1h5PL0QSGBxvmzAdRvRFQS6iAkOBTq8SHkw
	 EqMApbbRhS6XTqy4qdLBP0mZGoYJXTrUU2XeOAhcGFDMabFO5m9hQUJvXYJYjqWbgd
	 V5ITRTnkVXjGl8sr3ddGqIY6TTxyZuuI4iBZOhL6+YL460J7VHA6ibn0sdhwIlVbaS
	 JK4ex0kRY89aA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae85add4dcso41531691fa.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGge/REEitknMr2NLK0oMHFO54BDIUJoW/Lp8gGOpNMe6adJZMiD7Sl7ho9xbgID43mPttvGY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lPb0yBg72+2gtjQ2NDXc+O8GoSoz8HlmMJobC1Wpm2kZ6zJov
	r+QB22APkxPgsn9R3jVFeCbNIXe2nG7bL9+99K3mmxtOLmQOK3d6B1U3nSZrUqsvWbNSAQmLCJE
	tYyPHJvupEvw5YJ2/eKtoR2fDNdEJxnk=
X-Received: by 2002:a05:6512:31cd:b0:5c0:b5c:4052 with SMTP id
 2adb3069b0e04-5c1bc6819c4mr5241312e87.2.1795629368690; Wed, 25 Nov 2026
 09:56:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-rk805-pinctrl-alias-v1-1-e0c6cdd5b823@iav.lv>
In-Reply-To: <20261111-rk805-pinctrl-alias-v1-1-e0c6cdd5b823@iav.lv>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 18:55:54 +0100
X-Gmail-Original-Message-ID: <CAD++jLn=+O55bh46owFdqb_TvQ+9KYfpLp6afsrO07v1JNd9Fw@mail.gmail.com>
X-Gm-Features: Aa3M54qcfqetMqqeazuNtJAXHuKFVrLAs7ZwHievoGEVbmIindCmaMEjBUdUnhw
Message-ID: <CAD++jLn=+O55bh46owFdqb_TvQ+9KYfpLp6afsrO07v1JNd9Fw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rk805: Add the platform module alias
To: iav@iav.lv
Cc: Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 3:05=E2=80=AFAM Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:

> From: Igor Velkov <iav@iav.lv>
>
> The rk8xx MFD core registers the pin controller of the RK805, RK806 and
> RK816 as a platform device named "rk805-pinctrl", but the driver has
> neither a MODULE_ALIAS nor a platform_device_id table. Built as a module
> it is never loaded on its own, and everything that uses the PMIC GPIOs
> waits for it: on the Pine64 ROCK64 the gpio-leds device with both
> LEDs stays in deferred probe.
>
> The other rk8xx cell drivers (rk805-pwrkey, rk808-regulator, rtc-rk808,
> clk-rk808) carry such an alias. Add one here as well.
>
> Fixes: ea479996c79b ("pinctrl: Add pinctrl driver for the RK805 PMIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on a Pine64 ROCK64 (RK805) with v7.3.4 and CONFIG_PINCTRL_RK805=3D=
m:
> without the alias the module is not loaded and both LEDs stay in
> deferred probe over three boots; with it the module loads at boot, both
> LEDs register and the deferred list is empty.

No reaction from the maintainers so patch applied!

Yours,
Linus Walleij
