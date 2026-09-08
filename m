Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C893769E4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852594; cv=pass; b=R4gU6/D4HmLElBp49c6+crggHyJ2E0aKO5yxpoUswlPgt/1cyLHLFrbXZH9kdylZq0Ajaful3uVf0PTN7f5rsmrHM5zsmLF02D32wL3Y1sgGcexYlWSrNy12t1G292HWxtE6mT7yG97dauelu8UQt9gL74py5+oePRDUFzhzUog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852594; c=relaxed/simple;
	bh=T08rrPud2VipHJSVCcS3NiZ+LpFrS/HS4Ee9JZRN76c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYU58xe+9ABy6noNj95xGUPtSIKoVpuRbsQjUyke5iB1Nl4oIMPosJ5OYTFlPgFxHRmUV+7hGnrgfTJA9IibjILRSuOPfxhNqjBc1ciDqm7r5Fc90gTYTM/NGbaBrT0aEQQy5bp2Y3RBGMfaUFS+qSAzWF0UL+syJNPUFr0hQD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdLFx1on; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdLFx1on"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c25420fe973so735155066b.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852591; cv=none;
        d=google.com; s=arc-20260327;
        b=f0DEXDRW0VVqGiiWPuXJnNYtjn7hiQtdpfYse0GSPoDfpFCf7Qx2th3VfxqwrG8AIt
         UN56lPWMcuoevNnNdd7QC2Tu95znf2yeuRuqcJ3noWWYftq4/u8i30/w9KyAyEapBFu+
         o03dMGq3Wf3wQnxbITvxXRLCX9w0lDo8J1p/nORzMCTC8NqPp/+Wm2KVsZwo+ZT6g9JQ
         3dKNjioxsOmMt7FXNthhjfeseiv6tri81QX5hVgt8D9+JpImQvQah55wVYVV9VDFZ7gE
         t291BlDCuKOYyebOIYWO2lKwREO3iB68xaRgoRKN54pGAcJqAOjRXgR5B7kaH+vaufTt
         beUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKfQxZ3gyiwirNDj+FitYX1gJJkSzXez9jKvYCt/Fto=;
        fh=/UyCrsRoR3AoFchK1k1LcQcVHlVXOgUYRNj9DG165d4=;
        b=D5Cg6nY/dax7mMBdJFHy1kuh4rArdClYKKEZ0AbCnOD0rPnhgn9wNW3dSD58fDCIqk
         EIGajaqUFU+FkkM/a6IDarviH2aSc7QDOB19ufyZn+bojzK507MZl0s9B5k5BmnkR8J9
         UR4JaOyRL8AuA0BKwmPPaqRxeQBGwJ6fFUOtGv9I9Tqj0bBgxuvsIuI95x7xHPgaFyD/
         EU0cyJAFkdeCvCtoCBGLRcimP/1/uT5JGbs1B2h/xNSDyCgzErW9ZKyb23fk+DNO4iCp
         Q/bUTXcSYQT5NM7uuyBa1ZacPkDhmfA8ZvPRi8borlU0VCr3FujKCb8iLH4HXwy1MPi6
         dZ2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788852591; x=1789457391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKfQxZ3gyiwirNDj+FitYX1gJJkSzXez9jKvYCt/Fto=;
        b=FdLFx1onVZurzB5wI31jRDhriIFyVON5GlJJCWl2ESSbdYUM8EO0xqPnjp9VQa17tk
         p1oHoN6qKZmp9YEjkYj58Ivd4Hz/OxFPWh6/vLAZZhBlCzpIBOhycb1UFu+9ub1LGBAy
         G+qJ8MOnDXEYlDPKyVUjkJJs/1kRfe0XZ02RUmmubxYY5Ue6FA/agVp5JrHQ0KwMLlJ7
         1HzN4JGNmEN5bdh64pyeXpWLahBA7fR7uRKBSFxFC89v/A6pp6bEpW260rDKXlcOfmKK
         nMwE5Zrxzm/HO3/4RzV7XzH020GzDd5oVLylDZCVxyYlh3riebaP81ZzURbtR2QCLj2b
         Z8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788852591; x=1789457391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKfQxZ3gyiwirNDj+FitYX1gJJkSzXez9jKvYCt/Fto=;
        b=GQhae7WhCFUVsRB3mO6StzLG7rU73XUP72ZicsDe/MWmjT5nHThTJB4m96HAR35ODJ
         42TL0DyJWgS2DO1R25Yv3KONYszv2z6ihIGzmPqc/zqyaX7j7dnFE+mDBAToQPJfknuz
         ZxKXLpXWvZdxG0LVNSRsGiKMMzQFIDt7Ur6o2PdTFiYxfv881+5pFFzDA19g7TeSVwwq
         3UiE6ntjZ+bnMrUBFg2vpzq35R54dwXYmw69iN9l4GIeffMfCxgeeCDRcJcbK1/M3S5d
         +ufrVn2jSZ1uYg8rvjTZOmhKTcIzIcFimLQlU4eEJrchtiSJHdDalAObCgxR0eD5W8bk
         yh1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxmuDX0MPmuRtAOMJ8MhLnO5zuv+wNnGHc803chf+rsux8rTkXNOGmpT924bi+nKJRTgopP9tY=@vger.kernel.org
