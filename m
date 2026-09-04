Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AB3E316B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538210; cv=none; b=ZBYF7zIY66KOuNunZxBrmjpgpoy3qDcid4iHrZ4abz8fsm4pnjKLaCFWmhGwtTats4Uty/CJ1FkupjFGwvr3qbPkMa+Z4gNh2kYQbFedzsNKYo8l0eVCcvCF5uZr6cg3QCR4Zsw0FparBwup701kVnNJXVWh+VEwj8ambdJYYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538210; c=relaxed/simple;
	bh=P2rW3hKxGUs4nS+9TbwXfR4YDLmtL/y0lG03tWYudJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciu9coZCp9zfJZoDasHENRIi1vqHp3yewu2bNleIvG9jvY3qbUj+7WZ1nq1ZjDvXxivY3jbJ1syiyjojdEQ10VteAzRznumg6gjKKTRnXdnb6U1mjvX2CY7PUpP8hnS8Qun0gkV7K9WAc0y7RaujPNFJwDIxKY31jOX0HRnLiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ipShBVYG; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ipShBVYG"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-936623c6dd3so274279485a.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1788538206; x=1789143006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/dj2tdiAd1cTUZz8ylHlEPfPG8XqvRkzCQtnk9erCM=;
        b=ipShBVYGUEPVo/2xJcwbG8HL69uayIEmWrV9qfp3YrpAq1vKwLSCgwjOEEF4wYoP0e
         sKqEWfuatCdPtXWRMihqoXAnjjIx9Rtksb18qhi/3nMSk4gA5/Kx+lKQLFOlvvWEYHxc
         7xIACYFAbw39B3PyMKMzu1Grac/91Zv5mmQP3Og9jqTuntnd/kfiNoeFuNIj07I0xrXL
         nSVYfcZKW1AHXvAmOVpDHMA+Jz9miNOIeX3DhkX7SvoDWq5b5X4apmAXPq+LsK3hu3Wx
         EL/KYgjj/pD7C1C3C9AvT0+FB2qjvHm/u1Jdu4py9eG2aZHnmBQ29OFQwsaGRWbU1xl5
         BaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538206; x=1789143006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/dj2tdiAd1cTUZz8ylHlEPfPG8XqvRkzCQtnk9erCM=;
        b=Yi3lxI0g1qgAzTvKTa2Gyq8eoEWS8FSN6zLT/ap5xfvkz1rZxgxxj+zOsAtRDfJusy
         PNwDBY2QDSENPOUxm+17iABm9631TL11ulTmFUgBzGHGofkttMRSlnjuGi8i2yJLsy4h
         Bwm1XulI0JwqzdIekYT3eXIdvmb/h5+Rb8BiCggsyIVIvHuVNCm75WlC5/oGEPBytyDc
         xAfw97OSZq5r8QZ5YPfHp7edaF8pNp0NUPTFi/v7iKgDEXto2oTEZS42HoGI9IB0g7y8
         5VNr9us8pgIL3sVTSHmjTonif3fydgVG9iTB8nckfGx53JDDb4HBzkK4hkHELv1Zot3b
         bvvA==
X-Forwarded-Encrypted: i=1; AKwUvBxOzp1dANCrhUA28y7QK/hn7S6nZ0WxRJpn39jOIZpIQ+mzRw0h3qzmiwzP70RSod1odybzdVA=@vger.kernel.org
X-Gm-Message-State: AFuF++lSkCJi1irbfkrTOCBw+Pxekmr92besiHNUI8oqwaGVdjAnCpE7
	J52oy27QwY7Y1khlkPxDzmijXy2PIbcLM96Li51sA710cuIBm5X/wH4LUc94v1mFY00=
X-Gm-Gg: AYBFou2PGSr7poFVj1/Yq2r2U1STUdX/L/24WxPboKmxRcfHPCxITjDltQQ15CKjsnp
	jGu8mrZtUDV7EqkfeJL53SOMbMo78o8U1KKpPWCRVByBAKQ7l44hEuQr1EqIBfILM+5xm4c0nXF
	otsUe4SVnZ065Qa8mG9AR7DaJlyraVAqQvWw5gVrzaU/PxlR8JG8n9htleRP0BkbxAb6d0SLASD
	CJ3+gghud32j8PONYF5lUMPAab6AlmBOAcN/QR6+HN7poZXLxvb3Fv2HnsNLxM+fG1KAyMbbURu
	n89bC4ppV9YJFJXGbUKPD4D6UD3Na1vsnZGR3tYFcL6cElz9Zn7U/HMBF8TwYggkzyLBdN/6mT0
	2jLdV0upSCtOA/K8lLyxhRmKJQty9oy8QxnjDdoBqIbig1K9Ad4dYDx7/PP0YzjbwVQ7TZfEP1I
	QRsvGf6ZqFuxQyhx2Ij1yaVg65HOxZjaZsP+Dn
X-Received: by 2002:a05:620a:6cc6:b0:930:f285:5ee9 with SMTP id af79cd13be357-9396e0b2fc3mr1194176885a.20.1788538206229;
        Fri, 04 Sep 2026 09:10:06 -0700 (PDT)
Received: from localhost ([2603:7001:f100:501::2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067b125sm23869576d6.29.2026.09.04.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:10:05 -0700 (PDT)
Date: Fri, 4 Sep 2026 12:10:00 -0400
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
Subject: Re: [PATCH v4] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <20260904161000.GC6641@cmpxchg.org>
References: <20260904115629.3993331-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904115629.3993331-1-dipiets@amazon.it>

On Fri, Sep 04, 2026 at 11:56:28AM +0000, Salvatore Dipietro wrote:
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
> For costly-order allocations with __GFP_NORETRY, clear
> __GFP_DIRECT_RECLAIM at the very start of the slowpath, before
> can_direct_reclaim, can_compact and the nofail checks are evaluated.
> This makes the entire slowpath treat the request as non-blocking: no
> direct reclaim, no direct compaction and no drain_all_pages() IPI
> across every CPU. kswapd (and in turn kcompactd) is still woken further
> down for background defragmentation, so compaction keeps working for
> long-term system health while being removed from the latency-critical
> direct allocation path.
> 
> Allocations that also request __GFP_THISNODE are exempted.  That flag
> pairing identifies the local-node-first THP attempt issued by
> alloc_pages_mpol() (mempolicy.c), which relies on direct compaction to
> form transparent huge pages.
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
> 
>   Config                   Avg TPS      % vs Baseline
>   baseline (no patch)       59,408       -
>   With this patch          155,409      +161.6%
> 
> Link: https://lore.kernel.org/all/20260403193535.9970-1-dipiets@amazon.it/T/#t [v1]
> Link: https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u [v2]
> Link: https://lore.kernel.org/all/20260710143437.12379-1-dipiets@amazon.it/T/#u [v3]
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
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>

Looks good to me, thanks for keeping at it.

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
