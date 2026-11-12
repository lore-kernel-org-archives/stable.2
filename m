Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506865;
	b=MTS3OM55OiIW8GJIb26sEeSHsxsTV5I6FbQ7y8AMV7wyVuRoAhmdI2nVH1QJUnOZzsYr
	 Q0ixS4XWA3rvTejz+juZKp2dXPWLfDugzBZpbyjGmqAanLDg9seniAofpBaRksS+l9jSS
	 y5HxvNruGIbvW2mhv+vsQtyyWxh3u+5k4aO2+TKACzFz1N3lslZZnJjFHYpVjMO9OsdOn
	 NHfWhxVnxtGEGQf1RIqD1zDVr3yJck+D7wa6yMzQeeCmZoaXxAeEckJ/bFqTq54tMa4NP
	 +dV4WMl/ZneWhm+HmQoBsvJTWroa8XG17aLgphub56XRu1R/xH9mc3Lt+Q2Q5ZuHRSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506865;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jsNR/pRYGWFaHDwqujtAOATNDQ1mgwcPOKFdvCgM3hE=;
	b=YkbdWHDZLor+kT+CEzO9LrV+naaqKJnTet8B5lkVHWMbHAfvIgFr257dB31K7wyA77QP
	 wR+U4XBi0XrTezwbkzcXTKKkMLwFuo2FAQ+EX2o9RWNRR4p28NpHiSw6k9nWvWR6wwX9t
	 j7RiwOlH+dH5m5o/F5bNj5wVn2KRlL+qq09I3PRighgc60Qx36/2g63n0B+dM5UBHrgP7
	 dd4pn8w/zd2qBUIB1nvB1qT/jk5WQBaFC06cFlmwarGNWHtqq+nBc0s18g2XWTZm3+far
	 NvxvJsLDc5lSPlqzstk9vGxBl2q3LiLWNZoOcBDHG+o5yZe2VLsGWRQFipPnsRm+J7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ri0Kd36/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369A606A31C;
	Thu, 12 Nov 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ri0Kd36/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D261F000C4;
	Thu, 12 Nov 2026 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506864;
	bh=jsNR/pRYGWFaHDwqujtAOATNDQ1mgwcPOKFdvCgM3hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ri0Kd36/I0P3REBf7rp3tYJapb9ri00ThjWxr7bxZQXWTXK5k8HEIv1/xKsjeH8d8
	 ML/Hfq1bBdz/Q3/TbVrGHRgdbaqpymB8cw3gTS9oB+smix1e+y6ZfRCVLseuZ+5Jbg
	 iWqeaF5i7JnZfaMJkoxKtM27qLqhGxSrds4bzGhdm6L2LT2JUmPnXbUudgFR/dx6zj
	 T39tFbntOyrWurf/pnumuiUevGgIA2qgqaRjnfNEkHXoel1UfyoS9emjlTldtPsizn
	 YentbTKSKr2FMp5rkpFMe3fDXL28YUf17Z0ZkZFlAp0yIYFbOQHrwggE16P0isEVAC
	 bQju1Bu9kDmdg==
Date: Thu, 12 Nov 2026 18:07:32 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/12] userfaultfd: refuse UFFDIO_MOVE into a non-present
 huge destination PMD
Message-ID: <avYAMYr87pHQ29Zh@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:10PM -0500, Tal Zussman wrote:
> move_pages() refuses to move into a destination PMD that already maps a
> THP, but checks for that with pmd_trans_huge(), which is only true for a
> present THP. A device-private THP or a THP under migration is a
> non-present huge PMD leaf and is not refused.

non-present huge PMD softleaf :)

>
> The destination PMD is then treated as if it pointed to a PTE table. It
> is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
> fails to map a PTE table from it and returns -EAGAIN. move_pages()
> retries on -EAGAIN, with both VMA read locks held. If the source is a
> THP, it is split first for nothing.
>
> For a THP under migration, the loop ends once the migration finishes.
> A device-private THP can remain in device memory indefinitely, so the
> caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
> anything in the mm that needs to write-lock one of the VMAs blocks along
> with it. This requires a driver that migrates THPs to device memory.
>
> To fix it, check the destination with pmd_is_huge(), which is true for
> any huge leaf, present or not. UFFDIO_MOVE now fails with -EEXIST in
> these cases, as it already does for a present THP.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/userfaultfd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 61a712e1f9f5..ad9d243dc64b 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2021,12 +2021,13 @@ static ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>
>  		dst_pmdval = pmdp_get_lockless(dst_pmd);
>  		/*
> -		 * If the dst_pmd is mapped as THP don't override it and just
> -		 * be strict. If dst_pmd changes into TPH after this check, the
> -		 * move_pages_huge_pmd() will detect the change and retry
> -		 * while move_pages_pte() will detect the change and fail.
> +		 * If the dst_pmd is a huge leaf, present or not, don't
> +		 * override it and just be strict. If dst_pmd changes into a
> +		 * leaf after this check, move_pages_huge_pmd() will detect the
> +		 * change and retry while move_pages_ptes() will fail to map
> +		 * the PTE table and the next iteration will see the leaf.
>  		 */
> -		if (unlikely(pmd_trans_huge(dst_pmdval))) {
> +		if (unlikely(pmd_is_huge(dst_pmdval))) {
>  			err = -EEXIST;
>  			break;
>  		}
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
