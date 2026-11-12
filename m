Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524108;
	b=n8SRkBAwKcsoJNwKPQNvjYgM56HtSRFg8agRgYeMF+L/9/y+x94ZIY+cm32KUBCS3UNK
	 jRM9icZ+BmnF4bVMwC5UmxX84Zn1KuEaGimQzRDd439RzpRl36uHbKQw6E+h9RQyxgPg3
	 SB2byvg9d7PRek6xAQFoNLX4E3vVwsyLUueOPjpmT7NCBMQkl7QXUxIHxbRWXf1T7XEt/
	 mj3aSjYlzviWJDgy7SLqycNJJStl98i7BuMy8qRlMs295zdXkmXBtV2TEB8EekYCwHkjD
	 dt09VWzrQXVDa38VyFZIBbXRXUTQ2472uRBrt3wO4Nbj8Voi3jGTs3wwnhczSkJqDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524108;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xD5fh73q/8pagNiTYKZXU3AwQ2//zL6YtRJEHaiPpLQ=;
	b=GJThq3z2mMOv2AMyNX61O1Rt3NQn21LhWCFwIbTwBeneAr6X3tYA9CEd/sWyhe+HWs8g
	 QqCCzuRth0+G6FoePv3YRQTti9rIq0MjOv9oWi4SPXAWoX5y/sKwlU1cSJtl+QxTnQPGj
	 Lw0H1BQjtRCtzTQUfW+HmjvqasbRxr+V5cS9to1YEr/VsZIW3m8+Q3VlG5Jf/zEgRAN9u
	 qbFhRks4bbUR0sr3awnfugDN3syygJdDMxunpb1nuEq+7lWKyXuxAqaVa8R7aydCPUvn9
	 qoJ/c3URbO1Ybdv5bG296yhAyjNPol1Qd5CKXHwp9VA8Kc5me4eAgcDxSWrgR1+4zSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTeTfbGe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506B606A31C;
	Thu, 12 Nov 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTeTfbGe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7641F000C4;
	Thu, 12 Nov 2026 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524107;
	bh=xD5fh73q/8pagNiTYKZXU3AwQ2//zL6YtRJEHaiPpLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QTeTfbGessK3tLqLfk7/znA/6mfnv+uFezUe9IOZA5Y1l7h7Oo1TfY8ZdN2V3k9Kj
	 1uH0fHiEDnYNZS3QfepNFBRNe/EZtIRS7UPXtVBhP44WAKJNI+2cPRoO2GUXkz7mns
	 C7ZQPAp1zqi98vSWE5I2aNWqf2jTsRwaPSF3rRk/z8e7e7Z7glMoWIEkyK6hC4E+Q+
	 AwkyTgZFTjzLSXEF8jBBxkmTxzzLfXQjh+6JvVz/yokNdr+mmWr9hRvvSkO1zaoej4
	 /DQHD54k41YzHXDi7Ns7oaPdD0KIkYYtObsnxIxQ6/yZ09TpfcPTPS6jegKf/G28Yg
	 eRP5Dbx1fktTw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:24 +0100
Subject: [PATCH v4 5/9] mm/gup: limit pagecache folio refcount when
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
Message-Id: <20261112-refcount_overflow_stable-v4-5-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
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
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; i=david@kernel.org;
 h=from:subject:message-id; bh=oyZjzhRpZpzTLHbZfyFwqqIr96d+/BTQmUry5D3V7Tk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWe1ad82rOEOc3geX6LAmhz4VF7baNeb+BCD9UGPX
 jBkLIzqKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCJBExgZ9j10fOmaED9x/Y3W
 xz+Pebg/+LTFUDGn6V16UuNv5sYrRxkZbgp+/bVy3f04nwks3Ke7w7meFHt+q9mRyaWQm/TKYcs
 NTgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's add __folio_ref_count_over_limit() checks in fast and slow GUP
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
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 11 +++++------
 mm/gup.c           | 32 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d00fc1838a01..cc6f1e69223aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2246,6 +2246,9 @@ bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
  * to pagecache folios (!hugetlb), either before acquiring references or
  * afterwards with rollback if the operation is refused.
  *
+ * Also required when pinning folios without a dedicated pincount that use
+ * GUP_PIN_COUNTING_BIAS.
+ *
  * Checking other folios does no harm.
  *
  * This check is an approximation; we leave some headroom such that concurrent
@@ -2967,12 +2970,8 @@ static inline bool folio_maybe_dma_pinned(struct folio *folio)
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
index ebbfee09b7278..c1b8ec3513913 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -74,10 +74,14 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 static inline struct folio *try_get_folio(struct page *page, int refs)
 {
 	struct folio *folio;
+	int ref_count;
 
 retry:
 	folio = page_folio(page);
-	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
+	ref_count = folio_ref_count(folio);
+	if (WARN_ON_ONCE(ref_count < 0))
+		return NULL;
+	if (unlikely(__folio_ref_count_over_limit(folio, ref_count)))
 		return NULL;
 	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
@@ -140,7 +144,13 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 int __must_check try_grab_folio(struct folio *folio, int refs,
 				unsigned int flags)
 {
-	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
+	const int ref_count = folio_ref_count(folio);
+
+	if (WARN_ON_ONCE(ref_count <= 0))
+		return -ENOMEM;
+
+	if ((flags & (FOLL_GET | FOLL_PIN)) &&
+	    unlikely(__folio_ref_count_over_limit(folio, ref_count)))
 		return -ENOMEM;
 
 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
@@ -1482,17 +1492,17 @@ static long __get_user_pages(struct mm_struct *mm,
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
@@ -3541,10 +3551,10 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
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

