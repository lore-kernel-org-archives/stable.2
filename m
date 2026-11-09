Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254911;
	b=unGeR5rjn3BzpSXnNcfJpUfWRo/ECkooHRmRqwSywWf6+SLF/Mu3FW7UEe2thKJD2tvn
	 sgZsh29Ukmid9s3I1tC6o+Z4coBxtYmkk0fHyEU+Mkj/msjl9CJnOv06IcVYCgLF4s8/X
	 kMSwcwO6FgotKIqIB+IDPeu1l04EXUB2J9ewUuhTA+8oRS7cHrzyCE2fCNm2ANaTXj8KZ
	 A8zUwTCrkv53oyvnXBzhA6bhX+ZXJoL6ISbn7DToGkkz8Vcgk1A22kfNLGopuHZixk5ee
	 c9gpahHsFHfIGjIQyIBw/MGRm5qdCaaedj9xXiymWhWVnA/JmLi6z9sW62JPU7wWH5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254911;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OWULWeROBq9QHKGDrZtJVZFqDXu9makIQwCeo4uR55Y=;
	b=reijL5MAWROdQ9Ca7c3iyRu3tlGl07jUma7GDVDJLwKX5WpylFh+y4DrenCY9zArVDnh
	 /Z91bSU1akhDL88YYwSLAMZLwGvn4LDzhifABpJDCwY3RTQaLqcuUN9jEYC/1HIk3B2MH
	 +igm9sd7o1puezO6LyI0PMvcDeZs+KKuAEiEd4bxSM8cGboArGhwrkPzm4mAP2kx/+qnc
	 dggWcQdd5iXbVRL11pWj2kJozbkwAk7eshTgNHVx2fXLAPJbnGXHhULZ4GO2UOfp2JCxS
	 MiLIaTRYk3+t2j36hUCueMCSdaTtZtokBeVfS7WVuruOxqdqvLt0kXSOLzApTPVoaqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebfIBqRO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF5606A321;
	Mon,  9 Nov 2026 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebfIBqRO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794254910;
	b=yHLccIuQmJPWYHOtcIEc5bIKeRxIfm4l18ovjHGuSiyiIzWHrlGgNMNhtSXXm5YgZm7C
	 E24cYB/5m2u/WBCFbkJo53dttQV68hBhCrH3z6wzwYVhEbeRKD99Hf8G/WbR6pg9A7a+a
	 2rf6mPQIInlKt2ZWS9VbRZX/Duvu3tE1MkFqHOEfkElffCqPpLChr7qJksBUdiOfJFtbi
	 Qwajp2T2QtVuSJqW53bdn4P0I6ELtOQ9fkZgPYLLCH6G+TXe92IZL0koPP1g/PvPAjRwj
	 chneViDlhSOTUT7mCJ5ZcaXP3AoRxWPNlPUgcQyyIR6lmAHOrHjZEYDNJaDPCLG2C/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794254910;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OWULWeROBq9QHKGDrZtJVZFqDXu9makIQwCeo4uR55Y=;
	b=qB7ieS30qaawhMex0PT2K7XOd1hga4zJL3iz71tcNFik1SYIMeg73Br+TykVCOXS0IqC
	 JmEd8XVaaYQywUqGcihDyZsym/dLciVwojUCgUB8BCnQ10RoIcyh0p5DIpYNyQMuq+8nx
	 BYXoy9rr1ieyR9oSlPRhSoLCbDYevfdF/lvqj9TvjCagunCHC7+AgrdNEt/4UtAm9FxrF
	 C0ULI7lFzxPS7ZkpKhFOqiaCr58/cruG+ArDc/csJiV3tSTW3AgYvGri5/E5IzPgh+AK1
	 iJeMZm0hovRx7w+87ico1NNpZXhT9A9HMwRmb8xZ5rm0sMFZxii6hfaYTbcbUlsEVyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D46901F008A1;
	Mon,  9 Nov 2026 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254910;
	bh=OWULWeROBq9QHKGDrZtJVZFqDXu9makIQwCeo4uR55Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ebfIBqRODot7wOSzMTZg5MD9ozpqRtBARsY21u3s2GmfRN9iIl/sKm2WCpB4S2rDM
	 t51epgmb2erF4nAKJ8Wdt5VL1zLoCjUEzzVm4YVCEp5REcSoXsrHWDLRMeK6EWeiBe
	 L0amVa53SEGZtQOTmnFkHZY2tetvw+kqgXo4Rou4X5NMALcGNwfWdVXG7hOrhW13vk
	 Qwd64P8TBFy3v1uUR10l/CiCiw2puwgE7G3VtMWA5oYcp3D8r26D0dA6Zy818BSndS
	 XFqtok7+Ja0enXKm+MqcS8smpC46Tt2IXk5zsjQl4WF2I3v2p5iqYLoGHI5xHca4Bc
	 tZ5nZdXa1+Ylg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5FE0C48626;
	Mon,  9 Nov 2026 20:08:29 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Mon, 09 Nov 2026 21:08:29 +0100
