Received: from mail-qk2-f11.google.com (mail-qk2-f11.google.com [74.125.230.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CD45C700
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159460; cv=none; b=gCifAyOIU6k9k59jCP5c75MJGzhVSTb81SJoigK0N7ANxjwKBK1IyO3XV7Eds27aPOWwU/AmetzflVDSLVOh2As13bbM77+PRTJJnWcHFXzrj6e2uwXoqElYvuQZl4L32FCTJY2aEnxSlnQof4XUuE3k5rzpXS12WuKNq9UQod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159460; c=relaxed/simple;
	bh=9KRmBLpDfExqlzXDVHUVK59qu4C/6ghjdOd9zFQjQ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn083nbu1NCq+TZWUthzdEXyDXvRqe1HId8zzyGnUfH9obxaL19HPbgeXDTmeuIp8US8dKnfyrGEgvbh7VN6VuehOW3FT4MpEOJnZk2Rs/1OVlPNbF9kxy/9lcC6i7n6KZxXcJD1Dwwd8/8/YZltTCu/inwoWdUZzAAf50S/QqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=qyoduPel; arc=none smtp.client-ip=74.125.230.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="qyoduPel"
Received: by mail-qk2-f11.google.com with SMTP id d75a77b69052e-530cedd4e6eso1825961cf.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789159456; x=1789764256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FDi78tn+rNyw2f5XP4H8xqn6L7v0YajTpN+MIEXmNi8=;
        b=qyoduPel33nPtdq/ko3a8YtkDb3zIeUPwdUpVbazYDFTpundfnYW9Oxh4tzKauU9Ei
         BGisEXp6AQZvGgAYzf7RAEaofve4Af7emK0sCBGXYPsVCBVBzhe46sUKd7ufjzEUWOXJ
         U4ViDbp1OjP8TqGvyPewYd6vHWnI+IBEutNiacFeVtNmTq+KLDrabYp8n4p6pYJ7g8kt
         QVTf8aZNDRfCFaU0dYrLN36lPNdDgoEc+JH3O060cahbwXtByrZMeAF8raN/NZxLDS18
         B9+N0GjWoqs/ZafGY7BYh/KPEbh7+ihPQTNKYfNO+sC9DsqLjJ9jvdq+Ex1ciaH5c64D
         JjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159456; x=1789764256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDi78tn+rNyw2f5XP4H8xqn6L7v0YajTpN+MIEXmNi8=;
        b=jztedGZViwgLVfDcy/21tGaqKtNhXuoOgnc1yQ9eAUNavCf9ezWen4FaAzoM+VoD3Z
         vA6CzxeXSB5OrLRk64FhT5x/WLS4OZ/3Ic+l/OhvPsrYNMdmhXFpBAUsAjjlbBXJdN15
         6LDi8EcP07nQRJCkefHoc+ZtuhTZVCNtq6kTPEWoxDfwhpr/kGCarid1uX472eyBiyjp
         BbpywRvJkaFefYYMPoZSw/HGKq3STMtcYI/p+X447WYVvfNA7Vg30YIazNTonhrKdrQp
         ICSUcP1atyT/iGn/VEhCayKEMnS7775fAVDlmXRnpf9tZ8TUrXYY5X+kGNndftgq84lH
         cWTw==
X-Forwarded-Encrypted: i=1; AKwUvBxh7fBs0lbOdV7/SL5PutytRe8tIvhJobCLkhrlNIRtfoIDxTs7rXQwtIprsoDXWQqRvnoWkgg=@vger.kernel.org
X-Gm-Message-State: AFuF++n+SsGxDWumjh2u1yY9vOl80EO3+zF8xZRDLYHLWvRalP9xFSXh
	3BA2uAMWMObVfOfEmGX/b0osqgJk6IPawt+Slts4zycYDL3iPIhwRcMzoxz1VrDW0zw=
X-Gm-Gg: AYBFou2CPpuH/x+RNuDOA67twIV4fKggnc8U+HQ9t5qoc/ToR4ZC7PC64KcErV9fLU/
	KMVwlnq3qPTthBhB7aHllJ/4E7rgFFaY4Z1mCodHxq560/WKe3dyV9deVoDVZUg8m0dDzZiSOy4
	nh3jg861LKjSwNYX7mGHTq1xRoZKVJjSCTD+IIgni1J/YStsSNwCxuNT0Tbd6FvF4I6fPkJ/kfC
	CDVJBe5bN8XqPDIawabEhXkbLEdtRngQOJEOcD8HRAqjmsjSUwQy+UPm9OS7TScM5ZDm6HH2RKj
	fCkjhx3BwND0wFJlyXUF+ZX+fuGQDB+joHlkyIVyeoUie2WQYw1jtluNfL73f0/87gdQRuya0TB
	Op7xQNh6vn7mZ+0w9YlMttd+xCynzTiDFLaQy5hBiiHwb20EGTCoDPt8YrMXy/dJcL8OAMY2kdw
	WHqJ6Drr24cF+7/kK6GbN9oHxDX1mfghPE+RCp4TwcjBX/ZzOdWUQzq2QRZdU3zP49LYi3Rg==
X-Received: by 2002:ac8:5e52:0:b0:530:dc5e:27b8 with SMTP id d75a77b69052e-530dc5e2fb1mr37003331cf.27.1789159456019;
        Fri, 11 Sep 2026 13:44:16 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca511ff0sm28939081cf.31.2026.09.11.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:44:15 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:44:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, abuehaze@amazon.com,
	akpm@linux-foundation.org, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, jackmanb@google.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, willy@infradead.org, ziy@nvidia.com,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: Re: [PATCH v5] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <aqRoHr8XGzzDUjBk@cmpxchg.org>
References: <20260911142102.2294202-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911142102.2294202-1-dipiets@amazon.it>

On Fri, Sep 11, 2026 at 02:21:02PM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the iomap buffered write
> path.  When memory is fragmented, each failed costly-order allocation
> enters __alloc_pages_slowpath() which runs direct compaction and
> drain_all_pages(), causing a 0.38x throughput drop on PostgreSQL
> pgbench (simple-update) with 1024 clients on a 96-vCPU arm64 system.
> 
> The root issue is that direct compaction is too expensive for hot
> allocation paths that have fallbacks to smaller allocations.
> __filemap_get_folio_mpol() already marks higher-order allocations with
> __GFP_NORETRY | __GFP_NOWARN, signalling that the caller can handle
> failure.  However, the page allocator still attempts full direct
> compaction for costly orders with __GFP_NORETRY, which is unnecessarily
> aggressive when the caller will simply retry at a lower order.
> 
> For costly-order allocations with __GFP_NORETRY, suppress direct reclaim
> for the whole slowpath by computing can_direct_reclaim (and hence
> can_compact) as false.  The !can_direct_reclaim check near the top of
> the slowpath then short-circuits to nopage: no direct reclaim, no direct
> compaction and no drain_all_pages() IPI across every CPU.  kswapd (and
> in turn kcompactd) is still woken further down for background
> defragmentation, so compaction keeps working for long-term system health
> while being removed from the latency-critical direct allocation path.
> 
> Allocations that also request __GFP_THISNODE are exempted.  That flag
> pairing identifies the local-node-first THP attempt issued by
> alloc_pages_mpol() (mempolicy.c), which relies on direct compaction to
> form transparent huge pages.  __GFP_NOFAIL is exempted as well, so a
> must-not-fail allocation is never made to fail.
> 
> Test environment:
>   Hardware:  AWS EC2 m8g.24xlarge (96 vCPU, arm64)
>              12x 1TB IO2 32000 IOPS RAID0 XFS
>   OS:        AL2023
>   Kernel:    v7.3-rc1
>   Database:  PostgreSQL 18.4
>   Workload:  pgbench simple-update, 1024 clients, 96 threads, 1200s
> 
> Results (average of 3 runs, TPS):
>   Config                                       Avg TPS   % vs baseline
>   AL2023 stock 6.1 kernel (pre-5d8edfb900d5)   136,942           n/a
>   v7.3-rc1 baseline (no patch)                  59,408             -
>   v7.3-rc1 + this patch                        161,994       +172.7%
> 
> The patch fully recovers the pre-5d8edfb900d5 performance, bringing
> throughput back above the pre-regression level and well clear of the
> ~59k baseline.  The AL2023 6.1 row runs a kernel that predates commit
> 5d8edfb900d5 ("iomap: Copy larger chunks from userspace"), so it is not
> directly comparable, but it shows the pre-regression level and confirms
> that the ~59k baseline is the anomaly and not the norm.
> 
> 
> Link: https://lore.kernel.org/all/20260403193535.9970-1-dipiets@amazon.it/T/#t [v1]
> Link: https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u [v2]
> Link: https://lore.kernel.org/all/20260710143437.12379-1-dipiets@amazon.it/T/#u [v3]
> Link: https://lore.kernel.org/all/20260904115629.3993331-1-dipiets@amazon.it/T/#u [v4]
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <dgc@kernel.org>
> Cc: Ritesh Harjani <ritesh.list@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>
> ---
> v5: Derive the decision into a local flag instead of mutating gfp_mask

I commented on the v5 variant here:

https://lore.kernel.org/all/aqQlUr-1h07G8JWM@cmpxchg.org/

I think v4 was better.
