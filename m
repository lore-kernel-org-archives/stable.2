Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706701;
	b=n4To7bp2u7nX6Ac2tmehrQ6Rg3XGgzqzYEavbLkkWyYJmiROaR/p+AT0r0vsK9ufpVgI
	 q4pAEdA6r/YkgEvlYRmfPFNoG6hI6IMEspLMobJdaukRORPmixmY/SJvDunSohFE+kh9g
	 JqZqayz/hhnc7vdxMx1E0YS0lZPMwZQyc0hDViYXluZTDPIuAPqHhuAbTc2NQPcvdbEVf
	 TGDpJ2Lcq6ohfCIceGLaYlY66M0I6zS9sbLVbEZlK/8DyPWMsj1xAtlT4q3nfSauzljpm
	 6ba7lf1LhCDiBICkzJx8FoN+eAwWxO/i0tmu7U+S36t2Vdg8jzxXjFX82l0S/fm5vTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i7lrPVm8MRgF6YudmTHBeomkmhZmyrvzU7FBuz4xZBI=;
	b=hWHXWlqEdzvsbHjqjCGXrm3+xHV/1/QtigNulwWR/5xIgBleKjlcVvaLiHZo8GjZYVl7
	 UedB262QnmOQhxfin1ub6YAA8vnrc2k8q+CSo1hyTxdQHikm57LRSwknOpOyFzqHzRczD
	 RKbnlYf0vX0cOjKYwdR9ex/eQ6C75NHFtrAaJ4IFPowv2TJrHVBMr4EYpXMKfa2KeEfse
	 qFkrEx2YcOVu6cvzoSCmhJDDenPKudCMWScxsDb7yAHv/fbfaaarfW40sHP4XpuHv9tOQ
	 xhssoLXldThWgm3Kg1+f5OeecAIlmzdkZVnNDOe7ZbXTBqnOz3ozNZuCGziFJj+3AqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPlU5aRd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6D606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPlU5aRd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AA1F01825;
	Thu, 22 Oct 2026 22:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706700;
	bh=i7lrPVm8MRgF6YudmTHBeomkmhZmyrvzU7FBuz4xZBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BPlU5aRdDJU+bH7IBnIrCIsLZIx9yMcQirr6e62M9xy6kmFEtd0N7vkfb+vEi9v/4
	 jtr3keHbrI5wXSzyxpuohwyHfT5XNurcI/So8+TlVrDnLhZowK9Y847QteJ3oi66CA
	 hflBPUtedioSHh5eOI+Si6Cy5PsaSTA10AJCABYRzX5jJ3cUtaqHWZf2US2UxfNsBl
	 nEFtQKMj7/Cf9cg7tv4zL/fWXn7heMQky07tLLfYPwOmNqDryVfZ1OIFrJfAjHtb6Q
	 YD1/DGL4ELQIgmrtQ8YkGlfzrAtmBaeG9nnbprIa+EHXYlna4Ml16iXdpw4fyi9pgH
	 aaHxwgDp38p2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vsock/vmci: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 18:04:58 -0400
Message-ID: <20261022220229.1986956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102122-provoke-waged-b5f1@gregkh>
References: <2026102122-provoke-waged-b5f1@gregkh>
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
[ sashal: Replaced unavailable vsock_check_source() calls with equivalent inline checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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

