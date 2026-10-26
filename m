Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056730;
	b=gvfO/ePcbJBR0m6RWMCUWZEWkSQ22HRKlkcOqmJQ1F5npNWvFvITCjFX+U0y5gHnwng4
	 pdboxu/m4LdjE/0ypt+cvleabateisRuolby6frh9cwuyipBCigkfxsoFQiETBhxGkcLV
	 RSV69jj+QKJhOXCl+bH9YjU4XxlRdfb4hRqtKPDsac5bT+nPWsIO47F0f3t0jyvQ7t7T4
	 dniDgGxYJPtxae/y2S/rvrlkAZBD69dRRwA+3FnECCwZIQrh1H695N3DkVk+XX7FsUxPv
	 l3oCtLibp3+fNtwuhS3DRCU0fKQYw6aqZTNp78aXZHnavJ7eL2Pziln3fjtbM0i1bdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056730;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1kqvh3QHgES+LSiM08s7U/NmvKIkWtzCHiKPGrHCdA4=;
	b=DcNkynbVhPAa//dRVfb0oT5XbSeFKDpzN3eEUT7m8HU5iJn41cPvoawIu9w9xt8+eOrl
	 9LAtjl5GuZ5IMxiMmCxgclOBR4bDH0zUTQckuXMuuRmf9ff7q9OCq7BccWL0uv8nAufSJ
	 rZAwnfJImdp2DGUNOexb/m6Gb1B0yIO78IxE9bObdB4X0xQA48VM2ke+BhJgPx7RU4x4U
	 OIBI9SYkuQeKSckTP9OQF/10un5dRdqQCkhAmBgSF5Ddk2fl4+F250KHhVox5Huh4eskT
	 jD5nQ4Z+5rL/c+6yWeMcWPJi38cNK2a31Pk9RIYkl6ZjLmUxu+DuqCFW7fBt8rPWf2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9TWTt+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB89606A31A;
	Mon, 26 Oct 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9TWTt+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DE81F01828;
	Mon, 26 Oct 2026 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056730;
	bh=1kqvh3QHgES+LSiM08s7U/NmvKIkWtzCHiKPGrHCdA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l9TWTt+1L+96E8I0lJ9iMCkUJIkaJ1DluUoi903qeANK9k6EbKcVlyv97+o5GezYH
	 DLbgE5f37O/Zzf4gABcw0E91GGpbNhYQ2bcjgsFGFMxtOH8rGEPiXqQ6IdoN/afDgv
	 d0U7ZYskU93ZiARZJDopac13HIKc/OTZeIBLlxhDg/d1nbW7Xgq3rnOjhJjTaZAtXc
	 OJ5JwrO3qLcWFvB2dMJicIRahK1xbEhf2+G+OHRE2yEWbp2B4NWxfcIDJ7cyQyn9lJ
	 RcH072HgQhLHMSDRpqqlOFWLLRiTzdYY4XiqIXCtLe0GTIn+Tr52qXvk6mvuBIkcck
	 fZbu26U8SUFXQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:23 +0100
Subject: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
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
Message-Id: <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
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
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=david@kernel.org;
 h=from:subject:message-id; bh=72FnFCPclMGQ2RVEjfTEZip7yxNcpfMMwjBpW8uk9h8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu3598IHG65lsVvXN7Xh/+NOGzlVBY7sGdTtrcVexbt
 0vN3xRZ3VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEbnIxMqw+svrQr1oPlhsX
 rM+erHVStVc64N6aKaOqvXX5p761hzUY/hdIXvknGLTOdA1flFehtk0aT5N8nNyinpZ3zf/vbl9
 0lREA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

shmem_file() only checks a file's backing mapping. That mapping can belong
to another file, as with a Coda file backed by a tmpfs container after
mmap(). It does not establish that file_inode(file) is a shmem inode.

Seal handling and memfd preservation use this check before accessing
shmem inode state, so they can access an inode of the wrong type.

Add file_inode_is_shmem() to check the inode's file operations in both
paths. This identifies regular shmem inodes, including those used by
memfds and ordinary tmpfs files, independently of wrapper file operations.

Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/shmem_fs.h | 6 ++++++
 mm/memfd.c               | 8 +++++---
 mm/memfd_luo.c           | 2 +-
 mm/shmem.c               | 5 +++++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a7c7a96a7cbf9..2ceca7993e4f5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
+bool file_inode_is_shmem(const struct inode *inode);
 bool shmem_mapping(const struct address_space *mapping);
 #else
+static inline bool file_inode_is_shmem(const struct inode *inode)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
diff --git a/mm/memfd.c b/mm/memfd.c
index 0f6fff004f5e4..7d2da23157003 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -211,12 +211,14 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
 static unsigned int *memfd_file_seals_ptr(struct file *file)
 {
-	if (shmem_file(file))
-		return &SHMEM_I(file_inode(file))->seals;
+	struct inode *inode = file_inode(file);
+
+	if (file_inode_is_shmem(inode))
+		return &SHMEM_I(inode)->seals;
 
 #ifdef CONFIG_HUGETLBFS
 	if (is_file_hugepages(file))
-		return &HUGETLBFS_I(file_inode(file))->seals;
+		return &HUGETLBFS_I(inode)->seals;
 #endif
 
 	return NULL;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f9..c0811407ce397 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -582,7 +582,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 {
 	struct inode *inode = file_inode(file);
 
-	return shmem_file(file) && !inode->i_nlink;
+	return file_inode_is_shmem(inode) && !inode->i_nlink;
 }
 
 static unsigned long memfd_luo_get_id(struct file *file)
diff --git a/mm/shmem.c b/mm/shmem.c
index fadf23f9e21ed..0d41aac125df9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool file_inode_is_shmem(const struct inode *inode)
+{
+	return inode->i_fop == &shmem_file_operations;
+}
+
 bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;

-- 
2.43.0

