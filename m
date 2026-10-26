Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057350;
	b=Vgh8bFdy1DH+ZX480hdvevReYQKC570rguiAgmzS/mqkmIslvrQTasNq4B4INR9Sj7QS
	 2EgE8d7Mix+X3DXQrfY6bbXF/h6vByVGe334doWSE6GyK2/JtDJTXO94d14HAGGI1k92z
	 q076qNDj73Y91iVqirzVCCGkxz/B64Twpu90U8O8PQMAoqpmZYOF9BxRQB4Ir4cHuuOfP
	 TehLgNebIv0RqbtN0q9WzUOvb1VIaTGsnieDOdJpXamxrMUohCKjHrxtMnKbxDRjpPmmc
	 1fPmE27hnbGVxHsdodxxYA+VCJUq9C4ldrOuEyCKu61TbXHrCOZ7iJG9bpxWKT3p45Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057350;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OoFHaYBhm5BDHRt4hk2dDlai0Lu5WpyAocva34cAfYA=;
	b=upEET9uWfLzCTjdHb1OnoY6G6IqGN7mzr4HFQ9ww7FZCpyZf6QVvBCVEzvXn/C6aWPGa
	 zFx6MCPI0QKSNxX3KvkAtQISpdfH+UoK52J+oV65MGh0PWEYHKlnfhgCcEUrEWZoyiwHb
	 7VMIMqLJ5/78fkodnemCBczZtwPt8o/SGV2Ebsiry1+K74kL6kpDli+zBydd8ZrqmW/nZ
	 5EpeFBm+zhiOVkuls87voAIPbLPTzmd/0ZRoHAYd1+vV5B8XUvnyZE8fPRNjv5MV7bHS0
	 9tFWbvkAEfqIj/w1zOycJQN+ZPT83UtnNB/qsRJtPak06as+m2gnRiNaFX4QokqOqgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UNbUEG/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485EC606A31A;
	Mon, 26 Oct 2026 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNbUEG/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0091F01825;
	Mon, 26 Oct 2026 23:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057349;
	bh=OoFHaYBhm5BDHRt4hk2dDlai0Lu5WpyAocva34cAfYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UNbUEG/SujRxvLabLs1Ob9p21oBhi+rGXvfUKjqMDQc12IUiZnwmTDApSDiN/doHK
	 Htp9Ipsw+SQp+pFzIORI8kLx2XLdu4rOahJ0TPlelHfX1GJ1qLDkN8+N+aWCn8WCds
	 tZKLfzo3kEI2Ic5a7yAs64WNXkp0GQ9463s7JB2V/ciJHVqOo5idW1iS2SKYE4l3o+
	 mmQ3vIfL+tDLHRHgEyxeKpggddER2NA819TKZnVHtRhi+Sq3NPEIiR5ET0FwgZX6ei
	 fEZXbzJhICbnx1enS+A8NU5WTSrME8TXg/tsHJn7ecpC43Su1OH1tQwLJM8cp/lhBz
	 YEOm5b5Nlxakg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:56 +0100
Subject: [PATCH 36/46] mm: fix unkillable fault loop on MAP_DROPPABLE
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
Message-Id: <20261027-fixes_core-v1-36-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=david@kernel.org;
 h=from:subject:message-id; bh=pzxM/cFKO4VXQWnP1gi4l+XWqAOEVbNka7bwCiIYBW0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu358ufnWFRtyuxz0v7f0W/Xstsp+rpij0whZOtoAdj
 O+fvJVI6ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAipR2MDJPYqpQSJzxd+VjV
 Sur4qftq4hcCTkXs/XHuWWzbsvvV/zwZGT7UT1FdZiUx0a1TNyc2/fYVjS1HumMsfZ2tf/o2Fkz
 IZgcA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5c5f326b8bcbe..230a2f4dafa13 100644
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

