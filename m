Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974449;
	b=Wq/iRqJqrWt01pSMizqQ+IX+Iv+CE73wnmOPn6sL3hbnD+jaXDB6HJaRrawr5IwFvM3V
	 ObtwVgmQ52ikt2aL8Xmo03v54eqJXRtY6bsXbQn5FRCpaSKQYDalwPCIlGtc8VwftTYcp
	 7hDwhIOhMG58CBMblEaZ1tBzwRoVcJHfSAX36JDa9GkVqRLzhs5AFH5D6MBA1oH6iukY6
	 Z6xZ6LbTLIHMlAOVXtYodwZUCa1Npg0rhQgiOzxx+9cLkiCq9vxX5EwQtq9BRCFhANmcV
	 n24w6FIyuLdfKwWMA3UWpokIqL3mAy0rbM+pf1d5xmVFwpunpWmRHVe+ZBy8dBHpXjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UmT/lNWRxAqlkVUDH80pLePQc3MPR18T/a4qh8PguOY=;
	b=GghTKceJFwbOC3XY5n8dR52YNRd1gC+Ips5jealMmgrhh6fpNgjpjIUe8c7M6XcMLYSV
	 bIj1WBcWQP5QtJpTWjNVep7uvd6OQCYj/ZRtNwBaiUlYf8qLndtbTK73Yd/DLtyTvlEoG
	 Tbs/aB9n4mOHVW8lHZseK1LP3a4I6pWZdV2PArNjbcgXrHfFiKsmJkZSUw1Mn2Fw4osU8
	 elzU5NRgs+oQxdnN6f8qKtl2RGHS/uAuhXKAS+g1n3+96Juk3ABRGmMu/F6gjbHEbX6y0
	 C+eHDnFeyRSL1bU6NmJvqrkehBX6P5e+6O0rZbplGhzC86QyJhpCxJthyNkDUHEGKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9f+EOq0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9C606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9f+EOq0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD2F1F0089F;
	Fri,  6 Nov 2026 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974448;
	bh=UmT/lNWRxAqlkVUDH80pLePQc3MPR18T/a4qh8PguOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9f+EOq0cJQxieH0dz+p3oMB9IA/lfwyD0V7Xtv3W5IVj7lNC/rN/j1mmeS7MxdgD
	 FqDX5atUGTuMBkfMsY5D8CcXFLPKhLuKQGtnzi+7iYVOlPdNHMMxKD3G6ysZljKxSu
	 pDHKEJ+0ZVkfbzElq14hybz5YTa2hYdw2AdHga4ykaqMSqObRJLPuC4CQtMGmMmBjY
	 LDL5wFtZpSqPjcpfnYT1hytgi+UpEA0zLTuvaHi54Eodpwjsj/4g3v6zd7lJdh7CdV
	 8BvFgrKvEUjUBIZN35vo0oxwXhsrgcVX7cz+egjMYMNDC8MWhUPp2wtc147JtYrAwm
	 orN68HBzHKbeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
Date: Fri,  6 Nov 2026 09:14:06 -0500
Message-ID: <20261106141256.248564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-amaze-fabric-565f@gregkh>
References: <2026110440-amaze-fabric-565f@gregkh>
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

[ Upstream commit 18a71e111c7505e16c2de91480561fc491f41341 ]

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
[ sashal: replaced unavailable rxrpc_call_is_complete() with a READ_ONCE(call->state) comparison against RXRPC_CALL_COMPLETE ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/rxrpc.rst | 13 +++++++++----
 fs/afs/rxrpc.c                     |  4 ++--
 net/rxrpc/recvmsg.c                | 21 +++++++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 39494a6ea739c..a0973e65419a9 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -903,10 +903,15 @@ The kernel interface functions are as follows:
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
index 0658523bd7865..6599499efce7a 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -532,7 +532,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -946,7 +946,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 		return ret;
 
 	state = READ_ONCE(call->state);
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (state) {
 		case AFS_CALL_CL_AWAIT_REPLY:
 			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 870fab693653f..91b8306626dde 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -699,14 +699,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * @_service: Where to store the actual service ID (may be upgraded)
  *
  * Allow a kernel service to receive data and pick up information about the
- * state of a call.  Returns 0 if got what was asked for and there's more
- * available, 1 if we got what was asked for and we're at the end of the data
- * and -EAGAIN if we need more data.
+ * state of a call.  Note that *@_abort should also be initialised to %0.
  *
- * Note that we may return -EAGAIN to drain empty packets at the end of the
- * data, even if we've already copied over the requested data.
+ * Note that we may return %-EAGAIN to drain empty packets at the end
+ * of the data, even if we've already copied over the requested data.
  *
- * *_abort should also be initialised to 0.
+ * Return: %0 if got what was asked for and there's more available, %1 if we
+ * got what was asked for and we're at the end of the call, %2 if a service
+ * call received all of the request but is still in progress and %-EAGAIN if we
+ * need more data.  A variety of other errors can be returned if the call
+ * completed with failure.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 			   struct iov_iter *iter, size_t *_len,
@@ -727,6 +729,8 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	case RXRPC_CALL_CLIENT_RECV_REPLY:
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		ret = rxrpc_recvmsg_data(sock, call, NULL, iter,
 					 *_len, 0, &offset);
 		*_len -= offset;
@@ -760,6 +764,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 read_phase_complete:
 	ret = 1;
+	if (rxrpc_is_service_call(call)) {
+		if (READ_ONCE(call->state) == RXRPC_CALL_COMPLETE)
+			goto call_complete;
+		ret = 2;
+	}
 out:
 	switch (call->ackr_reason) {
 	case RXRPC_ACK_IDLE:
-- 
2.53.0

