Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794747403;
	b=AaW1q155GdmzGKshrC25A6HvzZoXPR21hy5y9qFweItNAEjIcr95MnZYIc/VHZWNKrgA
	 bO6fcZaVdmwMV6iqKM8xR1nqStTBzg7b0AEiO3ledrGRP0EUipRgB7jgL5BqHLScEZgFe
	 qzkkaREjMwfDRLdOuPZ3cypKVIq6R2DXwZy/BMUlfHONbmOVM3gbQ28kvwFJRawisfDXS
	 tinaFGve5CBsvtEzUJfOYMZTwyFIgk+eKh2DeacL2TpUFaWpeixBujQOzljbk6a4bZuSO
	 1VuLNNQX137l7nQI5tRdo7oMbV3a5dcV7fNKQvnpyoCLa4LHjKn5+EvmPNhcnQGsN2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MPjxARwbhT7wpT+NldH9sgjHxyAG1kHYfbUx4elToaA=;
	b=bD1DkDZgJzxw8DR1NFPlK2UZ4vbopZE7H2sXHyvtCZ3HVLK2diBz6xWwRGb7iZjB5Q/q
	 UoZYcz2MBezLTQg8cprb8/AfKK3w5/ITFMPXsJDFzSIEpmnIleuPoOe16UQVBvOf9zG8T
	 5em+tbheYxx09iuG0Txt3rqXkREDLiangcMEtipwxrgGGlGjCakkaD/Bfe/SCgqJu40n2
	 ftGbb8dhL7gPEV97/03ihGCjHoPmK+ZF0Aebd8YHk64qWaCobr+ZtiluQEH1eUeTRf9FV
	 +w0UOyLDRvhS5FXN7YydS2/jQX/2m/Q+eq31O7H4s6j0h1moo2/tuGG7+i7sn64bwSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JIHfnajk;
	arc=fail smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324D606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 12:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6324D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JIHfnajk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1211161b3a.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 04:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794747403; cv=none;
        d=google.com; s=arc-20260327;
        b=d4lgV97EFa7TtBtTlw6aP0N5r0rrLz+ODtJtgLULn/pYWj49nJgydlr4q3LZEw5ev8
         vwVzEZes0Gj5aKMaCl2pgDhZbHCVwBXEP7QoWsMF73l2+8ylYqkczWeKx1o9BFnmvPRN
         vVZRi1ISNtnwdWnRGJLxrKNjh6ZzhoxiMtJqXY5bZr4Nkux0HGvNqsk0VlaktcbjeoRG
         AqE2Bk44LM5d/B5OhkNh/kDHDOPNjK+4CDPxZ0zoB6R7iD6YATjL+PF+6TnzwqgXqFUM
         49rFHF+E7om8e8a6o3F1Sqz4a7U03C/iDH49lZ1691Viif3XQqQ8gQB9SCAbrovkWc8w
         nnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MPjxARwbhT7wpT+NldH9sgjHxyAG1kHYfbUx4elToaA=;
        fh=7zwtyNSixcx76RvD0xlSSXHXjVjUrjFAWAfrUuV5xgM=;
        b=rAHS2JhAAc/N898Of2xcNVOdsdqi6FfIH0x6NOJmgg1NornLpkOY5IU0lL2USt4rqd
         CDAB9E3drRfEhiqV6NBTXpHOItHs5wjyPL2e48cXSHfDmY/ESoU4nOBw6YOvY6pz+Nwm
         qjnn3FTmtK1IPIi7PPMZ4BErx6UNqnrqvTAWVIq34l29aiFiM3iXTanh4OH18rU+Vk7u
         A1iIiDHN0a//aYCXtfqNgi4SNvHmUjsmBdb3F46ZQfCth7KMdx7VorjJQB2oWrPdt+Gi
         VcGwCqwMgBsqd0U0ujU4e1rrtjwMnNwcuTUdn/mvK8UzvOL4Evh79dp6+ij7MPN3Nj9j
         80DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794747403; x=1795352203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MPjxARwbhT7wpT+NldH9sgjHxyAG1kHYfbUx4elToaA=;
        b=JIHfnajkwoCboS1fv2TBBmAWt9SCje39C14bfMNUah71eWfYjaT87VKc6RlzVqcHPw
         eYNpcWQm+b6idCc1SH/a4OCC/q0vZO4Mw01QBK+p9yznmlJXA//tRL+czKQ0rBbgE6nY
         8lLjLIawO0THSZCW4cQcCUIkHNRLz8ZoFGkKG8OX8nVTvJ1hEsQMTsaxyGT9yTZgwQ0a
         b1hR37QqhrTzTJaCqoYWZrbdMRHK4IXMOTPeASsN5wT1OZNdM701u3sHqlTPtK+XyPi6
         OwbSXhYh00Riv7eXcfCttV6qZ+GcCwihBZe468YDDlk1+3TQvqglMyecLDGYh87L0XPq
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794747403; x=1795352203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPjxARwbhT7wpT+NldH9sgjHxyAG1kHYfbUx4elToaA=;
        b=wfjBAGcXi58V45OW07ZTd8jgRUNbw91PWdoy0OFzJq8EBxOmNsoxCoxBE2D8p5qoTQ
         hzN/aOS5nHic/EJXQT88O3yWJmeDVBrk4qtCnQV44NyrJoNaLboZKmntiehbOKbceAHR
         n2PCitFBDG0QJz009zTmuKkkduNo8qUc4sQUB6CBqUY3tzgwyCaV8fUV41B+CbVkPH+Z
         7y7YjjEIdKaCjctDbkQVBzCY9IEC8Jh502C5M53mfLB5PmqKm4Knee2cb4VyguVqdaoC
         ElLY4SwsmBqYYqCzN+G8+Hx43RqoW0TAqc62vn975LHOu6OcY3rv8n2fP+wQfmT1GKmp
         4pCQ==
