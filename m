Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657556;
	b=09kOz4p6yijB+kXbBMPZsL9MjmRx9mkyo6KRjfWmGhjEa1PKOi4jfxzJsVw5iF+v+GMu
	 6e4R+8W3C4lY+X40r8G2lF98x8aTGc7kypE+/wZ8M9gX8Tww5h0u5eH13EwAMVjc3UZ8S
	 63UeLAoHmoNfX2JWT0OKULVQ0xpGOyP+Qql1tJcQqcLbcgK8F+lRkwS2Y3y8opOXy0Llv
	 96D3Ied6IpAtoMc4tzLjRtGvS23p6HSpvCy+FkQDsLy8NtFJ3dNRO8DRJwVvS84I5FuRv
	 7wMNzS09MU4ekfeg+pWD8WFHI7eAhjcdA+Www+T+eggqw5ckOT2S5dRRz1TGJ/2gqdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QyifU7iv2k3L10P848nrkqXZFSblfaKGRCoDXH9oME4=;
	b=V8h39fBLbRmn4FJkuDuw/taM9NeDSVTvtg2jIIVuNCcePQXqAy9KMZrdBhCeUWE+cQFq
	 envXwU99c/R1Gn3+UCB45w9nlS/95eHlURW/UXCcghFG9xztZTmyM/Yin/9wub15/8Sil
	 3ZwhCMFuMvAIO+KWbsACRB6ryT8CfvWav/jyeIX1Qgj9JbqUG8LfCPJUEjzDKJgZWNN/Z
	 HcSU1rehlxr5o8TJydn3Otk/blbxcGIvxF+R7CtLwwJwnQSs3moXLJ6eVBJ3Il+tcWRcM
	 r0JWXK6Q2ZClotLSybETuPF6P0zUZByvprQHCceu8/avYDv4AHNOchIxwBGkv8Cn1ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOsi7r9X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C271606A329;
	Sat, 14 Nov 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOsi7r9X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794657556;
	b=i13+MhTytVFHBFZOUEVy2CUHZAn1598qXkm2V/K6Z8eWsiRshy1+cPfSd+U1IudHlIcm
	 RqjnHrqrVm8twYT5ly3+apIP9Vf++gsSlIhnj90xShwPYCC/VXLbRGRtLrQjiBMFGBKdg
	 oj3YOXrOEO9gX3PjqL2Hz156c0KIDfJJbht9JIczw1gbkNV5Ls7xyyAd2PHsFJl/CXCiZ
	 YkXfibngtOPUiYC76jcjGeVkYagRxBqf/Bvw+2fBHyspEqR9DVugllJKe8sc/rb5lkDZf
	 nv2VW63Rlc68uFPM9SCgCPJkmfnPXnXWumIDjCxyaUIq33Uj7k5jfc2p3ftM/6HgUSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794657556;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QyifU7iv2k3L10P848nrkqXZFSblfaKGRCoDXH9oME4=;
	b=2SboHpeVDWvMougaBb+Oikv4JXwplavx3NLEqkE7BtaGkerC0SjxkYATm00g7TQs0DCw
	 BDTLZWByNfesoHVZ8zfrOjmDd0JaEYGEyu0n2/kwEd6RyDYVAM1ysaqQiNR2Tncnlb8g8
	 nPVxDBb4oyj6Y3paTiFvEdIn6J55H9K7N1L0RpFvCJXdAvBJb58Ei6l6CmSXrYoljd2k9
	 T8YZxTN2TbinI1/E55hjv9FtYtKBDGO9s/wxDa6CFAWHcaH7fol8CT145d6A42aXQzWSb
	 VaqAZv1fVj4z/vaN2hl/vcPF2cUzFZ1/x1Au2JOsfVzjbddImMcPwgRxj9V9WIUg09A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB81F1F000C6;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657556;
	bh=QyifU7iv2k3L10P848nrkqXZFSblfaKGRCoDXH9oME4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WOsi7r9X5ZgmrZKHJFvKhe2S2r+2nFiCYVFp8O6/JnyWrmpdyU7AgGRhezbSiHPov
	 uYb/KSeppPeVQKFMND5k93wcTSvT5HJKD24evR8YrPQkuJycrbPCqxs1VnUozAdIiY
	 VrmnOzzV0GH9JbO7yX0F/R9Lf/ZoB9w6QKxjFnwa4KQavjcLd6T0oJomUzdkkT1TYk
	 jsPszbGwJ3vwQnBpcqhTwvYAREOJ6AHwzpKI8qDtfhOb6Vb1DhjQA8qkHyqpT3Saux
	 wuV6TDyZvwaKJCFAMFD6IWVrpZb1gFasrgU0B1AmrlkbP6TrZzOnGfRlXmYocDDICl
	 mvi83LrYkOA1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4690949D73;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Sat, 14 Nov 2026 12:59:15 +0100
Subject: [PATCH net v6 2/2] vsock/bpf: release sock lock while waiting for
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
Message-Id: <20261114-kbh3-1-022-fix-v2-v6-2-96b6029bbffa@eldare.de>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794657554; l=3876;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=zKh/7Uqq17NlML/ztrwLxN7imFwo8STVIyMfCtn51P8=;
 b=ya6GopZ4hDKAtGvWAMvwpNAuKWBCDvuUjdlTBahAowEPw+GDQ4SNI7hi5ip0JOfTj+YGAEHBB
 8XJKYvXDWTtCn8mshSPblXKB0KPNxhgoBNRErigRPAZyJGhQWySzUWc
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
data, so the wait also has to loop; the fix needs both halves. The loop
ends on data, the timeout, a signal (the sleep returns at once while
one is pending), a lost transport after a failed connect(), or a state
in which __vsock_recvmsg() would not wait. Those states go to
__vsock_recvmsg(), so a non-blocking read now sees them before -EAGAIN.
A blocking read interrupted by a signal now gets -EINTR, or restarts,
instead of -EAGAIN. One tested difference remains: a reader asleep at a
virtio transport reset gets -ENOTCONN, where a native socket gets
-ECONNRESET (0 on seqpacket).

The deadlock was found with the help of Anthropic's Claude; the netdev
Sashiko reviews and Alexei found the wakeup, reset, shutdown and
lost-transport cases. Each was reproduced in a VM without kernel
changes or error injection (the resets unbind the guest's virtio-vsock
device), except the lost transport and a SHUT_RD with a pending socket
error, which were checked only in the code. With this patch the
reproduced cases behave as on a native socket, apart from the reset. I
ran the vsock vmtest.sh single-VM tests and the BPF sockmap selftests
with the series; they pass, though none of them sleeps in this wait.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index c9b399f37720..41307759da99 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,37 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
 	return vsock_sk_has_data(sk, psock);
 }
 
-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
+/* __vsock_recvmsg() doesn't wait in these states. */
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
+	struct vsock_sock *vsk = vsock_sk(sk);
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
+	while (vsk->transport && !vsock_has_data(sk, psock) &&
+	       !vsock_rx_done(sk)) {
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
@@ -105,10 +118,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
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

-- 
2.56.0


