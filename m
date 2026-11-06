Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968732;
	b=tFH0NovHiBxxTZXrh9rbB7XQmvxsEA3sBd2y38l93mDWRpJr371Yfbp+Tb7ziXMyZyjC
	 5DINZb/7ioEV8+nky4Np9hbAOmENL6IfTC6gv31FydrNa4RlTchfllbBhV9iTMylCLjRn
	 mSsOgbIrjrTs7frTXHnlNIr136RAU5wO3yPpByuSlpDlmzokHfbP8/4YzJ7oI0wxXFNbq
	 40dGlr/aDreyljuEubPn+o8M4qfMKuzD54g+xiDI/EKWAXNPyQTvtvDmO6ni7uz3oNHuu
	 R4QYKYlq9EDVb3Rno1g9KCwZh/2x2T8UkjGBgObFHXaP3Qg0zKj1PWoHsy9iLuM7U4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968732;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2pfmacECcqVcYywkgZMGS6LkZuCwqHkVAmJzamD2whI=;
	b=1MojuVd/kLs3ILIGQ6dajh452Tlvt9lwo31VNNZxcY4J3p6hd2jHUSO9sZJvXOGefj+W
	 5UnBFTsoCuo6apvf1BKu6Hu3f6NE9lDcL/64iEE6esyppamzfJwtyCRf2j18XleUkHLF4
	 p0D5wPh/f3K+Fb/GffmORGQD1D6kpUjBUU8pkGVFTmH7xBYOv+ZdWdUFgPvnKtIS1XGsq
	 fPCKvrBzMgEwOitQXBNxiq2xAp97leCZI0XimZAci79CUdVfCLQo5yezPRnaHt2mS8UJj
	 sslCir1RdCcNKi3Rx6aJOGLOMfxDRPhiCvhXbsIgNwKu0CNI0KVa0aBkY+TzePBl5iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3FMkEW8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9B606A329;
	Fri,  6 Nov 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3FMkEW8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8F61F008A3;
	Fri,  6 Nov 2026 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968732;
	bh=2pfmacECcqVcYywkgZMGS6LkZuCwqHkVAmJzamD2whI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D3FMkEW8F7FOfkTko4A62x/+gbNolMkADx7oCT8ApfJNgoDuXSrumFvgLVAIosoi+
	 OGQQivKUOR0YGlH7IYTUsnGi9+/c2yO9qHonTIiuqJAbt9YZ7iT1DvbBs9Crp+OuxS
	 lO3ekg3n+bZyU9kDeRW07nCSmqMTfuCjPLxAU6EEmia+KuWPSoT1XcIL+vw2rHR/F9
	 HmU8nvfAoNwNeMJaqMnF/aYfQ0+LV+kqJxq3ghBbOBgIw7+7yAGHJqM/wtRo5fLy9S
	 vEg2ks4UVcuRnPjR18mg/Ll5cWFIX/6/Aqyjozm1Jv15RCNjSpL5EkaEOINNHi1Ij8
	 FLrFUlbc0F+/A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7526D198004A;
	Fri,  6 Nov 2026 07:38:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 07:38:47 -0500
X-ME-Sender: <xms:T8rtasefdrDg50RCfXVYapWRPd7hJhOH7MR_vMfF_RkFPcpgn0iabg>
    <xme:T8rtaq11Zf6R1Zc0aftUnIsFDaY0LWo5YyxJjLiJyorI0EjMIMb_FQ2H1PSDt_qJk
    eenHVeoya81NzJfPZ9LLMg62Zf4K4Yl6CtsrypytKDJ7q2XXT-7fkAQ>
X-ME-Received: <xmr:T8rtauiyuNtFX1s9r67EC8H9v-rJ9qUshbNAZWxxA-i546XDDMOnOCzcYEY>
X-ME-Proxy-Cause: dmFkZTGzAjGnz4qczRWBwFDzqEedcIN2RDs77+IhaKJdOHI/wRF4GJ+/XYgTh6qUDCaXtK
    q3BGgpdQwiz8g3jZv+XNiZ3PHhWZePA+KkMXnh5DVEYxm4xAwVX0MEjom76ZmfzWC+JTPH
    KiS19Dcunkmjpxr4Uil2sC19R8pXj7ovLT0PA2yAVZWcLty5pA48PAv7fst0p77EiM3n+1
    SmGSQ5XOtXFCV1+dbb7vBvMxrwGRHPa+XdLj9z9pUYo6DwpdcyJmkiF0P6rFAo/V/JZdTc
    JB24ZdeHtaiEyrrTwoEjAufvE1haKfVDIo+IxU19WrQxgP8cc4psM9iHQFHP4vpOpa7VoH
    wzQ1pi5Xm1k+/vd5fWuuLnXYA4NDa3sM6PbhRSGJ29vaEqlrEoBKvduJJT2QLau5zON77X
    LVS4No3GqNmQ7P5K5ZGNyDCsQUAFFMjELc5QUn1AxYZC+wWsbenSBZU/lmEyveJGaJ2+jX
    5fuGn8bxlHcwcJNuyglZcxdfbk0Sa0PEcwNUH2TBBBLTHU0CoNDi/SD5/1309grZ9OgwS7
    L3pcQ1dDN1WJl/+zOkyXMbph0dlAPT58n+aswI4a5WzW2PE7JzKbmxjsgGo+8fBfzklnrj
    EBr+0lhdOkv1TdfFi5YziSH1mehaQtbycU8WlCmDbaBUbLQfGwo3GJ9qXvIg
