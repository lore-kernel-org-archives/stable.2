Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306365;
	b=b1xOawpYlqbf7TZ8GAgxE3BZvrbbv2o+xDDULi84NRz/faQg5+Rwt1uMpjKxMjqEZYJq
	 uamZzr98070C87GxF2oh7RkPI0Im9vMDb0P2/j1Pyc9c4BHQbTh9CZ1UTH/ml6FcY1Vc0
	 MWhN/tLyJgzncC++hQLCTwUa2FYBi3yP1+rVSPbV71ZFPqkWK0l0cnT8K1eS8fJRumGAl
	 IAFrugQAw7GWbfO1f2irAah0ADJ27OQihJCbabrfvWxUXy1BAx2Z4Yb7yC5TcoyVhnSlH
	 0LOgR3HYtNI0fG3qEpog6QW094wPaoaqZgeYFybsrLNFIaJZeQYTW/ueqYBYp95IMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306365;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=93rB4MhysMhGYbksem4hKuOQyLx77syArI3hVZIrAK4=;
	b=z0aRBAQgzfLRsQi1/jWUARSGKrJVmTMEpQhYSRufZ81tC0H3jWIBkYfVn07XFfh6WxTt
	 fxtTiYyRbslbcno1TYMoF/5kQlHMPhM9VEd/ze5i/aQpxGwa/354KuFdCoEC1UQDkvtMW
	 yFAmdud/r1+3k82dxaSjoDVhUqG991QHMgteTBmucQ30EPmCir5YYPzAGL291LQ5+UNM5
	 1PvhbnJ4KLKgkhiaYGFTMEMbczzxJWJBgqNF1ldlCmqfbDJxNGsGeu46/TP7RdqlFQ9TM
	 yXSUUJ9uL2S/f/aMCCTrjZ6xNWwiLTZb/HPXFuGwFjczcOChe76w1KeWInQ6TVDzHeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKsdyMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7B606A321;
	Thu, 29 Oct 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKsdyMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BD1F01816;
	Thu, 29 Oct 2026 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306365;
	bh=93rB4MhysMhGYbksem4hKuOQyLx77syArI3hVZIrAK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YlKsdyMXMe5uYCu83iB8MjgJNBo9ihA41CeTCek8Yphz+cIivFiF1PQxyAHfKlko2
	 0QD32dcJV7Ck4q1Js/ZOHyaLk5WAydTF1kdrarTAi71AJ2YwjxMAGMNmEnCtnAQv2X
	 /S+Ch98lQzbrbvWpHx+QzNZiP2EkyoOo6wYgdlvQ6g5ScFZPceMS3op53bXt/B+Enq
	 BED4rLyLLGRwSKp0Qq4/93GOyLtpiPv7fa0DrCe1bq0HxIbRnbojjtmW2X4vwKwoCA
	 6slZ9Mrrp4KHRhq1orGCO3BkyyXd1JC+utuS4SS3T8j4nbPnctubqyoD23R0oW24tJ
	 liZ86yXMtu6FQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:19 +0100
Subject: [PATCH v2 24/47] mm/userfaultfd: wake all waiters on unregister
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
Message-Id: <20261029-fixes_core-v2-24-a64ce7f83abb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=david@kernel.org;
 h=from:subject:message-id; bh=IeP32edqUnfVhMXgZn9k/7GJXHBVF4YDItB/FrA9iCo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21fZssROqlhS+ofnxNzpMU1gq+eX5g3y+T4lOjXX
 xuvrzmU2FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEbh9m+Kd00U3ugNZCHgbl
 956f3Nxt3+u73ZzEdEiM7/CD6oz54b8YGbZURRyZ7WzlLbfCpOulgpFegap5/aGGTfnfm7o63Vr
 msQMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

UFFDIO_UNREGISTER only wakes pending faults if VM_UFFD_MISSING is set.
Threads waiting on write-protect, minor or RWP faults can therefore remain
asleep after unregistering a range that does not track missing faults.

Wake pending faults regardless of the registration mode so they can retry
without an explicit UFFDIO_WAKE or closing the userfaultfd. This matches
the existing behavior for missing faults, including removing unread fault
messages for the woken waiters.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: rebase; simplify description ]
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3ca04b582329..be630674fda9 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3977,6 +3977,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		struct userfaultfd_wake_range range;
+
 		cond_resched();
 
 		/* VMA not registered with userfaultfd. */
@@ -3994,18 +3996,14 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		/* Prevent new userfaults from being queued after the wakeup. */
 		vma_start_write(vma);
 
-		if (userfaultfd_missing(vma)) {
-			/*
-			 * Wake any concurrent pending userfault while
-			 * we unregister, so they will not hang
-			 * permanently and it avoids userland to call
-			 * UFFDIO_WAKE explicitly.
-			 */
-			struct userfaultfd_wake_range range;
-			range.start = start;
-			range.len = vma_end - start;
-			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
-		}
+		/*
+		 * Wake any concurrent pending userfault while we unregister,
+		 * so they will not hang permanently and it avoids userland to
+		 * call UFFDIO_WAKE explicitly.
+		 */
+		range.start = start;
+		range.len = vma_end - start;
+		wake_userfault(ctx, &range);
 
 		vma = userfaultfd_clear_vma(&vmi, prev, vma,
 					    start, vma_end);

-- 
2.43.0

