Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980771;
	b=e0dW4iSF10cYmzyych3iWcxgFXCKACbpaPIz8Lk+g9MQGhAUFwoKya5dF85Aia6oilf8
	 mMVBYYFhyZYIhBMipf/kKrWxxL4jTGcvDSfRIbnyTZCwa+wUU7WCvcquSk9dF6Rt47uAN
	 NORPngBXNuB9pjsjmDnWZRoGR/Bvp1zSQei02YFhYtvMVzpKFJITOvP7kev4oSdeTOVA6
	 WtlruYrkDxVeydg6c5Ar/yFUzYHwNJxkuz1e94mL/hZV/JLKLz8KIKfuxWRj1aQw5VkS3
	 2GOKQpAYjrly2+vPbcxnETKDpRpeYxVzOAERIljxYhKj2EtWU8JxNGvFOIMkMS1TTHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9UuEawhsfZdpFwRmmA9ZhbQJ2qhwiR0PLXYXV5mZdzY=;
	b=iJI861u4y9bfF+WnnjG6QLObrw3nMAUi19zlsNiHAiyQ3HRcEp5ZDUPP4d3HhcdvEXV3
	 0ZiGySuIucfJmLMNOK4kGHuCXC3Xmo7xojJf/QLlXdsSlI/Rh8NAlWKU/tJnIU9tPZUHG
	 +dBoZBykG2dpIFtcASleikHjyefqmY91ym3UpEpyJsdRb/Iv1IsUR948ZjPJqkoxvngWa
	 M5wpzcU8hjyKsqlTKavZh75gtCD1ri/Tduf2utSZKasB2EnZD6U6bBRznR4zNVdjZgAwd
	 S5z30VKUnucQyovGaiYZBTzC05JK/06jm7Ty+m71gD/iLNVJTbK1bJk0LrJ8sLHobbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfilbVBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2F606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfilbVBU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECD21F0089F;
	Fri,  6 Nov 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980770;
	bh=9UuEawhsfZdpFwRmmA9ZhbQJ2qhwiR0PLXYXV5mZdzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfilbVBUfNQD9wd9VfSNMhSZrP7y3l2yID9PoyjLMrPMfFxp0W8iMEgt2qyVQLUxE
	 lYVDtG9/JComcesi/bF8z+a9baBc4GlmSLu0TZvgVEtYUG3ecobtduVhzJbXKrOUAM
	 Zh9L/yfDwITmBuEpSyKD3IY/BHMvIkMI0k035NxOKXqVyxlrNQH7BT+BhZUEqSwgCV
	 4LfzvU2FFGee4MDCAqWGgkzadE5lVlB36PTh98lGPZIFpqW23scXwR4z4nImRQ39s2
	 B6bjqvYXvaVejL02IBKZv+zvKGEvLHx4ny085wHZPuCGyGGKA8uPgI8xmUKSPP6X6q
	 b9hMZY6V1RCIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] afs: Fix afs to abort the rxrpc call on send error
Date: Fri,  6 Nov 2026 10:59:28 -0500
Message-ID: <20261106155904.409755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110416-deck-supreme-3629@gregkh>
References: <2026110416-deck-supreme-3629@gregkh>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 3e6af08a571fe2943a006acf3e890f36322602bc ]

Fix afs_send_empty_reply() and afs_send_simple_reply() to always try to
abort the rxrpc call rather than just aborting on -ENOMEM and otherwise
abandoning it.  If the call is already complete due to network failure or a
received abort, this will do nothing.

Also make afs_make_call() always abort on send error; again, it does
nothing if the rxrpc call is already dead.

Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261006133011.531806-6-dhowells@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: adapted rxrpc abort calls to use string reason codes instead of trace enums ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 624ca9a2bc8a1..45073a7369122 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -400,10 +400,9 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED) {
-		rxrpc_kernel_abort_call(call->net->socket, rxcall,
-					RX_USER_ABORT, ret, "KSD");
-	} else {
+	rxrpc_kernel_abort_call(call->net->socket, rxcall,
+				RX_USER_ABORT, ret, "KSD");
+	if (ret == -ECONNABORTED) {
 		len = 0;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
@@ -821,6 +820,7 @@ void afs_send_empty_reply(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
 	struct msghdr msg;
+	int ret;
 
 	_enter("");
 
@@ -833,20 +833,12 @@ void afs_send_empty_reply(struct afs_call *call)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, 0,
-				       afs_notify_end_reply_tx)) {
-	case 0:
-		_leave(" [replied]");
-		return;
-
-	case -ENOMEM:
-		_debug("oom");
+	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, 0,
+				     afs_notify_end_reply_tx);
+	if (ret < 0) {
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM, "KOO");
-		fallthrough;
-	default:
-		_leave(" [error]");
-		return;
+					RXGEN_SS_MARSHAL, ret, "KSE");
+		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);
 	}
 }
 
@@ -881,11 +873,9 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 		return;
 	}
 
-	if (n == -ENOMEM) {
-		_debug("oom");
-		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM, "KOO");
-	}
+	rxrpc_kernel_abort_call(net->socket, call->rxcall,
+				RXGEN_SS_MARSHAL, n, "KSE");
+	afs_set_call_complete(call, n, RXGEN_SS_MARSHAL);
 	_leave(" [error]");
 }
 
-- 
2.53.0

