Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A052ED4A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872321; cv=none; b=NCdtKekDAV5zhVnUuqvp3hLHQPmUaal2PelJOTa/8m6xkZ1t0jy+p/xyie07MOn0q4/KoGGIn9LWMfYVWK22OrGpYVsOuFJ5KWg3LdqDEdMoO6XO7k657v+7xB9Peg+OPBXdXNe7o40xbe7wLO16vF1gI6MPk8AnrNQVPr3myuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872321; c=relaxed/simple;
	bh=w9sIZzJx4m0C8hEcQrN3OBSKjaRYTjf4skbd5nMdGt0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oXNzw9aPsKVYHKAdMbyYgywqv4RzbziiPDO/L5kRl8AzeprUm5iwZvbvpSOZKnJCFKvEe5x+RFmOp1uIoEGZpuXFa3R/qwXXPPo5+t3SH8GWv/TSJauqXihVEGSECkblQU/UZtZQ14q1r5V7YakRHJTfy190L/8K87fbwO/R1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwXttcKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwXttcKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1998F1F00A3D;
	Tue,  8 Sep 2026 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872318;
	bh=TmYs6Zn95q9lul8qGghZMZgonQ8n8yyg1SV255E12Pw=;
	h=Subject:To:Cc:From:Date;
	b=JwXttcKAZC6l7xR1ODqC2tn/qLoIMlGYAup3RDjgnIQcdemDLpurbNyv7IylMc9z8
	 NPqtv0Rv8PXMYkpcgGGs9755QCxc22Kl5i7ebVK+IaAR5UZx3OE3r6W9cI7V2Y3Z8b
	 eTFEPRZ9D1DaxvKyYpZSCUwmLdoRLflLdhv/xklc=
Subject: FAILED: patch "[PATCH] mm/secretmem: properly account locked pages" failed to apply to 6.1-stable tree
To: ljs@kernel.org,4ncienth@gmail.com,akpm@linux-foundation.org,ast@kernel.org,davem@davemloft.net,david@kernel.org,hagen@jauu.net,hawk@kernel.org,james.bottomley@HansenPartnership.com,john.fastabend@gmail.com,kuba@kernel.org,liam@infradead.org,mhocko@suse.com,rppt@kernel.org,sdf@fomichev.me,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:53:32 +0200
Message-ID: <2026090832-trivial-doorframe-5fc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 97d34aa65c29cca85e3e9050f4c936389b38a054
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090832-trivial-doorframe-5fc5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97d34aa65c29cca85e3e9050f4c936389b38a054 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 26 Aug 2026 17:30:35 +0100
Subject: [PATCH] mm/secretmem: properly account locked pages

secretmem accounts folios by treating memory as if it were mlock()'d and
thus limited by the RLIMIT_MEMLOCK limit.

However the folios are unevictable and remain so until the inode is
evicted, eliminating usual mlock() semantics - mapping folios then
unmapping them does not clear their unevictable state, since it depends on
AS_UNEVICTABLE, not PG_mlocked.

A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
map then unmap and VmLck no longer counts the secretmem range.  Worse,
folios are not accounted in the process's RSS, meaning the OOM killer
won't know to kill the process.

Repeatedly mapping/unmapping (or forking) can then result in the
consumption of all available system memory with unevictable folios and
cause system instability.

A secretmem fd can be passed between processes and over fork so a
per-process limit simply does not make sense, so follow the precedent set
by io_uring, perf, skbuff, iommufd and xdp by tracking the number of
locked pages in user_struct->locked_vm.

Since the scope tracked is actually inode lifetime, the RLIMIT_MEMLOCK
applies per-user not per-process, so it doesn't make sense to bypass for
users with CAP_IPC_LOCK, therefore remove this bypass.

There is simply no reason to carry on marking the mapping as mlock()'d
since it's misleading and the lifecycle is now correctly handled, so
remove this too.

Note that secretmem does not support any form of truncation (including
hole punching) and the folios are unreclaimable, so the folios need only
be accounted on fault and unaccounted on inode destruction.

__secretmem_account_pages() is more or less a duplicate of the code that
io_uring etc.  use, but since this is a bug fix that needs backporting,
defer any de-duplication efforts to a follow-up.

test_mlock_limit() asserts mlock_future_ok() on mmap(), however this has
been removed, so remove the test altogether for the fix.  A new test will
be sent separately for upstream.

Link: https://lore.kernel.org/20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Daehyeon Ko <4ncienth@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Jakub Kacinski <kuba@kernel.org>
Cc: James Bottomley <james.bottomley@HansenPartnership.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

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

