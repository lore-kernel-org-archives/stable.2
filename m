Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DF3612E2
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791777706; cv=pass; b=Ya3MXMxCBKRYIq2RlW86qg+FFq48ezOXbQH/hzxQ6TrIMZ7otu7I19E1WLKYVjP3Stls7fKM09si5x1V4lLBoNQUvaHMn9tgdx9OlsZ5xzRSAhNockvH0g56HJwAvzcem6/+uPcKhFW4H/qk68EXYMxrAo9VmWu6CrYZjYag3FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791777706; c=relaxed/simple;
	bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RorgYS/xcuFqeI/FHJg7DlpwRbQO+s1IT8nnWOZYiobMhQ+g+p+b6c7zdD7gPxVOvTld+CHoN02HnU/Jm70qwFXaDtSEUbA9aSUY1IHAam2S8PGShA/J5Pg/z7fRMbLaGo9Sbl3J6C2JvbnJO0kZnDn6FboAgcJZKiq6JEGw7d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ36cwfG; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ36cwfG"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a9a1ed66b9so9425291fa.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791777703; cv=none;
        d=google.com; s=arc-20260327;
        b=E66N9LdCYIM2ea9/9odCHMVJKI48yjyTETg7lGiLzX6TqGCtuasDyPfPQ0NK0LZ0MY
         +08une1qkpyb4ZbRfW12P9URbB4b9q4QiQN/lLDHAFfs0b3xgvRBGjxg7VmFDzjADJcV
         9CrBRaPKriZbi9tA2qoSaQLXzyIWfpJXsr+y3IHoyHKHdOt2A8eWXiqexvnWCsM5DRx7
         XV+7VWua1f6Er1DIFAz7T2AuuAFPBH0j+cIgixBQvNDCtODaLKHvFia8jmqv2QWLJlsG
         ffMLR7fqD2scwUOXxDkOLpPG7CJr/oBu5CHtHg8dWO8WVw2zB5oVzMuedWEmFhU9Kmof
         tZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
        fh=dEX6iu2dPItH/7lc/rbRENiqvxW7lgoC1ybbaUhb4Z8=;
        b=m7H6qu8Ts2GcWg2PB5lg3AqNvmf8uUWXGSGV265UwFaOY5JTsVKHJx9X51hPyyhdbH
         qPrZkGmXsEujuh2/ZGQhKni6tYoSl40llJXHai1P39sW3DZiEvXHCSI+2qH/n83cSGHk
         RkSNsOenmToBTm+6J6A6I9S1LGbxRHl9JXO6YWQD6X1zyxw9HLTgSxikql50sUVFh5xM
         jyg9c0C9xxZuSd4dPpkaiulB09bDUd1oe8Cdht9tbTPnBWvOZO+crCyt1gSnmVrs1TXp
         cBnlZMV1EJpBITKUse0DN+pfjcwDb/Iu3VtfVhVA5jBkn1zIPU8lfHCZy+6IHNJbZqTY
         PT3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791777703; x=1792382503; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
        b=AQ36cwfGPhnFdbImpDl6KR/pLalB3QqBuYM1+G6v3iu5ogXH25D2T0RHBzSZu9FWCk
         3p4D+QEmcvmjMtBSyu+NmZrk4ncIr1YQNVNjh2YIYFLNa/BBUvC2/wAfUrYXGr1twD4C
         fPwLtwW1ptwaTokOl1wHSoWV/neoUswdX2mJLjjv8xncQaO2VKXOiOak/VwT0+RCe7tw
         St4x2vsyVQu6QSl67grvqQMpRFUw7h8LKh04QyeoPgCfSEy1P2GpZ4bCVNuDh4EQWXD9
         l8kdnxM1BY0VB4/mFZZa+jNOZwW6+u+HKXZzJYhLaOUQS23yJhpbCBUj4MBskEbNeIya
         9IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791777703; x=1792382503;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
        b=YU1Wy4SHrkydIXk6FAf5M113uhQPjaEPsF4HV5i1CQXxnhjH4G+EjarHVPiBrqckYs
         u4GMqBZtlH6MYsgKWqnWKC9HlznR1O2sbWoq4jRqholL9JVQFoVVwVVrq/ThcvCkb8Ep
         kduHZWrlrXbzAgEjrmbcaOZg4swIBT5xPaXHzOQk47Cg75PKfC7xcbErDVZA9w5no1U+
         AmF/c/T7rnyibmVVhmBK/KphKID9ft/bTvr4DeX4Dxx9vpN+IhftTryNrJ09a4I/kxQa
         Qan7Cf80IU+DxHz+xrSTzQdXcvNZrXGRdrSTkh1B3dusgRGYXV3eBV05hevM0Dv4Hzf0
         AgaQ==
