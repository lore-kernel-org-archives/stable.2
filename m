Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B01339B3D
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692833; cv=pass; b=TPtc2tpnk599ojgeOljnBs1RezwLVgtLfX/NhiykAFeNekL2ZH5S6lGzsHqeIRubnbfcyFuQZ9OeW0GZmB+/jcgh/XLwFMZAOSgSKw5mEo9By+SeBvAP9+V7nnglcO7MH8LOqe21rk4VNPgzpax3xvpq2bIMPNX8QDdwa+WKlEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692833; c=relaxed/simple;
	bh=+0FEERhuCrNALhxt5BYqoKVl7HbeqQe4QtB0NTjTiQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmMBsyQi4tyWpdSlZ6V7Jrcjp1voqIJtfucgQAGBdWrF703nSESVnzA42hVb3nuMwXd6swZGgnPx/NwMwv5pDsTsxbhOh6EacfPmoFpeMu22OyWjhu9fQUisMsUtL8YTdxXMm+7M6LtEFm6AOKvK4eKE/VpjrP3iC7GiIXinQ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3i0Z6xw; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3i0Z6xw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53113d72966so101711cf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789692831; cv=none;
        d=google.com; s=arc-20260327;
        b=njpHSmZG8M0pVvK0L7jVPo9/OYrocJm8yvcIWyL1HPuNyO99eCmy5HA92GfY94TvZP
         zsm9kjrRG5v3LCqHHMd7cj8CFhLKah0g/9PmyjxG+S+odsRP7OAH8z39x76Y9rA6EsPP
         zvn1P3KUhq/V7BUVcBtK5h4q3VBKk95UD+DgkHv9VoNKnDd9666J/sEyXneQS9hEkbYs
         I5w/zP/1ZCSSe7B6dYtpJrmMiL7cRv+WQxxLwBVME5Q/el9OXG2b3N4jtCZyGRDKTu13
         9GmI7a2BeJw38rzXyV4dAY9C2U+dCY7bmBVO6ynjQsoqoL6UslZA8Y5DzpyJUrJGtVRG
         sQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        fh=lAXvXBIsETISQjJTINQry2ybDtqMPBbOHGuyp5YQ01Q=;
        b=YENvz0ovNkiS6lK875XiRMrrYZ7w92KuEsXNm/mdiotjEDU/gz0zBdKV2W/yUzLi6j
         0cQd9xNmCNaEW8GrvAtGEEQuWf0UexlKsxkvTMIZ3Pf8JGe0wNGgdIm+5ehMkRSoEgqh
         ml82KWYmcuf+h/njxyD1ACEWrhTsheJI+vhAI7jldiObMheH2j0bLpRF+2ewv4hzdxQl
         j3Am0wNIdRMzF66Ly23R6kch5TooeO68wDFH3wOyySsx4xbZzW1n4gz7zE13v/tN2PRJ
         zYZ8bLW21HSV12Ez7vaAc2ZEu+Py8cuTZUPvrOy8gNZ+BA+rgcQTybfDRtGr65DAIQEb
         Pieg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789692831; x=1790297631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        b=r3i0Z6xwdGZnSt9mDh2RVZCRb25qtWmuHncKV3cCVzvoZ28oqbQ6Dcndu1gVfBd44j
         otvXSfSaOTwIgK+o29nOvfkBGYCytVxFZrcFqIMCt7MYDXzkc3a4LvKQoiB3WAW/mEsg
         DuWkPt8ERVcQIawIJXVDSqrmlhj1LT3Rgia0plnemp4ngRXYpyolkuVakeGrpuITkSlZ
         F8q0UFlcPJU54oKSuJXDmdkKjukHLyk/3/iPc9urCEHu5NQNewcGuI1jDutf4zFFED9x
         3i11Kx/xTVzsxUyfOH44DZ/Caa1CTzm4OV6i0a+4Xnx9CRJ9eMpBa9zYbZumpKfCBgiv
         bgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692831; x=1790297631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pChmIbk5dvBz2x+ATGHEFGjZSAwLQf4D4OxFleYq/PI=;
        b=wqnCFbE1GnmRMC7XWG62ZAldn0w8vcxjIbbVicsgTRCOWXDB808iXeia5EfP2WLmYa
         peBCV2/ZjZHLQ3EiaQ/thNJlHLYoUklEzVVmsQ/lVBd07nIzR12totEjZ84NacBJLh76
         C37SNJLRIaWzRpNDiOy4E+MqSEGzuYb/TL7JiqCeuHPXwLsTO8ceBa29mqrl7N7vMNyq
         aDzaMi1aVWE6tixTHs8gAlAUBpad1oMjcYxBRx+lzBhrr1ajqTgEXWz8Cf/8K8cXppuK
         dQ358QPXHlVXek7YVv3CEa5KZfJ/lbHrVl5jFfMbXDs2TiTGuFaoEXSIAviGjQ3kHKqs
         GFTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+Z9LYP24KQQrDJxXZ1yxlWuxr4qvPtDQtxcfZ1/2aQUOg277tIhWyC3fXfBEV1gvCB6/dwlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7yzr38nupxvsfk1ynM046N5W8vh/y0RZCofthW0cIdHe1QSqw
	YV+6xEWOlxvOteDuQdWlm+3abfmLKtRIoiHoDcAU0SNpp69ny2GSnrCUYopNr0tkacLCB+X1/7W
	JELNUKyoDHNT32tQPeqnEK5boRYoipJAZYAloUOjD
