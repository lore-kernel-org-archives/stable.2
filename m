Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650648;
	b=pPCHPt/0Yt5dD5mTYXzge8dyolfVMLrpkfGL5p0OGza0MD3oen25x2QJoi9OviyzH1Lg
	 2sehrAs/nFgFDbOpTLzEkonp6eXy3ofAzXUh1u47ZQ1QFHaGBRpHbGayQdrPyKUXk+X6M
	 mVAF1dLnE8IQqnH8fyZ2dvntijwUV93Q/jRAIyqhDZZ5aAWcjUAGDalbmOP2/eF0sabt3
	 oSfN+KlSHgBwmqPJVGgJnWc9KkWisFqrNZ2cpDN7Bdf+c9zWGshv9odS6nTa8Rn0XUJqF
	 3+cItU94uUYsZR+dnSMFHtIFJANGSFH3nwJ3LDaPpeFaAFA+jurL58cLCnEsdsUYeQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650648;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SSF3HNmX8IQuqM+s3AUAPIx5aRv7nDlvb0TBcLvwRJk=;
	b=uDhUONWuEwM49E4iWsGfP9n0Ot5WTGYGksFjFisFbpQnuYrbWEOpIIlKVISuMU3eABo3
	 GKFq22IhLYuh0Yep2d5EJBWXikLEyZfTzw9boqrojVlQeY09XqdYeXib2DoDE/LVoK9sh
	 vL3nXZrwOJI5txUvbQW5DV8RQ9GvBTFf7u9Jb9icBFNYogIak2ytIPdGTvZAA0M6OFbCo
	 q3B4EHy29IWG58W327X8l7jvkOLMMsZNHJTDViyygdzYp3rPPjnC+tAZgbYp60ByshX3B
	 tBZC2IR7qfA2Bdi9o0z8VKp2IGBtDksh9TvXPFFTDtAUsnEUSMCFJXVd47cMUTs7Qaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz54QzvU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F9606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz54QzvU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656921F000D1
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795650648;
	bh=SSF3HNmX8IQuqM+s3AUAPIx5aRv7nDlvb0TBcLvwRJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gz54QzvU7z1D4kq1AqjGdSDn7QGNa4uhzG96yBRN9vj8aaAF3zpm94Fi1ZvwC49A5
	 zzPYAkG1zHH22bp4pQhgc/SNYvoLiMXBDMS6zUUd8A1zX219lDwgYHuynslXhl8cbl
	 UBnr2OgMGPGu1NJynj2I3rHIIqHSEWyloFhkEs5BnB+dhycNp3vltB1qca+bJP5xUM
	 WsX56fY4hISZWxx+9TyMhltFdSgo94PobsGFJDJXYsWfEUYvuevn8VuTpWbujtNeS4
	 nrAa4P3X3wNe/bj6CvwgbVG6GUc8aTKLtyh+hyRvyIRQFeJPAJrVKk/hQM8DbEy/Az
	 dBm2q5HLjjIGQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c1c0c8d61aso4309095e87.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:50:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHrPOFMqeLo4IsIG7JXcne/DxBiyc3ezKE6zDzfkv9juaqhGlOxLVu7Pv67cFKygT02cc9d4Kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XUKfdrCrqpCB5vbGbom29Z43LSl6BaXpBY2+xv8rq9BC/39OU
	+Avxjg1cRe6KctTlu11d+3NswADLvEUcli5Giv+xCu4xyPYcLZmqliNpufRO6c6pO3St2wIGltc
	6gU+AZaEXLtUMcTfaTkWSU9dFm6s2TE0=
X-Received: by 2002:a05:6512:2301:b0:5bf:d000:bca3 with SMTP id
 2adb3069b0e04-5c1bc80af80mr4947135e87.49.1795650647170; Wed, 25 Nov 2026
 15:50:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
In-Reply-To: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 00:50:34 +0100
X-Gmail-Original-Message-ID: <CAD++jLkLZZjazqrTNhrX5b08o8CCEd-aJApCChg1CA9+4_hBDQ@mail.gmail.com>
X-Gm-Features: Aa3M54o5djYLxkPCzUBBr6bgl1plvSzRd2_k-TGNDmu2r6ajYBxpvQV8WpW-0fA
Message-ID: <CAD++jLkLZZjazqrTNhrX5b08o8CCEd-aJApCChg1CA9+4_hBDQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use the of_xlate() result when hogging lines
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Norman Herms <dockseed@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 4:03=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Since commit d1d564ec4992 ("gpio: move hogs into GPIO core"),
> gpiochip_add_hog() takes the hogged line from the first cell of the
> "gpios" property. The of_xlate() callback is still called for OF nodes
> but only to get the flags so on controllers that compute the offset in
> of_xlate() (sunxi, Qualcomm PMIC GPIOs, tegra186, ...) the wrong line is
> hogged.
>
> Use the descriptor returned by of_xlate() for OF nodes.
>
> Cc: stable@vger.kernel.org
> Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
> Reported-by: Norman Herms <dockseed@proton.me>
> Closes: https://lore.kernel.org/all/qh4LV99kGaQYdQuGbsPX4b9Fm6Cip_Ow7ImY4=
icfwI8IsbMQy_09FovZY82b-_HVkDmR2ELMlKe8bzCuBB5NpaZizoO-s4tc11zAX30FDhw=3D@p=
roton.me/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Looks right!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
