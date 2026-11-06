Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794002245;
	b=BmaQRmd+ASxwyQ1jz7u6xpg5nC5CbwhcBedxOliYbxwtdPOhGX3nsmBqUVsWS0oimsyU
	 pcQsXa0yxmsl8EM2ZItdoIk7uai5dwkN8ouDwJnveHW+yMkJekde+O76qSJVzbRBOh2wZ
	 sI4ikxsP9w6uOSy7S5EKBMV582IIlPbLSvlGwXTfPDLvjS+J8x8eOpDj501GrRwomhuJt
	 ALSIYT8MboBbUWJOLMjB01SNjfs/FdwJE1xwadvqXvL2kF+pTwU393zwNGecrEGI5wZ/f
	 +eTJqRH+gyOtHEczHuaIHzIXbbIzWuL0whpifC0DDtHtMJU97qS1emlzwdUzvUkTHXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002245;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uJnC3E5LSZQKM5Vic0qZdHZV/eCxeajn03COeeAIM5w=;
	b=qAZQ7hQbqtJLKzjEMrSzcCQTDfwnc0TecTPhCw1IOy8K+4gTjGf5VhuIsZkmVHbzS2fE
	 8tQ3xyEU70oVlhIT6nTdvFhnxeErUj9pFQ/356PCHxSUWa6fM6OUhOv9pqSCtRpbOI7tH
	 9Lq3ehmzZMlDjbWJAglRb75JVSOOGvZ+AsLQTLk2nKVZmQlz5Dv/Dyb21E7WN1b/pJ7Ji
	 Z8xOI9D+Uzba9LlotdeStrK+eaAAcqtm8PGjdS64BH+1q10pKxygSuD5oUv9ExbXihxkP
	 ccamStqxeuFSpWe+w8h4rPkTXhw9qzoHSxfA8DhDhNEHK2e+rqotReJ2lDTcXrC8aaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUgFrV7s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C10606A32C;
	Fri,  6 Nov 2026 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUgFrV7s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794002245;
	b=OjlMyTJzUD8nqrnvbrCMdB1iRHJMUuirtQUqTvdk9zGDsffC98Mvju3mPAeihhiuiLya
	 PQqgVqE15HIODJgKV9IckZegLXU85g3LDuVdjcPPqfPGtw/IX7UEKEApq3D9ktrF50C4w
	 Z8Cx+d3H7sWE9YA1HNG/Jce1ZJVtNoP1h7P6G/HZyZtD5sqJj2FBipVmmUTev6p2mxZeA
	 5mrezzSlSsWuW/SdENrl9+HDSA8cHLzODlZX+u6/hNjFSzxPETq05tCO3Q4VHJIYmMBIY
	 5nzqF7H4QL06MD80aQGamRPt+deUH9EzYgb7bu/jEbwGIn2zmTOdz6ZnTBZgmtNOrsg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002245;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uJnC3E5LSZQKM5Vic0qZdHZV/eCxeajn03COeeAIM5w=;
	b=jVbxYwMzgHAlAQ6fjEjfhZTZxGCoOXU1HFliZiRbQAg7j250PJAwgazLFEuzzFjTF99n
	 ABxvzhXDQhHj3y/hLltnqPmKQgBmjc5ofP8VzFKXfBcvr83ZxIWoQhzumqH1018Reqaru
	 pGM3DbDUhoiIL3KOt74TF1oL8TSngDzLbqOUtbAuUDy2uLapLbXD16VxLZosB2kDEljvN
	 B6jXVy7ShwzXU9gZfRCGuAwS2fRigj5ry1DPFvqmxgZwIsAq2I/b09M+N+b6I+XqAX5ZA
	 4pQWQQ8FtdOQfgfNVE/5TOjMElDa+qUAS7YDSsL4NSkFne+Vl3dC8Rd8+YQH3Sc3fMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 069141F008A3;
	Fri,  6 Nov 2026 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794002245;
	bh=uJnC3E5LSZQKM5Vic0qZdHZV/eCxeajn03COeeAIM5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BUgFrV7sPcMJWKgGRACQVDniM09V1FgZXrXU7NddC6hiqGlmdVe/m9uuvli8iMQwN
	 /GBJN3eV+a9BdzAc6zdH4FGRORxDmqkLKeZO6etMuyAcw1A4RM6Rd7Xy/Z4MeK/H3F
	 GlOlU78uygyBx7HGUNAlEHVC7HpRlBMM4SK7Nu4acG0e4dqkGq3Ni/3fRztQorYqwe
	 fB+S9ig+f5Y4JuRPALIa1EiLr0sue0hY7L/XLnAjlL3N9yeUc4Ff/yWiq0hrw2WGeI
	 OY8yxls3iDjsKFiaaIdtWLUhKB0A8Ize1qOkns57LppliiUAnYNjH7KI9uN8Q5y+Ir
	 aq6CH5vo9Am5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6F3BD478A9;
	Fri,  6 Nov 2026 21:57:23 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Fri, 06 Nov 2026 22:57:21 +0100
