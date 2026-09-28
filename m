Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E84485501;
	Mon, 28 Sep 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592944; cv=none; b=rraKNFRUL+yXwXXHfTo38TFmwFAMtH29Fd98IYgPGr1oIUvXspSpd3TsjdWfG/axZ/P+pw+DHYZvt5K8zT2bangXOtwujSr/pqoNGp/Crn7UsghDjAIqY+uFSuUGZGmaprbyczUnLJRidq/T9WCVxn9xNsO4WiJgNg26vHLWbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592944; c=relaxed/simple;
	bh=k2qltfQuAoZi3AGmJdybrRH9sbX0btd0g+se7aWhKNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjzbdZSMFpcoM63AF35z4V2i6euMNOtr90QpObvLiJ8ZDlA8w8ysHAi94Hvl5mrd/Svgp7IudZ/jw1Vi3j6YgxRUk9qNzwz43OEhhX8FuDV6eyxQjb5ZJgUcMQZiVUGlmBli4K5YKyBRHV/cQ6OuGETg62ZkE5zcGnTpfBsLwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0ryfBYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0ryfBYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3ED1F00898;
	Mon, 28 Sep 2026 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592942;
	bh=BNirgXH/aTMcKqGO2u604noXZU+mbKKvf6CCUw9ZJNU=;
	h=From:To:Cc:Subject:Date;
	b=Y0ryfBYL98DZHk6BuEVJZ30L0BkNUZRPRyW24gLZ3pvaoB/yT8HYGHkKMyUlnRoU+
	 ok8UR+3F1EqP8zJbqP+LKWh55ysmz9gUpFktce8j5qwjxpap0oKxzOZLyF57QYQ1nK
	 Vr0s4oOA7T/XMDzYWadsy2dHf8R+N+upBPxW2GWbsHjLc3zV1B5Fm/q2PoIz6FRe1R
	 U6IhE9FDFBSP4jN/X88KTGA1YUxmZZuqyMOJwJb74BDwTx+KWmJlxJxKdzMORZBxSQ
	 i5PadwksIwEZ1sxvDEdo+Lj3M0vSl4HPxzz7eL63o4Cv0IWqFpj2wnsWTJ90WLsJ5h
	 ekjqhUorDwZow==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Jann Horn <jannh@google.com>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiang Wang <jiang.wang@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Xingyu Jin <xingyuj@google.com>
Subject: [STABLE v6.6-v6.1 1/1] af_unix: Drop all SCM attributes for SOCKMAP.
Date: Mon, 28 Sep 2026 10:55:11 +0000
Message-ID: <20260928105513.3555368-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 965dc93481d1b80d341bdd16c27b16fe197175ee ]

SOCKMAP can hide inflight fd from AF_UNIX GC.

When a socket in SOCKMAP receives skb with inflight fd,
sk_psock_verdict_data_ready() looks up the mapped socket and
enqueue skb to its psock->ingress_skb.

Since neither the old nor the new GC can inspect the psock
queue, the hidden skb leaks the inflight sockets.  Note that
this cannot be detected via kmemleak because inflight sockets
are linked to a global list.

In addition, SOCKMAP redirect breaks the Tarjan-based GC's
assumption that unix_edge.successor is always alive, which
is no longer true once skb is redirected, resulting in
use-after-free below. [0]

Moreover, SOCKMAP does not call scm_stat_del() properly,
so unix_show_fdinfo() could report an incorrect fd count.

sk_msg_recvmsg() does not support any SCM attributes in the
first place.

Let's drop all SCM attributes before passing skb to the
SOCKMAP layer.

[0]:
BUG: KASAN: slab-use-after-free in unix_del_edges (net/unix/garbage.c:118 net/unix/garbage.c:181 net/unix/garbage.c:251)
Read of size 8 at addr ffff888125362670 by task kworker/56:1/496

