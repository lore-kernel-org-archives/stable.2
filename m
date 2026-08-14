Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B463B47CA
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674954; cv=none; b=OU5ipQ7i1jpwAJevjzQJ9IZeYvtB896wGXk2on234ozvPflwsREsWasjt6IY6sSu922MCX4S9bZ4vUVkl0cMfWTsBTozqO5RTv5DC15Grtjretd/FNU4an1j+PuN5ITQTzACIcWqtiGj2XNxw1TdKNpc2RZPc7uMRzZ1q2lL1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674954; c=relaxed/simple;
	bh=AAW1FZVKOtf1LWmTZ3Q2jsud1n2Ab6gDH0a7HVoYLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3OkmTsaZ2E8vlAMM+rXcIA7j0yvSZQbA6Kh/BFkRgq94Ryj2fX0QrwPk/7lLwrw3hMn8gww0F1hQDjzPnwkOZGLmZe9iIlPDGMHc19kISPt7siFVLZs9By3C2dDbdn4ZBfYfVvd2cXKcwUNmh/V1FryUwHZlpyzIv8I9WNN+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwmiK7An; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwmiK7An"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38101f85591so1603882a91.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786674952; x=1787279752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/z6n/EFmVELJj8nSYAWQTolcj1izWhLKb3PuxI7peBQ=;
        b=bwmiK7An8m/jhHiCFv77LYOc7X1CY6x63gVGAalcrEcCnakEyfrWi5n5zgOTjzaOqj
         oViNP7hdR2dKwdXaI1KrxiABOnkzarl90zDyPKO3r9NBfS9G4C+5j+OgAlRhykMgU501
         cL+8l6+E/47CxiPGghaV/on6BKHoqpUXHcmwAf1DSvcm7/LeccNJ6qRH6FZ+/T7zpVGd
         aWcZaDmhs8J9R6dFtkNqRua/82sXMBTuLT3bJkc2eKIx9J1YTgyzFrAVzi7wuKHKxncA
         B0XhBs8xI9XJBALiBOc2STHRyt13f5nsF/87o8WI+LYwWPhyIvoVUSFlAtTJNeUmGchn
         E41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786674952; x=1787279752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/z6n/EFmVELJj8nSYAWQTolcj1izWhLKb3PuxI7peBQ=;
        b=NNxIZeSWOeVoo24ux15cw1+rHU2/elJecrkxT5mJJhaZ8rxnbRAK49Vxpq9EQ8SdvJ
         ksYKbp0CoMmvtzDrUd2T2kJpoRQjmbiscNoIPSsU1EDRDupnDrUXo+xr6SRaKL45xHUw
         NNVtwWhqHsACfvmQb8fQm4AKnWM9dVjpLaLkG2CLyiYd1xY9ekenfekPGTdzwnKSMRnT
         70vMLaMgvfZzUfqIgtZzKTbi25bwYOvBqI0KLZ8y4phaQpSJiMbCL3gJE8kGx7qNOZZ3
         RIQur7QxSJevR9C9r4MQ2DsL2gt4mrwEEC1hJUWNTfjRZWZwi+/9QMDSi6H7bKM9+Ksk
         V9Zg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6eNxsYTUNIhxwRxdkRI1OX1YicXJ40cBDuqI0X1HPjvfPQF6V3c8c2mMb8FrPrcudIPPU9ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoeU2KYovIIeT9mAhkDhzDMjGtvVSWUHOialukPuGcUSIqCXb
	rrKHvMIn8JIe5IW0BSUQkkqWX4owHYzDcOOYCBgubie5d/drZqLKz5/2
X-Gm-Gg: AR+sD10OjOjoS0lpdwJ4ddgIfSlwQDro4z7qtBRAXl7fXOqrHYZlLvG4GkD07jE9K2z
	+QJ1hplaMJkjMbc/6ZL4YFJ5rT3KHAAMBj4NGKNvc5i7ojEuqi0Obq/nvKbj+V4sdMj6Fanlooj
	fmCe+3oxkzqALSJ1A56+9HMpsBgrd496aEsYVcBBx2xlWEyeXlxnsdsAXhn0gMBZ+juvdkRJxk2
	Jab02vyApqkeDx8UXbZtTk5NDBB08FhipGr17UeZfsLJxX5kivOOtRABTmeHRR52tZ0h3/b38Ao
	56XjmfIrHazvdTJvUKqNuiWN9v3umq21gqMN9DrIQ4oqniC4tllS4H1gC5Y2U1qHYasdoXwa3my
	vsl4IZEqLrpjQHdnn3crjjYhf59RUt71p5WGegF6gojBgJ2lsr3gIs7ca2odhR6+E9JHhkYpS7j
	BxGi2jQm8Ht1u/eX5eRVnx+blYfmhdhdp52rbzbOPXj1f80QoNZ2CmtUoUwAVZnweEABNU/pF50
	m2nCbJu4dMf1vAd6g7mmw984USklWlUi6c=
X-Received: by 2002:a17:90b:1dcb:b0:38e:5ce1:ae30 with SMTP id 98e67ed59e1d1-3933b0d37ebmr1977769a91.14.1786674951776;
        Thu, 13 Aug 2026 19:35:51 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebc08871sm442866a91.16.2026.08.13.19.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 19:35:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:35:46 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Longlong Xia <xialonglong2025@163.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	linux-mm@kvack.org, Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/swap: publish cluster tables after full initialization
