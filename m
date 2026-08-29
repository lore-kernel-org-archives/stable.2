Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5639E9D5
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014247; cv=pass; b=Xop5UWH0EPThWopiL04H+R9lvDjCTnatbVrTaw4ztAhzsrdr8JjJyYHy7JyXPOMbk9QxjD96Rxc24W5zLYHwiaTnL177C46NmUro3qpl/CMfGjLwKyKAwXX6kEUJ9/cwwNPv6WAaeP2LN9hdTkWblAMJ0g+/5lcvRynK8j0cvAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014247; c=relaxed/simple;
	bh=MgA2NGVooXkzTgVF6+l0Vmm7WuBIDGGtn85djZqTNkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTExkk4pny3huvt6ROsl1rgK7yTlRzPVCOuHIoHoC860qiOQgJFjLO8+M3BY4XmZV9kDWpbY5zMt8x/1DFwUyvM8GAA8ErkCyVbfYIribI09GyaJfL203dz3hqCWmlh2dKU7HPGN6sHZA4aQ5HuaovtqP9nNn5ZxlxJnnSWoIcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEjjXMtX; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEjjXMtX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so17053575e9.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 07:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788014243; cv=none;
        d=google.com; s=arc-20260327;
        b=SxX719QUq2O1ibXyCqU/MXfzD3rTgf4kpbqmqlIEK6zia1GpSJor+MAgvb8z0HHcCU
         sdHTImHfNpfZwUiziIvJb7HEw6lkbZItGWsGPOK4tShtK9hTJCpke0kBUMXSbnItCn+5
         fAcWRJuU4gv8Z8xDH8Pa8tm8jgoAroY0V2O5+r48XatL+2JwBe2Dwo/x42r5NtnwWy5Z
         0ZXz0e7LVA8tksxgHbONMCyXn3SCpMGnx4JgXiJ0T+bOb9sDTcsg9WO4u2EcmiWaKCno
         cCa6SEsdIaYhQ2CFg0TLQdy1rPejIv54bZfHNt2HqunOlYBBz/2MFSZA+xkIC+0UNJKd
         rzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZ9OdMIWwS+HeVefiMGtXz8F2WL73A/c0lBq2ihg7xE=;
        fh=vphvZOlCCkUKJwRBwTaDVs6pSDY4fC8WY3nQUQSFNSU=;
        b=jGy31fRP8WkwauxE1RhzV952ItcgiSOGH5rXzKcfM1ch1aaXchUKbodMZ9TokhRLRs
         PN5vplSZCHHmrX3SzdTDVMdp/kCGWtNfQTrtYRSj7Xipsv/M2D7oa+Z6j+Jw//cOD0XV
         sjEWAGtPb/mkC0kvc839CQq7legavjxOQPQYpFta5eCFr9MA1wFY4bZQ35T+1JaOVVtg
         Lm3yBajQ04KiVYtuQ5Y67diu/sDWqXwGcetP+dvfp0XwpfyFMpf46lhoaEZ7+qe6OsBy
         m2tofTM7ljCbSV64CoVqsCpWxCX8CoW1GxEpIQo9ArNBD7B2tZUIeKO6VlZa+clLe50h
         19ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788014243; x=1788619043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZ9OdMIWwS+HeVefiMGtXz8F2WL73A/c0lBq2ihg7xE=;
        b=kEjjXMtXu39pMB9C5faeYrlg5lKBrPZ2ravxMQuZnrLbuCiJWblFeFmLDryjUxrNgz
         u1DesDjOgH7iCZC6MM+1hUWUODbkgj0bdo/YcctesxGHlbd6en2R/V3oTeQPDaTLegmV
         XuVrjcaiD412UIEFYbJSjCv8Etuom0zDzQzGvRLKDg20AVqDcLfBGjg+ZrLShGYoyhBe
         6c5fCS/pRG2neBzBkWSUPP+iLSIAt85FEh5k4pNUbuTo4oIVwbZrF1M2ZolEjLJC9rAR
         kuqKjsHijkrwBRjDmK0hpnaHK/8EioyHey4J98NHfaK0ndp0yvQHRsW0OOtZNqCtjAqL
         6egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788014243; x=1788619043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZ9OdMIWwS+HeVefiMGtXz8F2WL73A/c0lBq2ihg7xE=;
        b=ZT4AosbEkQBKqVBdh7yhyq+RjKsjDL+rtY09EHuk7VRlIM6fUCZWcxqRq+dQd8KRqZ
         zdWhLiIJfPKvBadfZZhmMVBDvjezfyWxRKqdjiFsQ37BekDA0JuYyu75Mevhs5hpIu9N
         CEEQpAUqCx+6fOtjffxTy6mSYkrWj9sJlhMpUEhABnlT2yrBqDbJZkDm28rXm46wZbf0
         4TwwuPlltY760bDbYT0dGAoeUz4hQs6/H8cafp3Gke6qKCVhRhjkV/U2f+3PXL3cNhxQ
         ElEkYfKRKiO0JHLKokF9Ce6+joxDpHlmisu47WUYw74jzfeOLlVdl+600lNneTWV2KkR
         a6KQ==
X-Forwarded-Encrypted: i=1; AHgh+RraK/DPnJpu0ejoB65zZmodCOZHjf757h7rVCYeZZgmU33zRdu30Ks/DYSA/ruvqv+gn2VaYNY=@vger.kernel.org
X-Gm-Message-State: AFuF++mz0yfiZxOjTPBZ0AErzK7HWhuvkNBbEQGKdTI48F6yNT78Rlto
	fhLXpsXt9UQwdfpCKvN/Z5TmEoThFZXAYBgD/l0d96jNgIz51ynnbctNOsii9cL1ZZkCE9ydB48
	dZMJYh7nKWVNW/Uu3zOSfDkX+LSPr8CQ=
