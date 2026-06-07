Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408172F361E
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866085; cv=none; b=F/3/CMq+W8nADqFI5R0kmJ1rotXaAcOYMSw65G91Fo44IlwZ+2aR8R1a5uHn+AgrVrDJLWha6oFvHu7Ius5+TjqCscYKPLoxJx86drPw7gK0i0hXDGI8z3WeFCH6W53syF+3oBmU19qFnNlL0eAz6js40xZBUTnsC6kHVl6CJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866085; c=relaxed/simple;
	bh=cvyOcjhtMlvvFxqMsah19NK9zcmo5fvDbymjyWwBqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INuVZPLjtqKMUGNKWCXqCdctGwpaZEOfHn4X0UMkYEOX08ELaYixhr3ranxUBglR3xjVRFRrVmCKDGuWUaqfbqBdzsonY4C7pphNPoqptO8vK/g8jgjUEjOTXbj9YSEjQJVh17xMST6zeX+CenMI4CghKsx28mmL77+y4AgiiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZICtpup9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZICtpup9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a7629453so3613535e9.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780866083; x=1781470883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuWhUU666YoCkcgjw3YuQ/NERV8K0Y26bfg0NnK3PCM=;
        b=ZICtpup9fHGT/Om+JcLOpWNhN6g1UvQR+qApKh4wXClQbt29+kubA6XKC9kmuEMAxD
         5nY2k4jFmnxTvrXUYp+XEuK2wNeIp2wPaR2vKgSq6BQ2qbEDGSraACWyIsoIVw5ATfaT
         gDbEWq6f0YhZCjTwyEoClRG9/y1uohp7WLRLCTIpCYmrWrQ0AzEfSJDj5EGMZqonJezc
         OmRfQWmpA11hk9My4Uj2YBjPgCA/qH8U6qcw9FHeKAhw22LRx73UUKekIQ0RmANGw5qW
         MLisEp2qQ/5H96i7wh2H/Zv86Th/uHblABFDYOhBjs2iUA4gxxn3uTznVVG/5xdz3ERR
         rwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780866083; x=1781470883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuWhUU666YoCkcgjw3YuQ/NERV8K0Y26bfg0NnK3PCM=;
        b=W1xbqh3R2PlnYiRrQD/whvqvKyluaciB7W/Cc3ZfqmRZrJIJBm1NJjPgrkL1Gh52vi
         0nAxXhv1C5bAUpCOUCBLIfh5PZWVcnuCsyMfX6V9UEIt8SGCyz552U/VaYNbqHOB3PWy
         9U6SwYDWgM7PLW89dkfVyCuGhD5rYKOlXwpS4HnxMhI4U/zBV/djFG0sUnceW50Z5w6K
         DJUNBC2ICCjdZDpZClIUjoI5bdNwZg+5mXWjoOJGESCT0t7NoAZVRqwXVQki4RxPqLKI
         D24MUAcwmkzbyIrRatEO9aWfnhya2ok0x5ONXcbVz5odJfbAWQfLGgR/8gzKm7bt17eZ
         70CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K1+3Cp5CRm1jeuUer3PGAElpHl4hnLapb+3YWXt6jZrxbKz/mGLIVMliYgZrDn7BD7+ZhC50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZYl2ZBP+jFM7okRc54u0/PS2+psR72r1BkkhwN8iHJv9jZqP
	Jp4IXYvXbL0GY8RcHDIjOVPzEZ/f/HBKnJyq+SH9LcaCIy2nVBrQGOVN
X-Gm-Gg: Acq92OH24hg9hACDkS9/97QSR0cb1FIwb0o7gA6pr98byqfoMcX7mzzx+FX9Wz+RNgU
	PkdeXsx1EpfOYuu1NlhMpXX0OhBloI6OetBjQXVSIfimGlkMbjToaw1FGh2/AYNJFKkkEg/nu1m
	bRkF0rz5M907PaVok3/Y5JgQ9yCs3/C/WI+KCpvQuMDFCYIYOksuHu4YbrkvJaRAIHgvyCH58Nv
	DS5LgVw6I+Em4EaKa1VMmmpzH1dtLVe9us/5QULW1cT747ZH7UDcZRPe8JMNmIICk/Cm+Nsk6DG
	xJyidx52SkYe2anAHG817/i8COFYVkL39WRaJhI0zRDCoafHCbj88au/BNw1xhlD7VOxTB5b46C
	7//Rj1U4lcpd4I0k8LSAEy8yjDLLvHK2CX3ypaq61ULJgjt0dKwMDgEVC/m+GJCXPndNdeHQ7rk
	xGj04DKuwvolhxNLhyevg+UCi9RYUSo27qMbJP12DmA0y31v69nHl6Rvc0cXrCX4TOi34PueMr1
	Ok6t3YUkP4ZdK57ew==
