Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439661;
	b=o7tmq4Ydsk3VrsvRlQHUVEYg0VUKJR6iqCbefVMCVco5gCR+NPoG+f7k2NBWrAAAv1ff
	 0icogRMKwuaC8h06fPXCqioCWjokA5g7378t+dkuJpGhdL8j49Mt7ZtZZhTy8Ov0dFQlT
	 EzsMwmZjO6dBuivAjBTepzJTXLS7S5JusnsRLyyiyBo2fbnfe/9FaFnDnMWEpN0rfyve+
	 KDvGjmi+vb/udZ+Ab77HQclutMYN8Z01xpRR4Z04FSBaNq4S0NpjAjn3ccL4tRecu+p9+
	 s87L3x3+cZS8AjkR2VQV9tlmL5Md8ol9IGllNEEIfgLmC1p+RRnQjwbzo8z9KVfm2Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439661;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N/UbZ2DKEnQojQSELBFGnS0lcpZB7Ro6yxedX89z52s=;
	b=jxEJMWxiU5Sij7p/qRQNsgNjwOSY9skKTNKooVSBG8ZKO29S2A3JhqTCwj5sGgCgtwMo
	 v2wXMl9n4e/9ET8AW9HslfVXmdJnaaYGFpoeITlcNM+YRcybhK3SYB5kfpi/qKuSTIF+I
	 IS9kACV+eAFLzQ1HQOjeGvyxSL7Jwm0Y3agcQUFK20w365pxbCIBGa0QdTq64wUKY8AYM
	 LG/2kCm3GwZD608++HL8P5SssVbdbZA+qO8wXIdyFfvAxxEOYTXNPOJUtKH+0KdvgIrkw
	 qCBk6NUepNp0tbV6WFP6CHoVdRu1OUTwLkmdPgX4qKl5yWoDvm5aizrWwJzGLaXaeNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjuuvzf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F6606A31A;
	Sat, 31 Oct 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjuuvzf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB61F000C1;
	Sat, 31 Oct 2026 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439660;
	bh=N/UbZ2DKEnQojQSELBFGnS0lcpZB7Ro6yxedX89z52s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xjuuvzf9wuLMCySY6IdeNSdaTJ2k4cmFetgxtxYQ56YkxXU/QKPSft7eTxxxhEvPx
	 h3bLiQgIiAgEDU6jd7zQkjZZR59AktCDf9D3EsyMCAU2pPH7YBmiH8F90lBDCLylGw
	 4qOV9TbiNgXVH4TQ/L5eN0UL5u42Rnr/3BeMbJxAnndyh1Mvaiszu5ZZvtfQ/UsITg
	 8fMpWAb0srINu2AcXKp7C9J5bxYK32NhnbiumWhDoqenMmVWz3qtrUKG11MrymKh+r
	 cCY1IRWjCta06tdjbBBvjHeXTuhxRU1FKB5a0eg3KogPsKSrj0wxtO5XG0pTSkK+AN
	 2dPToiEUSGgTA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:32 +0100
Subject: [PATCH v3 03/47] mm/shmem: make shmem_file() check the file's
 inode
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
Message-Id: <20261031-fixes_core-v3-3-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=david@kernel.org;
 h=from:subject:message-id; bh=i8RbN8wIEh2nBD7/h47LWSYFQA3zQXy0uIRiZqeF/JI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk9dfvr237cbdI8eOSy4jP9gU/dDjZ0JD3/NcpZu8
 6qMC5hv31HKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE4ssYGV4dP91s57bvP/Me
 RQXP4vMz+03T4kuPGXx4/H3+xMQouw8MfzgMu+PduC+dyy8+21m6acc5s/6YU8d3nbGZFv/Pp9J
 EngMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

shmem_file() only checks if file->f_mapping is a shmem mapping. This
mapping can belong to another file, however, as with a Coda file backed
by a tmpfs container after mmap().

So it does not guarantee that the file inode is an actual shmem inode.

Seal handling and memfd preservation use this check before accessing
shmem inode state, so they can access an inode of the wrong type.

Let's make shmem_file() check the inode's file operations instead, to
identify shmem inodes reliably. This will identify regular shmem inodes,
including memfds and ordinary tmpfs files, independently of wrapper file
operations.

Use shmem_mapping() in collapse_file() instead to not change the behavior
of collapse_file(): it operates on the page cache and uses mapping->host
for shmem inode operations. Focusing on the file does not seem relevant.

Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a7c7a96a7cbf9..f89b4b1511332 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
+bool shmem_file(struct file *file);
 bool shmem_mapping(const struct address_space *mapping);
 #else
+static inline bool shmem_file(struct file *file)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
@@ -193,15 +199,6 @@ static inline struct page *shmem_read_mapping_page(
 					mapping_gfp_mask(mapping));
 }
 
-static inline bool shmem_file(struct file *file)
-{
-	if (!IS_ENABLED(CONFIG_SHMEM))
-		return false;
-	if (!file || !file->f_mapping)
-		return false;
-	return shmem_mapping(file->f_mapping);
-}
-
 /* Must be called with inode lock taken exclusive. */
 static inline void shmem_freeze(struct inode *inode, bool freeze)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b71d010b2aff..3a6f4b7b28453 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2230,6 +2230,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		struct file *file, pgoff_t start, struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
 	unsigned long new_pfn = -1;
@@ -2238,7 +2239,6 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	enum scan_result result = SCAN_SUCCEED;
 	int nr_none = 0;
-	bool is_shmem = shmem_file(file);
 
 	/*
 	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
diff --git a/mm/shmem.c b/mm/shmem.c
index af21a89abb0f6..421ba066995c5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool shmem_file(struct file *file)
+{
+	return file && file_inode(file)->i_fop == &shmem_file_operations;
+}
+
 bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;

-- 
2.43.0

