Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9937CD5A
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068376; cv=none; b=JXG2o6LHVCrqH8Rw8bfVQqKTCuOu8MRCU/pR+kS5YlnB9mBxjREC2ta4qpfmF9r6bNbXeZzzBEUtrItOegaH9Kld4fZLW9hXWTKVn9tsboqwAuU/8e0IrG5MpfNlX2xpDpuKepi4HCK3kO1wG5VOz84l+IEKpZreeuq3sbb5Hns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068376; c=relaxed/simple;
	bh=nLQeJkCbFzI3yfdneh5Aa+HN3kEcEpa3wN+zJbNDcKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEjZGxPHy8fJsi2mVHhXjsKi0gZCsZ0YmaMJBMcw0URFEoDhOQCShdnHuYQ1SSm8VH2unMSne8obN3O2rr2DHMUtmj+Lrs/zXLl9KW/1T8t1xq4MscxPw+RLRDtb2p1gtlWkyy0lY6OBzxvE4Hut6RXsVxnh+rxIauC0N2/jBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2BBHDf7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2BBHDf7"
Message-ID: <6a547571-e60e-4b36-9968-011e3d880588@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783068359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60Vpn3H5TSaITeEafUCSZSGw+JUZcFB/W7NF3CJRJro=;
	b=S2BBHDf73puw0tKBLqjZuAEU/CWtMRJAxDqfOYNqFAeo8YjKSh7dR2sR+MoWh+wM1ysj/x
	y05f5fq17vzO2zQPppAjq2CCy6FTcDHSUmRMNOfgx/4ysnNpqGIjegsfguN233t1vfPVtx
	kpopE2aCTEIKLD3MkESUBH8/cJ+luV4=
Date: Fri, 3 Jul 2026 16:45:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Lorenzo Stoakes <ljs@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
 Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>,
 Gregg Leventhal <gleventhal@janestreet.com>,
 David Hildenbrand <david@kernel.org>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <110e92b2-f7a6-487a-94a2-25ef1242afb7@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <110e92b2-f7a6-487a-94a2-25ef1242afb7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/3 11:49, Baolin Wang wrote:
> 
> 
> On 7/3/26 12:54 AM, Pedro Falcato wrote:
>> As-is, khugepaged and writable-file opening exclude each other. A file
>> cannot be open writeable and have THPs (because the filesystem is not 
>> aware
>> of them). khugepaged will never collapse file pages for files that are
>> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>> particular file is dropped. This is fine because nothing could've been
>> dirtied.
>>
>> However, there is an edge-case: collapse_file() might not be able to
>> coexist with concurrent writers, but it can coexist with dirty folios
>> (from previous writers). Therefore, the following can happen:
>>
>> open(file, O_RDWR)
>> write(file)
>> close(file)
>> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>> open(file, O_RDWR)
>>   nr_thps > 0
>>    truncate_inode_pages()
>>      /* THPs are cleared out, but so are the dirty folios */
>>
>> When this edge-case happens, there is data loss, as the dirty folios are
>> fully discarded.
>>
>> Fix it by fully writing back the page cache (and waiting) when collapsing
>> file THPs. Doing so provides the guarantee that no dirty folio will be
>> observed while there are active THPs. To fully ensure this is safe, the
>> invalidate_lock needs to be held while doing the writeout, so that
>> do_dentry_open()'s page cache truncation excludes this write-and-wait.
> 
> Thanks for explaining the race, and it looks reasonable to me. One nit 
> below.
> 
>> Cc: stable@vger.kernel.org
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Eric Hagberg <ehagberg@janestreet.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non- 
>> shmem) FS")
>> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
>> Closes: https://lore.kernel.org/linux-mm/ 
>> CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
>> Tested-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>> ---
>> This patch is written against 7.1.0 (because the code no longer exists 
>> in mainline).
>>
>> Zi, I kept your Tested-by, but I had to move some things around and
>> use the invalidate lock. Please re-test if you can.
>>
>>   mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
>>   1 file changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b8452dbdb043..0707d719a270 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct 
>> mm_struct *mm, unsigned long addr,
>>           goto xa_unlocked;
>>       }
>> -    if (!is_shmem) {
>> +xa_locked:
>> +    xas_unlock_irq(&xas);
>> +xa_unlocked:
>> +
>> +    /*
>> +     * If collapse is successful, flush must be done now before copying.
>> +     * If collapse is unsuccessful, does flush actually need to be done?
>> +     * Do it anyway, to clear the state.
>> +     */
>> +    try_to_unmap_flush();
>> +
>> +    if (result == SCAN_SUCCEED && !is_shmem) {
> 
> Actually, the operations below only for those mappings that do not 
> support large folios. For mappings with large folio support, 
> filemap_nr_thps() always returns 0, so the race described in the commit 
> message won't happen. We can add mapping_large_folio_support() here to 
> filter them out.
> 
> if (result == SCAN_SUCCEED && !is_shmem && ! 
> mapping_large_folio_support(mapping)) {
>

Right! nr_thps only gets updated when !mapping_large_folio_support(mapping).

For mappings that do support large folios, writable open won't see
nr_thps > 0, so no truncate_inode_pages() for that case :)

