Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113219;
	b=tibO/Y75Od/s/YJ2qD2d9SyHI8A2KWDkH9mpKaBGOdFpd1mY1vyP9KZ0CLpVKI+PaeqX
	 X5z2k8MXU7hXCkL5uedjtCChKTQGZyOUMSs94EJrDtHrAysWwgRlna9eVxx/LxFwEi3F+
	 +WVs76VNN/hFSADikU10iunyG6oJQjQaLSAKD810otbAFqw+UQWccXAVWLL+yUehDqynW
	 t9dlxj0++glgzhDcTusa84ccXlVVNxn9+zdQDQY6pC7lP4i7SArs0lHrfFhcqscgvbql5
	 IatTLeICVv8mPcctRFmNcGmdop4L3T0ooY699WrAsipWHLJ37e0r94B6czoI1RcHQBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=qp+fSXor3rJtw8hGRhqYEuRFppHYbzFfezBhq/ClTY8=;
	b=qV8pnwXCk7UsXFGptyUSJ+KHnCIwgpQHwScarF41oMGjJ7h4kc3TqHs7XQk/5bnhZo6T
	 YAM4Zy//iijzrlPr+AL4xRk8Jf0Ul4ZeOIuo5V4X4oxnBjZK0YvSrWSOIJLhVnVsjRXw1
	 VTPoxFx1NFQ2RaUb5M/EQunid36OugxqvZdigRaE090cmMFJpi1byYtC2X26jAwUF2ZY9
	 DoD/S6Zo3XxlU46KFCbeJpoxh2JeIuTCTRrzFbweTYM2/7k2be+Gz09AhlsNK2ypsz6dy
	 zoUEjez1UpUU+Pds+oGQOF3NgnZhZ36CInGxu1KuqlJ2Xz9ks+Ik27m3cNnxvVSymOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnXLdq3k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA2606A32D;
	Tue, 27 Oct 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnXLdq3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0151F01825;
	Tue, 27 Oct 2026 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113219;
	bh=qp+fSXor3rJtw8hGRhqYEuRFppHYbzFfezBhq/ClTY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UnXLdq3klaC+tZ2+JX6PBI45P7W7nF48+f9ADm70UzXvPsh4+dY2WhOicztPbMw7F
	 SARjt9Oczq92TzB6tsLTcFdVUo5032qKNP4oINRE/Q8ajIBJ3KPA69x6ct5ZyaPihb
	 dzmgq7TcIx1PWaY/d5t1JPP1sQw/8RZHDucCg/R/QFCmyDP2NXPW+F6S6AUKz2W+3t
	 Dpk7PNOGHdNngY66tF6fRyZEMJsZsML0o3pMjD/NKndJzXXBZJwiuvk6Lr6JNZpq0X
	 Vrc6vg4zteKiAqZrKEoQENifIVt/YUhXNNs100l6gLc3ci49cX4el5JejC4ULazFv4
	 Ph+fkkfmpEbLw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Kairui Song <kasong@tencent.com>,  Barry Song
 <baohua@kernel.org>,  Axel Rasmussen <axelrasmussen@google.com>,  Yuanchu
 Xie <yuanchu@google.com>,  Wei Xu <weixugc@google.com>,  Baoquan He
 <baoquan.he@linux.dev>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  "Liam R. Howlett" <liam@infradead.org>,  Vlastimil Babka
 <vbabka@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,  Kees Cook
 <kees@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Jann Horn
 <jannh@google.com>,  Pedro Falcato <pfalcato@suse.de>,  Hugh Dickins
 <hughd@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Lance Yang <lance.yang@linux.dev>,  Rik van Riel <riel@surriel.com>,
  Harry Yoo <harry@kernel.org>,  Alistair Popple <apopple@nvidia.com>,
  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Matthew Brost <matthew.brost@intel.com>,
  John Hubbard <jhubbard@nvidia.com>,  Peter Xu <peterx@redhat.com>,  Will
 Deacon <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
  Nick Piggin <npiggin@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Minchan Kim <minchan@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  Xu Xin <xu.xin@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Chris Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Youngjun Park <youngjun.park@lge.com>,
  Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Jason Gunthorpe <jgg@ziepe.ca>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-cxl@vger.kernel.org,  Chris Mason
 <mason@kernel.org>,  stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 00:17:40 +0100")
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	<20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Oct 2026 16:00:08 +0100
Message-ID: <2vxzbj8fp4sn.fsf@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> From: Chris Mason <mason@kernel.org>
>
> memfd_pin_folios() pins folios obtained directly from the page cache
> without checking whether they are uptodate. However, shmem fallocate()
> can leave newly allocated folios uncleared and not uptodate. Callers
> such as udmabuf can then expose uninitialized memory to userspace.
>
> Clear non-uptodate folios and mark them uptodate under the folio lock
> before returning them to the caller.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comment ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index efc9aa2654625..47e7ae152cdf1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3516,6 +3516,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>  					goto err;
>  				}
>  
> +				/*
> +				 * fallocate() can leave folios in the
> +				 * page cache that were never cleared.
> +				 */
> +				if (!folio_test_uptodate(folio)) {
> +					folio_lock(folio);
> +					if (!folio_test_uptodate(folio)) {
> +						folio_zero_range(folio, 0, folio_size(folio));
> +						flush_dcache_folio(folio);
> +						folio_mark_uptodate(folio);
> +					}
> +					folio_unlock(folio);
> +				}
> +

Nit: this logic is repeated in a couple places in shmem.c and in
memfd_luo.c. Perhaps it deserves a helper?

Anyway, sounds like an important fix so don't make my nitpick stop you
from landing this if you don't want to bother.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

>  				if (nr_folios == 0)
>  					*offset = offset_in_folio(folio, start);

-- 
Regards,
Pratyush Yadav
