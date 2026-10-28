Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206517;
	b=ki9NWzcYocS+qNjb3YRyWTNVvgOCtA0Bbsgrbx82sXVMWvwKA5IrTTPr2z1go3M/kKM1
	 +M1AFC06OvCOtW2QYmwVAhV4yivu6zwDfkXhW7dDPAHm75mUIRQC2AWjlXzRKAuG4zJs4
	 NgyEfqVhXPutRGDEgqYa3+fyucUMfFhBZ3JdDPzCgYSlLCv7rBSqTUvuDxSdJbuPQ/aqK
	 ac/7PycI20FOVrad9Nja5z+kHHHZEKFqPdq2KOckfV/IIRn9UDnzlrCDXpApgBKlD9Kbg
	 56iHq1f1nDBg3vnH/Fk5j5ZMfdumOBauymN0Se1ioIdu4x7uEPvE5hpIub/P1hrs1lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206517;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Z0ZhwvuKB4zpYCGY+1GjLRRMsHPTa5Lvp91s/JwcgmI=;
	b=SCpP3ifNZJiN17nWV9T+DQGVnHgOCvreLSUd/m4t6P1pjqX07LpRQXhpZV3PHHBXI5Yc
	 PWWo3ayz45CctdyZhK7RVZ16u2ej3K8BS4agKNyVyuHMdQE4tpJIxnI/+P1kI/U5XQn8e
	 UooPCxye7gzWmjJ7P6fo/Q0H6r/+O0EZwobQI/rM4ZkYA3TYvkz1N5nHaexIYL3qHuNwl
	 cp1NxOLjl0cm+BBWAHFmJVnQ7X+rWjTi4KM7CytajVAVgRKrUNCBQtbyj1yc8ZSjRKtaz
	 xFLnGS8+v0hjt3MiO6n8rALTVi064mk+A++g1IMOOLH0uol2Cik3ncK/7MH1NTjZrVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlFpwLKt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64F606A31C;
	Wed, 28 Oct 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlFpwLKt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B221F01383;
	Wed, 28 Oct 2026 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206516;
	bh=Z0ZhwvuKB4zpYCGY+1GjLRRMsHPTa5Lvp91s/JwcgmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JlFpwLKtSX2o0aWLZ/b3/7yIjMHRAOr+vEDpShfZy+KAUEpwP/sw3ESKIkAG8yW/h
	 oOEG45gGP2A4Frdj40SEV1yFHzWd11p2LHszSy4mETnk8ASvOgXY2SLhjbhAee6ST/
	 XxgWsEetfuCismwQo2ooCFRZXgJNelrESZk3Pplm9mfLTgS6JDiI2tadgjYICpwTtX
	 NUaI3lEP+vBi4W4HMuS7/p0vFAysdqyoMbljlYLFvjTjKA/id1O7lADhvEzcESivIW
	 gRcMJodBiNE93JgviyRdy7Sqv8JZ0fLti6a45kGshVZVGtE6RF7QWHxX7vONNVIcGQ
	 BghLRGm4Q4Twg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 781C0198004A;
	Wed, 28 Oct 2026 12:55:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 12:55:10 -0400
X-ME-Sender: <xms:4yjiajSARqw8PioWyLkupEeXct9Ss2qs5djqP4hQga51zyA5CclqhA>
    <xme:4yjiaqF5uBuDkSDsDBVun3Nduxg_VIy8zCU5JbQmuyrxWrYRMrJ2uEtcy7Twvuij6
    U9QyXXC7AkQ-_yXBOAoKFfx8gFyBSvVJ-PR_hzb6Szh6PHnzb9Cl-os>
X-ME-Received: <xmr:4yjiaj-3U1reClXYJMR86x_214YB-E7NPJqkmAmytXP6g94Td4_LNsXyLGU>
X-ME-Proxy-Cause: dmFkZTEH/JXmOVrY1taDCoPaJq3IVEd1uOJXsXXF/9Hj9n77Aoo8DF/Z2+y6VwUMjdyxL/
    vNcNxlWPOrzJjnTTnhU/i8mG2RaecFzcvs1d/58U+81UT2rrSqZcuXVcmJPvN+85Vxmst6
    M+xIX1By265vICLgVpWMTiDzp4SikoR94mt5KoeDHe0EMSHOdb4HjYnJ2gFn6Jl/jXpTbW
    1cj1cjuHzE0QOe4Vj87hxPzVA7/e5WKQO7i7HlZnpcOqFBH4nZCcHIT12UXxL8WeWRxmIl
    5Im68ywTuP3WqKspjS2QQUDWVpnJdjOhauD/wAZQybXH1dmkgbh8FRIT9xxu5hpwJaaomC
    mvUYquwQCKDqfI6kfvDJMybmqBz7q/9PFZ6wxnj0QM2XOrQem1LihDgZxlgfmoxJzYIsWu
    xbnrF8t8WIJ5hEFFFVA/MpFaq7kGfFEDtPj7c/5lR+6uEB6MT88r5l0hakRGsn+Sd9HUTl
    b3RB3DDyj5tujdg60fA6EJQdbrWiA2uBzz55umormQ0ogMeP6OGN8c56LXAD6GGQ/PaZmQ
    IQISuPc1mDylIDH5VLMmYpcJ31tdiRrFvBKWYGWu+h5ifZZ2RLfDnGQTfxhGSfZR7jcFMW
    MFdExhcE3jnb1xzwCCOxlhc/jz01DYKk67mV4yzeBryfzQ34jWvPrzhEgeUA
