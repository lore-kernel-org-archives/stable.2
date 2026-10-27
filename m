Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092487;
	b=4ZJgbl3BEXU0i3RxCI4i4PuOgEipeijv9i8j+abhemEYX9wGgqXO1BVnUCtGrRjQaBBy
	 VBwn1ZQYgtIj3x3HkTBKjk1GXws4XjcyJD3WPWMmx57sfJ4/9lHW8ywucfgvNjit4z5ez
	 4TZTkJjpMj265S93RO2WsPRGzljTMpHrxD+1QCUUzP7GVUD7Y+WFCx+J6G9J+GMi49tLt
	 HoMraDMIMK1su8RqD3oNOmy4RwZlaC8VWd1WVTMLHDCeJGGO+xVRhHj6G/vT5Cy37fnRk
	 C9d/nSGgcYVg7IOs1uhrO0+3lNlVu8T94Nmr5zAUYKS22QZ8xE7uT9VokfS2ALvADQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3C9BaH0xhn5HBqYI2J//q0I0p6+i5eg81V2wjnKirFM=;
	b=5fB8gDmJ44C3V5dzynMbGrkQ8NDdt32ZRurAv8ZidHQlJIDEIbW8KuxyB3WYTRxKRBRA
	 cTNdeNEFEvU+nOCBLybnjVXV5/6d70zlRJ3isE56Lw8Z3zcNF61qath16DgHMJn57RXbD
	 nJ62QH33PDviM9NNyn1kOgfs4zpDdXTUxJ9ApOBQt0bBrpfe3zQsw4svqq/KdGygCsnlE
	 FIhoUeyGMpezjDuSe/bZeTcI+mHQZmbSjV2W/jvYcP/7Dsorl//80skdpod/X9OMEt8En
	 DGOs1AUTi22GTecJebfBfhy6KIzcaUPrPfLak71KNeOgIqkN1qz5szKEaFexSRtGRMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wax8ZcaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCB606A31A;
	Tue, 27 Oct 2026 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wax8ZcaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD0D1F01828;
	Tue, 27 Oct 2026 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092486;
	bh=3C9BaH0xhn5HBqYI2J//q0I0p6+i5eg81V2wjnKirFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wax8ZcaD/71DiecJRehBjH5zvLNetiaOZxFQpb1WrNjXeS7UbTJCfdPzju8GkpkR5
	 dhrLX3VqNdfyJG8THsKAy7Zg1MlSK48H8IzHPn4+WXagMvTMTf23VfaYwqjmMxWF4J
	 ++aVQRfE/N3qmeQ4mWlhTnPnTLk6holKtH9fysbFY3Sq0B3fzgYVi6P9bv72BUL8as
	 jPTVF6ybNZ9tbOBT4WgNmDcRrIiEEvZtlJjuia2pyRtxp1x+2LMPFWrT8PiiQnoU70
	 T6x25iwZeTJPgQeNnZDH/2onGJTGqPiDGfF68A322uNHd7QLFq01c+VVuq5nXdSavM
	 /61haflQ2EIiA==
Date: Tue, 27 Oct 2026 09:14:30 +0000
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
Subject: Re: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
Message-ID: <auBrQQ9Lu_261z2e@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:58AM +0100, David Hildenbrand (Arm) wrote:
> Each full scan resets ksm_nr_node_ids unstable tree roots. Enabling
> merge_across_nodes resets this count to 1, even if per-node roots were
> previously allocated.
>
> So when toggling "merge_across_nodes" 0 -> 1 -> 0, a scan that starts
> while the setting is 1 and continues after switching back to 0 can
> encounter stale unstable tree roots, resulting in UAF.
>
> Only root is allowed to change "merge_across_nodes", and the documented
> sequence is: "merge_across_nodes setting can be changed only when there
> are no ksm shared pages in the system: set run 2 to unmerge pages first,
> then to 1 after changing merge_across_nodes, to remerge according to the
> new setting."
>
> Let's fix it by tracking in ksm_nr_node_ids the actual number of
> allocated tree roots.
>
> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
> more tree roots (skipping the empty ones), which is harmless.
>
> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/ksm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b1892..9c51925825cbf 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> +/* Number of allocated stable and unstable tree roots. */
>  static int ksm_nr_node_ids = 1;
>  #else
>  #define ksm_merge_across_nodes	1U
> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>  			else {
>  				root_stable_tree = buf;
>  				root_unstable_tree = buf + nr_node_ids;
> +				ksm_nr_node_ids = nr_node_ids;
>  				/* Stable tree is empty but not the unstable */
>  				root_unstable_tree[0] = one_unstable_tree[0];
>  			}
>  		}
> -		if (!err) {
> +		if (!err)
>  			ksm_merge_across_nodes = knob;
> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
> -		}
>  	}
>  	mutex_unlock(&ksm_thread_mutex);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
