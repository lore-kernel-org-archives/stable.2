Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77963495E5
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647899; cv=none; b=A6VPUOC6I1161rtNwL5Y/zPnBGynm7+CyDoJ6duJdsech0x+D+OV8ZDmnNDekoDIf+zNukEkzcKGOJ9ruH+ncQpwZTHD905h6Zx0reGObh7ZVVQkaf4FyEsPtDIrx5GznHdPPwneUmiYjKpnrtPBYKkZNGd94tYXeUJZBezOV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647899; c=relaxed/simple;
	bh=fddwZMEJzG3D8cZDEDw7rYgZv9IFMpJGUX4crZ0R5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShfIX0U5OugC4jbWWsvoUO4EvrChIn06X5oYZiA9AnWKQf4ydos3bq8Lg7JHiLKzaJ0wZlDwBrNztqmiSx7UOdUZS+S3dWyUxJX4KOs59Vy3nQjT8NtHisdE7fH4mk2Lxp0omPw4ZIK4xmTiKpdncRV7SLMqq+UBqqHsvaZZGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCSihxFT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCSihxFT"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8453427d3f4so314850b3a.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783647898; x=1784252698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3UTPv+hJX2QLGxws8LgGW5Meix2PpanRSv1dLaDtFYQ=;
        b=kCSihxFT3uw/+JOBONin1YIfwPhRdYIJkc5FqsEmPSVdAaJ4bF3OKDmMvYgZa1qcXL
         ufNGDUB4oqNgYZ3YFQr4MblenAVDPVB+kTlG3buPOvQfP2k36zkn5UTR3KeqOyrnbkNj
         UKrY4qwkvCLzIOjp8o+Wcl6pHEMFzGzbN7yrX1I/xJQRZboOGruy9B6Z4RdSJbfIzuMN
         w27nwEKjpCKAUSqPp5VJqQ8lSshO5voOg+bUDi4o9e7JxPI4TE3eahZkNr7GqN9rWqQq
         eChQVh/8pfVdzqwUvVkf1jKdAN2oIHAliIXXncZHntl1rJdxDtG03Pp0wHRbLGbRqTbd
         mgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783647898; x=1784252698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UTPv+hJX2QLGxws8LgGW5Meix2PpanRSv1dLaDtFYQ=;
        b=e20MytWaBK0Hod0pZcj+WaMQUZ/NxzvKFJFuSPib5YvJLRrR8W4bQ0w6LvbGuLB5yo
         J2TXOn7qqoNXT2UNALMZF/rGT2+NQLWYtGVRWbFXGLZ/a85Ead8LajtleOazbFYZdsuI
         5upekukuGm+L6VsNG5XP19/NwF6HswJl1qjCUwePELWHVAjb+H80EHQ3bpXIQqkfvKtf
         9dwbpWDcGpfj+/djQ4KHxgmP8fG3UquyeMVlJbBij+pgqB/lPFtapSsVQGI0zGlrE8Ff
         Kjx3MMmWalTR6NigoM2TivCoETAP0qUSm9bOddNir64c0LSEBaCThpI5DjvuumEJ2Fuf
         rOUw==
X-Forwarded-Encrypted: i=1; AHgh+RrN5fnspRzhv0qcRnJrUyCA3AXDO3UGEQrIKI4Gqg4Gk4lKCypP96tDIzvPZItyoPyacEn/my0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIBXvBImSMYO0YqKPwOuQfRdgK97XODW/1FKYYE1NlFTKingZ
	370b50BhmCfNLGLBrgJTrIhQOvbAJOIwF/WGjoE+1f0FsMhqgK+4s8wI
X-Gm-Gg: AfdE7cnHSRYzhRiWglu9sdrLySq5CjjvZYl3cI20xGmgF1h5rAW1A3cHHzlUkNc4F5b
	bF4vueqln8Ot5QKhy6/OMNZUzq2DBphxxRvlXGYnidthU9sqy/wWhXjk1BW7Jb4PdAE9x+K1i+K
	u8p8OjIE84WlFkueOpADuz8LJQn90omSvMQtEdRWDA4H9TtKljAtBelTCodQcEEubStI9+9oDQK
	Rqjp3H+txLINiNVodMGmaHXbWJUAMrLmtMKIWo38ASTfUyjyxuweduoozWFX7Pjtbq0grgNyVlY
	1I62K+f88tLe+GfAgA/LSTibsK4tIIiwkJ9ZOsR2w4SiLz+crM8ZDfjMvyZfJpozj7xhcMGyuV3
	hjIMpVBFYEg901hC0NNcE3ozXng351DQWCrN/Xk5Ulh2ZFAV/5P+ygomaaMjjIwF3YkZVnosC6x
	zMhmjF3qFIseulzPhjAEXhLBQP
X-Received: by 2002:a05:6a00:2e24:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84843248513mr8521769b3a.34.1783647897749;
        Thu, 09 Jul 2026 18:44:57 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84856d5d661sm2055607b3a.35.2026.07.09.18.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:44:57 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Fri, 10 Jul 2026 10:44:40 +0900
Message-ID: <20260710014440.2055584-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
returns non-zero), its error path frees the sk with sk_free() but leaves
sock->sk pointing at the freed object:

	if (tipc_sk_insert(tsk)) {
		sk_free(sk);
		pr_warn("Socket create failed; port number exhausted\n");
		return -EINVAL;
	}

This is harmless for plain socket(): the syscall layer clears sock->ops
before releasing, so tipc_release() is never called. It is not harmless
on the accept() path. tipc_accept() creates the pre-allocated child
socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
fput()s the new file, so __sock_release() -> tipc_release() runs
lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
sk_lock spinlock.

tipc_release() already guards this exact "failed accept() releases a
pre-allocated child" case with "if (sk == NULL) return 0;", but the
guard is bypassed because tipc_sk_create() left sock->sk non-NULL
(dangling) rather than NULL.

Clear sock->sk on the failed-insert path so the existing tipc_release()
NULL check fires and the use-after-free is avoided.

The tipc_sk_insert() failure is reached when the per-netns socket
rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
returns -E2BIG.

  BUG: KASAN: slab-use-after-free in lock_sock_nested+0x98/0x150
  Write of size 8 at addr ffff8880047cdc38 by task init/1
   lock_sock_nested+0x98/0x150
   tipc_release+0xa4/0x7a0
   __sock_release+0x61/0x120
   sock_close+0x10/0x20
   __fput+0x1d6/0x490
  Allocated by task 1:
   sk_alloc+0x2b/0x380
   tipc_sk_create+0x82/0xb90
   tipc_accept+0x14c/0x650
  Freed by task 1:
   __sk_destruct+0x22d/0x2d0
   tipc_sk_create+0x7b8/0xb90
   tipc_accept+0x14c/0x650
   do_accept+0x1d2/0x2a0

Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
This was reported to security@kernel.org (Cc: the TIPC maintainer) with no
response; posting the fix directly to netdev as it is a straightforward
one-line fix. Full C reproducer available on request.

 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..55e695748332 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
-- 
2.54.0

