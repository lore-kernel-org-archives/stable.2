Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03E35DA55
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676151; cv=none; b=aes7uXTcGGh7DW8ensLwn33FsGdy+y1Daw1ChGKd/dT+VbQLJWoW8Q60acBZFQ2LV30ZHGAiGEkzUZGkBF6xe7Nis32YYblO79b2EMXO1on1YzCxw8DY7pWxbVo3eXFDGE5i+F/3BwYHtMMaG83NrzoITbcPz7Kksw3x6+8XY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676151; c=relaxed/simple;
	bh=zPRYzamrHB1t981YosyVBZ3nLc4peLOZVDZRPiq0FNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqnqcuErBhnNTMCyuY8RGQPwwNyF2cnjvvJpyjPIPiMfmDUG03nnijnI9gn4CQaWZWOdPdhumu/A41V8H4+t0ej425EG2NrVt1+y2M9bTl60tviLh0G0ha7zFU8FlbYisnzHwzfUz9L7575YPzw0V/RGe6gH7SES6OgN6xa6e3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PC1yFBTJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PC1yFBTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=5QOcvwE+F6mgiRV6cDZvj6pc+a7dUoPydsJAnpmxLoo=;
	b=PC1yFBTJjAPQc1grgzibGOFxINjHq1tMwF4EvTBCLj5+xu18NIhP6o0+VYwOSA
	R7nZg9Cjt84ItLBGzzgU1cIsvrEsuTac6GfcuQFRsd2jHVHMqj4Z0++6ThfucRuz
	07paMOh8YpCphdlXRzQXt9txaq7vCE+4Wzzk49L3+3MAU=
Received: from [198.18.0.1] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3vwqMg35q7GDfMw--.16540S2;
	Fri, 14 Aug 2026 10:55:10 +0800 (CST)
Message-ID: <44eb0883-c49a-4d02-b330-914cd167840c@163.com>
Date: Fri, 14 Aug 2026 10:55:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/swap: publish cluster tables after full initialization
To: Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
References: <20260813150316.2793642-1-xialonglong2025@163.com>
 <an3xnGPBCASWuS1w@KASONG-MC4>
From: Longlong Xia <xialonglong2025@163.com>
In-Reply-To: <an3xnGPBCASWuS1w@KASONG-MC4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3vwqMg35q7GDfMw--.16540S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4DKF47CrW8GryxGFWruFg_yoW7Zw1rpF
	WrGas8KF4SqrnrWrsxJw4DtFyrJ3y8Gr1DGr1xt3Wa93Z8Zr1fGayktry3uF9rCF1DJwn0
	vr15Kwnrur4Fy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO2-5UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9w8+N2p+g4+5ZgAA32

Hi Kairui, Youngjun, Kemeng,

Thanks for the comments.

I missed Kemeng's earlier patch and the follow-up discussion. Sorry for the
noise and for the incomplete Cc list.

Since this issue is already being discussed there, I will step back and let
Kemeng continue with the updated version.

Thanks,
Longlong


