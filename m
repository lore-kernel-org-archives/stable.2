Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870543;
	b=UGCaXy25XslYiSf1Otlk3rkcK/es/WbbldsdhKhZAwW6nbLNWq8geFWQyxd5p93EnSlu
	 dG8sksrX4/sDJJgww0ebrKpEPUH+vimg6rsbb9yu7jty1P6yaYxRXDEfiClKOj5i6D4NG
	 m918CkYRmnapqxKq+X+ITSMVYQpb1iMXCLuDqIOvbfZ0GvXqlvsNLAfFKU0OFjWlE0dD1
	 kic2Xro/3C/nQUP2557FEcNE+GYVeOTm21HqbCuRN8pibpnMiR5YM8/4VeeKf6cNB1klH
	 vEx+jSy7HE3RH0cr5n/Q/VKhOpG74VD+zMzjtPfh9lV0yNQp86rwgb4pb8joA49ztgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870543;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=38nZMeNznVKeupiqH5IxVPd4xUnhI8fUvfCaQKWMg2A=;
	b=ZbQrMKGMUObLEt1254rU62cUdrp3bfoZDnwJ/yMmjyKBJBLp5UAnEjYSRSLIBMY5A5VH
	 SvnGW4JH3opz6lmV7RzrSlaCAfzrpWKxaNpFUr9+AtdZhdUHBaJGKiXshasam+kLiIecD
	 VhlwV39Ehl/XSxyw1ZmLdBD7RlLq2UrasWwm1hWX51elfqVB+N7S6tZuRqKZLYb0qHf/7
	 +U7I0P8tURWyP9DtSBlG8cNn9DZq0gof16ORFGMg+eb+B3zdm2RcYQ3ucOvROa7fRtMV8
	 oCyqvJ5yov/a+zHI+np24f1UqTo+9NGKH04/SrXVj3qOVXv6bYygxhQmYt57NTEmlUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6rcAFKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38A606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6rcAFKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DF31F00A16
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870542;
	bh=38nZMeNznVKeupiqH5IxVPd4xUnhI8fUvfCaQKWMg2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H6rcAFKo+4gqVyPOhTaEkldRgXH0ytPgPp3wFiSJavm8fKl7xBo2iNAPeIKCvjvUB
	 cvbq8/s4ee1bfehZxxSs4jCYqpIsRvRRtUhMyAZcqEANoHHC9/t299bmfA7vYPj5sG
	 xJXZZUkQ8C/JSBDTj1c12SeE8708LYkyctwZOFUEriY/G40pGeni2VhYrq2TK0KTgl
	 kTY2zoALYSnXskb3xcya7NaHInRQWoQsIg7glYviBojQbtR0hSRT2HmrGhpt7KGDDH
	 wH7P3RZfXZh7GRyrE2CyLJxxdetwEt6HlmHRAEdajeWUixKxzlbMQkZS39nwC9zbEd
	 FHUfFPLMF7cTg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so1451304e87.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 01:22:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxkVp8vS6P0lXKmvCoJxCGwww45K69sWLPSFrrV43If99EVw7Rkiav4sd7b3m1E+QqzlaTvKEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wyiWzMwMGXJ8Y7QScnkFCtuAVXaFSJxjKwKXZuzKwZ2iFTq0A
	WYLzx60p49PlCu0hhtcyewkUlR1ej3u+J6OojW8vUua5DUM/lun3NL7LHmjQGKV4UY2n6YJoni+
	xVLGc+dNnus2mxhVqjrjLvCjrqoKeT9w=
X-Received: by 2002:a05:6512:33d3:b0:5bf:b144:fd05 with SMTP id
 2adb3069b0e04-5bfd957ec46mr6771787e87.54.1793870541701; Thu, 05 Nov 2026
 01:22:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103213002.1673560-1-lee@kernel.org> <20261103213002.1673560-8-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-8-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:22:09 +0100
X-Gmail-Original-Message-ID: <CAD++jLmF0U6ehFSuauqKDQiZRkuUnqpbZd--v2aqF2YZQF=HwA@mail.gmail.com>
X-Gm-Features: AclHuK_usnBCJ7KUuM8edZVtpiEIeTbj7Pj1_drbEmXyfoNip4o1DLtzy4-1lMQ
Message-ID: <CAD++jLmF0U6ehFSuauqKDQiZRkuUnqpbZd--v2aqF2YZQF=HwA@mail.gmail.com>
Subject: Re: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
To: Lee Jones <lee@kernel.org>
Cc: James Tai <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.com>, 
	Tzuyi Chang <tychang@realtek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-realtek-soc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:31=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> The Realtek pinctrl driver uses NA (0xffffffff) as the sentinel for
> unsupported pin configuration features.  However, RTK_PIN_CONFIG omits
> input_volt_offset, slew_rate_offset, and hvil_offset, and
> RTK_PIN_CONFIG_V2 omits slew_rate_offset and hvil_offset.  Because C99
> designated initialisers zero-initialise omitted members, those fields
> default to 0 instead of NA, causing rtd_pconf_parse_conf() to treat
> unsupported features as valid at bit offset base_bit + 0 and corrupt
> adjacent register bits.
>
> Explicitly initialise the omitted offset fields to NA in RTK_PIN_CONFIG
> and RTK_PIN_CONFIG_V2.
>
> Fixes: dcc9334435b0 ("pinctrl: realtek: add support for slew rate, input =
voltage and high VIL")
> Fixes: e309dbd523b8 ("pinctrl: realtek: add rtd1625 pinctrl driver")
> Closes: https://sashiko.dev/#/bug/linux-fbd0bf54-6dba-4652-9418-270b11fb6=
d8b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

This patch 7/10 applied to the pinctrl tree for fixes.

Yours,
Linus Walleij
