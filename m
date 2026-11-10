Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343095;
	b=M0K1RBc1r87v1GJkjV2Zxq+hiVd9vtamJquCdYtHys21s1kjeSUBGLsR6rSl7TtJYzFr
	 /upi1LW1PKjUeC4GiylFQDAt/e8k7ZyZGfWPrYT317/s/IzEOzmeQsntwIHjZsu7XTWTg
	 +V4divVco9bYzsQVwC9f2sG551iqVe8wrHyDvsmYagrRIF4nu58/igSI9Jx+GwrjSxq9s
	 OR9TEwSElC/4aPnJ+QMWObgzp8wQ/LUgkrCoirqD/m7R4QukiGnJ6E+lv9+oeB48TPu1w
	 yTqb2JQ4Ju0Lxk81aLAMrBFlX++OlK5w1GjM+A/seWqRqOdYUQ7efxulSkfMJ3FIv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343095;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TQhZr4bKzH1yYf83YlQikJs/ouU09iimk/Cgl1T4SEk=;
	b=e0cxcX2pph0UWRtE3fvnkB4Ic/KMN4krSRhNEure3o9uwoSGeeKFX2pEKyQ8OyGJ5HaP
	 0ngyYXPioQYtJBzTUxmfThbvQUEUAvH5O/J6HM3LPssfkgfnf4I6cQoKmIKTFZbNUD4yb
	 WYA80SC/Z6d6uYURtTgjki3ESMrroNZOpy45gQ+l8Ex82CeybMS8U1WaBzU8cnRLrMIOy
	 xbCmTsUwq/DUoFL6Lcm6xmdH+e30BPz4tqwOh/zGEywYQO8yqUK06/CbJs4t99cCuh2+1
	 iO7EQ4gkicIh1OLgFo1hPtp1tB83p6Du2uqlS4ttKWJ2Hl+/a/MMyz9Xzum2mUCjcww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHPcEkzb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F4606A327;
	Tue, 10 Nov 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHPcEkzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153321F008A1;
	Tue, 10 Nov 2026 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343095;
	bh=TQhZr4bKzH1yYf83YlQikJs/ouU09iimk/Cgl1T4SEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DHPcEkzbho85PvDiXuH1Qd5lFyC5q8gv5xBGffOubCgfOWWV7lqek7lvYfLRpSA0t
	 IQhTVJa4D+18lGt7AH2soR542b0oAlCR8P7LrIYpK31KzO7WrEG5dh9vxvNnyOQM/S
	 Zzp0LW4h/4rd/y6B/YdEiEzjYrWRL++7W+rtuk1+Hj57yFgXvgIdV4CQiW+ldPSf67
	 6GKEdhSSGHlGPBXfai6+VBlvQkQwf+pS+xWNq8luXH6gsQU2QOgxTB3fEnlfzzRiiM
	 NiKA0VJ1SYCOE+9P07p5d1RFLT20ramI6Mni0mRodbWhV4r9rKIOncSV1qxGF1Jmt+
	 y25nKd0tEPckw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:45 +0100
Subject: [PATCH v3 5/9] mm/gup: limit pagecache folio refcount when
 grabbing references
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
Message-Id: <20261110-refcount_overflow_stable-v3-5-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131; i=david@kernel.org;
 h=from:subject:message-id; bh=U2nJUUKzo83lirIS+DNqGFEsPfDiTB+27qyVWt6EY4E=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63BC+Xi7jxvm37RO/J0ZcYPGTjOO+dHWBuLZc/bcgh
 UsBpnZzO0pZGMQ4GGTFFFmurctJDV7T6lgWZegGM4eVCWQIAxenAEzkbDkjw5fAS44nfZnacuf5
 MJ/NztLk33np7QlN1nMf71/7dsjK7CIjwzXxOSLLW+9qfzk1I/lYa8CL/dqKjX0dMxnj5fuu9x6
 5zQUA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's add a folio_ref_count_over_limit() check in fast and slow GUP
before acquiring additional references or pins.

Keep it simple and use the check for all folio types.

Also propagate try_grab_folio() errors when grabbing additional
references in __get_user_pages() and in memfd_pin_folios(), so hitting
the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

Keep the existing invalid-refcount warnings.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 11 +++++------
 mm/gup.c           | 24 +++++++++++++++---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a36ff83589c61..9b11af88de2b9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2244,6 +2244,9 @@ bool __folio_ref_count_over_limit(unsigned int ref_count);
  * to pagecache folios (!hugetlb), either before acquiring references or
  * afterwards with rollback if the operation is refused.
  *
+ * Also required when pinning folios without a dedicated pincount that use
+ * GUP_PIN_COUNTING_BIAS.
+ *
  * Checking other folios does no harm.
  *
  * This check is an approximation; we leave some headroom such that concurrent
@@ -2951,12 +2954,8 @@ static inline bool folio_maybe_dma_pinned(struct folio *folio)
 		return atomic_read(&folio->_pincount) > 0;
 
 	/*
-	 * folio_ref_count() is signed. If that refcount overflows, then
-	 * folio_ref_count() returns a negative value, and callers will avoid
-	 * further incrementing the refcount.
-	 *
-	 * Here, for that overflow case, use the sign bit to count a little
-	 * bit higher via unsigned math, and thus still get an accurate result.
+	 * Use unsigned math so even an unexpected negative refcount is
+	 * treated as possibly pinned.
 	 */
 	return ((unsigned int)folio_ref_count(folio)) >=
 		GUP_PIN_COUNTING_BIAS;
diff --git a/mm/gup.c b/mm/gup.c
index ebbfee09b7278..531ef2469228e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -79,6 +79,8 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return NULL;
 	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
@@ -143,6 +145,10 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
 
+	if ((flags & (FOLL_GET | FOLL_PIN)) &&
+	    unlikely(folio_ref_count_over_limit(folio)))
+		return -ENOMEM;
+
 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
 		return -EREMOTEIO;
 
@@ -1482,17 +1488,17 @@ static long __get_user_pages(struct mm_struct *mm,
 				struct folio *folio = page_folio(page);
 
 				/*
-				 * Since we already hold refcount on the
-				 * large folio, this should never fail.
+				 * Grabbing more references can fail once we
+				 * hit folio refcount limits.
 				 */
-				if (try_grab_folio(folio, page_increm - 1,
-						   gup_flags)) {
+				ret = try_grab_folio(folio, page_increm - 1,
+						     gup_flags);
+				if (ret) {
 					/*
-					 * Release the 1st page ref if the
-					 * folio is problematic, fail hard.
+					 * Release the folio reference we
+					 * already took.
 					 */
 					gup_put_folio(folio, 1, gup_flags);
-					ret = -EFAULT;
 					goto out;
 				}
 			}
@@ -3541,10 +3547,10 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 					break;
 				}
 
-				if (try_grab_folio(folio, 1, FOLL_PIN)) {
+				ret = try_grab_folio(folio, 1, FOLL_PIN);
+				if (ret) {
 					folio_unlock(folio);
 					folio_batch_release(&fbatch);
-					ret = -EINVAL;
 					goto err;
 				}
 

-- 
2.56.0

