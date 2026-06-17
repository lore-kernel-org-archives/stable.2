Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0193C3441
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683105; cv=none; b=D8o1ubAgN0o1r3gtIk+vUJJfTPHzNJ895uX4pkn1uOVUV77/4HXmIpWIUhMnlQN0/cBHgl3Fgb2c91qihCSRlgehwKXc3/7IMK6xlGCPv5DJvbT3LXda84k4oIt4R9J6EfLNBUtxs/73b+h5dauGjiie2l0QDj1g7N4HU6k2UiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683105; c=relaxed/simple;
	bh=MTSLF1i0SVm8X/ceHYU7vQaIB21106ApW03KPotEA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEznLe9mvQPMf/0CYij0UEC3MKe8xvGdSJ8VPUenGtB6NXWGpaU2WCCpxli9mXFrhyHNVGfhtcSDt7KTBiyuhwGDsLI2NIS4uZ9L5HWXifOIj7K8gtFrA7LhmisO/ahs/D6DUDKPM+XN10ZI4N+narF+ojlEugun3qfpL0snAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Z7cfZc0p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Z7cfZc0p"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso5993405e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781683101; x=1782287901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFkTCzH0bW/6eaucGKv1hofGcpDdZG/dUw+kXhlNjkA=;
        b=Z7cfZc0p7HcuUKcqjg38xCst1q2S2KB4isXkNp9AsFDhtkc38gCp6q62Obq3M+NKFj
         54lH1rgdR1SlrfYMqXFcuJuBoLRKPnRjFmX+gxp9LvlqaNR2BC5RisA0T1wdNaUTHOM2
         tAXSJKR4QFxehLJjtDYnSz1x3TxvsOPDH7Y9Pf68SK5fTa+cbqTI5TxVhzFeCrZOp07U
         owHp5HOEFnVVy/8gI0+iX2PzJzk3vvn/dkH5x7H75S22bQPLsiyPrSOVpodT1azc/3VL
         5u1jOciqut5CVzo13hrGUql2ypf/ImbjoEjm3yMAUxi3rFvXncmtjwCn35cYTuT+52hi
         rdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683101; x=1782287901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFkTCzH0bW/6eaucGKv1hofGcpDdZG/dUw+kXhlNjkA=;
        b=V1n9bJ2pBOM7KhKlrrXMNYpmt6SIgk84SXrYjNEi9c9z7ZXAuAUscteNInkT5YNt+f
         fRrqxVcVpGSe02j231tphZy3vEhGXRxZZ4JakqTW1wzL55Rcry1QvE1t4Mpeyxtj58N8
         lMw9H6aPOQ48vpaDXfzxFthLMutZc3NT2q9eUIKSjq2jhn8rkvFAAiW4XoQXOWILDcNc
         XJCI6Axt0qG00Gi2/Itatfe2KZUgN2WGVEqT3Bb8ubVNjcrV6YOV2JI2h57suDqj+2U4
         hnriyoTEU1nEmQ9mw8x9YfgOLjOXBlQO/spc3aoBIlDdAzGCoaA4iyChnHq9D0wE6u+k
         UqAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hbHu4lvmdGBKt/YEIFxOEw8JE62xsCBvHFCcW8jF66nxjAOoftIHC9Bue5FBSkqTodsYn1TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XDpMpqZGESrYolb/zzJtAgw036w63Onb1NfOEKQZcO/5uo85
	juK1IWMuKH8bljhqec9n3ftqLDw5mOxfLox/ccBJnGhb9kVQsL9MGfH4xGXJd9OuEoyP
X-Gm-Gg: Acq92OHbKfDOeqzccZW7LEEq9B90cZez4g3/a/eq80j9apEeiTQPfoliXIqeBicfgdT
	HJx8WxzojfQVLcBEw23kO/brq7KNB/GCHgx2NRJE3k9ArjmjMjkDtBbSD5jGNazVDWo0+khot7k
	YO/hzZEJ5of1MmtRVWr+Wsf9TS/bpmsKzCU0ZGXKb3hNpHvV/6hlRzQYKjIGAmPHcuM9QpOxRac
	gZjy6rjQj1E4FTUgt5Rwc3W5xwXnoYU1C57oDGzCXINAI4z8oo1jHJxzn8xVPKh4To2jNVsc689
	3AN25NK+ju0gaCKw/DOJ/qqxqwbTiEH8UcL/XiuiQBQ3Fqf6GdHOf72ZJT+8amsjQS+weNYEyAa
	ZkXU6T2IxddrUzCGdlnOSsV2wn8anSB5qaUq6o/6RWBFJCGt/3vf5/7oSxser09zkInyvqnaDlj
	2eCrsa1XY8uaiu4PNYOo1Fy1XiOdEP3LENy5OCqeOjmasYimq3EumhLHcPvWidvKFp3GGUoXOKR
	asymZJcSpXurI88cWfsu5BGxrX24433Re8=
