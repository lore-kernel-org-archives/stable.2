Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696191;
	b=Tl8J83YIo+c3GhjO0Y+dN+uNyXMWn5sDmag5hxfOZj1qaEZ9EC3EgiZ9QCSBpzawj61H
	 KcM5GpgVHaos7HCAdor8MPf4RsoMrHdSfEJ8Pbnyk6YTvJwYsSq34TucQ6OjNBD1rmxO+
	 mCrenFKwIKzdbIJ+onHMylP3w7n/Nh8CMjas9rsraOzLAXlrhqZQ0rhs2xoXvsZip9pbh
	 CXnCmA6x4Jv3a4oDe6H+GmXIZWbaf3SbST2n4AFJPY0/9FPawmrzNDn8GhyltJ9cTd03V
	 EBdM+PPcx2MpAT9e0qJe0fm4oD5CAjjxWz0XJGhWF286E+5s+EGmzkNQ33K+dobak/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fCxZlEo0ucsHQqfC9SHZ/LmiNwn1AuS/FJ10XkVg6Bk=;
	b=WXj8L+nMq+/9HUkhvzbTRmq4nCU9alDMK2pSHJxxwxifzChq+Kpvzx+MBAIgBc59V5WM
	 AcdeSCTMvVrufNL0W+DCKPO6/atOjIBo8j8+SapOYvnhOxEZkk9zrltJ/jrqGtSfuAmms
	 Za3iXKC5InVjcF++dB3K0Id2ubKeEKpuerRYeJK0EymUfLmKKKW4/K/YQEmROnBUwXxko
	 WohJJ72KBbr7W6iaz++1RrMH0SEKjFs5Sgylq/N54Yi5wZ4gYuDn4l0yMxRQacKtRa0I4
	 0wx7z1DcCCEb0Dd58EY0nUG1ZjcKNQpr9GOvJwcXCmQZCJ2/2ZPPFGPJJNkWhzikt8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpJjs9LQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B671606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpJjs9LQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C274F1F01828;
	Thu, 22 Oct 2026 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696190;
	bh=fCxZlEo0ucsHQqfC9SHZ/LmiNwn1AuS/FJ10XkVg6Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpJjs9LQAEnEeV7cFO4vQLjr5KFi0LV4QChW5Iup5zQQRxowJb44dVTBQgu4jg6ED
	 QFmz/FOxwqe91yw9UBzjPAYWmsUDn3Y/7Uw4jxjlo8dGdRHp1E2x19q8mYbQPrHbvx
	 1RGWZLf4sFlGltrRTpUDje18zKtcDg73NUU1T/qNYW80xHX6EKMAw6AJg6XO++kr/l
	 6ipmQBRXlbDb+CLGZOvrpxwD+l/omEoRgXPaZ61e92iibSkly4SaWgm3GVTyt065IL
	 xXWeMXWHlrYPhvNOp1ce3NqM6opuwR6lIPEuwDnXdK5IPHry812rj7oRvJPSzGQSIC
	 aUsMUc7wRzYkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] vsock/vmci: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 15:09:47 -0400
Message-ID: <20261022174744.1757572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102121-anymore-operable-f7bb@gregkh>
References: <2026102121-anymore-operable-f7bb@gregkh>
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
[ sashal: Replaced two calls to the unavailable vsock_check_source() helper with equivalent inline conditions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261022162527.1685626-1-sashal@kernel.org>

 net/vmw_vsock/vmci_transport.c | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4f02a6f269cdb..df0c472f9dd64 100644
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
@@ -757,17 +759,32 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    (vsk->transport != &vmci_transport ||
+		     src.svm_port != vsk->remote_addr.svm_port ||
+		     (src.svm_cid != vsk->remote_addr.svm_cid &&
+		      vmci_transport.get_local_cid() != VMADDR_CID_LOCAL))) {
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
 
@@ -892,6 +909,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -900,6 +918,15 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    (vsock_sk(sk)->transport != &vmci_transport ||
+	     src.svm_port != vsock_sk(sk)->remote_addr.svm_port ||
+	     (src.svm_cid != vsock_sk(sk)->remote_addr.svm_cid &&
+	      vmci_transport.get_local_cid() != VMADDR_CID_LOCAL))) {
+		vmci_transport_reply_reset(pkt);
+		goto out;
+	}
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -929,6 +956,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
-- 
2.53.0