X-ME-Proxy: <xmx:T8rtat7js2s-eKQZcHK3_aXiUqi4PQT3ApNyxSy7PplOfAyVt45tMw>
    <xmx:T8rtagW_pOIDqaJwR8OxdqY5JxVHrJv54OXWTAdpWfg2Vex1AvmGtg>
    <xmx:T8rtatlscF93bVi-jaQNcHjAI-NjY-w5CIlVvBjJDaO8_4AtvZP4lQ>
    <xmx:T8rtahSHJTPBlU6GOzNLC9za7s75hOd8IlP5D3JPnl2Uwi1M9NeaSA>
    <xmx:UMrtaiNVGrkcAtiFcecPVVpaYRDrYD4OeE5iPf8Os-chIedx19aW39g_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 07:38:39 -0500 (EST)
Date: Fri, 6 Nov 2026 12:38:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
Message-ID: <au3JT5QXbcOFXCp0@thinkstation>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
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
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:10PM +0100, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process.
> 
> That's not really big news, but it's about time that we do something
> about it because some modern technology might find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> While the refcount checks are not required for order 0 folios, let's
> just add them for consistency: each folio_add_file_rmap*() and
> folio_dup_file_rmap*() needs a prior check.
> 
> Also, just document -EHWPOISON for copy_present_ptes() while at it.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
>  mm/filemap.c       |  6 ++++++
>  mm/huge_memory.c   | 24 ++++++++++++++++++++++--
>  mm/memory.c        | 23 ++++++++++++++++++++---
>  mm/migrate.c       | 11 +++++++++++
>  mm/userfaultfd.c   |  4 ++++
>  6 files changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2dd76cc5bbfe..79ae8fc0d6bb4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -8,6 +8,7 @@
>  #include <linux/gfp.h>
>  #include <linux/pgalloc_tag.h>
>  #include <linux/bug.h>
> +#include <linux/capability.h>
>  #include <linux/list.h>
>  #include <linux/mmzone.h>
>  #include <linux/rbtree.h>
> @@ -2228,6 +2229,38 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
>  #define folio_ref_zero_or_close_to_overflow(folio) \
>  	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
>  
> +/* Leave separate reserves for administrators and concurrent reference gains. */
> +#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
> +#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
> +
> +/**
> + * folio_ref_count_over_limit - Check whether to refuse more folio references.
> + * @folio: The folio.
> + *
> + * Relevant for large pagecache folios (!hugetlb). For these, we have to check
> + * before adding page table mappings or other significant refcount users whether
> + * we are close to our folio ref count limit, to avoid overflows.
> + *
> + * Checking this for other folios does no harm but is mostly unnecessary.
> + *
> + * This check is an approximation; we leave some headroom such that concurrent
> + * increments, batches and temporary references are not a problem.
> + *
> + * Return: True if the caller should refuse additional references, false
> + * otherwise.
> + */
> +static inline bool folio_ref_count_over_limit(const struct folio *folio)
> +{
> +	const unsigned int ref_count = folio_ref_count(folio);
> +
> +	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
> +		return false;
> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
> +		return true;
> +	/* Background threads must not consume admin reserves. */
> +	return (current->flags & PF_KTHREAD) || !capable(CAP_SYS_RESOURCE);
> +}
> +
>  /**
>   * folio_get - Increment the reference count on a folio.
>   * @folio: The folio.

Does the slow path need to be inline at all 15 call sites, GUP-fast
among them?

Maybe only leave the likely() check in inline and move the rest into a
function call?

Something like:

static inline bool folio_ref_count_over_limit(const struct folio *folio)
{
        const unsigned int ref_count = folio_ref_count(folio);

        if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
                return false;
        return __folio_ref_count_over_limit(ref_count);
}

bool __folio_ref_count_over_limit(unsigned int ref_count)
{
        if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
                return true;
        /* Background threads must not consume admin reserves */
        if (current->flags & PF_KTHREAD)
                return true;
        return !capable(CAP_SYS_RESOURCE);
}

Also, should this be capable_noaudit()? I am not sure a refused
reference should leave an audit record. cap_vm_enough_memory() checks
the admin reserve with CAP_OPT_NOAUDIT.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
