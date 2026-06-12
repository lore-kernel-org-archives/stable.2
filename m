Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B23195FA
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278673; cv=pass; b=NuZbiYTB+6Ie6RZMzrwoPnPUtD9F+b4BrUiuWFJrkXsHc70xZjRlLmf6t6KGNtIRYY8MzFc9nLJZPLKasMz3ijaZ6UStbBZmPwItOheCJpo/fNWBJMNSI5WzVVtQotHKL5YbbCI0TKjubgQowLu2p2HyGcN4CYT0yR4bcqHER9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278673; c=relaxed/simple;
	bh=sca2+OHaSwvmv4TdnEhwiG9yc6DyrYXbEip5V4LFm7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKHUXTAGBhruXF7QGD1DbuQ4UzIeFMKr5klLGqom2+C71F4N7SUuXATbGqlmMa6RGEcHNM0iEmWbyg/totVIS6vhm7MtXzFayjBxYrY7a2GZ3UkQ3+IAcdFieUSv2m9Er3cborJThQw5Yq+7YHbjo0tYR4mRhqnGNJhtiBdxAiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQSz0Gt8; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQSz0Gt8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso78285e9.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781278670; cv=none;
        d=google.com; s=arc-20240605;
        b=BrHcUsV0csURJz46F6n2X970deVQQg3sohMtJbnorexM5vHGFXVb5Skk5MyNgFoaW6
         mQgH6hNoJUfpGXFqV/vAJH+MVCQKdZzIrqEwZsDEvSQDs963mT5oR1No6xeCeHelXRHG
         UmWHk+HAA6/7lFKsIqNSdjpSOCxapZox8Y0pxwItl6RWOsm4oAO/3QykhRUs3162d+t+
         8VFKUulbBRDXFQdHFWnULVHOQBXJH5KvCxpTBa63oJkMR6LhghJyfYiNv+q3LaQWwkft
         D4poanJNZ1MaP7ui1FEeLzLw15eNhoAfVU0tgLDkndsU1XoBS9Y/C3HVuKNoeoOOUP//
         qgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        fh=Dwy2bhdksGi9JTSTkIQSsoot5w87/EMd59UcwHlM4B4=;
        b=ggvNdfGtphTY8iLPptN4hu6bOCAmHHcYuTOoDzu1cpTJLxFsZ5KbavhntFFgXFJ0R5
         XqwrwEB+XMAVnTQ6ErB8xwBIY+kKYmEf4AJ2O25mG5CQX8zRd8UpuR0aD/eJpbzBVqd3
         2EVAYTYMkOZlwyQfamj1g1F7Plr7IDX39+MFMlDzq7BTb5lBnqxJFCgJACzxnxHs8qmZ
         xLML4ZYEwwrFJxH71TJx8w02Why3zWgsFJJAeae9Cb3/672w8UxIwmViHdjoCCtRNIoU
         8ZtYLxSje7Z5+adDLAorga0Knn6puaIFoAE3WjGD/UNqzm6rFORueg+cQXTHye/KEJNl
         fjMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781278670; x=1781883470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        b=QQSz0Gt8iv2MjKVzI4+ftvdjvAATd92/RM4nhAz3YJaFEsWrkf1b87oukIWGoknm05
         WBepZiX/lxVlgCTJqmqubSsEOY0/tsPX2d0o2lZqs08CbFzuHC+QtRdCAFLCr/t8BNhH
         BVj5RTwEK2hf2YowGBThIpm8d506AwfuDL59e+X+VwyqmnBfQfx28dxg66w4v7qHZxSj
         Qvb36fz2YnWc2mTq2Dnbr//aa0TwV4aLvlkB+K4aUhc1Li0Zr/N8d+jmGirNiem5zcHM
         dnGyGm+LpRfFse8hH5FaZWJZrffOEbMKqswfygAkpy2wfcM6GqW473D/2zr1vcWYvC0p
         o/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278670; x=1781883470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        b=OEgCgpdreAUn8oHSI1DMwBQMow5p6nD7XSgRnthG2OwSWHCc12sB2JM0RTXs53wZHs
         oRuP6lZAWTpZ6Ajfo9HnWi5iJCu2oIPx8Q2aXx1G3nApS+xq+dfWbiSPNx0Hv7trUgUS
         8Wbe3ntIxIKQrEBI8+wlL9niI1TM2n0AtHFHMCYO69UxvLhYMvNnA3COoZzW59KwIc3e
         qKUN+kuQ4bHhv2/kLhxr+qAh/PYLcv9GliLW6zPzZmy3Zo6uWQEqak870lyxGDWWOT6a
         KcY63cre3z8Ju6hnKgADeWHc8CR08U00l33WK7kvQxsjTiU9vkys7VjxHc3YFXBjrhWP
         uA+g==
