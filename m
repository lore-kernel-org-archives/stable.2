Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284290;
	b=RNVeEvasIHoY+SpcgLnZ/YIqUDGuYiA6rAbx5hsqTUA+QdBO8cVtr94Hymogu2sHE20B
	 ENd7FPoy2FCg4Mf9YN20Py1HbEsVgE7vxTJh6WHydIb3aupuCf2Ngcvc+UNp2iPZgP10b
	 O2zblC+GTuTyqggnfG+u5ja375CUgfNXzQwUCLrcICMnFruGCKObhw3VTFOQXHILDtddp
	 ZKY26dDBLD/lVI1hLvtRQG3muzB88gBJnYrhqlZsfQM1N7D5c5gN6nHaUTryrC7UQ3l+A
	 Z99nNfW5vJRvwWT/JNLRbJf6OX75REsOl2Dqs1cm+Oe/d+DcM1/4K7i8OysWxlgS2oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284290;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mqXY1OcC5ARgzPi+R8XxHlz09YM9rQmQCBQ/7d/aXCU=;
	b=4IPrk3U6c85toq97lxDzV82in1vhenyd7EwynPGojvc9nAUdoM8x44uRW83G/YmDqxG3
	 P9uDoVjJ9QB3lOzaLMYmXrY2qgeiClqlM00/mqBjsn+fM/PABGhhdgnC5LhgniIgJpJiZ
	 YUMf7kN4Yt9r1WRWE0BgHM2zyduIa+TSFMuc2JQuTiot3fQ+iW+K6dIEDDbEGnffPcnae
	 klWDuvTKiT/1d1kZ5bRE5WxHlmTFgAbBhzQLEOrGxnzPPevt6yBbI6OuzMui2QatgF7SU
	 hkLH8T10pbQQsQkPsirIJ6D+4UlmW+G2SdaX5mqu8+3xPDMLP+3XWiyxsC26XFHlnTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+7+kNzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59895606A326;
	Thu, 29 Oct 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+7+kNzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB091F01829;
	Thu, 29 Oct 2026 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284290;
	bh=mqXY1OcC5ARgzPi+R8XxHlz09YM9rQmQCBQ/7d/aXCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S+7+kNzIX2ZMdfMr/hr6l4bhKncW3jvATRjUZNWSosKkVDp+gfFYQ4kqjyiXjyyAK
	 gs5kPXW8xG/0KT+HvaTk4xQTZL9v3hHSNBHmZpL8Pp7wWOJucUIy6ZbUAV4KXBR9x1
	 WYtze+u+asK21+yj3mqxwfp+1brn7eF/wYYE4dYb/mAQp0dP7jvSdnFY4f35xAZv1W
	 1wJ5WknxozTNNR3uE3WCHiS9+iQbSjFlGEJv0CzUW305T8TDzosH2HSKrlhpFrYV0d
	 IFR/sChwTcpkPvhDuq0AUrOOuXSZfwDloqRcMjT2PK3CjH1QEgeNOgtYdTI1xnrx0/
	 Ylgvn4jx6UkMQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id D7CDE198003A;
	Thu, 29 Oct 2026 10:31:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 10:31:24 -0400
X-ME-Sender: <xms:sljjasqqEYG9A6MGaYyB4phrmTc2UR4CNo6cGE6o9_kIYPTyiUFFXw>
    <xme:sljjamQukc3mBiYHzNxlKORPPuNOLZVFK_EljO4aa-UFfATXcXfDpFeOOR5ySp5e3
    2W3oY_IYOPYN4_89WjzZLcMZHSh89B7LCmJxyMw7LqTGE41QgnPebOe>
X-ME-Received: <xmr:sljjaocHgpSsSPKdmipnZxJV5PxaUcKSr06Kl253C0MMkKvw-vVhmbCWn5g>
X-ME-Proxy-Cause: dmFkZTEZfGskmN/KIALm0CJB+7YSa6+/0z6TYSZsJYszNysoKl9ha19QRgLMFtDXR5YTJU
    /ZtSllXOANZXHyFMLUtTazs3TqL4wn789TDCt9Clg6UWb/6TcorYCgPnRO1yG/d+ASCNki
    ef8dq7SubLCazhJOigTaPhJlXCh+AauxneJX30NAaSC9cSSvOTgd/RYPeHFhgwmIxxm9Yd
    XUnA7opn8M6R0HNovJsW3EeF88ulEUJFLh9pAaky7aJDjYSiN5BtFPOV7TerL4btsXoEPq
    cp6ZV2vmAclzI+C8mBPXQk99548l2lhaunvBg1pEEnk0CURYD04FMA3h2gwijrqVLBamEX
    +KoxpWN36HbdMDBokyDgZcydhpS1f9KgI8PaFAed8ADm5abJnc6vuHwnggI8aO9IAtffDI
    ipCbDbz1M0bdaXw7zTOgeTBkOyOY6iObnEFXJnh8OiD+rhFLRxfOgjlS5bLqPRuXOEA7dc
    zuovqc0yO0PHGX5SV5M+OqtwEuHlLIRmba3XmtKAmvZQn97ay5w+2tiMYysvPf4WcLEm0y
    mClz5VTCDYXL6iInsVZEfxH8cbr6DpXm1B3a05NNC7Hkc4aI3diZhsPjvb2EocdX3sTJRy
    rSmOHFVblnqwyUxgB9IIfYCWAnZ7TnDQAP2A4F7kC+UwttipX8k4t0q/Ks7w
