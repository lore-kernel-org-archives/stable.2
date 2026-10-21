Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597303;
	b=0NbEI/Lag60YPeXs5VYVjaGa11MZH2w8W5CUXgNEL+g5krWLaj2JCjKMtGUK+9ewH7di
	 ka2JECyBIqueOczjhlRsChn1G7t6kgkybtx+FR8TIhxYG3tgJcdmjfHItT85zCVOcqARI
	 yPbkzbD4jYHgWlJrnMgYcfgY7dETSneodj557PEEIc/K50q6fgOwTj5rAGLpdeSrOVdtR
	 QufztUS9vnl/xtm/wd72HDcqyY0X9lFPJ+3sm6nhdCZZI7m5XqOukhSB8iK9+fY2Y1QG0
	 rNOn1+KEya0C8UpTSwSwdZZFhf91ekAcspWbC/c4D6dPP1Skur/Xicy2/QiNgblEnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597303;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZUo0k7u6oeqN209HMB1vDJZ637Rg1brqfObwic47jlY=;
	b=4TW1Ygw8f6G0teZUnpgGxdOC5zjRG5aIcuC0MOGNh94e0R7u7yoxxNGOTgAEbbUXKwy0
	 2IRGnoJgGbb9v7pFCdN79kmOj1BziqMbAQJNeY0A9tGpOBMqgzTN5Tb1qWT+FWN7NR3NE
	 fVEkFUr+M3cHGvQDu0gSEh3f+ohqpxJOB0zhYGAF/f6NXSqk2IWWOfL8vu+KuBfakz4Hh
	 COGyDs9JRmFk+SDPR/ea3VRCYtRkzr8HkeWjoQplJggs09LYJ+w6q+62zbtGIc423gwhD
	 wdke0jYXF6zrx9r8OU8k96FEmfYC+9EmzHaYeHn8v20WDEtjGbwVrS8lHK8Iqc7hp0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DFhSxc6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC41606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DFhSxc6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202D21F000C1;
	Wed, 21 Oct 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792597302;
	bh=ZUo0k7u6oeqN209HMB1vDJZ637Rg1brqfObwic47jlY=;
	h=Subject:To:Cc:From:Date;
	b=DFhSxc6+JxtvGwM9kuYjNt1Eh6QmgtrrOLN3zabiYfFWT5j4UWnAptsh5j8hg8UjH
	 oI/VJvJY1btTuBoCrmXa2TxVLFjM2p+rFO5ifly0xM5ybM6VfJAKueLQg+PqCdwlPL
	 XLrYXb8ta/Is1zLQK6jsui5KdguTcippEiSlY4O0=
Subject: FAILED: patch "[PATCH] vsock/virtio: validate packet source for connected sockets" failed to apply to 6.1-stable tree
To: 4ncienth@gmail.com,bobbyeshleman@meta.com,kuba@kernel.org,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:38:11 +0200
Message-ID: <2026102111-patient-zit-1fa0@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dee44f41f206becb41c492899c1996cfd7f82a1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102111-patient-zit-1fa0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dee44f41f206becb41c492899c1996cfd7f82a1b Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Wed, 26 Aug 2026 09:39:27 +0900
Subject: [PATCH] vsock/virtio: validate packet source for connected sockets

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

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 3357ee62d10b..5549298c1ec6 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -229,6 +229,9 @@ struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d381d..f840498b58af 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -438,6 +438,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
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
index 88df82364f77..f225f53ed4ba 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1836,7 +1836,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

