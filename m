Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868591;
	b=Vd/kinwTVwOTJyeV9yKrVc0W47A1wl28jjlm4DiRCaS4i20sph971OG553pRFuK6+oWF
	 MJufwHSI3jZo5F8Ncy5At6/Y1a7LHJggcfJbckj2YlWBcy3/RGf14OhLVt/kBlrLU96+y
	 Rr5Xy5CFziqzGdtp3KVR7TVcm/lbBOQSYyPqKRmWvbiwV2aj//9BywXT+1ns3sCGSIipK
	 0VzFjDw3F3mwAMjW1UIv6FMkawRhs8SCPN6iX/EcVv/KJ0XDholHSspWBntpymh/zrMoz
	 ZzXn8I12tlUeqcx8bJUYQnUNdpLWUUW6bdIhTgkC7QYNzUEuYtxkAdAMJ/aphJgBa7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868591;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iXIfKUGJGkEnqn9QRpsp+DcwEv6yTAPnOh0Ju3Orv/4=;
	b=VgBKB6xdDOx4wDPB7VqUCuxoK/0vvQuiOkskKA5O3sf8ihNThbB+dvWPP70d32f7ARcK
	 E4JHaa1Qwl4LmeGyk/SvrCWNfaLxRcaMQU17E4rhhL/pwhwI2JsX3oXkxOLtn/v9DS6Tp
	 n1Su0pYOoEIVj2r6wyAODiWbebtrxLgRqVjv1nw5o2PSl1Y6Z4SM6GZXrUh6GA6slVeqS
	 2VBfkHEKEzSrzVbwb35lspHTAMAbTHmIGEIAFMY9/Q7xrrEDWOtlxsNwD/wV91wh0i5mL
	 deXM8uMinfWkhBKJJ1QlVzORb6JvEU1hCu1Tl/FD16NoB2RSkmwnXNwIfwt36PXvs9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReL2UJWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A8606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReL2UJWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AC71F00A15
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868591;
	bh=iXIfKUGJGkEnqn9QRpsp+DcwEv6yTAPnOh0Ju3Orv/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ReL2UJWmNZ5TxcrGIpbnhGyNp15nEgfXjZNsOeS5W6sHxs5USw7+ZVbdKsZy09F1z
	 pRSB/TuMSFPtsXMNDG1SsTLvPYkJZ0TsGP4FO5x1zVQgyB2mNOZu7nHyRKg0r2l9TI
	 tWfYU/iKpxdFgbSDSfiBjvDXCoGYUKXe3cLUsYxx61v/U6cVmrY6/2l4dA2FZIfWZA
	 0sjsdkJ/VvgkEU84ZRXCtJkq2gbT7exadCn5Pv9/lT9A3S8Hxv+7GKSMPeOLtyqz+z
	 uJWk4bJnyJP7sadqT0trgPRv3UduGH/blDEYxmEGmQwQ9nqXW/rBCNws/cuGIrKTyi
	 7URlnRPbQGTVQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso1283321e87.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzbKnMsB6S3QBMOIijGKMQvVmEHRdcw8h/t4BYMNl/SeKRHyaSgXhXVuWnL9I5fdjMAqiFiaHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zLeNyBqT+v1nRt+STqUmZta56daAboW+J8zRZzBxEZeaDgeq3
	RNVftNCjUzPKgjnv3Yk8RSe0UVwRsHKuBCmc1v4GWvHDmRVjKbHbDzkJuusmO1+YFYrS7c7HxaV
	cuBO/cwgFxemVTcySe5WHxaEtDOzNeAA=
X-Received: by 2002:a05:6512:688b:20b0:5bf:e4e6:7f78 with SMTP id
 2adb3069b0e04-5bfe4e68c03mr2745563e87.39.1793868590127; Thu, 05 Nov 2026
 00:49:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103104242.1373883-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103104242.1373883-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:49:38 +0100
X-Gmail-Original-Message-ID: <CAD++jL=YuYS85WFBv-dHJLqMW1VMgoTo3YSnDU8Yqg1Tp3Vd=g@mail.gmail.com>
X-Gm-Features: AclHuK-DqpeWMThWze48WguFPTy5w3muiNn0JsxnoY0aN27dGfjAgVQWa0g9Prk
Message-ID: <CAD++jL=YuYS85WFBv-dHJLqMW1VMgoTo3YSnDU8Yqg1Tp3Vd=g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm: release the NS2 pinmux controller on detach
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wentao,

On Tue, Nov 3, 2026 at 11:42=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> ns2_pinmux_probe() registers the pin controller with pinctrl_register()
> and stores the returned pinctrl_dev in the driver data, but the driver
> has no remove callback and never calls pinctrl_unregister().  The
> controller is therefore never unregistered and its memory is leaked
> when the platform device is unbound.
>
> Use devm_pinctrl_register() instead so that the controller is released
> automatically when the device is detached.
>
> Fixes: b5aa1006e4a9 ("pinctrl: ns2: add pinmux driver support for Broadco=
m NS2 SoC")
> Cc: stable@vger.kernel.org

??????

What is regressing due to this?

Don't add stable-tags like you add sugar to cereals.

Yours,
Linus Walleij
