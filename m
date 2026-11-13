Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603703;
	b=pG5R78oWQIty2BCTgWQt+NfkBlWyxNPnrANlVUa84YeUdSISLCixY0jEqvN7GaemoSgT
	 JdaHMa+0dSb0DmvJxYSg7BdmBCit+hdPmIl+6W7FSSrnXyCjRvxR+RgSwxw7M6WNYggIU
	 ol03pDKYznDAfXZI5Xz8UkQn0v5ZsTgcxmYfulbwzOBPoYhYXe4aJ2JgogRx3smbMBhO/
	 7GCEkEdJ4uo+XVuqvFe37Zfi0vn7eofsTMI0W+U9+y+F2cdmC/lTd7fzO2EtVffoam6EX
	 Nr8to4DejemtE/H8mzQFvDGGe4v9DX5hkuZ7PwxhMh1y4g8kLVQw1XhbfQmznpiCB8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6wqni+og4l+rhTlcxddl3L2qxHXHJSGgnHGb5W28yH0=;
	b=3CUPq4YJM+ox/jxAL4c4qHR4a3NUd/q41o3UFIkIjAorSmftMs/vHyRvAXAHp5HgXCPE
	 vJESUJNjVe9y7drzGQr8jDVNf+unGlom4ktaYCMQ+CFWJASxpshOVpOiX4L9KTcbM8P8t
	 Rgi6nD9w95okrcMmoARM+6EnyQtnykzq6CQfebb3EtA4FfyDv3sSnjt9phv1Ph8O8U400
	 9uZwhXC0fV0ff3OEPQpgP2mO85OHpW+K+vc+fdEOqwyQakLzTj1LQNoOafmnQHKN6e2Hs
	 2MNZlOJ+pdPbFHOSSjyumPoaf8qYX+WLX1cIMQCAM8F6VhZ6v+EFupC+Z/lDamJBEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSijpCPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043B606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSijpCPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1171F000C4;
	Fri, 13 Nov 2026 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603702;
	bh=6wqni+og4l+rhTlcxddl3L2qxHXHJSGgnHGb5W28yH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSijpCPnN2tk9zdBREXiIGk+b3JEecVFOOdsLg6GR83OMcfAwDxp6uB8JvF2N9DGr
	 foENoy7qoCh/BySt72Jw7yT7rhqH6gQ2QEfNYBFHKuml9G1Am5dxozVj4lkfy583SS
	 QPxWv6+8b9NUv35Vnvst3QIiGZDLdHrBx0spNg3gNXZ9pL6Tjala3rGLK4BF4fZIQQ
	 3bQM8v+PIL5KaHjDGsbvNWyDuxAFpK8mUV0LwAABPjKMIwqgQJUzteIuCpBhucftOE
	 v8kp/nME5MgEd/hTrXRFajrQ/AlIMHI2rqQ8fKdHUeUJ8F/fOFdV6SnY33Vo8JFuJ+
	 7UOQ4jFrIu6tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/shmem: make shmem_file() check the file's inode
Date: Fri, 13 Nov 2026 16:01:40 -0500
Message-ID: <20261113205805.2472530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201552-failed-6.1-d3710111839d@kernel.org>
References: <20261109201552-failed-6.1-d3710111839d@kernel.org>
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
[ sashal: adjusted surrounding context to preserve the existing inline shmem_mapping() implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/shmem_fs.h | 15 ++++++---------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d500ea967dc73..19a1965ff1175 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -75,12 +75,18 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
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
@@ -123,15 +129,6 @@ static inline struct page *shmem_read_mapping_page(
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
index 9738b70bbd453..f3f9f9b54abf3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1774,12 +1774,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
+	const bool is_shmem = shmem_mapping(mapping);
 	struct page *hpage;
 	pgoff_t index, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
-	bool is_shmem = shmem_file(file);
 	int nr;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
diff --git a/mm/shmem.c b/mm/shmem.c
index 9db6a2488f456..1ed9c1e9abb99 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -239,6 +239,11 @@ static const struct inode_operations shmem_special_inode_operations;
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