X-ME-Proxy: <xmx:sljjao3Ii9-U-1biFjXoSLWZyLnxsgW96gQbMsquBxpP-XHQC1zwiA>
    <xmx:sljjag3mwxkldqLKpz1tkxq02ICrVtXAsM5jokWmrb5wmUqUqwkszA>
    <xmx:sljjahBJ84sMoOzMrfPwa0DHewrgQa8hcJrYxzjtmbxK_1HTl4OrnA>
    <xmx:sljjan8zr5rDWNd6RB2AB-_VoITYIhzyaD_PXTriegZPBPyEHpV1SA>
    <xmx:sljjag5aYtzxuNskXd_FD4Xl48JUUUMw0e1pRDrBF8NHnpEZV_hBWtA3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:31:11 -0400 (EDT)
Date: Thu, 29 Oct 2026 14:31:10 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 42/46] mm/huge_memory: split huge PUDs when adjusting VMA
 boundaries
Message-ID: <auNYPPlCnLdN88t_@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-42-6f74bec9a5bb@kernel.org>
 <auMxQPze5cOvGbCe@thinkstation>
 <9f4128a4-85fc-4f4b-ac41-b9d348f56e37@kernel.org>
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
In-Reply-To: <9f4128a4-85fc-4f4b-ac41-b9d348f56e37@kernel.org>

On Thu, Oct 29, 2026 at 03:24:29PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 12:45, Kiryl Shutsemau wrote:
> > On Tue, Oct 27, 2026 at 12:18:02AM +0100, David Hildenbrand (Arm) wrote:
> >> PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
> >> allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
> >> only handles PMDs.
> >>
> >> After faulting a writable PUD-sized VFIO BAR mapping, changing its first
> >> page to read-only with mprotect() makes the PMD walk treat the PUD leaf
> >> as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
> >> the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
> >>
> >> Walk the page tables once at each adjusted boundary and split a huge
> >> PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
> >> PMD-aligned.
> >>
> >> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  mm/huge_memory.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 60 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 08e58cda7d37d..d090642ac8c2b 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3503,16 +3503,66 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
> >>  	__split_huge_pmd(vma, pmd, address, freeze);
> >>  }
> >>  
> >> -static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
> >> +static bool pud_split_required(const struct vm_area_struct *vma,
> >> +		unsigned long address)
> >>  {
> >> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
> >> +		return false;
> >> +	if (IS_ALIGNED(address, HPAGE_PUD_SIZE))
> >> +		return false;
> >>  	/*
> >> -	 * If the new address isn't hpage aligned and it could previously
> >> -	 * contain an hugepage: check if we need to split an huge pmd.
> >> +	 * Only selected VMAs support mapping PUDs for now. Lift the
> >> +	 * restriction once this changes.
> >>  	 */
> >> -	if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
> >> -	    range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
> >> -			 ALIGN(address, HPAGE_PMD_SIZE)))
> >> -		split_huge_pmd_address(vma, address, false);
> >> +	if (!vma_is_dax(vma) && !vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT))
> >> +		return false;
> >> +	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PUD_SIZE),
> >> +			    ALIGN(address, HPAGE_PUD_SIZE));
> >> +}
> >> +
> >> +static bool pmd_split_required(const struct vm_area_struct *vma,
> >> +		unsigned long address)
> >> +{
> >> +	if (IS_ALIGNED(address, HPAGE_PMD_SIZE))
> >> +		return false;
> >> +
> >> +	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
> >> +			    ALIGN(address, HPAGE_PMD_SIZE));
> >> +}
> >> +
> >> +static void split_huge_leaf(struct vm_area_struct *vma,
> >> +		unsigned long address)
> >> +{
> >> +	const bool split_pud = pud_split_required(vma, address);
> >> +	const bool split_pmd = pmd_split_required(vma, address);
> >> +	pgd_t *pgd;
> >> +	p4d_t *p4d;
> >> +	pud_t *pud;
> >> +	pmd_t *pmd;
> >> +
> >> +	/*
> >> +	 * mmap, VMA and rmap write locks protect the walk; the split helpers
> >> +	 * take the page table locks.
> >> +	 */
> >> +	if (!split_pud && !split_pmd)
> >> +		return;
> >> +
> >> +	pgd = pgd_offset(vma->vm_mm, address);
> >> +	if (!pgd_present(*pgd))
> >> +		return;
> >> +
> >> +	p4d = p4d_offset(pgd, address);
> >> +	if (!p4d_present(*p4d))
> >> +		return;
> >> +
> >> +	pud = pud_offset(p4d, address);
> >> +	if (split_pud && pud_leaf(*pud))
> >> +		__split_huge_pud(vma, pud, address);
> >> +	if (!split_pmd || !pud_present(*pud))
> >> +		return;
> > 
> > This looks wrong.
> > 
> > We should bail out here if PUD is was a leaf and wasn't split.
> 
> __split_huge_pud() must split a leave. Either by zapping it (what we do right
> now) or by populating page tables (as in Usama's PoC).

No, meant the situation when pud_leaf() is true, but split_pud is false,
so __split_huge_pud() is never hit. pud_present() is true so we proceed
to pmd_offset()

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