CPU: 56 UID: 0 PID: 496 Comm: kworker/56:1 Not tainted 7.0.0-rc7-00263-gb9d8b856689d #3 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Workqueue: events sk_psock_backlog
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:379)
 kasan_report (mm/kasan/report.c:597)
 unix_del_edges (net/unix/garbage.c:118 net/unix/garbage.c:181 net/unix/garbage.c:251)
 unix_destroy_fpl (net/unix/garbage.c:317)
 unix_destruct_scm (./include/net/scm.h:80 ./include/net/scm.h:86 net/unix/af_unix.c:1976)
 sk_psock_backlog (./include/linux/skbuff.h:?)
 process_scheduled_works (kernel/workqueue.c:?)
 worker_thread (kernel/workqueue.c:?)
 kthread (kernel/kthread.c:438)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
 </TASK>

Allocated by task 955:
 kasan_save_track (mm/kasan/common.c:58 mm/kasan/common.c:78)
 __kasan_slab_alloc (mm/kasan/common.c:369)
 kmem_cache_alloc_noprof (mm/slub.c:4539)
 sk_prot_alloc (net/core/sock.c:2240)
 sk_alloc (net/core/sock.c:2301)
 unix_create1 (net/unix/af_unix.c:1099)
 unix_create (net/unix/af_unix.c:1169)
 __sock_create (net/socket.c:1606)
 __sys_socketpair (net/socket.c:1811)
 __x64_sys_socketpair (net/socket.c:1863 net/socket.c:1860 net/socket.c:1860)
 do_syscall_64 (arch/x86/entry/syscall_64.c:?)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Freed by task 496:
 kasan_save_track (mm/kasan/common.c:58 mm/kasan/common.c:78)
 kasan_save_free_info (mm/kasan/generic.c:587)
 __kasan_slab_free (mm/kasan/common.c:287)
 kmem_cache_free (mm/slub.c:6165)
 __sk_destruct (net/core/sock.c:2282 net/core/sock.c:2384)
 sk_psock_destroy (./include/net/sock.h:?)
 process_scheduled_works (kernel/workqueue.c:?)
 worker_thread (kernel/workqueue.c:?)
 kthread (kernel/kthread.c:438)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:258)

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Fixes: 77462de14a43 ("af_unix: Add read_sock for stream socket types")
Reported-by: Xingyu Jin <xingyuj@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260415184830.3988432-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Lee: Drop skb_orphan() from unix_destruct_scm() and omit the
      unix_stream_read_skb() / unix_dgram_read_skb() hunks as
      69bbe2bcbe8c and d92fbaccd09a are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/af_unix.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8bd78cad69e7..e1f798af1a8a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1854,16 +1854,19 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 
 static void unix_destruct_scm(struct sk_buff *skb)
 {
-	struct scm_cookie scm;
+	struct scm_cookie scm = {};
+
+	swap(scm.pid, UNIXCB(skb).pid);
 
-	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
 	scm_destroy(&scm);
+}
+
+static void unix_wfree(struct sk_buff *skb)
+{
+	unix_destruct_scm(skb);
 	sock_wfree(skb);
 }
 
@@ -1879,7 +1882,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	if (scm->fp && send_fds)
 		err = unix_attach_fds(scm, skb);
 
-	skb->destructor = unix_destruct_scm;
+	skb->destructor = unix_wfree;
 	return err;
 }
 
@@ -1940,6 +1943,13 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
+static void unix_orphan_scm(struct sock *sk, struct sk_buff *skb)
+{
+	scm_stat_del(sk, skb);
+	unix_destruct_scm(skb);
+	skb->destructor = sock_wfree;
+}
+
 /*
  *	Send AF_UNIX data.
  */
@@ -2516,10 +2526,16 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	int err;
 
 	mutex_lock(&u->iolock);
+
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
-	mutex_unlock(&u->iolock);
-	if (!skb)
+	if (!skb) {
+		mutex_unlock(&u->iolock);
 		return err;
+	}
+
+	unix_orphan_scm(sk, skb);
+
+	mutex_unlock(&u->iolock);
 
 	return recv_actor(sk, skb);
 }
@@ -2673,10 +2689,16 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -ENOTCONN;
 
 	mutex_lock(&u->iolock);
+
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
-	mutex_unlock(&u->iolock);
-	if (!skb)
+	if (!skb) {
+		mutex_unlock(&u->iolock);
 		return err;
+	}
+
+	unix_orphan_scm(sk, skb);
+
+	mutex_unlock(&u->iolock);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