X-Forwarded-Encrypted: i=1; AKwUvByY+d24P18iOK2FGRU1g02N33NJ9cSVJ9MlFbfq6qlwMG8zebK6kZLSPSk/BOoYYjhgndZk7i0=@vger.kernel.org
X-Gm-Message-State: AFq9FYInY5NV55uRADzUfCTgiNfcUffuj64kQX+vDxLz2RsWni2WXjTb
	aHRRmpiiTYe973dMrKfKkWkoSekIttrN1RxzZAGn40h2IUfIte97v0IKQo3djYn9vQ22+qYnind
	Z8Db3aP1JiPl49EMNqZfikpddsNpUB2E=
X-Gm-Gg: AYBFou3MMsh6eDEIwi42NmqFXJMmoNCH2xxgKzK5MuIUqws1VubkrQCrWNoHSMFUYCp
	7DcO6NCv3XwKBQFzfatZVNMfVeauKQYp9ouM3qn7UGr49tzU3vVPs7UoQwVAE+vsZhkwMG7VqHX
	NTuZqKPH0aHo+cbsENMA98q82opHX+ObkiUo1QUrZgSOqiYyOEdQfHwbwk8txxxHJlhr2Y1p51u
	wpAEQL261zYRqHwa073+gUnN/Y7klfA1f3Ea3QPznl0jnDPLdResdFuJu2o0b/GuQlyAJY6TllZ
	lg/SYHl9QoDci3YG5tXREKLdsB/dYGrhP0OoHb6Mxb/dwsfLWnbEUhc2bMq0nFxfAQ==
X-Received: by 2002:a2e:bea9:0:b0:3a6:6a12:61e4 with SMTP id
 38308e7fff4ca-3a9c5380907mr22473741fa.19.1791777703249; Sun, 11 Oct 2026
 21:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com> <asm4DV84UitLCbve@dell-wzy>
In-Reply-To: <asm4DV84UitLCbve@dell-wzy>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 12 Oct 2026 00:01:31 -0400
X-Gm-Features: AclHuK8Nc-yI1UOeFL3cp2dh7P_n3SkiObRIXOBg2zlQtbRku8sMwkQ2lyVopD4
Message-ID: <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the review!

On Fri, 9 Oct 2026 at 23:59, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
>
> I don't think this is *real*, as code would simply destroy entry in
> that case, and there won't be on-the-fly dma operation on that, as
> guest mem setup is totally before execlist submission, if guest driver
> changed mapping by ignoring gvt emulated execlist status, that's just bad...

You know this code much better than I do, and I can't test it without
GVT-g hardware, so I may well be missing something.

The case I had in mind is the guest mapping the same page at both sizes
and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
or in another context's PPGTT. If the second request replaces the entry,
the first shadow entry seems to keep the old DMA address, as
shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
out somewhere? Please let me know if so.

> So this change would always force 2M to split into 4K? why?

No, only when a 4K entry for the same gfn is cached at the time of the
2M request. With no entry or a 2M entry nothing changes, and a 4K
request now reuses an existing 2M entry instead of replacing it.
