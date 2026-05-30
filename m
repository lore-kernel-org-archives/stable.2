Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E793AB274
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141252; cv=none; b=cfzlq/rQnUC4AJuDDhaumYpo1Z/VPL2czKfzCBSlQ8CrfSpqCPpIbkwXP+8I/L0Rf1RodJp6COZx5bdeiB6Qy5bYrqvVwwa9CCg5VTQaLt54dCKkhfffi7QnOylL0k21NVMqjexv7o6lLnSJMOJNYBo7ylJmPtYl4NqCl+k/1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141252; c=relaxed/simple;
	bh=5oqLrBeKdZjv8hB8nzqPTZSeNhUt5+QBQ7CZ/v3+VUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L17y0GI9wIXy9cU6Iyv1vpY8MhC+5r9chvq6byGexCfaFtNqrTaGjEH5VpD3OGPIegFs0SLv5tiOthm0FzZMXygHX6fo/5ctZTr5M3kgmi3mm85zjVND5WrTdlLVjXULZmdP56qglNyrZv6Meo7CD7tJ1EFv4fM34xe8N2+iInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcdcWldm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcdcWldm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6282E1F00898;
	Sat, 30 May 2026 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141251;
	bh=o5yq2zQTJiPiu6fSRzpNtJRrf9Clz46Zan0s6UGQdEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcdcWldmpOltm5jmCWXNdOuD/E+mI8s4rb+gK3lFI2Avm3b9RQrHAdM/Cs2TZ0jQZ
	 rJWtwYmp+hmGg7ifeS46ZZgnT5VwGep4xqi4Wf4396FifKkqrsci+oPAayyTj9JGmg
	 +hXhqEO63MDzn/OEJzAsTJ7Jt6qICFqoAvDctKKKNLa87Euf/ioGEgEK1wYKjB1IYA
	 Bwswz+/DbXSsxIOcWMU65YMFCG3zJOz5kNn8PTIONLvfuvSXBUQNRW1nhBaSNPVufB
	 DSCZBVNbNljzfl9oCP1iFLC6vXG9i+BhMlrN9FVFx/2P5O4ZtlBFihXMJW8lMk2B5R
	 QTq2E8Bz2SiRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@sberdevices.ru>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] virtio/vsock: don't use skbuff state to account credit
Date: Sat, 30 May 2026 07:40:45 -0400
Message-ID: <20260530114046.1945359-3-sashal@kernel.org>
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

From: Arseniy Krasnov <avkrasnov@sberdevices.ru>

[ Upstream commit 077706165717686a2a6a71405fef036cd5b37ae0 ]

'skb->len' can vary when we partially read the data, this complicates the
calculation of credit to be updated in 'virtio_transport_inc_rx_pkt()/
virtio_transport_dec_rx_pkt()'.

Also in 'virtio_transport_dec_rx_pkt()' we were miscalculating the
credit since 'skb->len' was redundant.

For these reasons, let's replace the use of skbuff state to calculate new
'rx_bytes'/'fwd_cnt' values with explicit value as input argument. This
makes code more simple, because it is not needed to change skbuff state
before each call to update 'rx_bytes'/'fwd_cnt'.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 0742653e2b915..441ca63743ce3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -244,21 +244,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 }
 
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct sk_buff *skb)
+					u32 len)
 {
-	if (vvs->rx_bytes + skb->len > vvs->buf_alloc)
+	if (vvs->rx_bytes + len > vvs->buf_alloc)
 		return false;
 
-	vvs->rx_bytes += skb->len;
+	vvs->rx_bytes += len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct sk_buff *skb)
+					u32 len)
 {
-	int len;
-
-	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
 	vvs->rx_bytes -= len;
 	vvs->fwd_cnt += len;
 }
@@ -393,7 +390,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		skb_pull(skb, bytes);
 
 		if (skb->len == 0) {
-			virtio_transport_dec_rx_pkt(vvs, skb);
+			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
+
+			virtio_transport_dec_rx_pkt(vvs, pkt_len);
 			consume_skb(skb);
 		} else {
 			__skb_queue_head(&vvs->rx_queue, skb);
@@ -447,17 +446,17 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 
 	while (!msg_ready) {
 		struct virtio_vsock_hdr *hdr;
+		size_t pkt_len;
 
 		skb = __skb_dequeue(&vvs->rx_queue);
 		if (!skb)
 			break;
 		hdr = virtio_vsock_hdr(skb);
+		pkt_len = (size_t)le32_to_cpu(hdr->len);
 
 		if (dequeued_len >= 0) {
-			size_t pkt_len;
 			size_t bytes_to_copy;
 
-			pkt_len = (size_t)le32_to_cpu(hdr->len);
 			bytes_to_copy = min(user_buf_len, pkt_len);
 
 			if (bytes_to_copy) {
@@ -494,7 +493,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				msg->msg_flags |= MSG_EOR;
 		}
 
-		virtio_transport_dec_rx_pkt(vvs, skb);
+		virtio_transport_dec_rx_pkt(vvs, pkt_len);
 		kfree_skb(skb);
 	}
 
@@ -1064,7 +1063,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->rx_lock);
 
-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, skb);
+	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
 	if (!can_enqueue) {
 		free_pkt = true;
 		goto out;
-- 
2.53.0

