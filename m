Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524092;
	b=5D+nqtVNuydi99H6sXGwoFT2ttlKY4nmVZX26ZDvNBk8DCwWK5nAKhQUjXAffmQS7B0h
	 fF4AvLMPiEpREoQU3l3gFODGCE2nLWiXu2v5bOEAlFgz6UpzRJJG/Q7WMrrV09O0SP2so
	 k05f7vYluYv/ufnLbKiD19n3cDU7Pu2Hmn/vmSMhTxFWH/h4utMajO8JU3buAEaJTyGz1
	 mUq3KhJXc2KWSoXrcjenIYDP+cullcHH1EOuNUwjgfgE62U6/LAq4jnusLn5nluLzM6+v
	 yJ84X/YqnxhRSLOK1MIXQpPfYOXt6bECnWUm1A0RdbUh5AXOSRTnHl7ZJL+QDxdiPLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524092;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pHhzsFK46xamHLjxn99YRGd8ys0XhYnUbLCGMyb//rs=;
	b=EXSkBBwI+Avw9jmSPjgxjhho+oiZtVWjtCKSgBKiiLGDT8d4zm+nKXaMz9cwbT8dzrs+
	 UtGrB1KI7cGdFpYy+4wbbwaUT47Xmlit4skEZ6C17hmF2vxwhCDKSaamCSIo2qi+sh8Hc
	 RqcFeQvupvkPzDHoFs98u/6gIl2MoR/VVbYTZk8X7naFuZCzAZkdvjAZiNc77LumnoTSF
	 feoev4WXoXb6AnH8BoK0BrtFFxZUf7InBpi7ZGTnekEd1BWlOj8Zabn5wTmKrUcmVPj/p
	 CtIM6H1OgoY3DMs0gwVmOAPi3eNpDNEhYBEFLACywBXwl11Dmmfs3XgCNJ75Y3hd+Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTY84qd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F79606A31C;
	Thu, 12 Nov 2026 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTY84qd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A654C1F000C4;
	Thu, 12 Nov 2026 22:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524091;
	bh=pHhzsFK46xamHLjxn99YRGd8ys0XhYnUbLCGMyb//rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gTY84qd7Kx3xPJVSlv0Vh6c6y421QqsRHJjtrv1m/Yy9rYUB7lVIMR2Q9+p3I4D8d
	 Cd6DXTn1l1oR+10Zi+NGZMXZyh0Hi7gJx2OHUn0ZtgzoNNVgn/ezSAZWxcRyV3TqwE
	 mtkGq7QEDVZ7DX04ybJibX7CyFzaqSRaKCKlwJzt7eGK4KTJ0VdZO0PZHWFRLHoFdL
	 +eLyisbrDfaeVdxr+nB0qU/LfMLVaIRQhwQtLh2xk9inPb4kR52Jc8i7yiJuhg9b9P
	 3xd8tMMPpSSiRP14qBEzFPjLpzLx2a7v0ZH3yV1K8bJ/3J3Vo1BsdqZsRNF0NkHbLu
	 ckaA6vBpBW1kg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:23 +0100
Subject: [PATCH v4 4/9] iommufd: fix cleanup when adding memfd folio pins
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
Message-Id: <20261112-refcount_overflow_stable-v4-4-ad3deef0bd23@kernel.org>
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
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3608; i=david@kernel.org;
 h=from:subject:message-id; bh=fau3pBzKpQXLjgKtqqi0yzExsXgD+rlECuO7Pn/e1yI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWfJhtdL7uhLDRC0Ci/bcInJYkF8q6oQt8/+GWc51
 JawqDN0lLIwiHEwyIopsgQF3zd4+XJdbbUbHzPMHFYmkCEMXJwCMJGt3xn+O8cetij4uVtU8oRf
 qCGz1BS7tZeaBNq/sjmlcTIZ/HKKY/hn2e/SwJmro3uEceW+PhXP5TmTz6kE/f4YvvhRyLEHv0W
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