Message-ID: <an3xnGPBCASWuS1w@KASONG-MC4>
References: <20260813150316.2793642-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813150316.2793642-1-xialonglong2025@163.com>

On Thu, Aug 13, 2026 at 11:03:16PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> swap_cluster_populate() drops the local, global, and cluster locks
> before its sleeping allocation.  The allocation helper publishes ci->table
> before allocating the memcg table and, on some 32-bit configurations, the
> zero bitmap.
> 
> A stale per-CPU or global cluster cursor can reach the isolated cluster in
> that window.  Since CLUSTER_FLAG_NONE and a non-NULL table make the cluster
> appear usable, it can allocate a slot without the auxiliary state.  An
> auxiliary allocation failure can then tear down a table which is already in
> use.
> 
> Allocate the complete set of tables into a private carrier.  Install the
> auxiliary pointers and publish the main table only while holding ci->lock;
> the slow path does this after reacquiring all allocator locks.  Allocation
> failures now free only unpublished resources.
> 
> Fixes: b197d41462c2 ("mm/memcg, swap: store cgroup id in cluster table directly")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>  mm/swapfile.c | 167 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 117 insertions(+), 50 deletions(-)
> 

Hi Longlong, thanks for the patch and report.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 78b49b0658ad..2ca947c540e9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -410,6 +410,99 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
>  	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  }
>  
> +struct swap_cluster_tables {
> +	struct swap_table *table;
> +#ifdef CONFIG_MEMCG
> +	struct swap_memcg_table *memcg_table;
> +#endif
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +	unsigned long *zero_bitmap;
> +#endif
> +};
> +
> +static void swap_cluster_tables_free(struct swap_cluster_tables *tables)
> +{
> +#ifdef CONFIG_MEMCG
> +	kfree(tables->memcg_table);
> +	tables->memcg_table = NULL;
> +#endif
> +
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +	kfree(tables->zero_bitmap);
> +	tables->zero_bitmap = NULL;
> +#endif
> +
> +	if (!tables->table)
> +		return;
> +
> +	if (SWP_TABLE_USE_PAGE)
> +		folio_put(virt_to_folio(tables->table));
> +	else
> +		kmem_cache_free(swap_table_cachep, tables->table);
> +	tables->table = NULL;
> +}
> +
> +static int swap_cluster_tables_alloc(struct swap_cluster_tables *tables,
> +				     gfp_t gfp)
> +{
> +	struct folio *folio;
> +
> +	if (SWP_TABLE_USE_PAGE) {
> +		folio = folio_alloc(gfp | __GFP_ZERO, 0);
> +		if (folio)
> +			tables->table = folio_address(folio);
> +	} else {
> +		tables->table = kmem_cache_zalloc(swap_table_cachep, gfp);
> +	}
> +	if (!tables->table)
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_MEMCG
> +	if (!mem_cgroup_disabled()) {
> +		tables->memcg_table = kzalloc_obj(*tables->memcg_table, gfp);
> +		if (!tables->memcg_table)
> +			goto free_tables;
> +	}
> +#endif
> +
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +	tables->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> +	if (!tables->zero_bitmap)
> +		goto free_tables;
> +#endif
> +
> +	return 0;
> +
> +#if defined(CONFIG_MEMCG) || !SWAP_TABLE_HAS_ZEROFLAG
> +free_tables:
> +	swap_cluster_tables_free(tables);
> +	return -ENOMEM;
> +#endif
> +}
> +
> +static void swap_cluster_tables_install(struct swap_cluster_info *ci,
> +					struct swap_cluster_tables *tables)
> +{
> +	lockdep_assert_held(&ci->lock);
> +	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
> +	VM_WARN_ON_ONCE(rcu_access_pointer(ci->table));
> +
> +#ifdef CONFIG_MEMCG
> +	VM_WARN_ON_ONCE(ci->memcg_table);
> +	ci->memcg_table = tables->memcg_table;
> +	tables->memcg_table = NULL;
> +#endif
> +
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +	VM_WARN_ON_ONCE(ci->zero_bitmap);
> +	ci->zero_bitmap = tables->zero_bitmap;
> +	tables->zero_bitmap = NULL;
> +#endif
> +
> +	rcu_assign_pointer(ci->table, tables->table);
> +	tables->table = NULL;
> +}
> +

You don't need to shuffle all the code for a simple bug fix, you can use
forward declaration if some functions are needed earlier.

...

>  	/*
>  	 * Back to atomic context. We might have migrated to a new CPU with a
> @@ -568,11 +621,19 @@ swap_cluster_populate(struct swap_info_struct *si,
>  		spin_lock(&si->global_cluster_lock);
>  	spin_lock(&ci->lock);
>  
> +	/* Nothing except this helper should populate an isolated cluster. */
> +	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
> +		swap_cluster_tables_free(&tables);
> +		return ci;
> +	}
> +
>  	if (ret) {
>  		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
>  		spin_unlock(&ci->lock);
>  		return NULL;
>  	}
> +
> +	swap_cluster_tables_install(ci, &tables);

It seems the same fix with Kemeng's patch? Youngjun have notice this too.
https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@huaweicloud.com/

And I think you missed some Cc, maybe you can try tools like b4 which
automatically generate the Cc list for you.

Hello Kemeng, can you help check and see if an updated can be sent?
