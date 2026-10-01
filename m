Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FC46A60A;
	Thu,  1 Oct 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889418; cv=none; b=IyUfz8RRA2wo1MnM2Tful4h2BfXwUpT2TnQViQ6nW5NghRBOmY3wT5E9cKfMr//4/eMbPkaR0aCTGY4OEDynOcxnZolMM73LuI4Xvco6CVoK7aP6/dYkSxHVd1+2PtPmtnmTFdk+hPmCHaMML5/5uFMsndpQwpIDlkKiz+u81sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889418; c=relaxed/simple;
	bh=JOlqp6Cy2f7dgy9WstV9kdwykzFIe+8amE5T46/T7XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nKRNnljQJXp1/ItN9bHeknzqvy3SsO5MX6BqDf9x1SxwPCA8gu5yM1CN8tZY5ED65QQHBWLfAkZAc4aTS9pBfVFNZ3iqA0lSwpdKtPqI/W9TY2TQlp9AKLTD68zsJa8lrKPieVdxPoG9ecZHof/vdrUcq6weUTNcysTY6cp+M1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHdc2Zlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHdc2Zlr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11EDEC2BCC7;
	Thu,  1 Oct 2026 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790889416;
	bh=JOlqp6Cy2f7dgy9WstV9kdwykzFIe+8amE5T46/T7XY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nHdc2ZlrY8JXDXc2vRiTOYJZewIyVGBt6xj0s/nwFavr0BELRpSO0/Dw63GKtfIQi
	 HoMNLo20T94Ys0yK/gXRPmM5FyXoTh3BdedUDAoHFLsgCTIBX8wdm/AX48r2kfPB+n
	 ancSaTmC4nGCH4+Lu5aGn7kj/U75RTgtqSxdmJuISAGE1GbrT+wTCTyIP9hn/MxPC7
	 Vd378KuUPaJAFWbM57nx/IpXbfS+ZuR7KygnGNW9CQ9IOV21327ZgV9EBDxipVbkgc
	 wX5QMq9CalJTRFsM2fvmtz8i+oBCvTXGCx5QhSyosytbpV9xitBSUtP195j4PJng/c
	 m3jw7KlR2wOWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DCCA5FD2;
	Thu,  1 Oct 2026 21:16:55 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Thu, 01 Oct 2026 23:16:31 +0200
Subject: [PATCH net v2] vsock/bpf: release sock lock while waiting for data
 in recvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCQBAEv7L02YGZSQjoV8RDEidmFFbZTRYh5
 O+ueqxuqjZkS24Zp7AhWfHsz1hBDgHj3MebkV8rQ1k7YRZ6DHNDQqxKk7+pKFkzSatH7lrpUb1
 Xsvr8mmdEW0JRXP57Xoe7jcs3iH3/AI5QqDF9AAAA
X-Change-ID: 20261001-kbh3-1-022-fix-v2-e3f14290641a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, stable@vger.kernel.org, 
 Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790889414; l=6591;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=YvTTC+RU/Ym1bKqgzQ3IfPdzTa169kmvcqEE9p94f/U=;
 b=CbqSqTZQSQB1j9Ic2qSu4ImstdiiTZ8FbKwO5N3DKsTQCUwDC6vjzO2uQ735OWUzjXlEDyY5b
 iVFVupzJPnuBXzJPBSX1rf9M02xPxsgmwnGLx4izONlMWJ9pY2WAiZ3
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
loop, including vsock_msg_wait_data(), which slept in wait_woken() without
dropping the lock. When data arrived the transport's delivery context (the
vsock-loopback worker, or the virtio/vhost rx path) called
virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocked,
so neither side made progress and a blocking recv() hung; the hung-task
watchdog reported the delivery worker in D state.

Dropping the socket lock around the wait is necessary but not sufficient:
vsock_msg_wait_data() also did not loop and checked too few conditions,
which left three further problems in the same helper.

 - It did not loop. Once the lock is dropped, a wakeup that is not for new
   data (for example a credit update via sk_write_space()) made the helper
   return with nothing queued, so a blocking recv() returned -EAGAIN
   prematurely instead of waiting for data.

 - It checked only sk->sk_shutdown & RCV_SHUTDOWN, not sk->sk_err or
   vsk->peer_shutdown & SEND_SHUTDOWN. Once the peer shut down for send or
   the socket errored (for example a reset), recv() did not notice and kept
   waiting instead of returning 0 or the error.

 - vsock_bpf_recvmsg() had no "if (!len) return 0;" guard, so a
   zero-length recv() with data queued never satisfied the loop's
   copied == 0 exit and spun holding lock_sock(), which wedges the delivery
   worker and stalls all rx on the transport.

