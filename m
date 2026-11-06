Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793948854;
	b=xzkSqYS246YprdDSOVsQVW9HmjYTeR7jbRLYGK+byVYkUpluFGPHdH7YiUi3tzcq7qdR
	 /gukSFTYG++ss/ADQgMZ91sIEuTkHwZTDh2G8WO5r+FhMOpcrRwPATCD03i74mAfgkv+8
	 ALE1Al/4m1Z+Y6Aqobd1FygorI1PpUkor9H5Tq98cf5QwTyMpeVfMMbeXsZafeF/GC71b
	 X6abfsYmeIMq5aHX0Q5+KR2p1Ye7kbg33sH+l9hFdy4OLAcSrYJ1Vn0ZhlNef63nsv8cZ
	 VXv74gXxtrMso4EHq1t4/vnkpS3uc+F4YT5Lgaf/DsQ0R4KabXrJWATD7MK/rx+pBgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SyAT3kgnB5A36GtJplToXCiU6rWfBoePnhWMVO882hw=;
	b=38LMM8W2KK2eT4W6O7nhhaQl6ZB/xrgw0SE4muRA6XqaPauZrlbpQtbVrlPAJU92IFgT
	 QyuV5NBtjFDurG0duCHhEjfqZgSBM4HSwYGVMSgPaqYmUF1KjEWkdygViGH20w8RsaxLR
	 yioxWKTdyLx/ALwCeTgr79swGsgzUunXQT06yHOKdnfTzIplD45k4XYLbwE80K5KmcWgi
	 kDlUPLbUnOJEWuRTK3M7UXb4owbbnSsd3ZKxDQjWMmBpKYgQt1kscqDucN2V6iM3yv7/T
	 1ltlG27Q++7jzsAzJX/7NKkK/qSqTnk9e5HMK6kYOYFZmpOt9LKdV+nvXaqxaKHRiyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ac+lalS2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10D606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 07:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F10D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ac+lalS2
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4ced671398so31639266b.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 23:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793948852; cv=none;
        d=google.com; s=arc-20260327;
        b=oggwNwv4KIVCnrOhjFO41PcWByMPDreSycXL/Jl5Jssxna/vDyP0lKp5wWdge51Hn1
         7UT43Inp7BGk2aGq0PQUQ2kZDRbmEWgfbwP32YYI9VddI6h6fmvnUo6mP9MwQnJFmjL6
         Fn2QcRpQqk3CuA7OBJ4ZRerdDoRZGxXhahERRcL5Euxf9kGRa4IAbS6kd2Q+wGP5CAH9
         JVGFxKB2pfDccKaQT+Y+qvbOMpPgoFW2G7nmP9IGK3kjrWZRYsMjkcAMVIM5xyCxIM/9
         utkUEBBpp+ijP2GKMi/d2L9HyFa1pruiBCOJLsXqmS4qYdmio5VGCkeqMaHLh7gBKhQS
         n80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SyAT3kgnB5A36GtJplToXCiU6rWfBoePnhWMVO882hw=;
        fh=t6F72BeDzh4TuM6facedPvBlTBP7Xb3YKoxhbuzaVaQ=;
        b=dYUnnU4lIF6l9bGUfU9yJrmYmzsEptJC9SxNCbODd89n2Uaz0PG++cWmB1IQk1aGDV
         kFFT3wJfVS7jrdHwHthZGt0oanIybzDUjvkETZGt0LSTAHTiJWg1YVeq6J+WJ9BptK3Q
         yY7WYhZrFAbY16X9KnOGSJprkzbMFlOuH1T8hjdzE/1YZDyj/AvZ/ng+y8HpakvwMxKR
         V72tlGYPScV255B2vdntFuQq0UGux4IkpEKiZ8juWHOQ1M2nyR2+ulazBUbKly+SAKC1
         CO9LpPebE0zs0y5NVsvpjvGbtaMJo94Hxpc1s8rDqNvIysotikbo6IWSZNer2jqlUf95
         /Vzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793948852; x=1794553652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SyAT3kgnB5A36GtJplToXCiU6rWfBoePnhWMVO882hw=;
        b=ac+lalS2C45udPKowbAlc49mJdNxCM4QoMDQi0U2N5zjEiTFDlQbyz6G2S4F7bC6Se
         13NAhus3mUlNHIoDyvTtrLSITGrBky/Kt0o/sJKX/4WTRUskOs0th9V66uE+yuuiOaQJ
         lrhRmX8U0HDPtuwP4zp/BDy45rqm+sPSIS7Ai5VTo0XnmPAT5WkHWhc2rjnYQp0Em9iU
         TYu+iPIInQ2HhKPSA5fExVTxNgvvwD3QSj3RM54Vx9ZuDFEwkIQom4Ikj8STj3MPAMtk
         MDYzmfOX5T53TBGL8Q7X/jnQ7xy9CFzH3+Cdo6NQJ/opbcDP6JfCV5fWPjUEtzaZSCtg
         lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948852; x=1794553652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyAT3kgnB5A36GtJplToXCiU6rWfBoePnhWMVO882hw=;
        b=1OTZ8LKEKmdTrCIkVA5Huyc3p18mD7xXE5GUS4RURB7Gmv4ki4GpUBKVoRPCIrRgDW
         R4d/X+oe/BOuClCfsUOsHZh2DNxY+OHqu8UqPEyWfe+goZ/lT8QASod+aubv/L5POA+w
         jX0BvnS8E3rnIPI20OZuN8hIE8/tuzOld84bqK4aURPyIIM6s/2GRe2cK2arYev6i5cT
         HJyD5db//731WMluLz+MTp5wGgzvlAfitrTPg1qX96h4VO1PWgmSCLLUTqcT1tLmg/BS
         f71prfAhcxGwkfXqSXLa9zz6oWtkrtdb3nTEaEmAatCa9Jh3l3+TD6OdiTMNqZX9GX9+
         6ubw==
