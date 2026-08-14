Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3D48AE17;
	Fri, 14 Aug 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733367; cv=none; b=hW0t77i1uqXccUSzp6NeFraJutYMifRfTCBQE/U0+4bpS973mp2G18k2WHEFD8xmojAYzKu0GP7/UPKadWBbv9ApXHj1Rfz4Xg/l2ie5fNUmILI0nj2Rr0TyUkP8U1ZQd9AqwCmK0S3Jv/UOgy4QoVswWv8pseX7QMlOEAJPAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733367; c=relaxed/simple;
	bh=yKRGInPGtch/R9cV3jJD5kNV2Fet094tcqzz3HDdJ4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OrMnpYmZJROhAXKMzKwFNWmxFPjcwjtZ0O9RBATwn6cZ0vOl0NzzeGwHtWgGsYyzuoXGttT2/nNAge5TTAx8Irei6k0QEiELm5eplQK9JCTb3xeSaFcw1p0BGyWVoZjnm02Cyw1BvbT0pF9zpgjwC03414Zvkjjc/2D0lylq+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM3KofcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM3KofcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E971F000E9;
	Fri, 14 Aug 2026 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733364;
	bh=X81VAGkYloILr0E5UrT7V9WQ0bRP0vdTMw1afxJlZhg=;
	h=From:Date:Subject:To:Cc;
	b=eM3KofcMt8c240/+i3iYHp/TBHs+hbYoI7SntQ0xvj7el+YXLI2QavnKJZgXN1xMk
	 +60GpWYyUDADfuz1rWdUgFuXi6utdNOeEZHt9wQcPACUWRKYmQ42Os4Lnh0/EiGp0q
	 RHSVk+eP+gT4LZXVw+vfcP/P1/x4gN+ACG4xBkSlLTJyYt8KQ0rLoIMBcUfO2I5aIy
	 Ycndp2byb1KCV1+S18Uw0HMyFU+Th9XDRdZnO8ATN9+5bzNyh3tBihxJTOjoYKeICB
	 NGG3ldNvAcpom5TE+tdM6E6OMqBQXFzDuxRXxVW0Ydn9U68MLHNjMJPiHKE2+ViA5j
	 0uHM3mw9UPO0Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 14 Aug 2026 19:46:25 +0100
Subject: [PATCH] mm/secretmem: properly account locked pages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIBif2oC/yXMQQqDMBBG4avIrBswIYTaq5Qu4vjXTsFYMlEK4
 t0b6/JbvLeRIguUbs1GGauozKnCXhriV0wjjAzV5FoX2qv1RsEZZcJkIvO8pCJpNHEI0fvgut5
 2VNNPxlO+/+39cVqX/g0ux4v2/QfV5RAAeAAAAA==
X-Change-ID: 20260814-secretmem-accounting-ad6a44629b19
To: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Hagen Paul Pfeifer <hagen@jauu.net>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, ljs@kernel.org, Daehyeon Ko <4ncienth@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15136; i=ljs@kernel.org;
 h=from:subject:message-id; bh=yKRGInPGtch/R9cV3jJD5kNV2Fet094tcqzz3HDdJ4c=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLqk8X+NztMtTDtlVLerX7WfT3vnaxmhkLVjwmTfrHlf
 qu8m3uto5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABO5z8zIsCR8je7iFaISe34Z
 eU01/Dbp6Wd5szuX/shOuTLxn/g611OMDG8MtVaFJB65d/Dt3yTeKzLqgQ6yRkzpr77MuGsudFl
 gPSsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

secretmem has a relatively laissez-faire attitude to accounting the folios
it allocates.

The intention is that the memory is treated as if it were mlock()'d and
thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
is not in place (which broadly allows unlimited ranges of mlock()'d
memory).

The lifecycle for memfd accounting against this limit is - account on
map, unaccount on unmap.

But the lifecycle of memfd folios is allocate on fault, deallocate on inode
eviction.

This mismatch is problematic because the folios are unevictable and remain
so until the inode is evicted.

This is established using mapping_set_unevictable() setting the
AS_UNEVICTABLE flag in the relevant address_space data structure.

This is problematic as it eliminates usual mlock() semantics - mapping
folios then unmapping them does not clear their unevictable state, since it
depends on AS_UNEVICTABLE, not PG_mlocked.

This is checked by folio_evictable() which first checks for AS_UNEVICTABLE
before looking at PG_mlocked, which is cleared on unmap via
munlock_vma_folio().

A user can therefore easily work around the RLIMIT_MEMLOCK limit - simply
map then unmap and VmLck no longer counts the secretmem range, nor are they
accounted in the process's RSS even if mapped again, meaning the OOM killer
won't know to kill the process.

This can also be achieved by forking the process, as VMA_LOCKED_BIT is
cleared for VMAs copied to the child process, whose VmLck will be 0.

