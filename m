Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FD3438A7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953962; cv=none; b=X7GCEqv6XhIm09Bj84md5vBbnC9KvKpdX2nwBMZEAJ/e4oZ/KOD478sWGfliglJzVzANkWdZKvljrVD1pcVGwOwJmU38OOEe1IkfwV0P6uAKODcij1d4SoHtG5BzldhO3+n1/WhV7jqbdimi+cBfZLvN3JKmAOZ3RzVSXEGEPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953962; c=relaxed/simple;
	bh=eH06d02Chz0Ei34ikr+qHmgb+23hHim1HZnyhQXjhPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnhMg1ilVVwOucId+PiJpHSk084kBpMtNgKcCKubnef9KCb2TbkVUvBDquPjcI1vapOI2LPl5pEHJrGxGMlUnwqb1qbQ+whmNI5wu7uSsMAQW6D7P5Ijuy/BN+/MaiVF40OKWStPnx1GZM5rSAKOKBr5tGdsKICiC02A0wctnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+OzWSIT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+OzWSIT"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a39ee84e64so334460eaf.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783953959; x=1784558759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XU2J9ywExwhM1zwy22c2Y1HK11dL7My6r4TdOxaIsEI=;
        b=h+OzWSITVdjXU/MsbsL2FDJB7UtxW0qZSXAAduBJcf3j8Kl0uT2Z34Nc9j/STJoDt1
         D/Z9AAOiOcnAjcxwvJS1TxxlpB9d5+jYCE0AL62r85mCkLHaRTFgiYLqrAITneSoDb9U
         jdvRz6VK9JT2lhvZTQ6NpZRdNXwS8WeH658vVIXP+m6TJTIvBSXM/n3T170k9bywt3/o
         84rCvzLsioJzNUprP3W1aiFJHLQ0gwU0P8QvbP9s9fSf1jadwooMDSY+tsRUtSubGmS/
         5NV5MarUtBYO3HSv68hAqFo6Kh1fFV+LyGOkdQMz4fpo9J5hLkcyKf12rNpJcBfd0Pe0
         +fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783953959; x=1784558759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XU2J9ywExwhM1zwy22c2Y1HK11dL7My6r4TdOxaIsEI=;
        b=H1dZnAN0kQ86hfAJ16Gp5IE8X/NRX6uA2f1b5DV0lirP6gzKA1bjXm9+NPbiiNliby
         EGJyA9aa8DcQh2m3qKXvzREVTcaQYzYnEpNp7AuUnxFe/aAoqii+bOCEiNWvx5WcW+Sj
         UTAoXue6OgEpwqUsknBCwM7e57zOvlwJKHsB3R18fX5lwSf4aivCOLN+gago6n1XP/3X
         bjgGuc0hdXGKuqhjGjvyNPQDRSCSo9bPSVGmBcQmHDf+e5BHemcdeJyvZhYs/1JFiTAF
         sY+HwrmPMH7/3Ct/Fif3ZbGSp26mNRhxhsXIwojRzk5kymjZJxbs3v+5N9pYR/IHDCuA
         Jitg==
X-Forwarded-Encrypted: i=1; AFNElJ++TWHnGO3APH3BfnVUvGZDHyuoLX9ZBoAbhrNDSJ+mDamosT1r1QslFGrtb6ZAXDzWgECqZEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HpniF8t8Hsn3HVIdXWk3xb5Mvi5RmM12UX6dbJ4Xey6TVg5K
	cM4CeuLROWmt2VaXNpxL2XUjpzV8xFKvtZFWu2HjBfo7efhu48DzBvxY
X-Gm-Gg: AfdE7ck5DYdpevaIJ8/AT68EMocYZ1ntoWRTAI1OZrnhYudFmX/bywUZhfvSZJp+CDO
	ubof5f3Vt6O5YB839eEC1JVT09togOBTFLop+RHIsdOSvVwR1SpvhoZpSxpWwlJU6vQBnP9XU9N
	T7HIiPx3/Jov2FrUlsk9aKH8CUohtQ7gVMB6UZh9KCZLcZqUYCIA3oUpw6iucZMqVJTizqq8xN7
	I2c7hnKY5A83LeA/MsQygaiqnfTN8ADqf3sle2XgWFyyuq8pM2AHIi6qRKbC+uDk7av+35wtWSH
	BnCMPNfsIof3fqd83mijsXdZS9kdUa7hqNXKV2vr1gu39E6iEi0WtX8EOZLdUaz2UcYxM1re5N6
	iCbweQWG6tBauMn3dI5CF3XGcFmaxxzTtS80nfiIEwqrFb6/YBIZ32ijal7Hg0nUdOsjfNNxFNQ
	1xEC/xSVgUejsWapIjOCHX5AfcUcsV+J6c98xuwpehYsF1M6c1E7l5Jw==
X-Received: by 2002:a05:6820:1b0b:b0:6a3:2368:4cc5 with SMTP id 006d021491bc7-6a39a6dd434mr5521035eaf.35.1783953959481;
        Mon, 13 Jul 2026 07:45:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38e9bc8casm6715121eaf.2.2026.07.13.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:45:59 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Song Hu <husong@kylinos.cn>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	David Carlier <devnexen@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: restore failed global reservations to subpool in alloc_hugetlb_folio
Date: Mon, 13 Jul 2026 07:45:56 -0700
Message-ID: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115008.937175-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jul 2026 19:50:08 +0800 Song Hu <husong@kylinos.cn> wrote:

Hi Song, thank you for the patch.

> When hugetlb_alloc_folio() fails, alloc_hugetlb_folio() only rolls back
> spool->used_hpages in the out_subpool_put path when gbl_chg == 0. For
> gbl_chg > 0 (e.g. a size= hugetlbfs mount), hugepage_subpool_get_pages()
> has already incremented used_hpages, but the error path skips the
> rollback, so each failed fault permanently leaks one used_hpage until
> the subpool is exhausted and hugepage_subpool_get_pages() itself fails.
> 
> Decrement used_hpages for the gbl_chg > 0 case too, mirroring the
> hugetlb_reserve_pages() fix.

So something is clearly wrong with this codepath here; there are now 4
competing fixes in the mailing list currently being discussed [1] [2] [3]
including this one and they all do things slightly differently.
Let's please agree on what the correct solution is, 
I've CC-ed the authors of those 3 other solutions to discuss here. 

> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Signed-off-by: Song Hu <husong@kylinos.cn>
> ---
>  mm/hugetlb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6c812d1857b..8413ec92d836 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3073,6 +3073,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	if (map_chg && !gbl_chg) {
>  		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>  		hugetlb_acct_memory(h, -gbl_reserve);
> +	} else if (map_chg && gbl_chg > 0 && spool) {
> +		/*
> +		 * Restore used_hpages for the globally-requested page that
> +		 * hugepage_subpool_get_pages() counted against the subpool's
> +		 * maximum, but which we failed to back from the global pool.
> +		 * Mirrors the fix in hugetlb_reserve_pages() (1d3f9bb4c8af).
> +		 */
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&spool->lock, flags);
> +		if (spool->max_hpages != -1)
> +			spool->used_hpages -= gbl_chg;
> +		unlock_or_release_subpool(spool, flags);

Why are we unlocking or releasing the subpool here? 

>  	}
>  
>  out_end_reservation:
> -- 
> 2.43.0

Thanks again for the patch,
Joshua

[1] https://lore.kernel.org/all/20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com/
[2] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
[3] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
