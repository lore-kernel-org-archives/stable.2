Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215673;
	b=NKpdG9AwKvq3bYvI/gcTkW+p0dr+prco39KxDbwGtS8+F+Kwk7G5qZa+Heq5VJj1hsbD
	 R/vGX1BfdfJY+Jb7Sr94cxRimaHKVuQ16CjLeSPWQ37DhjyV/Aj/J4nIG3WHk7JLHyEd8
	 /XG+2rpwzDIs/0i0nautzjTFUynFfkjkuC2pmQxNdqJR9HQAtbiXB09yT65pouBJUijUz
	 oBfItIclj2PxaeHoYXPU2G82b2Fia2DxaPbAc5kmyZgvX7bO2VS3zEFJKy8jsHxOAg8wA
	 uAWXKG6mED57xhblwQlohZrLwxJeJou0nNOj6DehN9/XPFQKlCEZxA4do8r3oquiAbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215673;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BSMajUrIRWokvEVqqfI78Nzwlqlux4vwQO4+MOjfV+o=;
	b=AjsWixkoX0TFGnMoHuqrLOXAp86bwf1+APidUp6To0phylmZnCgFXrIlgQRs1r49050n
	 Y1Ai92h9fHmnCPzersgOzJmLZJIF+UrTHXCW/JXHHc4iYHeEntHkmC6mpumaqvB/9H/20
	 jCGYjsET5sB85H88J6CR7BP7vnejbg5OCkFZi1U8RexlLMZWIt+Dbdcb02NBCQ0WmcXaK
	 UHK9kcTwHqTM/EMEne8mmD76CvLKPgR1JV3mImZM2dXt182QLohx+bLx72huzueIRz+kv
	 j2pGgunLDgd7ZmTLjTyZqfRfyPogtXbiGl3uqKIHa2TEdwKIA3gl1X2dwiQDeWo24KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n+5+OHRQ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE5606A31D;
	Wed, 28 Oct 2026 19:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63CE5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n+5+OHRQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	From:Reply-To; bh=BSMajUrIRWokvEVqqfI78Nzwlqlux4vwQO4+MOjfV+o=; b=n+5+OHRQAxJ
	59yCrr69KDXP9RQOEKk8GR+jY9iET8bVfnnVgTQiEz0oQgq8pbdIld1loOHywld3JdPYWF/PmBYGB
	RKWmW3U9wbyYYlK3WoZZTF695hgn819oakXiz97sHa5Lajz0bodTI+2SW2aoU/NHoOzPk6lqv0Y0d
	P743VNNi/bTMYmAOwVT9LcxFdKO3CED846nUgpBT6NgsNw/qIwpUTDZ+7asWMmzTiCPMmvoCGCpq7
	Wt6YwZR0A/kEXrEdbvwPUErnzMJ90+XEnSlUu/iizkfDXjblmo6F1IW9ZjeOrllCySjm9uD4jgJZU
	jm8msZJ5H0z9IoIqIjHBnxQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xM9IO-00DAtn-FH; Wed, 28 Oct 2026 20:26:48 +0100
Date: Wed, 28 Oct 2026 16:26:27 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 08/46] mm/filemap: finish fault cleanup before dropping
 the fault lock
Message-ID: <auJMY1xFp6EkhXbZ@quatroqueijos.cascardo.eti.br>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-8-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-8-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:28AM +0100, David Hildenbrand (Arm) wrote:
> On a retried fault, a fatal signal interrupting the folio lock wait
> makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
> the file. However, filemap_fault() may still need to release
> mapping->invalidate_lock. A concurrent munmap() can release the last
> file reference and free the mapping before that unlock.
> 
> Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
> releasing invalidate_lock. If the fault lock was already dropped for
> I/O, release the existing file reference instead. Keep the fault lock
> held for FAULT_FLAG_RETRY_NOWAIT as before.
> 
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/filemap.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6b5e1d866a9e0..b04be64a5069f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3308,11 +3308,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>   * @folio - the folio to lock.
>   * @fpin - the pointer to the file we may pin (or is already pinned).
>   *
> - * This works similar to lock_folio_or_retry in that it can drop the
> - * mmap_lock.  It differs in that it actually returns the folio locked
> - * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
> - * to drop the mmap_lock then fpin will point to the pinned file and
> - * needs to be fput()'ed at a later point.
> + * Returns 1 with the folio locked, or 0 if locking failed.
> + *
> + * On both entry and return, a non-NULL *fpin means the fault lock has
> + * already been dropped and the caller must eventually fput() the file.
> + * Otherwise the fault lock is still held, including on failure.
>   */
>  static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>  				     struct file **fpin)
> @@ -3329,21 +3329,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>  		return 0;
>  
>  	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
> -	if (vmf->flags & FAULT_FLAG_KILLABLE) {
> -		if (__folio_lock_killable(folio)) {
> -			/*
> -			 * We didn't have the right flags to drop the
> -			 * fault lock, but all fault_handlers only check
> -			 * for fatal signals if we return VM_FAULT_RETRY,
> -			 * so we need to drop the fault lock here and
> -			 * return 0 if we don't have a fpin.
> -			 */
> -			if (*fpin == NULL)
> -				release_fault_lock(vmf);
> -			return 0;
> -		}
> -	} else
> -		__folio_lock(folio);
> +	if (vmf->flags & FAULT_FLAG_KILLABLE)
> +		return !__folio_lock_killable(folio);
> +	__folio_lock(folio);
>  
>  	return 1;
>  }
> @@ -3572,7 +3560,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>   * vma->vm_mm->mmap_lock must be held on entry.
>   *
>   * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
> - * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
> + * may be dropped before doing I/O or when aborting an interrupted wait.
>   *
>   * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
>   * has not been released.
> @@ -3728,9 +3716,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  
>  out_retry:
>  	/*
> -	 * We dropped the mmap_lock, we need to return to the fault handler to
> -	 * re-find the vma and come back and find our hopefully still populated
> -	 * page.
> +	 * With fpin set, the fault lock was already dropped. Otherwise it is
> +	 * still held. Release invalidate_lock before dropping either protection.
>  	 */
>  	if (!IS_ERR(folio))
>  		folio_put(folio);
> @@ -3738,6 +3725,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		filemap_invalidate_unlock_shared(mapping);
>  	if (fpin)
>  		fput(fpin);
> +	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		release_fault_lock(vmf);
>  	return ret | VM_FAULT_RETRY;
>  }
>  EXPORT_SYMBOL(filemap_fault);
> 
> -- 
> 2.43.0
> 
> 

If I understood this correctly, the invariant is that if fpin is set, then
the fault lock has been dropped.

At first, I was confused that maybe_unlock_mmap_for_io drops the fault
lock, but in that case, it also gets a reference to the file, so fpin is
set and the invariant is kept.

With that:

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
