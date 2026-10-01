Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D84AB3B4
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845420; cv=none; b=iZDTMMnzoigdih4PffQ6BtIlCpQRUplJU1lCFeb4bfX6sLabtVg8UMnANOO+PTerjH0PPwvmtkdxsb3583rGxlfoIm68KSnQHZoiuc7wMiZVZYIqne6GtSRXGHDHrynEyx3LrKkI8yUPcoGxEb60NWDHAHkOZ5HEDDYVJ7HK5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845420; c=relaxed/simple;
	bh=cWV8CxZaIBy2RZjoAuBHJTAdku+3e+cjJG1NcZuUCek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E6NGbMtcDJ0V/SChp7XeOcT71jIE+VikBORq6CN2fjBc0fVyfNjG6MY/J5T+GG7fhcxFoGnU6fWJnNENHzK6M/vYd7rbgpJ/PdqIK8/qmdrzqeNyGogTRFPxZBKFv4xpwuttwBTJvQaVqr5FIf/xtu8qlM7AJV175S9OAJZ7UtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WtP+euU5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WtP+euU5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 46C464E410EA;
	Thu,  1 Oct 2026 09:03:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1829860341;
	Thu,  1 Oct 2026 09:03:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67F85103297EB;
	Thu,  1 Oct 2026 11:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790845415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rJqWg2cc4njNGBfNS6KT7A7x5vgwKPeNZ8eDnvxuLAk=;
	b=WtP+euU5w0fCpRS6Gd6+dn1FAkqE4a4UsIMQKTsvdD7qdNxJa84rw+Errn8YlA/DYi96kc
	szklfUTeXam4ztQlPRgRgwoFr0xM435wEBR+ggbmRsG8D0v1clJzmFKbDqMPLc7SXHcT38
	hv+QYYMP+t/eMtzQYIUzkcnd0K3Pf7jHREpNeq7mtPSkIj2Rfd6973VtwDRdIKYULHQAZR
	jq+l8QRbkTEV5aiPEkPNnwvmtZ4a0jQQlXUbZjwvpOeIW2hS5g8zm157O5xixNrPrSbebQ
	am/vjkqWhl4ttdk371Ul13sUgRByAucY8HrFgQmj4n3ULhFxWOhyXySUnAu9eg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Thu, 01 Oct 2026 11:03:26 +0200
Subject: [PATCH 6.1.y] af_unix: Drop all SCM attributes for SOCKMAP.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-cve-2026-53005-v1-1-c247eff5d3b7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3bJbg2IvorxQNtV1wOaVgmE8
 O4WPX6TzL8gazLNOFULko6W7TkUyK5CuPfDTcliMRy7VpiFwqi0gZo9c0O+k0MXj97F2KOcXkm
 vNv2CZ7S11DMu/zl//EPDe4thXb/GIinseQAAAA==
X-Change-ID: 20261001-cve-2026-53005-b8178d9b2dda
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Cong Wang <cong.wang@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiang Wang <jiang.wang@bytedance.com>, Andrii Nakryiko <andrii@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
 Xingyu Jin <xingyuj@google.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790845407; l=5962;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=lKr5PMQ/qqIbiAflZ0JKsqF7uQp7V9UKCCXMP09veJQ=;
 b=G2+/3FQKFlHmH7SzIw2DfIWaC1BqVWlYjwJ1PP0UdttEVSZKwCTQ+WMuUSJmIZqS0pvOs7NZw
 WPtwASW2xhJB3iJdpYeZWUv+QNVncK+7cmhR0qOccQaukn+6RE/fL2I
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

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
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/unix/af_unix.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a4fa3c279a46..72c6ef640af9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1784,16 +1784,19 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 
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
 
@@ -1809,7 +1812,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	if (scm->fp && send_fds)
 		err = unix_attach_fds(scm, skb);
 
-	skb->destructor = unix_destruct_scm;
+	skb->destructor = unix_wfree;
 	return err;
 }
 
@@ -1886,6 +1889,13 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
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
@@ -2557,10 +2567,16 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
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
@@ -2749,6 +2765,8 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 #endif
 
+	unix_orphan_scm(sk, skb);
+
 	return recv_actor(sk, skb);
 }
 

---
base-commit: 1a8763b93150b2c8f3992c27a5ce7857fee4ab0f
change-id: 20261001-cve-2026-53005-b8178d9b2dda

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

