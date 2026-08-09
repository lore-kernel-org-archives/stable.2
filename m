Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890261AA1D5
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236497; cv=none; b=KDvbCeAyF71u2eHY3ouGyEHB1WHy+Jrk6PkYR51fTvCwt1OWsnODlnM4WjWNTmn6mqdk1suxkqULOTSGOj/OGRLwFlIubO26hF7UpZeJ1Je+3IZtRJ2koJkw4J6rqnxy2v2vRrBHlpNyakLFZ+dsidcUUeUvZYljMYSLt9CFTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236497; c=relaxed/simple;
	bh=m12YWAFrNnU9vrkTfs4RTtQicFYZMkVKBssjqdNYd78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY9vVa1DpMLgByROsvhjvAQG/3jg1V4lZe7ms1oWcPQEgCGEEIov2BZjsvN8Ze85gfyITYILNQpHm0Mv8/EHFB42BjBUFl4Nc9e+LHBPvsfqAxgwHGMY8UUPkaNzeSzH0IVBnxLJsHyV7oplIha7LD3jUKGqD24guZglp8q/1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAtPWX9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAtPWX9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACED1F00A3F;
	Sun,  9 Aug 2026 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236496;
	bh=Z4uUYMTZL89G4jlO1igFFLdaOoOU1/pMLHscnKkidQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hAtPWX9d3IXC02mZdyVw9lfQq5buQn509SX53IUXykVcLoSA/VQq2duXTfADRsol1
	 12PCQ5U5b6mBzAITiAYkRmQiY8YFiP6+fpsYvvONvaY5vvJk/MLWqEWwWd9QLohc9V
	 710iAlMmsZUFdIaNm5/z3gSCPoxmm24FKUpWTsFTeONev9nCv/b3QVhgUCmjBI82ai
	 9MiIdQUkfdxBpoE7sQsqaDgFTZNrp/s3xBhzz1V/OR9KISAWq2ueVjs50PkSF2IIoc
	 A/WVr5RThMC2f8l8Q2Azoyxd5zUJj6mlmSnKTMrvyMEsKvYeqpvqNGxxdozMUu7Yfv
	 F2d3J20JvxYOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guidong Han <2045gemini@gmail.com>,
	Qi Tang <tpluszz77@gmail.com>,
	Junxi Qian <qjx1298677004@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] eventpoll: pin files while checking reverse paths
Date: Sat,  8 Aug 2026 20:48:13 -0400
Message-ID: <20260809004813.874894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072903-exact-prototype-2cfe@gregkh>
References: <2026072903-exact-prototype-2cfe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guidong Han <2045gemini@gmail.com>

[ Upstream commit 8b7e8245e2293078f657521236ac92c045552e5a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5a19edda2b777..665a1528ab579 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -404,11 +404,13 @@ static struct kmem_cache *pwq_cache __ro_after_init;
 
 /*
  * List of files with newly added links, where we may need to limit the number
- * of emanating paths. Protected by the epnested_mutex.
+ * of emanating paths. Protected by the epnested_mutex. The ->file field holds
+ * a reference to the associated file while the head is on the list.
  */
 struct epitems_head {
 	struct hlist_head epitems;
 	struct epitems_head *next;
+	struct file *file;
 };
 static struct epitems_head *tfile_check_list = EP_UNACTIVE_PTR;
 
@@ -426,6 +428,16 @@ static void list_file(struct file *file)
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
+		/*
+		 * The caller owns a reference to @file or holds the ep->mtx for the
+		 * epitem that led here. The latter blocks eventpoll_release_file()
+		 * before the file allocation can be freed and reused. A dying leaf
+		 * can be skipped since removing links cannot increase the reverse
+		 * path count.
+		 */
+		if (!atomic_long_inc_not_zero(&file->f_count))
+			return;
+		head->file = file;
 		head->next = tfile_check_list;
 		tfile_check_list = head;
 	}
@@ -435,15 +447,18 @@ static void unlist_file(struct epitems_head *head)
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
-- 
2.53.0

