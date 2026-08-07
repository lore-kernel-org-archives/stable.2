Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1965399372
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129102; cv=none; b=MAbRek+GUL4EfxaL3ZCjhAzW826YCNv8BU9irVlWI5yLiXvGfq2HwHZIq+mp+2nChbFTR1StKYMPV4pXZ9NVgOf6RdoTfudaS5i5hX002jyXhQu4IKDS77LVTd9HgZN3hcr1VSMXRsrNLFDPk6whgajGgH9bUbSCd1Hcbq5tB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129102; c=relaxed/simple;
	bh=aGtkDqO7e+54jvf08NyJuzEW1eC5g/ECUadimlOEYqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4RCZLjhmi7yXdne7nEyKP0oHBn6P4pOpOpextmmD+QEyc2UUDK/OEdo0mT907uG3Q4OkIqOiBJ5wNQVLRTsf+8ZYJZeIt8vTFAn1Vff3D6/rCOWBCQRDrQn3Vz3o631FiAD9W+cG0Z9XSnSGkyxNHA7eUYo+ZhJW36ivRjDwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+rwtId/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+rwtId/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A9B1F000E9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786129100;
	bh=aGtkDqO7e+54jvf08NyJuzEW1eC5g/ECUadimlOEYqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K+rwtId/JJsp7Aw67BwNtSGYf8oTs1k/80tLy67f64WjE1mqJ8p1o4Wd3tmwUWnuJ
	 tnf/u4evB0eUq6ooOVQrjOPtN6jugH4GZ5D85jBSHJ6roCaZEODa6tMpbLm2K1Z8GN
	 JFHUKYWP96fsCpQSxhAEIqv9Hbn8SfkWo/PX2cHT2H4cyc0GTxfDus55p2j5ElsOsf
	 jmtgMZ2I67s0sufDbX+plFa8jKOJ+oMFIFV21qe5ZbAhqNQ2rkea9lZaRguYyAZWGH
	 pcW86LQlgrZ7BTvj515EypQKPRn4h7LtbS4I332NzX8GdB0F901/lS/f72L1H57kpn
	 8XgFLp8exC9/Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39ca300db70so33060551fa.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 11:58:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp+m2sSIbCoVi8BpgKCIm9XBGdHiIrIiVFvnEsxArWKNkSseKVz/v+URK7Kt3oJJl6nIfRobVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrQEYZCY3zJtl1W0vuQJQDdFB8Uz7YJBDxueL6fPzhpPPyfHe
	qgl2ISQEVp0wZ3nBHreYHSdEfgXmrCP5f3A3+fyUDLWxceuoWBhvEz5u1pnjRBNBI3lENhgk4bS
	CkI/ChP8+BrHnpT/mWAtL732yjjDGbY4=
X-Received: by 2002:a05:651c:a38d:10b0:39b:3adc:70f9 with SMTP id
 38308e7fff4ca-39fbb0668b1mr21822891fa.1.1786129099241; Fri, 07 Aug 2026
 11:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805084143.3901-1-ansuelsmth@gmail.com>
In-Reply-To: <20260805084143.3901-1-ansuelsmth@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 20:58:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=LLyod-me-wXKznKLhjjGFTmp7x5uF1nCUL7fMTBpONg@mail.gmail.com>
X-Gm-Features: AUfX_myFt8OXaBF6dymdCU5o-coQ8gVrYgo4gR7tMibyT7NV-8nbLtvGnaWMtag
Message-ID: <CAD++jL=LLyod-me-wXKznKLhjjGFTmp7x5uF1nCUL7fMTBpONg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: airoha: fix wrong value for PCIe reset pin
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Aug 5, 2026 at 10:41=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:

> The PCIe reset pin actually require the bit to be set as 0 to work as PCI=
e
> reset pin. When the bit is set as 1, then the PCIe reset pin act as a GPI=
O
> for GPIO44, GPIO45 and GPIO46.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Is this already fixed in the big Airoha patch set from Mikhail
that I just applied?

If this is *not* fixed in what is currently in my tree I need
a rebased version of this for mainline.

If it *is* fixed in what is currently in my tree, this can be
sent separately to the stable tree as a backport once
Torvalds has pulled my changes.

Yours,
Linus Walleij