X-Forwarded-Encrypted: i=1; AL+hErGdEzjXYYlGOb3ENwEvkTHFmLVILPSj08wvMYgVwQKab0gyn+qIa7StCmPuBhI7TLERQSmrp8I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rB9fQX1pXhPZzXqRggKPWjFyubhgrOVxDkg0QDG+Ji8A/WNYH
	KFtVHVPpzIDABN4hUO0mjjAMCB4Z/5LhBniAbxhioJTTLcb2YfqHcVRAi7g9OThj+KN7lFiNMV2
	tunntE7oPEIo9LlikWNLhdfAd02VlM8c=
X-Gm-Gg: AYBFou2TSGy3LnTwTzMPxvzaS9jWRepE+0+CLMA77p5cCQIC7th3sT26KZVmOSr9qmO
	Qk/kr01bEKjiLHc3FCvfOfQzqRUPMBU46hO+ytpm1WQKFFQMOSiSgeh2iz+X3tdDupRnmI9YAHg
	X/31LQdv4uGKCdvDrlQuWIgm3lQuulap1g4sg2XjHlBSpr9swUkhG86zP7wmBBSHFjzHvYNibrT
	SNmhhN0Wz7DxluknSzhG+eZZuMKUnD/SSGI2/kjPMK5eThlgiFA5I3o5n9RSTGhhp1+LMCGHb/v
	ZIA/MWV9iOni3HQWRN5CH90YPAIqnB/EyPFl1k1hmC3q+tVm8l8BgIir2jW6dLiaY1RkGvc6g94
	pixYIu7TT/SpyoPxNZOjlgp/bXiBTyRMpf/kYkNW9+O88AbdJ7N/M9QD78vR2ogd1+NuOdA==
X-Received: by 2002:a05:6a00:8011:b0:881:1c64:6723 with SMTP id
 d2e1a72fcca58-8beb6f5c1f9mr6440205b3a.37.1794747402550; Sun, 15 Nov 2026
 04:56:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110151407.789960-1-nphamcs@gmail.com> <20261110151407.789960-3-nphamcs@gmail.com>
