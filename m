Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710310;
	b=rl+qQ4UMSWOHKiHE3j1mALnji5jFRaUrLFt6yCkK1E1h/EiyJSwsXNZuJRTjOMY9yNXL
	 XpnJ8K2HjSoSv3v5GcecaAJWO2ve76hJ5bdqfsN+Bs5N6moyCbkNUL3zGxF/VfDvqkc9q
	 kW/HNi7l6XNoH53yI76VmCNLdoylpcsxDeNx48SxiRJi/nK2O7EUCD5gKi/h0Fe7HE9WG
	 EViFj9xOdJVGooWrYsu8LiPWDqdtfyBUmBpVJGaTIuQlChev61+t0lf/KMBmixUgVH2Se
	 LnxgBphAS8jV+f6BT+DNus8P0ovFVNO0ypn2bFioMzqR/uvEx1Uv7nUb0oxVbG9necg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710310;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2UPNRRIVz5KRFGxnDTZmZbYAI/y+27zb2Ho2AqiDdIY=;
	b=K3iz4kAM9ZT/BUK/S2iRO1HMBmRoQY7N1iejzl/iXMI99JTsxoLhx76iVdPGNkiGi907
	 j9NaOIAP3PxsKvHHEg7TOhPUqNssu+oiAq+ub4YL7hDm0aYyyPeI6dUl66o6NSDYvWXMv
	 PygxhsXpHdR3b+sOoQ2IZVJkfK0yooTUsGG0GUfI8xLNZbVKzfDiYUoKeK/WtGkMs7cIH
	 PMDJZwaHEWJ6VHM9vCS88t/mAknYr/f32BCL8MKb1dAwd2Bj4QKHHL/7Bt/tJt8zyQT+n
	 HLL/Dvhi/jd3FLXavd1zqTtP5dF7eSi6LlOpSqW96XfBFWTQ0NKBjFnbBgSvkC+WoVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCLxusdV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF63606A32E;
	Thu, 26 Nov 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCLxusdV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F41F000F2;
	Thu, 26 Nov 2026 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710309;
	bh=2UPNRRIVz5KRFGxnDTZmZbYAI/y+27zb2Ho2AqiDdIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OCLxusdVYBkFomceMQ/l6ugQeuOgW9cgvcPw7B8Dg6WOMeIZ4kdj0APSvCghwvySW
	 QjkG+SpgYcQaZlM5x+W+2tegSCFyLjJstr45BsHW5ScQial/H7aV4aNYcAHMvr9Bqh
	 qaH4uc+s1UVN28vvQPQBTJt+9KKV8q0W4iAKq5EN4cN++RfGSyJ+LUJfv6GRjVKygm
	 9qX7yxoWIKGW9fsCOJGgaQhnLKtMlR7VxcUjp7kcgtMVNLzfLAGRPTzcYYTbeKvegO
	 vbHo6ttTzsDll3jLFx8u1+WNcJFrskCvD4x9GkzxN9631H1MfxbLrgsnlKQTl88B7w
	 ZN1J5mWE0vmpg==
Message-ID: <042ab922-4707-4c96-80a2-83a0378646d1@kernel.org>
Date: Thu, 26 Nov 2026 17:24:59 +0100
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
Subject: Re: [PATCH 1/4] mm/khugepaged: allocate page tables before locking
 the folio
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-2-azpijr@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261125100058.15200-2-azpijr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
> try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
> locked. set_huge_pmd() allocates the missing p4d/pud/pmd tables there,
> and on ppc64 with the hash MMU do_set_pmd() also allocates the page
> table to deposit.
> 
> Allocating with __GFP_FS while holding a folio lock can deadlock in
> reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
> that may be waiting for the folio lock we hold.
> 
> Allocate these page tables before locking the folio. The mmap lock
> keeps the upper levels around, and an unused deposit table is freed
> after unlocking the folio.
> 
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  mm/khugepaged.c | 79 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 23 deletions(-)
> 

That's a lot of churn for a corner case (powerpc with hash MMU).

What about simply running in NOFS context when allcoating that page table?

Apparently pte_alloc_one() doesn't consume GFP flags ... but we could add NOFS
around the allocation.

Any reason you went for this more complicated solution?

-- 
Cheers,

David
