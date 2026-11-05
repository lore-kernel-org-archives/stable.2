Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871222;
	b=fVfa3alLK3Ae3J2LnlnPe1CthHGl8NLHEQ8hfsK1wurrMDxQfDy9LfXIvP5OrCk5cldt
	 FqlJkdhvaMLGJVUPmcYEud7Ut7fXY6kCUzFl2sdiZuno4HqnsewABA1BhUjAqDjbAd6Uw
	 A22+U91SQfXALQR+RQ/4/ctEte742ao/yiHB0pi/FqDCh8biyzmR4PykNYeuTZWzWN14R
	 fWqUDuecfaUSj6Bd6FRHltr2e/uFR1iDn4OXh4vwHHYYpfOITILPEWvFSljpikgoIwhh7
	 xgHjVAP1TJygFZADMwgaHqzo4l7MZVrZKL/0co9eQx8R/SdzptJ01E3qribp5qeagkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B9M1jKc5WShsgBoTJ+bYEs7oHPuVcQGJEiYWo3gvijw=;
	b=CQQHl+dAvfAu9dDBTjNjLhUmBJHxDgGob9XeEwA0rF3toNCyWO9GeP5OhXWjmsWPfAm8
	 7pizPlg71b8xZLlHBVeVnqI+Q/RB29Mt1uJXcjsaNRLpbwWK9uEvDNZ2/3hJuJhheek69
	 9eu751MoIdWD/cDCihqNTO4cTT1vGDeLdRYHOhKfbahAm/u7NWGy2ai+U72O1KHddy6W+
	 kw+LGEwc+N7PxY8Sqh1L48lWpRfCAycHva2mlOqwu2edaYhBYHvCny5+OBRnOtc6TXS4a
	 GxzxRNaOH3fhrD/1jNtS8VkWY6YrRzXbPTAZ+MkijfztFPDltOlt343rSgF/EsoFRnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4pVjiXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839E606A31B;
	Thu,  5 Nov 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4pVjiXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C11F00A15;
	Thu,  5 Nov 2026 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871221;
	bh=B9M1jKc5WShsgBoTJ+bYEs7oHPuVcQGJEiYWo3gvijw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4pVjiXqQWR+5SFY4TKFoYUfEMsE72yuHNwRK2I41rxQuY/4LbRXQ3ko3EI+vkg/P
	 c3t9TL6FMacOdgZ88Dqk9Pyo0kDgU5qbDRTydfg5vlzJiQf5yyt2y8OZZlFEBUct4l
	 AVq2YNScTMavI2su3aDV36L9wqRNxRMU9H3gKoQmpG6KwCttP2eoIChKmjnjCV7GAV
	 65LAONyGbAzgTALhT7n0xP/HOw7uhtxt6qpgiN48V4OdRIbiT5YgpKrns28GOCTs8b
	 fRlP5n3H184cK07tK8cIDlPnF9xH88lkpuPz/LxIJ5sNSsHe6G1prAvEeM2nBx6j4e
	 jMMOqP+++KBCA==
Date: Thu, 5 Nov 2026 10:33:35 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
Message-ID: <auxNbw83G5v3nvI_@localhost.localdomain>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>

On Thu, Nov 05, 2026 at 12:07:44PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> unpinnable, causing unnecessary migration or pinning failures.
> 
> These folios already own their CMA bitmap ranges, and memory blocks
> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: stable@vger.kernel.org
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

With the rewording suggested by Munchun:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
