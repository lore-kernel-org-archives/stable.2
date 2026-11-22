Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795318494;
	b=HzJplQ6HURD1GKPKUwz51xDOesXQ0p/jidAkSfkKsZOUHw3Ua336cTqHuWmvcXPhmyEX
	 S//msyUzCcbb7KaBkMk5s8iJr6Jt/5W+Utfk2aFNi/CSCTR+Q+teTenLC1aE/2lI8oEXu
	 qxCym44lkU4PacXgQ0vzI/iiNsUrchzhCBjhsdCkI25BXR6KZHROMIxhDTNZK6Nc2hZep
	 V6fbGOUUf+kvf5D7CZgdO5AM6k+H3PWSydMbLaWB5ZZSwGe59KzsoJiCNQNr5ibHi3tR9
	 c/6D94DVN25hnD4ITEcNF2HhCXRNaAF+Ytz4BaZaqk/W8U8U0Oc/BebQng60tY0JfJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+arqdc7YBoB64Vn5DbGyaeiFfyImnvCCTd6+VOMToaU=;
	b=Wh9QBshbaQcdc5c4sq0peeG8Hkpp0VHlT5AyYlFf44cxddOzHbjKZACj1eoU4aW/1PLE
	 VGNbidY01XGSXmy3Wg9Vf2EwGhh4+kB4Zrj7rJwXdCQBXQjZenkX0dFbOOV39DenI6UIb
	 EPhy0AZSLCUjzZlEfOzO5vNfejaozm+zbc8IqRF+/vBXZUKPPy8g5j6PGe7KiGmtdxbDy
	 euseZ0fAbUgFkqojZZSz2/45GjKFhhfA3xL2oej8ahhpFJ5px/J6HKJo/uAcr3sZXpWa1
	 pB6fQkLgot8j/osEORsR5FAHRhK1QPyi4RjnSX9nm5OonYIa5mNR+Wki0VliMPOT/hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BZh7YZ8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94567606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94567606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BZh7YZ8a
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-54492d8a988so215171cf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795318492; cv=none;
        d=google.com; s=arc-20260327;
        b=OQwXsf7xlfIC1K//uG6xvJae0mIPHv07RvgqornhFkMdEf0pQh0vyC62a5aM1DYocm
         +lXhjXaogEogp/WtgceHms2D5HnMq6jHyc08bXKLUXF737HREqPP0Q0/Mat5i3ACs8Jl
         Jy/JvLKy4LycS17oT9lclwKsnmPsseMkJGHz92a1SB4zTpHQsdafLBj7vTxxmPrmY22U
         zaCees7qaWU1TsKFrdqQyit8cvBot+QHgxJ6bGx01VqjAJNX7sV+j4GlJrcbXpE556N3
         aetcUTOhV7ko0UiI3YXRvE0ajv+ZOyInmPuH06XLKBJlEju3tTpsuW+MUPqVZlUflRg/
         kCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+arqdc7YBoB64Vn5DbGyaeiFfyImnvCCTd6+VOMToaU=;
        fh=rvVEJO6kUQHQksuhhaEX0QNWEYzXSZNbaQvlAjz1/p4=;
        b=ruPVgPsbl9XkgUxZV9Yv9P6lUZOMT4YHYtgeKm5wxHqd4wLMskMygsra9ccoP/BqZM
         UnDuu9p87Stx8/RwHtqX2CnAbqorQV5p9dFAmhmsuosXEKhb/QKkBA8qMW5GiTP3IDs6
         JG2wqUCO285Yy23AfXh9XUWOEpy4Y2cojLRXci0PKjBEye0+50+DXiFP+B97HYbT2nYT
         ihQFS/Ohi5+298C/4zuqFkUz4YAHOcJTm7uoxamI7s+BI8VFY7iRDjBvT5EVFfDFziiB
         65sunnb/HRXCpozQ0Y4X5/yjLEV3YcHFEHyoH6NI9WBaVPNTReemHLq/9q7Qr+rU8dPS
         Jyig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795318492; x=1795923292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+arqdc7YBoB64Vn5DbGyaeiFfyImnvCCTd6+VOMToaU=;
        b=BZh7YZ8a+Axw+NuW1A2J8CzdyE1lZ+cdPZmj59+4FeGqWkqcCOnCOTwrsrGWNonqpn
         sPZhPP5mIQSoyKFTdCQS+evpNTpHHrDF8VAfKmvRd2oD15abLZNOCiDXttIoK6dvMHIG
         rRtXoIJ8bPoyS5p6i/3BJhi073EnFfOViWZm5Fa3/RO3WBVA+otoqjDkhNpTzS5BCXrO
         EMNCnWxDOPbCl8YyPjIHYfRWwqr4wayQIgfwKAjoV7++iNJppQ450q0nGKJmIE1qXpru
         7feIEqli1unkyXUa3MgkxuztPEbuvYPAZDuJqw77r3ZjM64qt8Zgg8WOZzuJ541THg5H
         9Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795318492; x=1795923292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+arqdc7YBoB64Vn5DbGyaeiFfyImnvCCTd6+VOMToaU=;
        b=x3t2g+RoBPcAV0HUj9foihGvYerepB8DZWyDPKga2kj3rJE3+qvAF8EUmgsm2H1eHi
         AAihIicxI20K97LxnoUlHuVAzu98lNoXYHdr+FAVbGEpbD2dqluO8MkvrKssTO/pWRqM
         zTqYLDFGlphAoitwvVXdZGr4CFN4XjyAyDTK7BmAgG4dqsWc8ahnzg9VzwD3yBjErRJw
         kOb5AscqlJDfb9kXk3WMrTrBkCGEMGEnqv8uKZXuuENkNJVI+g9kvM1R3ULzOObhvH6u
         L+lbK6DyESVR/9iCN77Zzs9GHWLSgFD+3iMpUal4LVLrAagRNzLHXwPenlkj9Z4okrfA
         w8bw==
