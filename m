Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308877;
	b=RjqvpOWL70wqjsIvi7aPzgCrhPNqjtUrqxroZahCTb4T0wGi8jHwQ7pSWqOatRO5/L9Y
	 w960tcoHU5Wsii3tVd3qGcd3nyd1wwAXX4hWAOvOaCj5YSeSsPWK5aqsXGsYSFVcuENrc
	 yY2c/GCPVqtM4vGkf8QOk7t5gvqDFvdHViru2NMnFFnZeNN6EStQDYKEqRqd+Ex7cDrwc
	 7EymI6kXxXz7LenDKIroDJ7ZzQRMzzqr31W01nem1ENCCQkjC2CY+NTSQLU8G6iqlWzgU
	 +GbQnSxoZlnBU9mgDYs91ziLOstT/G2EiVdHilhmDjdR/qsQjZWkLeuLdVFZdMXEgYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9+8ns+yvE4djttd03VIoOUqKqYBAUVZpRS1Gm6Ry0jA=;
	b=btJhkpfEJoJhvomoAfSVPwQ74CFCXZB7kEJuVo4l8nZ0cwKKLDiBCl6EdXR76i3U0Yzq
	 Js7pU5nnS0zblWoWSNiVjvyucec6vepMeCFK0gZED5hYTd1H3PcVswoo28e9diPkJH3nR
	 WAYPokM/c9ww3x6rVAkmuYeCnmyH1LdxkZIFORx3rxyfhdGltLbog2RWSykFiT6S0tWXN
	 K4eM22gLM7ORpwvveSpXmocN6ZzfVapSCd3GzKo3CW5TyhnQpoBSfrEsobq09U3nzhYnL
	 muk+S0sJ4do3JblQEhIfAPtP7KG7EzHigqNw/s9O/zpVPqQT+FWo5XJpPM+op3FtOlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b187zlaV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EA606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 504EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b187zlaV
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso99685e9.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308876; cv=none;
        d=google.com; s=arc-20260327;
        b=RjFghjui/TeNihxdFHez1tT5D9X8uMoB3TyxPPXby8gvH11aYf2yDHMYfjIb2AIvjH
         jVKyLhr7UBhQLqVwjVADsQoJZXtbfpLFQezEVQlCRkqDJR1w98L5rRrVpLF78F3Fo1D0
         3FmbLSaYYNR6sV4OpHvFpYXWoctNvNMKih0mbzirGWbXsNaiWmzB0rCkXvTKIDHXE07z
         QG+Dwj+Zvzw0lXxAcSq20iiFNH6rCEal4Bnygq6sqzos+FDnaNFwv763TS18EgTsUfVz
         7HMGegqVa2uToms29KkjCDsbEf6dC6Hrj0ITTuBLlvBYiu8U55VABkjScoz30KSyfiKB
         /t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+8ns+yvE4djttd03VIoOUqKqYBAUVZpRS1Gm6Ry0jA=;
        fh=rTk9PaSN7HdFMSe6tXp9C7TcgbPzHA9FM6jN4mjkaEw=;
        b=dWCwbEEh09qxj1krgYxzKap6S3OeeS8gV+xe/O/l1+vVVtPwJRo8eFbfdX8FIck5zp
         wl/YBlSyjZt2YpP4EBY6x7Xgfd5q+2pMP4eEFWTBdYcbjKmspk9oXyDMFnTBE9oiSr3y
         FWPB4ECsk8EgUBDbw8XA8jVMnK75Z5HmPDCqt28OEwqVuXq3x/+gfrvlP40+vqxKzp9Q
         vioWZilIFxcRovsObQZgP0KxzXmmoE1szBc9izzA8Lq/3nDqEjWzZbon/bgbaeNTElJU
         3Pt1AhSwPja12+pZjQKC5oOozUs6+G7psDDX2b+bag4jeqCtH/mya/65b64T1CJO/R8X
         wJ4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308876; x=1793913676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+8ns+yvE4djttd03VIoOUqKqYBAUVZpRS1Gm6Ry0jA=;
        b=b187zlaVHnz5lzU40qztJ6pRtgry5HkMLZIj05AbLmiUPaDNznWYKFk20cs739b5mO
         sKBdIdaG+F1j9SokDMS63l/DAQnIUNS/LG+RVmHF+ycrEj8fSzzMPaCj6FfLiBPwcg20
         KLF/714jYYxoLl0Ot4y3yQLq4W52oW+g0YUwvF/NpgswQ1xazDgrqQwvCUlCTmvQwmwy
         sTG1DEOWw5gJuqjqt3/DYeSJx9n1MJi+LhDqUufo8t9K9/kAccYEWLwpVUkHpAnS0l20
         /hOphx2OLVPwByqB5ltoD3uf4kEqxU3W9EkXm3bDpgWTiH3oLYrNXuQthFcSXq4IDCNu
         mHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308876; x=1793913676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+8ns+yvE4djttd03VIoOUqKqYBAUVZpRS1Gm6Ry0jA=;
        b=fLlPhrbuAw7Vg1ivmEIjxbPoiGhQwg+CBFo2bf/hSjFtkCa5tnFiWYuYdIWT/EcTe3
         Jcr/itikoQEDZYtLouvl/Ens4xgnF8s+XWN/NgYH25SdEJzyTSpLusDPzdfIVQBsM7Cx
         A/tTIudNN5HbLs/neKeeytPxK4eZNuZ31/0tj0IXIVhyGLwJ+8uueqg5pJWQTWIQpudq
         9ByCfOAgE81MVvwyBFi3J5s9CJWMFQLdnoLzfUUJewgv+OGyU/kH93YMDHb9Oyl33bf0
         s2heZznlvM6ivcJnqXOKWLIDXYGP0CJZQNPnhe8WfRz8Hvu+dJKS3MhQDN/9WB3af4N4
         sXhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk6YBoMQG5QxHfUnRoNAKHJah8+J1EsdJXoWxyhTbVaXa3axAIAdWzUXOY9sNM7ypvTIDWXVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKduZfSe9LeKu5N+l8vcNWMLHXQ0VBO6WF956JNXIhPiNOLfKed
	LlwetK0reSrQ2gfRKlCP3EIfdBisS/7cacMzw4FbAmmOGWclZ1SFKOORfuledgBjbzXBSuDcIbP
	a8oNsFp9DA/M51/vV2nNxFVndjYf9K54=
