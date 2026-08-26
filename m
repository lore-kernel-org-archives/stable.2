Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0844CAE6;
	Wed, 26 Aug 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761876; cv=none; b=E15mXzkhbKGlRpKi72hGIQxD98PZXz4Cmt+r/f7P5VFJgt57SzUnzXUwv6yKQQ2WtUemxEigiMYARAsYCSkf3zZaO0bdAotMv0m+1NNP5A2HQrWLM3/L2slA8iVhiNqLcrnpIPmPUw/jajWYjlHZ8dugoRrUdB0NNQw0BpmaIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761876; c=relaxed/simple;
	bh=3292G1oeBAcmtbhOMVJvtlvXQkkqwPpvEl8KWeS3tJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nZ5MQ51CgipY58eoXdMvUQX0cLXE5FUPkWOde4SJ7NUk8u2cgwJnQzKA8c+7QSHiXCc/CvdrWamQUNZYDSvOpHQqLEX/MAktbEup9uP1GgK+Cn6Sx37d9PzuQ3t4UZrEU7X4htKDN6aBL6jabSHPY1S+zCFMQ8N4DgeUlOeJ++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMzLdrq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMzLdrq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEEB1F000E9;
	Wed, 26 Aug 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787761874;
	bh=Yg4Oy+42yCHK1QRBaG3QTdEIjLEpLNjOi4DjkygMvoU=;
	h=From:Date:Subject:To:Cc;
	b=LMzLdrq8QR4FUpRZXnwAJpHXQ6Tw94Cfm+MAThkmAziYB1oIowpvwmABQ8B0zr2Zm
	 2TG3ifXjp+coCb/bBIxx6f1oX/t1K0JjQ1Y8piwePY4Wc70kyI4zmI9d5LSUB12Pbx
	 bf2RRQiwf5geKOFPhhQKkNPYGK0Iy4b3gqzgIBSDY1tzWuMskTKaGTm9Bk19zkaJ69
	 I5Vf0lCxRY5lf9PwXy9kr1GA91Wxx1res6eNDylDis/7H7qrMx3v1Af2LlqBKoIMo/
	 dKlBtptnXKxA0ijV+x0OLMyOnkAp5xqNKtSRZ0ud0wTpTtfweV7gOLqAN0yMAbEURn
	 d8Rexqj/UA4WA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 26 Aug 2026 17:30:35 +0100
Subject: [PATCH v3] mm/secretmem: properly account locked pages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKoUj2oC/4WNQQ7CIBQFr9KwFlMQaevKexgXQH9b1IIBSjRN7
 y7UjS6My0nem5mRB6fBo0MxIwdRe21Ngt2mQGoQpges28SIlpSXNWHYg3IQRhixUMpOJmjTY9F
 ywRinjSQNSte7g04/Vu3p/GY/yQuokF15MWgfrHuu3Ujy7k8iEkxwS7ta8apq6lIer+AM3LbW9
 Sg3Iv2wUPrDQpOlA8b2olIcJPmyLMvyApg1VP8RAQAA
X-Change-ID: 20260814-secretmem-accounting-ad6a44629b19
To: ljs@kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hagen Paul Pfeifer <hagen@jauu.net>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12430; i=ljs@kernel.org;
 h=from:subject:message-id; bh=3292G1oeBAcmtbhOMVJvtlvXQkkqwPpvEl8KWeS3tJs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL6RfZmceSIz//93ex7trK74E2zBGuJV5FPbh74ZS/4c
 es9H64zHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiI21dGhqfBWZs3snfFpr3e
 e5F5UV33mWX2ayKOra45GatZ9a3UIoThf3xxkOxLvhVTLy8IUNYMMK/qeaYabWEj+73aykQ2QO4
 vAwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

secretmem accounts folios by treating memory as if it were mlock()'d and
thus limited by the RLIMIT_MEMLOCK limit.

However the folios are unevictable and remain so until the inode is
evicted, eliminating usual mlock() semantics - mapping folios then
unmapping them does not clear their unevictable state, since it depends on
AS_UNEVICTABLE, not PG_mlocked.

A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
map then unmap and VmLck no longer counts the secretmem range. Worse,
folios are not accounted in the process's RSS, meaning the OOM killer won't
know to kill the process.

Repeatedly mapping/unmapping (or forking) can then result in the
consumption of all available system memory with unevictable folios and
cause system instability.

A secretmem fd can be passed between processes and over fork so a
per-process limit simply does not make sense, so follow the precedent set
by io_uring, perf, skbuff, iommufd and xdp by tracking the number of locked
pages in user_struct->locked_vm.

