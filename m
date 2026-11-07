Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091728;
	b=TrNfof/O4id4/CrC2C5n9+NdBHcSzZ7H8lSLCQOH2mxQmvfyIxYFqTsHa0p4LiBvbr5H
	 duiFH3k6JEFdmh9AYqut4LIUELnxYy1LQ3BxghGEvn8Xv5jsgJgaUKn8Ka3X7TdK1jHAZ
	 MEa4qYmmdEcQ9sOkU4uHFvToW1grm5ihIFgrkKKY7sd6EOdeGPWN+JjDIH7ckeZPaJTg0
	 WMy5uTvMCykUmJWnzU4FMql2MF2P5kNstIvyYWfEkfXzPC5Uf+AhRQgiFkF1eVQcXuBU1
	 s9RaxpelWhl6V2Z5mkFuSy4dW1/6Qc1JLuuQ1HCIjqL5ZvbhsPMSh2jIQN1Xn3b8l7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091728;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QuLhFEvmmpbdFe5TBed4DD8fUH5b/6o6JMrvceQqWs0=;
	b=tDnTAI5kcAoRj7AsWbuNmRXumLl6tkIxUi+Wq5zK6ACjmzUD/kpFFGn5k2qghQ9jYvNV
	 +Ehbo6eC8jYsWxDjfdSHFNtZSHODOLvTOOcYyUVZWZKVf1yezofPzbkW+skpceLTqsFjs
	 CM4A5BkzbgCjHXA97oe0X3TOqFtx3LU/eRPWH8RLxlqn00/w5rUdjFfmT2gPDzSYKIAZj
	 yhHo4lXaOfD80aNvdI2Jmjb2Cy5960M1PcSxJYHMfe7tfsUbH9mttYSNQLIU0qJfHO040
	 SrMKFfHZAmiCau4jhLY3hPXzqcoDrmacW2UeyTTGQ6aoSL2FyLeTbqcK4D56eBQvcFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHJdESOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHJdESOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680971F008A2
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091727;
	bh=QuLhFEvmmpbdFe5TBed4DD8fUH5b/6o6JMrvceQqWs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iHJdESOfGkXUhxi+nej8FX8ZZVq7o3gGEAX9jKFPXoGubpeHyJqqMooG0NG+yeqO0
	 KJTkGkUDnh3MrkPRD2JWUAzHOz6hLip8FKVeA/SxiDtn6RLkYs9mFYygIOSJQWEJDv
	 ahKpcMy92jx8GhxTuoKVy0vsyHToqnZoDkCBYoXyowaJ9KNJfFscbClVLq9SNadxzz
	 YISPSKjQdhbC5c525MeY8zTRB1PHxQiUpIOGtvVPJ7cB2crSiFYXuHnI71acuPTeh6
	 IeC7IVxDxBf1iiMtnvibfpH3azhzoUvB65/uTkfKAa3CA4znN/rvHDaFAo5J3wzOfJ
	 qn7yCHXQ2zCWA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3acd304b5fbso366761fa.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:48:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHtbosr3PL3R96hieixlwl8a6whKj3rqCfaUxsu/1s83+/Wo0MsdZ46MGgHajBwm6wb+aVljWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/95KIk3F+q/GGKJY5KmKVxnpJfrHYFuJONLiloH6kPYwHWNo1F
	SWSV9kTMdOXQtmUtAgOdPHgsCKHOeLx65mFqcHTyIF25g41Ogp4DA2MsiRo1Uz5k6M4cEhgxvRz
	U04XCsr7oQxmiA2atv553rIL4QRHJGFY=
X-Received: by 2002:a05:6512:1048:b0:5bf:cabe:23b6 with SMTP id
 2adb3069b0e04-5c003a9c26emr1737966e87.33.1794091726181; Sat, 07 Nov 2026
 14:48:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
In-Reply-To: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 7 Nov 2026 23:48:34 +0100
X-Gmail-Original-Message-ID: <CAD++jL=xWDA=JsD+JmX+1i6fs3dRXztUk13mcTvKcnO9Lq7tqg@mail.gmail.com>
X-Gm-Features: AclHuK-twRwCMVL7cQuNhWiRM9_Y2ubKODxjVoSRNRTWzU9h1XAiKR4cV_MVtR8
Message-ID: <CAD++jL=xWDA=JsD+JmX+1i6fs3dRXztUk13mcTvKcnO9Lq7tqg@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: fix potential misconfiguration of hogged lines
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:37=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> In of_gpiochip_get_lflags() the local variable xlate_flags is declared
> without being initialized before its address is passed to
> of_xlate_and_get_gpiod_flags() when processing a devicetree gpio-hog
> child node. If a driver uses an of_xlate() callback that doesn't update
> the flags argument (like gpiochip_fwd_delay_of_xlate()) we'll end up
> passing that uninitialized value to of_convert_gpio_flags(), potentially
> misconfiguring the hogged GPIO.
>
> Initialize xlate_flags to 0.
>
> Cc: stable@vger.kernel.org
> Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
> Closes: https://sashiko.dev/#/bug/linux-2bb44847-fd6e-406c-878d-9739da2cb=
8b5
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Right! Good catch from Sashiko there.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
