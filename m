Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0B5867C7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987505; cv=pass; b=FjRPlAfwrGwQ5wCG2EDXr8RAEP8ZuT9SaomcStn5ZafEFbdmyGTCGcosd4ld+nq2SZ7H3QUy0gHY7HnIVgAuhcszne6hAT+MIzy4JFg3tepjjgQjuqC2A/sGTvJi0iJVS/9aMS+n0kQFh/iRlpXstm0bdFGacec2S+WQ+ET9Sf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987505; c=relaxed/simple;
	bh=GNBnlEEqI8nyGt1DXIN/Q2A1UEs04PydxXQJhFl47ns=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvZODc8jQJSDuya2JxkJMCQ2OM9sHRb21mDL8zA3cwJcMEpFPPbMlt0IwnY3Ip9GrKutoc4yp+Gc8X1aRA+L/d7iIURLN/iuS4y0/Q5hSnQ7Nlaf8K+dMIKdhhGjHI2z2PqYRgs4hyc6/Eqy4uw0CUZOv0i5xi58s+4hSQFxxoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXfzXM/7; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXfzXM/7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso620073a91.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 13:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788987499; cv=none;
        d=google.com; s=arc-20260327;
        b=FiS3B0DLAX6vtCIIA/7zob4hag4OAepLHPU0ggEGaqPt1R9zLyi+sScq61x+9yO9q/
         aEUCcvlPxX5SkOKZAvAHJq50DcCk2qBtb5rwLlnOoI5vbPFaXin2N4/bsdyQUOhYzGuV
         HKQyjDdRo3Ml5kXymqXUPDgcY257SyXpi183r7ofDPGWh5lKMCnqWdIowOPrZX+0tRFs
         3j5E1zxciIb2a39GdPZM7QERocHiER2dshPVkNaN+IhX1emJb9Nj9Y8+yhspILlQKx44
         teJL6D5AAgb+phxemLhoNp5seehmqgYMwVrxbn0hZJ7Rd4uPUe6BQVgQIIFwvhBdRgQo
         Xt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fto8QffRRzc1iPbh04C4QLWgSTkv6xI4tqguxS1zB/k=;
        fh=Vt1uAhpOuq99wZYTHsZpdxBmuInFWECcsBmFY9+Snx4=;
        b=dqbjG3vlQsWQqCViE7EXgjkgo78d6We/toQ5XkMkJiY6DnWckYlMAbjoHquH5oJEB8
         uGX25jjrgrnJsIw2TfRetqgW2gCe+trapEv7xHEkwBjAFrTfTpUhGnmOY0/qRpWqTxb0
         MoPWJLD8AakowFHATQY93KuitYX9PcLbz9EZsvT/XG7e57IJSx7qACcrD2H8U2o0Sah0
         PWQu+/rxE7GT+40oPN8B2x0YbWzrcyfu4gkn1+k2SrozM6+wK1t0cIR6kEvgZavfvd0U
         5Q1bdEvF9aW3+p2hK33JrjV3u0ijwK6MKIpSTDbNCTLnzzNsKE6Pukdelvbon+w67G8f
         YQGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788987499; x=1789592299; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fto8QffRRzc1iPbh04C4QLWgSTkv6xI4tqguxS1zB/k=;
        b=pXfzXM/7pUcdy3qiACdJMAYnalpVUTe9gTGVxItQL3fc0LKvhK4c7DkK6FzA5PT2D7
         e1kGRkFZi2CyAO16TpUDlMKJfDylNlABVmsDDu/1tZckjDPxvs3inC1WEMneYIhosjMT
         DzTqm+VyTiN6WmPzBM0d4yDPHjHgP+QM0MjjUzi255yFF1Q28DfrxPJaLZtv2EngFvgY
         diKVo2fljU8ZYLTVtAqWRO2afECrAEvKCQEVRtAM97M0A8OvIo/Z1mxoG9r/QmuOzjKp
         q7r7axbByxQBYnuonpfYdytNPrCSd30kUiLcH+MDT1MFj0hKOBTEOhCOI9yeMgTQU9Qb
         Vqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788987499; x=1789592299;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fto8QffRRzc1iPbh04C4QLWgSTkv6xI4tqguxS1zB/k=;
        b=fde2Dqo3l6TkwsHICdufbVMZOLotxBob9x3mriG7JD7VFBZhsZLHVKVTbsOg2ZC4rQ
         ZeFx/Zo8AJcO79yvMicG6Dv3wKnHYgq4PD/5j8KB7ER23Pugf2xC5Dju2Zy0L0K8Lw9Y
         TC8+qYQXm42XjdibjEavwFD0+iXkPnSpm7lJU4s6ukcRXcNwy1858f7jM4R5SuIIH3yk
         NFfjR2QHl7p5W+VANcNmYMqcmpbzalKEwV3F9wNdteBM8MGsVf8A5/IzGgZ0G7auTDSE
         7XbZB5wLr8DkCEDfuhEB7DhAwAW1zKwec+DXHTGb5dI9FfPXNPcGm3GwEHIJ/0/aRXmu
         w3EQ==
