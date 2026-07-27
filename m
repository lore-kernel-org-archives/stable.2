Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F2370ADA
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161794; cv=none; b=fK5pzYiPYAux3p0a6WgAgmt1eenk/BnVg3IrfAot8GuUsRiCM5Dy7VhhHeJnT2KV+/MrP6nt+7vX1xcn7eg2ESawOfaF6UAsOH7lLOE2r0wg6mBWTmyCCE4Ox4nB2ZX3hA46MMWGNZbU1rzmhkd/U41qPiJ9wYWx/76qELJdOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161794; c=relaxed/simple;
	bh=ZTt4L1rMqWUs0ZHpauJ7AWFGS7OSGMA9OLRAFFoDi7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2PcY/DHlx9ZKgiaYMDKTuN01Z313IHoL1Pyo3E68pN9Qxyb6lTsWmSKOoQhFZHWP8jUSqgc/CD3eLGn9bk9eMGcABJeAhXRLObwnJGNgjzIbE3Wd3hB2xh/yzj+3TEj3tx3WXpzOza+McJVgG+QWqL6/ji+tjHOKpMX7+WU0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+pufnrI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+pufnrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02C21F000E9
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161790;
	bh=ZTt4L1rMqWUs0ZHpauJ7AWFGS7OSGMA9OLRAFFoDi7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a+pufnrI1gWYPLr/P4t97o8MOwLq8o+2RUjv6EQUHRNu5NKggEp4oaIHX1mtmfdeG
	 UAhQ/bdmfI+gNkaNXgE+HzUJroIsy2fvgIN3p7MkRA/UugxfpsSPmZm/HB7zESJfpQ
	 F9azxlVVgUn2saZykCDpeRRTgsLazSLzRdO+K1FPOJh8oA81KKBQtRTAM0QqS3sN5X
	 nXtoetg0hjivL2l5YosWaFffLNtXvyGni5AKs+G+Xu3Me+MRldzpk7z9vAk5/C1TNU
	 BFexkvaGzCyU/SkXrnu2uAuKQ/E4XQI16+3FJpeJvb1Ol+0m83+nTkQkigqMj9r/oc
	 TYjGxWmAvg0MQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39ca0a30148so26959631fa.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpqHbw9Mw9HXjlhLc59DGLCfd70FJ1htZtAb4vWzeAbRi16SrhcAUlVt6f9rT+nH4n9fXExcAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYyrfFbJguI3/jj43uEyOwDmEYeDG0CocjOuS9ZShUu9WZmXX
	PYnqdPpDMKVc/l+zxruGAtZfNgEF0Ml8rf7fYdUi9paa+fmPTyrPXqGbXQj9Zc/RHz79qLv5RzZ
	EEZ61SL/3shTxyvAtfUGDpu51NXWm1Js=
X-Received: by 2002:a05:6512:12cc:b0:5b1:54a8:6568 with SMTP id
 2adb3069b0e04-5b2c1b54a08mr1798111e87.33.1785161787692; Mon, 27 Jul 2026
 07:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727140322.41306-1-mhun512@gmail.com>
In-Reply-To: <20260727140322.41306-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 27 Jul 2026 16:16:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLn7z2uSvn11KTi2WxdUD4SXno9rj7p4N3tfGgL2kjJ8qg@mail.gmail.com>
X-Gm-Features: AUfX_my-ZM7DZCwcoBOePJb0b--NOWy9eg3G5S9SiaVu3O8ed7UMyomPSntzgfg
Message-ID: <CAD++jLn7z2uSvn11KTi2WxdUD4SXno9rj7p4N3tfGgL2kjJ8qg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: unmap the bounce buffer before device release
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Ijae Kim <ae878000@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 4:11=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:

> sdhci_allocate_bounce_buffer() allocates its buffer with devm_kmalloc()
> but maps it with dma_map_single(). The buffer is therefore released by
> devres without the streaming DMA mapping being unmapped.
>
> Register a managed action after dma_map_single() succeeds so the mapping
> is removed before devres releases the buffer. The action is registered
> only for buffers allocated and mapped by the SDHCI core, leaving buffers
> provided by host drivers under their existing ownership.
>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buff=
er")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

LGTM:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