X-Gm-Message-State: AFuF++nhcQMBgblEDfobRuqENkAG6k78gNOAnDFZVROUoGNkd8LBd57a
	2QuiPydFSTxTpVJDfqW9MhFweAjZzlR8uJF6aRLbCCY+o6teUEPVvjwLHGPjBOGERnjGOE+iueD
	dv8rzLt3WZxajn9mjyyFfOd3TdG/PUhk=
X-Gm-Gg: AYBFou0Hi90lW/j99NQagHEjARGAS7Zny4gUOUpHcAjkxvn2EjfSHSYc0uZkPzC236g
	D+LkyvpDcr4crb7fPK7AwAzTn+P7qc2U4nn3QWZInIB8HXtL7WewriVOJURyJoMXalIaEKI8GLT
	oJZ/7z0JKcy4whJBiWtgyonoe38Sq6EVTPUYz3UJM321LaW19eYWCSXntVMx4VtNFIF8Fju44Cq
	ggYQdK4NqbyC2rURrNCGnjW0dTqS4sxcyTV0RT7ff+ggMxPK1B8hrT7UV5VUeak4ijtbR+LEMHI
	9v+W4vl8E8B4zrzA0FSVWHfUEEcznudPhc06cY04PJYGUj7FQT/ADLaYuAKyeo4S1hO62XgJva7
	rUxU=
X-Received: by 2002:a17:907:3f15:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c260cb450c9mr1089341266b.24.1788852590630; Tue, 08 Sep 2026
 00:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-memcg-swapcache-stats-fix-v4-1-d3626d305d4f@tencent.com>
