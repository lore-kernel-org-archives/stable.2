Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057089;
	b=u8O5TwD9DZR74ScitSWiqDicDPVIuqCKBTdypSynw2wic7KhPKLSDjb+JNVkeJOH2X6F
	 KvA1iUJn+AikNlwMsFRhQk4ZGg7gEc50/LeNDZf3ljvkvoeGfUUQoZLEVGWDl2WJYD30R
	 2XAUaW2NrNIJ45nZnMujqXQe7kAO/HWsiwmtsmZdwdlOHNgUDj+bBzTEeBB7TJHIS05xQ
	 JceTHZchCKnwq1BxrxEr6lzHK9q+xR/FZQ77VMmFuBu4VSUFywjAiBdPdsM97zTgZGHn6
	 3sb9lMnqvPpm0pKHSfc0HaZ9s7wHwYdq9aMiPTFe5M7CSkA1yIwKHyDb1KO3vFojMTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057089;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qQBYoODQ+YQypvvJ/bxf+QZV6zHatXlRhHg5nFuEkjY=;
	b=JHY+XIjnrJk2pwRHuuM7PU7H3Nf6VAmsdLDxjZ4VWM5e0siDBoiCSEMMRUJLWIP41Zm8
	 brloxFIpmAfsiqpD7v6y038cbvP4D3ZhSGYjNAMpDiGWi2vSjcu5Adp0vo1l+0/5sI4ae
	 Lp+JPAdUBwzdSQ/+TOPlH00kE1dEybdGOb2aFELDkfYw9aiRpn1roeHQb6iulvILYEhup
	 6BRJqqkfCMAAYS6E2txP6KhboHPDuK+WVZzucQaeDrU1IKh8y6cEdstv8DpkjJwxy7B9q
	 wfsDB28Dqevk7TMFwZbIYFH4C/o6Uk84HTRmQpZ3gy2K6+oAr0w1Ih9QlbeoXfFRUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiQEG5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C275606A31A;
	Mon, 26 Oct 2026 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiQEG5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13A81F01828;
	Mon, 26 Oct 2026 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057089;
	bh=qQBYoODQ+YQypvvJ/bxf+QZV6zHatXlRhHg5nFuEkjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=apiQEG5ikFEGzk70lvNqgcSuFbxsqv3KoY+cdbi/CXgRNvwDaThsY9M5RovpEEfFo
	 JFu4/56U0E++OV3FBySS+H1tdOulH/Xt6CCEu3CGKpMEe0mUXtqJSJP9tRS6x5AJ31
	 m+ndyvHcLpq9OAW6nIACsnOC6HrvGmJMoMlpGQYK/jThBCwuCcSKNUEAxCW5t7xDNB
	 fMVR4TiZ2J0xQ9Jvws7WPcLF4R7Nvdr7TVW1if1FFkP9Mbip4u6YJm2tr3KsE9sF6z
	 xzpiQJB5NBcKKSuheBGTIIOW8lkxwrcHd257sDU9t8MbpXu6q2KjpsZ0YlL42ux0QL
	 GAcroa840G2Qg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:42 +0100
Subject: [PATCH 22/46] mm/gup: check for overflow when converting nr_pages
 to bytes in GUP-fast
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
Message-Id: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
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
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=david@kernel.org;
 h=from:subject:message-id; bh=xmWshrb3+Xou48CaDcjPkXm82MkuoZo6NmHK5/nuQPc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+aeTNfcdI97pS5wQm7FPTWmh1Unr01g9eJPX+Bl
 UAIt9SGjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbCtYDhn2Fw+YTli4MZd/M1
 hdXvvvO+YDZr6cVrBREH3i/9tpjT9AfD/1Q724PTdmWLiq3IYFMDOiS8cHKfUes+/QXfD+c+fba
 OCQA=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9906965893431..48e1bfe5ab9a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3214,8 +3214,8 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
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

