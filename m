Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8848D874
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352225; cv=none; b=Iag8itnpDcH1Lx68bxUOeqUWsWXTEKu9A3uMWf8gJHcaBVrp36EuWI3hnN4p12V52dkd7M4tv8CY0rLNm9+XvZc64vp9Sh4SVSIy+HxGdcRAM72yhLYmYYN15OKqjLkUNn1mE46A/QOlmqIgm8CqJqyqrm04PBYh7ckPrZ7nKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352225; c=relaxed/simple;
	bh=Jw8I8KiyBzK4krNuRNEbLp7x85N3k1ph/dDFzes/gD4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJcCYzdoUzIjBxee51UPPuEP5xPZkBWeVg6sIhUvQED0AmYU4RrOMZD4nftiUzcyLxF1TWToW4HxdUivV8s7ktXhGUne5fhVlU1ErkPG2/nDjaUoUeOeBex71KT5sxBb0rsOBBrdDQsFiHWNymFKjLMpbxo+aVKoJ+CRC2zLjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mePyn1Kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mePyn1Kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EAA1F00ADB
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352223;
	bh=Jw8I8KiyBzK4krNuRNEbLp7x85N3k1ph/dDFzes/gD4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mePyn1KrKlUIC0pDJ80SXU8qbae+hipt/NTAtNHnA+cYwDqtQICrwzCor7bqW/UPK
	 1FV67Mh1McRjLwzgHQBE4lLcZccbquuTffZcNzJGEfIpEhJqt6dijEGng+91dQc79k
	 E/2nBIosQg4eBVNWa35xPddj8L2qa0m3+4fC1yG+0v8f1KlK/5R7gKww2VcIg5OF0k
	 O4MuC0VmnIOmatkWtXAVtj6GyyxhDRHTAkloYkehpq+8VCAtkoB4S7roa7IQ/IaIN0
	 /hZjT6741Qm2oGGxel8EsWztMr/Q7eOfHr1RWFfQihAMNBzeW7GHIss7/cnDbSaaV3
	 hvdOUNcp+b7ww==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b4a95ab94fso2109356e87.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:30:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByniprEBjOtD8eDGWQT5hOXzzkXCgboCynN4HjX8JJtTJPht3fI+DCxCg67JFSPlI/+edRAWFA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMyrURx2zg9745gWt0sBD1S733YPz8t+UsHPjhDYVSxyhZGram
	XN0HebTuViQ+h+WqzSBLVJL5+LW7jgd5vXXM1FJZAh37yfHZQDyCFjX0gyMlOHGeqDGiLIm96cG
	opemdRwCMJcW+b7jZfG6qa1EbUa1rhxe4IFTFomKZCQ==
X-Received: by 2002:a05:6512:228d:b0:5b5:e2c0:510b with SMTP id
 2adb3069b0e04-5b60c2af6d7mr680289e87.4.1788352222274; Wed, 02 Sep 2026
 05:30:22 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 05:30:19 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 05:30:19 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com> <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
Date: Wed, 2 Sep 2026 05:30:19 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
X-Gm-Features: AcwNN1U24dyKB99fnkPXyWUGjekW0b5TNJ_oPsk5eSnHyaY2MGzi9qRRlixYVp8
Message-ID: <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> said:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
> through gpio-map properties. fw_devlink instead parses GPIO properties as

Unlike PWM, there's no such thing as "gpio-map" properties.

> direct phandle references, so it records the nexus node as the supplier
> rather than the mapped GPIO provider.
>

Can you point me to an example? I'm not sure what a nexus node is in the
context of GPIO.

> A nexus is a translation node, not the GPIO provider, and need not be
> populated as a device. The resulting fwnode link can therefore remain
> unresolved and indefinitely defer the consumer while
> device_links_check_suppliers() waits for the nexus.
>
> Use the map-aware parser for all supported GPIO property spellings. This
> makes fw_devlink resolve the same provider as the GPIO consumer API. Direct
> GPIO references continue to work because the map-aware parser returns the
> original provider when no gpio-map property is present.
>
> Add OF unittest coverage for mapped and direct GPIO suppliers, including
> the deprecated singular and unprefixed property spellings.
>

Since this is a fix that we may want to backport, the unit tests should go in
a separate, follow-up commit.

Bart
