Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185379;
	b=0kqfHzWmCZ7d3Iv24jz1eaD+uxSfnYIKl1VBsI/52qUhCzaZaGL+jBv9ni609P5Z7CFr
	 lBmj1l0pJ75+N/xNHMmEE6PPMDhRWX6Zq9NeUbXFqNVyIUnQXBj5Qa1YkIz98G+jHGIJ+
	 boyKBysVo60hX9nRIA8OWS0VhSHGXj0aU3Myn7N7gRLhPq0JnfjZ0WAz3LNJxHos29OvW
	 haO7rjKIolyj9Aa+AAcoBDeQktrvd6b9OFZd45FeprBVGZuiaWDhcPxYjP1F58clSt4G/
	 hq5yUdhqOYAoLGWXWxJl3d4+yHwpJNG0MAxCspVeopqItvIr2XvtzXjd7xztkcdcrRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185379;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=pdpL3sSHlMHK0Bo+huRWtAzQa54MaEYpMlhgZA+5qtA=;
	b=WhmUh9PpfFUH1mhHzoCvkQjewc2wzBqMhqNl2TxeWQZ4gcUII+8r4+rYS0kT6q/o9sST
	 VVxYudzRrlZ/hSZr1VPqeH7H/5s1LBLpV7DnB4HmRZjaiiTq4gZOjaOdTt6peLUc8zEDx
	 zHLT7RlvYB3tGc6ycNox9qkgsua4QIL7WcAarTEs8mPc8Nt6+HobYY2FcbNCyIWnU5fJI
	 KSQdmnXC2jCuN+WbsykgUSu0x57t3g8f+bKe9ll+lLIxsp68gchnokEmUsipaMnyLUtQT
	 b+KxuZd+nVmdDG8iSS00z+sMk4LZasmtFHHuQW9L4ueD4/VMeRkc3OQdp7ONveinBDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=YHdeU0R5;
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (mail.netskyway.net [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AF606A31C;
	Mon,  9 Nov 2026 00:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=YHdeU0R5
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF5DD30A2A3;
	Sun, 08 Nov 2026 21:49:24 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1794185366; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pdpL3sSHlMHK0Bo+huRWtAzQa54MaEYpMlhgZA+5qtA=;
	b=YHdeU0R5ShqohxbtrcsCp2qy+LdXsxNyQLlInVbtQ1yEFVVaGakDZBdxBFSMNOZTHOnE63
	WiGmy/rfumI03B0uUJmS9omS3KFUa6sNKIWsKkkR1yUoxqd0K5dxuHiAj0CAuBjLVtaacJ
	kVnjwHdeNhykNwd2BQlWNlPqbJa/GtzlzbXbGzBpw7neiEWqvftqtpvIwjGUnmoIyvEZ5r
	oj2crMmJymkS7+6frTgXj6yXQwml80YSJo0TO9RB9glMPzugIyDhRGMQMzMXTXE4oa7RtS
	yWdUJydTy2aY8W70dQd7YNN+RrrhNYOG4PiXIHmg+3Dy7vXEiHiozkqx3prm5w==
From: Tamir Awad <tamir@auth.ink>
To: sashal@kernel.org,
	kuniyu@google.com
Cc: stable@vger.kernel.org,
	lee@kernel.org,
	netdev@vger.kernel.org,
	rodrigo.zaiden@canonical.com
Subject: [PATCH v2 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Date: Mon,  9 Nov 2026 02:49:23 +0200
Message-ID: <179418529889.10436.12048717656065553331@auth.ink>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <2026-11-08-1-daily-reply-0011-af-unix-5-15-v2@kernel.org>
References: <08E5C4C3-189B-4B0D-94F5-5C049EAF6DA8@auth.ink> <2026-11-08-1-daily-reply-0011-af-unix-5-15-v2@kernel.org>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Kuniyuki Iwashima <kuniyu@amazon.com>

unix_gc() accesses oob_skb after dropping sk_receive_queue.lock. This
can race with queue_oob(). Clear oob_skb in scan_inflight() while the
lock is held.

This resends Kuniyuki Iwashima's March 2025 fix for the old GC. The
code diff is unchanged.

On 5.15.223, the reproducer panicked three unpatched QEMU guests. Three
patched guests completed 8,000 rounds each without a kernel warning.
Both builds used the same config and guest image. An instrumented run
traced the harness's failed racing sends to EPIPE and ECONNRESET and
confirmed all 8,000 iterations reached the race.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Link: https://lore.kernel.org/all/20250304030149.82265-1-kuniyu@amazon.com/
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Tamir Awad <security@auth.ink>
---
 net/unix/garbage.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d2fc795..a733d0d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			/* Process the descriptors of this socket */
 			int nfd = UNIXCB(skb).fp->count;
 			struct file **fp = UNIXCB(skb).fp->fp;
+			struct unix_sock *u;
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
 				struct sock *sk = unix_get_socket(*fp++);
 
 				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
+					u = unix_sk(sk);
 
 					/* Ignore non-candidates, they could
 					 * have been added to the queues after
@@ -122,6 +123,13 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 				}
 			}
 			if (hit && hitlist != NULL) {
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+				u = unix_sk(x);
+				if (u->oob_skb) {
+					WARN_ON_ONCE(skb_unref(u->oob_skb));
+					u->oob_skb = NULL;
+				}
+#endif
 				__skb_unlink(skb, &x->sk_receive_queue);
 				__skb_queue_tail(hitlist, skb);
 			}
@@ -299,17 +307,9 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
+	list_for_each_entry(u, &gc_candidates, link)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
-			u->oob_skb = NULL;
-		}
-#endif
-	}
-
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
-- 
2.56.0.windows.2