Rewrite vsock_msg_wait_data() to loop: return the data when it is ready, 0
on RCV_SHUTDOWN or peer SEND_SHUTDOWN, the negative socket error on sk_err,
-EAGAIN on timeout and the signal error on a pending signal, releasing the
socket lock around the wait and re-acquiring it before re-checking. Add the
len == 0 guard to vsock_bpf_recvmsg(), and route MSG_ERRQUEUE to the native
path before that guard so a zero-length error-queue read is not swallowed,
as tcp_bpf does. The exit conditions follow vsock_connectible_wait_data();
dropping the lock across the wait matches unix_bpf (u->iolock) and tcp_bpf
(sk_wait_event()).

Testing: built a fuzz kernel (KASAN + lockdep) on the net tree
(v7.3-rc4) and ran reproducers over the loopback transport on a private
VM, each before and after the fix. Before: a blocking recv() on a
sockmap socket deadlocks the vsock delivery worker (hung-task); and with
only the lock dropped, a spurious credit-update wakeup returns -EAGAIN,
a peer SEND_SHUTDOWN returns -EAGAIN instead of 0, a zero-length recv()
with queued data never returns and wedges the delivery worker (hung-
task), and a len == 0 MSG_ERRQUEUE read returns 0 instead of reaching
the error queue. After: recv() returns the data, ignores the spurious
wakeup and returns the real byte, returns 0 on peer shutdown, returns 0
for len == 0, and routes MSG_ERRQUEUE to the error-queue handler; no
KASAN or lockdep report.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
Changes since v1 [1] (netdev review by the Sashiko bot):
- v1 only released the socket lock around the wait. v2 additionally makes
  vsock_msg_wait_data() loop (no premature -EAGAIN on a dataless wakeup),
  checks sk_err and the peer SEND_SHUTDOWN as well as RCV_SHUTDOWN (correct
  EOF/error on peer shutdown or reset), and adds the len == 0 guard to
  vsock_bpf_recvmsg() plus an MSG_ERRQUEUE route ahead of it (no spin on a
  zero-length recv; an error-queue read is not swallowed).
- Garzarella's Acked-by on v1 is intentionally dropped: v2 is a materially
  larger change and needs a fresh review.

[1] https://lore.kernel.org/netdev/20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de/
---
 net/vmw_vsock/vsock_bpf.c | 59 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..127a20429aa6 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,46 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
 	return vsock_sk_has_data(sk, psock);
 }
 
-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
+/* Returns 1 if data is ready, 0 on EOF/shutdown, or a negative error. */
+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
 {
-	bool ret;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	int ret;
 
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		return true;
-
-	if (!timeo)
-		return false;
-
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	ret = vsock_has_data(sk, psock);
-	if (!ret) {
-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
-		ret = vsock_has_data(sk, psock);
+	while (1) {
+		if (vsock_has_data(sk, psock)) {
+			ret = 1;
+			break;
+		}
+
+		if (sk->sk_err) {
+			ret = -sk->sk_err;
+			break;
+		}
+
+		if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
+		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
+			ret = 0;
+			break;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		release_sock(sk);
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			break;
+		}
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -80,6 +102,12 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct vsock_sock *vsk;
 	int copied;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return __vsock_recvmsg(sk, msg, len, flags);
+
+	if (!len)
+		return 0;
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return __vsock_recvmsg(sk, msg, len, flags);
@@ -101,11 +129,14 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	while (copied == 0) {
 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+		int data = vsock_msg_wait_data(sk, psock, timeo);
 
-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
-			copied = -EAGAIN;
+		if (data < 0) {
+			copied = data;
 			break;
 		}
+		if (!data)
+			break;
 
 		if (sk_psock_queue_empty(psock)) {
 			release_sock(sk);

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261001-kbh3-1-022-fix-v2-e3f14290641a

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


