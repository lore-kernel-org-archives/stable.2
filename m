Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090302;
	b=naB47dv/lrc3uBNckeWk3VFzBghlQeEn5dCgWyL/B9h1Cxy7B3p1WKRHPXb+pwwA8vsf
	 xjKIDWbdRVsnXUNAYMp/wuvTAyr9KWMHmGM/A+Y+6TvCl0UA202CUOZ5q6+pocf/MRsjf
	 9oDZTvcdAyR52pRUgHyCNX+AceOtQiR7Xgv8Z1BId31QZ2dtXzF86wevlhD8PTrHtC2/v
	 asFsivor+T2lNizgiSJZrRDSIwjPXQl+XE2Sf4OFa7y2kHzEYypAbMKZ80R7vS+oZol6P
	 07QWbnmhQIN2WIXC29tDS4bcAlY8pYSEFcYsiJ+0dVIe4sx4McyiWL1MPVMl9w2+9Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090302;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pHhzsFK46xamHLjxn99YRGd8ys0XhYnUbLCGMyb//rs=;
	b=DG8oRhfIWbgsbq+OdHU4Yz0/pdX6RmBzMqGp7V8doOh/yXyucHLDuFDQwkLMr3Fwi7v/
	 LIlCt2ZF/1M0zQ+1ju2DVVg6onZJ+rZj8TyPCB2Jte64N1dr/iIZF3yTxXcISDMYQupW8
	 nME/XG7LA/9Bliyto3uSF/AfQE/mImPu5x7KIrHReIfdYvT6FMYM1oikRbiwDGlzwWFDJ
	 z+leVNKYLHZ7+VLYQJWVDI9kSNR36wZHuWu9dqNMjBO2Jpd4LIXbcZQCpwZxXIPX3bclj
	 XXmXft6MR1uppY1UAnttRoQFY40H1h0UW55teEEu6pPePuyTmh4r6UFysViQ4Ztbd9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ju6Cfz96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB12606A32C;
	Sat,  7 Nov 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ju6Cfz96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB901F008A1;
	Sat,  7 Nov 2026 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090302;
	bh=pHhzsFK46xamHLjxn99YRGd8ys0XhYnUbLCGMyb//rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ju6Cfz960666XG0yk6b/gqWUfTYFPewkV84zF0+CiI6bHhEhgdSqF+x9V55sa4yrD
	 P8vI64/cOlDJ8RkSsq6dPjKek/Ywv7qDM0to8D8N2TlPLfYAiaeqRU3ygvS8fFNzW0
	 qcTQOlqQLVfLWhOxezpaaFBCmaLbjjCpvynfNXTz0gnEJUSOEgjRmkMt9fkFM6F3tl
	 VVSx46jVnCDPGXao4tWJh/skNSlPw2a4bikZ2UpqJJNMOTXeCQm1pQqdwuGsnJ9i3g
	 26F2C/HSmE4JxmGcGSJXwM4K6RcTQ+dJwP+iIOXHVEOiN2wgDA/sINnzqBI+g4eSXl
	 jVciwuVDKOX5A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 07 Nov 2026 23:23:40 +0100
Subject: [PATCH v2 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
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
Message-Id: <20261107-refcount_overflow_stable-v2-4-c38f6809b106@kernel.org>
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
 iommu@lists.linux.dev, stable@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3608; i=david@kernel.org;
 h=from:subject:message-id; bh=fau3pBzKpQXLjgKtqqi0yzExsXgD+rlECuO7Pn/e1yI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeL2W0bHadVfTlfHZP64PqGzeK3Teah+fH6VZ+cpw0a
 8b3bK2FHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykZDkjw1KTmIgAwY894ov6
 fFjzPUWdLKuu84grbV43U35iHm+dN8Mf7jCua4Zxe5lMu1PvLr2yifeOxIUA3UXyWnqt+rHOG/O
 5AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
folio. Upcoming folio refcount limit checks will make this easier to
trigger.

Let's fix three problems in the error handling:

1. pfn_reader_release_pins() uses the allocated array size instead of the
   number of folios returned by memfd_pin_folios(). With large folios,
   cleanup can unpin uninitialized entries. Remember the number of returned
   folios and use that during cleanup.

2. pin_memfd_pages() returns on failure without releasing the pins acquired
   by the current call. Release the per-page pins for folios already
   expanded into the page array, and the single pins for the remaining
   folios.

3. pfn_reader_next() returns on failure before updating batch_end_index,
   even if the batch already contains successfully expanded folios. Update
   it before propagating the error so cleanup releases those pins as well.

Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
Cc: stable@vger.kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/iommu/iommufd/pages.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2f6153108add7..fcdbde007a9ab 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -781,6 +781,7 @@ struct pfn_reader_user {
 	struct file *file;
 	struct folio **ufolios;
 	size_t ufolios_len;
+	unsigned long ufolios_count;
 	unsigned long ufolios_offset;
 	struct folio **ufolios_next;
 };
@@ -800,6 +801,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
 	user->ufolios = NULL;
 	user->ufolios_len = 0;
+	user->ufolios_count = 0;
 	user->ufolios_next = NULL;
 	user->ufolios_offset = 0;
 }
@@ -843,6 +845,7 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 
 	offset >>= PAGE_SHIFT;
 	user->ufolios_next = user->ufolios;
+	user->ufolios_count = nfolios;
 	user->ufolios_offset = offset;
 
 	for (i = 0; i < nfolios; i++) {
@@ -859,8 +862,12 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 			} else {
 				int rc = folio_add_pins(folio, npin - 1);
 
-				if (rc)
+				if (rc) {
+					unpin_user_pages(user->upages,
+							 upages - user->upages);
+					unpin_folios(user->ufolios + i, nfolios - i);
 					return rc;
+				}
 
 				while (npin--)
 					*upages++ = folio_page(folio, offset++);
@@ -1251,14 +1258,14 @@ static int pfn_reader_next(struct pfn_reader *pfns)
 			return -EINVAL;
 
 		rc = pfn_reader_fill_span(pfns);
+		pfns->batch_end_index = pfns->batch_start_index +
+					pfns->batch.total_pfns;
 		if (rc)
 			return rc;
 
 		if (WARN_ON(!pfns->batch.total_pfns))
 			return -EINVAL;
 
-		pfns->batch_end_index =
-			pfns->batch_start_index + pfns->batch.total_pfns;
 		if (pfns->batch_end_index == pfns->span.last_used + 1)
 			interval_tree_double_span_iter_next(&pfns->span);
 
@@ -1320,7 +1327,7 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 		if (!user->file) {
 			unpin_user_pages(user->upages + start_index, npages);
 		} else {
-			long n = user->ufolios_len / sizeof(*user->ufolios);
+			const unsigned long n = user->ufolios_count;
 
 			unpin_folios(user->ufolios_next,
 				     user->ufolios + n - user->ufolios_next);

-- 
2.56.0

