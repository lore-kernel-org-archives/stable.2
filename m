Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB3F12DF
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677328; cv=none; b=IVUUdSpl2Qx0hGEC20QeowkcF8goN1MOG9VymORdREmm617wbqLuDUzvO+802P05Nz28CLkmPg6hKoxBDdd3d9RqtFkKThwuUg2FMi4nnYzAD8/U5zrOP9NY/Xfu7JHtl5etlPa6xb0QYv/R8lzkIDCaewWU70NGJKUlzLrKfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677328; c=relaxed/simple;
	bh=IQCTtQNW/hKXRkFnI4RcyXAnrgrs8DL/pT0BVeExKWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOrcxlVicfhE/hISe0nAmGJWimqIDshHEu95mA087vca0sY886LrCg2C1Tt8RC6rvlbYPZrulDqgz3tng/hKHuFsIqdAHuWWu6rKJ0IMfHqF78P0Fm4vTnXYUl/F5eWAMfslEL36Zph72BEbAslxw/E66BbouiKj7aJ+8kH7yVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-736eec08c43so647767137.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677326; x=1784282126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjx1ETi0pE66yaW23Sda3TmvYDKWG3Oq92tmDl3ve2Q=;
        b=rwFE3anydJEhT9DWwRyy9W+M1ux5m/Glhl3RCOuSUvQLqhHXa6vgITcwzz1V8mndD5
         +/MIrsVbQvlnUlPy5FHClO2kfrP6QYDB88xj8eq7G4NYvcVbJ8TURl9Xy55yvEUEJdyy
         5PCltUM0DcMqb1rBXeaA7XDmEgLDwIwmF1TkVmLDEdokLtZtFkPLUrcRYf793YQnWB9B
         WfFJUvYe7PZmCVfXvfhERjnfukZSb3EnDdrVi5X73tnqKjyikJ6AtJRLiC2jZuqm4Ji0
         YUYq0JDrgSPPBvSs/Wml3WsRWZLPOtj0H+rrzC61G+Kl3iyK85Z+4g4D3FRfjiOqTrEX
         HRJw==
X-Forwarded-Encrypted: i=1; AHgh+RroulDYWF9v5HmmdvU22DcNeLa08Tr3r0jcGtlEkjOjhKM8jTDkbV8wXcE2suCJyTcDbvoTSWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjid7TcMYu16zRBZn2p5v6enCeLOrMxYWGqN7Gx1KjEopcHnN
	wNRODCmlit59dRyXhtDlq/yVnPKhidkSYykDC+WEl49yIAIXpd1j3NLNkGAzpbiZ2xU=
X-Gm-Gg: AfdE7cncyMwXURU4vk8GrNB5WVnP+6fEom043kk4qTvfvMbFxDZcd57HWKo7omSFVnG
	y5hGtu/MWEMhetZW9IJWWSGGH6gGsI2xGcXLPyip7GM48ihma1Dgn7cW6kvCVrc2GRWQ9nl21/n
	jLwWdoUE0Ltre17wK3FYWbsWY5HicJ614X7W3XW0IHGh8BVJcIVXoC1k4poFEuWEtcklIOldmkR
	V6btWuetwGQOaHLNX56Vo4ZO1dfjuZYqqSy7iiXhkFKsGM8UPcprC/pGnLcb/zZHo60FmpLx3E/
	zpKABeEAbg1gqAWruKxSWf9j+wj87Add1vaIBrfBUR8mtDRiHA2Gpg6pbGNsGqhpHVEQLuz+Ijb
	6GTZ5BwwvzRgqDzQFQrxGULP9SN5MKMhpwTPYzbAiVwIf8I61PXPxAHe3roNffIgD0W0qxUv07k
	nKRZsG+nFaUbahEVw3GqXuBXxm4ykcD07LSEIoBx8NfF7K1Bfd2CA2dF2s/EzZ
X-Received: by 2002:a05:6102:620a:20b0:738:c9e1:c60 with SMTP id ada2fe7eead31-7450cba3f83mr1185482137.0.1783677326178;
        Fri, 10 Jul 2026 02:55:26 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6deb2a3sm4953175137.8.2026.07.10.02.55.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:55:25 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-736eec08c43so647754137.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:55:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr/Xr0nr90WT0Cy1VfZUg9UPOkMpQ4yxrFbRjvO8q8OIBfuVRYbjGm0nDBgfqyQtY840ljiRA4=@vger.kernel.org
X-Received: by 2002:a05:6102:40cb:20b0:744:f2bf:44d2 with SMTP id
 ada2fe7eead31-7450c6bee09mr1250670137.3.1783677325709; Fri, 10 Jul 2026
 02:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709221245.146406-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260709221245.146406-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 11:55:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBJuN6ZJzTMU_Ww7ZUm2Apmp_AaubAE-My6DK334pLPQ@mail.gmail.com>
X-Gm-Features: AUfX_mwl89Zp9wNyF-c_GbFzjrveXMEBWiOpAsRGPClNvXP8eS2mrd7PvQf895c
Message-ID: <CAMuHMdVBJuN6ZJzTMU_Ww7ZUm2Apmp_AaubAE-My6DK334pLPQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ironhide: Describe inline ECC carveouts
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Fri, 10 Jul 2026 at 00:12, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The DBSC5 DRAM controller protects DRAM content using inline ECC.
> The inline ECC utilizes areas of DRAM for its operation, which are
> in the DRAM address range, but must not be accessed or modified.
> Describe the inline ECC carveout areas used by the DBSC5 controller
> on this hardware as reserved-memory, which must not be accessed.
>
> In case of high DRAM utilization, unless the inline ECC carveouts
> are properly reserved, Linux may use and corrupt the memory used
> by the DBSC5 DRAM controller for inline ECC, which would lead to
> the system becoming unstable.
>
> Fixes: ad142a4ef710 ("arm64: dts: renesas: r8a78000: Add initial Ironhide board support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
> @@ -107,6 +107,47 @@ tee@8c400000 {
>                         reg = <0x0 0x8c400000 0x0 0x02000000>;
>                         no-map;
>                 };
> +
> +               /* DRAM controller inline ECC areas */
> +               ecc@10cccd0000 {
> +                       reg = <0x10 0xcccd0000 0x0 0x33330000>;

I think you do want to include the 64 KiB block of unprotected RAM in
each region, e.g.

    reg = <0x10 0xcccc0000 0x0 0x33340000>;

While that block is usable, it is not protected by ECC, and thus can
be subject to unnoticed corruption.

Alternatively, you could put these in separate reserved regions, to
make it easier for users to re-enable them if they don't care. But
those users might want to disable ECC completely (is that possible?),
again suggesting to keep them together.

> +                       no-map;
> +               };

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
