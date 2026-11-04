Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819621;
	b=4I9UUo0ExYZWMsKgCS15w6XxDC7E1Uyw4JnkW+ATEiPe8SgGy9J1Bg6BOC8egfv4QNCT
	 3ekT/wKCkCra5uRn7u9ZHhGV7xhz8rdjkYCQmUgfUlv+I1uacXpBGe/UbLGuAvCBPqTTC
	 rh1mj+WKfzpZBS1DLMedZHd6jeJfYbVCyIOE1EFwMkUHawE3QgM+72QSxRCDHuVRJYs+V
	 4TRKdNxj5XKTCdah88hbrlXv9oj5EIBDfa4OlqMjDtm43OrHHT+dTErZlWOAv0kUb2FSD
	 C7SX5ZVQSP8QZsCHIKXueyAstHzJj987lK35QAybgFhObrWwAEMdVxKQRjJGTi+gcrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819621;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=majT39kIkLJK5Q1r1apUVMY/oUzo07EughVw6WT3YaY=;
	b=gWO2bvSCR9wSORvogJiXaFOSpDHnYzFDN8cDkxIqq72r5t5R/9kMi9rHx5z9Nh8wxyla
	 4RxbdtkVMzaiU83p0r3TCufUN1Vun0FMaYae5zdyU3RLntVHRCHk3cqIT32CSzziIl5m+
	 Jad6uCrjPBpWJ6a42JwhS6jCvfTOsOI6MJkJSbFLmQ1DPG+zQhLBrc0SZltGE5/8NEQvF
	 bH1BWAsNazxNAUe0kL4JCyaSxgkfC4MU4NTlDUtHSBH/rast1EOVkaf2nRAakq3j8ov+4
	 O7dJS9LyRnE+dlvhbQl0Fphg3qEbz8F8lFC8KxL9+Lt/bMm5YpfTq7wHs0s9kDj9DPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KTO3mXDC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD5606A33C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KTO3mXDC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86F21F00A15;
	Wed,  4 Nov 2026 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819621;
	bh=majT39kIkLJK5Q1r1apUVMY/oUzo07EughVw6WT3YaY=;
	h=Subject:To:Cc:From:Date;
	b=KTO3mXDCvnjzNJTUU8QthuY2ze31N4iHIQVBoMcWhv9rql19tR6SjnOj1G+CKKuB3
	 bSECYNrz0xDj+lBKJIVoYjSXcTomzB48Ald8ASTMMV5BRJPZMasyRcaedLHkOjzcRE
	 +Ryn942mDv3GoGGWuGx6rk1d8+ExseMOZnMgoXjA=
Subject: FAILED: patch "[PATCH] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls" failed to apply to 6.6-stable tree
To: dhowells@redhat.com,davem@davemloft.net,edumazet@google.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:13:39 -0500
Message-ID: <2026110439-sectional-harmonics-b283@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 18a71e111c7505e16c2de91480561fc491f41341
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-sectional-harmonics-b283@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18a71e111c7505e16c2de91480561fc491f41341 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Tue, 6 Oct 2026 14:30:01 +0100
Subject: [PATCH] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

When rxrpc_recvmsg_data() gets called on a service call that has received
all of the request, RXRPC_CALL_RECVMSG_READ_ALL has been set, and this
causes rxrpc_recvmsg_data() to jump straight out, indicating the end of the
call (ie. rxrpc_kernel_recv_data() returns 1) without waiting for the call
to be processed or the reply to be transmitted.

rxperf_deliver_to_call() also has to be altered to call
rxrpc_kernel_recv_data() to collect the final ACK on a service call as does
afs_deliver_to_call().

Fixes: d001648ec7cf ("rxrpc: Don't expose skbs to in-kernel users [ver #2]")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261006133011.531806-10-dhowells@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 9239f7bd8885..eca055a536aa 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -909,10 +909,15 @@ The kernel interface functions are as follows:
       want_more should be true if further data will be required after this is
       satisfied and false if this is the last item of the receive phase.
 
-      There are three normal returns: 0 if the buffer was filled and want_more
-      was true; 1 if the buffer was filled, the last DATA packet has been
-      emptied and want_more was false; and -EAGAIN if the function needs to be
-      called again.
+      For client calls, there are three normal returns: 0 if the buffer was
+      filled and want_more was true; 1 if the buffer was filled, the last DATA
+      packet has been emptied and want_more was false; and -EAGAIN if the
+      function needs to be called again.
+
+      For service calls, there are four normal returns: 0 and -EAGAIN are the
+      same as for client calls; 2 indicates that the last DATA packet of the
+      request has been received, want_more was false and the call is still in
+      progress; and 1 indicates that the call is now successfully complete.
 
       If the last DATA packet is processed but the buffer contains less than
       the amount requested, EBADMSG is returned.  If want_more wasn't set, but
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 64dd32df8a34..768b26820dea 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -541,7 +541,7 @@ void afs_deliver_to_call(struct afs_call *call)
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -934,7 +934,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 		return ret;
 
 	state = READ_ONCE(call->state);
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (state) {
 		case AFS_CALL_CL_AWAIT_REPLY:
 			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 56fa324d0962..0c960f13b5fc 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -638,9 +638,11 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * Note that we may return %-EAGAIN to drain empty packets at the end
  * of the data, even if we've already copied over the requested data.
  *
- * Return: %0 if got what was asked for and there's more available, %1
- * if we got what was asked for and we're at the end of the data and
- * %-EAGAIN if we need more data.
+ * Return: %0 if got what was asked for and there's more available, %1 if we
+ * got what was asked for and we're at the end of the call, %2 if a service
+ * call received all of the request but is still in progress and %-EAGAIN if we
+ * need more data.  A variety of other errors can be returned if the call
+ * completed with failure.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 			   struct iov_iter *iter, size_t *_len,
@@ -679,6 +681,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 read_phase_complete:
 	ret = 1;
+	if (rxrpc_is_service_call(call)) {
+		if (rxrpc_call_is_complete(call))
+			goto call_failed;
+		ret = 2;
+	}
 out:
 	if (_service)
 		*_service = call->dest_srx.srx_service;
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 823eedc5d16f..0bc3de061b93 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -293,8 +293,20 @@ static void rxperf_deliver_to_call(struct work_struct *work)
 	       state == RXPERF_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == RXPERF_CALL_SV_AWAIT_ACK) {
-			if (!rxrpc_kernel_check_life(rxperf_socket, call->rxcall))
+			size_t len = 0;
+			iov_iter_kvec(&call->iter, ITER_DEST, NULL, 0, 0);
+			ret = rxrpc_kernel_recv_data(rxperf_socket,
+						     call->rxcall, &call->iter,
+						     &len, false, &remote_abort,
+						     &call->service_id);
+
+			if (ret == -EAGAIN || ret == 2)
+				return;
+			if (ret < 0 || ret == 1) {
+				if (ret == 1)
+					ret = 0;
 				goto call_complete;
+			}
 			return;
 		}
 
@@ -369,7 +381,7 @@ static int rxperf_extract_data(struct rxperf_call *call, bool want_more)
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (call->state) {
 		case RXPERF_CALL_SV_AWAIT_REQUEST:
 			rxperf_set_call_state(call, RXPERF_CALL_SV_REPLYING);

