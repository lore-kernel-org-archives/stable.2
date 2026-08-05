Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37E3CF05D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952077; cv=pass; b=ErM7oaAFYLuvR/H4dr158p+oHV/ZRb3C9lpW/kNwFCBI2bNQn8+t0W21e8A6XmTmOdTX9tV6yzMGLQDWyKDOiOcKDd2OSYkaa6nRlo2SpJQH4qBTWdLFEnuG0tmmMC8MEKWHtSaS49QlZbHOVb+NZEbidRlDBakoP9JXkUYJLK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952077; c=relaxed/simple;
	bh=XwAypjWZWiKfGF5jOo7lZPiJ4DWx37WusXD4g+uRmLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6N8rYOprG/spxzxqjbq1Rz7XmPVPY8Enn/x2ZZTotpQJnNisO3/EQ4KDyGPglj5H2qFpG/FZ0j4fP1aUbN+rKnPwFhKE6+03SB1cEQbLRb3Of+qJ046y02QNUAGiOULLwoQHQCUi9U828kjiWZ1Yr8jYMAnAYqHmM8o7rxqRaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A18J6KwG; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A18J6KwG"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so22921cf.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 10:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952075; cv=none;
        d=google.com; s=arc-20260327;
        b=krE+WoTDR1Napr8A/hqiODIY6A/CJjXgDJYamYJAczBnLXwaA+aHjY53resjysF+xV
         b8nV7QKf1d6O00PFvf4Gd4d4JU+ROkIr7Xn5qz5XHa6iJOaq/fBiWvUQH5519bNfAJAM
         wM0h7CVZpau93eq4hDwdIr6WVp80IQlsV+SPRE0c0vOIxpL9YGU549HM23ukKAtAtnu8
         yAX9Vrsi8QkFkuGXoIfhjf2Ws0bViR6H5y05vfhkzyRKJip1/JZb/MgMj+gJEQiQ1Nh/
         wWMU3dW4XVOXIC96t3eWpxke2j7+OAYyGoAzTbwA21AXz6Yoai97GJ/COF+6E1xkijCX
         wrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gnWA/DuIIokY8/eXsnQhd+bhj6lSNL2Ukz/5pFHWlTQ=;
        fh=iv3eLk1o7GuDGYaJluNG71XXzWxY3+fWpGXLyvYs/kM=;
        b=YtUjehsG90KZR+lZ7LccSBf/GpYOfMo4wOS0+S4cvfErjuhD2sCzip+Hf+0ORj76Ed
         4W+uL8XlZMr7x7v7nTaRPNCS2+Pdp/H+5J1TDongwxdsTT0A25gVuKr2xrldwE2/bn+N
         9hDqZWaydAaxOTqg/FBOBxQXA9VqjgO/+TPCDHka8PgTRZsQaFkVjcrvcC0lt1eslbU5
         NJZqF0Ymm7TVRj0uKApq9N5i8mjT/XwteYzL+V9vM6CsnACk4sx1cLR6peJSmroSyjpu
         UPCBAo3vnqZ5+BIsReUSFLx/mMlGvttLVG2XuMiqxYlhayKH+D1H3gBM13cBuSXT5Dhe
         pe/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785952075; x=1786556875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gnWA/DuIIokY8/eXsnQhd+bhj6lSNL2Ukz/5pFHWlTQ=;
        b=A18J6KwGB1MBqIoR1PlAKn0WTO7aGMqQHim4GTXLHcdYjOlA/ywhcLcvEhykxjpcA+
         ftVT8pc0HIsTjduzqyZV23nExyksWVflpbP1Rwm0GSCa/Ti4KWPvEB4/XUFg/61QeHAZ
         NNnXoLdq1nXGxH8RnuHW9GCOvi1Lmz0+5hNwLj0F3taGQtNT41CNbxMjsdcjr/iA+BEU
         uo7yRzUVP67tEGXLKO5qJz2NpCmP/d0BlUf/7XvZBSEN6eD8ERxQjXk5o3TcyWl3ff2W
         orCZzoZUVqNt9rcIhdh71ph5RaoqzChVjq2PE8xlmAUnq0uvQPPPabPOPpW/CJHYYdy/
         B/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952075; x=1786556875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnWA/DuIIokY8/eXsnQhd+bhj6lSNL2Ukz/5pFHWlTQ=;
        b=b4exrRzTWF/ZOtkTGixLU6zmrbDIR/BB8R3mN3aR/8fQBRMM+VBpP22DiN4KG6immP
         OU6vYS0pX/9/pml+HIsK22Aldb9IrxgbHK/TP4BsF1xh0PETe/mSjvpZSavUax5E3eEW
         gZA88fhEaPZn5XvtoBZpFKgnqhgclEKJMNoB3iJjTbiE9Yvvx/6pAi3k6Gn2Xx87oLGw
         ofR5WXPzmwQaNd+dv7SMfqe+y9xH/nBZVdCH3ioz3ss+rkeyLL7+Ymr+XJIAduOfvjMg
         l9BLTX1CBgk1ZbzwLYERI5H0vFPCuCZY/pABrjI/pmX4JqbrLxtfkpdd+LQRHtetRhYp
         9iFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCklBwkyrp4/veizTaQGmFLjOm68jkxQtos0/R37akONVdwBR5/PrzLQ28aX0IZr1Ck3DpW8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigyEz/tK1A8XoQeGysS2UpHH5BFimy9yeiNscrIUqUj+Nt5+r
	boYryB4429d2mv+wKlFH1WtrgOJZS80zsG9R6/qJGa2TpgyexoAZLxM5XdV545Jo7gxoIHNp5pZ
	wrciUK+556obzetG5FA1+Ihmg5kFB6xjDQUidpz/9
