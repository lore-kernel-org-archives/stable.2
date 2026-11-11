Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412948;
	b=LI6SOiCNk/WPwmoZE7wLHxgn31/LaSCsMgn7E3yrVd1FF5b0ae3Lez82qBYspzXcHq0/
	 rIfw+dtrj3+5X/sFL6DfzsGtJeQDQxJRs84o4Jct8TGFF4VorTkRIuGuhbgnxKCWEaEt7
	 arimwciznskzWmA+gbZ3uq7mFGDOTI0xQp3Jp8HXPlwqIMbietC20LxCl48NGfdO4y4or
	 fdlSf5Dn2NafoXYtmalhuGPBszaQaR/ckWTSME/cNmZ7gkNdCwNrtUM/Ve8Z/uAZ+EYLk
	 nyyUVoZrxd/4PnbX1pU5d6VeEVhDIZSxD5MXV5nP5F0zQUSQRof6snlBwX9j+3PhzCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412948;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=WokhbsrTFc2NsHpEugw+0dMzXBQ004WHE6KXS5ikNyc=;
	b=FGgmLBFMvlSufHisl3pGz8c3vRuwLAyuVSFdNgz/wV7KzV/Fu859iJzNSBzYYXF8rOUl
	 jRBcr+5nNly4KBIsSOjUjqJmeIWDBZONCGHmlU8HP003Mi3n2aye9lEtv5j4Z6Ohpa/8R
	 gRH2W0WLK62gJnJep4dvjHLrTtxIZpCvye2p8M/yI/RmHwoBrSdggLYjmoKTyXsk9H+vR
	 0w6aCy7ahveU4zknkK0b3HtqWJZoLIsO5RGSRrb3RXEQH02yamFe/lpHv5Tz7lOVeQzu8
	 NfTIq7r2Za07P7nx03ysg95R4hMWokVgS6k4gUhwUgf5W9742IsqbKczhZdBws1p4MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=N5D0I8G0;
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (unknown [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5C606A32D;
	Wed, 11 Nov 2026 16:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F5C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=N5D0I8G0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8760630A2FE;
	Wed, 11 Nov 2026 13:02:08 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1794412931; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WokhbsrTFc2NsHpEugw+0dMzXBQ004WHE6KXS5ikNyc=;
	b=N5D0I8G0QMiIngQffgzUl0ze0LjcwhXcJ8HgWudmE1xMqukZW45EsniiwMqVP6nR9VG3AB
	RC1upKz3QWXaIJsNO/2X9Zsod9hUAUo9luySLJzdCbzl9QI89DRUjLpOUbQIpVxR6GYhkA
	py1cJH9x1M8nk+Vfw5qPx8zWNDrwBQFO3oY2IMdttJ4k9m+2sjKd7wPwA0UjekfmqPTF0Y
	62lnPNaUL5eBlQSBrHcBlFIbNp4XXecvXmePlvQk9QgwcQxPzLuH/qduCwwasoQXT5lnb5
	0tG3yI01jB24CHVMM61Eui4uIuveWUatkxqN3l4nv1Bdjfd73IoijhevoYbVLQ==
From: Tamir Awad <tamir@auth.ink>
To: sashal@kernel.org,
	kuniyu@google.com
Cc: stable@vger.kernel.org,
	lee@kernel.org,
	netdev@vger.kernel.org,
	rodrigo.zaiden@canonical.com
Subject: [PATCH 5.15.y v3] af_unix: Clear oob_skb in scan_inflight()
Date: Wed, 11 Nov 2026 18:02:07 +0200
Message-ID: <179441291360.3032.12248522121219232932@auth.ink>
X-Mailer: git-send-email 2.56.0.windows.4
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

Embryo socket is not queued in gc_candidates, so we can't drop
a reference held by its oob_skb.

Let's say we create listener and embryo sockets, send the
listener's fd to the embryo as OOB data, and close() them
without recv()ing the OOB data.

There is a self-reference cycle like

  listener -> embryo.oob_skb -> listener

, so this must be cleaned up by GC.  Otherwise, the listener's
refcnt is not released and sockets are leaked:

  # unshare -n
  # cat /proc/net/protocols | grep UNIX-STREAM
  UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...

  # python3
  >>> from array import array
  >>> from socket import *
  >>>
  >>> s = socket(AF_UNIX, SOCK_STREAM)
  >>> s.bind('\0test\0')
  >>> s.listen()
  >>>
  >>> c = socket(AF_UNIX, SOCK_STREAM)
  >>> c.connect(s.getsockname())
  >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
  1
  >>> quit()

  # cat /proc/net/protocols | grep UNIX-STREAM
  UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
                        ^^^
                        3 sockets still in use after FDs are close()d

Let's drop the embryo socket's oob_skb ref in scan_inflight().

This also fixes a racy access to oob_skb that commit 9841991a446c
("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
lock.") fixed for the new Tarjan's algo-based GC.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Link: https://lore.kernel.org/all/20250304030149.82265-1-kuniyu@amazon.com/
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Tamir Awad <security@auth.ink>
---
This has no upstream commit because I replaced the entire GC in
6.10 and the new GC does not have this bug, and this fix is only
applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.

This resends Kuniyuki Iwashima's March 2025 fix for the old GC. The
code diff is unchanged.

On 5.15.223, the reproducer panicked three unpatched QEMU guests. Three
patched guests completed 8,000 rounds each without a kernel warning.
Both builds used the same config and guest image. An instrumented run
traced the harness's failed racing sends to EPIPE and ECONNRESET and
confirmed all 8,000 iterations reached the race.

Changes in v3:
- Restore the original commit explanation and socket leak reproducer.
- Keep resend context and validation results below the separator.
- No code changes from v2.

v2: https://lore.kernel.org/netdev/179418529889.10436.12048717656065553331@auth.ink/

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
2.56.0.windows.4