Since the scope tracked is actually inode lifetime, the RLIMIT_MEMLOCK
applies per-user not per-process, so it doesn't make sense to bypass for
users with CAP_IPC_LOCK, therefore remove this bypass.

There is simply no reason to carry on marking the mapping as mlock()'d
since it's misleading and the lifecycle is now correctly handled, so remove
this too.

Note that secretmem does not support any form of truncation (including hole
punching) and the folios are unreclaimable, so the folios need only be
accounted on fault and unaccounted on inode destruction.

__secretmem_account_pages() is more or less a duplicate of the code that
io_uring etc. use, but since this is a bug fix that needs backporting,
defer any de-duplication efforts to a follow-up.

test_mlock_limit() asserts mlock_future_ok() on mmap(), however this has
been removed, so remove the test altogether for the fix. A new test will be
sent separately for upstream.

Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v3:
- Accumulated tags (thanks Mike and David!)
- Tried to cut down commit message further as per Mike.
- Made local vars const as per David.
- Removed test (will send separately) as per David.
- Added comment about hole punching and truncation as per David.
- Some small commit message fixups.

v2:
- Tried to put the commit message on a diet, as per Mike.
- Moved secretmem_init_inode_[priv, destroy]() nearer their callers as per
  Mike.
- Removed CAP_IPC_LOCK check as per discussion with Mike.
- Removed redundant GFP_KERNEL in kzalloc_obj() call as per Mike.
- Updated to consistently use goto err style in secretmem_file_create() as
  per Mike.
- Updated test_mlock_limit() to consistently use goto cleanup style as per
  Mike.
- Added a comment describing why we are capping the mlock limit in the
  secretmem tests, as per Mike.
- Set inode->i_priv to NULL after destroy.
https://patch.msgid.link/20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org

v1:
https://patch.msgid.link/20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Hagen Paul Pfeifer <hagen@jauu.net>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: ljs@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 include/linux/sched/user.h                |   3 +-
 mm/secretmem.c                            | 116 +++++++++++++++++++++++++++---
 tools/testing/selftests/mm/memfd_secret.c |  30 +-------
 3 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 4cc52698e214..8d7e5521f7cd 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -25,7 +25,8 @@ struct user_struct {
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
 	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
-	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
+	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD) || \
+	defined(CONFIG_SECRETMEM)
 	atomic_long_t locked_vm;
 #endif
 #ifdef CONFIG_WATCH_QUEUE
diff --git a/mm/secretmem.c b/mm/secretmem.c
index d29865075b6e..384f5cfc457f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -18,6 +18,8 @@
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/user.h>
+#include <linux/cred.h>
 
 #include <uapi/linux/magic.h>
 
@@ -47,10 +49,69 @@ bool secretmem_active(void)
 	return !!atomic_read(&secretmem_users);
 }
 
+struct secretmem_inode_state {
+	struct user_struct	*user;
+	atomic_long_t		nr_pages_accounted;
+};
+
+static bool __secretmem_account_pages(struct user_struct *user,
+		unsigned long nr_pages)
+{
+	unsigned long page_limit, cur_pages, new_pages;
+
+	if (!nr_pages)
+		return true;
+
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	cur_pages = atomic_long_read(&user->locked_vm);
+	do {
+		new_pages = cur_pages + nr_pages;
+		if (new_pages > page_limit)
+			return false;
+	} while (!atomic_long_try_cmpxchg(&user->locked_vm,
+					  &cur_pages, new_pages));
+	return true;
+}
+
+static bool secretmem_account_folio(struct secretmem_inode_state *state,
+		const struct folio *folio)
+{
+	const unsigned long nr_pages = folio_nr_pages(folio);
+
+	if (!__secretmem_account_pages(state->user, nr_pages))
+		return false;
+
+	atomic_long_add(nr_pages, &state->nr_pages_accounted);
+	return true;
+}
+
+static void __secretmem_unaccount_pages(struct secretmem_inode_state *state,
+		unsigned long nr_pages)
+{
+	atomic_long_sub(nr_pages, &state->user->locked_vm);
+	atomic_long_sub(nr_pages, &state->nr_pages_accounted);
+}
+
+static void secretmem_unaccount_folio(struct secretmem_inode_state *state,
+		struct folio *folio)
+{
+	__secretmem_unaccount_pages(state, folio_nr_pages(folio));
+}
+
+static void secretmem_unaccount_all_folios(struct secretmem_inode_state *state)
+{
+	const unsigned long nr_pages_accounted =
+		atomic_long_read(&state->nr_pages_accounted);
+
+	__secretmem_unaccount_pages(state, nr_pages_accounted);
+}
+
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct secretmem_inode_state *state = inode->i_private;
 	pgoff_t offset = vmf->pgoff;
 	gfp_t gfp = vmf->gfp_mask;
 	unsigned long addr;