X-Gm-Gg: AYBFou2DCcUwScQsWIl2d1VfuCN+23zI1Mws8U5rFJyP4Xomd7End+kMK/Bkar1Meex
	3fX6VOFHjxiS1DZDq6IssYwUDii5XlUQwt+wvql1rcs7aviUMyNfK7wFl0a1LXr0lmakEnYzNPs
	YO+yWO/XCSe9Ph+1cwpbqZHdu4qQGBbGJ8wNGsXY6od77PrdFcH6dDFqVdoLkLtVqWCDw3mdEQQ
	rQE+rBYFe4vTmgQk95iLGE706A5+izw1/wP5jyLQesgeLw3Ew3YlmyK3u029iYJZvv1caYdrzvv
	i0D5bT93wvSUahLVy+ts0/kKCKr6z5cY6p7oxDc1CwJulUbXutuV7HlVSyS9hptVF/AIeU5D7KL
	6Iq5e8o3RkaSVY3t/ZftV3Y0T0BQ9ho9LO/TkWtKPFuPqIchRlEw4XAXGzext8LfEGVdtfGBK44
	IOOW8ZN+aa45CHmyYZH4POK6Ggz9bDK5fLfN4YsJrBn87lOBX11IxHwlkw5sUkw9vcJJ1jwIrP8
	A==
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4ac18c73238mr4750555e9.33.1793308875581; Thu, 29 Oct 2026
 14:21:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com> <20261030-swap-fixes-v1-3-73f73a59f2fc@tencent.com>
