Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210160;
	b=Cg+L8kYxLOSwk4k5NiR+jgWkn6mwpvwd+aw2ja9O5GfZ5cNwAF5VYGNI5GdLEOeygBM/
	 XR2lb1PvfPeKQ1iHn3FjGOtpMH0zKMi/YWspc6teFQLEr2KMdWlPc4fmnCOTLHKRDvEEK
	 UXiJ4VKdeoyWowCGGCxezLha3YvHA4vGxNjdUq2cd5iyRIp/Xc/VDYh7Qc9SM0J9UdwQM
	 kiVCeMxQ7RK0L8fc00zKL5c0v1xEdGXl8wvJyqpOEf+7yPck0RMjYwE6qGc5LjURySAMn
	 Fr37Lnsaxy9JOZ61eQpgtDPrVrFiCf8qy9aEnmGXOyAdCowyp0mWlOUYFlJrc5mU5/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210160;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B3Z8yibr0dNS80pUoWGrdQP0lvUWc3WoU/OtrkXqitA=;
	b=FMEOcCHEM7/qjTiIw3vbLSyFuP6U829SFYgUZtBM5dmSKC+uaRHUP6wVvYRgJ/3heOiv
	 rHPcppuDiRkMCKFe2UxFdutDEQdXyr0PWNZzsKxV1c/mTJZIEa4513dzwmOaZ04doeRue
	 rAJD82wO96jG5rs8qE6kixR5zG5qeGo0yJ9a51n8NKaQonp1rQnpHrCP/LTO+HPUm3tXV
	 BVAda+04oTzJ9NeGr30oLQOcKmVNEfvAMX0soKdXyNpEo8BcrATMMxqwvVCBlcka3kSZK
	 HW8skRkTHljmZflYunnx1Y35fS2a83XT4C3JwGWFoXA+rx/QOs+1OEpirC/h8bgU7PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XGBC/8/J";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F160A2603;
	Wed, 28 Oct 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGBC/8/J
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793210160;
	b=XLoPnOiWe+vWS7fjejTrEctD7ZXLYGNtP8GGqgopsFA/Eyy79fvuNflAKWROXWBL9LKL
	 RH04HaeB0DhEowzjZayjHrJOxudGncHWW9HV2tMVF9HHGMK2HxinSa122CQHe+rGuUxtE
	 1dq0SVTx1h5hyOh3NpjeGGJhq+vWOAml4DohCntY14YeXRQ0zVfbRvylvJcJxsNZ2CIdh
	 CmMFhExXijTrvrG+i2JicOU46trkplzARCkvQr1D/dH/F4cXHLeD7EJLfVnfHo8gpP15A
	 37JapxvxnASilm+MhFmhipHX3mVpnBXU/VEvfNnxVDwbfTIjvwFn75VEeg8CsQ7LLjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793210160;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B3Z8yibr0dNS80pUoWGrdQP0lvUWc3WoU/OtrkXqitA=;
	b=cWcva3ppz8GxhbjkEYXbJh8TPROQCQLXQg0zefOLLQrZOm/Y4xHwidakUHf9JwfherXN
	 rmQ9slsgaQ91Uz9eCFdkDiqMwwYjCYAi9nvpXIwIe+1XgrgoDv4qy/yYrzn4sfSeH0cVE
	 v8CoFDNHreLlaoZe8xm1eTsWzBDxcUNI2DrMu5XbwC82c+JF/bmh65A5qoL/tCtSJIN/C
	 OmJv+ajDg8jfvKr247w8D76TD/kzyW7LUWwK/czFqLVE3eRTaf4nRHprSDU8zErzAaxTb
	 JVVqY7/7seHHlQPcmlVAEbsINlROzuChzhXKZ7aj3e7XusbShOOTb0PbaqLC04tUO+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7291F1F031E1;
	Wed, 28 Oct 2026 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210160;
	bh=B3Z8yibr0dNS80pUoWGrdQP0lvUWc3WoU/OtrkXqitA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XGBC/8/J+T1IFpnUdKNc4sCuo2Oo3bVrgvo+8LiN7ovt2YgisidBXbOiOhgJBWVsy
	 D/bhBh4DSpAjh5JqNt3gUqZ90IwMxgXfAtlVgSZ4QsWau8USI16C4EWAsOeoKP9rDj
	 NlJNE57HKvkp8qitDlULVQixjVN0s7RqJZn2D85jyP4pnWi41zqb0b6l5BHXqg5ztS
	 v9tFABqQPmYlf6jNHEUAiQ095oBDA1pazfxPaPZApoFBuB2Fi6mb3G0+iF78p/FwVM
	 WiL7ENx/oxObI7cMsoQrJHclalLKxXIgCVEeYPQz1/yTHnN+kpmd9Mv0mgzRDB1uVD
	 oZKfXOm96YkbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0333E45530;
	Wed, 28 Oct 2026 17:55:59 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Wed, 28 Oct 2026 18:55:40 +0100
