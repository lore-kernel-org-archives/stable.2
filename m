Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53291382295
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287362; cv=none; b=bgsRTNohl9JKji2qhtHpstReVJd7f7HI6A3Nd8o1SfenmDUiHNAGopcO7jaFaUJf2RTT83BRYSPIQrNN1aClvhIHsPD6W9T7Eh6mRnyprr1YIyJvrUxUktLz9eaCAwjzcnOLlni2UplBRjd/tu7ljwWUqUfRsFr5bcbMCBJtKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287362; c=relaxed/simple;
	bh=0p1lONg7gWSDyn5khXuVfzBo4NRo1p2TyqdXQOjbbVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLnyQqoPPD41Mt6h9GhpmAX9V1AvsHJYn9Kku1TcNnlFS3YsJApf42hVJU21ls7GaiyI3OB7qn+KyiW8nnCdT1tQESe4mCS7V10gwRKjYPlDBlcHIn5FIYXF+5erUDg2VkNgG4e6KLz+IKJI9MpFxu3Q5t0CYutNKDFqPQ0kN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=H+A5nh5x; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="H+A5nh5x"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caed617615so7038095ad.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787287360; x=1787892160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5dxDVgLX0SEoeONy6U5yRnXtU3RWgoGHdVL5Bj5+l9A=;
        b=H+A5nh5xBiL2WcpCNqfc4rPb15CIVWenG6wh/oul7EcUSVoOE9mXKDZHyBwUE8xc1t
         Q/uGmdYVKJdMTeHB5bPxFbaXVige1toEnH5RI41RHmE4UuNo5KFPEghgA5UgiC76wm/6
         S7VEEE9n+HP+GGvHQHvRDgI/HzMHnaonpEyevdggMv3hrbeFQmuh9Ea7ZWbjooGrnCf/
         NGCWtSLp258ugGCS0j7IrEXGx8YLv6uGtbMtg0QHdBqot6UxW4kqiYuw4XOUcst6MAlO
         u4eZU9QKvXkL2aNUxlEJI469xYdhmrxZ4cH8pA3K6DJNg0xCJsilm4JPGRSd38msrObz
         9rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787287360; x=1787892160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5dxDVgLX0SEoeONy6U5yRnXtU3RWgoGHdVL5Bj5+l9A=;
        b=KnI9ClfiuakxsGr6Sb1qhQ9dne8jREMwFIqC/tVyEH75eJHGLRay0Jx7C2He5yYkqg
         e9SAFyawMQD129qY8qNW6Bkk7KDA1a4NxcpKc8KdS58lq9HIso/0Ajiloh9dyvkBCOmS
         v+hW8gOboHxjbnWXnmrX95QKnofh4zCz5Lgg7LJS+faGwOHTN1IKtOXRaB13a+ZY8QUi
         JabizrTB0ZvtNEocpdcOoGr8ps3qilwZJccZ7NtmPdxedAsWULH2YKbSWrlmB8bwX0Sr
         eDxZGe8ul2ALvHHqEy0BrpciGZ38gzJ9eHiu9P8pKcRMaRV9v6ahNo4WYPYRiCNhY1oi
         invg==
X-Gm-Message-State: AOJu0YzTxgGyYVATujIe5/YKywTFdmW/iBTJbzWxsXJEvZt4OVv81/0f
	kMy2xA/dRGCuHSxF3L11CauD0ohm/nhisq3h3Y8ehUpvwp0rWNfcPbId37m0iN2IjdrWex3vquj
	hd07A
X-Gm-Gg: AR+sD11f2F97P8Cic7KKNYfCYbv/tV6Yhj6PNRjeSX7kORNNs23Uotz7NnfviPlA8oI
	z9dB/typvYEkzCK5Qlp/VWUH8mLTTTgBw00qOf+8lg+fJl0JhcWmD84m84004yCySzvZtsXQIZk
	fODDVYrwBlla/HMFUDcWJtHn7y8iLI2V1egWI+NFDykQyl5dXJYEdyewPzLwk8FHsNYTzLkD2N1
	Z5fusAV2Amm7cLsD9OMjeJTP/o1Qcj1vhO0xl/oBN2zbvJnqCm1hJ5izvrozoFhaxbyZpWj8cnQ
	Nz/+x7KBtyd0Kwa5gLh4W0h3f7df2+QvEAMUeM7F5pbJ92aGBTuTj2/Zm3ArIXzTXDcf5G7hDkC
	AyhjIZseAEf5b7o0dyfLV4aiCxVqP/KsqsoZNpuWZq7gvICSt7CRFlZ1C89uRBjkKgCm4OezDdm
	VLcHAXnCa45MutrhVaPrOfZ5YKDMd3/ZmhEPe0aQFQ+J42juTxf6AYBQiQupOPgyv08DAfIUCge
	GKtRckw8ZKEJIPHorw40zbNNEIJYEGDMFviYnKLbD8L275ItOujkjBQRhWsZr8=
X-Received: by 2002:a05:6a20:6f89:b0:3c0:b766:751b with SMTP id adf61e73a8af0-3cd300cafa7mr7386192637.14.1787287360593;
        Thu, 20 Aug 2026 21:42:40 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:b111:8435:d2e3:35de])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm40321253eec.8.2026.08.20.21.42.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 21:42:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.1.y] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
Date: Fri, 21 Aug 2026 00:42:00 -0400
Message-ID: <20260821044210.10076-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei (Microsoft) <xmei5@asu.edu>

[ Upstream commit c283e9ada7fcb7dd4b10592623086b2e6d2f9925 ]

xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
rcu_dereference_protected(), stores NULL and dst_release()s the old dst.
That is only safe if no other thread modifies sk_dst_cache concurrently.

For a connected UDP socket that does not hold: the transmit fast path
(udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache locklessly
with an atomic xchg(). A per-socket policy change racing a send can make
both sides observe the same old dst and each dst_release() it, dropping
the socket's single reference twice and freeing the xfrm_dst bundle while
it is still referenced:

  BUG: KASAN: slab-use-after-free in dst_release
  Write of size 4 at addr ffff88801897b6c0 by task exploit/155
  Call Trace:
   ...
   dst_release (... ./include/linux/rcuref.h:109)
   xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:2256 net/xfrm/xfrm_state.c:3053)
   do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
   do_sock_setsockopt (net/socket.c:2368)
   __sys_setsockopt (net/socket.c:2393)
   __x64_sys_setsockopt (net/socket.c:2396)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Reachable by an unprivileged user via a user+network namespace.

Use the atomic sk_dst_reset() so the cache is cleared and released with a
single xchg(): whichever side wins releases the dst once, the other sees
NULL and does nothing. Behaviour is otherwise unchanged.

Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket policy.")
Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Assisted-by: Codex:GPT-5
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Please queue this unchanged upstream fix for CVE-2026-64581 in 6.1.y. An
unprivileged namespace user can race UDP transmit with per-socket XFRM policy
replacement and double-release the cached destination.

Reproduced immediately on KASAN v6.1.182; the patched target completed 50,000
rounds. The fix is in 7.1.6 but absent from 6.1.y.

 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 6f70aeaafe14..4b0835cb58f5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2428,7 +2428,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (sockptr_is_null(optval) && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		return 0;
 	}
 
@@ -2468,7 +2468,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		err = 0;
 	}
 
-- 
2.39.5
