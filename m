Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789E34F24B
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581265; cv=none; b=dNzrhohX14oEVxblsj0qtvlxDNDLKXw7yLuuOy1oosTwj9Laa4eYnfzJD/FBjh2kVWb6Bz0JsXVj7hm/A24P2cP2btsOYXMdfQ7cO/l8cVrVvQLsc9e+WFrBbvQIorNrlOQBWsGcCNfTQhLSe48kjtXx/Pl2y0n/uAH+3muXiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581265; c=relaxed/simple;
	bh=EAdPE5tTsS8gNuKA/TVCfEN8WoaOc963KIs8hO/7xQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD1N3Pm1K8m2I75uorkmKWYiL6qZDA+w73cbVnTWvYH96b3/Cnn8NOYEUuK/aoY/KcG3kfjYmUw8pLEIuFrLP4ttP2kRqGyYH/QuwqQMbtXNHmfX2g8MpS3Uo5h6FQ1JXJKq0tjcA5syuYRPHc5Ig2iOX1CEGf29XlIsmcukZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyrWm5Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyrWm5Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD481F00893;
	Thu,  4 Jun 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581264;
	bh=/b4nVeJN2nykSyZgLuapqnrO7SFkDHJSu/52ALBpZw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyrWm5Et3XINm7eU44U4PPplXUMwOz2otnpW7hTNzNKVGCL71/W6t+JQhAmvWPFri
	 OVgdFZZRKF1alyWpL2bHJKlNKvvYh+BnS+UdHZ/mw60KlD7Flx4LRgGB37dU+Gwyvm
	 8bCcbiFF2NLiY2JL0wwkTymMKzk/1DVgbdF4FD5IrHyBqPxVDr+NhIzKnKCXuvemAb
	 zaIy0m/TtNg2G8eYaMUrLFdlnejTS1QGhhJHIeZWnCW0CqBiQ1nybjZEUQWYbLBQRY
	 YXM1V1AWzKCcFXOQniXgIgBI2cI8zi7pHZlSxhiB5IxsDQqR2FsX5vyXGVMNun3bug
	 tjOxwSO6kItlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	Hugh Dickins <hughd@google.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mm: perform all memfd seal checks in a single place
Date: Thu,  4 Jun 2026 09:54:19 -0400
Message-ID: <20260604135421.3490773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060408-corrosive-dental-a22b@gregkh>
References: <2026060408-corrosive-dental-a22b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit fa00b8ef1803fe133b4897c25227aa0d298dd093 ]

We no longer actually need to perform these checks in the f_op->mmap()
hook any longer.

We already moved the operation which clears VM_MAYWRITE on a read-only
mapping of a write-sealed memfd in order to work around the restrictions
imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
path behaviour").

There is no reason for us not to simply go ahead and additionally check to
see if any pre-existing seals are in place here rather than defer this to
the f_op->mmap() hook.

By doing this we remove more logic from shmem_mmap() which doesn't belong
there, as well as doing the same for hugetlbfs_file_mmap().  We also
remove dubious shared logic in mm.h which simply does not belong there
either.

It makes sense to do these checks at the earliest opportunity, we know
these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
change from the invoking do_mmap() so there is simply no need to wait.

This also means the implementation of further memfd seal flags can be done
within mm/memfd.c and also have the opportunity to modify VMA flags as
necessary early in the mapping logic.

[lorenzo.stoakes@oracle.com: fix typos in !memfd inline stub]
  Link: https://lkml.kernel.org/r/7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local
Link: https://lkml.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3b041514cb6e ("memfd: deny writeable mappings when implying SEAL_WRITE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c  |  5 ----
 include/linux/memfd.h | 23 +++++++++---------
 include/linux/mm.h    | 55 -------------------------------------------
 mm/memfd.c            | 44 +++++++++++++++++++++++++++++++++-
 mm/mmap.c             | 12 +++++++---
 mm/shmem.c            |  6 -----
 6 files changed, 63 insertions(+), 82 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4aa9a1428dd583..b0c3b4399a7937 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -96,7 +96,6 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
@@ -113,10 +112,6 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_write(info->seals, vma);
-	if (ret)
-		return ret;
-
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
 	 * overflow a loff_t when converted to byte offset.  This can
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index d437e30708502e..246daadbfde824 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -7,7 +7,14 @@
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
-unsigned int *memfd_file_seals_ptr(struct file *file);
+/*
+ * Check for any existing seals on mmap, return an error if access is denied due
+ * to sealing, or 0 otherwise.
+ *
+ * We also update VMA flags if appropriate by manipulating the VMA flags pointed
+ * to by vm_flags_ptr.
+ */
+int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -17,19 +24,11 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 {
 	return ERR_PTR(-EINVAL);
 }
