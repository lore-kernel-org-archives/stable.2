Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30594218B1
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785579439; cv=pass; b=shgYTT4dYi8pKtxOxBcpVe6m2RA/D4xqIlWtLLeDStYog3JWNobMlM+U7lPKLZ9JA3iNCA2SI48ltQSTBF7BoZNK9yqrASo6N+yWs4m3joDrOimyo/T9++ikPrZud3qsbvvKmb08a9ExXCDMTHXLZFPFwgAunzKBvnBhLIu0Fmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785579439; c=relaxed/simple;
	bh=fYuc91yYvMFDE6497qhGMtUAgZbd6nA0KxrauEEgHMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9JJYu4uH9Vd6crrC6gVcGC1OI5wGGnSux5mqd2jIQ4BY9lhpbS+OzH6H10mc1JXTQOZv1x7Vn5bQFP5ib95aZ1h6KRSUNGmeWPKSmAIgzzrnpuzfzFOGomY2Q9+33DWqBlB+LLFoJbbyV99KkLvfKhHEzZcii3sedsFa9161UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/3WkENd; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/3WkENd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b5737bb2so1615357a34.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 03:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785579437; cv=none;
        d=google.com; s=arc-20260327;
        b=Ze/mF/h3qUhUBeFKwPqHZZv1GZRbg95z1ZIc6hYr0BhofRCNeFCC4Rt3bbag+B6yUf
         19cidc+nmgNwZClN9hYPiJk+IYj3qbjC96fRowQpe2ITz4C666ODKNBTZIiznhtp9Sm1
         OI2T4u4COOw2Kd6i3HRjMmAI7FiPco0/CbucG6ca1/FClG4JxJzlQzADn5jIW1lMYH10
         Q+MDxEuZUpNP5kOUm5xh5PVz5W5ttq/45uTitQPBn3/w/YARWqplVYGoRlYYWKaCLNUs
         rn2mZ5JrH/v5jyeMmZHJ77pmHYNhp6pUYYBsz2b57gQpNQGNUFlFaZYrR8bKKMoh3LKx
         o7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        fh=zHytMwPtYCia0fmXub+I2LkvVqDcYE994vndjJC60ig=;
        b=gaOztQkFQpyD/XhsDvKov4uiKkJypCzpVW3dGnD4CkVoRiTC33Y5EEvhyxrD79uzza
         beEDchKeFT8MwCopDXBrf1kkR/GryDxsEsCBdlzwmYARQqF8tKMho2nL6GE3e1s8UOCP
         Zkift8H0TW3HYxPc/xQyjyTa8cfue+8rTceJ6BQVlEDoXeQXwqKq6sxDJFcIzcaZuI32
         cf4fJ+0kF3/nNiv/urP7XGceTgHZx+J3cipqzEOy475TOyj2TY6PClojAfiEsRiL1+T5
         ccHiQiQyEs/aFv/NDGwTJPUd7ETRuiNUXGielcgh9kUnuwhpmweGdqYAjwEB+dX0SQXg
         zy7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785579437; x=1786184237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        b=N/3WkENd3AbGKSO5/TTgbLmZr4Z/KYTNfR6Ng94/L2l+W138hPbF2RLrkUJuRERrid
         1P4U2O4zd4UHjf5nn7ZayhLcKAfmF6KPd9MZBxwyw832Y5uHmLJncW9Yk/3y2TUF4Rvs
         1aQ28plPDQwCv2fdLnDtIyl7cVEnpeSRZpZK+iKUm18kH4jeGXql7surTmxxUBoEs44U
         JwyqQ6O92TLVOhL2CO7qZaxkil1ZNf1jYjq6Snf9691cGpe0suDv9ZP3KtnzwjluZeNm
         bU8DnrDWf8KVgByK/QII9KECNGtFUsi6w9Kz9w9JZtelNqPgSqiXiCako1vQ+NfTLlnx
         uLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785579437; x=1786184237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        b=n67dZczZtEgw1jnxtoo/Z5+APPorS9SwY19+GG91dsO+UA+ydI4y6c0e0D30rhApwD
         gX2mre9Vutz5zznWrt/uQSq9/Ft9nfHpAbu+XPlDDisz8rihT+qmzrhmTq4WsWf4S0eY
         jzWvXxaMt6l9NCiSdBhOsBB2IAZsiBCrFsBs3F+FzkqnE/irfDgB2UJ5ZIsUsuTfg1u5
         P8GuHgtF6DRvnzqxOzA+iMtFJTQunMReaQy0LrYMJvzzrxF+/w+rQi/jBEPNJt5LiDSR
         Mcg8iKkgR6zWaNfRbjPcalfXSoO9w217moAb7FiW/OmQ7N93gwbunJEUMhmzJV10zDZy
         FsKQ==
