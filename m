Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057052;
	b=o/ZnHS7ZpfUFlJewDHYOgcdodN/F2mYDI+t6zriHW7ZU8MAX8UeaEEKyqNK4/3mT5i00
	 kyv/6d7RTPaC4dB19Xj2/bGjJl4r+bmKHi/JN4OZgIt0a2OuLxewMWQ3X5MBzmCPIeLQ7
	 c63XzEU968jJfgycRo0zuH7w7sWL79d9WrVI5mDtpt1M+wWuxFnrjV6Fqw/oAfo6kJ3MX
	 764IIlaGQUA9qbcJZoK46+kBrEs7L6o/ygxxPigTR7a9sJUcyqfDgVGGxKw/rarzhO7Le
	 dhhoQFVU+9ckRuzUTC4VfyU9PTRlfWVsx7F4KXdthmfvJhltVvL0xOqBajv5qbRHnYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057052;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3vwVoCZbunPi1dkOYnN4mDEZRm3BRTq8xmS5X7w6cP0=;
	b=UPSywVsYgWaSqqx5k8O6/og2QG62FnQlGs5m0lNdC9K6NIMc2PQSyFWQxjudlGzD7aAN
	 FdDrTYBgabyccArRFAwSEQdnOQc21HI4c0R/wiCVgumCir5o8n/RDv2mwgx+2GEsWiEzE
	 ZjQSubDotbCt3CXik+ZSURtHpYLfS7CNJnB8aD7ElJLzMPaivAljHQftATrFKnw683RUQ
	 Cv7BZYCjsME8L4V8skBtiiaDFAkJTUJqP8bA6VxShUe0Bt2Pz9eAJYtwIbDm9jb1HFKu4
	 2mzFK7NAvgKwNaIkHuLu4/NqT1aGmCOKiYZSA/FxO8OZta/q/v7ppIC22ekiSYouOvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4AILRgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93642606A31A;
	Mon, 26 Oct 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4AILRgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A2E1F01825;
	Mon, 26 Oct 2026 23:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057052;
	bh=3vwVoCZbunPi1dkOYnN4mDEZRm3BRTq8xmS5X7w6cP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P4AILRgQaj254wrERwTFGmRjBWG7uy2v20jCOaBuor4u27mNsgkUFKWatsJDumVTU
	 aiE9TuGAExA2XiuLQZMk5Ccy5Pf0k1lsY1w/uoerD9vH/vSMcihFDTWSu3961I7Daq
	 NR2tu4oCL8YilsZnU3zTrqIIEEGTzFiY6Z3Eg8ewjSRaTMhs8B0d6tJlITa3zX8kCy
	 ErZ7R7QlOE9HaG07lCEecT8R/qxSlqYFRyzI0xlVdI4++v3ZS3QyTHi0gU5Bery53s
	 DUuMVz4LtDXtp1QBbCnCPlhIxw0rZXkaevhunTrcBTmBYnvUtBD4UigNKtQsncyiCL
	 rrpCbfmit2BPQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:40 +0100
Subject: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
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
Message-Id: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=david@kernel.org;
 h=from:subject:message-id; bh=xxpfXnHcN1JnhyZw3Nbb6nL1MoIOUrIKvtj9v3lNKrU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu358aIb7XPPhYx3ble/wvHDqWTc98vLTZ2qqbLfOP8
 7GlgcvSOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIWjYjw43Ai9auDCevuN2P
 7y3rOM18ZoZ1ww+/Qw8UeS6u0tMr/svwk7Hb5nyg5+enjJl3jFhO15RbZKjfnf81a/G+uPgDGds
 vsAEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

memfd_pin_folios() pins folios obtained directly from the page cache
without checking whether they are uptodate. However, shmem fallocate()
can leave newly allocated folios uncleared and not uptodate. Callers
such as udmabuf can then expose uninitialized memory to userspace.

Clear non-uptodate folios and mark them uptodate under the folio lock
before returning them to the caller.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description and comment ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index efc9aa2654625..47e7ae152cdf1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3516,6 +3516,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 					goto err;
 				}
 
+				/*
+				 * fallocate() can leave folios in the
+				 * page cache that were never cleared.
+				 */
+				if (!folio_test_uptodate(folio)) {
+					folio_lock(folio);
+					if (!folio_test_uptodate(folio)) {
+						folio_zero_range(folio, 0, folio_size(folio));
+						flush_dcache_folio(folio);
+						folio_mark_uptodate(folio);
+					}
+					folio_unlock(folio);
+				}
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 

-- 
2.43.0

