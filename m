Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631641;
	b=ieCo7SL4tuptzpg2GzvIn6jl0EWCnTRzAGmjzZmwBKtzZe09tPWGR0AjrU1S+e/TL7TU
	 zYPJTqcNp3lIqqyDkfo1cl01lM1T5x4VeCUuEDcwzluGWGwY9v71Tdl6f/5SZmuCcUiSI
	 Zybp9BWuDmBjrevQyCQU8N0o0mAEv4dfjtNvGSAqMHeVSWUuhw8jHOJR4ZcvUfj/QNnUH
	 jfgb7zaMZ0lBnOA0eOZI4QhtttKH3eDkXsN/NxQC1p18/dGU+azBQmcsmogUss8BhkJQP
	 LCABExh9l6rFVAGzuXhj89ai/Fn0aZXoHbnePkGNWUl26RpuDWzh6AOaTSPT/yOh65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631641;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MZOn7cbyBZCKner9Io0gV9Z7rV2XG5FimTAg+eegkQw=;
	b=4YCxvLWJGL9FMfL+feKsUlWrJwWsWYBoVqo8ZV0tHjSF0E74QKEQ9kQfNV+zTp3XLVn6
	 RHJrXvj2s7KsJb0zjwQ8uAJ21GUvGRBD3edRI3N82pM8eiMPYaBTSQkqmKhcDvf7aqW8a
	 60gysAef5LSTGhW2v6XeqJuQf2JitutauCbE0ToS89J5caWJWEX6Wq3XVMqyoQ08VNaqh
	 FGlXH2Pb5H04Sn8zwWyUJmeLcqADi6c3gKv4Uk+Zidc1NytuV0V6ut+qsqGMdEJGDE9FC
	 vtmkjcMdBOvn9x8/iEHCsRZMbiR3YDoqjZ9AzDVwb9zwfSN6kbgy6twUy7zMAJPteHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMR604Vd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B4606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMR604Vd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A91F000D3
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631641;
	bh=MZOn7cbyBZCKner9Io0gV9Z7rV2XG5FimTAg+eegkQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gMR604VdeK3XkdaruPCZrrWntH8ZkluWTq1UEz1VzQEDYndulZ2K0orM1LCEeXm8R
	 Sdg6hQ97QvJsBIZUClF2b9BGXd0m/GCR3m5rsYPmmE/mX+1BK1nyneigOjCdPf4h3+
	 OfVymgM031W1ZopRBlTAWmOC9mwIa9Yq1KpzvcUBHkqfy5yItIg4lFiW4TpakH27Vi
	 zArSLBcTb20Mq2UFvT/fkmC0LZ78HTaLbT97cgiu3i/L3cWOfLiR5ej3uUXEQifyIO
	 qKx+/wwLkj/3jIENXBKu4oVAdMTqfLume0cMIFm+9BsDAGFPgXwXO5QVjz4irZq6r5
	 7H3CawIi5TT9Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so50890121fa.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEcofcZnazMb9zLjqf41/GeyzNXpUE/KRwQ0rm6iHW/Y7ZHtepzzm8JPrDPMYPW5pSQQcGV6vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E8kygwfT/HSMsMePUBeZ8RsSaBbvD0hsTxx68hxREgoQszND3
	R5dc8nqfZSpqamK2qLLsMZAcOw0oHo41IwwaXLcFuQdhM2Ch/nGbAXf+GL++FEYwlOB0A4QKZM5
	rTOZbThfd3JRH5mgF+adTMH0UPU0x/Is=
X-Received: by 2002:a05:6512:3d23:b0:5bf:f76f:b5ff with SMTP id
 2adb3069b0e04-5c1bc8c950emr6241358e87.52.1795631639987; Wed, 25 Nov 2026
 10:33:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119204748.2558209-1-lee@kernel.org> <20261119204748.2558209-2-lee@kernel.org>
In-Reply-To: <20261119204748.2558209-2-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:33:46 +0100
X-Gmail-Original-Message-ID: <CAD++jL=yx_=j3Km32AqKmQ+JqKadcCEOBMBs3R3dVvhS9A2DPg@mail.gmail.com>
X-Gm-Features: Aa3M54qJrAjbkPP_s3DSmoGNUsm5bkx7wv6GpF9Uaxblh2WXq34zjRLrGUaH3NM
Message-ID: <CAD++jL=yx_=j3Km32AqKmQ+JqKadcCEOBMBs3R3dVvhS9A2DPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] pinctrl: tegra186: Fix out-of-bounds register bank
 index for AON drive groups
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Aaron Kling <webgeek1234@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:48=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> The Tegra186 AON pinmux controller has only a single register bank
> (nbanks =3D 1, indexed at 0), and all PINGROUP entries in
> tegra186_aon_groups accordingly specify bank 0.  However, all 51 AON
> drive_* macro definitions pass drv_bank =3D 1 as the final argument to
> DRV_PINGROUP_ENTRY_Y, causing any drive configuration read or write on
> an AON drive group to index pmx->regs[1] out-of-bounds.
>
> Update the AON drive_* macro definitions to use register bank 0.
>
> Fixes: 542baf77f092 ("pinctrl: tegra: Add Tegra186 pinmux driver")
> Closes: https://sashiko.dev/#/bug/linux-a9a7165c-c5eb-463a-b7b1-24a30416b=
33b
> Cc: stable@vger.kernel.org
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch applied!

Yours,
Linus Walleij