X-Gm-Gg: AYBFou1MJv0Z37FEF3IwTXNrHdaWjIdG7muac06aM5AA08+lb7EISy9pIk5RPV45Esg
	ZYY5D4xeplui85PFYSY/UEwcp1Ad+YTBGk93WsJgpSZAH0lcxncO9UznvdOqcnILioVjZxo0p5a
	UDoptdhaMSq5zweUhIv4BvzfiNHMSUuJLwHXQIsA8ar265k/AYXR9a4BeKA5OD6wOR8acJY++8m
	ybkmhhp/R1GUToIu0C76Y2/rlBroLvkvxNaxEVKjT3vDM422Y4m7b8ccTwUbBsZzmrIFtcwN4n+
	ZBwwHbuwKVcH/fFZl/KVlA65pJv1PlUAk2KZaeZEDM1Ef+11JY9CPMElDUGFwD9L
X-Received: by 2002:a05:622a:649:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-5329d7ebce3mr7543761cf.14.1789692830152; Thu, 17 Sep 2026
 17:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-6-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-6-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 17:53:39 -0700
X-Gm-Features: AcwNN1VY0P1eKa2RzQfSlte4wi4uAKsbNqye2Ulhzad_L0NMHnJfbc2fVWd5zEE
Message-ID: <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> After shutdown_mem_profiling() clears mem_profiling_support,
> needs_section_mem() returns false, so later modules have their codetag
> section placed as regular data and never enter the alloc_tag maple tree.
> codetag_load_module() still called load_module(), which allocated a percp=
u
> counter for every tag; release_module_tags() could not find these modules
> on unload, so the counters leaked.
>
> Return -EOPNOTSUPP from load_module() when profiling is off:
> codetag_module_init() drops the module's cmod, no counters are allocated
> and the module loads without its tags. codetag_unload_module() now always
> calls free_section_mem(), since a module whose module_load() returned
> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Yeah, I guess I didn't think about alternatives...

When mem_profiling_support=3Dfalse, why can't load_module() skip
allocating percpu counters, zero out the whole area between start_tag
and stop_tag and return 0 as success (mem_profiling_support is not
enabled, so we acted accordingly)?
Module will be added into maple tree and later codetag_unload_module()
will find the module, call release_module_tags() (which is a NOOP
because tag->counter=3D=3DNULL) and finally call free_section_mem(). This
seems more natural than special-casing with EOPNOTSUPP. WDYT?

> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  lib/codetag.c  | 10 ++++++++--
>  mm/alloc_tag.c |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a3..a0b600720afc 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>
>         if (err < 0) {
>                 kfree(cmod);
> -               return err;
> +               /* -EOPNOTSUPP means we can load the module without its t=
ag. */
> +               if (err !=3D -EOPNOTSUPP)
> +                       return err;
>         }
>
>         return 0;
> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
>                         ++cttype->content_id;
>                 }
>                 up_write(&cttype->mod_lock);
> -               if (found && cttype->desc.free_section_mem)
> +               /*
> +                * A module whose module_load() returned -EOPNOTSUPP is n=
ot
> +                * in the idr but may still hold reserved section memory.
> +                */
> +               if (cttype->desc.free_section_mem)
>                         cttype->desc.free_section_mem(mod, true);
>         }
>         mutex_unlock(&codetag_lock);
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 5836803898ad..1ca0409b492b 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -988,6 +988,10 @@ static int load_module(struct module *mod, struct co=
detag *start, struct codetag
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* Profiling disabled: load the module without its tags. */
> +       if (!mem_profiling_support)
> +               return -EOPNOTSUPP;
> +
>         /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
>                 return 0;
> --
> 2.25.1
>
