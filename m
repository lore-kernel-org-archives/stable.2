Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6B2C15BB
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150772; cv=none; b=gul22A21v1p+DG77V54G8r9qj0VCQBiP1tyP4BUyCp4nIXNzU0Kyg+ujKoiiuuicoLGDscTANUVuVHp0l32YCL4LlG/RPxezELvfZc+w1rnN4ek7wWmaSdQDYKGw+L9h/z+EBOWIzQGA70tukdemLv9LqNngeC9XxKJ4lHhMrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150772; c=relaxed/simple;
	bh=XWGFF85efp8loaUsxEgnPPXIMOoK/Lv1ZyIBBVnjjxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf6oFfhKJxwCI3yhaQFcFeAXX2Nn2ZPIKun80BBiFVhSUGDkcSmtk9hzph0aLWtK69w4ODF1e74ClhOJHb+RFiCOciI3BupQDhO9t4IJ9bzsSHSNLIi1ImCpiaM4kL0JXV1fbZY6MohoXr+A3JYqDrgO0HMtiDmeNFw/8IUiJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAhPevMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAhPevMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699F41F0089A;
	Sat, 30 May 2026 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150770;
	bh=hzi5duAPx8bZfoNUQpBMPnQBKc+tIapvM4uwqy70WYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EAhPevMpUro1SojOt2ZIeIB3G88PwNu9TwrrJPJ/bJCHyUA5+JgGfrYRxL69v1pWt
	 RSh2ISKzTEIxfmIrMpa+OvEbxQjaT1/SyyGAVd5T/1jW8G3INQOyWinzYcx1Z5AO9Z
	 maV79MyZg+XwBz504ygW2Zr9Iec01ivVlFXpFxGhhEiMWgi1aWu/0gmtiJJmQymDqb
	 x6vb4POns/BNH3xLNrnCtitAhRaTN2z8FP3X0BjSlO/CWgZXu8qQ4KGdB/G6uUwS0N
	 Ugk8wOTREb7Gmv5yVt3fLaDVk9hHFMsyF56ETPYKFGvWxtyAfXwzLpvEdnYXIxdl/O
	 Eyt2ivG5fZvOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] vsock/virtio: reset connection on receiving queue overflow
Date: Sat, 30 May 2026 10:19:26 -0400
Message-ID: <20260530141926.2406669-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141926.2406669-1-sashal@kernel.org>
References: <2026052842-catering-overfeed-07a0@gregkh>
 <20260530141926.2406669-1-sashal@kernel.org>
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
index 52a8a7ffacf5c..966a20262d46d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -920,7 +920,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -935,10 +935,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	/* Try to copy small packets into the buffer of last packet queued,
 	 * to avoid wasting memory queueing the entire buffer with a small
@@ -968,6 +966,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -980,7 +980,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
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
+			sk->sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		sk->sk_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
-- 
2.53.0

