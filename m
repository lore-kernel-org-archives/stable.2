Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690638;
	b=KeO98lZMrJ0V0xzDg7rfUdgQn8CWR+HfvFv0fPqyBLkgzH6L8aw3AgpLWjG7yQw8egIW
	 8388GJD1/2/pyKlqLrvdEAfiIS+HAiPDV6hGwiabbu9hpLXRjoAnB1nIVSWrvnHf0MRtt
	 /cjgitaO/qKnegXDseS5LgH6JoaDVWl8Z066mN8Ejy//dMmxoCQozsVi++jYJuRap+ai4
	 tiwPcFGIpU+ePELz7tEEVrlJ1ND/5S+XTF1CKbUU+vk9OwGkBnWhJFKQXcTHtA5u+rboA
	 RKhf46Y2+9KlmoBEhZrl13e5ist1tkOE9xBdH+15Wi4iDS8f9Cv2RjfhhJ1b/fjIfAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HELI1dAAj3JoHmm7/ujLounOijlzjDcDTv5RfRVrWvs=;
	b=5Gx3radUIiulOue1Qi8SmIveYbBQIXn1xFTAFyzSCjrPF0i+e044uqMSygb5Fmv5YAv9
	 huud6GX1j30bkdCEJuMDZsABj2EZESZx32z09z8c4gML+pV9blPPJxQkgJ8eN388X5dh8
	 n35jA2/Ly/0iHgoE5Nh7KcjtzZIgnc7fdzfPIQb8dDgGsabQN2aA4nvfSQn+iImslEpkK
	 7lYGo1L8HCjPPZDNOlC9d1mwzCfz3MEcMmIGAmSHeC8z04U7CV26SKbQCOtwBXfpo/wZT
	 W7vBBbQYuaowtIhn5X+hJR5BcD8ae6auiPmCTJH/1ViaWkv62lI+I68BQYQFnDkduqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTYf5xVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78D606A328
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTYf5xVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F71F01825;
	Thu, 22 Oct 2026 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792690638;
	bh=HELI1dAAj3JoHmm7/ujLounOijlzjDcDTv5RfRVrWvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTYf5xVWE9+8sT+RC9XrypXlnfC+iCmRn1tSjRuzU/nwW2Jb3ZIavRbn0LwofBGNu
	 i/8eIVUb1ILUPs8I0ZiuLfOFoDTm5RsbxZf62G6h92VpMBwI3UOBvdR5GiAbkR2XKc
	 9B9uB7VkP5efyxUiXVLLejr0rna21Snwb3VtVkDf6CMJkvToBkaDaaH8vwB7RTbuSC
	 oy+uMmQpExd0BDEMnm3Us/fS5ucdHkdRGX66kjDx/JwnFkNYmSZIkVPS33GUXr2mtS
	 QJrkKYGZqop5pzuqV4ZgmStCdQenh2AaVJ5xB3C/HIXTmrp+igpwg95GHipyUPGjQ/
	 BhEh24tqHJAew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vsock/virtio: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 13:37:15 -0400
Message-ID: <20261022173611.1783451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102111-patient-zit-1fa0@gregkh>
References: <2026102111-patient-zit-1fa0@gregkh>
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
[ sashal: Adjusted context for socket lookup and reset helpers without network namespace arguments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 568a87c5e0d0f..a1aebfa14a3ef 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -207,6 +207,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
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
index 893893869fd45..5675f224ea7d8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -331,6 +331,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
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
index 6ea00b8630351..81bb95875f203 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1372,7 +1372,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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

