Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E93EDE7C
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811402; cv=pass; b=pwnHvDUBWW+iM9s6PQ0t5OeO4Glx/HebeYB+Dw0PI3fDqwOk/w0Ihp/5mF6+94kXvWj8kiIljccawhawIj9rJV2lhPoFOgUPAg14ih3kgbAm/IFNZVaJWVrYHogxVL80NF9J71ud6KbIDIW+QFLJraNCyRICPNeRJ9HidbaI5sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811402; c=relaxed/simple;
	bh=YZKYb+GkPftg01Ou+o7yt15VY2iSSja29MKhp+0jynE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1cl/F84hxUSjEpE3CtOWWh0LpWbH1PmB4I4nmYDNxw3V295oijWehq9z6RCHPVAU+psLnSCXZzeP/4V45QtYnvgye4IIgB1Q6fMo0NUrj5HqPU0eBVGUEeGm8aqS9pBVqirVXxMF2oHM61doqy2ubrk9Jjfqe47OSVFBmvS6Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jC8vkyGR; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jC8vkyGR"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80e2cfe6918so43400657b3.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785811399; cv=none;
        d=google.com; s=arc-20260327;
        b=MjuR+OKuToxV3f5wqUKqMVEx9S+0Q5+kOueFfMMvR4k5Ljt+jWRKx86K44xOY9nfAk
         G/iqRqaD9GeP5LfBwqa3QHjhZA/fWNAHIOxhNrU7whnMAYhNqk9nr8jHh6UspnydYi3X
         3/cmLq4sM4NopsLJL/987+WKNafHSorUHKWv15n49odU6XDsVm2f9x8v4yZC7JRmQB6i
         rRxlJlJ2/RrS60IBFz6YFUf2qNy52G1ye7VXlAcp14geYzxLhwJpzrpsy1FXRkP453Rb
         oBd1FHsfjcKmT9IJzwfbuPecASB5FYhYWueEIXRxpWiqP8CSlVtfWNpddB4SajGWoITE
         KYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        fh=KzFm5/pEoeIIojJXFmmN/VlVLgyNu2QG9ePdBnbY0RY=;
        b=HN7dBoYCiXkfO7wbIaoixpYF13gLVpKYoS0uwE7wgRUz447fnwHHn17AvtlmIlM0UV
         5F1qnIlB1ZE97C6i+Au2vJ92vafWoH6xXXSBgU3LCPvxwapOVI/Kyurwk8ZnirzYUEJv
         Ng90ddwG0rHTSq9TycFZpiVja7to2YEZ7s32hZfL+wv7GE7kQ3+gzTQ98ufcmieQXzuq
         bakvEI/23GdfBdH6yiK8kTOANqENGbfKbZ4b/IRcaPSC6N+2BcBuBGKN+3UTubZwaEzX
         eKSpOKJN3OV2hIZYTab7eyYdPngQN1qaDjr3ZL1EnFBUs6xZW+h9HnQJjxz7znMdtFIX
         FUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785811399; x=1786416199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        b=jC8vkyGRk/6dVnzI57mRjrGd4MqWLiArc7JTmqjqD6z0oiS0mwNucudqoCumJqjU6B
         yfCx7waIOJmSxiWu6GvOnURVX/TuBoZF/zv/89yb+OVs/IWg5BeyTcALp8iho/2z2Lwg
         k15bw1pWFm6RivINUFCPNnpZjG4nxfykdY+6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811399; x=1786416199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RF3fTD6VniiBpbG6B64SSlFMt6UnvATMppDDhdm47VI=;
        b=DKt8qX4r7MR505guXJdIXfklXCPMpAhqMIQANPOTs7Y8N2kngv7LQ7EuqHKDfB+nEI
         TJKFMYi/CjfN4MaUF2ufSRP06b37zUfi4NBRZuoJK+1Bq76PoVnmPpuABt5Cb8Kalhjy
         rpZQ/1qr4z7MnkVnEGESDD1wBwhvOb4c1qEdqm4J9rPYHIOA72J0a+0fpPld35bvUs8X
         JP3Qy7604MBGCkfefyqlmrOuBbGc9pL/mo2iP/hiw3PlSWK82GW8YZpegxjH43DhSx2G
         8pxvXgZS/FRenQF4ylGIuEcnM55WKmAZJIZwt6lU5q30xYuXcJct1rYUeHJ30UHe4F2d
         e+YA==
