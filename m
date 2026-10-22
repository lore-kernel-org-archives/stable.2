Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689103;
	b=MSWafgXhSv8xGW8m1Oxiu0I5P9R9u/KCDk1kQc6Px0rS48WTqNsizhFLpkDXhL45DZ1g
	 lkM42KjYfJyQZtcWvJ6RVWzKD6gA/QcWhukzupaHgrMHhJLUbZ0ByG6sr98BLi76GmXUn
	 1jGqtySrm5oTFTFrR7YVx4IsjdTyF58v4PZ2x2xqFgQdZY8qv/gZR6S3hZjgEshfLlXMw
	 uFuVeDiKLjnyOGLe3BX0Cc5rofkaOI6VI5Qv1wizxNIsWIbZCfY82vmFnjPGHwa6aahRS
	 V9hPrmP5ynhOo1SCSm6ZwDzar/BRW3xD5R5bHNzNRISBaBwUI2txysQL47v33/wapHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xzcs4Is05M4RgjUyVw2eCgUKNMuM+8vsPDL9M5kZvM8=;
	b=HluFqxrSNu7okgvI003qznm7VHkQRmZ2jER6Eqy/o+TAk111ZT6g4T9jMjS6KUDeVNhT
	 HlKzL/UwtommailSh1QshTadkY8B6krPWo6l/DWyMwjc+F72154LajK8nQsa6ZAFM7yS4
	 WaWg+4uVSrLLrvzho7mBCyv7NLTRIXiGI9HeImqef/xz4XrcaziIFrGxFx19P91wwGby5
	 DULMs6N7xPzkm4Sd/csAzlI6455okJ78xgopAr94AEsQseRFuWXUoF3B/B1neybCTF6Su
	 dAz1PSJB27ZGe03IOqv+AU6GjXjwjMAtvboJbs8Id9DOmFMNvcW6bRs/dnnTmIcrihA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOW078k7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33095606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOW078k7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1523C1F01828;
	Thu, 22 Oct 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689102;
	bh=Xzcs4Is05M4RgjUyVw2eCgUKNMuM+8vsPDL9M5kZvM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOW078k7UMYAExs5Y+Mow8zDtWrqngCJNaFOPj3ojHHNldCq+jLLTATTkaK6yL5Vi
	 r2fA1NAwkAyYItb4kDqPRXw5H3YperNEQseUWwZAkdegUMtmUVbWPUcdDvfY2ekKSo
	 HEM5d1nr1kvl+p+FWUyzv9fiDgzwYCRRat8twSG5TvQRU3hPAZe1zeh5KoD3HeKUFp
	 JmvFlZFdfBi/3BoQ4ER4P/aVbm1nV+YmtGOntb+XGnTRw3gQ4SkMOceGdHjgbPOglj
	 7rJcYCpfNccay+xa0ACKcpLIKoXTfw4Nuc5ZdAWX6H3eoURcCbAX7/OCEbGQRwzNmP
	 +nIS9XY+0TmQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] vsock/virtio: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 13:11:39 -0400
Message-ID: <20261022170952.1760451-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022170952.1760451-1-sashal@kernel.org>
References: <2026102110-finalize-subpar-d30e@gregkh>
 <20261022170952.1760451-1-sashal@kernel.org>
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
[ sashal: adjusted context for socket lookup and reset helpers without network namespace parameters ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 70302c92d329f..20bbe02d2cfc5 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -216,6 +216,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
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
index 228e45bf2d769..999cccb323f79 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -335,6 +335,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
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
index 75df280bcc81f..cf7f3dcc075c7 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1837,7 +1837,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.53.0

