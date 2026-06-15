Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E9212F89
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523987; cv=none; b=Fppn14xNGY44uGjdtJqZ9bxE5Ktdudfn7jI/KknWv+EskuTT2tG2gIyr5BTHh6w6pflIC6MMPC+Lsi9MwEk8eqUP5q/Wnm1VS9knqmYBOR7Z0Y6qKUgLZa8Z/Vb331rCr5TsIpWhgjzW/rGUR4cVrMlFB+BmtCuCBHGujEWKUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523987; c=relaxed/simple;
	bh=2bQGxVUZ9MTPf1QkyzYPrKWsuFsxCujrar5IyTh0Oi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2qYYkwPD/WhOq85oqDdmIWel40b8ox3KxA5albAkAoK+RuD2rzU8TuPZzUMUFllr+6+vMi0ZQ97Dhlcl8wlpZPiTkxhAVcHPedl3ZQSXgEf2rnKo5R5wbLkMMG9bGpjcNF6w7Hm181LldosZn9Fa4GqVsbjJ0fig/e4RNz1OcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=mhpO0K3H; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="mhpO0K3H"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b9318997so23114735e9.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781523983; x=1782128783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jEKzIBUOghNkvDTiM29+zsP3vkJkDD0mPoUSzkRcsQ=;
        b=mhpO0K3HZ2ZSwmb6umjVEf6bbJFuKXL3cx3AszmYxxQZotchT41kuof7xar2hYwxvh
         0l8zytrGOgthdJH0fj68NMIFHlQlmb5I7vUqHqU6XjAlQ18CaUOKWJBt/TGX4pTNdrFi
         BfLUHN6KtEp7EqzfxFHQi+FHpGH+QE7MpDmrj9wq5TwYHHXegBZZ0DH3zr90fG8UeRHT
         eWeUhEY6BC4nBC5Vn065Gw8Oiwpa/CU28iPsbhT8hfeb6zOwneyzEqgHaJyPKdYHUmPG
         0VSGYJIdaTOVAFRqwBaZwpwS10Mbety/Qu/bfeyzIsLqo4NtRMf0bDwD9R27p/qaIfhA
         BL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781523983; x=1782128783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jEKzIBUOghNkvDTiM29+zsP3vkJkDD0mPoUSzkRcsQ=;
        b=E+5CiGhPuTndX4cAsKY/Gq18oR70gXPsFxFpFNbiqf8O+cKKuHsBGqag5vvycbi7Ex
         F9R66+aXeH5i/CxUQHrlrbiSpG0rC2N2dSZ5MpVfIHAmvu4ZNk7uTwsW9YidE2EA3Ewq
         0rEd+soFiPcOuyvUJ4hXvps+pJ8UtFiJN2IFcpyxWCqOc32EjmmsSsyvNEeJVM5Et6KD
         HIF/Mxb5U3H6cI4OJutkLj0Mn4oAYtrI0s8ZlYEEFC9BQRHc2yHwmx7VgMc/8s2lJlCw
         Z7yBcGbB86MFwXKWHVLmpP848N2IJ1pHd0/psE5fjC5r6+8GE3hhBHSOoVQK5I7Yr8CW
         4N9w==
X-Forwarded-Encrypted: i=1; AFNElJ8HKl2sRhV1ZUL5L5ckOmx6ZvfKsb+S5sqY9ovq/bjSpZD4yLGdXCff3bgR3F5Hp0AlvVmvFew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1JTAMAEnCAVUlvgqSBl7BBVyakhk0/uwySpbkombwESNBzpI
	spm44rPHbcmgFMbKq/balklXKf6K2Gl/0H1BpTZQbDkL0cyBPmQKRLKwTIAxwVbNx/OA
X-Gm-Gg: Acq92OFqtyHBCmAimMPRxLcVOH0/svovKrf+qqT958x2JlDlnhb8uid4Cx3uuY3rTKg
	p+Rz4sexbufkA4F/CK8nt1cI25JJq+Jy0AJE4VTDZqYPXSr8Jn2BBxR1wVxKMtM++hGWD7/iQ/6
	uA4QnuEnTVZOrHD8p6ERQF6P8z/0++XZYDyXB/BBf2FgG3WGczxERKMqy/5Xwmet+ua1I/XkeN6
	ib9yBsmj4cuawNgbmQIJwqt/3M7St7x2dvNwMIvfRpn4lBE7kDiM4IUgzIAMDXh0J9r+XxFoTvB
	sNr5s0sxAjnXf2HLOXm+mnYdSf6HeWbszT18Z8rahyFWtNJ6JLWSQwjPRTIenbzh+5UqyOGhtwp
	ldqYsyuTlY56plt25la4lGlAe9r4lw0QN9uG34Jpw4U9kbTDZxCfSLJRxfFd6OzHQpIjAbWf7xD
	381IQgUXM8ekuWI0lRmwDHNine3A/Wm48Hw8pu4+wJ6UkH5L4Js0GQbK3Q/9++/m9pnHXsQ7tys
	Y5peM81+a3ZAWIK0qoOvPN+K/vCBuWhstsAr9AeOWtd9Q==
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-49220093459mr95390895e9.15.1781523982724;
        Mon, 15 Jun 2026 04:46:22 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220207efesm212347605e9.0.2026.06.15.04.46.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 04:46:21 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jmaloy@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v3] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Mon, 15 Jun 2026 13:46:18 +0200
Message-ID: <20260615114618.71249-1-doruk@0sec.ai>
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
---
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
index 6d3b6b89b1d1..84a6489da036 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	if (!maybe_get_net(aead->crypto->net)) {
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
+	put_net(aead->crypto->net);
 
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

