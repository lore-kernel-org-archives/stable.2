Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819732;
	b=2cfpkdIOOuxerpujDDVqwII5ofrAar/sq+d0uv9HeG3T3Z0/rkr71Zs6rAIeMm/Px1n9
	 ifWfxsOFTagKXjY1tZ1vO0HI7dZzQKBfdiAgQZXUS9dZUC/HwgF1ci/84ZHN8Pzjk0ZaJ
	 yPez4PZuKcDuICHVWo0v4LL/yiaTNc1z2rw9NYhw5z0klEdmNUQB7FicAX7Al7yTbaMGE
	 cFjDRr6lA/r/6rbS04yaGl+bAopR5VAkk8K/AWbo9x12gP8tS9NoZq0Z5jbhZqKfCIxS7
	 Tjkhybu40f8vZgTRyT5eI+wEXYwXRnH8UuNrR7rJp9H+YkdqAdwwpDSemCPscyoUNiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819732;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R27gurMrWAiF1nO+wwfwz9JAI8Wko+vNkDI3bBCyoGA=;
	b=1GkNyi8bEkWGi6PdWNKsJCEmGP6RsjQKbXOUC5gAHBUold71kc5cIjW6sGS53MyZFv7g
	 13ZfxSt5acizzMwbBefVo4XZnw0lWYFHm9lyE61OxS3lduif5n0N3VxihX2I3tvuKdl9M
	 5I7vuzW17mjY9i0l/a7fmfab0W4/3nT6obv/NMmSYK7ymOK5SsMm24senn1GdUKgH800o
	 +EIdkq1Jg44sngOx9hZKnQURXDX/pS+aY2ABJQIFHh1r4uypgKMGdKjCGRJVbEkZdTjnR
	 Is2jhhHlhT84aifulZf6Y0B0xqJfituzq0oGCy8P+Nq1WnWX9RyuAG4gPBxZFApNnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CX0//Lh1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAB606A323;
	Mon, 16 Nov 2026 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CX0//Lh1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516FF1F000C4;
	Mon, 16 Nov 2026 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794819731;
	bh=R27gurMrWAiF1nO+wwfwz9JAI8Wko+vNkDI3bBCyoGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CX0//Lh1DA2ZuZWTrCVzVp8OeJEfR9s1eHs9sM0eWGUOIC9KU+xsNgo/scrwnqxoT
	 STPM82v+CeZnOw9+9QAbCRY/F/UWwWHJuyMggJQhYpnqaSvLWvaxsCYh038SKEaJr/
	 ED16gtiwBKRRWxC95NOw37M/3SPf2JEzXVtMKyo5kW+EYe9OmRr7QfWqrU1ZSule3m
	 kbKN9jciHEq40qa1aBpyQlc7thbx1JPGlRqu1nD5/evGRNEVjurHAiVKiBkJ1s0Hs4
	 IIUEzvLdl+yL/8h7HeZ58/UxZ5fypajiJDdWgAYEXsnlxnMTsbnWukmmR5qXv6p/m5
	 KGbW3/9d40W3A==
Date: Mon, 16 Nov 2026 10:02:05 +0100
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
Subject: Re: [PATCH v3 1/3] mm/hugetlb_vmemmap: fix HWPoison state races
 during optimization
Message-ID: <avrGjaCa05UnK1kd@localhost.localdomain>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
 <20261114112523.75208-2-songmuchun@bytedance.com>
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
In-Reply-To: <20261114112523.75208-2-songmuchun@bytedance.com>

On Sat, Nov 14, 2026 at 07:25:21PM +0800, Muchun Song wrote:
> HVO copies the vmemmap head page before remapping it to a newly allocated
> backing page. Memory failure can update the old head page after the copy
> but before the remap's TLB invalidation completes:
> 
> CPU 0                            CPU 1
> init_new_hugetlb_folio()
> __hugetlb_vmemmap_optimize_folio()
>   vmemmap_optimize_pte()
>     copy_page(old_head, new_head)
>                                  try_memory_failure_hugetlb()
>                                    get_huge_page_for_hwpoison()
>                                      hugetlb_update_hwpoison(old_head)
>   set_pte_at(..., new_head)
>   flush_tlb_all()
> free_vmemmap_page_list(old_head)
> 
> The raw_hwp_page linked to the old head is then leaked and the folio's
> HWPoison state is lost when the obsolete backing page is freed, allowing
> the poisoned huge page to be allocated later.
> 
> Unpoisoning has a similar race: unpoison_memory() can free the
> raw_hwp_page and clear PG_hwpoison from the old head after it is copied,
> leaving the new head with stale HWPoison state and a freed pointer.
> 
> Serialize HVO remapping against HWPoison updates and removal. This
> ensures that an update is either copied to the new vmemmap head page or
> applied after HVO installs the new mapping and completes the TLB flush,
> and prevents unpoisoning from modifying the old head while HVO installs
> its replacement.
> 
> Fixes: 11aad2631bf7 ("mm/hugetlb_vmemmap: remap head page to newly allocated page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-18e93f17-529b-4d84-ba44-a41829f4be64
> Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