X-ME-Proxy: <xmx:4yjiaoFcaoyZWpIYKFY3v7C-Oj28kP3zeTCZgSy395wYH63piXPgLw>
    <xmx:4yjiaphEdO-ptGAYs-gU575cuvwMxFSx7cAsAFR3lQSHx_aSFaRWEw>
    <xmx:4yjiakFOsCpyaRjuMMuHroAjcH_Safa5KEzD4ud7UwmaX0IzR-ZYTw>
    <xmx:4yjiat29K8iz33MgZzunPtVmpyVngsMlLqflnxkPJ89YD8mgu21FZg>
    <xmx:5CjiavpckMmHMDqrTmPU1G6w75v7E6SF6dz-jOjzrFV-Ljvs7_smwbqv>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:54:58 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:54:57 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auIniV8YSpA4_oxg@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:25AM +0100, David Hildenbrand (Arm) wrote:
> invalidate_inode_pages2_range() skips a folio which no longer belongs to
> the mapping by the time it has got the folio lock, on the assumption
> that somebody else has removed it from the page cache. But the folio may
> have been replaced, and then there is a new folio with the same data at
> that index.
> 
> For most cases, like folio migration, that is impossible. However,
> collapse_file() only checks the refcount of the old folios, under the
> i_pages lock, and relies on their folio locks from there on. That works for
> users which repeat the lookup when they find folio->mapping changed.
> The following scenario is, however, possible:
> 
>   CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
>   kiocb_invalidate_pages()
>                                       read the folio (old data), lock it
>                                       refcount check
>   the write completes                 copy to new_folio
>   kiocb_invalidate_post_direct_write()
>     find_get_entries() -> old folio
>     folio_lock() ...                  xas_store(new_folio)
>                                       folio->mapping = NULL
>                                       folio_unlock(folio)
>     folio->mapping != mapping
>       -> continue

The diagram reads as if the folio lock should have closed the race. It
might be clearer with CPU0's folio_lock() after CPU1's folio_unlock(),
since the reference taken after the refcount check is what matters:

  CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
  kiocb_invalidate_pages()
                                      read the folio (old data), lock it
                                      refcount check
  the write completes                 copy to new_folio
  kiocb_invalidate_post_direct_write()
    find_get_entries() -> old folio
                                      xas_store(new_folio)
                                      folio->mapping = NULL
                                      folio_unlock(folio)
    folio_lock()
    folio->mapping != mapping
      -> continue

> In that scenario, the collapsed folio with the data from before the write
> stays in the page cache after the write has returned.
> 
> This used to be impossible, as khugepaged only collapsed files that nobody
> had open for writing.
> 
> Restart the lookup at that index, like shmem_undo_range() does. The same
> problem seems to exist in truncate_inode_pages_range() as well when
> truncate_inode_folio() fails, so handle it there as well.
> 
> Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/truncate.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 733d2713a875a..6d8c0ec4623fe 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -499,7 +499,15 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  			folio_lock(folio);
>  			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>  			folio_wait_writeback(folio);
> -			truncate_inode_folio(mapping, folio);
> +			if (truncate_inode_folio(mapping, folio)) {
> +				folio_unlock(folio);
> +				/*
> +				 * Folio might have been replaced: look it up
> +				 * again.
> +				 */
> +				index = indices[i];
> +				break;
> +			}
>  			folio_unlock(folio);
>  		}
>  		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);

This hunk looks unneeded to me: its second loop restarts from start
until find_get_entries() finds nothing, so the new folio gets truncated
on a later round. Or am I missing a case?

> @@ -760,7 +768,12 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  			folio_lock(folio);
>  			if (unlikely(folio->mapping != mapping)) {
>  				folio_unlock(folio);
> -				continue;
> +				/*
> +				 * Folio might have been replaced: look up
> +				 * again.
> +				 */
> +				index = indices[i];
> +				break;
>  			}
>  			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>  			folio_wait_writeback(folio);
> 
> -- 
> 2.43.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