A user without the CAP_IPC_LOCK capability can therefore repeatedly
map/unmap (or map/fork) and consume all available system memory with
unevictable folios and cause system instability.

Worse, the OOM killer will not be able to resolve the situation.

Additionally, this fd can be passed between processes and over fork so a
per-process limit simply does not make sense.

There is precedent for addressing this issue - io_uring, perf, skbuff,
iommufd and xdp all perform the precise lifetime management required here
using an alternative method - tracking the number of locked pages in
struct user_struct->locked_vm.

Add secretmem to this list and account locked folios over the lifetime of
the inode to reflect the actual lifetime of the folios, while bypassing
this if the user has the CAP_IPC_LOCK capability.

As a result the semantics change - the RLIMIT_MEMLOCK limit is per-user not
per-process to reflect the actual scope of the allocated folios, and this
limit is shared between secretmem and io_uring, etc.

However this is reasonable given the need to track this limit in the actual
scope in which it applies.

Since GUP rejects secretmem mappings, setting VMA_LOCKED_BIT does not
result in memory being faulted in on map, another wrinkle with the mlock()
accounting.

This also leads to another oddity from the previous implementation -
mlock_future_ok() was checked on mmap() but since nothing is faulted in
right away, this check was more or less meaningless. Therefore drop this.

There is simply no reason to carry on marking the mapping as mlock()'d
since it's misleading and the lifecycle is now correctly handled, so remove
this too.

Additionally, fix the selftest which checks the limit as this now must
assert SIGBUS on limit violation on fault-in.

Also assert there that the limit applies to the lifetime of the fd rather
than the mapping by trying to map a single page past the maximum rlimit -
previously this would have succeeded as the prior unmap would have reset
the mlock limit.

__secretmem_account_pages() is essentially a duplicate of the code that
io_uring etc. use, but since this is a bug fix that needs backporting,
defer any de-duplication efforts to a follow-up.

Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gmail.com/
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/sched/user.h                |   3 +-
 mm/secretmem.c                            | 127 ++++++++++++++++++++++++++++--
 tools/testing/selftests/mm/memfd_secret.c |  87 ++++++++++++++++++--
 3 files changed, 203 insertions(+), 14 deletions(-)

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
index d29865075b6e..537fe5b1222f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -18,6 +18,8 @@
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/user.h>
+#include <linux/cred.h>
 
 #include <uapi/linux/magic.h>
 
