Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306335;
	b=cZDkeryoEOPSD0y2IlUK4BJq26RmfZhmM4efGIuiot8S+DYnltJJP3TnEoLFDqngbqQe
	 IXip9+LYZW2cXWy2f34ayKv8id043z66bb7A6Ium4dU1x0/Vlnv5oAIi407UWRz2iZLGD
	 /IK/W8l5gMGvyCcPaTOK7564Gp7/wU4fYYs3Hg8QLjrSZ4PhMyYUsGMijFQY0jQem0zJm
	 gfALeC3UdeVZzSqpS5uHenRJpT6QKm5fKUc/5Vm+KhGvMb23J1tWZhsZmetBRnJnv6Rdj
	 VXwQXEtSVeqiWykrqOW1KVM4es1+3Uz818VikfUhUTPF70+5leHhiexT8Zow9ofDnbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306335;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VnQ13mkoh6ozIDWGTVX+C6HT4vjQEoXrCm0MooEO04s=;
	b=x5G6j4+oajXW1nWzU5i+yrPcLKqA4wyBKiZF2igE3jESJ+V9uVwlVNjkhXPGyrig/Ma2
	 kHkdut2uNg6wnyx1Kr+wcYvG6tqC1/EvsMqx8tXhFdmul6uWorWXiaZD6cSuX07rXgDy5
	 nBpcDeVhc5uvlGFlNo/ysCIp0/tRnBKy40u0I1XeXHZ62/eiFlb1jhaaOodhxbVLr+WBS
	 /yL79FDl1e8w4ASDANcfjj48L+AAj0e/lXEy2d2KteDRmT/p85heK0zGKMdVVBwFJ1s31
	 v04nEAf1j89oleUxU7EvsAerPdpmJIa6hilD2q18CqJVFucauIiQVVbX6y1o8YR8ZYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YezDjZU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0B606A31E;
	Thu, 29 Oct 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YezDjZU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736391F01829;
	Thu, 29 Oct 2026 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306334;
	bh=VnQ13mkoh6ozIDWGTVX+C6HT4vjQEoXrCm0MooEO04s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YezDjZU2yi5cWmUqfDHysvLO9HwSd76jRjz2DKKiJKmvX5TchaYVydd2c1v8z1JoG
	 ukY6PBjO2jSZ2MQea3k0Ss09Ud/uCHu5P7yCWtRSy256Tb4AzyVTKkJiiDAcgduQg7
	 xrppl9xLjFoWu1REw195bMUI8zpRl7qt7xONHzxWgUiB25CSuIO+I9FXJAhMAXvIxe
	 9vFj0edvZ4NkCIz0Xn+Jfn8csY2hF2LHytvnUSwkq/J8TpxTtMH2yoRQoiT7o4M8eY
	 68bluiNVhI3XJ1TLn1f1fRogMry8mga7lzsNOhsJevsO9wM1nRRKTRUXOiJoCR3V2/
	 aAjnkIfXbMGHA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:17 +0100
Subject: [PATCH v2 22/47] mm/gup: check for overflow when converting
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
Message-Id: <20261029-fixes_core-v2-22-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=david@kernel.org;
 h=from:subject:message-id; bh=1C5sa/S2cZ8sLgA0w/Gi6tvhiudETPPmM19hS9JNC5Q=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21vLdw0040r6ZRnZU1d3rZlDw/pO7lrXgmoYp4wY
 /tajl38HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEYTkjw+vlHL3B1hunvHr1
 /9a717nmGp87rIONvDT4+Q4o6P65soKRofVY6M6Jcm9fbfnHGVBQEHrm94n22fOMc+78Cd67bJV
 1FjcA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1c2ac7c66c30..ba4907b35232 100644
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

