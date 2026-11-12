Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467751;
	b=bGk3UGqUfqbG6VhX8WV0qQOlsxry9H4Ob/pvUzq669voJC/9Yn3UJkFhmtzkWveSf49N
	 PmgpoJUHzyX+LvaTAgo+UKK6GWXqm/37OXdNXYuM6qxagpJFYPNZFJ+cBrrxtqr7u0ecj
	 5xWfWdf/QdWKFg4uclZoEyX4tSuxc6503slqq/BLJWt8hPKFQB8P2Lh5JLTWzy4S0lSAM
	 tHF2EpHuM9MJY/ayz7p1cLc0GHuBroD2CyFxo2weVyhZPrXBTETUOZvt0QWDXBckL1lcj
	 CLLAZjZKO1BaKwKM86XVO0TiZyFD9GQ9XS7VThVGk8ukvCPF9pv4VPLZmC1AlTojVJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467751;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4r9XXFTO8ZQmRlSOe0BepTMvXqZOcL+GZ1GXT5k3Ep8=;
	b=eUnTDZhSMbzf+uj46EfdHLnZe82NyYfzjlsyCaLwn3yXgYb+gWyyM/a4w6SgXN41zzg9
	 i1wrCnK2F3C8l8pKnYaPkv9tgVfJjVD8giuxAMBiaC+PftJeeYRlPTWeo5KANwm3Oi+hM
	 vnD8Z5bkndQV8HSCx/PbPl/s6PFmwXU/ITq4+vnDx10k8P6BLgBleBzo3fJ/O7G6UxKYi
	 OW9t8wQ54dKE/LCfi6BVsI8PDWdzEjB05BijVqqDwcatPhaZD1pBBw5esnbRKFMswYSut
	 E3wPwpH0R/8pZ/Lig3mQgt3Wzy3xdua8BHbq85lKOjpWUnXPgDEwzId+zxcMMvgghRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PWFGoF5c;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C87606A8A3;
	Thu, 12 Nov 2026 07:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C87606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PWFGoF5c
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794467742; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4r9XXFTO8ZQmRlSOe0BepTMvXqZOcL+GZ1GXT5k3Ep8=;
	b=PWFGoF5cnjqGeA7lczyyZ5NPyzyeyZuU8Bh1KwEdFsfvos1tLTR3rwhHyI2UAYl+zcT5OwG0KZP2vxuygprSTrBMnZQSHeTjQY/+l+wEGXMq33ZlOXey3bUPyvoVB9rUidzgyUnf0TNjlsamEOFTL08sXdvUi0FeX9uRv7ZtloA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XEbBYxb_1794467739;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbBYxb_1794467739 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 15:15:40 +0800
Message-ID: <df38cd19-9554-4183-984c-70287e821de8@linux.alibaba.com>
Date: Thu, 12 Nov 2026 15:15:39 +0800
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
Subject: Re: [PATCH 1/3] mm/userfaultfd: fix PTE table overruns in UFFDIO_MOVE
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Lokesh Gidra <lokeshgidra@google.com>, Barry Song <baohua@kernel.org>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
 <20261111-pte_table_clamped_end-v1-1-2dbe339c487a@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261111-pte_table_clamped_end-v1-1-2dbe339c487a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 5:59 AM, David Hildenbrand (Arm) wrote:
> With a folded PMD, pmd_addr_end() simply returns the supplied end.
> move_present_ptes() can therefore walk past the source or destination
> PTE table during UFFDIO_MOVE.
> 
> pmd_addr_end() is only intended for page table traversal, in patterns
> like "next = pmd_addr_end(addr, end);". With folded PMDs, a higher level
> has already clamped the range to the PTE table.
> 
> Folded PMDs are uncommon, but can occur even on arm64, for example
> with 64K pages and a 42-bit virtual address space.
> 
> Extract the calculation from folio_pte_range() into
> pte_table_clamped_end() and use it to clamp both ranges. This preserves
> the wraparound handling from commit f681d4580d5c ("mm: fix address
> wraparound when scanning large folio PTEs").
> 
> Fixes: 50944692052b ("userfaultfd: opportunistic TLB-flush batching for present pages in MOVE")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   include/linux/pgtable.h | 24 ++++++++++++++++++++++++
>   mm/memory.c             |  7 +------
>   mm/userfaultfd.c        |  4 ++--
>   3 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b7..66d369870a740 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -12,6 +12,7 @@
>   #ifdef CONFIG_MMU
>   
>   #include <linux/mm_types.h>
> +#include <linux/minmax.h>
>   #include <linux/bug.h>
>   #include <linux/errno.h>
>   #include <asm-generic/pgtable_uffd.h>
> @@ -1518,6 +1519,29 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>   })
>   #endif
>   
> +/**
> + * pte_table_clamped_end() - Limit a range to a single PTE table.
> + * @addr: Start address.
> + * @end: Exclusive end address.
> + *
> + * Only use pmd_addr_end() when traversing page tables, in a pattern like::
> + *
> + *     next = pmd_addr_end(addr, end);
> + *
> + * Higher levels already bound the range when PMDs are folded. Use this
> + * helper elsewhere to clamp the range regardless of PMD folding.
> + *
> + * Return: The exclusive end of the PTE table containing @addr, capped at @end.
> + */
> +static inline unsigned long pte_table_clamped_end(unsigned long addr,
> +		unsigned long end)
> +{
> +	const unsigned long pmd_end = (addr & PMD_MASK) + PMD_SIZE;
> +
> +	/* Compare inclusive ends to avoid wraparounds. */
> +	return min(pmd_end - 1, end - 1) + 1;
> +}

Thanks. The helper makes the code more readable.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
