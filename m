Received: from mail-wr2-f17.google.com (mail-wr2-f17.google.com [74.125.225.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB83911B2
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576930; cv=none; b=IofxyowBZn+K+Xcp2WJBrku0CS/q2d9tN3dnhV3s7t7skrvcKTXFMdZWVH3oOMH4eRmemTZljmakOArgQkri/7OjTcGw8GnwsP9gfcH56L9S2Sy9ifx+NFdS6xVTD/uiNnNfN8BhPCMHqNpwlsu/rIMpIkTtX2F9XE0Jl1iOYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576930; c=relaxed/simple;
	bh=m3KPpRq+cNgFaSPI3z9noRAscHUfVOmBnPDUVtycS8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg8HCUixxkJ4zrIuFtD5564B7PZFRWJgggNrMn2PM7jgWPXDr1UDx9tqqFtzrlEas/6iWjX9TyiReelPYkdrq/sX+qSkWEHsnIEDFWSI7zcQcdbjOZRZJDQQ1cUlbpFDHMzyCT9DsfzTP60kZbNvG6iyfWnIbS54AMy1TZfq08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3YEDA/s; arc=none smtp.client-ip=74.125.225.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3YEDA/s"
Received: by mail-wr2-f17.google.com with SMTP id ffacd0b85a97d-4887d06c669so2001331f8f.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576927; x=1791181727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlTeCabh7BYu07oJry0uYVnPTkXCqqBZzgHeANLiL5M=;
        b=q3YEDA/s8miV/tQDWLeiw2qpDxUhHcd2UyG/WoNruGzydR+fzBfIhK2OSjuYISUIF6
         rhNHP2kwj/Ui93DejjrKJvhYcOso2I/Au/5Uw1Xa8gGDO5roBK+fneDEGCPsWANfQKgQ
         gvvNlWfdgiiYEX+qr2Lk2HBqffH92UiieAXc09chiXyDbxNzu26XzjQrw0VGXYQG4qLu
         JCci3KpkrX0vwMg2g2tZyXOP3Fm776nPBjqg+B0a62tHBg2TTFHqWfKuvAjlifZScemZ
         i7wmFxEcxD+nKXx6GxAIgyMv5pxwg0BzR3yJI+8duuKz98MclTIh23wafW+cGEk5XTZf
         Ye5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576927; x=1791181727;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlTeCabh7BYu07oJry0uYVnPTkXCqqBZzgHeANLiL5M=;
        b=qUdTkNeSn1qjWBuBPUwCmjhno+qL0egvkm3dDu4J5r70M2G5m2yjpeP2JNuWNzNX2r
         ftgko+Z1RZ9s+lCkJ4g05wNRCihwamdm9eaImUYO3hStkwMHbnKuBXXI3zC2cujsRBJ0
         yOiovWliJGlX1ezr2wA29Wjh9KBwx4qsyBIDVEfNlc6hKCI8AOfKLKkEtCshIwCUGcQP
         KM78MUi8F//so8WZ0iAXkztk0WMm7mZE0CW9SJwvxPSPXFbcUVTAv3GnkxKcDEVW2yyC
         jdVb2TnUblNF54EMCGgNpH6RJwTWv0/Z3tFup2qPLxdiLZv2apvnwFReZyTqqENMDqfo
         BEbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm0D3YbPxqSdz9gZDr+kItl+JZyt4qwDuACmKRvTl11bcRMvseQ+DeCk838BwJRMASKBpM+5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNHLy9BeAg7HwgYWTgJpLuL2uiQ3Uz/TPzOAS8HKwBtaCGn7ot
	pnI6/tWtYJVpb2pu5En9erjax0b5QSoC+9OI2xxTajTLCTg1wtb7yXOa
X-Gm-Gg: AYBFou27IUXfAFCtTfUi79+m23ua34qZXk3aTSnD3RrcfMrwQHfoGv1nI15iPgN8NUf
	FLMMLHYltKOnDXGTt1dU3gZcZaNPk/UjccQye0pucEdjjMuGOJqek5kXpvwd9dX5D2irdpgf7h6
	UYCj2FfxL/C+I9ZOrLxqL+cnq0oIguYMiJzf0/xyu8zuUqu/85ADq/4SsZAsStrtVQ7MrS+d/PW
	151oaBcO+9aNT+M6cT129G7Ig8G+8uGCm46cmMs9yPfq++KNXW/Ya4QZI/sT7qejPP44ikv8je+
	aPP5PA+z7pcTWellb0lLqq2GTYezAHI/aNYMyGNd+BPKfSlpQjqg9QIJjDHNMqPA2HvvvC2w4MS
	r3wJ10qPj/6EdrTfpSIkmPWYlm45oXbR43tYy4Cvf01/6wByaG9iLbA8y7SJmRJX1A4djxwE1r5
	t/Y+o3PZTPR5jNo6AHqldyo1uDi0kbXPyJi89HKXsSjqXZE9/lM2qGS6aIATr4TuxtMvsJWTlbj
	4P1EaFaer4a85SCyaZ75giXxqyXrPd5M3Yt7wgerLS1pX644/Uz+OLgOTLPO+lYJIAElmbiyjUr
	38ecb8Iq6cyz1tB376Vtlh3ZCqqRNCMzv9UPuVW9kZ9KVktc/cchNchasiOaDbkBss5KQHDaFrk
	LWZw=
X-Received: by 2002:a05:6000:4908:b0:487:2805:6834 with SMTP id ffacd0b85a97d-48872ac763amr22046956f8f.42.1790576927074;
        Sun, 27 Sep 2026 23:28:47 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ef3asm25338956f8f.30.2026.09.27.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:28:46 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:28:43 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Zhao Li <enderaoelyther@gmail.com>, 
	Jinmeng Zhou <zhoujinmeng@bytedance.com>, Alex Shi <alexs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com, 
	jthoughton@google.com, rientjes@google.com, vannapurve@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: hugetlb: Fix subpool usage leak on allocation
 failure
Message-ID: <aroH94a5F4Mzuqgd@gmail.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
 <20260916-hugetlb-subpool-always-track-used-v3-3-38aae9b5ccdd@google.com>
 <20260927170426.2467-1-kmehltretter@gmail.com>
 <CAEvNRgHQLifmcD1NO6cd7EVcCiQb6gJgNUo4HkFhZAvzuwMq0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgHQLifmcD1NO6cd7EVcCiQb6gJgNUo4HkFhZAvzuwMq0w@mail.gmail.com>

On Sun, Sep 27, 2026 at 10:19:08PM +0100, Ackerley Tng wrote:
> == Questions for Karl
> 
> (Independent of the "Path forward for 7.3/7.4")
> 
> 1. Does squashing patch [4/4] of this series into [2/4] [3/4] resolve
>    any of what you found?
> 2. Does patch [1/4] introduce new issues, or does it just not fully fix
>    all the issues? At this point I think we have so many bugs, it's more
>    about fixing bugs progressively (not regressing) than finding a
>    complete fix.
> 3. Would it be ok if you integrate your findings across your two replies
>    on [2/4] and [3/4]? They're similar yet slightly different so it's
>    kind of confusing. If you have reproducers, it would help to share
>    them! :)
> 

1. Squashing the unchanged patches does not fix it. Full v3 already includes
4/4, and both controlled tests still fail:

  Path                     Cleanup       After files / after unmount
  -----------------------  ------------  ---------------------------
  hugetlb_reserve_pages()  +2, -ENOMEM   2 / ULONG_MAX-1
  alloc_hugetlb_folio()    +1, -ENOMEM   3 / ULONG_MAX

Both should end at 4 / 0. I got the same result with one and four vCPUs.

Patch 4 fixes the later region_add() failure path, where the global
reservations have already been acquired. These two failures happen earlier,
after global accounting or folio allocation has failed, so 4/4 does not
cover them.

2. The exact v3 patch 1 does introduce regressions as an intermediate
commit. It starts tracking used_hpages on min_size-only mounts, but the old
failure paths do not undo the new charge. In the ordinary tests, with or
without the two queued fixes below it:

  - after the SIGBUS test with no files, HugePages_Rsvd is 0 instead of 2;
  - after the failed mmap and unmount, it is 3 instead of 0.

This does not mean always tracking used_hpages is wrong, but 1/4 is not safe
on its own. A reworked series on top of Zhao's and Jinmeng's fixes will need
new testing.

3. In both races, hugepage_subpool_get_pages() first changes the local
subpool state. The later global charge or folio allocation fails. Another
operation then releases capacity and a separate mount consumes it before
rollback. Rollback restores the local minimum, but its positive global
correction fails with -ENOMEM and the error is ignored.

I put the exact test hooks, both userspace controllers, QEMU helpers and
validators in this test-only commit:

  https://github.com/kmehltretter82/linux/commit/3ed79d756dc3845b9af9dc1dec3daa8cb141a500

I support merging Zhao's max-only fix and Jinmeng's combined min/max fix
now. They are useful, narrower improvements and do not try to cover these
min-only races.

Karl
