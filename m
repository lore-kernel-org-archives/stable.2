Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439958;
	b=GuPqHZ6DuCSTvn1iIz4L41420U7eUK1oCg36EyKUZyU90ROCeSNZRZUCZi3m8NrGqvKZ
	 0BhmphzxKXagh50iHZUW303Opd693L89h6aGqhpdRI/ZGVJ1v0bKXJyFFqG5BLPgaVXP2
	 SZNPiyhyBW05AcL8wyNWFFLYwj39FJYsCfVR/Z7pqdZRP0Vsohmou1s2AOfm6pA0Otcbr
	 dxL6TTqkc+j+uDeQAGLvfMt5L1Q2YcxEdVt4F1a/+dLUIBcAEaAl2U538ptI67qUEiHmS
	 mDjIvrBXczmgq2tFPWc7RQO7Wdn9GAVPgjSnbNCjQq59rAVC7mkrklBOz5/ArX7nfrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439958;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wISwi351T9RVVV1oXeQonBfVyTKFfK4XoWM4mZGU1z8=;
	b=NsfYYEiD+gaO4EB1Aj8Cb8WY8TJ/peSvj5yMU6H9rDRb9MowlRdkXjud5K1W52mqC009
	 phiAw04qR3bEtjbZt6qxr9cJdvLTcVd8kEY1drRqBmI/3MYI8tOH/NeZs6pn5zVrAAHy9
	 SvakRO/0A3gQZKqkTcZGG7Br10Ymfe+T3ME2iiDEDA1agt1X27B0w4Hzxr65MjboWBjtS
	 XYgaarVHQ7y2/m2yILqSP93B6eK+OniQYTbAJMOOcNaA+X3aker0PDqmApKZf7AikA3ZS
	 wLrhxZMrbsjGf+xHBzYitF5sR7NFh6zOBXvoFVRj7X5XRTcGkES1z2gFoqnk8QnxguQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OcVH/BeE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DD606A320;
	Sat, 31 Oct 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcVH/BeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278111F0093A;
	Sat, 31 Oct 2026 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439957;
	bh=wISwi351T9RVVV1oXeQonBfVyTKFfK4XoWM4mZGU1z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OcVH/BeEc2hYfL2FYGWe1OvmH8o+k5edNc4FHDUjc8QmLWMD9qEaA3739kvUYuIIv
	 NdEhiB4tuErpPCysmctpgOwiA1RyjWRiKmEBs4q/oO0aFyWb6QW2imFkeevKJ6/u6/
	 A5D7ccuqBCziN4Gk+eR3salFGBi6bsDi9+pKQkmS4CuDSUFnOvvuZSPJhGkhtRUJuz
	 hyaWctchXf7KHnMJMYfXCPdeKm59BqQ5oSysl9esxUiYfV5qJnQm09ojPLZu36HExp
	 qeaPCo7g8Ah2K2QCxL85rqYn6+orFN7B2pkZTZuUAVM5jv2YS9eLZFOLhcs/7mIU3w
	 4zHQWM0WMBKFA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:51 +0100
Subject: [PATCH v3 22/47] mm/gup: check for overflow when converting
 nr_pages to bytes in GUP-fast
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
Message-Id: <20261031-fixes_core-v3-22-d6437171ecc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=david@kernel.org;
 h=from:subject:message-id; bh=kuHYCo8jZXAQ9XN8vjw93pI/nGqY4DS2NH2YO8khoeQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs94vWxtqPbuuB9vUk9tOlh+p4nLJ3bzr5mJJZUfV
 U4vWNkT0VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEtM8zMqzlOOtfm5t343jZ
 1o5lDTYVTDu850yesrHneqye5kuf74sZ/leL5UluV9b4zxeU2FBTZ/1S7rP6zpebP1huXfhOy1z
 gLQcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The overflow check in gup_fast_fallback() only covers the addition to
start. The preceding nr_pages << PAGE_SHIFT can already have truncated
the length on 32bit.

Users such as RapidIO's rio_dma_transfer() can derive such page counts
from a 64-bit userspace length.

Let's just check_shl_overflow() to reject any such overflow with
-EOVERFLOW early.

Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1c2ac7c66c309..ba4907b352323 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3225,8 +3225,8 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 		might_lock_read(&current->mm->mmap_lock);
 
 	start = untagged_addr(start) & PAGE_MASK;
-	len = nr_pages << PAGE_SHIFT;
-	if (check_add_overflow(start, len, &end))
+	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
+	    check_add_overflow(start, len, &end))
 		return -EOVERFLOW;
 	if (end > TASK_SIZE_MAX)
 		return -EFAULT;

-- 
2.43.0

