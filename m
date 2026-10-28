Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203805;
	b=3163MJb9pP+IXu8CfYSBFf6MzSRqyQeDX5rtGOnNZ6xW20SjY/CRWsL3s89d74s3/b8J
	 WHdioHxxkShvpBTMgW7nQSCIVloFNCNve7c1dhVoxM4Z+1FBLF9OwtEodcZq0she0Kh15
	 vS9fbmEM3soTIK70pEZRw0ZEG/gr0VWqDxr7zdN9nweAwKL5ga3qyBN8zSZpyOg3ohtcX
	 QBZZdrHJ1J2Q+HjDjzWeBKBEJaVp6utju1mJvH6MUo+BFgmIzWn2wFCucCEbStQ2m7ib/
	 Z0VcIzi4xSrw9tzfDhWxCZCbcrUJcuDNf8n+5XxvIL8L0w/dYe+0jQAkXR2Tn8SgHfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203805;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qIVvq/ZWrS8OHZoPkom4erM5knN+bWWJnYjFer9m7xM=;
	b=gVXAuKPsEX4nMYUYl7XzCfETwNbrErzplx5chrPinKKo5PVfi3we41eBPz50z76qLO5K
	 U1eoMiPrabTLzn6dL1qe0ovijYaTg40EuLWkUOyg4V/Notop/kWARKrN2ZovD5E6A9sit
	 f6u8jMX6tHKNclpOjtOtUSUvVET2lQzuT1RlU/UvQ42cCzhw1zVDf/kj80y68gAXihgkZ
	 NM9ZGvNetvSrSUT1Rm6Xf1J5iLAlV9vmxnlPbP5tcS778GUNdc2pf/7G9Ie4rZepV14wa
	 zktedR3VSmHpLvOsU3ikSkJ34xSNCdEc0M9KvJGOSRAfMANlQBtfJQaFf3mnx40V97g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPJdSz9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B8606A326
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPJdSz9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D01F01304;
	Wed, 28 Oct 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203805;
	bh=qIVvq/ZWrS8OHZoPkom4erM5knN+bWWJnYjFer9m7xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPJdSz9mscO0Y+jBQbJ5oP0QUm70aTGZAWcrT+jTuD6vdx/Qb8OPponNgTk8n4Y1d
	 p2sWMWzZgnUx1CpEIa36nSJs0ptmUy3v1PSY+5U7QZtaYyvgVFGdwrmV/idWeBz2b+
	 uL276y2gUD7+U0y4tGXaStraINA9ds/Tah7Ka3O7rBLgTknFhZ45biPDDkgr0fdjL3
	 tM225xap4ZjlZwwZKe2XhPo8eQzbkt6mh8HuOjdwnqp6ps34iSavqm/xazqa+GhB4Q
	 hkoX+iNqgpYCR0M88XiGHAOdpv6aKD7FRWwo6sDOs7dBia+zC8DeAuPlGgXZ6H/MrI
	 glPcSBR0Ss7hw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4AEF11980052;
	Wed, 28 Oct 2026 12:09:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 12:09:58 -0400
X-ME-Sender: <xms:Sx7iajNQ8kCiIPHs7NsgbcOc-5GiijoyiZmqOQUNtt7qSaz8hw8epw>
    <xme:Sx7iajQj06axGz4Ktgks11H8n88buOjM8aZ3zpB5v_ZfdEc4sVQ8AzJl67hPm-gns
    rWcqzWSZaeimaD5r-DzK1Sl0rKMap85IaUB2ZrgrrZgVX3oSkwPqok>
X-ME-Received: <xmr:Sx7iatb8i1YgECvk_z69s4iSEkm98SVsLZx9jjSlGoLxwvQ1w1B8SKwfc-M>
X-ME-Proxy-Cause: dmFkZTEFX6z6UhyyvpX4H7cx49/QxxO3VmgzZkIh+c3mPnpdkklpGc5/WJE8+p9mDInHA/
    ihdwrhdFqJNZFJ63o8zJrwjlQlbph6GhpkbE+h0iQImiKrOuOoavDT6SUFRbm6Mz5dy4o+
    QO4P7rlUx4zU3AvumYf0B3hS1zqghSAZUBPb0mJwudmM4AtaC71AWoiTCGmSQNrgxa58Z6
    ggIUGdqMsg661eTPKd+HvC3dPYGJs/18pFl173/9BPzIvg7fwpisCMG6shG9NwATmBzvpP
    VfX7QEfwcLulxxCkIwX8hPq6yYSpdGzDAUQTeX0RJ3ruyCzuMqbXKbul+VTqFGT0iPMVCR
    +mNoUlYXMEW3h0bSMeWJS0eleYwoFLQzWJ4kHpgQeEHi0bh83wm9mO6zcNmdeaLsGephK3
    qRARM3QyDwaOc1WL4nHInnn/Y0lmu6mZKJrx0FKFYzL/kkAdhj2lsfoNo+lm9P6Rmg7xud
    Cl1ZVleoAeTpFCEQgN70RGrVnMYJ55p1ehkHbVk6zxr7vKxKEJfr9VFRPYnyzGQr7lgHc5
    VXu8+5qh5ZVSAap/uBFq+HKj6xUlHktHs6pGcWvq9m2wtKX4kiE4SSYO46iWTztTwQi4q5
    EdIvNy5BU82W0yUTBIRfBuAKOsraR8UYCNRUPEARViWGEqZ358CyALQRUgEA
X-ME-Proxy: <xmx:Sx7iasynGZhI3aEsFrGOMXHaEHEdfniPQtim08Zgb8uk099CRJRelw>
    <xmx:Sx7iaoe14NnSZmoQ7v9cfQOv8a5sG0K8N3GSI6ZxlBl3PPjVKGVYcA>
    <xmx:Sx7iagQep8ZOnjKGyIamoFTDxPgul0UuEWeQlmcV9eMv-UmWdRkCKQ>
    <xmx:Sx7iauRlr5DTK8qcMUH6ozbcFvGt_bEb6Ai3yQipjH50fmr3RJMLUw>
    <xmx:Sx7iavUxCWu-ziRuNNw9fhDlb7okjuCuNvmZG3wzZl5CWXYuqLUF2IIg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:09:45 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:09:44 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <auIdjO7IV5UREfK_@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote:
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
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
