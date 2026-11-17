Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903196;
	b=gvNGKIOoXLnM5rm3CBZIACAe6vjUVpfB5pUy3KgdufhwUNOgSvO/SRzQuOnoLcCQzvdm
	 OSSZ7O8kw91q6V0hkG9f7P6vO1Ojzvii7x6Pv6wRdZCUHH+mrROCr7cUMQ80rA8vAXu2G
	 joOgRR+hK/XT4oytrH67Z+Ec4zW7xeN2lJwSjrv1h6Vosr3NvXVQH1cKg7G7nknbNegN/
	 +so2asAmbqJFkivtSzcjQ2F2Jo6dEqGic/MpgLa1paNMZT1F64Lrdy1c9Vf6wJvlnhuFV
	 IZFwThzSY2flzEvx7PymQ619ic2IPdj6ug/sMOiPgsGIUbed2XVY8VZLX7giBuNJAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903196;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IBXUdSjPv3St/AeuB5N6wFkUoCBcAH66OSGEhKqTT3g=;
	b=AgIO4/xZ6GTlvUy6u1ncXHP2m5kC1sPk34z2snHhDOJ9a3fHMUFbxHe85dNtgtq7Vndw
	 U5WYk2Pev6k0nlJu0k+GWs/Nx7yh9tYwzSpyEV+ML+rA9rJVDcyWLxHupL/hsUea6yV25
	 CGJh7nsfF+63mWIimYDAiOuYHUb/cOwxsXmTGhmKASZpg967tm4RK8aZOhm2H4ZEDiFdj
	 LdnkFpkDCeg7WemMuDTN9zWbxGaiRQbS0u5WPyySAvKcblF4osJoXTyCZzHCnjBGxaqB6
	 bCeO0pTGb0S4aeJIawrBpDNQiGNJrSEjEE8isVV30xyoK/iK/bJuHAmGCASYq/G+c4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlyAEWxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE3606A31C;
	Tue, 17 Nov 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlyAEWxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23A81F000C4;
	Tue, 17 Nov 2026 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794903196;
	bh=IBXUdSjPv3St/AeuB5N6wFkUoCBcAH66OSGEhKqTT3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hlyAEWxiuklLcW8fzBZVgxRgIwA1STK2mCOg4xpyew9l5sw6uHHG4GUa2esbOCYyR
	 gWKY7aebdDYx4tQ134Pd/mA9ZSascY77fjfxf+8tHph7RJZwnUQxmbd7Vadjlp03PB
	 RNrBxLdB4INA9J5n4eCN8l0/HM1BLIEee3UGNu1EQN6nZ01iflmnECFgmgq54XrtB1
	 JsXeeobeiOizwedOp7h4cIHeq87rET3qPSz3+VkiGULZ9mugtd+znJxTMH4/8NV91B
	 jbDVAA5MDAyYBIqfEy1dX4KdSKVNshyJa6p2RyLVZdP/Gqx/GUbyHbKR9JJRivERy1
	 PZ4c2J3bY56LA==
Message-ID: <dfbf361e-8125-4f8e-9567-65e80996e2d4@kernel.org>
Date: Tue, 17 Nov 2026 09:13:09 +0100
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
Subject: Re: [PATCH] mm/khugepaged: mark a collapsed mTHP dirty
To: Daniel Wade <danjwade95@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117075246.61336-1-danjwade95@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261117075246.61336-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 08:52, Daniel Wade wrote:
> When khugepaged collapses an anonymous range into a folio below PMD
> size, collapse_huge_page() copies the pages in, but
> map_anon_folio_pte_nopf() marks the PTEs dirty only when the VMA has
> VM_WRITE and nothing marks the folio itself dirty. After
> mprotect(PROT_READ) the folio therefore holds the only copy of the data
> while looking clean, so MADV_FREE in one mapping marks it lazyfree,
> reclaim frees it, and another process that maps it reads zeroes. Mark
> the folio dirty before mapping it.
> 
> Found by static analysis with an AI coding assistant and reproduced with
> a test program on an unmodified kernel.
> 
> Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---

I have a different patch on my queue here that fixes this as well I think. Please review.


commit b835defd5b9b0fb8cd89997fd4a11c27b28bbef7
Author: David Hildenbrand (Arm) <david@kernel.org>
Date:   Wed Nov 11 21:09:26 2026 +0100

    mm/khugepaged: do not lose soft-dirty in an mTHP collapse

    An mTHP collapse can lose soft-dirty PTE bits if pages were written and
    the VMA was then made read-only.

    Collapse does not preserve the soft-dirty bits of the old PTEs, so the
    new entries must be marked soft-dirty. map_anon_folio_pte_nopf() relies
    on pte_mkdirty() to do that, but only calls it if the VMA has VM_WRITE.

    In map_anon_folio_pte_nopf(), call pte_mkdirty() unconditionally, just
    like map_anon_folio_pmd_nopf() already does with pmd_mkdirty().

    Consequently, we always mark these PTEs dirty (including soft-dirty) but
    only set them writable if the VMA has VM_WRITE.

    This essentially reverts Hugh's commit 1ac0cb5d0e22 ("mm: fix anonymous
    dirtying") that back then touched do_anonymous_page() to avoid forcing
    clean anonymous pages through swap instead of discarding them. This no
    longer applies as shrink_folio_list() allocates swap for ordinary
    anonymous folios and unconditionally marks them dirty before unmapping,
    regardless of PTE dirty state. Keeping their PTEs clean does not make
    them discardable.

    This now also marks fresh anonymous PTEs dirty and soft-dirty in read-only
    VMAs when page faults allocate real pages.

    This has low urgency.

    Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
    Reported-by: Chris Mason <mason@kernel.org>
    Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

diff --git a/mm/memory.c b/mm/memory.c
index 24144892c2803..8b4a62722a0b1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5518,8 +5518,7 @@ void map_anon_folio_pte_nopf(struct folio *folio, pte_t *pte,

        entry = pte_sw_mkyoung(entry);

-       if (vma->vm_flags & VM_WRITE)
-               entry = pte_mkwrite(pte_mkdirty(entry), vma);
+       entry = maybe_mkwrite(pte_mkdirty(entry), vma);
        if (uffd_wp)
                entry = pte_mkuffd(entry);

-- 
Cheers,

David