Subject: [PATCH net v5] vsock/bpf: release sock lock while waiting for data
 in recvmsg
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
Message-Id: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTU7EMAwF4KuMssbIdtK0nRX3QCzy49IA6qCkR
 KBR706mLBihEctnP38+qyI5SVHHw1llqamk09JCd3dQYXbLs0CKLStGtoRI8OpnDQTIDFP6hMo
 geiLDI1pDTrW79yxts5uPapFVPf0My4d/kbBetEttTmU95a/9c6W9/M+TSi2HycnYDY7G3j7IW
 3RZ7qPsftVXAg+3BA0IPmDfseeoo/8rmF+B0N4STBNCH7XtUQ9k4rWwbds3J8/vrk0BAAA=
X-Change-ID: 20261001-kbh3-1-022-fix-v2-e3f14290641a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794254908; l=5966;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=gAMP05v48lA79FLWFALXd9zeaNzA0SUA1TvaXrc531E=;
 b=MuAaoC1faU7y/6OsXRinifDWmeyjxYlifpBjeMeeVMCUz5e3BmcfGP4S3n/tMEixejmsuZtB6
 4LMrBMbv0c2BKMjd1OG1HqhbS0uPowujNLWIg2eCPSTIa1QrJh4yRPu
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() sleeps in vsock_msg_wait_data() with the socket lock
held, so the virtio delivery worker, which needs that lock, deadlocks
with the reader and all vsock rx on that worker stops.

Release the lock around the wait. The reader can then wake without
data, so the wait loops until data arrives, the timeout, a signal
(wait_woken() returns at once while one is pending), or a state in
which __vsock_recvmsg() would not wait. Those states, and zero-length,
MSG_OOB and MSG_ERRQUEUE reads, go to __vsock_recvmsg(), as Alexei
suggested; a non-blocking read now sees them before -EAGAIN. The loop
and the zero-length check belong to the fix (without them the reader
returns early or spins with the lock held), so this is one patch;
MSG_OOB and MSG_ERRQUEUE just share that path. One tested difference
remains: a reader asleep at a virtio transport reset gets -ENOTCONN,
where a native socket gets -ECONNRESET (0 on seqpacket).

The deadlock and the MSG_ERRQUEUE case were found with the help of
Anthropic's Claude, the rest by the netdev Sashiko reviews and Alexei.
Each was reproduced in a VM without kernel changes or error injection
(the resets unbind the guest's virtio-vsock device), except one Sashiko
case that was checked in the code; with this patch they behave as on a
native socket apart from the reset case above. The vsock vmtest.sh
single-VM tests and the BPF sockmap selftests still pass, though they
never sleep in this wait.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
Changes in v5:
- One patch, using Alexei's approach: in the states where
  __vsock_recvmsg() does not wait, and for zero-length, MSG_OOB and
  MSG_ERRQUEUE reads, fall back to __vsock_recvmsg() instead of
  copying its return values (Alexei).
- So after a reset, recv(), a zero-length read and MSG_OOB return
  -ENOTCONN, and a peer shutdown with SO_INQ reports SCM_INQ, as on a
  socket outside a sockmap. A reset while the reader sleeps now
  returns -ENOTCONN instead of -ECONNRESET.
- This also covers the netdev Sashiko review of v4: SEQPACKET after a
  reset, MSG_OOB on a closed socket and SCM_INQ on a zero-length read;
  SHUT_RD with a pending sk_err by code reading only. A SEQPACKET
  reader asleep at a reset still gets -ENOTCONN (native 0).
- Don't cite the selftests as coverage of the wait (Alexei).
- Link to v4: https://patch.msgid.link/20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de

Not tested: virtio-mmio, repeated runs, a sockmap delete while a
reader sleeps, a signal arriving in the same wakeup as the timeout
(returns -EAGAIN, native -EINTR), and the vmtest.sh ns_* tests.
Still left for separate patches, as in v4: data that sits only in
psock->ingress_skb, and READ_ONCE()/WRITE_ONCE() for the lockless
accesses.

Changes in v4: comments, one data <= 0 check and message changes
(Stefano); rebase; retest with a new dataless-wakeup reproducer.
Changes in v3: split into two patches (Michal); end the wait after a
reset read with SO_ERROR, and MSG_OOB returns -EOPNOTSUPP (Sashiko).
Changes in v2: loop in the wait, len == 0 guard (Sashiko); MSG_ERRQUEUE
to the native path.
---
 net/vmw_vsock/vsock_bpf.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..c0c9e69860dc 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,35 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
 	return vsock_sk_has_data(sk, psock);
 }
 
-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
+/* __vsock_recvmsg() doesn't wait in these states and knows what to return. */
+static bool vsock_rx_done(struct sock *sk)
 {
-	bool ret;
+	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
+}
+
+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock,
+			       long timeo)
+{
+	int ret = 0;
 
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
+	while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
+		if (!timeo) {
+			ret = -EAGAIN;
+			break;
+		}
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			break;
+		}
+		release_sock(sk);
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -80,6 +91,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct vsock_sock *vsk;
 	int copied;
 
+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
+		return __vsock_recvmsg(sk, msg, len, flags);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return __vsock_recvmsg(sk, msg, len, flags);
@@ -102,10 +116,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	while (copied == 0) {
 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
-			copied = -EAGAIN;
+		copied = vsock_msg_wait_data(sk, psock, timeo);
+		if (copied)
 			break;
-		}
 
 		if (sk_psock_queue_empty(psock)) {
 			release_sock(sk);

---
base-commit: 6d2cf411aba2aa0bd641b49be5b1964ac5097a50
change-id: 20261001-kbh3-1-022-fix-v2-e3f14290641a

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


