Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B43442FCD
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795430; cv=pass; b=joFsYmXIN302zBGhOmeVi3zrQ5dPqX1zB44WT3ZN/mxb42jGLPrqe47BlnKuhrQZ7VKHLKbjjVxrQFI6odw0GbPt01XkPnIAn21VzeeX7y9mFnuVtl1sOKYgaLHOZdv1y6aVaAWvew+nmEOv43vhVJvAojZb/W6pI9vYJFRKrZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795430; c=relaxed/simple;
	bh=+hsanqcaRD8wERt3PKwcrFG5KTWWy58uIS8hjI8nI1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZRqWG9OG/ra0DnV5LexdcphNZwT0LRnSWMcKm3L6Infzh5SZTjeSv+uW5bbHbTK6/RprWmcVT+vMOSa9bRJi4GEg82WRTfvy0Cl24PzhnLTwAimtEi0sNdPfyBAO5OPz9/cahCyd4uGRd99+ipdiv8gq5TvFDIfEPbzUCc7bBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Ara6So; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Ara6So"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-782e0fc1e55so531741137.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791795427; cv=none;
        d=google.com; s=arc-20260327;
        b=kT6TRAcv2I6tH3mdmjcCh6ihbkVRO2tC6XYhe2jjrGUtSG5NmFJrMcq+m7HaEF/nhB
         vGL7i8TY6RqDI6dPcexhN9U8D5om1kPX08F/BxZZPcBfeJdFqMhd8sN5r8N9w/v5JEKz
         4oPh7NOs9eXX/FMrGKXE+COdLxQ64s2LtK2VPRgn79vQjDdyPRK7iBCU3l0BLOD7Fgw7
         EtFFj3yZ9qV3GPk3lYb+7fRRQTKVeEE3KqC2c9calKuBoG3+tsNiooyRDgc+ckIm4U8f
         PYQUYs9qkFfd8mL7XcKScg7ERoAK6S7t8jGqD+RwM+Sj8xvo50uhz5uc92GycUZveVbV
         oPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+hsanqcaRD8wERt3PKwcrFG5KTWWy58uIS8hjI8nI1M=;
        fh=s7+3ZozNc3LmEpItYUWEuUzsUqn3CE93bBooULztLXY=;
        b=BM0SjbA5zR78U0FC7hbaA7zM/mSXME6Ce7AWpEkO+rAJwWfMd12xVhNz+HzX7Q9B18
         EeOVNkcnFupgd+GTPnlgR8B1Z76nRzZfFCGxDjKXO6iNpdkys1hr5pfb36BrVCEPr47M
         D0ItZ6US5xoMbW3+uC1Sa77r1q3qG9Wmg085q/AFcdzhzLCn4RaurwWmyFk73HFKuYjS
         TDUPgOze7SYBIfl7jASCsDa8LCpoRtUm+7eu7nxN84ayQRju+kAYSSkMOxEeQpAnVkf9
         /SLmvAxhS9/t8UOmrH7c6k9fydRuaqDjpxXvioi+W9kKQOP4rNI1aOrUGoHYOBhwu7lX
         I00Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791795427; x=1792400227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hsanqcaRD8wERt3PKwcrFG5KTWWy58uIS8hjI8nI1M=;
        b=O+Ara6SoNrBB2FSBPPX6UbK2RadUgZI4KQzRClFwS30a0geXziEfj3kRXg0u+y8Kqb
         Z6pqPkVuZFvLbU5gM1MPdUIAAyEd/FUx5+hwim6CCVH/gK1I+UYArcAHw8uJNAg/LGKZ
         XxMgtsMQ16n6I1M+znEzd/epzexWCRduiGdyA0QErbhNhaBQpr4CEH+d6lzm6Opcm5Q4
         HjSeDw6v7VWCy+tR9BkREUu7t7CgiEdXU9aJi9IMWVTO8a/IhoVs4SvEAhWJpONfrW44
         +WVrEQzXBrCnpSLuXTpSuqFX4HYkNPhr8FkSbfbFKmzJXspcRzCVCZCxDGn99EaFlPJN
         Tc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791795427; x=1792400227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hsanqcaRD8wERt3PKwcrFG5KTWWy58uIS8hjI8nI1M=;
        b=1b8XMfZxjDGWSvnWX0WaS0AsbBDElCsIxI/PafA385CP95UxEyel2BQt6jLfe6jJqw
         3qaKzdkjI/bd2aefI+nrBOxMd+tTNHw5H2iCgBxDWwzKauHj4cGqPCqK5ASjzDAMNHtZ
         heX1v5k9APEc+nPsmV1qJu6iGZyy0bNNyL7JVYybMzaI3qhy2TBvNyX+N/La+bL554FS
         yA/r17JL0Fut2E1p5lFnd4qClhK+fgYOZG7N/7cUGhAyTA0cKurAcYPw9Alwa494Htm8
         1g+SQuG8bCD6876tQNVeId6Iecz0eZz9jWcEQi9ojVNDKuThQTkpumkd6hjiUu5KMWjM
         XQnw==
X-Forwarded-Encrypted: i=1; AKwUvBxPRRhY2G1hT0d2P5dyZMxsk0hpvQmhw/cZpZcD3GpHxz9jCeajifOSC/wd+YuTmHAKbA/0xnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuHDHX+NdCmIktk0GMbmKH1oomkcVPIN8CiPEVu+IJ48RIan9v
	kDhYT7oyGQ0mCitZJrsWEl/J+sONon6OpiWsPh3yyBlGhpddVSFYnh/gbSGLGQjXWj0kHQhhxfG
	qs2zCsXvg/Kq40tu17FNXOYzQr+uzaWE=
