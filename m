Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273971;
	b=g3Xo6zClQPBetWYQTlXtVGa38LAHu0PPY2Z4tJt3MuG+rqi3H+d13DUpv94o/Wjl3Z/l
	 p+d6YH61u6/rnQ8jLegsYVxmoWX1e2BJ8ApfrpuIB+gGsMULM0RzaA0U9ur3RuD8WJW2I
	 lMAP6SENtZqIWmDx3y6sv7AX4bT241NKVJbqsvzrsTbcayAwZsxwMgLOa/JT/88u8BJdx
	 S7K/JMU0FsMUNeBsBX+re2ptNaCbzNCZA0F17yCsUFMiCkpQqtfZy40yGJX1a3jLzfL9n
	 73dkEoz/ren37pcJelIU7hcRTq5kzL2ulhnFckzLkyT0A8CbWOsR5KQe2QdsJ6zgMoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lkSHuUl3k81n+qjtJ1aO6MczsTOAQRmikWKu6m7MhoM=;
	b=eK6DOAUXFwAeyIXiTv7w7eu0gN5m0KJnkQisE7TeZ+k7+bUIIxmW//8i6mQ3DvkMIBL7
	 dBOltxfaeb+dSONd67o4EQSm6PQsM3RVpnYIodGchTgqb2r/ck4U3FBkbtkDBXqoG6m3Q
	 TnS+lByVxI/E3+Fqwr8k+kpgNlFI5/a6eg/BHUpyj7skUFg/6uYBLKXqji9jsshtz84FZ
	 QEXCdi0wbHobKf1DX8T3embeiCMcIFFUXptiVZzfodWGZBvhEG6qfw8gdqmDfslNDDqiR
	 jQHniXPEngTKRqydDhvWp3rpkuq8PGLc/OQFas4ZkNOEkWElV4+Jnr6h30UOmC4YLjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgUKiGId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330960A260D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgUKiGId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38091F0089F;
	Tue, 10 Nov 2026 01:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273970;
	bh=lkSHuUl3k81n+qjtJ1aO6MczsTOAQRmikWKu6m7MhoM=;
	h=From:To:Cc:Subject:Date;
	b=FgUKiGIdyo1QjrQo+VQV7hw9msoty1Y4H192xzXm4pHU3xhOGHtZaKh7n935CSRBg
	 gDkPTd5Ibp2uDK4zWqiAq2PbgdfCeISRb0hsAOzniF0iQ/aKpNKUZfNQ+HPL6C0JZR
	 3womNWQaDztntomk2v6v7eXEeY/73WbJFO0xvVlg5kjutrjeMw1nO7lPQohATssGzx
	 gUNW2mD7TEEUmMHFTlxFNuPd6YMoSXwglwaWR47zwoi+MuM/j7zzAFlFxvFAIdbQy4
	 pCDqYhhEoqEtFB3lH18/E75iw5WQzrmpzEYM4LNajsTPU9HMvm5+egcocByyDkOr19
	 b2xV2pFUTSV6w==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	mason@kernel.org,
	pratyush@kernel.org,
	baolin.wang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: make shmem_file() check the file's inode" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:07 -0500
Message-ID: <20261109202607-failed-5.10-d3710111839d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d3710111839d11339e414b1bb3fea3d05ab83f6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202607-failed-5.10-d3710111839d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3710111839d11339e414b1bb3fea3d05ab83f6e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:32 +0100
Subject: [PATCH] mm/shmem: make shmem_file() check the file's inode

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
index 923957e5e6a24..e64704ac72222 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -276,6 +276,11 @@ static const struct vm_operations_struct shmem_vm_ops;
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