In-Reply-To: <20261110151407.789960-3-nphamcs@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Nov 2026 20:56:02 +0800
X-Gm-Features: AclHuK_5SaXrB5pmLGWhXjUHDXsOmgc2bg3dysnge6viAM7H3emnkg8TzZhuZpQ
Message-ID: <CAMgjq7A9_KRxJEA1gLO8aEuUkbQ-Wh_N3gfTqRuX7A3_Ysh4Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/swap: publish cluster tables after reacquiring
 allocator locks
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, ljs@kernel.org, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, willy@infradead.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, chrisl@kernel.org, 
	shikemeng@huaweicloud.com, youngjun.park@lge.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> Under memory pressure, swap_cluster_populate() can publish a table
> while its locks are dropped for a sleeping allocation. A cached
> allocator can consume and free that table before the populating
> allocator resumes, leaving the resumed scan with a NULL table.
>
>     CPU0                           CPU1
>     alloc_swap_scan_list()
>       isolate_lock_cluster()
>         swap_cluster_populate()
>           drop local/global/ci locks
>           swap_cluster_alloc_table()
>             rcu_assign_pointer(ci->table, table)
>                                    folio_alloc_swap()
>                                      swap_alloc_fast()
>                                        alloc_swap_scan_cluster()
>                                          __swap_cluster_alloc_entries()
>                                      mem_cgroup_try_charge_swap()
>                                        return -ENOMEM
>                                      swap_cache_del_folio()
>                                        __swap_cache_del_folio()
>                                          __swap_cache_do_del_folio()
>                                            __swap_cluster_free_entries()
>                                              free_cluster()
>                                                __free_cluster()
>                                                  swap_cluster_free_table(=
)
>           reacquire local/global/ci locks
>           return ci
>       alloc_swap_scan_cluster()
>         cluster_scan_range()
>           __swap_table_get()  /* NULL table */
>
> Keep the count table, cgroup table and zero bitmap private until
> swap_cluster_alloc_table() restores all allocator locks. Install them
> under the cluster lock and retain it through the scan. Initial bad-slot
> setup takes only the cluster lock because the device is unpublished.
>
> The allocator releases its locks before the sleeping allocation. A
> reclaimer that dropped ci->lock earlier can then resume and put the
> cluster back on the free list. Abandon installation if the list state
> changes or a table appears, freeing only private allocations. Restore
> locks on allocation failure too, so the caller can return a still-isolate=
d
> cluster to its free list.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
> Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
> Suggested-by: Kairui Song <ryncsn@gmail.com>
> Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/swapfile.c | 106 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 74 insertions(+), 32 deletions(-)
>

Thanks for the fix!

> @@ -825,9 +862,13 @@ static int swap_cluster_setup_bad_slot(struct swap_i=
nfo_struct *si,
>
>         ci =3D cluster_info + idx;
>         /* Need to allocate swap table first for initial bad slot marking=
. */
> -       if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
> -               return -ENOMEM;
> -       spin_lock(&ci->lock);
> +       if (!ci->count) {
> +               ret =3D swap_cluster_alloc_table(NULL, ci, GFP_KERNEL, fa=
lse);
> +               if (ret)
> +                       goto out;
> +       } else {
> +               spin_lock(&ci->lock);
> +       }
>         /* Check for duplicated bad swap slots. */
>         if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) !=3D SWP_TB_NULL) {
>                 pr_warn("Duplicated bad slot offset %d\n", offset);
> @@ -835,6 +876,7 @@ static int swap_cluster_setup_bad_slot(struct swap_in=
fo_struct *si,
>         } else {
>                 ci->count++;
>         }
> +out:
>         spin_unlock(&ci->lock);
>
>         WARN_ON(ci->count > SWAPFILE_CLUSTER);
> --
> 2.53.0-Meta

Acked-by: Kairui Song <kasong@tencent.com>
