Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670749;
	b=qK/jEkHLgoPEGP4eZQF8tuNGL6sRIfI9JYDChSEGNh2QLsvUA5NY5slGEUDQ/MMl2W12
	 blSL3s2JgzePrMbckbkJxQG7UqTCNSZsvg+2UQU7xF6wfZHcO0UGfjRAasVlGC9h1HKaK
	 0mhyPZaoyVdxPudmlXuiXH0CY9mNn+SkUTdQMCiJ2OPJF5c6N3lVSNlo36Pxjz0d4Dprc
	 qDLgH9F6A+BZ0cCZqLS5cfjuWIMd/ska7Hh1RFNsdHK+YsRiPNSMycwsNQqor2XBwm2Z8
	 N0QfYkHlYBVpnEKrrJqCaH80vzzwpXQZ1JPbBqLDcYtY5SriBK49A4VGqaQrRVpaIWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DGoHIfl7QNzjpt6DBGy/eMcw9uC5FNLdM71t/oqrJY4=;
	b=LQGk58i6iZ/Ubsdf8muz/GQBYDzYWcFpAqY1ySvOToJzsLtmy5N+LcgO5HSRYdEiz8fM
	 ElXSC5leDVJqoGueuk0naLIoOqQJu9HKEsHmbJnUq5+HEWmc/ZyihVtg3C+Oa/j19haCM
	 4RmmNhGrR8MqhvBOUa8qFl7Ahug9FixElv9seWxhYR4jyqCPp2fSaQnOLU3CdOPxDfAHZ
	 QwoV7J6sRa/K4RyhIGrCD7hbI5UIppt5ORHudWN21Ob955rhdPg3uqM/84277OsyqijtR
	 k92LRRnyrzfPPZHeEOj2i7ooKlB1r1yrXFzAakwoFnKLweCDb3E/oDPCBV6LsyBa7lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auwZueCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B4606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auwZueCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA681F000C4;
	Sat, 14 Nov 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670749;
	bh=DGoHIfl7QNzjpt6DBGy/eMcw9uC5FNLdM71t/oqrJY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auwZueCoWaANF/UqFrH6j1IO3egwViyJpGN/JewLIvxK6CgZJM88+Rvr1nhgXC7zB
	 rfeAr/HTKdFcpShC8YLnkz/quQmfsq1YByP2Hikji7WlFkCgosTO4vFn83CTj9Yqvm
	 MEF1msbwCqpeuZzhR84Rk6BRhJsnyVJdUTgoPuTYTi8f3jD3/MvQUzLaxnJsmH+r5f
	 gCRovR0VdyxMvI8UR5AfPMCeVAoKWY+TZo8f8Mjmc6Mrmo53jVcYLMo5N/EHcpdtf8
	 uvC/NIGD/6Q5ZJYyQfaOLzXlI/Boa/CB/R+PuVygAXWHXY4Au2Rg/kypXSWjgkuEpm
	 gobYM9pGVZ/hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/shmem: make shmem_file() check the file's inode
Date: Sat, 14 Nov 2026 10:39:07 -0500
Message-ID: <20261114153848.3661595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202607-failed-5.10-d3710111839d@kernel.org>
References: <20261109202607-failed-5.10-d3710111839d@kernel.org>
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
[ sashal: Adjusted patch context to fit the older shmem helper layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a5a5d1d4d7b1d..fe9063e9b2ee1 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -67,8 +67,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
 #ifdef CONFIG_SHMEM
+bool shmem_file(struct file *file);
 extern bool shmem_mapping(struct address_space *mapping);
 #else
+static inline bool shmem_file(struct file *file)
+{
+	return false;
+}
+
 static inline bool shmem_mapping(struct address_space *mapping)
 {
 	return false;
@@ -106,15 +112,6 @@ static inline struct page *shmem_read_mapping_page(
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
 extern bool shmem_charge(struct inode *inode, long pages);
 extern void shmem_uncharge(struct inode *inode, long pages);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e523bb9381189..bf70c3bbf91ec 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1690,13 +1690,13 @@ static void collapse_file(struct mm_struct *mm,
 		struct page **hpage, int node)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	gfp_t gfp;
 	struct page *new_page;
 	pgoff_t index, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
-	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
diff --git a/mm/shmem.c b/mm/shmem.c
index 6f2e267aa092f..db3c38c59818a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -254,6 +254,11 @@ static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool shmem_file(struct file *file)
+{
+	return file && file_inode(file)->i_fop == &shmem_file_operations;
+}
+
 bool vma_is_shmem(struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_vm_ops;
-- 
2.53.0

