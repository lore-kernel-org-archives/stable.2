Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328903AB283
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141253; cv=none; b=FOPw15AHmesUXy3Rgrxb06CxwCzzPP5DMPWvKFSfzekjGywgIEJZ06w9vMVOzJ5Kh5Q1qxqfVM4y1ixXmKViE2aFWtAIBe78Jqfvkmaa1CeOiGVrBlVYI+XxdRUTTh6AkGPmixZTHVTGMPB6BNORP5oTfaShxxaxXXZD3IOTNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141253; c=relaxed/simple;
	bh=/fCMtxJHBDmriaBO0rfkagHSE8XB9BQe5/qCuM9Ccpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewFdCvXT0JeX5+dolfCIztGfje0qmHk2l98Ij+Y9RrCUrM4AOQrYPt38XTt8zGlOp9T/N+pG5JxL6f7ikZBRJ8Lvh+j7DGOp0hw+VTSEjT/Pu0iZbk7/Q3H2tkcrstZrEzDttgjmI7qFrH6kMDLQtGAsei4xetiJ/0EOZKoRnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=espUjeOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="espUjeOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613EF1F0089A;
	Sat, 30 May 2026 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141251;
	bh=J7bJdJWTpfnpw/1GLCEPDCFx82m8DbdxLIB7FWGWEb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=espUjeOLIIWMggkuRejUAAbOYVstG1v0V2S1JnL9n+tu/BNpYquehO4R2M5faL3Ea
	 5402pqmYtZLnyIl3mD125yXF5+d6JUJvuTBlh+UAdlRELuXbtaOUlDDU3LOfcSJEgr
	 wY7IxS29ZN9Ozrnpw26zlRpT37zLBpyn5FspGzKGT+GBec7SCqhvrzE7EpXh/i8C3F
	 x1ko3dj4EsgjMCyqeQpmnpc/7L7QbMv87CP446Wc9pBUALNTdd9/Q0Dl8Qr+pXQosH
	 YuvuLiXGRqfBvZZZUo1JAEhBlg5ZLMBW+fHjiZg/Zrdu6z/P3wcBEELKm+zVDiIOQ+
	 sUAW/GCO2gQsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] vsock/virtio: reset connection on receiving queue overflow
Date: Sat, 30 May 2026 07:40:46 -0400
Message-ID: <20260530114046.1945359-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530114046.1945359-1-sashal@kernel.org>
References: <2026052841-mobility-surgery-8063@gregkh>
 <20260530114046.1945359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit a4f0b001782b21663d10df983b4b208195bec66c ]

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260518090656.134588-2-sgarzare@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 441ca63743ce3..4a0c0840ebdbc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1049,7 +1049,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1064,10 +1064,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1105,6 +1103,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1117,7 +1117,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			virtio_transport_do_close(vsk, true);
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		sk->sk_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.53.0