X-Forwarded-Encrypted: i=1; AFNElJ99hpJBShyp1hEHXhetIYADtYsz+RHy29uLhM8GNg4IpVfzFAR9hLxGacOxTczoCGhZX2Hzdl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+s8UbvAJHTeg3VoCqh28XSHDC/5nzpdOW+Md2mIMFwq+8gBZ
	jOWZC3vE3V5Q05FRd6TKaucfzMSUQ3wmWhfvkH4+pHCKT94uO2EeBzb2+GRaZU6zUFyr04GiBqv
	+Ex6QwCdDtHS1FY0ZVlotUGqvTuHCFM82RvgNz+PX
X-Gm-Gg: Acq92OFn0zxyp+FdYWvHRLpXuEojLPuYgB795aLN11CG6gDiw/awOGmSL/ybXHD2xJM
	PZItvk11wWmLN1Ugx7NoBKzh4h2pYHNDzQ4KMezueWQgjTZ2Xz9iXkAzjD3X4Ev71ZtBSHbNqK1
	NrGE7KCE3W9bJw4gvAQsdB63dH4Y4AFd8R987iKm4p807lFw/C2TkaF6PWSDoNF38TEFWurdQu3
	1L/NARJHjn9l1nBuNCYRuVunwqCVDORkIhTH+z4u1V3VQDk7kqFAhq6Lh6q9iQrNkA6OFifY7HA
	CZcyyBY=
X-Received: by 2002:a05:600c:604f:b0:48a:623c:8859 with SMTP id
 5b1f17b1804b1-490eabf8ed1mr791455e9.7.1781278669647; Fri, 12 Jun 2026
 08:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612035903.2468601-1-songmuchun@bytedance.com> <20260612035903.2468601-3-songmuchun@bytedance.com>
In-Reply-To: <20260612035903.2468601-3-songmuchun@bytedance.com>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 12 Jun 2026 08:37:37 -0700
X-Gm-Features: AVVi8Cdc4B9DOI5h_B7aQcyBPFaEKb3BaqoI3DRKTY6Pl2XtpJFskCaA7xImrJI
Message-ID: <CAPTztWYx-_A8Jq=U+OGA4y0LUWkKWJxutOzyHJ6FeR+C2gj0JQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:59=E2=80=AFPM Muchun Song <songmuchun@bytedance.c=
om> wrote:
>
> __hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handlin=
g
> bootmem HugeTLB folios.
>
> The section number passed to register_page_bootmem_memmap() is derived fr=
om
> the vmemmap virtual address of folio->page instead of the folio PFN, so t=
he
> bootmem memmap metadata can be registered against the wrong section. The
> helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it expects =
a
> page count, not a size in bytes. In addition, the write-protect range is
> based on pages_per_huge_page(h), which does not cover the full HugeTLB
> vmemmap area and can leave part of the shared tail vmemmap mapping writab=
le.
>
> Fix the section lookup to use folio_pfn(folio), use
> HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages,=
 and
> use hugetlb_vmemmap_size(h) for the write-protect range.
>
> Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb_vmemmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c713c0d2593a..ea6af85bfec1 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -635,12 +635,12 @@ static void __hugetlb_vmemmap_optimize_folios(struc=
t hstate *h,
>                          * mirrored tail page structs RO.
>                          */
>                         spfn =3D (unsigned long)&folio->page;
> -                       epfn =3D spfn + pages_per_huge_page(h);
> +                       epfn =3D spfn + hugetlb_vmemmap_size(h);
>                         vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio=
),
>                                         HUGETLB_VMEMMAP_RESERVE_SIZE);
> -                       register_page_bootmem_memmap(pfn_to_section_nr(sp=
fn),
> +                       register_page_bootmem_memmap(pfn_to_section_nr(fo=
lio_pfn(folio)),
>                                         &folio->page,
> -                                       HUGETLB_VMEMMAP_RESERVE_SIZE);
> +                                       HUGETLB_VMEMMAP_RESERVE_PAGES);
>                         continue;
>                 }
>

Thanks for fixing my mistakes!

Reviewed-by: Frank van der Linden <fvdl@google.com>