In-Reply-To: <20261030-swap-fixes-v1-3-73f73a59f2fc@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Oct 2026 14:21:02 -0700
X-Gm-Features: AclHuK94IG0mhXQQjpw3RIi-A5xAWBQBwS6QINbigt5Lm9tPUmEat0F26KqQrPE
Message-ID: <CAKEwX=MJcyr1GjKNQ81x+fUS07T=THXGivjebt=W0ayjjZ3fgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, swap: fix large swap-in across swap file extents
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Yosry Ahmed <yosry@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:32=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> A page fault can give an unprivileged process blocks of other users'
> files instead of its own swapped-out data. This affects systems with a
> swap file on a synchronous block device, such as brd or zram. For an
> anonymous mapping it also takes a huge page size below the PMD size
> (mTHP), such as 64 KiB, that is enabled for anonymous memory.
>
> A swap area is divided into slots of one page each. A swap file is a
> regular file, so adjacent swap slots can lie in two extents, far apart
> on disk. A folio is read from swap with a single bio that starts at the
> sector of the folio's first slot. So all slots of a large folio must be
> contiguous on disk.
>
> The swap allocator knows this: it only hands out a run of slots for a
> large folio if the swap area is a block device (SWP_BLKDEV).
>
> The swap-in path does not. On a synchronous device (SWP_SYNCHRONOUS_IO),
> one that always completes I/O in the submitter's context, do_swap_page()
> can read several swapped-out pages as one large folio (a large swap-in).
> thp_swapin_suitable_orders() makes that decision, and looks only at the
> swap offsets (the slot numbers) in the page table.
>
> Pages that were swapped out one at a time can end up in consecutive,
> aligned slots, and are then read as one large folio. If the extent of
> the first slot ends inside that folio, the rest of the folio is filled
> from the blocks that follow the extent on disk. These blocks can belong
> to other files.
>
> Reproduced with a fragmented swap file on brd and 64 KiB folios enabled.
> After single pages were swapped out, a fault returned blocks of a
> root-owned file with mode 0600.
>
> Fix this by allowing a large swap-in only when SWP_BLKDEV is set.
>
> Known gaps:
> - A swap file on zram, brd, pmem or btt is now read one page at a time,
>   even where its slots lie in one extent. Its swpin counters in
>   /sys/kernel/mm/transparent_hugepage/hugepages-*/stats stay at 0.


I guess we can check for this right? Look for the swap extent of the
first offset, then get extent's size (swap_extent->nr_pages).

Not sure if these users use swap file here though.

> - With the posted "mm, swap: enable THP swapin for xswap entries"
>   applied as well, the large swap-in that it adds never happens. That
>   patch gives its swap device SWP_SYNCHRONOUS_IO but not SWP_BLKDEV, so
>   the new check would have to let that device pass.

Mentioning unmerged patches in changelog? ;)

>
> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io device=
s")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index b65b56fe9714..944f57153c89 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4863,7 +4863,8 @@ static inline unsigned long thp_swap_suitable_order=
s(pgoff_t swp_offset,
>         return orders;
>  }
>
> -static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct swap_info_struct =
*si,
> +                                               struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         unsigned long orders;
> @@ -4888,6 +4889,14 @@ static unsigned long thp_swapin_suitable_orders(st=
ruct vm_fault *vmf)
>         if (!zswap_never_enabled())
>                 return 0;
>
> +       /*
> +        * Neighbouring slots of a swap file can lie in two extents, and =
a folio
> +        * is read with one bio. The flag is set in swapon() and stays, s=
o the
> +        * race is benign.
> +        */
> +       if (!data_race(si->flags & SWP_BLKDEV))
> +               return 0;
> +
>         entry =3D softleaf_from_pte(vmf->orig_pte);
>         /*
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
> @@ -4924,7 +4933,8 @@ static unsigned long thp_swapin_suitable_orders(str=
uct vm_fault *vmf)
>         return orders;
>  }
>  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct swap_info_struct =
*si,
> +                                               struct vm_fault *vmf)

Nice, I think Sashiko is complaining about it on one of my vswap
patches lol, and I was wondering how on earth is correct in non-vswap
case.

Fix LGTM:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
