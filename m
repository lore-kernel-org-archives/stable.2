Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597765;
	b=mA31Dlsbsf8olBl2vbFXIhYSlaoYypNFK6k0tMXpMWXqz6Xusg4W3J+DUEey4Rdqs3m/
	 aEgWYdizzUQxLH/+PH+uMzn9Zf6gNI/7pX3gV46BTJ/aKWwiw54MLHIJeOMFQcwnnegKO
	 LCYfpGFA909IIcxSZ3Hn4ik4sibblISva2a9Oo0ITwjnij53AGZZIs4sSetGRbAQggH4e
	 GxDq39Oy+VfGnbSbP+zJPDvp3ZdS8Mj9sRyRwLIjY5JYWbwGoG4kKgjLlTdao3z0G1O5E
	 XjBPx5ICiCvLSLQgaSwgSLI8RcSk51o+dQrSRItaQOi3V1CXUfOktJsnNF5AREuqqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mnNRgWRp+4hv+j6YL+iFcZJMWH6z4jPrEo7PZ8M0U2A=;
	b=Sn6NBpYdGjFUc+weqtXUFTSazUy368jUknmRQnVB2GdC75zOAWv/7fZ0AyagZ1XsMbMG
	 psdrfOqnj3tFWiOVviAwsH1IFObT9hNRNLsml7d2TQyscojSGjB8Ev/GkxoaAUWbfLKxb
	 A47qTZH4/TtZuTEkX7VXB2ePNI0WCzdDSmcTXvKPAwyzCf+dSAdN0tT+mhse91bUoc1vF
	 q6WJ3gMRwdNw727whFu40wdYuYtxgPM3WE9ej00htqELcYk1cpSfcOVUJsm8KWiu1rsAa
	 kdszaMmNKWNx/l1ZhhXALS9x4KFqI7sQltqhKGyVNUlwj8Qm7TTQxsiJA74jrv/d1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9hqhfSE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232860A2606
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9hqhfSE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967DC1F000C4;
	Fri, 13 Nov 2026 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597765;
	bh=mnNRgWRp+4hv+j6YL+iFcZJMWH6z4jPrEo7PZ8M0U2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9hqhfSEwH3T24PNTuVRkCVefiacMnyUly2bVlDtYOHBrZGN4QJeVjaIcL6awcnjr
	 ZZ5k6abgoOepRPV/9od0fjG1NPQ+Sqx8rPHyjRCZJusrJ1clqw/53NOxSrdYvLNnGb
	 bclsJudF8nA9oF0VLkEuH/jLCR/rMCpUVC1wl68xGThd9lFvlqGYRC9Fi26uA8V4aN
	 5Im5yVnwFu2RA23OUXwrDM6Q6BgxYVZ9//fmtgnPz4K/LSXcx/WlHlDWTKJqbo7p2B
	 vVcRogQREgd76f97T/0ij5Qxj6/YpI8jbkPOkySpZOVfYRzLbnOfkci1PITkWqqT6C
	 Koxgy8FFBhGuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/shmem: make shmem_file() check the file's inode
Date: Fri, 13 Nov 2026 14:22:43 -0500
Message-ID: <20261113192022.2246748-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200701-failed-6.12-d3710111839d@kernel.org>
References: <20261109200701-failed-6.12-d3710111839d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit d3710111839d11339e414b1bb3fea3d05ab83f6e ]

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
Link: https://patch.msgid.link/20261031-fixes_core-v3-3-d6437171ecc3@kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Adjusted context to preserve the existing non-const shmem_mapping() interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 515a9a6a3c6f8..183975ead5cf6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -97,8 +97,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
+bool shmem_file(struct file *file);
 bool shmem_mapping(struct address_space *mapping);
 #else
+static inline bool shmem_file(struct file *file)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(struct address_space *mapping)
 {
 	return false;
@@ -161,15 +167,6 @@ static inline struct page *shmem_read_mapping_page(
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
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1250d878d7242..f1d9af8324c11 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1809,6 +1809,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
 	unsigned long new_pfn = -1;
@@ -1816,7 +1817,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
-	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
diff --git a/mm/shmem.c b/mm/shmem.c
index 8de38d7a98f92..df6a57f227865 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -270,6 +270,11 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool shmem_file(struct file *file)
+{
+	return file && file_inode(file)->i_fop == &shmem_file_operations;
+}
+
 bool shmem_mapping(struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
-- 
2.53.0

