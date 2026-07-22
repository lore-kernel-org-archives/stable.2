Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E617411F94
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741387; cv=none; b=lkJSEuHgcyEq54DtCjKe0u9H6NtXJ7TN+NS/LYsB71fbTArBRUHs2XIHnJ+/bPJo0hCX0SpfOh2wmI9xcjVTaVJEypx/cUSH8d3C5o/mLKI2FNzOXgS+dU9WvGlf2cq2v/j5gYiuCfYjq8Grn9WB6Bu8Db9YCFplteLNU+t/X9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741387; c=relaxed/simple;
	bh=HWVqueF6UiAdQXCcszxRATkEOn2H5z9Hu/CCuSQI8HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvdKR0xBlUvls8DGlQF7Z7aISWGi6vTX33jj/K1RcfG5dYcaUz4RNud5NJixV9+k0nZqN9iUaXnX22JC/+kJyUV2dkbSTviPCszbk+9pXbl1P8gVWuV3uS3XX07JQ6IRIu/5S6y3Tj+qT1qlbSR7MxGEJM12NnjLDuoNYuw8Mbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeKCTKf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeKCTKf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848771F00A3A;
	Wed, 22 Jul 2026 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741385;
	bh=1Xh+pUbfjUGLWLWtpDMw3RniMKc09oYdva7Z9+vPetA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeKCTKf/a5GCoFKUTK+NylvTFs1k7CHxA0jgLkoY1kSV9ix6qkkvJW/TbqOT38Rr3
	 hLhNjH1SmU17d9SUfyOxfz6mYxV6thPdI01yQAhziWBBV+xtNcr4ixgvAlbzcEMJhr
	 Ap8rGmAbU/tllFWddwSoRl73xrpO80mCyWAFRMhwO24DEHMURLT6sBtWPBWPSwzzlY
	 HcgWUMeOVunEIQ0tYJPcjSvD8s1aYjx8xVMwNESRC3bxM0jCX2zUNRXaGJZhxfwIyg
	 nt0gbH5pPCSmrn1Duy46bH4PZDehlzhE0OAMV48bBO9xYgAjJcIKdVSNUU8qYVax3n
	 F0sgCNIcQ6itg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Daming <d4n.for.sec@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] rxrpc: serialize kernel accept preallocation with socket teardown
Date: Wed, 22 Jul 2026 13:29:43 -0400
Message-ID: <20260722172943.2067905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072055-kleenex-motocross-d624@gregkh>
References: <2026072055-kleenex-motocross-d624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Daming <d4n.for.sec@gmail.com>

[ Upstream commit dc175389b18c29a5303ee83169ec653adfae3e17 ]

rxrpc_kernel_charge_accept() reads rx->backlog without any
socket/backlog synchronization and passes that raw pointer into
rxrpc_service_prealloc_one(). A concurrent rxrpc_discard_prealloc()
sets rx->backlog = NULL and frees the backlog rings, so a kernel
preallocation worker can keep using a freed struct rxrpc_backlog
while updating *_backlog_head/tail and array slots.

Serialize the state check and backlog lookup with the socket lock,
and reject kernel preallocation once teardown has disabled
listening or discarded the service backlog.

Fixes: 00e907127e6f ("rxrpc: Preallocate peers, conns and calls for incoming service requests")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Li Daming <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260609140911.838677-6-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kept 6.1's extra user_attach_call argument in the rxrpc_service_prealloc_one() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_accept.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index b96af42a1b0415..e3df2dbd37ab56 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -481,14 +481,27 @@ int rxrpc_kernel_charge_accept(struct socket *sock,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct rxrpc_backlog *b = rx->backlog;
+	struct rxrpc_backlog *b;
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	int ret;
+
+	sk = sock->sk;
+	rx = rxrpc_sk(sk);
+
+	lock_sock(sk);
+	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
 
-	if (sock->sk->sk_state == RXRPC_CLOSE)
-		return -ESHUTDOWN;
+	b = rx->backlog;
+	ret = rxrpc_service_prealloc_one(rx, b, notify_rx,
+					 user_attach_call, user_call_ID,
+					 gfp, debug_id);
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx,
-					  user_attach_call, user_call_ID,
-					  gfp, debug_id);
+out:
+	release_sock(sk);
+	return ret;
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
-- 
2.53.0

