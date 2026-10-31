Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440021;
	b=ph2b8KUT8CC+8aI+Ih0rsxoluZjL3hvgYZmHp+befecyl6piXGomqUVTcqTO1Q2QGmMJ
	 OEqGUHAsry08CzjX0qDQXU7Lp6XEtt+Zh7Z11bU4t4x667+5lu8dDlaExSg+1Ar2LPczd
	 h/qQqXp/sPYLSly53P0x5Gkg8NA5nzpojajabBiu+3VNqUa8oCMSgsaPeqJM/HVNahqR4
	 2b6N1eh6zqMbwFIJYFcj+Kxa/vtWv2o3RQpMehcGabBNlP2Tkikdu6qqSK7csSvliM8LL
	 BqLYBsLE+ecrAzqG1dAmfpwnTLTsel/iuJ3uBW0fR908Dm6rfkK8gw8R8Q+s3SYqsKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440021;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gNn7/nSxmNJguW2bsADoqLsPI7cv25lI/JHeobxIgIk=;
	b=wukvSeIeNrXCjsurhGB2f3pe/ELohPOlIfFPCOirkeIriuRZ0FYsBmaA5j4R3hRbTafT
	 GH5eQOSmIWzgWPrnOm4Ybq0gIonmzTXw94yfymylTwgkthKbmDsJ0aQyVpVBU2wszVG7I
	 A8DUrzeJx135OigzYCP69xRW0Njr+3PQr8V/h6UWKdwMvSFJ//w6mSv5QqLGPMCwUdrfX
	 GQq5Xc3XsrBj+5tKJ1I0MrbTiAdDS6AoGHv5HwHGkmEsuKUsfRYAykdf+IwXyIbMCzrqL
	 wV+e3B4UfHfZiEw4W/9KFW4biQ1FKvaMO/hUwDfjUi2O/WBsPwH91/iUV7hdPXQ7LdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Goo08VUO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF0606A322;
	Sat, 31 Oct 2026 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Goo08VUO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A131F0093A;
	Sat, 31 Oct 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440020;
	bh=gNn7/nSxmNJguW2bsADoqLsPI7cv25lI/JHeobxIgIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Goo08VUOyTuxB+9BiU8tT1hGY7xIbPlcSmnFKYKLEns6CjMozp+42PLDwlris0Wgy
	 Epy0qZs9ruATYG7k3H09RtPnyDeTrQWjydx2A76PkzWc/HJEqku1kfq+YGHjvzgiu7
	 PVzQSIFw2G73kn0/TmY4S7YikUWi5ZjSlNlCvW8sTI4Xwv03qxL3EhI9T4GGCOuzOS
	 wqesxAZme6fwCbZotjvP7RH+qDfB95lIIOdkup1BldzJkCVJXYxqy9DC9vPqebcprH
	 uLdmoGd5Ixnvi0Tvgq2KahgXTyv1qFs3LN+TYfkQH8ipONbe0mXOCdtPulAg5ZVhx7
	 dsOwRYfOdSfgQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:55 +0100
Subject: [PATCH v3 26/47] mm/userfaultfd: compare exact registration modes
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
Message-Id: <20261031-fixes_core-v3-26-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=david@kernel.org;
 h=from:subject:message-id; bh=VPLF7ZF60P6QZsc5ogJFtB1G0DgMIn6ux/cdpuH/iTQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs/ojGKyT+C9PCWZu/jAdn/xR/eWdutsjRLU8tn3S
 GhxtmtcRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABNZIMzwV1CyVabwyaF8oQum
 Z0+LdgcvbTw/7Wih/MHrHFWK3NvDDzD8Ffi01Oet/XuBJXyLvH7pvd019+vmjPjl/i3pgnKt0x3
 OsgMA
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 03f1b15bfe63e..dac696bda19f0 100644
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