X-Received: by 2002:a05:600c:4f83:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-492340e763emr23901315e9.9.1781683100362;
        Wed, 17 Jun 2026 00:58:20 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa5120esm150707715e9.8.2026.06.17.00.58.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 00:58:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jmaloy@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	tung.quang.nguyen@est.tech,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v4] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Wed, 17 Jun 2026 09:58:18 +0200
Message-ID: <20260617075818.37431-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_aead_decrypt() goes straight from tipc_bearer_hold(b) to
crypto_aead_decrypt(req) without taking a reference on the netns, unlike
the encrypt path. When crypto_aead_decrypt() is offloaded asynchronously
(e.g. the SIMD aead wrapper queuing to cryptd), the cryptd worker runs
tipc_aead_decrypt_done() later. If the bearer's netns is torn down in the
meantime, cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() frees the
per-netns tipc_crypto, and the completion then reads it:
tipc_aead_decrypt_done() dereferences aead->crypto->stats and
aead->crypto->net, and tipc_crypto_rcv_complete() dereferences
aead->crypto->aead[] and the node table -- reading freed memory.

Decoded KASAN splat (v7.1-rc7, CONFIG_KASAN_INLINE + TIPC + TIPC_CRYPTO):

  BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done (net/tipc/crypto.c:999)
  Read of size 8 at addr ffff8881056258a8 by task kworker/u16:2/51
  Workqueue: events_unbound
  Call Trace:
   tipc_aead_decrypt_done (net/tipc/crypto.c:999)
   process_one_work (kernel/workqueue.c:3314)
   worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 169:
   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
   tipc_crypto_start (net/tipc/crypto.c:1502)
   tipc_init_net (net/tipc/core.c:72)
   ops_init (net/core/net_namespace.c:137)
   setup_net (net/core/net_namespace.c:446)
   copy_net_ns (net/core/net_namespace.c:579)
   create_new_namespaces (kernel/nsproxy.c:132)
   __x64_sys_unshare (kernel/fork.c:3316)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  Freed by task 8:
   kfree (mm/slub.c:6566)
   tipc_exit_net (net/tipc/core.c:119)
   cleanup_net (net/core/net_namespace.c:704)
   process_one_work (kernel/workqueue.c:3314)
   kthread (kernel/kthread.c:436)

This is the same class of bug that commit e279024617134 ("net/tipc: fix
slab-use-after-free Read in tipc_aead_encrypt_done") fixed for the encrypt
side. The encrypt path takes maybe_get_net(aead->crypto->net) before
crypto_aead_encrypt() and drops it with put_net() on the synchronous
return paths and in tipc_aead_encrypt_done(); the -EINPROGRESS/-EBUSY
return keeps the reference for the async callback to release. The decrypt
path was left without the equivalent guard.

Mirror the encrypt-side fix on the decrypt path: take a net reference
before crypto_aead_decrypt() (failing with -ENODEV and the matching
bearer put if it cannot be acquired), keep it across the
-EINPROGRESS/-EBUSY async return, and drop it with put_net() on the
synchronous success/error return and at the end of
tipc_aead_decrypt_done().

Reproduced under KASAN on v7.1-rc7: a UDP bearer with a cluster key is
flooded with crafted encrypted frames from an unknown peer (driving the
cluster-key decrypt path) while the bearer's netns is repeatedly torn
down. The completion must run asynchronously to outlive
tipc_crypto_stop(); on x86 the stock aesni gcm(aes) now decrypts
synchronously, so the async path was exercised via cryptd offload. The
unguarded aead->crypto dereference in tipc_aead_decrypt_done() is the
unpatched upstream path; tipc_aead_decrypt() still lacks
maybe_get_net(aead->crypto->net), so the completion can outlive the free
on any config where crypto_aead_decrypt() goes async.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v4:
 - Use the net parameter for maybe_get_net()/put_net() instead of
   dereferencing aead->crypto->net, which is the per-netns structure at
   risk during teardown (per the automated review forwarded by Simon
   Horman). net == aead->crypto->net here; no functional change.
v3:
 - Rewrite the changelog with the decoded stack trace and frame the
   reproduction on the current tree (v7.1-rc7); drop the v6.12.92
   references (Tung Quang Nguyen).
v2:
 - Add Cc: stable@vger.kernel.org and Alexander Lobakin's Reviewed-by.
   No functional change.
 net/tipc/crypto.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 6d3b6b89b1d1..16f1ed1f6b1b 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	if (!maybe_get_net(net)) {
+		tipc_bearer_put(b);
+		rc = -ENODEV;
+		goto exit;
+	}
+
 	/* Now, do decrypt */
 	rc = crypto_aead_decrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(net);
 
 exit:
 	kfree(ctx);
@@ -984,6 +992,7 @@ static void tipc_aead_decrypt_done(void *data, int err)
 	}
 
 	tipc_bearer_put(b);
+	put_net(net);
 }
 
 static inline int tipc_ehdr_size(struct tipc_ehdr *ehdr)
-- 
2.43.0

