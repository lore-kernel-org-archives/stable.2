Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CB486BB2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333380; cv=none; b=OHxOjW19hlevkAXV2ukiODBmA185zBEY9J5Yk31wbEDeGHRoZANMkX+uBdyCv7/q/givzU1el8zd2qtT4PHpkmGKWsYdKHkbPztyFzoecWyyvh9M1B9EuJrNbKEQC/jyS9BP60b2GxuNp3i/rqUdPwFTqnITpZjg92nVe+mht3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333380; c=relaxed/simple;
	bh=XpmeuNTU6Fjtq1EJNFIQwuYOtGAUJBzryUkV97zkIBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z5R55cnL6fnQoA2UsvTcAlFaFWDSACCkVikHWAK+BTFCpHQBgOf0GlWbpM9qHeBrwkmAUmFweq03HRvZllsvYnZS/lDBtFClAEOscq25CA/jKVVyBTU5BuL/YUfcKA6IeFC9JXAKqEzJk6+mbdT4txZa7hmCAxz0GBDcuxsNT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k84mQaIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k84mQaIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FEB1F000E9;
	Wed, 29 Jul 2026 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333374;
	bh=7fV9kauLF4HFC3tk2ikYf2mltMdf8qi2SN6xQPbAX0c=;
	h=Subject:To:Cc:From:Date;
	b=k84mQaIj6KuHOGUqrwnv1Jn5M3hhP7k3qOvBXw2pW5MORRfHaXrL17VD7jFZs8pXi
	 wSH1BKrnFuCuXpOHTyq7w04PRF1gW3u0IEevHZSkMTvIr/htgyOGF4hELXT2o2QfrP
	 iMufOOUJ/b93c13nrSD5XbVvVL/frnenOKhODehw=
Subject: FAILED: patch "[PATCH] eventpoll: pin files while checking reverse paths" failed to apply to 7.1-stable tree
To: 2045gemini@gmail.com,brauner@kernel.org,qjx1298677004@gmail.com,tpluszz77@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:56:01 +0200
Message-ID: <2026072900-revisable-showroom-1b81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8b7e8245e2293078f657521236ac92c045552e5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072900-revisable-showroom-1b81@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b7e8245e2293078f657521236ac92c045552e5a Mon Sep 17 00:00:00 2001
From: Guidong Han <2045gemini@gmail.com>
Date: Sat, 18 Jul 2026 18:44:06 +0800
Subject: [PATCH] eventpoll: pin files while checking reverse paths

Commit 319c15174757 ("epoll: take epitem list out of struct file")
intentionally removed temporary file references from the reverse path
check list. At the time, both epitems and their files were freed after
an RCU grace period, so unlist_file() could obtain file->f_lock through
an epitem while clear_tfile_check_list() held rcu_read_lock().

Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
RCU still protects the epitem, but no longer keeps the referenced file
from being freed and reused. A concurrent close can therefore make
unlist_file() lock or unlock f_lock in a recycled file object.

This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
reference before acquiring an object's lock. The race was reproduced,
causing a wild unlock of f_lock in a recycled file and breaking its
mutual exclusion.

Add ->file to epitems_head to remember the pinned file independently of
->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the head
is unlisted, leaving no epi->ffd.file from which to drop the reference.

In list_file(), acquire the reference before adding the head to the
check list. The caller either owns a reference or holds the ep->mtx for
the epitem leading to the file. In the latter case, file_ref_get() can
fail after the last reference is dropped, but eventpoll_release_file()
must acquire the same mutex before the file can be freed. The dying leaf
can be skipped because removing links cannot increase the reverse path
count.

In unlist_file(), epnested_mutex excludes another list_file() or
unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL from
freeing the head. Save head->file locally, clear it with head->next
under f_lock, and drop the reference after the RCU-protected operation.

Christian Brauner <brauner@kernel.org> quotes:

> SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU reader
> still holds its old address. Once that address contains a new live
> struct file, KASAN sees valid, unpoisoned memory and cannot distinguish
> the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
> instead.
>
> The failing interleaving is:
>
> CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
> ------------------------------------   ---------------------------------
> p = hlist_first_rcu(&head->epitems)
> epi = container_of(p, ...)
>                                        close(victim)
>                                          __fput()
>                                            eventpoll_release_file()
>                                            file_free(victim)
>                                        // the slot is free; f_lock remains
> spin_lock(&epi->ffd.file->f_lock)
>                                        open() reuses the slot as new_file
>                                          spin_lock_init(&new_file->f_lock)
> spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's lock
>
> CONFIG_DEBUG_SPINLOCK reports:
>
> BUG: spinlock already unlocked on CPU#0, poc_unlist/150
>  lock: 0xffff8880067fb200, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
> CPU: 0 UID: 1000 PID: 150 Comm: poc_unlist Not tainted 7.2.0-rc3-dirty #22 PREEMPTLAZY
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x64/0x80
>  do_raw_spin_unlock+0x75/0xb0
>  _raw_spin_unlock+0xe/0x30
>  clear_tfile_check_list+0x88/0xe0
>  do_epoll_ctl_file+0x519/0xcf0
>  ? __pfx_ep_ptable_queue_proc+0x10/0x10
>  do_epoll_ctl+0x8f/0x100
>  __x64_sys_epoll_ctl+0x6f/0xa0
>  do_syscall_64+0xdc/0x520
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x42034e
> Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 e9 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007a657ff3c198 EFLAGS: 00000202 ORIG_RAX: 00000000000000e9
> RAX: ffffffffffffffda RBX: 00007a657ff3ccdc RCX: 000000000042034e
> RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
> RBP: 00007a657ff3c2f0 R08: 0000000000000000 R09: 00007a657ff3c6c0
> R10: 00007a657ff3c1a4 R11: 0000000000000202 R12: 00007a657ff3c6c0
> R13: ffffffffffffffb8 R14: 000000000000000d R15: 00007fffb7de0210
>  </TASK>
> ------------[ cut here ]------------
>
> unlist_file() does not appear as a separate frame because it was inlined
> into clear_tfile_check_list(). This report was obtained with mdelay()
> instrumentation immediately before spin_lock() and spin_unlock() in
> unlist_file() to widen the two race windows.
>
> More importantly, this is a wild unlock. The stale unlock can target
> f_lock of a different live file and invalidate mutual exclusion for
> state protected by that lock. Turning this into a reliable exploit
> would require precise scheduling and same-slot reuse and is likely
> difficult, but the primitive is potentially exploitable.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Junxi Qian <qjx1298677004@gmail.com>
Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
Link: https://patch.msgid.link/20260718104406.27897-1-2045gemini@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0e65c7431dfc..eed8cecd94e3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -459,11 +459,14 @@ static struct kmem_cache *pwq_cache __ro_after_init;
  * Wrapper anchor for file->f_ep when the watched file is not itself an
  * eventpoll; for the epoll-watches-epoll case, file->f_ep points at
  * &watched_ep->refs directly. The ->next field threads
- * ctx->tfile_check_list during one EPOLL_CTL_ADD path check.
+ * ctx->tfile_check_list during one EPOLL_CTL_ADD path check. The ->file
+ * field holds a reference to the associated file while the head is on
+ * the list.
  */
 struct epitems_head {
 	struct hlist_head epitems;
 	struct epitems_head *next;
+	struct file *file;
 };
 
 static struct kmem_cache *ephead_cache __ro_after_init;
@@ -480,6 +483,16 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
+		/*
+		 * The caller owns a reference to @file or holds the ep->mtx for the
+		 * epitem that led here. The latter blocks eventpoll_release_file()
+		 * before the file allocation can be freed and reused. A dying leaf
+		 * can be skipped since removing links cannot increase the reverse
+		 * path count.
+		 */
+		if (!file_ref_get(&file->f_ref))
+			return;
+		head->file = file;
 		head->next = ctx->tfile_check_list;
 		ctx->tfile_check_list = head;
 	}
@@ -489,15 +502,18 @@ static void unlist_file(struct epitems_head *head)
 {
 	struct epitems_head *to_free = head;
 	struct hlist_node *p = rcu_dereference(hlist_first_rcu(&head->epitems));
+	struct file *file = head->file;
 	if (p) {
 		struct epitem *epi= container_of(p, struct epitem, fllink);
 		spin_lock(&epi->ffd.file->f_lock);
 		if (!hlist_empty(&head->epitems))
 			to_free = NULL;
 		head->next = NULL;
+		head->file = NULL;
 		spin_unlock(&epi->ffd.file->f_lock);
 	}
 	free_ephead(to_free);
+	fput(file);
 }
 
 #ifdef CONFIG_SYSCTL