X-Forwarded-Encrypted: i=1; AHgh+RoLdPxs8bndCtFABlXYKU4wXKx9odwEf5L2b9vNDgZrm0fnhuM9AEa8TqATYk4K3l+pBYoggTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCeEgPZL1Sj0z9Ooq0tmze03G4U5Ix3x2LQ2MeLyHFiw510w8
	adjt1A257uPrmY0YOa1UaCEe4mgCUaGDksWAuea96tFflmKHoUa6I35mlF3/YDtmmkN1x7qbH1X
	wyuYzqZuts2Mbv6ZEgsn9rQLxscDI2bVx+0IT8Hh7
X-Gm-Gg: AR+sD12i/EpCmYd5c0/anzf0iIu90nH1tsRkmeSC+Q4j7wKW3S0TuvRaVeMn+8ycIiG
	rTuBh4+fNlwLLwohERDxQAFWgt9dnPcEZBfkREN3mdazgOkMJok7EpWWUemgtUCZ9bJ8gsIFEan
	swseoHhglyLu/OlrzS3aavSuLfsTq+mHER6K0AOvzRYV5UilCoeGyBm0QG39ZaE+b3I9ehCk/KX
	Nhl5HoAnzvcoZg8aiJ1Z4ueCXCIiJ2QG+eTakED0k9k+jr+b7kJxhjfLnZ3Bxnsc0sUjAjyv3xa
	hUMs4VxWBPRIgMJIyD2OYpJ1i/nHuQo/BzLEEd8DLt0feJc=
X-Received: by 2002:a05:690c:6984:b0:81e:a425:fe88 with SMTP id
 00721157ae682-81fd4bf523fmr168290117b3.33.1785811398719; Mon, 03 Aug 2026
 19:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803141659.559129-1-akkun11.open@gmail.com> <20260803141659.559129-12-akkun11.open@gmail.com>
In-Reply-To: <20260803141659.559129-12-akkun11.open@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 4 Aug 2026 10:43:08 +0800
X-Gm-Features: AUfX_mw0ODj1uLGkUiNOBLIVs6yIxP-U-M-JHW0wgLxFKYiXjICIFii0-d42exg
Message-ID: <CAGXv+5FHSNH5SLiCiXyHDieO2rUDypAQBi5-nbTFKFzb+3ZWRA@mail.gmail.com>
Subject: Re: [PATCH 11/32] clk: mediatek: Add auto-population of sub-devices
 support in simple probe
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Miles Chen <miles.chen@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Sam Shih <sam.shih@mediatek.com>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFPM Akari Tsuyukusa <akkun11.open@gmail=
.com> wrote:
>
> MediaTek audio clock drivers call devm_of_platform_populate() after
> mtk_clk_simple_probe(). Extend __mtk_clk_simple_probe() to run
> devm_of_platform_populate() when the new 'populate_children' flag is
> set, reducing boilerplate.
>
> Note that explicit of_platform_depopulate() calls in remove functions
> are unnecessary because devm_of_platform_populate() is managed by
> devres and cleans up automatically.
>
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 7 +++++++
>  drivers/clk/mediatek/clk-mtk.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index c3369a04cdec..71d70b5a9990 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -609,6 +610,12 @@ static int __mtk_clk_simple_probe(struct platform_de=
vice *pdev,
>         if (mcd->need_runtime_pm)
>                 pm_runtime_put(&pdev->dev);
>
> +       if (mcd->populate_children) {
> +               r =3D devm_of_platform_populate(&pdev->dev);
> +               if (r)
> +                       goto unregister_clks;

You cannot use devm_* here, as they get unrolled _after_ the probe function
returns an error or after the remove function returns. A child could be
referencing a clock that got tore down in the error path below.

All devm_* functions need to happen before anything that requires manual
tear down. You can't mix the two together.


ChenYu

> +       }
> +
>         return r;
>
>  unregister_clks:
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index b6504b3e77ed..11939e3e0b38 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -265,6 +265,7 @@ struct mtk_clk_desc {
>         unsigned int mfg_clk_idx;
>
>         bool need_runtime_pm;
> +       bool populate_children;
>  };
>
>  int mtk_clk_pdev_probe(struct platform_device *pdev);
> --
> 2.55.0
>