X-Gm-Gg: AYBFou0es8X2ZnTetw5KQyA5m2RIOxzQQ6LzeZ8eWP7b78x+VEjlg3fZFahTr5HEWtF
	tzt9lVcuFiW+fDVt420uc5h1PK189VnzpOTHXZvVx5yA/S9lxzLeeiIERT5h5luhfRPqkBknMSd
	GK0SxwnZh0IBYTUaCeSLbD+IoxNc769CUMkNCMSR7CxNmIGve94/5qibbwzw0emkTxRTpS5bsEc
	1tzuYZFNfhJ5bOnXaOdYpgS1MCbEy4X7MoRvrVn9kTFnrXRflauc5H4TMUPnCw7NU8hXpjw2n0t
	6U3qtiv1OElgHREobbprcU+2KVmrHIwwbi4QOY12/LcNsorEgKTrqn1bkW58HDXPcUV9sP0K8cJ
	KODlnxevm5eiK+9jA8zVJaN/Ua6/fjcv04Y8sVUHjxOlbjBFinoXR2iLs1M68Cb3Dz7V5NQRXdA
	yQSIki21hh5I+HlwELm0izDRErh2DdHU7C/LX7VndHPsp1
X-Received: by 2002:a05:6102:80a3:b0:7af:4843:5ec9 with SMTP id
 ada2fe7eead31-7cb3728268emr2044842137.8.1791795427219; Mon, 12 Oct 2026
 01:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
 <871p9v4a1x.fsf@bootlin.com>
In-Reply-To: <871p9v4a1x.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 02:56:55 -0600
X-Gm-Features: AclHuK9PgSRU-9yDfcYymMtt4yQDEEGqg1HXAOlwk0cudjnkkhK9ivdvdn9hMz0
Message-ID: <CADvTj4pZEH2wj2aHSL+S+jO-MeFjRx+XMqhv+XGLiiukvf28vQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] mtd: rawnand: sunxi: support the Allwinner
 randomized OOB format
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:06=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi James,
>
> On 14/09/2026 at 15:09:46 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > Allwinner NAND firmware leaves the bad-block marker in the randomizer
> > data stream. On H6/H616 it also places all protected user data before t=
he
> > first ECC step. These choices differ from the mainline format, which
> > keeps the physical marker plain and maximizes the H6/H616 user-data are=
a.
>
> [...]
>
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
>
> I am sorry but I do not want to proceed further with this series.
>
> Even though I am not capable of finger pointing what is wrong in the
> diffs nor in the commit logs, I do not understand most of it. I cannot
> clearly explain why, but I have had a hard time trying to understand
> what the commits were doing. The risk is that nobody would then be able
> to further maintain this driver and I am not willing to take that
> option. The kernel policy so far has been to ensure readability and
> maintainability, and my gut feeling is that this series is going
> sideways wrt this major constraint.

Just to clarify all known real world usage of these devices requires
the vendor layout due to BBM's themselves being randomized.

From a practical point of view I'm not aware of any way to avoid
this constraint for any existing hardware.

I mean, without the vendor OOB being in mainline it's likely maintenance
will just be abandoned due to the mainline driver being incompatible with
real hardware so that doesn't seem like a very good tradeoff. As-is the
existing code has received very little maintenance overall likely due to
this issue.

Is it better to have a more readable driver that's effectively non-function=
al
since it's incompatible with the hardware or a less readable one that can
actually be used in the real world?

Keep in mind the patch adding the actual vendor oob format support is
only 270 additions and 10 deletions and is fairly cleanly separated from
the other format handling via the sunxi_nand->randomized_oob flag so
I'm not sure it's really as bad as you are making it out to be in terms of
maintenance burden:
https://lore.kernel.org/all/20260914-submit-sunxi-nand-vendor-oob-layout-v1=
-v6-13-2fb084fe0751@gmail.com/

This code may not be the easiest to understand without LLM assistance
since the vendor logic is somewhat complex but since those tools are
only going to get better as time goes on it seems unlikely to me that this
would end up being unmaintainable and regardless most of this series
is unrelated to the vendor oob format and is just bug fixes or optimization=
s.

> Also, from a Linux kernel point of view, we generally just do not
> support vendor specific layouts. I already told so Richard Genoud back
> when he was working on H616.

Hmm, I'm seeing plenty of mainline drivers with vendor specific layouts:
https://github.com/torvalds/linux/blob/v7.2/drivers/mtd/nand/raw/rockchip-n=
and-controller.c
https://github.com/torvalds/linux/blob/v7.2/drivers/mtd/nand/spi/gigadevice=
.c

> With this added to the pile, I prefer not to merge the entire series. I
> can still take some of the fixes if you feel like they would be relevant
> anyway. In which case I invite you to send a v7 with just the few fixes
> you think are actually relevant outside of the randomized layout
> support.

Patches from [PATCH v6 11/18] and earlier are unrelated to the vendor
layout change so you should be able to take those as-is. I deliberately
structured the series to put all the bug fixes ahead of the vendor format
changes. The ones after are mostly just optimizations that didn't make
sense to implement before adding vendor oob support but for the most
part probably still make sense to add either way to some degree. All
changes
