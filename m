Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057122;
	b=QvlIW7HwrvYrh+2h++BiHNqNjvCTzg+f2IJAdUmkbQrUmYHphRF09YCRE4wttyVm037r
	 XAYiTp8gHW7A0RIBZSxVrB2oA7O98PmIBinU9LLT+aIbAlkTm3xBW6I4Lakj0yCBtYVW+
	 dIt9/P4cRqhgf2+rdaQTtuhDrVJPTB9sB0U+jGcz7NE5xKZsSsPzmZzd0dsEJfH/HmHzg
	 0XUGFzfHTs8eWvwqdlU53bOvcyxL59apxRlYcVsx9+gQzcrcMES6RaLGoYrJzjDxarg48
	 FSDvVMgkxgF88fFH00WAQZBB0+bJHyIez6FmQGMfMl1/j/856edVAj4RYAmrNp3ZlwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057122;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wk8fHmHyhf8+gOZCyOM9u2jGkcwPVKHrhCqeaA1oNlE=;
	b=hqqxLnRxb4wJGx32VlvtYKDL9nyBuHHQS058WwqvO/Nb/aAcUOBjTpv54SwINdwMLgvS
	 h5e7PsAAoM1hrqYQR7B2czsd1gg6M98tKSI6i3UrNuwRWT0lfW0o1XKpjmwbXdKicrC3B
	 DfW3cMdDixKnOqV/oNDSJKbkPp011VPUHLWTgUk+CodU6h75kZgMljV5RmO9hDARdsqcR
	 8F6E6EYuazFCRoQb7RcmDo5NwW4MzwLGQI/6NxJXc13LRfaAiyfqi924sjbOETDMDXRWg
	 sDq/HNnRVvlmPZZY8CkXt0Kjo5dJhOaTjplod17EoJUSdl0v+X/nUtsvwoxaz7rE7/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBlG95Jj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB1606A31A;
	Mon, 26 Oct 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBlG95Jj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9A1F01829;
	Mon, 26 Oct 2026 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057122;
	bh=wk8fHmHyhf8+gOZCyOM9u2jGkcwPVKHrhCqeaA1oNlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nBlG95JjLTKQS1vsnDjG3NAtGsrJsDj/kWHYnsNPwR/Kc0irpHvaXwIB38KpMmMaH
	 aJUO172YL7skHXpfcdKZZL3xndwdNhmEt2wuFrTZJ/6vzkZFBNrVgwh5j6lHQPqNr8
	 FA2RwtRCOwbPj6WLRe7QN8lDe412PsOUyKPQhJRU8dHjTUhNKSKli/BFSl1+hMJhFc
	 B6E8BVR8WCWG26bqcALXH43Cp89W2ZE2U7vJW/EApfYOtJIoOvx1au8dpIsJblyBbu
	 CQ/IA1Jopa5qol5YYDuCEkY2gLlCoYtmIuFrL7HJ2t1GVIN5bStSPzqSJg/dcuOsUC
	 HfPG3U6ect9TA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:44 +0100
Subject: [PATCH 24/46] mm/userfaultfd: wake all waiters on unregister
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
Message-Id: <20261027-fixes_core-v1-24-6f74bec9a5bb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267; i=david@kernel.org;
 h=from:subject:message-id; bh=VWyRnUh5UUmddqRoYe/RjEaFtJoCER021E7Zl4sKkh8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/m5/Zf4afPirVSuw4bnlaL3XBgkWdEX+7eJ/nbD
 qi3+js3dJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRDEWG/zUzPd5+511kL8MS
 WSulJCHq8trETpxv7aHmc0vVdIP2ZDAy3BXRPcHVdu+soPf6/ivasxpqVdJX5kcavou8kHhieqA
 YKwA=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7e30b5ff17be1..2122676c4220f 100644
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