Subject: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting for
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
Message-Id: <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793210158; l=7518;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=qTxhMDMjhFbFejtDYQ+YtTIUqClmtxTEnQn6UzGFnKM=;
 b=J/vorB6US6gv5IOLiS2LZHCHqvl40aF+mykV+xkOCOUSuK6qvayIJz3rdnmeXZLAg3xK0P9IH
 mnMKqYXZ/ErCEw7TIMfDeGJC5J0fATwa1Whj/aQfXrW4ogyeHdqdzmm
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
loop, including vsock_msg_wait_data(), which sleeps in wait_woken()
without dropping the lock. When data arrives, the transport's delivery
context (the vsock-loopback worker, or the virtio/vhost rx path) calls
virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocks.
That context is the only one that would queue the skb and wake the
reader, so neither side makes progress: a blocking recv() hangs until a
signal arrives or SO_RCVTIMEO expires, and meanwhile the shared delivery
worker is stalled, so all vsock rx on that transport stops. The
hung-task watchdog reports the worker:

  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
  Call Trace:
   __schedule
   schedule
   __lock_sock
   lock_sock_nested
   virtio_transport_recv_pkt
   vsock_loopback_work

vsock_bpf.c is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
drops u->iolock around wait_woken(); tcp_bpf and the native
vsock_connectible_wait_data() also drop the lock across the wait.

Releasing the lock alone is not enough. With the lock dropped, the
reader is also woken by events that bring no data, for example a credit
update via sk_write_space(); vsock_msg_wait_data() did not loop, so a
blocking recv() then returned -EAGAIN early. It also checked only for a
local RCV_SHUTDOWN, so a peer shutdown or a reset was not noticed. A
looping wait must stop on everything the native receive path stops on:
without the shutdown checks a peer shutdown, and without the state
check a reset whose error was already read with SO_ERROR, would sleep
until the timeout.

Make vsock_msg_wait_data() loop and release the socket lock around each
wait. It returns 1 when data is ready, -sk_err on a socket error, 0 on
RCV_SHUTDOWN or a peer SEND_SHUTDOWN (as vsock_connectible_wait_data()
does), -EAGAIN on timeout and sock_intr_errno() on a pending signal. It
also stops once the socket is no longer TCP_ESTABLISHED, with 0 if
SOCK_DONE is set and -ENOTCONN otherwise, mirroring the state check in
__vsock_connectible_recvmsg(): a transport reset
(virtio_vsock_reset_sock()) sets only TCP_CLOSE and sk_err, and
getsockopt(SO_ERROR) clears sk_err, so without the state check the loop
would wait out the whole timeout on a dead connection. Data already in
the psock ingress queue is still returned first. vsock_bpf_recvmsg()
returns a negative result as the error and 0 as end of file.

Two userspace-visible results are worth noting: a pending signal now
returns sock_intr_errno() where the old code returned -EAGAIN, and after
a virtio transport reset recv() returns -ECONNRESET until
getsockopt(SO_ERROR) has read the error, where the native path returns
-ENOTCONN.

The deadlock was found with the help of an LLM coding assistant
(Anthropic's Claude); Sashiko AI reviews of two earlier sockmap patches
had already noted it as a pre-existing issue. The early -EAGAIN on a
dataless wakeup, the missed peer shutdown and the wait on a reset
connection were reported by the netdev Sashiko AI review of earlier
versions of this patch. Each reproducer is a C program run as root in
the guest: it adds one end of a vsock stream connection to a BPF sockmap
(CAP_BPF and CAP_NET_ADMIN) and drives a blocking recv(); the reset case
connects to a peer on the host and unbinds the guest's virtio-vsock
device, the others use vsock-loopback. No kernel change or error
injection is needed. The reproducers are available on request.

Testing: built a KASAN + lockdep kernel on net and ran reproducers on a
private VM, before and after this patch. Before: a blocking recv() on a
sockmap socket deadlocks the vsock-loopback worker (hung-task). After:
it returns the data; a dataless credit-update wakeup does not end the
wait; a peer SEND_SHUTDOWN returns 0; and after a reset of a virtio
connection (unbinding the guest's virtio-vsock device) and
getsockopt(SO_ERROR), recv() returns -ENOTCONN at once like a socket
outside the sockmap, where before this patch it waited for SO_RCVTIMEO.
No KASAN, lockdep or hung-task report. With both patches of this series
applied, the three single-VM tests of
tools/testing/selftests/vsock/vmtest.sh (vm_server_host_client,
vm_client_host_server, vm_loopback; 44 vsock_test cases each) pass, as
on net; on both kernels the host-side runs skip the SO_INQ cases (SO_INQ
not supported by the host kernel). The ns_* tests of vmtest.sh were not
run (they need root on the host). The BPF test_progs sockmap_basic,
sockmap_listen and sockmap_redir tests pass (767 of 767 subtests, among
them the three vsock subtests of sockmap_basic and the 240 AF_VSOCK
cases of sockmap_redir).

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 62 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..5120911b8143 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,55 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
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
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			break;
+		}
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -101,11 +132,14 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
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

-- 
2.56.0


