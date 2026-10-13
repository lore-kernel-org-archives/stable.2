Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE47525A66
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924978; cv=none; b=HFTjcLjKxmfxfW3y5+E1bmF97oq4LR3k4suRCk4jbZtWi0UNbbWnzE5ArfFx6bBYmC9qoRuklJ1ntSC7Vx3cyi/1Mw1cwt9UHOU/75vFiBKGHKAOVydmhLS5rfCH+9E1W8fIbTsku9qhpGJ4cBO3wOPV5Hmt60d7fYQMEh7Z/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924978; c=relaxed/simple;
	bh=PzbISJO+P3bAu3L9Lhmxt+iSyWjOBECQD30EekHssk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMLJ0x0LGs+0VmX+qRSXPRbbn2L7zZTqn7X75RXyDumNsSqQtY8cyj0hRgrD44dUbXnHb7cBGwDBHSxMGEDt2CZwdv1sZDfaezfd2yEPN34kfqXkBYAKb+bjpr8857imxhL2/DQYhT/ZPLMCsTBuokEReFUHzDFGJYsixGB9uN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a1V+jzNv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="a1V+jzNv"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533930955a4so31788431cf.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791924975; x=1792529775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmAAfYOVTPwFY/Zg7H8+euLMsz6Hvgkde2NCZqpx35U=;
        b=a1V+jzNvyBQS13xnSxxXUGFBv2DZidWq8YyeHDm6QJXig/UkR4b+y+3n6zOHPH2wWh
         GVApwPIT8cDz/2ByxMLPaPrvVLo+6gxhcmtGtRv7t8e1OOiybtayafU4CRGbPecxPUsC
         Hxd/g0SFMN6wti6cxRw3IAmxHW14ahRjy/s2zH2oNgCFKwoOEDL2albMJRn9Lo5C5GXG
         dOH24A2Ru1d4jAXdyTaRgcwFu0cHDCc1qUUteh6BFnwduB8m7dFdP5ErcMEPsJyU7YKC
         QLUH9TyusEb6nkFeUQXy/K3J2l3xfwx9kPVQgB1PJ7LizciieeTmkRmiNZ8UrjWoBm7J
         4rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924975; x=1792529775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmAAfYOVTPwFY/Zg7H8+euLMsz6Hvgkde2NCZqpx35U=;
        b=Y3EgRUm1vN+NfgxfTRwfJPZn5XFrWKydzRwbrujiQ2z/dUvBj+/UVnrRh6elJh7Op3
         VsI2MJE/gAyWLl0x0hW+WMpsPDZdlOL8EKmw2k0Ml/M0mCOPXPuW7Vfanm7Y8ORE7aeB
         +xDeK/cfqp4kPBlWFG8ar4OgsguuejM62keEIcQv/sdubiFViOhWRWPjRKO2prMuBih4
         VVYLn5pAGX7I0hNX/fL/CMmDOBpRpvKxbFyrNhYRItTAbkR+LWjeAfU2pWXBogDfkRQo
         oHeshzaXB38Wo8XveB0uTKbTLLKarshgnR5iqorqhhySweP758cTnQeCwyxhwK4SyceU
         Ospw==
X-Forwarded-Encrypted: i=1; AKwUvBzaNJaQqQbq7VwYMeONLHIn5DDIva1qXxNp5vnIolCw1EFHxAHXpB0LP0PVly11CFSufaKS/Tg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQcBQtzOg4n9eMHYzYx8fAA53F72DSnMOjm2tsiJBmEYiM2Tnu
	9GMaUfG+NGQb0Rl0zL9WhnVaJtS4lhYCRv7PtjN0wQaf94GnQ4vQxmwbC/BaKiEzf8M=
X-Gm-Gg: AYBFou1T3av4VjxhnO78/bC1gImzsVh7SoQUI6maaWYVyhsUGU/74kIg2Zx5XmZVjk5
	Do4DaFYwyh3E3lAhY7xQfEMLfocMxC1kxOyICgnjkbTNT7Jt/J+yjht4CapmUSrSupO01PrERVZ
	AICw6Zz9plhyjCjfa9rhjWpW7iDmBKWy9KNh9RyzuJeGwPjGEr+F4nD8jEjUYjlDqSCLJq65u3C
	8IO1ePigTYChdxxxTJbzcqj0Vsi5zzssHmkZ602YQyJbVvSX8Xk0CRB8GOB6vqd7WRlbFUjKIx/
	E3Kgvf7ihFPz6gp9TJpjnw9NR2V1pfqEieKRjY+3aDhgI/+xXwOeTgkIP0phOH7c/eZrxQG+iSb
	jlAZ3MQUjJcWm+95UwEO4wyb2hVNd2FDe0VZk7rFcy+pBViuFKNsF8S4o5peb5zU+EvW7wKuNH+
	glhp5lf6Y1i6qifWxU/oH4Gdt++ftdbX6ogqBEPefYvlPBuKqhjY6B/BBJp5TYI3tPkKhDT54/p
	cG5NuHJuu9pB7PzGnPlo/ng8VqRANMWsaBHh/k2N2moKNeDf9DhVRM=
X-Received: by 2002:a05:620a:46a9:b0:93e:7939:acd0 with SMTP id af79cd13be357-93ebd225b1amr2250843085a.37.1791924975256;
        Tue, 13 Oct 2026 13:56:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef4f497e2sm328770885a.6.2026.10.13.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:56:14 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, stable@vger.kernel.org, 
	Samarth Narang <samarth.colleges@gmail.com>
Subject: Re: [PATCH] mm/madvise: atomically clear the young bit on THP
 MADV_COLD
Message-ID: <as6ay-X0aXh9SzNM@gourry-fedora-PF4VCD3F>
References: <20261013191719.95502-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013191719.95502-1-pfalcato@suse.de>

On Tue, Oct 13, 2026 at 08:17:19PM +0100, Pedro Falcato wrote:
> As-is, madvise_cold_or_pageout_pte_range() discards the hardware young
> bit by invalidating the PMD, doing pmd_mkold() and subsequently writing
> to the pmd again. However, it does so in a racy manner, looking at a
> possibly-stale snapshot. It's entirely possible that a write elsewhere
> set the hardware D bit, which this logic now loses.
> 
> Fix it by using pmdp_test_and_clear_young(). This is an atomic
> modification of the PMD entry, and thus safe against any possible racing
> writes. As a (nice) side-effect, this elides one non-required TLB flush
> in pmdp_invalidate().
> 
> This bug can interact with the swapping system in complicated ways, leading
> to data loss. For instance, if a folio is marked lazyfree, but was later
> read from, and then MADV_COLD'd while racing a write to that same THP,
> dropping the dirty bit may lead to data loss as reclaim/MADV_PAGEOUT drops
> the "clean" anon folio:
> 
> T0                                T1
> ================================================================
> MADV_FREE(thp)			|
>   folio marked lazyfree		|
> read(thp)			|
>   PMD marked young by hardware	|
> 				| MADV_COLD(thp)
> write(thp)			|   if (pmd_young(pmd)) {
>   PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
> MADV_PAGEOUT/reclaim		|
>   dirty bit may or may not be   |
>   set				|
>     reclaim/pageout may drop    |
>     the folio			|
> 
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Cc: stable@vger.kernel.org
> Reported-by: Samarth Narang <samarth.colleges@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

The function that keeps on giving (bugs)

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

