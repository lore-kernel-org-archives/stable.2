Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618613BBA08
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944092; cv=pass; b=jolbwfhl+au+dlfSCKek4PP99c9SjWxMnmVZEwHKncB2HfPJFNaVWYTbPXu5J90wdvg7jgkKt7OVxPpLPOXLB81WyrOTmVxt6tBj6jAybGiKB3E3wn7LcnAbQtcjOG96JxZqnRhofaSpOtqL6jcYWHJdl2W4F1rnKIY/FAcx/As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944092; c=relaxed/simple;
	bh=UTY7n5mWKlgU6mG7lT+g+x29Ur3pE7Cfj4pLQ1uLVVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ9v2Il9qMqLEZjdfBprAeW+AjmcjR0XtozF6bD+d9eA/lHPmauzNl49z1v2ZRuntZ7JLaDLHMovkM39C++wOBhzRFdOUvUX06T6wWZ2LANReZBcsav5VO1xWfsR+NTyLQlHhpRV5Ww7B+Bii4lEGdLnqeMsGjnpuCEs7fs350o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X854PUOV; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X854PUOV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so4010288a12.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787944089; cv=none;
        d=google.com; s=arc-20260327;
        b=pfFlwSx0wQLWZoihJTeInl3qHb2WHH2Da6PN1qLRTD9Ncl6/qaTZ4YF8oM+z6SSZUS
         OVCT4++F8MY93SJmzJlcWREMxkFWuDp12C6E8bwODPPxhCHxcPpmnSirnFY6Yb9EUUQK
         WOsP2QB03YEI5t8z5xff0rnRHvrafwbel8LHE+lIPcrGNZ5/ZJ6Gvb6dKaDl4+xybOwV
         yxSE78fWn2nVpGgRJt1gt6j3E18affaqCytZ23uxux8qD/YuNATiUFsZYHPHkCQj60yB
         nM2JRVDOkJqA4cBr0RsNOLREBbUP7aNFyOYVgZFADB9+rUSAX47eHZAL2evPJx5Ki2Uu
         gwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TaAS1sNmEmRB6xGut3oqqD3PYBl5B8b35AmgUg5X4uw=;
        fh=JADlPfDzpkP9eKkktsCjSBV2owzXKARR2ifoqbKc7R4=;
        b=E6ddpPQAu9liN3nhjzOUaxyCe6Axmo1F2+ABXraF8BcdGU2BnCduCu6nQx+NixcWuY
         2oHuUKGq5XL0ZwvAzuHHz1YyLReGYGA6aGf4KSg2hOci4W7mc2MLmaz4SlS+R6COpZak
         21zIUHFh39ny7PiLp1I8zRPlcIcuBCz3OngvHKM9KYYmgALIVo0BXzAjYBAnqxNmS9XL
         QB6yvkA6i1l0H04Z3Dpi5zABsCv8YLTnaPL/mkiMu1G2z7bXqUyUuEcpydjc4DBcfWJL
         r83kHxTJhKisX2mG9XrsUq2yAMxoRzgkn7D3yzJuUBGrVsHj1X0m2kNtfuyk9QTGds8w
         IdIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787944089; x=1788548889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TaAS1sNmEmRB6xGut3oqqD3PYBl5B8b35AmgUg5X4uw=;
        b=X854PUOV/zQ8nqoMO9N4Ia1q8+8tSYRmoU6kU8C7AYazOmQLD+/lkrn78fF8ltJm5C
         gLjenKDKfby5HF+9JUT7j/pJvJ774/ck1vKxhYaBkW9P0w9D/KL029FwLjL266tY6DHL
         YNfzvR+QMlEnTO5wHsmMtcgeRZsCHZCuUmxBniGWINOn4JWyZEUL6EhwkD1fVAvVvLuz
         sOZwfjjO36QMwPzVg6GbaqEgZXguTNm9etT6M9zt6QsbxJpCSn0nYszyK12VNSGVY8Xh
         af3jziV3JeE1fC/XLGKcdOgt2TtIilAG201xWNdN1kIviWkzYR20TTLxVG+hFI1Dn+D0
         h/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787944089; x=1788548889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaAS1sNmEmRB6xGut3oqqD3PYBl5B8b35AmgUg5X4uw=;
        b=GN126azi5CywZsZtfR8RqIaKXZxh/l33DpLKMhbyUSrk9tkWWTYTOHzxClKvHKT5PX
         1PQXBCBqiyi3UeXbgBKL6I20KT0lCs048hCaQRZgVTPeNtEI4m9yYGmAiZrGHdIvlf+l
         labVvTW2zGSAYwfAMi6ECF/iwi1Y7A24T7A36cR7EWJ7uVncokyNp6xfRFUuWucgPj/+
         URUEXhPyV7CKgP1+ozfsUif9MFPIfZJROAQ045bMT1o2tle6cco15mezyrwAySF2kRHA
         7jYq7KvcNzbWKs9Mjx/pOKHUzBdV/brjidcQOwFcTw1KiBY4Am05GlxxS29Uw7aD+7BL
         n3ng==
