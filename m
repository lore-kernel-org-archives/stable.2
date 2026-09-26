Received: from mail-dy2-f23.google.com (mail-dy2-f23.google.com [74.125.229.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C86374E5A
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445868; cv=none; b=a3QivA+vl759bWVqbGSzQSx1APJG8JAiymjQZV7bvFooshst/ZIMtmyFA8ei9tYroj/ruKoBqtWAouNa0Y572xqswP1AzLdixPKTCr8kNliIHJHqfNpm6yAa6crBUU491RNjJo1aMfdDSkOGm2qzVTWPW086a5HBh5bK+7xPqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445868; c=relaxed/simple;
	bh=2zVps6AYrWAiY9ULKun6/agXQ3ENzQcWHEgAv4h9mPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZftulZv8+LeQ8ZT/FQaSK0eyW2N7v3tedYDcoqXU+rfS2fJZR9rE8oi7qHmx2b6t/GWXT/ryUhXDGTI8Q/VetH1PYOMHXJVZFgSoPKq1VONIjLbTD1/6mm3zKT4zE8d+uGoX8kYOFsC8GDSDbRKgHQiqoXDutx4MNh/4MFbLlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8Hh36KQ; arc=none smtp.client-ip=74.125.229.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8Hh36KQ"
Received: by mail-dy2-f23.google.com with SMTP id 5a478bee46e88-32be7127c64so209976eec.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790445866; x=1791050666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kHluweKfZpb/IlLJvDMNI0ICAGK++39Oi731e5BjCgQ=;
        b=d8Hh36KQIM5dQiSiSt6ZWvxwv8bA82YxwChJoHWpHhk1MMcNidnumefY9Tt9FYIkiz
         wv7hCOsCLVWTU8o+AOwXTDPREsqCnqYHtL7fbKesEK420mvTZyUxD9uQw5ZVBxuxPgg0
         I/FJhFI/GOFbqXL8funJbX2ZYlzhSsfaBuPVc4tbDnaYdIsgN7qGnQg0wxKqPHiyXWln
         MSjT3NMkYYZ8jXH64oULms2hm2ffeOoGk0fQZxCUvIPrEv5ZhZ71GkJQNuOxpMN4e2do
         hTd5yeo/XUvU5LnR3NppccxuB/+OBIuS1BOvjM4oYJrmJWZGXCFs/WHs5WWsC+DAnZQy
         Qlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445866; x=1791050666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHluweKfZpb/IlLJvDMNI0ICAGK++39Oi731e5BjCgQ=;
        b=cQNRYkTJvu7gnIH+B9ufE16BZsXtVqR8unWa9kgKE+FBGFa7RDnEOPfCjZYcZMuCHW
         eBklPU1bah242yPl1IF41X4bgSz8aBDt4HWDWWRJlqgicIzcVMBdb/MmOp5+EC1Ar99w
         /SIpiE2GoLh67qe3DanSXVXy/4GNrbHDYfUImeKfn51f4NkSoD7YSJV2Hdj575Zm8NTb
         ORHGfOZUpTPRZeFA6puHWr2ZKK/lGUDI16wNIq/uMGP6I61f+E972CDQVd84oJwq7Gdh
         n7/iTcUOPAuTXemEg7KnurtfrxVvUAbngVkx/hsN7HdkC4JfSAX39fSKDM+1wgkqNc2Y
         QD+g==
X-Forwarded-Encrypted: i=1; AKwUvBwjJTMObIp46U5mYuFPwkrdAdY4KJB16XtJskDsyMK/+1NT7FnrzPAf+8v3Mgm87kvJ1fjax9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgOo05s+u9MGnL4MHrsxvUWN55rGMmvBQLxI6bYqADJqqAr3Q3
	97WnWIGK56dNsZnZoLe8SvMbYTq8+V0BlQtsP0dlP0zt1AEbx3JNEjtx
X-Gm-Gg: AYBFou05Li7Cg2YHKcyDkJcCr+JLW0gUBlZBzqk8SKVg5jpfXtHEnnXc/vjg4u6TXIm
	FXdd7me8AuBVNo7fQllXih3/DFvMCFW800J+Q3x3w2VdpxlPRgIO7FZ60w1dBYvKNO0VULqSU19
	MkIPvKaaYp8lMDmcZ6ecvLdaVxrYxIFQHSgNxcxmrgPM6y6EM2+Po0YRMJEjwBOGt+36AlxlqZG
	NbbJ+NBl4D7O6MYOqFCp6KrodugxT4C62ajJSME+QezWBh/3Qhz65ImTMwLVrCLcAdjZ1m841D3
	44JAqjL9HU/AmgXi7yDJm2xzW33xyZAytWep4v9GzaAnn8sS716DkfZnHx9DfCXKS+83A9ydW4e
	V5pqueevNzHPS8ktUMaLkemja4jTOrpyqQs6dsjKQ+TW7hZA6SMdC637wj8J3xZy5UGZQccDIua
	fl821SRRyDwaJsskwzPddtqgwvppyPbRrP8gzYCehIiW6waC/30WNrkiiA4fXOmWiPyMGRO/w2/
	CPNamhaTPnZnLcE4driFinxtD9GefDhqmX7NvjyJiVkGZlLJ/HYS9lwl4qmOKvMMSxY9g==
X-Received: by 2002:a05:7301:b0e:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-3426cce6521mr5523221eec.0.1790445865269;
        Sat, 26 Sep 2026 11:04:25 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341463ec3ecsm16542044eec.31.2026.09.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:04:24 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: protect clcsock lifetime in smc_getname
Date: Sun, 27 Sep 2026 02:04:04 +0800
Message-ID: <20260926180404.2721010-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_getname() dereferences smc->clcsock without holding
clcsock_release_lock. Link-group termination can release the CLC socket
through smc_close_active_abort() while the SMC socket is still open,
for example after shutdown(SHUT_WR).

A getsockname() caller can load smc->clcsock, then the termination worker
can clear the pointer and call sock_release() before the caller accesses
clcsock->ops or invokes getname(). This causes a use-after-free; if the
worker clears the pointer before the load, it causes a NULL dereference.
The syscall's file reference keeps the SMC socket alive but does not
prevent asynchronous release of its CLC socket.

KASAN reported:

  BUG: KASAN: slab-use-after-free in smc_getname+0x19e/0x1b0
  Read of size 8 at addr ffff888109abb4e0 by task poc/103
  Call Trace:
   smc_getname+0x19e/0x1b0
   do_getsockname+0xe5/0x170
   __sys_getsockname+0x8c/0x100

  Allocated by task 95:
   sock_alloc_inode+0x1e/0x280
   sock_alloc+0x3d/0x240
   __sock_create+0x7e/0x430
   smc_create+0x121/0x240

  Freed by task 0:
   kmem_cache_free+0xcc/0x340
   rcu_core+0x50a/0x1850

  Last potentially related work creation:
   evict+0x446/0x6c0
   smc_clcsock_release+0xa8/0xd0
   smc_close_active_abort+0x26a/0x3a0
   __smc_lgr_terminate.part.0+0x137/0x2e0

Hold clcsock_release_lock across the pointer check and the getname()
callback, as the socket option handlers already do. Return -EBADF if
the CLC socket has already been released, preserving the existing peer
state check and the callback's return value otherwise.

Fixes: b03faa1fafc8 ("net/smc: postpone release of clcsock")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/smc/af_smc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e9f93b3ab435..8b3ee70f8433 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2784,6 +2784,7 @@ int smc_getname(struct socket *sock, struct sockaddr *addr,
 		int peer)
 {
 	struct smc_sock *smc;
+	int rc = -EBADF;
 
 	if (peer && (sock->sk->sk_state != SMC_ACTIVE) &&
 	    (sock->sk->sk_state != SMC_APPCLOSEWAIT1))
@@ -2791,7 +2792,11 @@ int smc_getname(struct socket *sock, struct sockaddr *addr,
 
 	smc = smc_sk(sock->sk);
 
-	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock)
+		rc = smc->clcsock->ops->getname(smc->clcsock, addr, peer);
+	mutex_unlock(&smc->clcsock_release_lock);
+	return rc;
 }
 
 int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
-- 
2.43.0

