Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090612;
	b=YcNbWiCtjC1FLyxFGevkrtMxWJXucff6bkz/w6JciwVTyaAZ7rZdAuOMDKcXL9ji6fc6
	 FD6kfPp4nj3xkAvMBrCmsqC36Ysfx9SHmxhgIrBnlKLBuNCYaTxxJez4+dqwY63wYKADS
	 Yc44dk+242XzSIaR+y4mZGxsws+8RIw47idsHZG5lCmkl8/EsMxEO8OWDUjCGdQE2TcDl
	 0iAtci0oJ77Yu501/wJj33SUduQxvhiYVVqJ18VOrb9eZVXuWgJVKXZOmJq/csCrqnj4i
	 z0VUdGrH6Kor+SGUr8MXH67Wab1ltSGFrUUzVfrG9PT98jqX+KOeFxnSOQDwAN+ECEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090612;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dHr232roZz4zxvNcr7fz7EZ96bBQfhBelI7N1e6dtIg=;
	b=f/93ihTyvRM1VQk7MunX6Asl9kqiDlyCJafPtyX6z54gtvA6h9B0LC2kQfISqM//vBn1
	 ePX8uAeKqAeJaELanyry42OTeyj9Wf5j9bwRV7TE8mmNTb4JJRnak76UVBZ0eVS1QyFms
	 pA3/pP+kYeSfQN8s9/HToRwBKtAM4chPKseUHcuaPbFmdvl4YWB8KEJwTPj4VeViHC63/
	 mH7QSQ+D3rOkOuv0gLa1UIM8d7ITTqHNaE7HfoqvekNs3hlsExZ5MZFOLEdpw9URSB8zW
	 Jzj+FNt8HATD2A2UyTgclYwv4qZpbKbbXEowlMgDYWD0T48suK7buB6Z6a144ovc7oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzfqTN9d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E096606A31B;
	Tue, 27 Oct 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzfqTN9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9500B1F01829;
	Tue, 27 Oct 2026 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090611;
	bh=dHr232roZz4zxvNcr7fz7EZ96bBQfhBelI7N1e6dtIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WzfqTN9dybqeLWoA8oUAZ1tXSG8xyenSoildQDFUPskrIwuh0Om8GmkGOBhQ5FsqX
	 3B6I40g9wmGk8NCIIhxhAbDqi/ZMQNeLz88bXgkLZL9wp3hp24AVldencxxNOmO56E
	 4Dk/LyzP9i6+CjPNOmovIvMvgBMfOCP5ftzi7ttPrA1HXuEw+YPYQEt8JuPCPhU9Qh
	 FTU2I/BXKFE66SYqvBcFQdHZeCq08jT60hhxAZK8vNRyQ92PVr8LzDAXu2OR6KFYh4
	 ggHTOX/ZZnJQfYnUIldz4DBR8skhm8PsS7DC9s4XnGtCHDusD1BrLy77dRYwXUQQzN
	 YEpV0CA1ETDaQ==
Date: Tue, 27 Oct 2026 08:43:14 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
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
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
Message-ID: <auBityGTDQjXURWg@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> userfaultfd_unregister() wakes pending missing faults before clearing the
> VMA's userfaultfd registration. With per-VMA fault locking, holding
> mmap_lock for write does not prevent another fault from queuing after
> the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> waiter can then remain asleep indefinitely.

Oof.

I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock via
vma_modify_flags_uffd().

>
> Call vma_start_write() before waking waiters. Existing fault handlers
> queue themselves before dropping the VMA read lock, and new readers are
> excluded until mmap_write_unlock().

Clearly an oversight from the VMA locks work. I guess was always a Herculean
task to catch every single point at which there is an implicit assumption that
mmap write lock ~ readers (esp. faults) excluded.

>
> Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 669f71d485d02..7e30b5ff17be1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
>
> +		/* Prevent new userfaults from being queued after the wakeup. */
> +		vma_start_write(vma);
> +
>  		if (userfaultfd_missing(vma)) {
>  			/*
>  			 * Wake any concurrent pending userfault while
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
