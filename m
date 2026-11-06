Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971466;
	b=A9gRdvORnQXldPYADg2MUYT8/ond7nkAuGIoxDBGtbBCQ8AyejyTK7EqHsqYvLrHuDLu
	 u6fDw3HeOgs10Fa3XAEC3DNm+CvokFQj7qP7AZcYRn4RxLUXvSSWX4IolwKuSeumE8saf
	 nunKWaczZQ+MHahrwrPbxMJAQIsAPqFS/eIITXVcR7Kh5nfbDbUGOpTlEpVEKs8mFP0bA
	 ny2QyeYD5i3UvQCQ7YzHKZBas8V3T6V98+voAzPHNiRqEe7whuAbemzF0iAsqizAzsTxV
	 JDRGwKesRYjzno2XJl/ImXWPtdD0mocPIZbTDlnkf9q/yw0Id6FimBlflz5YVGjg2XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1jCsCo8sG3dZ9Sq0lkrB/PZBfkm0svyx3znjYFlAI5E=;
	b=aakpseY6QcywDuRVAtXQkEfOr+EL/snhW9PFdhNE+vf7PN6os6C6KPPi0LVuJ0erv2e8
	 OWiKY7cy8DH1opsC564vT9asr2QiIdwmTPElnotW8sPQj9lITwSEpITNXfaO1jCLEY3Ua
	 vskiD2QnTX5CkUTatadms4rXT3T9X1mi+hUV8IGpRPxYDVUtubZbMrAMs3aKsZJuSQntU
	 S2CYxHC+0HsuRrEZUzaFnSNR8WbF4X4lyHXSoO4OS7P++v7Tfqhyjs/uTmFPDPFB6YWbl
	 NpmcVt07GZFRUDyfsbrN3aPFKmC84gGluyfk4ocGdqoRi2EJm+Dbi8wLumMlRzVl90w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/MBn3vF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73B606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/MBn3vF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4761F0089F;
	Fri,  6 Nov 2026 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971465;
	bh=1jCsCo8sG3dZ9Sq0lkrB/PZBfkm0svyx3znjYFlAI5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/MBn3vFb3NAUon6pwMqoV9dp9hwiYSS1n+SRUKzUTYMLzU6UDlXotn/PpKnTckf1
	 6/snkb6q4UOkeeo2D/kb7+IiwnEhlspUp8SnpDDINLRmFARxJ8gyBkPX3+v2yM+IDp
	 CxgqWVA0IljDkJBkV3J0vH6Ad5H2t88+nxoRyL8SCF8+wRKY1o4HjMWFY30lzNdiVY
	 Vl9n3Wf5QiL/0Pw4xa4wZCUl0OMGChh9rUDms8PgWw0Rs+x+DoIfrH8nStgHYpOeKv
	 LRZo/ZQeSBlpVUE81MP0d0sqKulwj6yiw/lasfbXLiRvX8OnRr2COycNz/XJ+KEbax
	 yOAzmH8YB9VbQ==
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
Subject: [PATCH 6.6.y] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
Date: Fri,  6 Nov 2026 08:24:23 -0500
Message-ID: <20261106132306.63512-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-sectional-harmonics-b283@gregkh>
References: <2026110439-sectional-harmonics-b283@gregkh>
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
[ sashal: Replaced the older rxrpc_kernel_recv_data() return-value paragraph with upstream's Return: section. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/rxrpc.rst | 13 +++++++++----
 fs/afs/rxrpc.c                     |  4 ++--
 net/rxrpc/recvmsg.c                | 19 +++++++++++++------
 net/rxrpc/rxperf.c                 | 16 ++++++++++++++--
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index e807e18ba32ac..257513e446184 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -910,10 +910,15 @@ The kernel interface functions are as follows:
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
index 523272b86ad46..cdf42efb06d46 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -545,7 +545,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -964,7 +964,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 		return ret;
 
 	state = READ_ONCE(call->state);
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (state) {
 		case AFS_CALL_CL_AWAIT_REPLY:
 			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 97879faafb5e7..fcb0fd5a4caa0 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -547,14 +547,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
@@ -593,6 +595,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
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
index 7b53e06da4587..66565dd24acf5 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -292,8 +292,20 @@ static void rxperf_deliver_to_call(struct work_struct *work)
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
 
@@ -368,7 +380,7 @@ static int rxperf_extract_data(struct rxperf_call *call, bool want_more)
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (call->state) {
 		case RXPERF_CALL_SV_AWAIT_REQUEST:
 			rxperf_set_call_state(call, RXPERF_CALL_SV_REPLYING);
-- 
2.53.0