X-Forwarded-Encrypted: i=1; AL+hErHAUhvEe7PCHmbADE/6fqIwNUtZjio/+0tNbuUiBAu3eir46jpLWDNTx9znmMkIxsDJInuOmNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/QqEKKssKfWiEe62+PfksrUVjc9P1sX+ksArU3Y9PpKrGefiE
	gXYhTmcaL+RwF+Fw5iJVvJlS4g0GQgDz2tfLYi0xKlN6WRNvzFD2rUWtyOzEEMK1KjYNJfyQSsR
	fBrIDjS50M4rWAEzK+zhYn3vYrLf6yESIDQyJUBun
X-Gm-Gg: AZFdTZcs980X903TiIQf3ag1JFBJkyUgWUetM2Ae2415SB2TO3OdKWS2FXnp12Znaw6
	XRVG9SrAljfs+/WNl1GV7ZLC2sppU7r6oMWHxWyzwa295fbdbYy1X+2rri6BmmYMPUUssPO/Y5h
	2gG0zKhWQeOeuNmxNfdciA/uY2CX72pe5Z5TbHz17Y51BBzDXF8ZwyBxIIXbxEysRU9dS7TH/ro
	wk8XW0BEfSr1gWP0umsKtyExeSK9mYr3hJ+2Sxt8F3TMEqfsrW34whIGf3W/F9Ruh02aaMJ1h9y
	q8xZ4+Zr7+grEHITwf9eQBFH2XjxxUnmyMq2c7hYt1nv+nqw5tNgSQDxsHLp9bSEKRCqNv3/moI
	lsMI0FGs/Vw1cqnHcMUd5qod1d2d1zs5+ySXclwrjnryAhbRhrkmnhvbXW8Zy+pmgo7Q5mbc=
