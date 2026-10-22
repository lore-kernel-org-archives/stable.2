Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696247;
	b=Y14q/AVOUWJREasq6E3DleX29d2th8CNn0fbtOPEw8ussZDOZTUnTN+H1mK2FH2U1S2E
	 wR7ENtYevr7D3lqCOykozFmhmy/X8KRMMm2w+DTjlBITGuijEEXzbZGseqqEK8g3opwyV
	 46QvOaX90Q92xfRMPV4slPw+FDoY6tswq3UPeTurknFzoDbZa6AxA+T4Ul3yMvEQodsD/
	 1lifYK6joltimA5SexlkPA+tCtQ8cxV1mzORCa4/46cMu6H1P9bmjrtnJ+QMomxjx9ZmM
	 7oAYWKa2cmu+fGiqYOVDLXko021sst0REgcBpbjmVD2Wh0e1a9aZKHtBfExWj1LGL9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MFeC07KAH4GvpuKBWNAkiACw4RLLu07VaDPB38ST+hA=;
	b=5mYoaHbeH6VBQ+P/IswKMLcOzSNwWJYi0O5oLX7awGVtYNlsnyv2WfpCJbCaO+UChMeo
	 BfU8e2OpoY+GpK0vgutZBbvzzJTIUlulIONk3hPmpmNIHHKMxnKNcG5nnYh3ZVQ9piu+R
	 vTcP/YW8uTM+4twtxG3jN3lcz+Vpvc4MujJDMBRnMdfUNkPaKZN8njutpJsPlYeNi6AeD
	 hIY1wqaplIkUKT8w9rwBqZqvON4CEh1BVNq9sQufQV+LRBN315Rjm0gpxOBepmRJMaNJU
	 +j6pwoi5m/rmDw7XUDCFraXemEGZkuELPvipoBwGH89OvzngnaI8M7YBOgvL0ROF0Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kezVzHAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kezVzHAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E471F01825;
	Thu, 22 Oct 2026 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696246;
	bh=MFeC07KAH4GvpuKBWNAkiACw4RLLu07VaDPB38ST+hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kezVzHAaYgId9qad/9d9AxxXEj0NA5GwSBOJD38EaP+EgUDWyo0V2Qkm8pDyvMkJb
	 ewONd7xlaFiQcH39K9Tnp1/p5V8blgh6ngym4JSV8sVPcPctCvAKSi0ZF9FXRr4292
	 0NHX4eCUJO3BhcGwj/sa/RFd4fNANU91Nd1i98H+kOPFXvIjS3JYo+BTVSHuZivvz3
	 6MdpNfEqiWdRontAjpFqELxzXPF7bFt3BQQnGJU4aP7iKwHp9k+TJTiyWFXxqdAxnO
	 Vtx27XPWEWww1R3tnuISOJXe5bjJYFxRA6sZ0ZdLqpwR0vZZJ+jLMA2tlQhX99IZON
	 BMICCgesIrd2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vsock/virtio: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 15:10:43 -0400
Message-ID: <20261022190944.1791837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102111-scrimmage-preface-ffce@gregkh>
References: <2026102111-scrimmage-preface-ffce@gregkh>
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

[ Upstream commit dee44f41f206becb41c492899c1996cfd7f82a1b ]

virtio_transport_recv_pkt() looks up sockets first by the full source and
destination tuple, then by destination only in the bound table. The
fallback is needed for listening and connecting sockets, but sockets remain
in the bound table after connect(), so it can also return a non-listening
socket.

The fallback does not validate the source address. In TCP_SYN_SENT, a
RESPONSE from an unrelated source can transition the victim socket to
TCP_ESTABLISHED while its stored remote address remains unchanged.
Subsequent RW packets from that source are delivered through the same
destination-only fallback.

This was reproduced with capability-empty processes under different UIDs.
The attacker discovered the target tuple through unprivileged AF_VSOCK
sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
the intended peer-side socket read 0 of those 16 bytes.

Add vsock_check_source() to validate the transport, source port and source
CID against the peer stored in a non-listening socket. The local transport
is the CID exception because its packets are generated internally with
VMADDR_CID_LOCAL as their source, including connections using CID aliases.

Use the helper after lock_sock() in the virtio receive path.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20260826003929.966160-2-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted receive-path context to retain virtio_transport_reset_no_sock(t, pkt). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index f742e50207fbd..2b5dd17cb58a5 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -204,6 +204,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c89f7b2df4ec1..0712c8339f927 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -328,6 +328,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
+/**
+ * vsock_check_source - validate a packet source against a socket peer
+ * @vsk: socket receiving the packet
+ * @transport: transport receiving the packet
+ * @src: source address from the packet
+ *
+ * Return: true if the packet arrived on the socket's assigned transport and
+ * its source matches the stored peer. Loopback packets are generated
+ * internally and always use the local CID as their source, including
+ * connections using a valid CID alias.
+ *
+ * The caller must hold the socket lock and must not call this for listening
+ * sockets, which accept packets from any source and have no assigned
+ * transport.
+ */
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src)
+{
+	if (vsk->transport != transport)
+		return false;
+
+	if (src->svm_port != vsk->remote_addr.svm_port)
+		return false;
+
+	if (src->svm_cid == vsk->remote_addr.svm_cid)
+		return true;
+
+	return transport->get_local_cid() == VMADDR_CID_LOCAL;
+}
+EXPORT_SYMBOL_GPL(vsock_check_source);
+
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
 	/* Transport reassignment must not remove the binding. */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 12eb365c1603d..9216ffe6a88a6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1320,7 +1320,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, pkt);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.53.0

