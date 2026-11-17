Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913707;
	b=3Qb81qMk6MmFuIjkzMhBMIG9+0QgaVoHcFN62rtUcv4Q4ex1TgHth4Sf02s5SXrsDy2J
	 1A4UG5mfTp8Txc6eFzdm5dlOZkF6mQrYvo46CuXCLFsHiAzzIqkwYCKZU4gv0h4uNBKTM
	 s3ay1ViHv0nwPDMVgLSjQiW+Mmxb9zOTaxw8QB7Ygl7CK1dcwqZyh3iX4+0guLt0/vfxi
	 t4hYJllMU0/lT59bR1ZT0+50UucuoFOlNgACQEOz8EWO6eR/1VBZIi76o+ZDy53fiwwc+
	 9LhKwPb/V5HMOgdepxQFhpl1rLQBRC1F/lhCCqDGYeECUMcOulNVIdm9f8JAoDaHIcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913707;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YdKhAjlrPqsB5ZWJA75kjf0hOR5+o724DAc3k4bz9WM=;
	b=T7oNxN8/5O/X2OH/NhV0LBrHmoYEq95KvQlsdpP7IOCUfWpLTRdOQvwfsqz92dzAIiKC
	 Y3+RRSWZPnAJ7mvgDvhTkTsJObe6hsv2QBMrsoXD/ypx5zadurqofheyWeDf93IZ4t7rX
	 HRcmGy5mcF8o8cnwVRPunYHlwiDDjbLr9s5m+mppxmUNZMiSokeE7MXbql3mBVp3orQj5
	 bLseHNm+wQc80M90gcV3SLdhn9MQoFGGYRUjO7PhvVgTTREXMen51SSVJdFhJFuuulMkk
	 86QzWn1GwSKxw/CFPOIhEtUM/EA6MWyOrZB5I22eMmzgvjqdpM8HZUyQL3Qo3zH+aMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSm9YO4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544F606A330;
	Tue, 17 Nov 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSm9YO4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FB01F000C4;
	Tue, 17 Nov 2026 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913707;
	bh=YdKhAjlrPqsB5ZWJA75kjf0hOR5+o724DAc3k4bz9WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YSm9YO4w2aPh+GuHQ3zlbH8kFIn6KEiPq3g/m8JTyz+sqhikPgHJlMRIkrNVxS85v
	 9LN5ikUDGNnvQdNVD9Yx0QaHeOvcERV05t4ezT8s8ht3FUFLqOVL1h46i41S3mSg8x
	 3CwyBjQ4Fz8wjapNG8inTytd7V5fBwQ+Qp1qk5qa/X5bQmKWSLffebuSwsl+bDekRi
	 ZDFf/tLPcFrGXaQz6wSmRcYpNg/uY4ev21f4/ZUzUz32pl7jcVES6ZQ/4AeNuf1dca
	 bzJwtNkH4Ux80E/wXJO2hRKSWB6MK+o/d7wI69Gx1K0PF2RktCnEsu5v+T8Jjhhzch
	 tv912fHnJUcUw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0DBE1198004A;
	Tue, 17 Nov 2026 06:08:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 06:08:23 -0500
X-ME-Sender: <xms:oTX8au8V4nBt8GHehzG9hEqmJJ0HaqqYpvNCV17AYD01BZPOeQVoJQ>
    <xme:oTX8albihyzYQlQnLn4T8BJ1gmqebndkTGMmqke7yUKcnK4APtbn3JWjy7RmzWS1O
    903VKbw5yuGRiyo2tXIWrsFF59yQYsrhEMhXzqsAs4SpsOsB0bFlII8Cg>
X-ME-Received: <xmr:oTX8aof3KijgYivzYrK9nBnwExCT8RjMBh5aunI6IasdxrPsWMBJl7d84B0>
X-ME-Proxy-Cause: dmFkZTGX1nIRce2EM7hEBPteoZuiZssnqMFZnuwSxMXg3gdmnTZl+fiHHzX2oBNXSiJsJf
    I/e9Vst+BHtRoyhl9WMXbh0/gwYGA9PqFYtIQKVLnyIVXb7zeXkz3N6uhReUZwYIR13hrL
    T7ZKOtu8DTAvwxpGM2l/jnWnCIUE81n/1kRkdUv7Pbk4yGbDA5DNCGU9aTD2f87pwBPfTr
    rivmGIjHyKUTgsoUG2wWa17dtgrQbqrrvlenEILMaH+BW9Hs46eNWXt0bxG7yreAceLvHU
    ykd75nYuGULyxecIDhNRoWGFcA9fGbFbcVW4tk858GUqeki7QD2eIO+z0vcDAwKw/ynInP
    sWwWo9LqVy1pNvVl7TC/bdvcrBYzidU3wgTdfM7PF/ACKjYhVqJUDR4nF2WHsgIJkAgHko
    jQrg9+PgzOxv5SmLJg+FedzvnFL9reKS7CAIv5vLVs14Pm9QAsrvbDh5Y3ux770Ee6Lylf
    QHJSnA23fNSUfcqNN+j5YKQFq3fQdWYKd5Abmn08WZZrlG3Oco8F0URxA+G4rAxR94RiqJ
    2j8o0SVRMPvmI/p3bUn1elP1e6Qrm85bepxgnGGrnWYIJ8HNbKRk3RaRBGvmHndZKENqeY
    0tjgazk8jKruqR2gzfcA0Xc7V/ggyN/xuX/0HQPJJeCbrpFjE9Us76Op37bA
X-ME-Proxy: <xmx:oTX8akr9YirNVX1wT6I5G5ZjYWf3es2sMnWiTwbMdWr1ECImBZiNYQ>
    <xmx:oTX8ap-CF8l49la4aQ3MiWU8vChpmqwjhx7rwe0W7ZElJcHjBI6y7g>
    <xmx:oTX8agIyOj-Cr_Jzcwge6FSvAsEAQMzbe4chXdGLMu5ExOmtq0LsFg>
    <xmx:oTX8anPcMSoAHG1094FhYNrpeOK_1uGbri0f_Ow_pi9ufrHjqAIjRg>
    <xmx:oTX8ak_ghEYWw0nYrtaE_8lytzaka_ZeBAYsR3IPaoc6K0mVmgCaNdE_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:08:16 -0500 (EST)
Date: Tue, 17 Nov 2026 11:08:15 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, 
	mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fs/proc/task_mmu: don't read young/dirty from a
 non-present PMD in smaps
Message-ID: <avw1Yc1W6BurgC9x@shutemov.name>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-4-usama.arif@linux.dev>
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
In-Reply-To: <20261116063624.1382944-4-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:57PM -0800, Usama Arif wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 164b4efc5e093..ad9fdcdaa2c40 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1029,13 +1029,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool present = false;
> +	bool present = false, young = false, dirty = false;
>  	struct folio *folio;
>  
>  	if (pmd_none(*pmd))
>  		return;
>  	if (pmd_present(*pmd)) {
>  		page = vm_normal_page_pmd(vma, addr, *pmd);
> +		young = pmd_young(*pmd);
> +		dirty = pmd_dirty(*pmd);
>  		present = true;
>  	} else if (unlikely(thp_migration_supported())) {
>  		const softleaf_t entry = softleaf_from_pmd(*pmd);

smaps_pmd_entry() dereferences pmd six times :/

Could you read it once with pmdp_get() in a separate patch before this
one, the way smaps_pte_entry() does with ptep_get()?

This patch would then only move pmd_young() and pmd_dirty() under the
present branch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