-
-static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+static inline int memfd_check_seals_mmap(struct file *file,
+					 unsigned long *vm_flags_ptr)
 {
-	return NULL;
+	return 0;
 }
 #endif
 
-/* Retrieve memfd seals associated with the file, if any. */
-static inline unsigned int memfd_file_seals(struct file *file)
-{
-	unsigned int *sealsp = memfd_file_seals_ptr(file);
-
-	return sealsp ? *sealsp : 0;
-}
-
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01d53e7fdcce5f..544ee79faf37f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4140,61 +4140,6 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif
 
-static inline bool is_write_sealed(int seals)
-{
-	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
-}
-
-/**
- * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
- *                      in which case writes should be disallowing moving
- *                      forwards.
- * @seals: the seals to check
- * @vm_flags: the VMA flags to check
- *
- * Returns whether readonly sealed, in which case writess should be disallowed
- * going forward.
- */
-static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
-{
-	/*
-	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
-	 * MAP_SHARED and read-only, take care to not allow mprotect to
-	 * revert protections on such mappings. Do this only for shared
-	 * mappings. For private mappings, don't need to mask
-	 * VM_MAYWRITE as we still want them to be COW-writable.
-	 */
-	if (is_write_sealed(seals) &&
-	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
-		return true;
-
-	return false;
-}
-
-/**
- * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
- *                    handle them.
- * @seals: the seals to check
- * @vma: the vma to operate on
- *
- * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
- * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
- */
-static inline int seal_check_write(int seals, struct vm_area_struct *vma)
-{
-	if (!is_write_sealed(seals))
-		return 0;
-
-	/*
-	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-	 * write seals are active.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-		return -EPERM;
-
-	return 0;
-}
-
 #ifdef CONFIG_ANON_VMA_NAME
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in,
diff --git a/mm/memfd.c b/mm/memfd.c
index 119467307bff1f..190f07b6b98af3 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -197,7 +197,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	return error;
 }
 
-unsigned int *memfd_file_seals_ptr(struct file *file)
+static unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
@@ -354,6 +354,48 @@ static int check_sysctl_memfd_noexec(unsigned int *flags)
 	return 0;
 }
 
+static inline bool is_write_sealed(unsigned int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+static int check_write_seal(unsigned long *vm_flags_ptr)
+{
+	unsigned long vm_flags = *vm_flags_ptr;
+	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
+
+	/* If a private matting then writability is irrelevant. */
+	if (!(mask & VM_SHARED))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if (mask & VM_WRITE)
+		return -EPERM;
+
+	/*
+	 * This is a read-only mapping, disallow mprotect() from making a
+	 * write-sealed mapping writable in future.
+	 */
+	*vm_flags_ptr &= ~VM_MAYWRITE;
+
+	return 0;
+}
+
+int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
+{
+	int err = 0;
+	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
+	unsigned int seals = seals_ptr ? *seals_ptr : 0;
+
+	if (is_write_sealed(seals))
+		err = check_write_seal(vm_flags_ptr);
+
+	return err;
+}
+
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
diff --git a/mm/mmap.c b/mm/mmap.c
index d361b1058da109..e5ddc9c2af4923 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -369,8 +369,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 
 	if (file) {
 		struct inode *inode = file_inode(file);
-		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;
+		int err;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
 			return -EOVERFLOW;
@@ -410,8 +410,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
-			else if (is_readonly_sealed(seals, vm_flags))
-				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
@@ -431,6 +429,14 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		default:
 			return -EINVAL;
 		}
+
+		/*
+		 * Check to see if we are violating any seals and update VMA
+		 * flags if necessary to avoid future seal violations.
+		 */
+		err = memfd_check_seals_mmap(file, &vm_flags);
+		if (err)
+			return (unsigned long)err;
 	} else {
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
diff --git a/mm/shmem.c b/mm/shmem.c
index c92af39eebdd8a..51a0f94e6d9fe5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2820,12 +2820,6 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	int ret;
-
-	ret = seal_check_write(info->seals, vma);
-	if (ret)
-		return ret;
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
-- 
2.53.0

