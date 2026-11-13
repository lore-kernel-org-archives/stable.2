Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598574;
	b=S7oo3fQL9VHsGjcVc6f8bZVOdOE0pVH+Vy1UiQm9whYFanmFsGMTNMWwt6zD9sXNukRL
	 lQGg2A9oN+eJplV0IvmAVFMxjZMFjHt/jnhWHzaJKAdB+8ZhI1SojkwLbHOb7wlfEroU8
	 cVxbsk0bxsZYVJa1gdhu306uHW9vILa7I4YTNvhUqxZzFFmB8fyDh5B7c7gTfZDCLqw2V
	 /qr8g414wSpwEZMxPwDvzjogC6o4cTz9JPoOCxjuxduWEMVrOMifYQutX3zTBsgwd2cJ6
	 d/Zc9BKxXMy4OlGkfTh3DOiwpamkRBKS8buJnYH4K7kp5FPUOR3dZ5OLpexB25nQjHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8xOqUV0cjI+1ELhzDdUu/YSrSTeMttRt8JyVyfccpK4=;
	b=UyggB2rgMNh6RUBWB3I9/3DPw/oZse/VEJImT9OKQrtc+NbMJkrjY6gLgtlJoiNMf6bp
	 mu6O2EbkudoFUvh96vz6JjRQ5iENBO97RpNIcXaf3I48K1yl8EtH/70gYDoIDIBvLXKF/
	 f9WM/z1oi3h6udr+VUmksw/qJD0cdiW2mJkh0XKlaQx3u/HVqEJtoEyEhC5OruI8LzBRx
	 CI0b3d6cDdVlJOj6xdZkP2FzDpvOxn/dwPBfb+9n1Ppdj/i3rzpYbtg0SheV7DuYY4Phv
	 6CBySNAXtPQT/WDAl9vsdKDT3DwhgAXHeo91WffxV4n5FpEPcxZ5VydDFDFpJWNkhJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcZoYpPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D1606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcZoYpPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4601F000C4;
	Fri, 13 Nov 2026 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598574;
	bh=8xOqUV0cjI+1ELhzDdUu/YSrSTeMttRt8JyVyfccpK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcZoYpPnilvrX1TeGuChJbUUrevfosDHigpRmVlKBCPGuxxfaOWofOilBpjYkVRdb
	 kGRqQFF6wL9Ix1vZ8eseQodn6T3993NDatexkphPhIOGzt9hPFLzUNymlVWH4c6U5B
	 8mgAZ+9msF5EPYCujmNc3dcInNhZYPZQ30EdfQTeKp3dqDb9iNuJg6Wr4iuetwbsTg
	 +ZXVy06sjoxT6/OgdXVlB9AaTCfWL6be60wgsz39ey7YT2fmOnBfMHX5WQ9Iqx/+Qh
	 auZmbiLEP7JzjB699PIjB9LX5xQrfFH0x/fGB9L80n93B/FdeprYMoqYWEGj4JBYto
	 /sP0AoAHAxn4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/shmem: make shmem_file() check the file's inode
Date: Fri, 13 Nov 2026 14:36:12 -0500
Message-ID: <20261113193425.2425211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201125-failed-6.6-d3710111839d@kernel.org>
References: <20261109201125-failed-6.6-d3710111839d@kernel.org>
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
[ sashal: Adjusted context to preserve the existing inline shmem_mapping() helper and surrounding declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 134c686c8676c..e4b24b4442bb9 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -93,12 +93,18 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
+bool shmem_file(struct file *file);
 extern const struct address_space_operations shmem_aops;
 static inline bool shmem_mapping(struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 #else
+static inline bool shmem_file(struct file *file)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(struct address_space *mapping)
 {
 	return false;
@@ -159,15 +165,6 @@ static inline struct page *shmem_read_mapping_page(
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
index c0a3d09cfd976..dafa740e9bb2d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1785,6 +1785,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	struct page *page;
 	struct page *tmp, *dst;
 	struct folio *folio, *new_folio;
@@ -1793,7 +1794,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
-	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
diff --git a/mm/shmem.c b/mm/shmem.c
index 0f7c7ec48837a..74517e446f63f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -263,6 +263,11 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool shmem_file(struct file *file)
+{
+	return file && file_inode(file)->i_fop == &shmem_file_operations;
+}
+
 bool vma_is_anon_shmem(struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
-- 
2.53.0