X-Forwarded-Encrypted: i=1; AHgh+RreEAMBgD07ugn671MD+xjbMn5+6lwXV95gbd609qDRZHYSi1demdzdNH/mPqQ5uVJed1Snzv4=@vger.kernel.org
X-Gm-Message-State: AFuF++kbgO9oVQaIuAQbu1KEd6KtkD27x2SyYShypz7d8Q/ZJR8/KdKV
	cUbs3TTrEyxeizQluQw1b0snNPO+OcCB0aIb25FhMp2enre0KNbxlqr5bqeOVuTbdmWCWD6EZGU
	eGyi8IKjCWgg0NXDWgkaNtbQ3I4+Xkz8zJ8V5dJD4
X-Gm-Gg: AR+sD10j057+BTPbEuwpEikNMJ5MhXLHCF809Xt8hxJoe2TgohXdKRxNTDAsYcVbRB6
	1MYGsfG18z2jI+keMe721T96NhKqhwT+hGAkFMc9+TvI0kw0D5GW4mu8dDPBB4XTAetmOVGbETB
	6zUDmHjOViEKpoai5V4MQlWntFarqsJ9jO8kWRK0mrDSpJMiJU9T3LfLd9sVkNRo5j+wlHmafZ3
	L7RzH1gA4rzgRgDm8wFNM0LhxBYy6zmuivTW2S5ycDupp3uKrRtreVPAt8wL5ddTgdrl9r5ugdJ
	vcS8qSNkm6odJyUhUmExkySJoQ/PV8caydL/THw9Vx7/Yd8b9RpIynsyk4CKnEZANMl91XyEx8P
	tne8i/QGCNdovKHhri2zc7m4uNdfBmshtj7r1qDmhbSMut6AyaEpqVNSMHPp94XLlB4j13KHGjB
	e1T5b5SMvFtbj0
X-Received: by 2002:a17:907:c8c5:b0:c25:3c3f:22dc with SMTP id
 a640c23a62f3a-c253c3f238fmr1089282266b.13.1787944088979; Fri, 28 Aug 2026
 12:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828005004.2870750-1-jthoughton@google.com> <20260828094703.11081-1-lance.yang@linux.dev>
In-Reply-To: <20260828094703.11081-1-lance.yang@linux.dev>
From: James Houghton <jthoughton@google.com>
Date: Fri, 28 Aug 2026 12:07:32 -0700
X-Gm-Features: AcwNN1UeBlJNZQTScnpGSIA84ceVmmw-Znp9Pros_d_DNJEw7LyIhxNwfMF_Hy8
Message-ID: <CADrL8HX+FT4ymeNOKLPQ+vE7HLMRwjdDJX=KjdqgY0f_YhmSiw@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, usama.arif@linux.dev, shy828301@gmail.com, 
	zokeefe@google.com, hughd@google.com, kas@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:47=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
>
> On Fri, Aug 28, 2026 at 12:50:04AM +0000, James Houghton wrote:
> >Userfaultfd minor faults provides userspace with the ability to manually
> >install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
> >map holes in the VMA when a naturally-aligned THP is present without
> >explicit action from userspace.
> >
> >This is a problem, as it bypasses userfaultfd minor faults that
> >userspace is expecting to handle.
>
> One basic question first. Should MADV_COLLAPSE refuse to collapse a
> UFFD-minor-registered VMA, regardless of whether all PTEs are present?
>
> I'd leave that to the maintainers :D
>
> Anyway, assuming the answer is yes, I wonder whether the new check is
> sufficient. See below.

I also think the answer is yes.

Theoretically you could optimize this and allow userspace to avoid
calling a bunch of UFFDIO_CONTINUEs and instead call MADV_COLLAPSE,
but let's wait for someone (probably won't be me, at least not for a
couple years) to ask for it. But khugepaged's own collapse routines
(and potentially other processes via process_madvise()) should remain
unchanged; that would reintroduce the bug being fixed here.

> static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> {
>         return vma_test_any_mask(vma, VMA_UFFD_MINOR);
> }
>
> static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> {
>         return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
> }
>
> Emm ... userfaultfd_protected() only covers WP and RWP. MADV_COLLAPSE
> passes install_pmd=3Dtrue, so the SCAN_NO_PTE_TABLE case can still reach
> set_huge_pmd() after UFFDIO_REGISTER_MODE_MINOR has completed ...
>
> Maybe:
>
> ---8<---
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 33c41bc32af8..0eada7265d59 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1893,6 +1893,8 @@ static enum scan_result try_collapse_pte_mapped_thp=
(struct mm_struct *mm, unsign
>          */
>         if (userfaultfd_protected(vma))
>                 return SCAN_PTE_UFFD;
> +       if (userfaultfd_minor(vma))
> +               return SCAN_PTE_UFFD;
>
>         folio =3D filemap_lock_folio(vma->vm_file->f_mapping,
>                                linear_page_index(vma, haddr));
> --
>
> With that, LGTM.
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks, Lance. This is how I should have written the patch to begin
with. :) It addresses both comments that Sashiko left as well.

I'll send a v2 soon. Thank you!
