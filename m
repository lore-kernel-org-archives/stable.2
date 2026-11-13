Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597045;
	b=ojWY5B4vInks+TnxBUlsntZBi3rIUKWL6HJKYk+lCP+0+6ZoUhhZJOY0A5Nvsot0Ow0c
	 d9wozVz57rvY3jWPhzMX3qmC5MHRnlOU4D2SjqLxai4b87TZoyQMzXfVwqfLJQIsZT3Ia
	 2J44qhALXjzNm3hRT4mvf5xUiAvbm4xN6Nl7WchZwQWYy4xba67pDSS6L+xHxVXaK7Jnp
	 he7Uv1FcX5/MI5lUXBv8lmIYMjO7B2mJnnriUQyM+DzmZypYS9E/ENziSVpNo/6wHBwbD
	 qTfG+JVmeYaqs+wKw5SjGZiAYSsBWeXkj00dtfBEmvKT7HQXp6lzxRRcgiNZWEamnRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+6mgtOeE77hCx9dQEyWulri7nTtkEZeRSollDzOEkrM=;
	b=T6ioyo2y7A2ME2MpfQzF0iwYoHIFtQC2grPMcHpCAENdTOB64H95RyYiZBNb7ay3E0EM
	 wH4xfPKq3mw8tMHxkiqBUoSjqtsgipA49BSCHL/nAoXIqaUQ9dnERpUBTEUcpnSMDBTyS
	 cA3b98FFB6M+uVWeG5uur6MMxP6XKJb+bmLq94/9FxhkHkgLz9QdCBar9V5UcrgUL9D8R
	 /JJUw+90dAeFENEwagDd9QyR/lsvP4c+904R0kKPVCzHQ5yxWIl29xBjFztlH6INxF9Sl
	 HpKJdcE0nZxeieGnWdomsazzWg3cuSpow3GBIVLb+SdcJwEuPd1q8+2GYD6DGP3pgLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfSZSvYO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17546606A898
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfSZSvYO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452F31F000C6;
	Fri, 13 Nov 2026 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597044;
	bh=+6mgtOeE77hCx9dQEyWulri7nTtkEZeRSollDzOEkrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HfSZSvYOJKN4ERbZBAGMtHXRcVL3jZG26HOOd3GKMKtb1rCxSoCSu9TK9r6N9WtQR
	 zeuzNVJ+u92GQ/HI/O9xVGWe4oln6iJ7o2Fx+MZIhlz+IyKmEnzY0HYivFB9ylmC5N
	 DpzlyrhFf2xZe4Slw8bTDusHyC1yITwfATwzfTCJN6G+F73viMmoYJubqNuWh+jH5+
	 cVxje00bI7SEONUgjjaQmLFTkGztt5V3RQ3IzhtU0zJgLCbcL/IdNT9iMyoL9T89Lm
	 aCXPCqoGh49zyJ7v+wXViwUK6tgR8iw3IhSXWP7aJ5c2B4Q/OCHS0Vvynmmt99TeeY
	 y/8fZWUBNmb3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/shmem: make shmem_file() check the file's inode
Date: Fri, 13 Nov 2026 14:10:43 -0500
Message-ID: <20261113160251.1939291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200312-failed-6.18-d3710111839d@kernel.org>
References: <20261109200312-failed-6.18-d3710111839d@kernel.org>
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
[ sashal: adjusted context for the missing shmem_freeze() helper and combined integer declarations in collapse_file() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0e47465ef0fd5..2b49d4d1426ff 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -99,8 +99,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
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
@@ -171,15 +177,6 @@ static inline struct page *shmem_read_mapping_page(
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
index 6bff1096de7d8..9db84989334a0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1860,6 +1860,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
 	unsigned long new_pfn = -1;
@@ -1867,7 +1868,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
-	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
diff --git a/mm/shmem.c b/mm/shmem.c
index 6828611bcdfe0..4f322dad7fbc0 100644
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
2.53.0