@@ -72,8 +133,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 			goto out;
 		}
 
+		if (!secretmem_account_folio(state, folio)) {
+			folio_put(folio);
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+
 		err = set_direct_map_invalid_noflush(folio_page(folio, 0));
 		if (err) {
+			secretmem_unaccount_folio(state, folio);
 			folio_put(folio);
 			ret = vmf_error(err);
 			goto out;
@@ -82,6 +150,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
+			secretmem_unaccount_folio(state, folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
@@ -112,22 +181,30 @@ static const struct vm_operations_struct secretmem_vm_ops = {
 	.fault = secretmem_fault,
 };
 
+static void secretmem_destroy_inode_priv(struct inode *inode)
+{
+	struct secretmem_inode_state *state = inode->i_private;
+
+	secretmem_unaccount_all_folios(state);
+	free_uid(state->user);
+	kfree(state);
+	inode->i_private = NULL;
+}
+
 static int secretmem_release(struct inode *inode, struct file *file)
 {
 	atomic_dec(&secretmem_users);
+	secretmem_destroy_inode_priv(inode);
+
 	return 0;
 }
 
 static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	const unsigned long len = vma_desc_size(desc);
-
 	if (!vma_desc_test_any(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
 		return -EINVAL;
 
-	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
-	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
-		return -EAGAIN;
+	vma_desc_set_flags(desc, VMA_DONTDUMP_BIT);
 	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
@@ -187,20 +264,40 @@ static const struct inode_operations secretmem_iops = {
 
 static struct vfsmount *secretmem_mnt;
 
+static int secretmem_init_inode_priv(struct inode *inode)
+{
+	struct secretmem_inode_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return -ENOMEM;
+
+	state->user = get_uid(current_user());
+	inode->i_private = state;
+	return 0;
+}
+
 static struct file *secretmem_file_create(unsigned long flags)
 {
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
+	int err;
 
 	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	err = secretmem_init_inode_priv(inode);
+	if (err)
+		goto err_free_inode;
+
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR | O_LARGEFILE, &secretmem_fops);
-	if (IS_ERR(file))
-		goto err_free_inode;
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_free_priv;
+	}
 
 	mapping_set_gfp_mask(inode->i_mapping, GFP_USER);
 	mapping_set_unevictable(inode->i_mapping);
@@ -215,10 +312,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	atomic_inc(&secretmem_users);
 
 	return file;
-
+err_free_priv:
+	secretmem_destroy_inode_priv(inode);
 err_free_inode:
 	iput(inode);
-	return file;
+	return ERR_PTR(err);
 }
 
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index aac4f795c327..c55d84c5e613 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -57,33 +57,6 @@ static void test_file_apis(int fd)
 		pass("file IO is blocked as expected\n");
 }
 
-static void test_mlock_limit(int fd)
-{
-	size_t len;
-	char *mem;
-
-	len = mlock_limit_cur;
-	if (len % page_size != 0)
-		len = (len/page_size) * page_size;
-
-	mem = mmap(NULL, len, prot, mode, fd, 0);
-	if (mem == MAP_FAILED) {
-		fail("unable to mmap secret memory\n");
-		return;
-	}
-	munmap(mem, len);
-
-	len = mlock_limit_max * 2;
-	mem = mmap(NULL, len, prot, mode, fd, 0);
-	if (mem != MAP_FAILED) {
-		fail("unexpected mlock limit violation\n");
-		munmap(mem, len);
-		return;
-	}
-
-	pass("mlock limit is respected\n");
-}
-
 static void test_vmsplice(int fd, const char *desc)
 {
 	ssize_t transferred;
@@ -297,7 +270,7 @@ static void prepare(void)
 				   strerror(errno));
 }
 
-#define NUM_TESTS 6
+#define NUM_TESTS 5
 
 int main(int argc, char *argv[])
 {
@@ -319,7 +292,6 @@ int main(int argc, char *argv[])
 	if (ftruncate(fd, page_size))
 		ksft_exit_fail_msg("ftruncate failed: %s\n", strerror(errno));
 
-	test_mlock_limit(fd);
 	test_file_apis(fd);
 	/*
 	 * We have to run the first vmsplice test before any secretmem page was

---
base-commit: e737cebb8de0d38e8f64584a8bbfbcf9176c7537
change-id: 20260814-secretmem-accounting-ad6a44629b19

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

