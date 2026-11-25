Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622486;
	b=Iq/QweA1RhcrNHfUJUQxvod7bX0TpUmv5YVGxcrf4XQO2vavYcTAZQyowdCqNEABpGEW
	 q8mAygx3QxN77Z29J6dKqp+L9cDhrxQHPnI/TLTx5Gj5Edyl009pK05mraT9TkNRin7p/
	 Ld6//Z+gIX+Zrdf/keXHqrlcwlYs5bTMJsCZfrhUdFiNFvK6zyJigbnmfW6MPF84DSKoq
	 uYN3YsQijUXZ0sqCidvVN6irgyDDLRRy23DyeloMVHEDa5StHHyCR6OBw9uhi7hrMUJtd
	 f5fDTXM4wWDooo7gHUXjp4C7iULi+VPrSu7w/gNjboFMTB1rbetT19ookdK4pHc5duw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fkko/aMGewiM92jMgvtOcyrWo3xpKtVLyHJyy/X6Amk=;
	b=qAMBuDEJEEIDvcIIVxdhIJsUA2kSG62/iWWEdkEaKmvTQ7YFVbIvJhffhbJPx0QN/EJF
	 oZNz5kLoI4U9bYPhRk4U6kr/pIuqNeVIB/nstcDlQj9Cvw4tWKHjrqCWdNZzC3V1Lfz1v
	 XnnOq9TjSXyxnHq6SbeyCl4G5290GpSmFTw+UjJ/ZImXHGclrIrfMuYPAGKyGdTUE1IIq
	 43OgbPvkdBefS3Ig6ffzwIpHwDlaW83MS4Rd66Rl5qKtR8tNVY3bl5PhWUTwZYDuN75Ly
	 kqts0mbqnymWt2Dfz6aKmZMfun4BfOWqY6lSicgT2tDRLI4DcR8rF7nXIQ8F1yz5VSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8h0tkGn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACB9606A33E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8h0tkGn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC9B1F000EE;
	Wed, 25 Nov 2026 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622486;
	bh=Fkko/aMGewiM92jMgvtOcyrWo3xpKtVLyHJyy/X6Amk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F8h0tkGnwvFEeXm1SF/t0JvsDdWNVxv0FdOPUxtosXjwsNuN3DEFTDr2b2rQnLp7o
	 dvA8CrDxblRlQjGVVFHyts+/B/fJtIuIQ8dEa/MQ2M947/FNe/o6CTFFrGM+4UesuC
	 sk6gcOIVKSFMPWaF1jxgBTJdPup5iEQoOOaav12vyxlE483rlanZ/7sLyiRc9hZawK
	 1BsJUDU8+ZLZ0yjS4ggf52ANOEUeQwEtxj1NOx3FYMLdZ0j4J7LEUuj1t90QyE9NIE
	 IJWsCMcJxWZNEX8rwF3Y+3YngIZ4yBLSG5+4k2f0W/J6qcufCZrvLXNaEotKdAviB+
	 YRWs14i6zCdYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] socket: Print pf->create() when it does not clear sock->sk on failure.
Date: Wed, 25 Nov 2026 11:01:20 -0500
Message-ID: <20261125160115.575356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125160115.575356-1-sashal@kernel.org>
References: <2026112501-gilled-capsize-0004@gregkh>
 <20261125160115.575356-1-sashal@kernel.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 4bbd360a5084d8f890f814327e1d9fbb1f0f6fa1 ]

I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
catch possible use-after-free.

But the warning itself was not useful because our interest is in
the callee than the caller.

Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
and the socket identifier.

While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
to avoid a checkpatch error.

Note that %pf or %pF were obsoleted and will be removed later as per
comment in lib/vsprintf.c.

Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241024201458.49412-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 82052e5b5ec3 ("netfilter: nf_dup: preserve guard across NFQUEUE reinjection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_debug.h | 4 +++-
 net/socket.c            | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/net_debug.h b/include/net/net_debug.h
index 4a79204c8d306..47f7a4a878b9f 100644
--- a/include/net/net_debug.h
+++ b/include/net/net_debug.h
@@ -149,9 +149,11 @@ do {								\
 
 
 #if defined(CONFIG_DEBUG_NET)
-#define DEBUG_NET_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
+#define DEBUG_NET_WARN_ON_ONCE(cond) ((void)WARN_ON_ONCE(cond))
+#define DEBUG_NET_WARN_ONCE(cond, format...) ((void)WARN_ONCE(cond, format))
 #else
 #define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#define DEBUG_NET_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
 
 #endif	/* _LINUX_NET_DEBUG_H */
diff --git a/net/socket.c b/net/socket.c
index b63029bfdee92..63d4acccb5f2c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1561,7 +1561,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		/* ->create should release the allocated sock->sk object on error
 		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		DEBUG_NET_WARN_ON_ONCE(sock->sk);
+		DEBUG_NET_WARN_ONCE(sock->sk,
+				    "%ps must clear sock->sk on failure, family: %d, type: %d, protocol: %d\n",
+				    pf->create, family, type, protocol);
 		goto out_module_put;
 	}
 
-- 
2.53.0

