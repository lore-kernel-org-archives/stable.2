Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306394;
	b=2ssfQNuqyEet+UOolzO/2LN6kbuWGL7hEC3O6d5AIbe+dV936nsSeePYoPD84iPPufVv
	 Y0chO5Ldfks0sQ3DrgUKgtjwoH/xgAGZMzq+xg/FxsBHHPUVs0xdJeZqvNPQUddT+3Htm
	 MhycBAw+milnAcQlAWlM+Qp2ue7wd3rg4qjNqWg0L7E6J1+wIsFp/ySb6MP2HnvNfeAE7
	 3QEWHSmsDHLVNuUSYJP14efOHlS5VPTs91BDLMiZVrDe06L61Xg/1iWQFQCViC7ZvNvIX
	 S2fZtcno/L7tgOJhXilhm+aDBc1kQCw8wzPihnjW9fwe5KRv5xLlPFzEbZbOJRMMlaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306394;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kUEfRiVPdPCg2/KqbNX9PPOiFF/eP69nxT6xONTBQFk=;
	b=hoSnPAcS5WfKXgzvDyhmhf59jxaH30nd+Tp/yWh64i8qPQZmOp2vggxvv4TfJOHajNzK
	 BgKqrvTABXcY7km4LHJYKms0/9zjQBNef0iPQWumqMNXgl5VMQnOz1oXigRVGXTRrR/EI
	 g/eRDETMUlh1GXJhR6/3rLJrkH2KpSCdANTuOQSRQTraKtUBzg2FZ7A5OHdFYxkPIDnF9
	 f6eoFP6Pit+/45IIDAbU5g6rxRbzceyp04agzpSfL8D0KqlYLpn4M4kp8iGFSWWYdYOE+
	 EXU/wZkJO3UDrcP5M42StQWqKMo5ZJ8+dF/II4CJm4QuUutSLnk0vnBGYje4keALUFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+gNQr3I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C150606A320;
	Thu, 29 Oct 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+gNQr3I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA2A1F01824;
	Thu, 29 Oct 2026 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306394;
	bh=kUEfRiVPdPCg2/KqbNX9PPOiFF/eP69nxT6xONTBQFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B+gNQr3IgYPjaHbppcw9o3+A/kH5KGFoMEXaT3pmXT0FTMtlv+J0pbqsgNG8qOKhI
	 EzZv32DWC5UMbUTC6nahg8i99r8SlIDGC3mhtb/aPJleJt9pQnXfM7DC3eqXrVeT7x
	 EdKUlx6xc9n+S59O83153Y6MLC9vkrBo3YohvFsMgyPF2XXX8arnY4I/NzKyuM/JEz
	 3ygSXzPCjFoKhHuKLnRUhILHFjQnmeRktJ+2iXs0kQOeWBYEibfl7ylO2Cg8X4ctvj
	 stH0v8Jp4kfpNdJepSKPR7w68ibQTVHXls/i3r3UYfHi7GEl6lgKmrtsNLIYxmrLpp
	 X+MiazDsOENog==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:21 +0100
Subject: [PATCH v2 26/47] mm/userfaultfd: compare exact registration modes
 before skipping
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
Message-Id: <20261029-fixes_core-v2-26-a64ce7f83abb@kernel.org>
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
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=david@kernel.org;
 h=from:subject:message-id; bh=EB1on15q6q+0KCAB0yKS0tRudcnaZpRwYV9wTcssTD0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer203CXiXELbMN4o57IvJUo3yzuqG+rPOik++eEpsO
 TjZ80ZFRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABNZu4PhfzavpnbcmeVGF7QM
 sr8/+8rw5RZPRxITd/OkpnP6gn7Fcxj+e2b1ZInfnHld9ZtWi3l+277N38xu99RKLNbot+cSfFn
 GDAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Gregory Price <gourry@gourry.net>

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: apply fixup from Lorenzo ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 03f1b15bfe63..dac696bda19f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2291,6 +2291,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 
 	for_each_vma_range(vmi, vma, end) {
 		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+		const vma_flags_t curr_vma_flags = vma_flags_and_mask(&vma->flags, __VMA_UFFD_FLAGS);
 
 		cond_resched();
 
@@ -2304,7 +2305,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    vma_flags_same_pair(&curr_vma_flags, &vma_flags))
 			goto skip;
 
 		/*

-- 
2.43.0