X-Forwarded-Encrypted: i=1; AHgh+RohFv/SdCivyTTUkp9bGJZ+eQscgwTl9/Qeawy0V8rzwcD+WUT82h+GEP7J9qqckaj/4YH0Uc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDSa9vr+uWlKCit4BZTmn4fRzbbU01/P47eb39HLejplO79HJ
	mqTBaCJmDLpdkA4sb3+qClk4Ld77w+L8ssiWUQy4BykBAKXbcYdP1nzy+FHhsuBmyNOLNjgCQ2J
	NSVjie0wCfHtjEI9cXGRR9v3J1ISdw1U=
X-Gm-Gg: AR+sD11Mqz44hyBSD1cw6sheScb7pz6+V9jZo4vGiOCkusQUnTStnzeKPU437uqY5x2
	SNHsfuW2boY02FntxE9Lbeof+tCq/m4i5awj1sv95RD3LtSUH5sJjYmBZkzq/G/iis2Ixdz3/kW
	3WAOWXiIyW3tBwGjZlJn/bg3aLhh+4HImf7YZLLaoLOFZTusx9BofajwFavUXtNDmdF/s1Ux5XT
	zkhJHW2sv8wcVJnpcl+94jxpYqXuRAFR9l/w4Jr0zsD4936HT7qTyfHNxzLF7b29tkCjUEwMOKM
	xmfRs2h99kT2u+LSpI8CNomLEyPgaz1taMWZokQFH4kfHg==
X-Received: by 2002:a05:6830:64c8:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7f196d407e0mr6475364a34.5.1785579436652; Sat, 01 Aug 2026
 03:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df5f0d9bb8f11d098f086bd2ace5aa0cef4c77d7.camel@web.de> <20260801071724.12998-1-spasswolf@web.de>
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 1 Aug 2026 15:17:04 +0500
X-Gm-Features: AUfX_mySPDS1tX6sBksLt_ubqUTn6yupd7v5vPVdQi51p4TGShRSsHENrQ2zzec
Message-ID: <CABXGCsMFa25HyOdcSX8QR8_=58=uJT+HMVhyus=rOFHBML25=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	"# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Rafal Ostrowski <rafal.ostrowski@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 12:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
>  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED()=
.
> Also fix the error path in dc_create_stream_for_sink().
>
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - P=
art 1")
> Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de=
/
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index cdcf140bc1bb..accad9e20e88 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
>
>  fail:
>         if (stream)
> -               kfree(stream);
> +               DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
>
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
te, const struct dc_plane
>   ***********************************************************************=
*******/
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
> -       struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
> -                                                         GFP_ATOMIC);
> +       struct dc_plane_state *plane_state;
> +       DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plan=
e_state, GFP_ATOMIC));


This hunk breaks the build when CONFIG_DRM_AMD_DC_FP=3Dn.

dc_surface.c gets DC_RUN_WITH_PREEMPTION_ENABLED only indirectly, via
dc.h -> dc_types.h -> os_types.h, and there the include is guarded:

#if defined(CONFIG_DRM_AMD_DC_FP)
#include "amdgpu_dm/dc_fpu.h"
#endif

With DC_FP=3Dn nothing defines the macro in that file.  dc_stream.c is not
affected because it includes dc_fpu.h directly.

This is not only exotic architectures: DRM_AMD_DC has

select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && \
!(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))

so an arm64 clang build is enough.  On amd-staging-drm-next with your
patch applied:

  $ make LLVM=3D1 ARCH=3Darm64 allmodconfig
  $ make LLVM=3D1 ARCH=3Darm64 drivers/gpu/drm/amd/amdgpu/
  dc_surface.c:89:2: error: call to undeclared function
    'DC_RUN_WITH_PREEMPTION_ENABLED'; ISO C99 and later do not support
    implicit function declarations [-Wimplicit-function-declaration]
     89 |  DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
kvzalloc_obj(*plane_state, GFP_ATOMIC));

A plain x86_64 build (DC_FP=3Dy) is clean, which is presumably why it did
not show up for you.

Adding

#include "dc_fpu.h"

to dc_surface.c fixes it, and matches what dc_stream.c already does.
Please do not copy the local fallback that sits below that include in
dc_stream.c:

#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
#endif

It is dead code there - dc_fpu.h defines the macro in every branch - and
in a new file it would compile cleanly while quietly doing nothing.

One unrelated note: you kept Cc: stable # v7.1, but this version is
rebased onto next-20260729, where the update_scratch allocation is gone
from dc_create_stream_for_sink().  It does not apply to current mainline
either, so older trees will need a separate backport - worth saying so
in the commit message.

With the include added I can give this a Tested-by on dcn32 (RX 7900
XTX), which exercises the DML1 phantom-plane path rather than the dml21
one you hit.

--=20
Best Regards,
Mikhail Gavrilov.
