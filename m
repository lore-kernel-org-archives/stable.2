Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796867;
	b=3B4RCWF4GtXd42yi/HLEiVgpU/t6c65yR4gji3iBOymtZBBCTkJ7ojApcKx2iwy2GoQb
	 51QMuoF0qkSXsr3UYCahU1pe3EuTebSaI2q5ZgZaSESYvFMfGWCScfqHlV5r8bIMuvsmD
	 ZYCoscoX739EvlY/dgveuKdlNaxqk3zvDa7tvIonM0Mgt/YEAtRmFZey04+w4IV43GEl5
	 +cf6G5rY7TMHTS+AoVAvCpJSnDARDAuoEn60kSonvrTJsV8g63FuMgeV+z+SfmQJB3Tzw
	 u9KgHjxsTYFUfoy6JWu4qVI2HvzWXidpjMnOeuYcE5z1i2j41HGYvNtoFLURCEbQStw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796867;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VaEAs2JpnZX/wCopgOCtsrHcdnJ8AK5BNMT03LjZSPs=;
	b=dpInGZbKV6gP7r5Rr3xih3qJy9BLP0sziYQaIwWFCdWFuii2E+okzGLX1Yy+c00zoS6l
	 cLqktLXu39ssnyaX5Nf3d45n8oIu06tPBZbE7PSOfHZr/Wk5Wfm4Mcx2epu1n/hiirA3S
	 IPBNzssWiO5qUEuJSrAAhp7tL06J0EG6/OmMdWyogYG4w4j9i1jvrafSm/CWYWW61J5tT
	 IRvXOJhJT/rGf0R/PyjErRhZKWDUxTD0nPYgkFE129p9ISodwnDA0bKbtntm4u2swAUXt
	 EqZHaswYmoTzEAzoazc7qu4n7u7VwJlU1lEdfNoRMk3hZSHMykTOT7A9MI3FPi3zKng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wSBlN8+6;
	arc=none smtp.remote-ip=95.215.58.9
Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472A606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2472A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wSBlN8+6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rf/MCpoYMsHhZVqN9YRHgJpiVwU0YEKm9+BlNtnxvdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795796864; v=1; x=1796401664;
 b=wSBlN8+6CURYpQ1D0VQIh2YyHNh83TwUAONbJyBL5tUf1D7B2KBBvHws1ZV575NwoYlEn3lG
 rcLT/nJTaB55wTpY1F+/Lm8lYPYBZnF12QmL4oYT9wxhUHqB+fVbI8cxF/reUV5nX3xy3OZ0zp0
 G1N6LI8y5fMd4Juj1SJOERsQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40760d7bb28af9f0;
	Fri, 27 Nov 2026 16:27:44 +0000
X-Mizu-Trace-ID: 40760d7bb28af9f0
X-Migadu-Flow: FLOW_OUT
Message-ID: <63e62346-fabf-4426-88a3-056e1d909fab@linux.dev>
Date: Fri, 27 Nov 2026 16:27:39 +0000
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
Subject: Re: [PATCH for 7.4-rc2+ 1/7] powerpc/book3s64/mm: don't count
 invalidated PMDs in page table check
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Kyle Zeng <kylebot@openai.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 Rohan McLure <rmclure@linux.ibm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
 <20261015-anon_vma_uaf_fix-v1-1-7b977303b42b@nvidia.com>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-1-7b977303b42b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/10/2026 11:13, Zi Yan wrote:
> pmdp_invalidate() replaces a huge PMD with an invalidated one
> (_PAGE_PRESENT cleared and _PAGE_INVALID set) and calls
> page_table_check_pmd_clear() on the old entry. This decreases the page
> table check map count. When the invalidated entry is later replaced with
> set_pmd_at(), as MADV_COLD, page_mkclean_one() and change_huge_pmd() do,
> page_table_check_pmds_set() in set_pmd_at() clears it a second time and
> decreases the map count because pmd_user_accessible_page() still counts it
> as a live user mapping. The same happens when it is cleared with
> pmdp_huge_get_and_clear(). Then the map count underflows and hits BUG_ON()
> in page_table_check_clear().
> 
> Found by code inspection and confirmed in QEMU (pseries, POWER9, 64K
> pages, CONFIG_PAGE_TABLE_CHECK_ENFORCED=y): MADV_COLD or mprotect() on
> an anonymous THP hits the BUG_ON() with both the radix and the hash MMU.
> 
> Fix it by only counting entries that are hardware valid, so an
> invalidated entry is skipped, as the patch "riscv: mm: exclude invalid
> THP PMDs from page table check" did for riscv.
> 
> Fixes: 641d47d4c963 ("powerpc/mm: support page table check")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Madhavan Srinivasan <maddy@linux.ibm.com>
> To: Andrew Donnellan <andrew+kernel@donnellan.id.au>
> To: Rohan McLure <rmclure@linux.ibm.com>
> To: Pasha Tatashin <pasha.tatashin@soleen.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index dff8790a047db..392474972777c 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1091,7 +1091,8 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
>  #define pmd_user_accessible_page pmd_user_accessible_page
>  static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>  {
> -	return pmd_leaf(pmd) && pte_user_accessible_page(mm, addr, pmd_pte(pmd));
> +	return pmd_leaf(pmd) && pte_hw_valid(pmd_pte(pmd)) &&
> +	       pte_user_accessible_page(mm, addr, pmd_pte(pmd));
>  }
>  

LGTM.

It fixes the double decrement in the page-table checker
and preserves how kernel walkers recognize the temporarily
invalid PMD.

Acked-by: Usama Arif <usama.arif@linux.dev>


>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 

