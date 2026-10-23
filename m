Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767648;
	b=uL+1XKYP0MPfGz8dEeiQATx6VVJ1RX9nIeR37FOhNkodY02c01TiOPgx8DxMQCxH0Yk7
	 pzjCYbX/OZe/L4af3NRGTpJ2nrmKqbEkzL9OPbL00PlghoQhbdrBE/M1qm7Le3Fl1JvkC
	 BZK7YBqMIiSlyLSpG9LT+Ni2x6Zw5fqQ5pncJzOCGnrn74WZa5D/MWsFuXB/hfnzhVSfF
	 Wfx5DIsPl+LQOXXJeE/vcJAOlNw4mn7LwJ4S+LXTRks3CPWccZi21bHqbjL4HLGczqQWu
	 4AFwdeWIYMZrvRwRlIwL74I+QY7AcR/pGM+QuFi0stk9TPz4viq8HVjMMW9UJcTgMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767648;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1cGbL1tfVHtvj8sZrOWH+MPb01DqaMLDrPMvrw1f+Sk=;
	b=XLmlxqElWk5vaF+KzjsA8aAhNHlM061kDyhUZkDnf3jzG4O7oT4BMonxj1Mg4dFVKENX
	 VXV45jDbhW7Yf4vT7ZDPnSQqYfyO/9pUSy7zno6FRpMZfGULddOx/IJ4W592Xntyg8jxD
	 lQLyeGbQdYVrvQqWV36D7KRTX8LLUULWzxXXdhmmJDGq/nx2kqQIb0jQNWbSErqK/I4wh
	 EDoHdc7+CiW6vS0fMnEIZ6jx4HQ3noj/oyCI8tbSCj7qoSQNxlhBO0KIlMeSF1yNMp+BJ
	 NxLPwEHYyvbn+C1zynykQmfEUCOj8tNovLKzQpQF3hCQUVpC68ThJ2oTGYcWL+K8qKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=B2tTUowt;
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (mail.netskyway.net [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D07606A31D;
	Fri, 23 Oct 2026 15:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D07606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=B2tTUowt
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF83E3001B0;
	Fri, 23 Oct 2026 12:00:39 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1792767640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=1cGbL1tfVHtvj8sZrOWH+MPb01DqaMLDrPMvrw1f+Sk=;
	b=B2tTUowtU4kkxBIlAXhOf/pP5Ph2TfO6QS+txZlNTXqxUoxuRMhyA9EGeSnQ636Yl8Pz5e
	R7w+Bdt5RpQ9vvEMyxPvFe/ctTm9lgJgA5MVXz7HwAlyEGSyUvhPEU+QbJWP34KFcayewG
	PyVkO3150pB4Bw76KPQ7DyjzUqzVVMok9IhhHNgsw3lhyMq2PTCFU2clyHmOvtLwzxvbVp
	I/kRh7FCG0DAr5nq3kqDJvyySm7OkaKWAtKacanTGWv9iWvJ4REEhA0xB4fqdBnYQBGEkl
	ubPep4AASUWVjjbE8iNnMdOXHEXHOn+gQJtQm2lKW2NgFF6vXVO4mGgTbsfA3w==
Message-ID: <7fa31470-872a-4fb8-9c8f-51dce38e9190@auth.ink>
Date: Fri, 23 Oct 2026 18:00:34 +0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: kuniyu@amazon.com, lee@kernel.org, netdev@vger.kernel.org,
 Rodrigo Zaiden <rodrigo.zaiden@canonical.com>
From: Tamir Awad <security@auth.ink>
Subject: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Content-Type: text/plain; charset=UTF-8; format=flowed
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
@@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void 
(*func)(struct unix_sock *),
              /* Process the descriptors of this socket */
              int nfd = UNIXCB(skb).fp->count;
              struct file **fp = UNIXCB(skb).fp->fp;
+            struct unix_sock *u;

              while (nfd--) {
                  /* Get the socket the fd matches if it indeed does so */
                  struct sock *sk = unix_get_socket(*fp++);

                  if (sk) {
-                    struct unix_sock *u = unix_sk(sk);
+                    u = unix_sk(sk);

                      /* Ignore non-candidates, they could
                       * have been added to the queues after
@@ -122,6 +123,13 @@ static void scan_inflight(struct sock *x, void 
(*func)(struct unix_sock *),
                  }
              }
              if (hit && hitlist != NULL) {
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+                u = unix_sk(x);
+                if (u->oob_skb) {
+                    WARN_ON_ONCE(skb_unref(u->oob_skb));
+                    u->oob_skb = NULL;
+                }
+#endif
                  __skb_unlink(skb, &x->sk_receive_queue);
                  __skb_queue_tail(hitlist, skb);
              }
@@ -299,17 +307,9 @@ void unix_gc(void)
       * which are creating the cycle(s).
       */
      skb_queue_head_init(&hitlist);
-    list_for_each_entry(u, &gc_candidates, link) {
+    list_for_each_entry(u, &gc_candidates, link)
          scan_children(&u->sk, inc_inflight, &hitlist);

-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-        if (u->oob_skb) {
-            kfree_skb(u->oob_skb);
-            u->oob_skb = NULL;
-        }
-#endif
-    }
-
      /* not_cycle_list contains those sockets which do not make up a
       * cycle.  Restore these to the inflight list.
       */
-- 
2.56.0.windows.2


