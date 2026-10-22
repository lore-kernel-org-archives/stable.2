Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686449;
	b=GJbmbtgxJURGE+Xin2+JWo7/6/S6RkJbAXJm39ndikGK5GigoZB2hde6Ty0mlaEX0J4v
	 2TfLVdaikgDVKym8EYFahO7UW8QWQEWVgUNgQQ4U1niiOxC4iTqT/rB/Q2uVWqvACuDnI
	 4w8QJ1nVIEMBRl/sDmg4EOJDVzYaiPp6oSCsq2cJEXnEVHAs5nU8O3N1qH3UT4F0WMGmn
	 0HH88kea1VBOpmDMVJtTKrx1s1YdBy/8wtKVUtEpU3vt70zMefm7ahoduXcPlrYdRBp7U
	 CoQbd8ZwvPYHCDWK/vhdODiri3Z2lrl2SklCQbeCMaFEcyyOkIyTbZ6zO5IAmy8Ptmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jihTn+mcQTljKex2cDRU3VG/1R27eCn8xbL4+Ox3VbA=;
	b=v/9uPpF6sVVDPa9VSg9TyR02d7dPh0Ow4PhsefMMvgwZ84KVRqMAOAcT67tHVAR5eIUs
	 CvgqEmx3+hUx87+V9IgqN2sETYK/rIW9cZvbDntASb1eh+49eWejuHCqb9aYdnwCI6lFR
	 wdM23y/CAqilMfjW7NZ6gSR7C2PxajkxdGsZdJDJjorH/AtWdd5xf5gOFgu3ELAYM6nvv
	 qe62RuyRcfy+QTFTvUIWND4qxkei52E3+Jhq1LF5QOIBr1hqdnL1x8SRG+bQHOnG0IViC
	 m/kWZAwtQNt+0jtkU2bWYmGy3apNv8Aw9dGjMHO62kI25VtaW7mOcvknKdE+VmERywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajmPvFBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3916606A334
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajmPvFBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10351F01829;
	Thu, 22 Oct 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686448;
	bh=jihTn+mcQTljKex2cDRU3VG/1R27eCn8xbL4+Ox3VbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajmPvFBRGs8hmuqsKSLD14VGVL01GW/FYyPNCYXHO9KY1jPT6ebKb3I5BggOmdBeM
	 +szko2+nthm3/tT3WlX68RGJUpd45ZNsLd3kdOqWhIlQK3uWPIZcKg90TyJ1v102D3
	 X93JH/2J9VLwk41ixHTybDmPrSzKU2CzvSm6F7WfjlpXnIm35yFGryxJvuQe3feAHM
	 bxFGDymgkLr4HHGs+LtwJMbTlGpzuUhXi2jMVrDJvc4hAXP+btd5/urX3S5vIyAcVx
	 UNifs9iQNQ7mJwvcCTT1vWvKcTMU8bHPxQ8bp+VuwsjfQJS8lk+84kTTQXDzxhoHZh
	 68cMoMd4VAVWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] vsock/virtio: validate packet source for connected sockets
Date: Thu, 22 Oct 2026 12:27:24 -0400
Message-ID: <20261022162527.1685626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022162527.1685626-1-sashal@kernel.org>
References: <2026102109-rival-yin-0759@gregkh>
 <20261022162527.1685626-1-sashal@kernel.org>
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
[ sashal: Adjusted context for existing vsock APIs without network-namespace support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e33..bb3af3e97e0f2 100644
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
index b02433aae57cb..049bd852e6898 100644
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
index c08fa44384b4d..9010d1a1535cf 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1819,7 +1819,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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

