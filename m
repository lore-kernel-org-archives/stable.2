Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319614;
	b=4YiCCv5CngZMqoEtOqhdo1lreY05R9RkLFy3d2nEUNCBYUKH15+qywkykUKL+wKZbYWa
	 uCrpAG8n9EukV6EnsyB9psrneElaPANXxo6ivGNzLYqunaD7CTrRf58dSKTaTW5flpVkJ
	 ZkAFJgX8hBl/UZYMDaT0+g8chSZpGMvc+WaQJCn6RwSbj7lcC+WQ1oejtwgF63kTgAQxr
	 oQdMw6uObYCzqJXXLRYWowyzQ4U+tirkIqd4+40WFKUn+Til2AdYn6CO2ntg0snJMzeD+
	 1+61mABJK8bo+7BXBm9h61txvhmAX5abfBl024JUMSZBMMgEOBLNfqcpML6Mp1ayF9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gUNDzrcBQCofjPtOZhO0zF/6BwtiodHnLN9kfJEdKls=;
	b=UMXouqIgSYYfJt3d7hYUpGrMrauHm1eGUQN+3IdzYVv5G7DwEaEpc/KcqMT9j+vlL+H6
	 AtTr6lUXIQkOaeqqGAVba2P4LN6+bGfi4mmjyc7azqIF4C6iXkdWqCJg3jBxOD1WIV7fF
	 UF4z1iAG0Qwhi7US06K0l6te14nl5bhmVc5vUm+EKx3k97rU0RJNWZmUIE5maCsZ90YBN
	 qmM3KjbhZ3Wjh1v1xvpGPiWjl90Sec7Jvon2AmvKnDiAKw9Qxl7h0/WFS6VwvKxZ8AbrL
	 xP0mzc6x0gwCQT6P4nAF4SXzQ8D+JDjdV76ixm9iZJrfRiB3QysjOjPW/BhqADJOojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMv7mkSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94F606A31C;
	Fri, 30 Oct 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMv7mkSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86C1F000C1;
	Fri, 30 Oct 2026 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319613;
	bh=gUNDzrcBQCofjPtOZhO0zF/6BwtiodHnLN9kfJEdKls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OMv7mkSB943eqjxfOdTCTqRn8rnHCaFZTrdaPeB0aIFCob3E3fqLF62qDpAEPjHQA
	 B3xh+10xm0pLuUYynSQpI6Nhgsdy13RCNCEvL/EsGdSb7FWvxPCUQBVJ/KVoki3Q3j
	 A7o8d2rcIlBgQP9lheaOYTIDrvi9q3rsoE+zz/ApHV8bjiyRYYLLaUYBuhT5JdA0R1
	 w7mbCA1lQdx5BakPTjA+ZD87OkbCVKcnrx9v8R9+8bKdOhFqSO1ssMBMBUYRkSn/Kv
	 BpHEmrr7LDOBQR8TBi9SkI1IJdsaRv8CC3SznbrHhfqdDWrNhiMX7QP/0o/p/4lUxU
	 b2bHyvWufwEuQ==
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
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking PUD and PMD tables
Date: Thu, 29 Oct 2026 17:20:03 -0700
Message-ID: <20261030002004.154595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029-fixes_core-v2-1-a64ce7f83abb@kernel.org>
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

'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
But I can show there are already quite a number of recipients, so I'm just
noting here.

- Brian Geffon <bgeffon@google.com>
- Oleksandr Natalenko <oleksandr@natalenko.name>
- Steven Barrett <steven@liquorix.net>
- Yu Zhao <yuzhao@google.com>

On Thu, 29 Oct 2026 21:32:56 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
> 
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
> 
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
> 
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the PUD
> handling is required as well to handle folded page tables correctly in all
> cases.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]

Looks all good to me.

> 
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Kairui Song <kasong@tencent.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