In-Reply-To: <20260905-memcg-swapcache-stats-fix-v4-1-d3626d305d4f@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 8 Sep 2026 15:29:14 +0800
X-Gm-Features: AcwNN1WWN5Imx29M9KWwho3-Z5IQKifWJ1tJ__QZC48lfB_vyWmh-z7xUMM4azM
Message-ID: <CAMgjq7B8ALDN1wUvFeJhPnkg8R7w6G=KzbGeO6BnCGMh_cVWJQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/memcg: clear folio memcg after changing per memcg stats
To: bingfangguo@tencent.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Bingfang Guo <bfguo@icloud.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:34=E2=80=AFAM Bingfang Guo via B4 Relay
<devnull+bingfangguo.tencent.com@kernel.org> wrote:
>
> From: Bingfang Guo <bingfangguo@tencent.com>
>
> I notice extremely high swapcached count in the per memcg level
> memory.stat when running tests with cgroupv1 setup by swapping pages in
> and out.  It seems that the counter never gets decreased so the value is
> rather useless and confusing to users reading it. So I think fixing it
> so that the value can reflect the actual swapcache usage correctly could
> be helpful.
>
> __memcg1_swapout() transfers the memsw charge of a folio to its swap
> entry and clears folio->memcg_data as part of that.  In the vmscan
> swapout path it runs before __swap_cache_del_folio(), which then
> decrements the swapcache stats through lruvec_stat_mod_folio().  Since
> folio->memcg_data has already been cleared, folio_memcg() returns NULL
> and the NR_SWAPCACHE decrement only updates the node-level counter
> instead of the memcg's lruvec, leaking the per-memcg swapcache count.
>
> Move the __memcg1_swapout() call into __swap_cache_del_folio(), after
> the NR_FILE_PAGES and NR_SWAPCACHE updates but before
> __swap_cache_do_del_folio() removes the folio from the swap cache.  This
> keeps the stats attributed to the folio's memcg while still recording
> the swap cgroup with a valid folio->swap.  Add a swapout parameter so
> the plain swap_cache_del_folio() path is left unchanged.
>
> Fixes: 2732acda82c9 ("mm, swap: use swap cache as the swap in synchronize=
 layer")
> Signed-off-by: Bingfang Guo <bingfangguo@tencent.com>
> ---

...

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 305877e1f4d7..38916ea96ac5 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -306,21 +306,28 @@ static void __swap_cache_do_del_folio(struct swap_c=
luster_info *ci,
>   * @folio: The folio.
>   * @entry: The first swap entry that the folio corresponds to.
>   * @shadow: shadow value to be filled in the swap cache.
> + * @swapout: whether this operation swaps out the folio.

This reads a bit strange, I think you mean "whether this folio is
being reclaimed after swapout".

>   *
>   * Removes a folio from the swap cache and fills a shadow in place.
>   * This won't put the folio's refcount. The caller has to do that.
>   *
>   * Context: Caller must ensure the folio is locked and in the swap cache
>   * using the index of @entry, and lock the cluster that holds the entrie=
s.
> + * If @swapout is set, the folio should be in reclaim path and IRQs
> + * should be disabled.
>   */
>  void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *=
folio,
> -                           swp_entry_t entry, void *shadow)
> +                           swp_entry_t entry, void *shadow, bool swapout=
)
>  {
>         unsigned long nr_pages =3D folio_nr_pages(folio);
>
> -       __swap_cache_do_del_folio(ci, folio, entry, shadow);
>         node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
>         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
> +
> +       if (swapout)
> +               __memcg1_swapout(folio, ci);
> +
> +       __swap_cache_do_del_folio(ci, folio, entry, shadow);
>  }
>
>  /**
> @@ -339,7 +346,7 @@ void swap_cache_del_folio(struct folio *folio)
>         swp_entry_t entry =3D folio->swap;
>
>         ci =3D swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(=
entry));
> -       __swap_cache_del_folio(ci, folio, entry, NULL);
> +       __swap_cache_del_folio(ci, folio, entry, NULL, false);
>         swap_cluster_unlock(ci);
>
>         folio_ref_sub(folio, folio_nr_pages(folio));
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 245f68c75b28..29bced43b0ce 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -755,8 +755,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>
>                 if (reclaimed && !mapping_exiting(mapping))
>                         shadow =3D workingset_eviction(folio, target_memc=
g);
> -               __memcg1_swapout(folio, ci);
> -               __swap_cache_del_folio(ci, folio, swap, shadow);
> +               __swap_cache_del_folio(ci, folio, swap, shadow, true);
>                 swap_cluster_unlock_irq(ci);
>         } else {
>                 void (*free_folio)(struct folio *);
>
> ---
> base-commit: b5529903123d9535bcf74386c1f4e185e8632dd9
> change-id: 20260828-memcg-swapcache-stats-fix-1beef3dc3afb
>
> Best regards,
> --
> Bingfang Guo <bingfangguo@tencent.com>
>

Other than that this looks good!

Acked-by: Kairui Song <kasong@tencent.com>