X-Gm-Gg: AR+sD11VPzFUGT3prqVH5OdgXM5RIJilACCmp6aTduQROEd4qsd0I+dYtuByIX0W7Ns
	lcTmZmcPwz4v5Y7BxIqpXHVZAAvUFnSATLIaNuby9lmn5+aSO4+7gLJ3/Sx6vJ8JIMIbMDfTFDx
	e0w7ng77JKKLxjwJb/2osdufHqgUXaKapQdexYsFdqUWiVxSeKep7dCGtRza6zNI6iScufwbxZa
	vLT6UCUbI8QdNgEzRJERZwvE5jtLc8H4bDXlIu1jqZplK00tkCPnrfbqkSv/MudLEjpUdvw66oP
	nOQUGD3zeOHnWGRV9BC5qayi09Jx9JUB6SS4l49df+VIX/0=
X-Received: by 2002:a05:600c:190e:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49cca2b74a0mr76687805e9.2.1788014242555; Sat, 29 Aug 2026
 07:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-mremap-fix-locked-vm-v1-1-c80be7505d1e@kernel.org>
In-Reply-To: <20260828-mremap-fix-locked-vm-v1-1-c80be7505d1e@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 29 Aug 2026 22:37:11 +0800
X-Gm-Features: AcwNN1VHoiYexiUTsHD52g-4kbK1C6nEM9rzNia-_c2hFJVdgL6ptuoVUWOQi4w
Message-ID: <CAN_Opa9CZUTUyvveTnVXK7Wy9Xq-9wc=QkASceLv5hTE-NiNnw@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: account mm->locked_vm correctly for MREMAP_DONTUNMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

Thanks for the fix. I agree this is a very clean solution.

On Fri, Aug 28, 2026 at 7:20=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> When a VMA is mremap()'d with MREMAP_DONTUNMAP set, that results in the V=
MA
> being copied, but the source VMA not being unmapped.
>
> If the VMA is mlock()'d this is a legal operation, though the source VMA
> has its VMA_LOCKED_BIT cleared.
>
> However this is done in dontunmap_complete(), after mm->locked_vm was
> incremented via vrm_stat_account(), resulting in double-counting.
>
> Worse, this is not even corrected when source VMA is unmapped, due to
> the VMA_LOCKED_BIT flag having been cleared.
>
> This all works fine in the usual mremap() case (without MREMAP_DONTUNMAP)=
,
> as the source VMA is unmapped with VMA_LOCKED_BIT intact, at which time
> mm->locked_vm is decremented accordingly.
>
> Resolve the issue by invoking vrm_stat_account() only after
> dontunmap_complete() has run.
>
> Note that MREMAP_DONTUNMAP requires old_len =3D=3D new_len, so no need to
> account for a delta in size in this case.
>
> The bug was introduced by commit b714ccb02a76 ("mm/mremap: complete
> refactor of move_vma()") which incorrectly reordered the accounting and t=
he
> clearing of the VMA_LOCKED_BIT flag.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260825-fix-mremap-dontunmap-pgof=
f-v1-1-39a40b2c98b3@kernel.org
> Reported-by: Kunwu Chan <kunwu.chan@gmail.com>
> Closes: https://lore.kernel.org/all/20260828094823.594279-1-kunwu.chan@li=
nux.dev/
> Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/mremap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 2b4b523a86b8..7c368440fafe 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1355,12 +1355,11 @@ static void dontunmap_complete(struct vma_remap_s=
truct *vrm,
>                 if (vma_is_anonymous(vma) && !vma->vm_file)
>                         vma_set_pgoff(vma, pgoff_unfaulted);
>         }
> -
> -       /* Because we won't unmap we don't need to touch locked_vm. */
>  }
>
>  static unsigned long move_vma(struct vma_remap_struct *vrm)
>  {
> +       const bool is_dontunmap =3D vrm->flags & MREMAP_DONTUNMAP;
>         struct mm_struct *mm =3D current->mm;
>         struct vm_area_struct *new_vma;
>         unsigned long hiwater_vm;
> @@ -1401,10 +1400,10 @@ static unsigned long move_vma(struct vma_remap_st=
ruct *vrm)
>          */
>         hiwater_vm =3D mm->hiwater_vm;
>
> -       vrm_stat_account(vrm, vrm->new_len);
> -       if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
> +       if (unlikely(is_dontunmap && !err))
>                 dontunmap_complete(vrm, new_vma);
> -       else
> +       vrm_stat_account(vrm, vrm->new_len);
> +       if (!is_dontunmap || err)
>                 unmap_source_vma(vrm);
>
>         mm->hiwater_vm =3D hiwater_vm;
>
> ---
> base-commit: aeddb4d52acfcc5ce5e988acd48f2906fe966ca3
> change-id: 20260828-mremap-fix-locked-vm-b8991ffc4181
>
> Best regards,
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

I tested the patch with the following tests [1]:
1: test-vmlck.c =E2=80=94 Andrew Morton's test for basic locked_vm accounti=
ng
with mlock()/MREMAP_DONTUNMAP.
2: test_mlock_onfault_nofault.c =E2=80=94 MLOCK_ONFAULT with no pages fault=
ed in.
3: test_mlock_onfault_fault.c =E2=80=94 MLOCK_ONFAULT with pages faulted in=
.

All three tests passed with the patch applied.
Tested-by:  Kunwu Chan <kunwu.chan@gmail.com>

The fix also looks correct to me.
Reviewed-by:  Kunwu Chan <kunwu.chan@gmail.com>

[1] https://github.com/KunWuChan/vmlck_test

Thanks again!

Best,
Kunwu
