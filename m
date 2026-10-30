Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793320483;
	b=CFx3KKxWKkApu+wZGvzCokCcDKhWLLRzq0MeJBmwu4M1G7Z7pXn486UDcMCEBJANzR7x
	 oOxhfoBefTleT8nj7+t5hH24p/5JV8jLpktQ56qlrNZqPKcL3BNroDtiRu8M7JQ4P5fle
	 ss+aiAK5p09p87BbIYib+wYuGv1eh3uvt0Z3oVcXc+cMREdJA9oTX4NzYbAenA+4fJ7hR
	 2VjfvKttJ0cIk4Sv+XmjpPexcotOm/wb54ClOvYwfVDz/a3DgOXsPOObc2/Ab6aBLOanS
	 l/sRwXWKwKCfIGpoxX3in+FNsYjhVOyvdI+m5nle91BaPOJXoA9VfOhAfwfQkZ4T72w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J6qvhedKX/gt9L39bpVgRBd7A0g16i9D1HZNiTvqkfw=;
	b=DNxJpkOumPZvK+vLn0MMJY8TBE8E4RAO2sUhVqYzq8PUGneH6AX9YFG996RJt70tEutH
	 03s96UhPmGwCobKI61KIpVjQjpbHsI1W+f0XB1j3Z0ODsrn7DrQCX3Wq+oKdN6MujFZ2i
	 90J+Zek8DiVXgKp8FKRL59kmhjhfBNQ5mDYI0Kwvh1eGT0GP1ujrg/1k6mxVlL3whxUVH
	 lylF9EJGA44yTtrCDaA3PvXjjR2oD8JVWPUmHUOaZUuq9LRWKVs/f8+3F2J4JKTV+4A7E
	 4dpzYb+xl/8D1cpnU2Yt8p1tKfWt8e73pUtsvWb/OHg7F3hkKzsgd0pXOgVgoaHr+jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DduHRuPY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543F606A31A;
	Fri, 30 Oct 2026 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DduHRuPY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BF11F000C1;
	Fri, 30 Oct 2026 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793320483;
	bh=J6qvhedKX/gt9L39bpVgRBd7A0g16i9D1HZNiTvqkfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DduHRuPYmFLQVXIsNcNjApO97/T8X2q8UAfCyYP1FbDA55gYCiFqIxgKlBRMzDPCT
	 Eqs2Hx8NW5JNHHOwoaWAREmZ9P3g0DpqSD6ZIAALIBan8uNdEC7bloNBM6ojVGEYVk
	 FENFOG2Gdb/Pe7A0j+ozRR73EUaDH16qGjtXlvUo9kWAgkt1QHi+VdagnEw8C8T74j
	 Yr8bysC4D0OxTeYJFfW5QuO9Da+Ehdf3XvdtWlh8G5C0H/tFFCwNzQnltS9dLOayxj
	 OH44Anbtpxbx/w1SEQjMZhJc6+ynBnLLft0fXjVDgMDV3v73CICkPnVUjb7wRDMMx3
	 S8ms98yTtaxtw==
From: SJ Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 02/47] fork: take mmap_lock before copying mm_struct
Date: Thu, 29 Oct 2026 17:34:33 -0700
Message-ID: <20261030003434.154864-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029-fixes_core-v2-2-a64ce7f83abb@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 21:32:57 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
> 
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> cause inconsistencies.
> 
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> exec_vm, stack_vm), as that is now no longer required.
> 
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
> 
> Move uprobe_start_dup_mmap() to preserve the lock ordering.

Looks good and makes sense to me.

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