Subject: [PATCH net v4 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
In-Reply-To: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794002242; l=4767;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=tMncr/t2BZDCVu+DkSDka364ua2a05eGFszh7At9iJI=;
 b=AYg1/w4e3WXm2lKA1GWiOSiVmfBY81KRkcGtQraSUK/I77t97ELFZHMRkMqAmkZdyUrfpA9pF
 h8X5oc7IjtJDad5dcC3ygPR5QHkyl9yFm+Qqi4sswW66P7Mw3RnGoSq
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() holds lock_sock() while vsock_msg_wait_data() sleeps
in wait_woken(). The transport delivers data in
virtio_transport_recv_pkt(), which takes the same lock, so the reader
and the delivery worker deadlock: recv() hangs until a signal or
SO_RCVTIMEO, and all vsock rx handled by that worker stops.

Release the lock around wait_woken(), as unix_bpf and tcp_bpf release
theirs. That alone ends the deadlock but makes a blocking recv()
return -EAGAIN early: the reader is also woken without data, for
example by a credit update. So the wait also loops until data arrives
or one of the native exits applies: a socket error, a local or peer
shutdown, a socket that is no longer connected, the timeout or a
pending signal. The loop alone, with the lock still held, keeps the
deadlock, so the fix needs both halves and stays one patch.

For a non-blocking read, a socket error, a peer shutdown and a socket
that is not connected are now reported before -EAGAIN, as on the native
path. A blocking read interrupted by a signal returns sock_intr_errno()
instead of -EAGAIN. A recv() that starts after a virtio transport reset
returns -ECONNRESET until SO_ERROR has read the error, where the native
path returns -ENOTCONN.

The deadlock was found with the help of Anthropic's Claude; Sashiko
reviews of two earlier sockmap patches had already noted it as a
pre-existing issue. The other cases were reported by the netdev Sashiko
review. Each was reproduced in a VM with a vsock socket in a sockmap,
without kernel changes or error injection; the reset case unbinds the
guest's virtio-vsock device. With the series applied they behave as on
a native socket, except for the reset case above, and the vsock
vmtest.sh single-VM tests and the BPF sockmap test_progs pass.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 68 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..6d96ff03f28c 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,63 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
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
+		/* Stop on a socket error, as vsock_connectible_wait_data()
+		 * does, so that recv() returns it; the checks below would
+		 * end the wait with 0 or -ENOTCONN instead.
+		 */
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
+		/* virtio_vsock_reset_sock() sets no shutdown bits, and
+		 * SO_ERROR clears sk_err: check the state the way
+		 * __vsock_connectible_recvmsg() does.
+		 */
+		if (sk->sk_state != TCP_ESTABLISHED) {
+			ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
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
+		/* With a signal pending, wait_woken() returns at once, so
+		 * without this check the loop would spin until the timeout,
+		 * or forever without one.
+		 */
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			break;
+		}
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -101,9 +140,10 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	while (copied == 0) {
 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+		int data = vsock_msg_wait_data(sk, psock, timeo);
 
-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
-			copied = -EAGAIN;
+		if (data <= 0) {
+			copied = data;
 			break;
 		}
 

-- 
2.56.0


