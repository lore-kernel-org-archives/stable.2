Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819596;
	b=M4V6EE+wNni2guECFD136g++Zp4loRyOmZvJC0iavYSqDXy5TyXpN3tQArf2HmtxbpU3
	 KDBA/DZ200nkA397IJQY9F3NVC42LckiT5PbaCOlh7qN38eqHcqBcdauzlI4UFOTY9u0l
	 Ics/997FWmBFZmF7yjUir+30jOSgDW7ghBSMYbmRm9WNRH2zC2KKpuzbhBO1aQfOByJe0
	 clvOizDr3m4mp+uNCd5Wij29PB4yC6tFDBcXilpuKFZbQFTnXE1qRXbUhE6tCyfZAkdRg
	 0TLFSTN7y85XFoSbUqL0GxGzvkMu/eGl4swc5kAhxt5wQwGa4tGc5aGwOjFJrirRjDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819596;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cHKOgxhXT3soEL5Yc9AM5AxOnrpJgk9f1j3YIU8kvb8=;
	b=3IfHIR7A5iR9wjNRbgxVpJTIMUTGbvMg6BOdarFBp+3/sQ8JH/4o1XiP3RyF+/gzNNrr
	 2NkCUr4HneytNcOrHf2WlAFQIbSC2jmiJZad5EG8qlU6ZDxdUvkUIdhNve0PeERjlhWKa
	 d2PAJy3DVxYhHj4Fsxk+sBK4VgudUXjB1vSFa1ljV6Uits4wpxH3hfLamZASpIqzwkAzN
	 5xNczTVyHvK3R6AIPAhXhqXHPIkKuZCFJcEaRtFLSHgFdAWcEa2sj8hdvTuxLSMWAWOWy
	 dsywr0PkZLYkYL/ExLR3qJOb1qDfKPTFpaHwshbbz8ztil0uGWgWysc3A2FwwnnnesA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="o/yB2dC2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537B606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=o/yB2dC2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C9E1F000C1;
	Wed,  4 Nov 2026 19:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819595;
	bh=cHKOgxhXT3soEL5Yc9AM5AxOnrpJgk9f1j3YIU8kvb8=;
	h=Subject:To:Cc:From:Date;
	b=o/yB2dC2DnTL4hV/6gvmMwae37p4jWkTbNO+Zi63vyLEyvVCitkWok36fLo5RZC+F
	 kvxFun1apqjLBMDe3KQ3lFuaWmc/xDLhGboVsAct/eEJy0UTTUfjNr1x5p2kaYczSC
	 fW3pfE66LGyhyDK+xFFJA1DDpp3dsWHoL1kDCKfw=
Subject: FAILED: patch "[PATCH] afs: Fix afs to abort the rxrpc call on send error" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,davem@davemloft.net,edumazet@google.com,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:13:14 -0500
Message-ID: <2026110414-distort-monument-fc2d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3e6af08a571fe2943a006acf3e890f36322602bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110414-distort-monument-fc2d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e6af08a571fe2943a006acf3e890f36322602bc Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 6 Oct 2026 14:29:57 +0100
Subject: [PATCH] afs: Fix afs to abort the rxrpc call on send error

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

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index bcb8bb15d471..64dd32df8a34 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -441,10 +441,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
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
@@ -857,6 +855,7 @@ void afs_send_empty_reply(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
 	struct msghdr msg;
+	int ret;
 
 	_enter("");
 
@@ -869,21 +868,13 @@ void afs_send_empty_reply(struct afs_call *call)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
 
-	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
-				       afs_notify_end_reply_tx)) {
-	case 0:
-		_leave(" [replied]");
-		return;
-
-	case -ENOMEM:
-		_debug("oom");
+	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
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
 
@@ -913,12 +904,10 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
 				     afs_notify_end_reply_tx);
 	if (ret < 0) {
-		if (ret == -ENOMEM) {
-			_debug("oom");
-			rxrpc_kernel_abort_call(net->socket, call->rxcall,
-						RXGEN_SS_MARSHAL, -ENOMEM,
-						afs_abort_oom);
-		}
+		rxrpc_kernel_abort_call(net->socket, call->rxcall,
+					RXGEN_SS_MARSHAL, ret,
+					afs_abort_send_error);
+		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);
 		_leave(" [error]");
 	}
 }
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 704a10de6670..554dfb777b93 100644
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
 	EM(afs_abort_unsupported_sec_class,	"afs-unsup-sec-class")	\
 	/* rxperf errors */						\

