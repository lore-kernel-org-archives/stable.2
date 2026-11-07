Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090314;
	b=cWagqAc4A2qhsCbG4oC+xwTIHMiD+1PbQbvRWB8jmfXmeJPA3mdy7tx2FRGgxQUyMuL3
	 3kOFyD9kzx0IIgAKy+ad9PB22CXn5BhXdmZOUY5wzunLa16gOs09rJra4Oe1cj5erDWZS
	 tSx13HdaJc3faDP0pU3zIArOYPZecKyOK0wDPfdRlQ3arVQC7L4JAzMXiswI7B1Ao7ue6
	 3GNFk+qJbc9mMNj0DkpfK5gc7NvB86QK3zFTfoG/ZKlyhcerJTMX1IH6q6XzgASnmHdQI
	 lmgdovyOUUb7A0KYy/6bhvN4sVzlZhRJ18C9v67uvB85PLfUFn96wS7zQyEQoHmsq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090314;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OWyVCq4+WgbaMf16pDGURTSB8zAUbf5GDLFCZh0FtAI=;
	b=GIaXWAF6QEskH0c/aM7JEHWGaSztEwkXEtflYi1QqulLhCoU+Rz9lSodxzwV7D0tJzBy
	 JsiKtUrHZlxKUIjSl44+WQK4LDTc/ZvK16NbI2ySMkLgmdMCX4bCb0Cto1/L9D6BDfBdt
	 7vca819oHnrS3U0YEsnrDhZFZ/8RBUY+EHck8JtSYhRydPCgzcEBVS5oUzqY9blQYO3Mt
	 Mfib/pENgNjpTOydGReHDjCWwvYxNtBAi6mGuWq968gdDAnGKE56yHz8y0QQO5nKZ76dw
	 dWG8MjChW2nrZKMeJ4nqdmSa0YXznBFo7fAeppygoF1j/sBGgQ6MN0HT3vwp8nioENg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/jSEPMA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01908606A326;
	Sat,  7 Nov 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/jSEPMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E38C1F008A5;
	Sat,  7 Nov 2026 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090313;
	bh=OWyVCq4+WgbaMf16pDGURTSB8zAUbf5GDLFCZh0FtAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j/jSEPMA663ptEOJg2fMwfdPC20unbDRzEFPmCCOUX6RbI2fLyEt0loXnWk0G2nlh
	 58eif8uVbcsSnHYspoPlCCQ+VHc40nxVEuIp0hxepYy70IRhiBheFNaVRFt7c/dX3x
	 0jQ6d2kz3UrrYwgDdeqp8yaRG7TTL1SHO9qAXCgqoAtkRhQ0eK0LyOahuBV9CFZ94q
	 Jn0bpw7KzhGBo03Mg3LWjF0U/aqFY7uYIFN7fdC2H/OjwuZWkcn39egWKwTzGKTtwa
	 nyg83xPy8Qwek10es1ropcbxwt91AIVlbFO+lvcNgYVxYXZ1V6GwqEXqe4ps0ML/eR
	 ZwGiY3zNu3XBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 07 Nov 2026 23:23:41 +0100
Subject: [PATCH v2 5/5] mm/gup: limit pagecache folio refcount when
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
Message-Id: <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
In-Reply-To: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4862; i=david@kernel.org;
 h=from:subject:message-id; bh=uo5BeEwtVcyMk0MrrIUhmjG1HPh/LU5gGAlW8CtFyoo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeL2Uya5+/+O3KF0odGVferdL2LS6d//zBve+fJ984L
 Fws8mF6XEcpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATuXiVkWFD3DubS4FVUrZZ
 ulf+/rp5sPH8PgdtPr2T37WXRFQF1WkzMrx67fAvI/PRHMP2oLQVvJdcuEsWL5y4zybjhbznVev
 KAg4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's add a folio_ref_count_over_limit() check in fast and slow GUP
before acquiring additional references or pins.

Keep it simple and use the check for all folio types.

Don't check capabilities with IRQs disabled, as even unaudited capability
checks can take locks. Refuse access to the admin reserve, so GUP-fast will
fail and fall back to GUP-slow if possible.

Also propagate try_grab_folio() errors when grabbing additional
references in __get_user_pages() and in memfd_pin_folios(), so hitting
the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

Keep the existing invalid-refcount warnings.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 11 +++++------
 mm/gup.c           | 24 +++++++++++++++---------
 mm/util.c          |  3 +++
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 244bf5d441a64..f62820cc9159c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2246,6 +2246,9 @@ bool __folio_ref_count_over_limit(unsigned int ref_count);
  * Check before adding page table mappings or other significant refcount users
  * to large pagecache folios (!hugetlb), to avoid overflows.
  *
+ * Also required when pinning folios without a dedicated pincount that use
+ * GUP_PIN_COUNTING_BIAS.
+ *
  * Checking other folios does no harm.
  *
  * This check is an approximation; we leave some headroom such that concurrent
@@ -2938,12 +2941,8 @@ static inline bool folio_maybe_dma_pinned(struct folio *folio)
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
index 2ab42fc6834e5..522049f2b8663 100644
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
@@ -3538,10 +3544,10 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
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
 
diff --git a/mm/util.c b/mm/util.c
index a906dfa755ff1..f2c6b222e3ef7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -798,6 +798,9 @@ bool __folio_ref_count_over_limit(unsigned int ref_count)
 	/* Background threads must not consume admin reserves. */
 	if (current->flags & PF_KTHREAD)
 		return true;
+	/* Capability checks are not safe with IRQs disabled. */
+	if (irqs_disabled())
+		return true;
 	/* Use the task's credentials, which filesystem overrides cannot change. */
 	return !has_capability_noaudit(current, CAP_SYS_RESOURCE);
 }

-- 
2.56.0

