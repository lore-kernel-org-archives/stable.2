Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689797;
	b=YPU40nElBKgPRl89w07K3PPdTnzTwepoRk1k1JSX62JFyfbYEhi0zE3+eAv4zVnLw28m
	 av4D0jFUv1GnPWSekcRFguc7x7BioxGzdzsS39j6ECE36Ba9zHFBlb4+QG/FAH4uWcAGT
	 JIFppkiIB/Qk8Z149LZH5mth5chec4nO6K9XqqluXwEPdBhjmRe15uOXfSiE6gJmBQ6SS
	 YfqMb95rxNRF1Cafg0tr5R8LMeZhh7vXHQVovvraUq8sjkoWsDXjQSSjRWTxUAZM8ll2x
	 elxIxANsI/emzo0QJSczv7f5V2HsBGuYY3NPWm/nTOo0/nxNriPC3KQp3EMgw/iehbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5U5ZS2kKWeBauEWeke7Sqh4UVp7AfpayUDdeAYGS/kM=;
	b=142w0ivCYiTTr8uHD/8qj8kp6mjAQtMp6Y91LqK78RR63k2ZYXET+uuHR1PK389TTHom
	 d48PQsIdwJq/3L7evyc32+Sufv+JYYwm4YedXMZiTAt6HZ/H15NIiWNHu5wDops5ktvhn
	 linZA+111oeA97WyuhGRC7PSWMfd9tDGgSTgyxsUwyj+hojoLKnjklu8Ku48V93+z4vYT
	 Mtd+aWg9XTm0CsvrfEICLGsfLvptzJVDFAWQiap7RibDKIu8wHb0BbOhpgaDykzaZjfG7
	 f8vxcdWuctCNU4rOYxIfuPnuMB5PGfeGwODby36F7yTbvUsmsM4DkWnoBMLKOSJ/e0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs8jSEyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B62606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs8jSEyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD61F01825;
	Thu, 22 Oct 2026 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689797;
	bh=5U5ZS2kKWeBauEWeke7Sqh4UVp7AfpayUDdeAYGS/kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bs8jSEygXw2wnsO+FK5TvZVqSX78NvobCq0VdNKKyhnRAJ5ivh8Fc0WsjuWL70TqP
	 2VlFeiRTel++TJYyMgcSFoAOi2L/X4rhH/hN/fZ8w5/hSfYqksfIIiMp2RVdk3bb1M
	 tdHPNcAJpjNrlfwAorkL3+r9c6V53lRfLO84YaH1aHJtLzU/CRCuoZmp/HG4MHpK62
	 RP6/VuNWwbMOOfYoZAM6KdsqdQbp7PV8DJ7ZDLcmWOQAcLXdu2e4+Z2r+QutlBE0Gn
	 ZltEL0arl43fFCXApHtnBAZh6ky31XBMuLCiyfTYJ+tsPXxNyCJ56dxLEByCZ83wJi
	 G4RBmAe8cNOuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vsock/virtio: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 13:23:15 -0400
Message-ID: <20261022172214.1774645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102110-kerosene-charting-8340@gregkh>
References: <2026102110-kerosene-charting-8340@gregkh>
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
[ sashal: adjusted context for vsock lookup and reset helpers without network namespace arguments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 1820b87b8b7ff..d00f017948ed7 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -210,6 +210,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
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
index 8be8d7c55034c..9d6dce5311990 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -334,6 +334,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
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
index 16431ef52799d..e6e04cbb7a4be 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1470,7 +1470,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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