在 2026/8/14 10:35, Kairui Song 写道:
> On Thu, Aug 13, 2026 at 11:03:16PM +0800, Longlong Xia wrote:
>> From: Longlong Xia <xialonglong@kylinos.cn>
>>
>> swap_cluster_populate() drops the local, global, and cluster locks
>> before its sleeping allocation.  The allocation helper publishes ci->table
>> before allocating the memcg table and, on some 32-bit configurations, the
>> zero bitmap.
>>
>> A stale per-CPU or global cluster cursor can reach the isolated cluster in
>> that window.  Since CLUSTER_FLAG_NONE and a non-NULL table make the cluster
>> appear usable, it can allocate a slot without the auxiliary state.  An
>> auxiliary allocation failure can then tear down a table which is already in
>> use.
>>
>> Allocate the complete set of tables into a private carrier.  Install the
>> auxiliary pointers and publish the main table only while holding ci->lock;
>> the slow path does this after reacquiring all allocator locks.  Allocation
>> failures now free only unpublished resources.
>>
>> Fixes: b197d41462c2 ("mm/memcg, swap: store cgroup id in cluster table directly")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>> ---
>>   mm/swapfile.c | 167 +++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 117 insertions(+), 50 deletions(-)
>>
> Hi Longlong, thanks for the patch and report.
>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 78b49b0658ad..2ca947c540e9 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -410,6 +410,99 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
>>   	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>>   }
>>   
>> +struct swap_cluster_tables {
>> +	struct swap_table *table;
>> +#ifdef CONFIG_MEMCG
>> +	struct swap_memcg_table *memcg_table;
>> +#endif
>> +#if !SWAP_TABLE_HAS_ZEROFLAG
>> +	unsigned long *zero_bitmap;
>> +#endif
>> +};
>> +
>> +static void swap_cluster_tables_free(struct swap_cluster_tables *tables)
>> +{
>> +#ifdef CONFIG_MEMCG
>> +	kfree(tables->memcg_table);
>> +	tables->memcg_table = NULL;
>> +#endif
>> +
>> +#if !SWAP_TABLE_HAS_ZEROFLAG
>> +	kfree(tables->zero_bitmap);
>> +	tables->zero_bitmap = NULL;
>> +#endif
>> +
>> +	if (!tables->table)
>> +		return;
>> +
>> +	if (SWP_TABLE_USE_PAGE)
>> +		folio_put(virt_to_folio(tables->table));
>> +	else
>> +		kmem_cache_free(swap_table_cachep, tables->table);
>> +	tables->table = NULL;
>> +}
>> +
>> +static int swap_cluster_tables_alloc(struct swap_cluster_tables *tables,
>> +				     gfp_t gfp)
>> +{
>> +	struct folio *folio;
>> +
>> +	if (SWP_TABLE_USE_PAGE) {
>> +		folio = folio_alloc(gfp | __GFP_ZERO, 0);
>> +		if (folio)
>> +			tables->table = folio_address(folio);
>> +	} else {
>> +		tables->table = kmem_cache_zalloc(swap_table_cachep, gfp);
>> +	}
>> +	if (!tables->table)
>> +		return -ENOMEM;
>> +
>> +#ifdef CONFIG_MEMCG
>> +	if (!mem_cgroup_disabled()) {
>> +		tables->memcg_table = kzalloc_obj(*tables->memcg_table, gfp);
>> +		if (!tables->memcg_table)
>> +			goto free_tables;
>> +	}
>> +#endif
>> +
>> +#if !SWAP_TABLE_HAS_ZEROFLAG
>> +	tables->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
>> +	if (!tables->zero_bitmap)
>> +		goto free_tables;
>> +#endif
>> +
>> +	return 0;
>> +
>> +#if defined(CONFIG_MEMCG) || !SWAP_TABLE_HAS_ZEROFLAG
>> +free_tables:
>> +	swap_cluster_tables_free(tables);
>> +	return -ENOMEM;
>> +#endif
>> +}
>> +
>> +static void swap_cluster_tables_install(struct swap_cluster_info *ci,
>> +					struct swap_cluster_tables *tables)
>> +{
>> +	lockdep_assert_held(&ci->lock);
>> +	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
>> +	VM_WARN_ON_ONCE(rcu_access_pointer(ci->table));
>> +
>> +#ifdef CONFIG_MEMCG
>> +	VM_WARN_ON_ONCE(ci->memcg_table);
>> +	ci->memcg_table = tables->memcg_table;
>> +	tables->memcg_table = NULL;
>> +#endif
>> +
>> +#if !SWAP_TABLE_HAS_ZEROFLAG
>> +	VM_WARN_ON_ONCE(ci->zero_bitmap);
>> +	ci->zero_bitmap = tables->zero_bitmap;
>> +	tables->zero_bitmap = NULL;
>> +#endif
>> +
>> +	rcu_assign_pointer(ci->table, tables->table);
>> +	tables->table = NULL;
>> +}
>> +
> You don't need to shuffle all the code for a simple bug fix, you can use
> forward declaration if some functions are needed earlier.
>
> ...
>
>>   	/*
>>   	 * Back to atomic context. We might have migrated to a new CPU with a
>> @@ -568,11 +621,19 @@ swap_cluster_populate(struct swap_info_struct *si,
>>   		spin_lock(&si->global_cluster_lock);
>>   	spin_lock(&ci->lock);
>>   
>> +	/* Nothing except this helper should populate an isolated cluster. */
>> +	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
>> +		swap_cluster_tables_free(&tables);
>> +		return ci;
>> +	}
>> +
>>   	if (ret) {
>>   		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
>>   		spin_unlock(&ci->lock);
>>   		return NULL;
>>   	}
>> +
>> +	swap_cluster_tables_install(ci, &tables);
> It seems the same fix with Kemeng's patch? Youngjun have notice this too.
> https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@huaweicloud.com/
>
> And I think you missed some Cc, maybe you can try tools like b4 which
> automatically generate the Cc list for you.
>
> Hello Kemeng, can you help check and see if an updated can be sent?

