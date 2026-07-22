Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571F23815B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724680; cv=none; b=fdyxCJdo8skn5J8k2vUwJVQErtD7jiqGzzgi0sQgcv4ROjvB+7zv6lSavFnaJ3EB2J6ozPWw8qRP/2EdyQUCAOovkrpleEdeS+MTIMVoXnzkPf5TDPILVsQO3JF8CFTJ0dzOn3JpEiFngs8qwP7TY8vPazjV7lJe0LWkKtGrhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724680; c=relaxed/simple;
	bh=cE1Ojb80pVfEWjHLM/beLVntqt36G2jJhVlZLqJ15G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFLNmG/t/Lf+XkA+uPQI98PO4QprhURIZNnFV1XHnbMdWm7XN9r21NV7D6JVEK6AFFFm2AFpd1AcxLrEF1ZZfA/BbCOLHRo89aemhb/soJiT0uRG0Pnjxyvj0nPybZGlBypNb4M3+VRs6DGEiv0d23P0A66hcYIHiuY7DtMOlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYkL0ghw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYkL0ghw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214671F000E9
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724679;
	bh=ii9eNLh+OyhBOgKbdCuxq8TmIdZcIlRxyrdNZnalKec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gYkL0ghw6pGW7mjktbGeu8qubL+kMkzQ0nY6HUd2MZDamwkOOYcWHzqJrNHsFHhmX
	 E+Ep4TV/wIiv6j/cVCIEMHcBVZS/pjf/zraRqCWSlNw2mZPHW+IURYxti/cOFs/jQq
	 a4XQJcl/nxZ9TXZo5coJJQJee6q6BlBBppmkAoU5T7tnoUIDpUQMZ7oeefLaYcEzsD
	 APpcB4JuAWGiLk7M2YFXsUoVHR7WqCcxDnVZaQ1F37d2ZCXec4YBEv4lqYXtVTfSc9
	 sutqKbbxp9yj2fFVM8/HF6fUcoTIkIrVQeDj1+28mbVs7BA2+O6HItrGQkgXRtK1lq
	 gTk6hO2iUT8tw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so12433056a12.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:51:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpkCs7ZsCIZMxE9jcT85P6ge7oRGvGfR/E5ecHdMiDELoRM/P1nH7CXvQ8mUjxxkll3yfaZQrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MWI4fCeCDPEgEvg8Af9cAD6rlZ4pUXmTZsh+BIcVegQpKIY3
	D7iF5Y1D25c89cfdCV196OZJ5yjlpKY825ikqwNUDFcdwCXKdNjznh7mPz7W4splw8iFUIxwtCk
	itXkwz7qWvQoxj0+nWCDOcJXNX9+PpH0=
X-Received: by 2002:a05:6402:354b:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-69e6525aa42mr8790195a12.9.1784724677802; Wed, 22 Jul 2026
 05:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722044457.1333404-1-liushuyu@aosc.io>
In-Reply-To: <20260722044457.1333404-1-liushuyu@aosc.io>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Jul 2026 20:51:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74o3hkWOTSSC5vfg3zh88E1isL5ch6ez1k-F8D9PWHXw@mail.gmail.com>
X-Gm-Features: AUfX_mw9kVHUAENtIPWu-DPbyERVoRUAoRoiOYxo0MnL5ye6Kt2zgSuHlLWFsa8
Message-ID: <CAAhV-H74o3hkWOTSSC5vfg3zh88E1isL5ch6ez1k-F8D9PWHXw@mail.gmail.com>
Subject: Re: [PATCH] platform/loongarch: laptop: explicitly reset the
 bl_powered state when resuming
To: liushuyu@aosc.io
Cc: linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Zixing,

On Wed, Jul 22, 2026 at 12:45=E2=80=AFPM <liushuyu@aosc.io> wrote:
>
> From: Zixing Liu <liushuyu@aosc.io>
>
> On EAECIS NL60R with EC firmware version 1.11, resuming from S3 has a ver=
y
> high chance (>=3D 90%) of causing the EC to lose the previous backlight
> power state. When this happens, the laptop resumes normally from S3, but
> the backlight remains off (when shining on the screen with a flash light,
> we can see the screen contents are updating normally).
>
> Since there is no generic way to query the EC's backlight state on
> Loongson laptop platforms, assume the worst-case scenario and restart the
> backlight power inside the kernel each time the system resumes.
>
> Cc: stable@vger.kernel.org
> Fixes: 53c762b47f72 ("platform/loongarch: laptop: Add backlight power con=
trol support")
> Signed-off-by: Zixing Liu <liushuyu@aosc.io>
> ---
>  drivers/platform/loongarch/loongson-laptop.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platf=
orm/loongarch/loongson-laptop.c
> index 61b18ac206c9e..742a585b0647c 100644
> --- a/drivers/platform/loongarch/loongson-laptop.c
> +++ b/drivers/platform/loongarch/loongson-laptop.c
> @@ -200,6 +200,7 @@ static int loongson_hotkey_resume(struct device *dev)
>
>         bd =3D backlight_device_get_by_type(BACKLIGHT_PLATFORM);
>         if (bd) {
> +               bl_powered =3D false;
I think it is a little better to move this line into loongson_hotkey_suspen=
d().

Huacai

>                 loongson_laptop_backlight_update(bd) ?
>                 pr_warn("Loongson_backlight: resume brightness failed") :
>                 pr_info("Loongson_backlight: resume brightness %d\n", bd-=
>props.brightness);
> --
> 2.52.0
>
