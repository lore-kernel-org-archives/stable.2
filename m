Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306511;
	b=mVb+min0obZoYBEC7wfWLjQkPWYs6laogbPcjQuSs/js5NBQYapRPJLHgZBsrXX+4pER
	 kltUh2V/h2NVETODd9BVd2lAQpm6i6eF5dcrrEGRzbqfXnmDikJjHgHd1iCa+gt+kKZR/
	 NChqRGwKvbworIFoJkpLGWOkBveeoWUt1YeJG9k+3hUNStnUqVwbzyT4NWCV7auUxCpF9
	 oOE6Hn92uU7y7lgmNZC5LC8unedx2FXCaNs5KYs6Gamt3PrT65DKEN3nNR/3nA7M4RC1F
	 kvvk2peC0AoR0R3kWEZx3nhIYE2tQn4MGvxYfLFsBfMD7hfcOP5DUd4pYDzslPT763g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306511;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zArSmg7yLUQusiUDBjlm/kScYeO/TmH/P9/Smu4iQZg=;
	b=cL9w26uIS+3HeJaj/y/W+UVozgY3nCq6d8NYmq/mmexm2jAWVqmUM4T3s/QCjPmX9Nyh
	 dntQ9hv/+pyyujAH6iE92hjx0Bdu6AxhHxbvdbNQqDDuk9RHhT5I5wgWg6XNxizAobZj+
	 kOp9w7sZRqlgLgCssbdllnluuWjMrCvFl/P5yRlfT5dAk6TIi/b4erVP0xxpWdxWDb3rc
	 THEMecwxOZcUhUKoYfvh7Im+RRl9fU5Cl4ELqKNxEcodveschoFKKGpBpyx9ZgITt3bZS
	 nYvzC+CPATfZ+06eTYQ7ypBPB0yenNE8hlzqn+X3Vmqvz7wpMFdvvSnsB9CkmIqAmIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGLYR88r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55194606A31C;
	Thu, 29 Oct 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGLYR88r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D979D1F01824;
	Thu, 29 Oct 2026 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306511;
	bh=zArSmg7yLUQusiUDBjlm/kScYeO/TmH/P9/Smu4iQZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RGLYR88roEEbDd5tCeYUTOpvVfraAhTmG++35UVmmW+MOOjtMfDoQbZ3JwNu9EYK7
	 a99vFMdfcGf8o5juAUZnbJ5xZs8mAGQ1+gjvsFf6NHOO3vpEmbqZVt3FCXH1tgKNfy
	 WHJSd4Lz8UjYheY8b6tfHXBpyMyIhevr0bOkLKm7e0YsAY15rmrqUd+JMgpP99OcGM
	 p5rxJpPQrcARGEcSkJF+8J7+1oI/T8LiSMX5XgFh2+E67ydfTgPDCA44s95fCGJaSG
	 Vvv0OX3xJ1ptZi56r/nPn2GsnNt0bERfJYkrF8Yyh5tqVEW86MP0+rqj4DGWD7vADq
	 jNLTFzqpOM9ZQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:29 +0100
Subject: [PATCH v2 34/47] mm/madvise: fix data loss from MADV_FREE on a KSM
 page
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
Message-Id: <20261029-fixes_core-v2-34-a64ce7f83abb@kernel.org>
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
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=david@kernel.org;
 h=from:subject:message-id; bh=K1BVe7ZYRTk2Zt50NT+PN3jE7jOx7NQzRVqTDwh0m6c=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+04M4X18V1Z9xPSyy/e+WsUa9zSlnOmMjtRcs/1g
 NZP74686ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi+dYMf8Ucyw4tm2A0J/OW
 z8VXDYXdXeKvv2wMrxY7eGn1EVedZ0sY/lmd9HP2W/rCXJN5+ou8mx8EBQO2BC78+WrrK7Gc7rI
 f+9kB
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf..a16e3cb256b7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its

-- 
2.43.0

