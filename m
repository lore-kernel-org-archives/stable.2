Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079882;
	b=KBXJas+s58MFUbKZ48p4VEJ/WPiy7BYIeGz/x8W/4+ub64/N9N0xuKnk8/VRdgLHr1WX
	 AiRM7Ma7c7ohxGNNOzNhOyvlVa0YB06cm1pdpp6ztB1EDGlt5945008grw3Zups5+ZG3c
	 Ag7Pova8XFrsBUUxFuHaHvc5p6EfBgbOdeC5+Cs5TkOnrtCwwvnzjDXNAF8iJIVxbQ3s1
	 bs+BwXT92Uhz2IPIcXVyvehlJgGtzg7uwtZ2t0ozNnrRUxHnqtYj4L9izuafX7vaQzUXb
	 r5gxWYGcuZ0Ilg08dbGAzBAVV1Yx2J8JFKoy5K7lL/qSuVXu3LJpRNDPdxdUfwSqAdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079882;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aSD/uA5GzniB62u1aszYIPG0z9UbK8URKHofuIPTWTk=;
	b=BJiwUTO+Fsqc54GyKlQTfHSE7KXGU0lunieopJ3kZGMuv+5WRAWW8vEmjfUKsHa+XGs0
	 +kHdiIA4HGR36gtR0OLvy7MOpPZik+n6FVldVM0Q/W8c10zGGnWxVoGFvcOzTgzDYqabw
	 rFuCLbHgy7y0C9lXzu7SXdGyVr6QZaYsv9gRxzBwrxdP5884bs1l1YvV9MX0m/kjOkIg2
	 BECca9snppSBRDJtAPwJGTh4Qf03dDyGtuJ/HLgBl1U36H0jAywqpLSFmqPtqNFTa6z3t
	 E9yD9HinvgX4C3OsrjIGTG/RQNcD1VbVPyBdHWZH9oRLKVA6KLuXdyWxLInoWpAXY3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NyUV7tUJ;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DA606A31A;
	Tue, 27 Oct 2026 05:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NyUV7tUJ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793079878; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aSD/uA5GzniB62u1aszYIPG0z9UbK8URKHofuIPTWTk=;
	b=NyUV7tUJLJAGILy3i9leMXptrzlVSQ1RMoIV5rre+g2Jdc0Z6+Cez9tv1wrlV56GABlimvzD17fPV+mb2wnnAb7iDZi5VOSHN7uYlpYVqOPPW6rL4OHq0DSDRtnr1WC+tfhZQd1om4vo5LMJo9sDnTARU6CB4vyW8I+t2eKU2dw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0XDcpFMl_1793079873;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDcpFMl_1793079873 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 13:44:35 +0800
Message-ID: <738ae37e-71f0-4539-be59-e64023a8e237@linux.alibaba.com>
Date: Tue, 27 Oct 2026 13:44:32 +0800
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
Subject: Re: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Once shmem_writeout() has moved the folio from the page cache to the
> swap cache, the folio lock no longer keeps the inode alive: truncation
> and eviction find a swap entry, free it and do not wait for anybody.
> That did not matter as long as swap_writeout() was the last thing the
> function did.  But since it puts the folio back when swap_writeout()
> returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
> afterwards:
> 
>    reclaim                               last close of an unlinked file
>    shmem_writeout()
>      shmem_delete_from_page_cache()
>      swap_writeout()
>        zswap_store() fails               shmem_evict_inode()
>        writeback is disabled               shmem_truncate_range()
>        return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
>                                          destroy_inode()
>                                          ... RCU grace period, freed
>      shmem_add_to_page_cache(mapping)
>        xas_lock_irq()            <- use after free
> 
> swap_writeout() behaves that way if zswap is enabled, cannot take the
> folio and the memcg or one of its ancestors has memory.zswap.writeback
> set to 0.
> 
> shmem_unuse() already added infrastructure to deal with that.
> Reuse info->stop_eviction to protect the inode during writeout. Increment
> it before removing the folio from the page cache, and decrement it after
> swap_writeout() and any attempted reinsertion and inode accounting.
> In shmem_evict_inode(), wait for the counter to reach zero even if
> swapoff has already removed the inode from the swap list. Add some helpers
> to make the code easier to digest.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() reactivates")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: code cleanups; improve description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM. Did some shmem swap and truncation tests, and no issues found. So
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
