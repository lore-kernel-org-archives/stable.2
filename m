Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091597;
	b=dEKMrlf8+m5dfgaPiPrVQDzkFbKbf+UyNhPfrkXRJNiGknCL1aB8DLW6NvcfuUv1kOjr
	 6zpeH4nJEciyTBknsVjaYpfsfeVaJJuqAYmqXPP1640B5PtyzKpAMNI8J3fcK5hp0QRwj
	 kdV0a+YC+xEk0Zw+djsDm2j1N0WAUpdN55ZNhTXyr3PGS4ixwMwgVsyQBx/r81MjCaXXn
	 VayXUUw/fwQXzgETJOXYtdvAzSFPtWe/RJK89tWoOj6f4d/f3Byfbl0RXsMzRe3UD9FEN
	 68ks1e/8rzEp1ke4ARzC+3FTOReeUb+OL9k/Y9+eANMEk+sX6o0kwf45mScdrHpc+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091597;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=m6D1TMuAeRek2s1DNXoMx/ngM+qIMzVdkNgeKSRi4QI=;
	b=ZGm+jjY2zvsZ8m6Npka0W4VhqT6BkvMeukrx0gX1bl3IDzawY9rT/k8tLD3GRvuwITBF
	 snyfwf7N6THBrm0vBRmDMbkft9fHpfQkxCaCW6u9Al7KLfDnY1gKawLcF6fD+HVWnDoNd
	 L74tpKfbJWMzBzp0oZHurLgCxEGoa23QoGn15jRHqqZtJqqCOk1V2kTDg2MSUiTYPbGY+
	 58E/frprhRc2LCGGDg7XuPjvArbxa6fzYMPLWwVNURPKOVE6dM88xu51BcyBdB8QXH4sF
	 J0GbOp1+8pxgrE5IgK3YgyxomkjYczlHJRrQcls3cgybi3a9lGPJfuRWGK6dP8wP/FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fxMRFOmY;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC77606A31A;
	Tue, 27 Oct 2026 08:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fxMRFOmY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793091587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=m6D1TMuAeRek2s1DNXoMx/ngM+qIMzVdkNgeKSRi4QI=;
	b=fxMRFOmY+wd33soBaZOkEcSadVJSmiqIihNxf3ScV3sPEjJv/K8LXtxNIz3x6LuLmrj699PrXjIjASwo5m3gaxcaFYU/KVTwunyf3LgGFsat/xKCDVByAxKKMD89I31mtcec1cIyBv1lYY7RgsVxaxCl7f1bNPDR70h9Xzo9BJY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDdD1uE_1793091582;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDdD1uE_1793091582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 16:59:44 +0800
Message-ID: <152d698f-d7bd-4e1a-9736-412d52e2370c@linux.alibaba.com>
Date: Tue, 27 Oct 2026 16:59:42 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] mm/shmem: fix truncate hang in large swap entry
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Gregory Price
 <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-12-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-12-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> Truncating a tmpfs file or memfd to a page-aligned size inside a large
> swap entry can loop indefinitely in shmem_undo_range(). The task holds
> the inode lock and cannot be killed.
> 
> A large swap entry represents a whole swapped-out folio. For example,
> truncate a file whose pages 0-7 share one swap entry to four pages:
> 
>      [ 0  1  2  3 | 4  5  6  7 ]
>           keep    |   discard
>                   ^
>              new EOF, start = 4
> 
> i_size has already been updated when boundary handling asks
> shmem_get_partial_folio() for page 4. Since it is swapped out, the helper
> calls shmem_get_folio() with SGP_READ. That rejects page 4 with -EINVAL
> because its starting offset equals i_size. Nothing is read back.
> 
> The final scan cannot free the entry without losing pages 0-3. It skips
> it, restarts from start = 4, and finds it again indefinitely. An unaligned
> truncate avoids this particular failure because the requested page starts
> below i_size. Folios already in the page-cache cannot trigger it as the
> direct lookup will return them beyond EOF.
> 
> Fix it by letting shmem_get_partial_folio() call shmem_swapin_folio()
> directly for swap entries. This bypasses the read path's i_size check,
> allowing the existing boundary handling to zero and split the folio. If
> swap-in returns a smaller folio, it also splits the swap entry so the final
> scan can free the entries beyond EOF. Retry the lookup if the entry
> changes during swap-in.

Make sense to me.

> Handling swap-in allocation failures remains broken and is unchanged by
> this commit. Even when shmem_swapin_folio() correctly returns -ENOMEM
> instead of -EEXIST, shmem_get_partial_folio() returns NULL and
> shmem_undo_range() skips boundary handling. If the large swap entry
> remains intact, truncation can still loop in the final scan, while hole
> punching can return without zeroing the boundary.
> 
> This may read an entire large folio back from swap while holding
> i_rwsem, only to discard part of it. Avoiding that I/O would require
> splitting both the swap entry and any large folio still in the swap
> cache. That, however, is much bigger work.

But I think this case is extremely rare, where every attempt to call 
shmem_split_large_entry() to split the large swap entry in the loop 
fails. At that point, the system is already in serious trouble, where 
even OOM kill cannot free up memory for the xarray allocation. Hard to 
believe this can actually happen in practice:).

> Original fix generated by LLM and sent by Chris Mason in private.
> 
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Changes look good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
