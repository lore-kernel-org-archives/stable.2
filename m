Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971427;
	b=j1Iv5It+mz5ZW+Cs/T1Me819LUIJNUuuZxKRi9pA86vehlyuQcqumMni5fo2osYKocYs
	 5JO7Tr1zVNylMCN2J8Ujjo1dXcrKmCyDOgp8q7oVj3rs2csLUr9E3C85FzpQGR6czZCOy
	 +b+wdz1UPfNwygjS845UHen1jAP5GnPG0T0m9wdz04J+S18eI2oCo6n7YrAUTm5rtCn1Z
	 Ytu6AAtVEeC+5A5aoDK48NwYKqc/TE2AXHdyjhLduozj5K02mbwcFeBkkzFAASPnEri09
	 GBCzoeLEyhbgovq/4zI3VSUQs0KLvzH5qcZWMPjkhq7GGANklL7ggChWDq4v7/fm2yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=px35KGqPlQA7Wzq/G3jKfOXPlUg75wq509JDGbRstJk=;
	b=ZVgNEYaMczLV+1/85H7OGryJwshsIv/rpRxsus6MzPJy5ULXX7k5Q//z8N3w9Z/NmuY/
	 Kmh8ctVw2Au71SFVWfZwmw8KLVkAWcrddKZrVoYWttZzkTCO3ajSedaxuTfwVG2NqvlSc
	 wsHykbm82zX4WgktIBOhRG6rb3KglzYmy+fKhZsK5gxzAaS1Ru3EFO7luwf16oF/ZlQnr
	 eRbkPuJ1xccM82Qf+zKfMdSSyCvJN/Fqm+reMXwMUYOqIfZLxkCxRywIONmgEuDM9DP4l
	 ObVJv1SCOvxyDZ0gn3/nhP7GAttWN6S78rdi4be44M1yj+xdScSNxNtz8qKumBNtCTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R36OOX1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DF606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R36OOX1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8889E1F0089F;
	Fri,  6 Nov 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971426;
	bh=px35KGqPlQA7Wzq/G3jKfOXPlUg75wq509JDGbRstJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R36OOX1/z1xQ+J7Udy2nqGfxHygVVca+m0AO+ffGN+sSvP+FF40XDfwG9PVBmPGeU
	 d+kk+NcufLnlFcIB1qWuVRQlGW76xTN/6q40PjvPszloxBGA6WkFh7rRtj7130Od9C
	 iDq5aOQYz+bDe20O2stXZiowZEmk6qn89n378MLVyc6dojUXtMIn40jVas5V+6E92X
	 247ATuFGu5OloIdf+ufnnBU0yfRbbnciNBzT/YBYBposHe4BWJyVcGxvyaQ/iidf0Q
	 6klvaY7KJ1uh0AI9a6bnjH57wsp715Zj2tbzkRtV8QcrV3OleSuw2y9keLuU/5biMa
	 EX2c+gG2ylSiQ==
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
Subject: [PATCH 6.12.y] afs: Fix afs to abort the rxrpc call on send error
Date: Fri,  6 Nov 2026 08:23:44 -0500
Message-ID: <20261106132302.13849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110414-distort-monument-fc2d@gregkh>
References: <2026110414-distort-monument-fc2d@gregkh>
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
[ sashal: Retained explicit length arguments in rxrpc_kernel_send_data() calls to match the older API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c               | 49 +++++++++++++-----------------------
 include/trace/events/rxrpc.h |  2 +-
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 55449c8791426..934667e547dc2 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -442,10 +442,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED)
-		rxrpc_kernel_abort_call(call->net->socket, rxcall,
-					RX_USER_ABORT, ret,
-					afs_abort_send_data_error);
+	rxrpc_kernel_abort_call(call->net->socket, rxcall,
+				RX_USER_ABORT, ret, afs_abort_send_data_error);
 	if (call->async) {
 		afs_see_call(call, afs_call_trace_async_abort);
 		return;
@@ -853,6 +851,7 @@ void afs_send_empty_reply(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
 	struct msghdr msg;
+	int ret;
 
 	_enter("");
 
@@ -865,21 +864,13 @@ void afs_send_empty_reply(struct afs_call *call)
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
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					afs_abort_oom);
-		fallthrough;
-	default:
-		_leave(" [error]");
-		return;
+					RXGEN_SS_MARSHAL, ret,
+					afs_abort_send_error);
+		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);
 	}
 }
 
@@ -891,7 +882,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	struct afs_net *net = call->net;
 	struct msghdr msg;
 	struct kvec iov[1];
-	int n;
+	int ret;
 
 	_enter("");
 
@@ -906,21 +897,15 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
-				   afs_notify_end_reply_tx);
-	if (n >= 0) {
-		/* Success */
-		_leave(" [replied]");
-		return;
-	}
-
-	if (n == -ENOMEM) {
-		_debug("oom");
+	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
+				     afs_notify_end_reply_tx);
+	if (ret < 0) {
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					afs_abort_oom);
+					RXGEN_SS_MARSHAL, ret,
+					afs_abort_send_error);
+		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);
+		_leave(" [error]");
 	}
-	_leave(" [error]");
 }
 
 /*
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 8c4d791507f18..5e29744e45037 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -20,10 +20,10 @@
 	/* AFS errors */						\
 	EM(afs_abort_general_error,		"afs-error")		\
 	EM(afs_abort_interrupted,		"afs-intr")		\
-	EM(afs_abort_oom,			"afs-oom")		\
 	EM(afs_abort_op_not_supported,		"afs-op-notsupp")	\
 	EM(afs_abort_probeuuid_negative,	"afs-probeuuid-neg")	\
 	EM(afs_abort_send_data_error,		"afs-send-data")	\
+	EM(afs_abort_send_error,		"afs-send-error")	\
 	EM(afs_abort_unmarshal_error,		"afs-unmarshal")	\
 	/* rxperf errors */						\
 	EM(rxperf_abort_general_error,		"rxperf-error")		\
-- 
2.53.0

