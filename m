Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306555;
	b=5FCaWWdjKH5oQ6ZhLNy9OqHB8V6YWNw0tWkV7NavvgxbK61VCun+NVvgRKqlK13vTEsh
	 lN9TIVc+oN+4/ae+kJBoJKa2E2VkYZT1sswbMCvrcYKKgflo1K+KO0/HTiTmZtyRtCx8c
	 rEuBeVlQIk9cZ5cT7IXhhmnCadiePuTPrC1OoSSaq30cyrRdJi+T3Tub0og9CWlQk+FD6
	 qo4W6tynHf2JUywHcK8oEE1G3m7FwwWmEcjTm4t9rdjMx+KbO74N/kvJMSsPTqekcxoAI
	 31jVAct0fhUEtKWk/6J576spRDPafCjKFIDnPi4TSNtoFXHmsM4/29N1zxDvvsFQmCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306555;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GzohAuTFTF3f/1hrG58iOYYkxgWAfRYzNd87kJom8ew=;
	b=TZAH8UyhLoP3HG5825mENMEjhdQluiVX9QRFkO30Nw41HA8K4pQVI8Logdrnp2ZA5UGq
	 mvwusgBgzDvTyOvlpuqcQfWY8Q9seP5iszZBR14RZWWY+87YawzKetk8n/I8uV7E14a+S
	 0yNpDtxMfL65FK96kaz5mCRci9KcFgXZD1Od8SaeC9YnIGtc9L0qGzV6qNNfD0vPeMiVQ
	 8HHefL2p4FUTXYRCG6h3b/PNeIdGAZ/YwEmeQ5CYbA2xR4+4leSQFz1CegajwnugVbWKv
	 Ek9NFEKcYByR0M4YoeyIQ4nQ7bkaRKOIkoUp2SCAO2bCgrL8POtoE0IoQ9z7vcXZhqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odGKC4Xb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D11606A321;
	Thu, 29 Oct 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odGKC4Xb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038A81F01816;
	Thu, 29 Oct 2026 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306555;
	bh=GzohAuTFTF3f/1hrG58iOYYkxgWAfRYzNd87kJom8ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=odGKC4XbmYtEAL0Gbsmsvx/WY4VvPYy77ntTduDNGVxTee9x8eCFs1dlirZrbm7zy
	 iC+kt5OPi0b7fGJlGk807OCvIbOWr/Z78TV/dFDtdfnfrPq2aHFVXyMPhLCSOvB1Y2
	 ZrN4hFhr9U2G7pJPJRhXKDaX8gWNjGlvbNVUoesFXn/q0rr+u58Qom2mW6f0Q09dKe
	 3q0AyCRIpFeQddnbKDlVIMB1qh/ZQ3BtSWnCL5WPB7IN9/D8mom8vqt7yZu9Csa5jg
	 BDnVwDUFvXRY6YrP7saZiBtyJiwIROc+tG9ELKoNHPe8loZEUzoVScdiDJdLpehZRi
	 /RsACXHCoLgfQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:32 +0100
Subject: [PATCH v2 37/47] mm: fix unkillable fault loop on MAP_DROPPABLE
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
Message-Id: <20261029-fixes_core-v2-37-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=david@kernel.org;
 h=from:subject:message-id; bh=yoxwQ2Y6qIbeUiwHGT1Y0HumpGAEonmZ/vQerxKuLzY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+3czvM5O0THx//vtoUbudj7mWSPupTa/Tnr4Jkd8
 Tn+Vk51RykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABNZl8XI8FEnafGyvrx5M6Kn
 sCw4PefgS4/ySwEXYgxE4k5desdXsorhf+JjyZr1Ze+2Bc4VtlpxsJI/8JO19IGImflnzH06jdO
 qmAE=
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
index 732b8f926de6..77d4bbf444bc 100644
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

