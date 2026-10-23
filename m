Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717195;
	b=m7+k1Gnfaq7r3lWWxrtbuWSDl1cE3qLyXXOGpsdfbBP1EgQi7swugoIbV9ISlYjPHTSC
	 /FE9k9U/Cqhen7mVzvRWBVByhHfg0ZnbJwmwa75JQ/d0TCgWOPNE6lUFiG8Hh1BrC6pRk
	 s6JenP7ayOc+QncLQgOlMRGzSZzvINDgWf6QiU8jkYq1XeMONuraMSA541zHueLREN5So
	 Mr5phJ7OFramRyIqeZE36OgRHEA9a9mslknDG0xbWcln8VRtiffxewrAfMF61o4XFQI3Y
	 IeCmm0JLVtsmJEs3OhTbfba9XgpZOTcPxSrAUUgOM93jB68Jgb6HJ7SZ3cWgnnsQrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0We8xv+1drvoYzq4NADhgvvvTw/CEa1dw/7Hzvix17s=;
	b=SUd0gT7fIZVwkg0uvfKHiRMyJd9E2DVU2cxKCpyMlkeEbP5knI4WkIWYKarM7o3adgjx
	 LtU5Vig7WKGp6GnxHf0+TazHcWAX4PFcI4jhOOPrlsxt6aeFWr2mKRlpKUB2c1k6RzswF
	 7DgSC74af+e54Rjg4p8Kyo9UN23Mj3FI6XJDli2ceyfBU4aoNADYG2klacVvMZFME3itg
	 3TvfY3YaeEUXY86NYeLBHWJM1GEC0++uGtawhkZfR1kouZ3ti8POx3IqMcMjAdmXDoypo
	 NUKQaTJfMHKW/MIKuHtKJmdPyWRJZBaLLfQkPnAKWxanXiHHE7wD/DfUKw54UNVPhKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrnnYhB1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5231606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrnnYhB1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A364E1F01825;
	Fri, 23 Oct 2026 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717194;
	bh=0We8xv+1drvoYzq4NADhgvvvTw/CEa1dw/7Hzvix17s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrnnYhB1BMWfYR5085VYCV/s2pQhpCWV3Uef5piSJ93tJty918d1MEWvDmfglubzv
	 bF7b7PIduvTq93abHyAd22KIOmaEqeB+yOHR1mOn4yCZWge5oKXcvSS/xJc/lEQizV
	 10aey37iJJlXSc4jz5/MapnmwbwB5hhk67/U4S7HzAVaQLllDxdR1xqJSp6g2mqhEy
	 K1jyKYVu5OhkcZvXxEi8tmsD640hnp+XbYLVZ8fjgybuWpbc+CtSPIYKESJMF7Tfrp
	 fLBo9Z1BK4Ehd33jFxvY275CKMcSinb+5codemEMXUdTmCp0hn8NywvmspDZVfDB42
	 DvdgZUW8KkBjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vsock/vmci: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 20:59:52 -0400
Message-ID: <20261023003900.2252502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-partake-lid-6095@gregkh>
References: <2026102123-partake-lid-6095@gregkh>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit ad9a7da3fa39c2d616ec0dd3cf6e30531d032fe7 ]

vmci_transport_recv_stream_cb() looks up sockets first by the full source
and destination tuple, then by destination only in the bound table. The
fallback can select a non-listening socket without checking whether the
packet came from its stored peer.

This was reproduced with two VMCI contexts. A RST from the context not
stored in a TCP_SYN_SENT socket reset that socket after it was selected by
the destination-only lookup.

VMCI can process notification packets in bottom-half context when the
socket is not owned by user context, or defer packets to a workqueue. Use
vsock_check_source() after taking the socket lock in the bottom-half path,
and recheck after lock_sock() in the workqueue path. Listening sockets
continue to accept packets from any source.

Reply with a RST addressed from the received packet before dropping a
source that fails validation. This preserves the existing reset behavior
for bound non-listening and concurrently closed sockets without directing
the reset to a connected socket's stored peer.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Vishnu Dasa <vishnu.dasa@broadcom.com>
Link: https://patch.msgid.link/20260826003929.966160-3-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Replaced unavailable vsock_check_source() calls with combined vmci_check_transport() and vsock_addr_equals_addr() checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/vmci_transport.c | 36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 936cd088160c9..262062204168f 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -676,11 +676,13 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
 	bool bh_process_pkt;
+	bool drop_pkt;
 	int err;
 
 	sk = NULL;
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
+	drop_pkt = false;
 
 	/* Ignore incoming packets from contexts without sockets, or resources
 	 * that aren't vsock implementations.
@@ -757,17 +759,30 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    (!vmci_check_transport(vsk) ||
+		     !vsock_addr_equals_addr(&vsk->remote_addr, &src))) {
+			drop_pkt = true;
+			err = VMCI_ERROR_NO_ACCESS;
+		} else {
+			/* The local context ID may be out of date, update it. */
+			vsk->local_addr.svm_cid = dst.svm_cid;
 
-		if (sk->sk_state == TCP_ESTABLISHED)
-			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
-					sk, pkt, true, &dst, &src,
-					&bh_process_pkt);
+			if (sk->sk_state == TCP_ESTABLISHED)
+				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
+									       &dst, &src,
+									       &bh_process_pkt);
+		}
 	}
 
 	bh_unlock_sock(sk);
 
+	if (drop_pkt) {
+		if (vmci_transport_send_reset_bh(&dst, &src, pkt) < 0)
+			pr_err("unable to send reset\n");
+		goto out;
+	}
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -892,6 +907,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -900,6 +916,13 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    (!vmci_check_transport(vsock_sk(sk)) ||
+	     !vsock_addr_equals_addr(&vsock_sk(sk)->remote_addr, &src))) {
+		vmci_transport_reply_reset(pkt);
+		goto out;
+	}
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -929,6 +952,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
-- 
2.53.0

