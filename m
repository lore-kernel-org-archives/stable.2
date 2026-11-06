Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988035;
	b=wjGhZta+O/inYaRJtkwQ1j7CpA/idGlgP38iymGi0uy/PAlgBcw6vZQ8w/xoUEmonlY6
	 kQmSqQArq/FUA9+ZW4k7QvN8C6Yakxhu6xZUwlggH371nDNDij5REsDOkhg70jZDdtUxo
	 PEnTRCXP0svyP1JgKjN0rPn8c9q/OankEU6x1CyUXaosL9VwkKvBVFGa6P9mkMiu3Rq1g
	 KdYsjXwDrki1MkUMp+zZpTigdAacLhIsMbGs/j1W6EIKTWz17Jfv8xUufDSAjCMNtL8xl
	 lzr3GRXA1KpX+T9VY/svD1pC1Uf3b7FwtfCP760r5wSAfTa6jLyhlSsy7y+DBlB7Amw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xr+SISH5RV62XIiVtNL1uZtms8VkD967JZr1xeYJsAQ=;
	b=OmM55178JvlUrqukl0l1NXfIlWr5Ou5rMnWTRIlye41irtivCuKC2XU4UGvKbkbXyDSx
	 5SRZ+U68lHd4wFXJPTJpvHgAKnOruPazjk9fO51riuxRLsrhZDM+UJFQo4e1zZmw0VrrK
	 q2s1eWwvVGLwiK3pGCexnqNA6DiOvE4r+sAxgo4N25DRmyGvOiCrbYWxhwGsaroB5ZgQ3
	 gHrm+2diWu9dc7iPjAXhxSRWfBG5Lxa15PMsIVoWcTkubPGlI0tUdSUDJQ5c3rGHrGdTC
	 jcZ2S25iHe+/ukefPRRq8tC09Z9ait+1e06TDvB0FkwwxNzIIdwql5KwUwAoTqZuNRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEwx9ATq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA0606A336
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEwx9ATq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FC81F0089F;
	Fri,  6 Nov 2026 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988034;
	bh=Xr+SISH5RV62XIiVtNL1uZtms8VkD967JZr1xeYJsAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEwx9ATqazP1ztqv4QCAdrm6wnJ9AalxHVLynmM28sjheietxE6cXGbqV/ogiCpqj
	 US7FdSY4MJXQZfAG6Z22dpALT+PK9a7yeuAALc56AVco7UakoNVQlfXCJ5rivW42kZ
	 s2PJGLraE/rkxOdvRD+9COeQRSlsfo0uUqys2MwxdJ4NoCsT/iB2W9d2WbAieB2MPl
	 ExMXOYZLwVkrPpSAVAt0IsxoPnBHrBtnaoeV5XQ5/C47lCK9z5nKz/gM1YSZEtasAH
	 5OJCafalUwv8Xdj8dE+EHKjit5OjYppSdAwz2WFb10AyuumEtAdR0w1BUWbW/3zucv
	 PHDkeloVwTJtg==
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
Subject: [PATCH 5.10.y] afs: Fix afs to abort the rxrpc call on send error
Date: Fri,  6 Nov 2026 13:00:32 -0500
Message-ID: <20261106180009.620289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110416-surrogate-sanctity-b62f@gregkh>
References: <2026110416-surrogate-sanctity-b62f@gregkh>
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
[ sashal: replaced afs_abort_send_error with "KSE" to match the older string-based abort tracing interface ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 2e68abf627f5d..f75e8b361e294 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -469,10 +469,9 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED) {
-		rxrpc_kernel_abort_call(call->net->socket, rxcall,
-					RX_USER_ABORT, ret, "KSD");
-	} else {
+	rxrpc_kernel_abort_call(call->net->socket, rxcall,
+				RX_USER_ABORT, ret, "KSD");
+	if (ret == -ECONNABORTED) {
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
 				       &msg.msg_iter, false,
@@ -854,6 +853,7 @@ void afs_send_empty_reply(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
 	struct msghdr msg;
+	int ret;
 
 	_enter("");
 
@@ -866,20 +866,12 @@ void afs_send_empty_reply(struct afs_call *call)
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
 
@@ -914,11 +906,9 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
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

