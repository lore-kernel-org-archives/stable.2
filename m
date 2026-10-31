Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440193;
	b=DYocVv3jU7SJeTDs8H/9Zx/BAFa2lLiOIgK84a/mc1acCP3bG1BLEFOIxzaSJSi/MfyE
	 BlQY8nwznyebagKMYegf89DpvofB3DAz4xej+AWmrk7eqsQpG+APsdvYhnLDONhcifcKJ
	 S/F8iWHUuxgEqeByTzq8zmTXMYizD0a0nyIf8ItuEVs4lQA3IPLazRloH23BZbHqn/npb
	 SVuNxoc9tgFy99j+X6ZHlkze7U8p1ZPp2Kkxi+mdMzFrtfrMnYlFUiPRnc7T7DwsKq50K
	 MjN06JaFQFYOw/EwPl5RaSHmbGbQLmLnwAGrseUEUrw+9mZA1H0AhQOhRT1wVJfrokA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440193;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6KPzj8boSo2Gk3+3ECHnUsyvk9AxPiK+EOaIJxEN6Go=;
	b=fBgN3u98ReMoZcFIwNGVhzZbwQL5IoCOCzm1NEEZCrAtJjSh7nZ/7lwlp3eFEVtplC8M
	 POuhpvIYbILGL8xhaIlmWGmXk6hTqpqRE0K6gSXU/K9obXe5sxVGjjbeHWL5T6f8csJmD
	 e6UIWRGqUsCr/R/haZWB33pXkPLBYhbbLcI9rZMfHMtIMeAlPOUSr7rUnbRPjjJGZlSVW
	 o5kSm7gGkhmrOpZE2x3sq1PXiqRodvA3FGFrtpaOXdUETrynq6h42r6tu3wBEYs21ha1U
	 NHPeNEhtCr7Xb6UeF0Oz118cXkZWTV7heQQmL0kd9CQB2NM8cJf5rtGzQGkT4Y93CRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8uJy23m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C04606A325;
	Sat, 31 Oct 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8uJy23m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AC41F00A16;
	Sat, 31 Oct 2026 09:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440192;
	bh=6KPzj8boSo2Gk3+3ECHnUsyvk9AxPiK+EOaIJxEN6Go=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h8uJy23m3iqMl3OwU/TM+eG06BDIlLaiL+p78gyW/VyxpuisHpa2ij0C+rNXmy/03
	 It3m3GuGtjE1NLJE7RvqGkdLdWj64TbEwTq+FK9jdAgAMRRLLG0OFvDhEHOXIwMmzh
	 Ph+e2q0/8C3LArjv4DLBCBIlUpCi3pOHs2a+Gex1nTr7/Tp4pokf6D3HyAEdm+nENQ
	 WR3Dc2oa2Y9tdNn0AJ7rqpEELD1qIZkhidc3x1iia2aUU7kmgloZMD6mGBIbvvHLue
	 tnycJdnsNH7tD/BAWlohAJfDtEVTzqgdRhmAlOZgGnqWVujtbljH2p0m4ztc6FHdjv
	 3AMt5DmbFMxZQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:06 +0100
Subject: [PATCH v3 37/47] mm: fix unkillable fault loop on MAP_DROPPABLE
 memory
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-37-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=david@kernel.org;
 h=from:subject:message-id; bh=3QXuBW/o+aJfpqMh7L6nYMz0PgksViIVDVNcIUyYwLI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs96d4VrvjfLxvuSP3cLVT87tXlD8pIaaW7WLX9mv
 vMx1v/W3FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEJqgyMmx/LLzCanKTqnWQ
 QIReLffBpYG/TVrZtlry33zqrXm9bBrDf6dPfy/+1zggt1ls09usTdH3ZnC6a3l7LSq45vxQq2L
 jNQ4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

handle_mm_fault() suppresses VM_FAULT_OOM for VM_DROPPABLE mappings.

For user-mode faults, pending signals are processed before retrying the
access. Kernel-mode faults on user buffers instead return directly to
the faulting instruction.

With persistent allocation failures (esp. memcg limits), a syscall,
such as write(), can therefore loop while not dropping locks.

Only suppress VM_FAULT_OOM when FAULT_FLAG_USER is set, allowing
kernel-mode faults and GUP to fail and signal allocation errors.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: simplify description ]
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 732b8f926de6a..77d4bbf444bc2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6957,8 +6957,12 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
-	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
-	if (is_droppable)
+	/*
+	 * If the mapping is droppable, then errors due to OOM aren't fatal: the
+	 * task returns to user mode, handles its signals and tries again. A
+	 * fault from kernel mode has no such return, so it must see the error.
+	 */
+	if (is_droppable && (flags & FAULT_FLAG_USER))
 		ret &= ~VM_FAULT_OOM;
 
 	if (flags & FAULT_FLAG_USER) {

-- 
2.43.0

