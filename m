Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C035E1AA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941327; cv=pass; b=KvOIlSMoDF4ZvRDreixDMVrBuhIv1/9STgVp8bP7gCBOMdad5ihyUpajgMkWPzdtZjLOSGv+oBGUr88mgMr0IYZ4Ohp3V5YItYDBNlxpkfEzdYdbLhQJuLGqFkFYOXI1Iyy8o4qZJc+RvHLU6OFl3MxhhwIT47/Xh71EiF0ZZgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941327; c=relaxed/simple;
	bh=+sm0oRaA6CohSwBYAY2+dXS3GPcskWTVG01fLCrlnwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCGuxThJ6lhNV7W+1EU5WSXusN/AxgH0xg2fHFd7+0i33/nXtxlZMw8BZwOI9a0fHDBEO8fp8WB7kCLrBEdvk3/jx40ykT2PjYGgq7UkVBys2VHm7XMcQX/pymWAFdONmwCTC9wIdvxo+4EPx06zxe3kpEnPgI0PRvV9kttS4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEJUdGBr; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEJUdGBr"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so9997a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 07:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785941322; cv=none;
        d=google.com; s=arc-20260327;
        b=JivvYIWqj34fayyhH8EgY6Ow0MdF5GaE5eQCvAxhd5JcjxrEFM3lF+rJypx/Z4ds0a
         d1szU+QZpd9NgBFfshYVEVHWqUtChEkkA70h9nsFet4CT3Fd0CRT5Bd1foRG8QSh+Uhq
         kxWZ36oR4rXhlXDfk+DRirA4rMdcvJIVBkWhA5CGlfTKUQXOwjlLlH7rCR16kOxP4TZk
         swfwfy0zH4xdwlEOvIY/qpQvglFDz/3H3257H7t5g9cddUVqIJ8W6fB4FJ0eUxscHxgr
         4SF8v3bWfxm4tujc7dewTYgyj4dg3Z83PWxYuc+9jvvaXZ3O6yNWowGk+pn6QNCj+S63
         P8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74JnmzC+AtkPtezOthxS7FXM4/QTh3C+xB8eJUSwR4c=;
        fh=yVjmxp/6DOHQ4MGXOPwb4NXdttNosuRGRgPrZTbHtrc=;
        b=gy1WbZRckBtocqsKaEuf/lL6rf9PqTx7KRvUuWb27rlDRygaacK3BQNgpdKxxFL8J9
         gfJ1GiIVMMCVx2U1OMih/XdNBdknQTd9EuDFcmmlRdwBXIgZPdonVkoSPlZj3gv3mN02
         paLFPdibiw6ay/ZhVEYCwZV2vc4R8USxy4CY1xgtyG2bFDWCNMzuoMVBwfKCB8MLJjA2
         UBUQZghgzCSq5JKlc42wbH7MD5Bl/j+RZ+ZnsP4zfCbv4JG0sYTgNdeMApMKkp+yM0nl
         7rtdVwtBJz37Md3AkwXRwRI643RsMZiCcbauPGOZM9XF9HL+V8y5ut1XesppfzAp2UVv
         /rHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785941322; x=1786546122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74JnmzC+AtkPtezOthxS7FXM4/QTh3C+xB8eJUSwR4c=;
        b=WEJUdGBrauM8YzNdg5K0UE7jvaPSg7qNnJaEf43SRQxfGXPyY+EARXmDfGhxAEdfn9
         nHBYhToAN98b5aZiNT0Ov5jywpd0gXO4yoxqEVCJGfkLd1Dy2WI8nGDVtxP8GnT9TTJH
         pIeJe3hgR++mz7N7nPEKD2yoWys3wc58vtGgs0VUXwGu8g3JTq/p38UgZAZA0u713szF
         2nCbXIhRHxk0NHO37H0BtSyvkSpnigdgDXqC69a9n8kuv1ELXCSazwuNi+6eUp0pM6qB
         hrYFlANCazK30xnY6hlc9TlUKt42q8qX5PrEbjBdUoQe9K6RZiQ1TD7FxR4j3O4MkGib
         vemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941322; x=1786546122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74JnmzC+AtkPtezOthxS7FXM4/QTh3C+xB8eJUSwR4c=;
        b=WxMSY8FArePlsRT6FcSN52FYBHiBTo/MYvHHGgwJd98YT0rHkFFrxxq3KEtQrPbhSY
         XbsayUnxT85TSHjatMbKDIwMkJGQ12a6b3mlG/2+t2B0hrFoTljDWnUuJRyFUJc8A17+
         spxCTJkofb3XvDomjukUpl8uXvNZ1qbuUeWOCXjcvy6jGZi4ISHZTCX5cEVMOFOfUBAB
         jttLsyQdEW67I+/bRogiOVmp1p8VqqrGr/T2G57AUnLTK0v66CQ1y57TvXUb+k8TXjZk
         PkzfaTyWi6+h6ld9uoM5rhdWCgo/rC4qdps4TJWBEhd9m38ztmYdgxDFRgY8ayb17wys
         u42g==