X-Gm-Gg: AR+sD13VpkCCxZotFs/Z/iZVlOb0Gajl3EXWZ/CtkECoNNTB9hvi+9p7mLdlspl7X+F
	+8WXOcDeR9vcWG3BzumT49R91sXWGECF8sn7rZKOLcKJtlerB+pIsplJZw3rC4oNTqMfvjYLxzb
	rAM3QfgjOLR4vk4yX2hegXp73jTen+4FyPlYieWaWUxJjvf1NlttTEPWPSXINgg4geiRsQ1g8CI
	gB82cucizWbZqLmeUcpdmj5mOPfaPspx2RAkfUYx3t/+4OmWCgdW3EZKPGA6fxaIMzpwePkpTMq
	CtK24K1udRIN0E2W8H4bqzMLmmQIb+MtvVi27Y4Goq3lgBKfLjjxJrTq5Zl8zUItagdrQeKQ0rA
	=
X-Received: by 2002:a05:622a:22a3:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-52cfc109122mr792451cf.9.1785952072535; Wed, 05 Aug 2026
 10:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805090633.141001-1-hao.ge@linux.dev> <20260805095505.1c2cbc150441cb20a74ba9bb@linux-foundation.org>
In-Reply-To: <20260805095505.1c2cbc150441cb20a74ba9bb@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Aug 2026 10:47:41 -0700
X-Gm-Features: AUfX_mxKiYGwyyUljQnBwrH-ct4w_9C4kkNu_d9Bab_VVjkT3TZ1NCyG0rHLGmo
Message-ID: <CAJuCfpG_XX-Hwy=TCrJ+g6yiMxGXLB=LvnPN_WLP3WQktNZMbA@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Abhishek Bapat <abhishekbapat@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:55=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  5 Aug 2026 17:06:33 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>
> > In reserve_module_tags(), the tag overflow check is gated on
> > mem_alloc_profiling_enabled():
> >
> >     if (mem_alloc_profiling_enabled() && !tags_addressable())
> >
> > If profiling is toggled off at runtime and a module is loaded whose
> > tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> > skipped. vm_module_tags_populate() still maps memory for the tags and
> > the module loads successfully, but the total tag count now exceeds what
> > NR_UNUSED_PAGEFLAG_BITS can address.
> >
> > Once profiling is re-enabled, ref_to_idx() computes each tag's index
> > as its position in the alloc_tag array. update_page_tag_ref() masks
> > it to alloc_tag_ref_mask before storing in page->flags. Indices
> > beyond the mask are truncated and idx_to_ref() resolves them to wrong
> > tags.
> >
> > This silently corrupts /proc/allocinfo: allocated pages get attributed
> > to the wrong call sites, so the statistics it reports are wrong.
> >
> > mem_alloc_profiling_enabled() and mem_profiling_compressed are
> > independent. Once compressed mode is established at boot, it stays
> > active regardless of runtime toggles of mem_profiling.
> >
> > Remove the mem_alloc_profiling_enabled() guard. Also return an error
> > after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> > the mapped pages would never be reused - shutdown_mem_profiling() sets
> > mem_profiling_support to false, so no future module load enters the
> > codetag path.
>
> Thanks.
>
> AI review points at a cpuple of possible things, one pre-existing:
>         https://sashiko.dev/#/patchset/20260805090633.141001-1-hao.ge@lin=
ux.dev

Yes, pre-existing issue can be handled separately, it's not directly
related to this change.

>
> "Does this unintentionally result in a denial of service for module
> loading, preventing critical drivers from loading when they otherwise
> could have just disabled profiling and gracefully continued?" sounds
> pretty obscure and I doubt if we care?

Hmm, I think Hao considered that in his previous version, but now I'm
thinking we might be able to handle this more gracefully and not fail
the module loading. When profiling is disabled
codetag_needs_module_section() returns false here:
https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2822,
so if we had to disable profiling, we could return NULL instead of
ENOMEM and change the condition here:
https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2825
to act as if codetag_needs_module_section() was false from the
beginning. IOW code at
https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L2822
becomes:

if (codetag_needs_module_section(mod, sname, shdr->sh_size) &&
    (dest =3D codetag_alloc_module_section(mod, sname, shdr->sh_size,
      arch_mod_section_prepend(mod, i), shdr->sh_addralign)) !=3D NULL) {
...

I think this would result in a better handling of this situation: if
we can't fit the tags anymore, we issue a warning, disable profiling
but continue loading the module. Hao, WDYT?