@@ -47,10 +49,107 @@ bool secretmem_active(void)
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
+	unsigned long nr_pages;
+
+	if (!state)
+		return true;
+
+	nr_pages = folio_nr_pages(folio);
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
+	if (!state)
+		return;
+
+	__secretmem_unaccount_pages(state, folio_nr_pages(folio));
+}
+
+static void secretmem_unaccount_all_folios(struct secretmem_inode_state *state)
+{
+	unsigned long nr_pages_accounted;
+
+	if (!state)
+		return;
+
+	nr_pages_accounted = atomic_long_read(&state->nr_pages_accounted);
+	__secretmem_unaccount_pages(state, nr_pages_accounted);
+}
+
+static void secretmem_destroy_inode_priv(struct inode *inode)
+{
+	struct secretmem_inode_state *state = inode->i_private;
+
+	if (!state)
+		return;
+
+	secretmem_unaccount_all_folios(state);
+	free_uid(state->user);
+	kfree(state);
+}
+
+static int secretmem_init_inode_priv(struct inode *inode)
+{
+	struct secretmem_inode_state *state;
+
+	if (ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
+		return 0;
+
+	state = kzalloc_obj(*state, GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->user = get_uid(current_user());
+	inode->i_private = state;
+	return 0;
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
@@ -72,8 +171,15 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
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
@@ -82,6 +188,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
+			secretmem_unaccount_folio(state, folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
@@ -115,19 +222,17 @@ static const struct vm_operations_struct secretmem_vm_ops = {
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
@@ -192,15 +297,23 @@ static struct file *secretmem_file_create(unsigned long flags)
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
+	if (IS_ERR(file)) {
+		secretmem_destroy_inode_priv(inode);
+		err = PTR_ERR(file);
 		goto err_free_inode;
+	}
 
 	mapping_set_gfp_mask(inode->i_mapping, GFP_USER);
 	mapping_set_unevictable(inode->i_mapping);
@@ -218,7 +331,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 err_free_inode:
 	iput(inode);
-	return file;
+	return ERR_PTR(err);
 }
 
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index aac4f795c327..626e7033b72f 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -15,6 +15,8 @@
 #include <sys/resource.h>
 #include <sys/capability.h>
 
+#include <setjmp.h>
+#include <signal.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -22,6 +24,8 @@
 #include <stdio.h>
 #include <fcntl.h>
 
+#include <sys/mman.h>
+
 #include "kselftest.h"
 
 #define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
@@ -31,6 +35,7 @@
 #ifdef __NR_memfd_secret
 
 #define PATTERN	0x55
+#define MLOCK_LIMIT_CAP	(8UL << 20)
 
 static const int prot = PROT_READ | PROT_WRITE;
 static const int mode = MAP_SHARED;
@@ -39,6 +44,13 @@ static unsigned long page_size;
 static unsigned long mlock_limit_cur;
 static unsigned long mlock_limit_max;
 
+static sigjmp_buf fault_env;
+
+static void sigbus_handler(int sig)
+{
+	siglongjmp(fault_env, 1);
+}
+
 static int memfd_secret(unsigned int flags)
 {
 	return syscall(__NR_memfd_secret, flags);
@@ -57,10 +69,32 @@ static void test_file_apis(int fd)
 		pass("file IO is blocked as expected\n");
 }
 
-static void test_mlock_limit(int fd)
+/* GUP disallows automatic fault-in of secretmem, so do it manually. */
+static bool fault_in_secretmem(char *mem, size_t len)
+{
+	if (sigsetjmp(fault_env, 1))
+		return false;
+	memset(mem, PATTERN, len);
+	return true;
+}
+
+static void test_mlock_limit(void)
 {
 	size_t len;
 	char *mem;
+	int fd;
+
+	/* Locked pages have an inode lifetime, so need a new fd. */
+	fd = memfd_secret(0);
+	if (fd < 0) {
+		fail("memfd_secret failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (ftruncate(fd, mlock_limit_max * 2)) {
+		fail("ftruncate failed: %s\n", strerror(errno));
+		goto out_close;
+	}
 
 	len = mlock_limit_cur;
 	if (len % page_size != 0)
@@ -69,19 +103,48 @@ static void test_mlock_limit(int fd)
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");
-		return;
+		goto out_close;
+	}
+
+	if (!fault_in_secretmem(mem, len)) {
+		munmap(mem, len);
+		fail("unable to fault in secret memory\n");
+		goto out_close;
 	}
 	munmap(mem, len);
 
 	len = mlock_limit_max * 2;
 	mem = mmap(NULL, len, prot, mode, fd, 0);
-	if (mem != MAP_FAILED) {
-		fail("unexpected mlock limit violation\n");
+	if (mem == MAP_FAILED) {
+		fail("unable to mmap secret memory\n");
+		goto out_close;
+	}
+
+	if (fault_in_secretmem(mem, len)) {
 		munmap(mem, len);
-		return;
+		fail("mlock limit is not respected\n");
+		goto out_close;
 	}
+	munmap(mem, len);
+
+	/* map a page past the limit to assert inode scope. */
+	mem = mmap(NULL, page_size, prot, mode, fd,
+		   mlock_limit_max & ~(page_size - 1));
+	if (mem == MAP_FAILED) {
+		fail("unable to mmap secret memory\n");
+		goto out_close;
+	}
+
+	if (fault_in_secretmem(mem, page_size)) {
+		munmap(mem, page_size);
+		fail("mlock limit is not respected\n");
+		goto out_close;
+	}
+	munmap(mem, page_size);
 
 	pass("mlock limit is respected\n");
+out_close:
+	close(fd);
 }
 
 static void test_vmsplice(int fd, const char *desc)
@@ -292,6 +355,12 @@ static void prepare(void)
 	if (page_size > mlock_limit_max)
 		mlock_limit_max = page_size;
 
+	/* Clamp huge or unlimited. */
+	if (mlock_limit_max > MLOCK_LIMIT_CAP)
+		mlock_limit_max = MLOCK_LIMIT_CAP;
+	if (mlock_limit_cur > mlock_limit_max)
+		mlock_limit_cur = mlock_limit_max;
+
 	if (set_cap_limits(mlock_limit_max))
 		ksft_exit_fail_msg("Unable to set mlock limit: %s\n",
 				   strerror(errno));
@@ -301,6 +370,7 @@ static void prepare(void)
 
 int main(int argc, char *argv[])
 {
+	struct sigaction sa = { .sa_handler = sigbus_handler };
 	int fd;
 
 	prepare();
@@ -316,10 +386,15 @@ int main(int argc, char *argv[])
 			ksft_exit_fail_msg("memfd_secret failed: %s\n",
 					   strerror(errno));
 	}
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGBUS, &sa, NULL))
+		ksft_exit_fail_msg("Cannot set up SIGBUS handler");
+
 	if (ftruncate(fd, page_size))
 		ksft_exit_fail_msg("ftruncate failed: %s\n", strerror(errno));
 
-	test_mlock_limit(fd);
+	test_mlock_limit();
 	test_file_apis(fd);
 	/*
 	 * We have to run the first vmsplice test before any secretmem page was

---
base-commit: e737cebb8de0d38e8f64584a8bbfbcf9176c7537
change-id: 20260814-secretmem-accounting-ad6a44629b19

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

