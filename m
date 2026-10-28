Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151073;
	b=fHH1RsxlKsyp2/bWclUfDLXMOuS298q3EF0qLj0jPHtVaJyKXM6UgaiAIjlbJ3boif61
	 6yMwVt4EJVqyRGf39LqEAvHzhKtHHqqMACzhe1lhM0yZeUhkSX4Ki5CIfbDSvaCTo4FUv
	 +7E4Et98mrdavp1GmXQiojSKiHm71jsgImvTNOEJi0MMjqB9sfHK0zUMtqhQ8F4wB6eyc
	 KkU+zznoToScAhK8pijlmWERkmYYGi60FCc9BiPbEmV3yuEjhjDDs6wgDlTDjo9lpKjad
	 boITM/rsbOfM5hJhuiT4mD3nBfNUN/JoxYdToB0FC1IT2pCpmAAkl69bSjIGh3U0ivA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151073;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+s8dDKZ4dMb+kRwqacBsw98RYGi6uf2pwBAWjpaxZWo=;
	b=qk+uMzT9RBz/sPEKU4QbJIYKr2y6WS7/B80mP6/BVnSlx15mBbjy8ZkIBXrAvfe6fChI
	 9NTrpfQfN8nkutzp9rDTJUgE4/dUdTtFE40qxxFgf8lk16T1rawVke2Da3FGK0UqaOvoh
	 BisxAF+4Q6EJk74TiXLzmIp5gnw8CXqgGUgi+OHPm6ZTFEbeBKwRI364IpsnMPki8A6DN
	 m1Khr9TjvvWor3uGgXSE3IwfGxHyfHN/+L2abdbakOwiZ1W7v0WfcpiMVSu4Z+PR9noWQ
	 5dzrsYtNbHsyGTcO0EKqoiGAgBK6tCb3jn0HakRqKcB121JJUAmfyTSARC6hHEkCBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fak75bFc;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33387606A31A;
	Wed, 28 Oct 2026 01:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33387606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fak75bFc
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793151064; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+s8dDKZ4dMb+kRwqacBsw98RYGi6uf2pwBAWjpaxZWo=;
	b=fak75bFcoGWlNra/g4irAv5g3GeUYq0AF1JJYCw7StsWQc1UhoI3X5EoXZ8YiD3ax3vmVqj9BnxbQcT4UyVZJ+CaMgxfQlIUBWAWGZLYOr2w29jslK2tnBxKAMrP56yH01GKD4z6FoYrKtInPkpeQbU3Zrx1rvgRgS3XncxxGNM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0XDfHy5f_1793151060;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDfHy5f_1793151060 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 09:31:01 +0800
Message-ID: <2d111275-e7a8-4ac5-8618-f068e87145f2@linux.alibaba.com>
Date: Wed, 28 Oct 2026 09:30:59 +0800
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
Subject: Re: [PATCH v2 12/14] mm/shmem: fix truncate loop after boundary
 swapin failure
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
 <20261027-fixes_shmem-v2-12-86a00952acb9@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261027-fixes_shmem-v2-12-86a00952acb9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
> If swapping in a large entry at the new EOF fails, shmem_undo_range()
> leaves the entry in place. Its final scan skips the entry, then restarts
> from the same start index and finds it again. Truncation can loop forever
> while holding i_rwsem.

Right. But ...

> Advance start past the skipped entry so that a restarted scan can finish,
> as we already do for folios that cannot be split.

IIRC, we originally avoided advancing start because a concurrent swapin 
fault could split the boundary large swap entry via 
shmem_split_large_entry(), leaving small swap entries below the new start.

Sigh.

There doesn't seem to be a simple fix. We may need to swap in the large 
entry as shmem_get_partial_folio() does, and then split the large folio. 
I'll work on this as a follow-up.

> Note that this does not fix the missing zeroing when boundary swapin fails,
> it merely prevents the endless loop.
> 
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
> Cc: stable@vger.kernel.org
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   mm/shmem.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9a11de010ed7b..4ece296a1ccf1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1434,14 +1434,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>   					order = shmem_confirm_swap(mapping, indices[i],
>   								   radix_to_swp_entry(folio));
>   					/*
> -					 * If found a large swap entry cross the end or start
> -					 * border, skip it as the truncate_inode_partial_folio
> -					 * above should have at least zerod its content once.
> +					 * Skip boundary entries when restarting
> +					 * the scan to avoid endless loops after
> +					 * swapin failure.
>   					 */
>   					if (order > 0) {
>   						base = round_down(base, 1 << order);
> -						if (base < start || base + (1 << order) > end)
> +						if (base < start || base + (1 << order) > end) {
> +							start = max(start, base + (1 << order));
>   							continue;
> +						}
>   					}
>   					/* Swap was replaced by page or extended, retry */
>   					index = base;
> 

