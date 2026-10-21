Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597294;
	b=26KxmmBFKJes7VlTdMrgg4IUWl+TL1YD7oTg2xUZNf+nPLKrURnhcq2Of4pf91jkHOlL
	 HJ+t2tavNE0YDdXLnAMDO+fBguAlDklZxy/ubS5WAbEcmRQSKYQXSFeckQxBDp0Tf2S8y
	 SGGg9lZRZDb4qFiqEWSwyGqWVSeYHflLNrPor+hD0940dBLFGn7tR131kzkbiQPGbRCJX
	 1DlmWHvj92dIFxdZXiALlNDCmyDr4z1N7ikBsa9L9sIbQyfIEn+cUbfBWbfZxbFUS8/37
	 lUMmM86GprQSGIeDimCtuWo5L1r9ZVNfDz1wLpqlvGORfZDmf9XUVcvX5K71b7OFIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597294;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q8i4zzyUh4QGVmD1FBGTocuwh0DzJ5qTl5L1a4KLt3M=;
	b=WSxnDlVS602qNuB3yqyG6555PuNPMsa/9iIaJGX8ZnzcRRMnty6QBgYrZuYMJmjkjS8B
	 24HJqyIKPl4EqLMZO5H3Ga/CIGev+MXyw2STZ8BmCqdvZlVi9tiNV8mR5Uo1wVhd06Dn0
	 h7bP/NSB+967i27x7mBhfIds8ysxmI5yRxoCdfIniBPYDoGP8AQCTdinI1RGs/sP514hu
	 7Np3GRGVV5vZYTJ9c0Xv47XxnG71LaNtnFmDeYsUzjh/noczt86MZYnAeut6hhqZyJZ64
	 bNoeevaUTdkVunz39QTtskNXm2LDAWSmpcRAm67vQuSDWOXG847wYKjME+1WLTqS+yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qvApOIQN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442F606A331
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qvApOIQN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC0F1F000C2;
	Wed, 21 Oct 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792597294;
	bh=Q8i4zzyUh4QGVmD1FBGTocuwh0DzJ5qTl5L1a4KLt3M=;
	h=Subject:To:Cc:From:Date;
	b=qvApOIQN+GZRQUMY/Lo0JSUpfydg85wW+t+E4dLN9KE8rSpctj5ZqJbGZ/Z3x0pY0
	 dNGqfVd+RCDHkxb4MOxS81q6sVSQbjrS1jBzCd3g8KiqCoz0roLDj58PGRr6Ean5bQ
	 Mcs6A7yUkP4AeTQEzO+0UgOarrAjk3lTAEjHu+hE=
Subject: FAILED: patch "[PATCH] vsock/virtio: validate packet source for connected sockets" failed to apply to 6.6-stable tree
To: 4ncienth@gmail.com,bobbyeshleman@meta.com,kuba@kernel.org,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:38:10 +0200
Message-ID: <2026102110-kerosene-charting-8340@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dee44f41f206becb41c492899c1996cfd7f82a1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102110-kerosene-charting-8340@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