X-Received: by 2002:a05:622a:1f17:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-55d890644camr16243611cf.14.1795318491908; Sat, 21 Nov 2026
 19:34:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org> <20261121-some-more-ai-fixes-v1-4-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-4-236e925d9b64@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:34:41 -0800
X-Gm-Features: Aa3M54pDb_dgj_Fs32ZEZae2DuXiVzBHiwxoPTSr9uOCmICIMPOaQKf8n_YO330
Message-ID: <CAJuCfpE8Vz2sM=q7gjAjk3V5fboqKUA--ohLYmA4ffE4VWM4ag@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/vma: fix uncharge after failed stack relocation
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ollie Wild <aaw@google.com>, 
	Adrian Bunk <bunk@stusta.de>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 8:03=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> An execve() that fails to relocate its stack can underflow
> vm_committed_as, and the commit limit of vm.overcommit_memory=3D2 then no
> longer holds.
>
> exit_mmap() uncharges vma_pages() of each VMA with VMA_ACCOUNT_BIT, so
> the charge has to match the size of the VMA. relocate_vma_down() expands
> the stack VMA by the relocation distance without a charge, and relies on
> its vma_shrink() to make the two match again. But it returns with the
> VMA still expanded if move_page_tables() can't allocate a page table,
> for example at the memory cgroup limit, or if vma_shrink() fails:
>
>     relocate_vma_down()             charged    vma_pages()
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =
 =3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                                     L          L
>     vma_expand()                    L          L + shift
>     move_page_tables() fails
>       return -ENOMEM
>
>     exit_mmap()
>       tear_down_vmas()
>       vm_unacct_memory(L + shift)   -shift
>
> On x86-64 with 4-level page tables, the distance is up to 16 GiB for a
> 64-bit program, and about 128 TiB for a 32-bit one.
>
> Fix the issue by giving back the charge of the stack VMA where its
> relocation fails, and excluding the VMA from what exit_mmap() uncharges.
> The argument pages of the dying task are then outside the commit charge
> until exit_mmap() frees them.
>
> Fixes: b6a2fea39318 ("mm: variable length argument support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma_exec.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> index 586c52155942..84b98f1a201d 100644
> --- a/mm/vma_exec.c
> +++ b/mm/vma_exec.c
> @@ -45,6 +45,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsig=
ned long shift)
>         struct vm_area_struct *next;
>         struct mmu_gather tlb;
>         PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> +       int err;
>
>         BUG_ON(new_start > new_end);
>
> @@ -68,8 +69,10 @@ int relocate_vma_down(struct vm_area_struct *vma, unsi=
gned long shift)
>          * process cleanup to remove whatever mess we made.
>          */
>         pmc.for_stack =3D true;
> -       if (length !=3D move_page_tables(&pmc))
> -               return -ENOMEM;
> +       if (length !=3D move_page_tables(&pmc)) {
> +               err =3D -ENOMEM;
> +               goto err_unacct;
> +       }
>
>         tlb_gather_mmu(&tlb, mm);
>         next =3D vma_next(&vmi);
> @@ -93,7 +96,20 @@ int relocate_vma_down(struct vm_area_struct *vma, unsi=
gned long shift)
>
>         vma_prev(&vmi);
>         /* Shrink the vma to just the new range */
> -       return vma_shrink(&vmi, vma, new_end);
> +       err =3D vma_shrink(&vmi, vma, new_end);
> +       if (err)
> +               goto err_unacct;
> +
> +       return 0;
> +
> +err_unacct:
> +       /*
> +        * The vma now spans more than was charged, so exit_mmap() must n=
ot
> +        * derive the uncharge from its size.
> +        */
> +       vm_unacct_memory(length >> PAGE_SHIFT);
> +       vma_clear_flags(vma, VMA_ACCOUNT_BIT);
> +       return err;
>  }
>
>  /*
>
> --
> 2.56.0
>
