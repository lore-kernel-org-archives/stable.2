Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823691;
	b=PyblI5RwYYOFiuYCc0QEtfRI8F9SbP9uBmCSgP7waAEdZ5J3YoNlXUehLW3rnDvD/StS
	 zzpKVUste/Jh/No0NvKY7IhbdbN4v9EaeecizWXZfMzv1ke5IqYElo4/goychB+36AyMJ
	 uaX31e9HtgXk8ifW66AERgYBfo8xHWagsA49vVnBTS9uHYQoj7a+ABVkRw4HQtUyhY1TZ
	 lE1eMV9cIk6XMMyuf/Qm4T4ufNH65KTGx6gptEhXX8MDpptIAt/LDUVV5jpJ1Y8qSs7NL
	 Q0BmgpGVNgi1pRrKxaG+zhF/iUE3oJvqWyXOfB4+GG89U38Hq0kyJg0Kavastm/R5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xomABNJRS5DDfBS7xLxXB1ttX9vN42Q+i+1BI0PiZcg=;
	b=uqyr9P0XBApV8xzJTVeeIGDr24nZWSpNmigI9Lsegl+0em4rK5+uGSLHulZGW2W8aDgL
	 +L1jkMmN5uvKjlvOzhSfaI9gqsbMx39T1RB1LxqPTmmU6iYlYEMll3sq+WFbOzGeVq2MQ
	 I3g5snhbNYNSLtyt8F6BMVNCiiBYaWfSkcd5eH+YKEkotrlcOa+4uSClZ7VLMlhsfgeE3
	 GkRNvCpESIyRAz5j4b3OwSFl4HK4ne/IDz0/yo/GDcRd19QNbo8lR8DjlprbIh+xv/Qx5
	 A+a5GOdHOgJ6gguYC0caKlJuq49B/UqWdnrzy00LTC4MHrAe55/o+EFmIvmfGFQRO+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DguWC3yV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457ED606A329;
	Mon, 16 Nov 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DguWC3yV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEBC1F000C4;
	Mon, 16 Nov 2026 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823690;
	bh=xomABNJRS5DDfBS7xLxXB1ttX9vN42Q+i+1BI0PiZcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DguWC3yVLhDQZdYT0Ss3fhD2eGdA5SSVlW9n3iPptBfnNPe57uUf6enAe6ijWcmaz
	 YjVLnBWa9RPOSruTDJR0Bw/3MBhirdVRAwMMMJoJ2aCU4An/GS0DtPjXrbqzCxqDPx
	 NXjX5P+k/g4k0nvzZNmaC2wbs2IQGS3tTs/Ubuelnz0Bg3SnHkC0YdNPBkcBRci8nR
	 7lv+y0OOJ/6bJHg7+G3mlMqJ1XR82uprshFJqjuMp8QOJoOQsB3/mOCPzuozJNDmLX
	 zkEZsKlIaRMMroq0JiFxUbAdPShLkYVB3ZBtWQqxDX1Bb3zGNpb0IiPoNJzR202VrQ
	 LD38oJxnYN29A==
Date: Mon, 16 Nov 2026 11:08:03 +0100
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
Subject: Re: [PATCH v3 2/3] mm/hugetlb_vmemmap: fix PMD split TLB flush race
Message-ID: <avrWA0hxiqPDmivK@localhost.localdomain>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
 <20261114112523.75208-3-songmuchun@bytedance.com>
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
In-Reply-To: <20261114112523.75208-3-songmuchun@bytedance.com>

On Sat, Nov 14, 2026 at 07:25:22PM +0800, Muchun Song wrote:
> Bulk HVO optimization converts vmemmap PMDs for a list of folios into
> PTE tables before issuing a single global TLB flush. After publishing
> a PTE table, a concurrent single-folio optimization can observe it and
> remap its PTEs before the deferred flush:
> 
> CPU0                             CPU1
> hugetlb_vmemmap_optimize_folios()
>   hugetlb_vmemmap_pteify_folio()
>     vmemmap_split_pmd()
>       pmd_populate_kernel()
>       /* TLB flush deferred */
>                                  hugetlb_vmemmap_optimize_folio()
>                                    vmemmap_pmd_entry()
>                                    /* sees a PTE table */
>                                    vmemmap_optimize_pte()
>                                      set_pte_at()
>   flush_tlb_all()
> 
> Modern MMUs permit overlapping TLB entries with different mapping
> granularities only when they translate to the same physical address. In
> this race, the stale PMD translation still points at the original vmemmap
> backing range while the new PTE can point at a shared or replacement
> vmemmap page for the same virtual address.
> 
> Serialize deferred PMD splitting against PTE remapping with the HVO
> rwsem. Hold it for write across the split-only pteify batch and its TLB
> flush, then downgrade it before remapping the folios' vmemmap pages.
> This guarantees that no PTE remapper can observe a newly split PMD until
> the stale PMD translations have been invalidated.
> 
> Fixes: f4b7e3efaddb ("hugetlb: batch PMD split for bulk vmemmap dedup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-fbdc3410-a4cf-457e-88e6-684380fbadfe
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
