Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917039A80E
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784971190; cv=none; b=pih1olyiZVm/D0fp/gQ5DP6NKO7pjGNRLHqh3DzMMOZUox8XbKK/Ccx6jGS3jvML1IEtJDGza4PwAYAXOup7lYaUfEm8VboP4hF8a2lWc7oX0COyCVb1LfR4/xX4HF7MvutkN1A5vmdzWqz7ebHNsZh+BJJqwec0ETHbCNFjU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784971190; c=relaxed/simple;
	bh=gT1CKO4EK7/3bWac08s2YQxQzdQzTQ0qmITNcMrkTwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+PxaPjV0fMITOXDEN/jeGsyiqLGHDG2rAErnJj5Q4pzJERAPMfXCTnV7JLeegv6OWVcOj4MfptuH9WTjkL03AKfg6kwUmcVOCbNPqV3T/MhePsdYQtHA4QXWC50sDa7M4MKcviGeEfWBusc/yDJj4qu1zXDLL0ru3rvAQb7OIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ppu9UWTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppu9UWTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBE51F00A3A
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784971189;
	bh=NGubqI94Ei6nqDONetK9C5AMVRp/MQujLv0n88M/a/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ppu9UWTawyDY8JAhaTiq+UNZ0TGAedPl05g6TLBTY7WY8L5xR+SDWQrSvBoOw0XrS
	 KEfWNQR3L//7JewG1tgKWS/a5t+QDi+EPRSSDZxjZd5ppz94CUWkoFvftK8YxMHpYP
	 l5heK7gazYYo+dalXjPktla9SNcBxN9sX9tjMQArsUH0c1jefbxHLCMTk2SKa6xVnr
	 u3OeZDgbp6vllOK74eivPIM8oKoGjBoUSV/V6u9Y1ry/ilGVnYuVovTsMMtsZVZ1IP
	 oqcoIM+rX47NO273j+cFD4ddKX0lDaycCsowCBW5JbL+OPzsUa5Aq6UebfizzVziL5
	 9wH85UcGx8fWw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39f00ce92d5so7311081fa.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:19:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrM+0jUL8lv5buDuCroQjk7x3ub3EfJh7oHq6DkfTR3pQ9GRx6t6nTN7EsAK+eZkITbYkhmAi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPReiaNlCpcao9ZbnnbaPpp5rtfNARtneeUX5dDoZIY32ILK7s
	2uiy015GGk/8WESQZcpf5q8PRkLh+eqjTyDj5JaFRQvo+0ieAR3+kc5BcTmqK9SlC0v5xh6j+Ef
	rYL+kwzkpSN4GLdJ9uVFkPOqCXLFW2Zs=
X-Received: by 2002:a05:6512:33d1:b0:5b0:1ace:3bec with SMTP id
 2adb3069b0e04-5b2c1af52f0mr268182e87.10.1784971187926; Sat, 25 Jul 2026
 02:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719121140.28730-1-kmehltretter@gmail.com>
In-Reply-To: <20260719121140.28730-1-kmehltretter@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 11:19:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLnCSVfJy7hgPr2qAwYeJy2wVNMfHoi7aCdJsupEBXaxDQ@mail.gmail.com>
X-Gm-Features: AUfX_mxBmD26epbQyyenypkfzJ30-O3BLttZrbPM42ge6269rEY64-rgYQRYkA4
Message-ID: <CAD++jLnCSVfJy7hgPr2qAwYeJy2wVNMfHoi7aCdJsupEBXaxDQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree: don't free uninitialized dev_name on
 error path
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 2:11=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:

> dt_remember_or_free_map() duplicates dev_name for each map entry. If
> kstrdup_const() fails, dt_free_map() frees dev_name in all num_maps
> entries, including entries that have not been initialized.
>
> Some pinctrl drivers, including pinctrl-imx, allocate the map with
> kmalloc() and leave dev_name for the core to initialize. The untouched
> entries therefore contain uninitialized data which is passed to
> kfree_const().
>
> Reproduced on qemu's mcimx6ul-evk (pinctrl-imx) with failslab injection
> while binding the pinctrl-consuming device, under KASAN:
>
>   BUG: KASAN: double-free in dt_free_map+0x34/0xa4
>   Free of addr c425a900 by task init/1
>    kfree from dt_free_map+0x34/0xa4
>    dt_free_map from dt_remember_or_free_map+0x184/0x198
>    dt_remember_or_free_map from pinctrl_dt_to_map+0x33c/0x4c8
>    pinctrl_dt_to_map from create_pinctrl+0x9c/0x5c0
>
> Initialize all dev_name fields to NULL before duplicating the device
> name, making the full-map cleanup safe after a partial failure.
>
> Fixes: be4c60b563ed ("pinctrl: devicetree: Avoid taking direct reference =
to device name string")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

What a good find, patch applied!

Yours,
Linus Walleij
