Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823829;
	b=xqu5XUSkRFI58hBs9tYlTpLIwjKG7pOPK8qBDUZwSA5890X+T9wg1PoEpqbVVxpOjRUu
	 LwBhjBpVzz+hgkCCvjVkP3cwjWKF3PWd+dttwD3U0XC4o54RYf2QpNL+UMvmSaU5wnQPF
	 ozEZuR9B5mIkzUw/tEbMIbi7VvMc2UiXCG56OP1ASxM8Lz3qVe/ExiV1t043aaUvO/6JR
	 CPXtgQjkghS6SElW0UDq4TCWAulzPwTVYQxJR3JU3Pe8cBExl9s65h0ctkCeelwfWnNf7
	 AhbIYDXSlvGpYaZPgnuB16hvW6PVXhuqL5YOeAAevinzXnhZR07N7E3FlTUeQNLUanQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823829;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JXbbxzTK4STMxlRmt7LCwpa3q0WjlHYEgdFStr3myuI=;
	b=gfuLWQaCDoJYawAJXsph8bKGjUuDNXbn1M9EfADYCnLYlCy0cy0IXTd4I4XW0XOEnTFU
	 bNJV7VZnHQT3lTRnoB09RMkscvEW2UBeyve49shDVliJG/ayp+g6OXsIv/X9jFfXxw/lt
	 sPqDSpaDqhStAmU4bvB+Tz5ENxnw6WdwYEEqqXcKmrGMFvqFQT4eD6TFgYq11JK9C7nyk
	 nneCcmJalYA2VhoGQ6u5y/YELzMaTR9UbIDxhxrWXDKziUsPIn4SVpK1c4qhHApQ/NJxG
	 jkb2rd9Q9I9eoQpHgxm524nRwCJ1RYBdDEy3jMCXlj1NuVWxAAPe7UBJIic5slBcKPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDChAnWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03766606A32A;
	Mon, 16 Nov 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDChAnWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A5F1F000C6;
	Mon, 16 Nov 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823828;
	bh=JXbbxzTK4STMxlRmt7LCwpa3q0WjlHYEgdFStr3myuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDChAnWAybrGnG8HbCareJDnR8uYlxFVzdt/PWEHutV/Nu9mlhxDeSVN5z3+uieoP
	 867FCmZ3I5iE2imreP7FBRBUKB5hMORMgEXUcUpkas3sC4KaU9Q/+wmfkEF0B3SzQo
	 OMZGv15rDPhqH47R/dN0GROMD1GDI48+9RqjdObrC3uC2NFm7CKVGfPG1nXelxvmbh
	 w3wY/IAqaVUFR4fsK7UJHrnGVcNrYueDRfW5xfcWYiCfB8nZ379yX/zP4mA1AHXTT4
	 fD1TYp8xdCmpMrHHD5J2pdTfZjyzi8DHOwtymSKOTRXzuS2wLJPK06p9cgYx18/KGQ
	 yxJD18zhnfAKA==
Date: Mon, 16 Nov 2026 11:10:22 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/hugetlb_vmemmap: fix deadlock during PMD split
Message-ID: <avrWjqe5kPfkReIj@localhost.localdomain>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
 <20261114112523.75208-4-songmuchun@bytedance.com>
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
In-Reply-To: <20261114112523.75208-4-songmuchun@bytedance.com>

On Sat, Nov 14, 2026 at 07:25:23PM +0800, Muchun Song wrote:
> vmemmap_remap_range() currently walks vmemmap page tables under
> init_mm.mmap_lock. If the walk reaches a leaf PMD, vmemmap_split_pmd()
> allocates a PTE table with GFP_KERNEL and can enter direct reclaim:
> 
> hugetlb_vmemmap_optimize_folio()
>   vmemmap_remap_range()
>     mmap_read_lock(&init_mm)  <-- outer read lock
>     ...
>       vmemmap_split_pmd()
>         pte_alloc_one_kernel(&init_mm)  /* GFP_KERNEL */
>           <direct reclaim>
>             ttm_pool_shrinker_scan()
>               ...
>                 change_page_attr_set_clr()
>                   mmap_read_lock(&init_mm)  <-- self-deadlock
> 
> Since commit d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on
> attribute changes to avoid UAF"), reclaim through TTM can enter CPA,
> which also takes init_mm.mmap_lock. If a writer is pending, the nested
> read blocks behind it while the outer read cannot be released, causing a
> self-deadlock.
> 
> HVO walks vmemmap ranges whose intermediate page tables remain present.
> vmemmap_split_pmd() revalidates the PMD under init_mm.page_table_lock
> before installing the PTE table. Use the lockless page-table walker so the
> allocation no longer runs under init_mm.mmap_lock.
> 
> Fixes: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-206969@kernel.org/
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