X-Forwarded-Encrypted: i=1; AHgh+RqbluHHKLnZcqlC1yn7Jc6ankzm+D3QV9NzAmMM/1aMqntH9heZaDh+PaARuTPFzIF59N+rWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtjfBPfUSv3qreAV4MPl3nGK5SrzBjSSS/WDFuAHOY7cZayEj
	+CZv+WoTMdkk4dUz01AWW0fir+yHZDA4Cuw+SlcZ4TJrV/StUeoLedo4k8ITJJXuigfpMBMhMN0
	cA0nMyiySjU4HjMBjUc0BZ08/Q5NiN+OQf6eD4SZp
X-Gm-Gg: AR+sD10Usl15jBiUUl/YzriQZTlH76lH4tYU/49v0E7FptrJIHWx56pZKN5PjaaCRQo
	cWsw0bYw1SytNvpNpdHky/QPoTzb1dnAKUi1hLM6veWPmkhEAwHDb+aULLAVx8V5zB/0pG+27Zt
	KeACirDxSKJPBw/en4bZjPdcT1rIFzyDor9qewE4kWFwKTYRcxC6uWV3WGBXSw5LvmIr1vZLEAq
	Qnc5eecI+9keqm2rGwLr7C2WAhjzPB0bL7/i/A0mIdlpX7TXYrwbWJ90HmIHzmLqnd4K9dq27ry
	TXdR2Kv4srar8N5ttO7IeC/OWkdjlRYpP3nRgCEFZAl52iy/4x63BUanBqqj5RlrO//ThfybYz8
	=
X-Received: by 2002:a05:6402:44c8:b0:697:7f69:48e3 with SMTP id
 4fb4d7f45d1cf-6a14fc7db15mr73328a12.10.1785941321666; Wed, 05 Aug 2026
 07:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805090633.141001-1-hao.ge@linux.dev>
In-Reply-To: <20260805090633.141001-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Aug 2026 07:48:27 -0700
X-Gm-Features: AUfX_mycrpDzhEJqHYmTeNBhjo08UvV5vnN10hZEYxiggLM3MZtoYjhTvx18P2w
Message-ID: <CAJuCfpHUqqD_GttG3bmxEPxeYNA9p7SH3aseWJFHAWN8aYKJAA@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:07=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
>
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
>
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
>
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
>
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
>
> Remove the mem_alloc_profiling_enabled() guard. Also return an error
> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> the mapped pages would never be reused - shutdown_mem_profiling() sets
> mem_profiling_support to false, so no future module load enters the
> codetag path.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> Changes in v3:
> - use pr_warn_once() instead of pr_warn()
> - return -ENOMEM instead of -ENOSPC (Suren)
> - expand the commit message to describe the /proc/allocinfo impact
>   (Andrew)
>
> Changes in v2:
> - return an error after shutdown_mem_profiling() to skip
>   vm_module_tags_populate()
>
> v1: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
> v2: https://lore.kernel.org/all/20260804122038.190270-1-hao.ge@linux.dev/
> ---
>  mm/alloc_tag.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 52aece27b00e..35ef2bbfa13a 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> -               if (mem_alloc_profiling_enabled() && !tags_addressable())=
 {
> +               if (!tags_addressable()) {
>                         shutdown_mem_profiling(true);
> -                       pr_warn("With module %s there are too many tags t=
o fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> -                               mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       pr_warn_once("With module %s there are too many t=
ags to fit in %d page flag bits. Memory allocation profiling is disabled!\n=
",
> +                                    mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       return ERR_PTR(-ENOMEM);
>                 }
>
>                 grow_res =3D vm_module_tags_populate();
> --
> 2.25.1
>