X-Forwarded-Encrypted: i=1; AKwUvBxdECvYdsSs6Rv0DHF+sWPESXDFFLBfuuJ1+FB9+gUxPhVsNSIA+PN2uNhs4ZsSqiHBtalQrN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z//QVAVUNL1+fhu6nJtwl+KNM/buj5KglxAFJPXQIjhdho9QYtS
	X1YDYrQJvudxJiHP9r0E4RY7VwcM8kYOMttWlyDPCF37J444Rybq9NyGIXaxN4bNMgFn9W5UPpT
	pKdUAYNfJmC65Mno6/OUfEflAz30JAXk=
X-Gm-Gg: AYBFou3QQC/CjJUHSC37hvtFUUfs2nYqSgbLFWo3/nHOJ5/3iwkmjn3J+YbEhk07D6g
	6KqvP092hRI/rKXgOqD0n0aMBnVQpCnW9VH7Je4z/Y0tV8oaddYeoxgHssmKIq19GMbkYx29cQR
	RYQLRQpGWlJZiwrWkOoAai5T21PljHBlkTS7BqNAMplzocMv993qDNFsHeSFNSB8P7yVoXwTszd
	T2u8db/U8VwJyTxKQDyxgb1v+lB0C8dtTMQGOlrdySwMl+nCTXHZtnViRF+TsxAau2dd8+XPeW7
	oRBV2lpaxX5VkwRmpjTzSyh5APGACWVDkWh6MDvByGqJir1no6WV7yLZ0EcKTXY1Z4pNtAo3dpr
	jOJURpp3muORkZwHE2tw8aUQzHBd/t3+UQFlD7riUQypnqvYnrElCXJjYuSco/r0qEjeBEP/2W/
	TeUMbj/w/tmsOaUQ==
X-Received: by 2002:a17:906:c150:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c4d354b9d04mr130447766b.32.1793948851462; Thu, 05 Nov 2026
 23:07:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-swapin-large-unmapped-v3-1-d5906e4cf18d@columbia.edu>
