Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977845;
	b=4TwYhGR/UU+OBQ9ooOTZzvYdlnuIiQtBMcQbVDWJixljAVh6QIMNnipNddq/nwBrBN2n
	 AeGy9ordmhTs/8QhKVOEENMJc79+c9ZvRS+NM33n4LlqK/Eg6wMxcSQ4BOe5CCClrreV6
	 ShjtNFKtJ3+KBhPSZ7dnH5O6w2fkzS8rLoCidGn5dMhg+veHPTIkWj5DAxbVqpwuDBXr2
	 HwOCAjK6DnGmTmn18Mfd8v6127hNXApST2Q+Y/d8UwEnrKVhBHNeQ82Zb1SeTbDSgtWHt
	 tOC5uFyrmK6hF1fwspC8j2xc3WzxD4bGBiVie1hWaBfaVPA9Dqd0j8bFxHxzhOmvdEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iT9NfhgnDE8yCQLxukxdhnUbhT9EjqaTKfivDl9MMxU=;
	b=Nrcq9wWQRc7rSjMJpkLCP4IV4Za1jlC4zZeQmWe2NaaxyYodOzYKgHgpORDxiMvpVWOQ
	 tpZ5OSUdkcL6zkmQQ2YUxpxIT5988mNLZnCsMo/CXhohtt87vnOc8Hu+HFoyDkYA5iBKi
	 Wi3JiyW8INQH4g73UPQPU6NeYseGrkKZS/L8uIMGa6I2sFuEqPoolk8rF/2D01tYWwYTT
	 MAvaa5tK7Rcfr9dn+OD9riUTro7/+cEbIu6d4ZaKXMHwBqM9DRuPKjDGMyON1nG6sksv8
	 9mrvw5zO/93AY6kh1BeQ0jCE58Sm7jJ7PShWxzgo/b10XL0DBEBSvdM8ZXPoJs0ZDWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nf52JdRs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263E606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nf52JdRs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6714D1F0089F;
	Fri,  6 Nov 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977844;
	bh=iT9NfhgnDE8yCQLxukxdhnUbhT9EjqaTKfivDl9MMxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nf52JdRs8gTfeznAkTKRmjmCyLUcXYqeuSTUm/rTn3fnV9RZ6nrcbryDrmvgd993R
	 EVRddueVdRVHgSlAySpRu4Pb17EOut+5RJJ8oMe3SqSk1r1X5FO613+E3erK3O933f
	 PkO0VMW53wOSDGvuN3ODn6xVNcYd0K14PikwzDtEHAI3Lem7ahlT1zPxUZ8pDcaGdx
	 Ovsz2+4rMdAMNroiSZO8QCwPB91PVplIAa6fYWSi1CuGR+drkP1vJZhlWFQbfNJZaM
	 yUVstuAKebNOQTCEmWF7TovuEod02fNABoRCxT7fvNLXuBUdW9a822d+77AuyCCFAH
	 10DRnSk6joa4w==
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
Subject: [PATCH 5.15.y] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
Date: Fri,  6 Nov 2026 10:10:42 -0500
Message-ID: <20261106151015.356330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-spectator-yonder-46d2@gregkh>
References: <2026110441-spectator-yonder-46d2@gregkh>
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
[ sashal: adapted service-call completion handling to check call->state directly and use the existing call_complete label ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/rxrpc.rst | 13 +++++++++----
 fs/afs/rxrpc.c                     |  4 ++--
 net/rxrpc/recvmsg.c                | 21 +++++++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index 39c2249c7aa78..1928582e90298 100644
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
index 624ca9a2bc8a1..871777ddaa8a8 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -497,7 +497,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -910,7 +910,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 		return ret;
 
 	state = READ_ONCE(call->state);
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (state) {
 		case AFS_CALL_CL_AWAIT_REPLY:
 			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index b7783d2af6be3..a7071c61dabfe 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -687,14 +687,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
@@ -715,6 +717,8 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	case RXRPC_CALL_CLIENT_RECV_REPLY:
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
 		ret = rxrpc_recvmsg_data(sock, call, NULL, iter,
 					 *_len, 0, &offset);
 		*_len -= offset;
@@ -748,6 +752,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
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