X-Received: by 2002:a05:600c:3551:b0:490:b71f:2eb with SMTP id 5b1f17b1804b1-490c26220b7mr90247955e9.7.1780866082417;
        Sun, 07 Jun 2026 14:01:22 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm47940617f8f.28.2026.06.07.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:01:21 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Your Name <yzjaurora@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: af_key: initialize alg_key_len for IPComp states
Date: Sun,  7 Jun 2026 14:01:17 -0700
Message-ID: <20260607210119.2437752-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Your Name <yzjaurora@gmail.com>

pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
allocating x->calg and copying only the algorithm name:

	x->calg = kmalloc_obj(*x->calg);
	if (!x->calg) {
		err = -ENOMEM;
		goto out;
	}
	strcpy(x->calg->alg_name, a->name);
	x->props.calgo = sa->sadb_sa_encrypt;

Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
the same function, the compression branch never initializes
calg->alg_key_len.  IPComp carries no key and the allocation only
reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
is left containing uninitialized slab data.

calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
IPComp state is cloned during XFRM_MSG_MIGRATE:

	xfrm_state_migrate()
	  xfrm_state_clone_and_setup()
	    x->calg = xfrm_algo_clone(orig->calg);
	      kmemdup(orig, xfrm_alg_len(orig));

where xfrm_alg_len() returns sizeof(*alg) + (alg_key_len + 7) / 8.  With
a non-zero garbage alg_key_len, kmemdup() reads past the end of the
68-byte calg object.  Adding an IPComp SA via PF_KEY and then migrating
it triggers (net-next, KASAN, init_on_alloc=0):

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x44/0x60
  Read of size 4164 at addr ff11000025a74980 by task diag2/9287
  CPU: 3 UID: 0 PID: 9287 Comm: diag2 7.1.0-rc6-g903db046d557 #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x10e/0x1f0
   print_report+0xf7/0x600
   kasan_report+0xe4/0x120
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x23/0x60
   kmemdup_noprof+0x44/0x60
   xfrm_state_migrate+0x70a/0x1da0
   xfrm_migrate+0x753/0x18a0
   xfrm_do_migrate+0xb47/0xf10
   xfrm_user_rcv_msg+0x411/0xb50
   netlink_rcv_skb+0x158/0x420
   xfrm_netlink_rcv+0x71/0x90
   netlink_unicast+0x584/0x850
   netlink_sendmsg+0x8b0/0xdc0
   ____sys_sendmsg+0x9f7/0xb90
   ___sys_sendmsg+0x134/0x1d0
   __sys_sendmsg+0x16d/0x220
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 9287:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0xaa/0xb0
   pfkey_add+0x2652/0x2ea0
   pfkey_process+0x6d0/0x830
   pfkey_sendmsg+0x42c/0x850
   __sys_sendto+0x461/0x4b0
   __x64_sys_sendto+0xe0/0x1c0
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ff11000025a74980
   which belongs to the cache kmalloc-96 of size 96
  The buggy address is located 0 bytes inside of
   allocated 68-byte region [ff11000025a74980, ff11000025a749c4)

Depending on the uninitialized value the same field can instead request
an oversized kmemdup() allocation and make the migration clone fail.

The XFRM netlink path is not affected: verify_one_alg() rejects an
XFRMA_ALG_COMP attribute shorter than xfrm_alg_len(), so a calg added via
XFRM_MSG_NEWSA is always self-consistent.

Initialize calg->alg_key_len to 0, matching the aalg/ealg branches.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18..3216f897a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1218,6 +1218,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				goto out;
 			}
 			strcpy(x->calg->alg_name, a->name);
+			x->calg->alg_key_len = 0;
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
-- 
2.43.0