X-Forwarded-Encrypted: i=1; AKwUvBwddidqA7ahUyFNW41Vn3lHpVMA/qozypx4OehfvaXtH9t2EKc5TwrjBSnGnk2rzZsOyxqEivE=@vger.kernel.org
X-Gm-Message-State: AFuF++kJhQO6ogE1JqKyBIqvSNDdPuB/dQgWX+IE6XCnjFT9tg/G0Y2Z
	w0rLXGHFVTH9Zap+8F9KTdKardZX7bWqAVXL0dXNZ568StyTMlYpi4eNRFREkwT5o1djlKJ/IAW
	E3bqdy+hIDskt47qFShXBJmgzyaoDWdzzq/9XE1M2
X-Gm-Gg: AYBFou2MeUs2T+BVZvqX/X5iENrLcSNpANV0hcN07UTLuwgEc4Hgf4lSftcQksBXEtz
	6oRS74ENBIE+7uRbDH000Fl2w6O3RkEXlhm/TN/vBfA4E1oW0FC5m9oB8G1NNHgKL+er6s2xOpq
	L7/shLquBGXpfNO2GqOTtikAlFmxuFMmQ2cOIucJ4WHWBxdW8qj2BhzQcMPHpdmXWkGk0Ai0tn8
	qB+Fho9fSY+vNtZFpzZTVeR0Mpbi6FV4hZxRJ1GBhDurzd7d0ZUKrZu6RGRzCkSr0u+LUE79o+m
	uuUSkMBOmlpeJGDlyYqt96TlXJ2N5Vb+NkzAlBrZ82rjBj2SMakoxgL8zYI9OttUTsBa2+kNTZB
	1WR2pRgBkz5GT12Sj8PgLXVJFqexoi6GVQ6OZzMTyTw==
X-Received: by 2002:a17:90a:d406:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39d70b4e3bfmr4942649a91.16.1788987498156; Wed, 09 Sep 2026
 13:58:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 13:58:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 13:58:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260902-hugetlb-subpool-always-track-used-v1-3-de1cd14bd713@google.com>
References: <20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com>
 <20260902-hugetlb-subpool-always-track-used-v1-3-de1cd14bd713@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 13:58:15 -0700
X-Gm-Features: AcwNN1VHOD9F3bWg7PfgqL3VQ7dHsVNaxKBOIXno-ubvbNrtHXi_elzy4mYJuNA
Message-ID: <CAEvNRgGRxRvAj_KC+RJ=7Xuddz+FRDP5pn7ZgVaZq5y9WAB9tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: hugetlb: Fix subpool usage leak on allocation failure
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
	rientjes@google.com, vannapurve@google.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

>
> [...snip...]
>
> @@ -3072,13 +3072,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	return folio;
>
>  out_subpool_put:
> -	/*
> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
> -	 * during hugepage_subpool_get_pages.
> -	 */
> -	if (map_chg && !gbl_chg) {
> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> -		hugetlb_acct_memory(h, -gbl_reserve);
> +	if (map_chg) {
> +		long gbl_resv_put = hugepage_subpool_put_pages(spool, 1);


Sashiko:

Does this violate the subpool rollback protocol in alloc_hugetlb_folio()?

The error path appears to unconditionally pass the full requested amount (1)
to hugepage_subpool_put_pages() instead of the absorbed amount. According
to the subsystem guidelines, error paths should return the difference
between the change and the global reserve to hugepage_subpool_put_pages(),
not the full requested amount.

Ackerley:

Nope, the subpool rollback protocol has changed since the first patch in
this series, where now the subpool always tracks used_hpages. After that
change, pages taken from the subpool should always be returned to the
subpool. The return value from hugepage_subpool_put_pages() can then be
used in hugetlb_acct_memory() to fix up global accounting, like in the
line below.

> +
> +		hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);

Sashiko:

Can this result in silent state corruption and accounting desynchronization?

If alloc_hugetlb_folio() fails (e.g., due to memory pressure) after getting
1 page from the global pool (gbl_resv_get = 1), and concurrently another
thread frees a page to the same subpool dropping used_hpages below
min_hpages, hugepage_subpool_put_pages(spool, 1) will absorb the page into
rsv_hpages and return 0 (gbl_resv_put = 0).

This causes hugetlb_acct_memory(h, 1) to be called, which attempts to
gather a surplus page from the global pool. Since the system is under
memory pressure, this can fail and return -ENOMEM.

Because the return value of hugetlb_acct_memory() is ignored,
spool->rsv_hpages remains incremented without a corresponding credit to
the global pool, which can lead to an integer underflow in resv_huge_pages
and permanent memory management desynchronization.

Ackerley:

Sashiko made the same comment on patch 2 as well. This is a common
pattern on cleanup paths, where the return value is ignored.

I think the fix here would be as described in [1], to flip the
reservation tracking to track an available page count directly, but
that's for another patch series :)

[1] https://lore.kernel.org/all/CAEvNRgGN0HSJ2iLSDD2haSKOxifa-uhkO9Hwossh0+Q_d9fzOw@mail.gmail.com/

>  	}
>
>  out_end_reservation:
>
> --
> 2.55.0.970.g62bdec98f9-goog