In-Reply-To: <20261105-swapin-large-unmapped-v3-1-d5906e4cf18d@columbia.edu>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 6 Nov 2026 15:06:54 +0800
X-Gm-Features: AclHuK_6llSzkyRcVYdlNTM5aGEuCM6qDLFo0-sBLaWSUDxDfNf218-kWrSN0Bs
Message-ID: <CAMgjq7AMjQpW+yTKKwuttNvVGeHfc1Nc=QDP836q+arsB13Lag@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swapfile: drop a large unmapped swap-in folio in unuse_pte()
To: mt4022@columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:28=E2=80=AFAM Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
> for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
> one large folio in the swap cache.  The folio only becomes anon once
> do_swap_page() maps all of it, so if the faulting PTE changes in the
> meantime the folio stays in the swap cache while not being mapped or
> anon:
>
>   Task A (fault)                       Task B
>   do_swap_page()
>     /* swaps in large folio F */
>                                        madvise(MADV_DONTNEED)
>                                          /* zaps the faulting PTE */
>     /* PTE changed (F not mapped) */
>
> swapoff then maps it, which marks all of its pages as mapped and
> exclusive, and the next fault on one of the other PTEs crashes in
> do_swap_page():
>
>   [    6.424485] kernel BUG at mm/memory.c:5195!
>   [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W=
            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
>   [    6.451035] Call Trace:
>   [    6.451567]  <TASK>
>   [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
>   [    6.458525]  handle_mm_fault+0x16f/0x480
>   [    6.461143]  do_user_addr_fault+0x312/0xa30
>   [    6.462044]  exc_page_fault+0x66/0xc0
>   [    6.462846]  asm_exc_page_fault+0x26/0x30
>   [    6.476708]  </TASK>
>
> do_swap_page() already drops such a folio from the swap cache when it
> can't map all of it.  We move that check into a helper and use it in
> unuse_pte() too, so swapoff drops the folio and swaps the entries in
> again as small folios.  With the fix, the next fault doesn't crash
> anymore.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 1s.
>
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_=
SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Changes in v3:
> - Don't handle a dirty folio, the helper already warns on debug kernels
>   (David)
> - Keep the comment above the check in do_swap_page() and say "some folio
>   pages" instead of "sub pages" (David)
> - Drop the note that the check goes away once folio allocation is unified
>   in the swap cache layer, mention it here instead (David)
> - Add Nhat's Reviewed-by
> - Link to v2: https://lore.kernel.org/all/20261103-swapin-large-unmapped-=
v2-1-87c70e597250@columbia.edu/
>
> Changes in v2:
> - Move the check in do_swap_page() into a helper and use it in
>   unuse_pte() too (David)
> - Use VM_WARN_ON_ONCE() for a dirty folio (David, Kairui)
> - Keep a dirty folio and return -EBUSY from unuse_pte() instead of
>   dropping it, since dropping it would lose data (Kairui)
> - Rebase on mm/core.git for-next-fixes
> - Link to v1: https://lore.kernel.org/r/20261030-swapin-large-unmapped-v1=
-1-41e4ae378e6c@columbia.edu
>
> This is based on mm/core.git for-next-fixes, on top of David's 7f2c000ffb=
10
> ("mm/ksm: check large swap-cache folios before mapping them").  On mm-new
> it only differs in context and applies with a 3-way merge.
>
> The check can go away once folio allocation is unified in the swap cache
> layer, where allocating a folio stabilizes the swap entries.
>
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/sw=
apmthp.c
> ---
>  mm/memory.c   | 13 ++++---------
>  mm/swap.h     | 10 ++++++++++
>  mm/swapfile.c |  9 +++++++++
>  3 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 91836d217d25..10016f7984fd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5170,18 +5170,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * If a large folio already belongs to anon mapping, then we
>          * can just go on and map it partially.
>          * If not, with the large swapin check above failing, the page ta=
ble
> -        * have changed, so sub pages might got charged to the wrong cgro=
up,
> -        * or even should be shmem. So we have to free it and fallback.
> +        * have changed, so some folio pages might be charged to the wron=
g
> +        * cgroup, or even should be shmem. So we have to free it and fal=
lback.
>          * Nothing should have touched it, both anon and shmem checks if =
a
>          * large folio is fully applicable before use.
> -        *
> -        * This will be removed once we unify folio allocation in the swa=
p cache
> -        * layer, where allocation of a folio stabilizes the swap entries=
.
>          */
> -       if (!folio_test_anon(folio) && folio_test_large(folio) &&
> -           nr_pages !=3D folio_nr_pages(folio)) {
> -               if (!WARN_ON_ONCE(folio_test_dirty(folio)))
> -                       swap_cache_del_folio(folio);
> +       if (!swap_cache_folio_mappable(folio, nr_pages)) {
> +               swap_cache_del_folio(folio);
>                 goto out_nomap;
>         }
>
> diff --git a/mm/swap.h b/mm/swap.h
> index d5bf21f517dc..7779ccff5a0d 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -464,6 +464,16 @@ static inline void __swap_cache_replace_folio(struct=
 swap_cluster_info *ci,
>  }
>  #endif /* CONFIG_SWAP */
>
> +static inline bool swap_cache_folio_mappable(struct folio *folio,
> +               unsigned int nr_pages)
> +{
> +       if (folio_test_anon(folio) || !folio_test_large(folio) ||
> +           nr_pages =3D=3D folio_nr_pages(folio))
> +               return true;
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_dirty(folio), folio);
> +       return false;
> +}
> +
>  extern const struct swap_ops swap_bdev_ops;
>
>  int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 71ef9e2efb3a..5d915951639e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2513,6 +2513,15 @@ static int unuse_pte(struct vm_area_struct *vma, p=
md_t *pmd,
>         if (!folio_matches_swap_entry(folio, entry))
>                 return 0;
>
> +       /*
> +        * A large folio that a fault didn't map can't be mapped one PTE =
at a
> +        * time here, so drop it and swap in small folios instead.
> +        */
> +       if (unlikely(!swap_cache_folio_mappable(folio, 1))) {
> +               swap_cache_del_folio(folio);
> +               return 0;
> +       }
> +
>         swapcache =3D folio;
>         folio =3D ksm_might_need_to_copy(folio,
>                                        folio_file_page(folio, swp_offset(=
entry)), vma, addr);
>
> ---

Thanks for the fix!

Acked-by: Kairui Song <kasong@tencent.com>
