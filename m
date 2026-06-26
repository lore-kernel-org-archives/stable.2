Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660630D3FA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481716; cv=none; b=LENBhWJAwBrA6OJKBYUItKPSwrq87IYnkyuYcSsNeUC/JcPzcAM3IqJuAOHuB5zC1PAOagyB/G9SbQbyayp6L2Nv8JxSs6DI6IGpa3jQ3RB4IgH6aRO+66F40JWMzHkAeMk4F+Jk/MX31Y0Q2Hq5IjnOswK15ObMH+sAsYCodjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481716; c=relaxed/simple;
	bh=kSmbivb2F6tEki0ZApRG80IjPIDJaaZr+UzUkrZmWM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNWW8ZqOUEqx0Sih0TpU1gXLss6+kHxTC5nkgb5g5Dhhm6frOLJn6F2bTUQyHHGQUhkzALeOTh5KEDSxC3a2brQqhPVVOZxX24G9Wu3rkaPygkmvIFg2ewybX0Nt4ueUA5XaTgipSCwcfEb+IhcN60m/K4Rr0JYWuB4Dw0nL8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YETV/LOX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sHVioXrf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YETV/LOX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sHVioXrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tejkhLdr0HnxxaNJljV7nQeGEFCdocArjm/M5aIQb7c=;
	b=YETV/LOX5srEfEoyBmdhBD/WGKCseugatTBEH4GnhVIxTzffLOjkDA2EW0TAoFtMvat5JW
	xXC1sbp6FM5P0Go42LoxL/6Z1CSfN1jI++XYRT/kJoxYSoKidRfK6HeFflEcXaIA/fG58f
	ef7/Ecj9EtGuBwoeShqCYeW6WRVsFdI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-D1QFQgWsObSHYv1oO5wGxA-1; Fri, 26 Jun 2026 09:48:32 -0400
X-MC-Unique: D1QFQgWsObSHYv1oO5wGxA-1
X-Mimecast-MFC-AGG-ID: D1QFQgWsObSHYv1oO5wGxA_1782481712
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46cd34a159fso172020f8f.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782481711; x=1783086511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejkhLdr0HnxxaNJljV7nQeGEFCdocArjm/M5aIQb7c=;
        b=sHVioXrfvlTjKJRSiyXEOBDhWbGBfjUTtuiMUL3+XC+w/SeuftPpAaMP8FQi3aRgTc
         bwGMditapjsgKcbxeIPOBogVhra3rq7SlRD91OSnH/CotKbRlOojPlyg3MZwWJwB9ANc
         xncASz5DNkGGkUNGFPmm8h5lWPULK7cEjnxJ5Ru3R3aUPf79ZG03QG36yOG4tI7Tdg9O
         OKBgW1uSjG31gwKvDxaiZzhOgKmLGQTwaDY6+ek+0qKU7n5V9AEDnBiGTpFqLz1AwLzm
         fTovBIytl8v52wUaEJOkUA2kAsvUn4Gbcd6kW1F104agk4ZC+cVvDe61K3FqLFb9uCrC
         nfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481711; x=1783086511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tejkhLdr0HnxxaNJljV7nQeGEFCdocArjm/M5aIQb7c=;
        b=bJdrR0Y/zYIIPQ9YBcL/ZCexWx8IIhitIUib4ZWr4ggEhVf2n0U+hRd8ToHCOD4dV6
         RRueoVUGxF3mmGNy6IdJauXWWrSWDRHUY9Z6fm6psNEtwOXAzZoeVtShdQ9sFzVNCY+p
         57DfJL3EwlFL5w9OKSZdQAp+dTWyXWisGfPz5e4CLF2ZIqJu6TiaxQrB4lXgRuFKf2gj
         4q4ZSUgozn48LOpQx0694YBUsW672TDWpL+8pniY/u5LhuhIY07WmBh16KJNjy00Frza
         obiRc60bbpjZ3gl3i/7fM36ueEAyOLs5Vkss4NDVo9IYSmWI602hNgPcysHdXL4k6Mhd
         Edgg==
X-Forwarded-Encrypted: i=1; AHgh+RpyKdnu9eKib/JIFXmEUi8pxx3ZuxEmCMtozHeWRpzIeZicCbUBEHJHFbREUKn5UrOLwRq/OLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgsaVqTPqUgPfU0tZdI7Sumcs983zETZI7QnWHuxBNbVbDziE
	raMkPzRtsjstZkDPzTz7ThSuc1k1nU1zasQyphc2nCWLeNYxShCiOhiAUXbFpEJwmQrpAO6mMP0
	zuSHj0HoAMBkhCf85tkkfpUA/VZRWCFaAOy8UA3yAoWAmPzgi6J//iOhLTQ==
X-Gm-Gg: AfdE7cnP9LbpxKXdfQaF5JnpdGJ6398vwWBwudbsgd6A6cAIPWZVgrh5gxv+q4Yh+Lh
	D4I4UnhzGV56uQVO7NSt1eaQu+b3w2uID3j354K1/JRxRaliNoj/0tkzfWcqcUNX6OIXNY2npF+
	sOzUdGDJwEm7c2y700ejKAmyiYoTKL+DDg6+ijcTgwuhVpkV7oxvlTSTE4sy99BXcOUWzUeApwZ
	Eo1w1lC5RVFb2WyIGVhwq9v1TIb2qf1ozVUpL0OF+2/I037x/l+BmMU0ZGLzzqScV+fZ6ctpKL0
	MhFjIzm6r5mndumkfeFz2LlLj7eioMqewZLSFvTCdNegoN866XvmLn8/tKWsD1zkuOoRhCrM+l+
	zE15qghnN079KW2WoJzE1hupLDZpzZFm0QWsysIJZk5tv2C8=
X-Received: by 2002:a05:6000:4552:b0:46d:cc92:e00d with SMTP id ffacd0b85a97d-46dcc92e132mr8992591f8f.43.1782481711427;
        Fri, 26 Jun 2026 06:48:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4552:b0:46d:cc92:e00d with SMTP id ffacd0b85a97d-46dcc92e132mr8992542f8f.43.1782481710846;
        Fri, 26 Jun 2026 06:48:30 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dd5f9da4fsm16443364f8f.23.2026.06.26.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:29 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org,
	Brien Oberstein <brienpub@gmail.com>
Subject: [PATCH net 1/2] vsock/virtio: collapse receive queue under memory pressure
Date: Fri, 26 Jun 2026 15:48:22 +0200
Message-ID: <20260626134823.206676-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626134823.206676-1-sgarzare@redhat.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When many small packets accumulate in the receive queue, the skb overhead
can exceed buf_alloc even while the payload is within bounds. This causes
virtio_transport_inc_rx_pkt() to reject packets, leading to connection
resets during large transfers under backpressure.

The issue was reported by Brien, who has a reproducer, but it is also
easily reproducible with iperf-vsock [1] using a small packet size:

  iperf3 --vsock -c $CID -l 129

which fails immediately without this patch but with commit 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

Inspired by TCP's tcp_collapse() which solves a similar problem, add
virtio_transport_collapse_rx_queue() that walks the receive queue and
re-copies data into compact linear skbs to reduce the overhead.

The collapse is triggered from virtio_transport_recv_enqueue() when
virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
to size each allocation precisely, avoiding waste for isolated small
packets. Partially consumed skbs are kept as-is to preserve
buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
message boundaries, and skbs already larger than the collapse target
because they already have a good data-to-overhead ratio.

[1] https://github.com/stefano-garzarella/iperf-vsock

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Reported-by: Brien Oberstein <brienpub@gmail.com>
Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
Tested-by: Brien Oberstein <brienpub@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..304ea424995d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+static bool virtio_transport_can_collapse(struct sk_buff *skb,
+					  unsigned int size)
+{
+	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
+	 * or are already large enough should not be collapsed: they either
+	 * need special accounting, carry protocol state, or already have a
+	 * good data-to-overhead ratio.
+	 */
+	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
+		return false;
+	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
+		return false;
+	if (skb->len >= size)
+		return false;
+	return true;
+}
+
+/* Iterate through the packets in the queue starting from the current skb to
+ * count the number of bytes we can collapse.
+ */
+static unsigned int
+virtio_transport_collapse_size(struct sk_buff *skb,
+			       struct sk_buff_head *queue,
+			       unsigned int max_size)
+{
+	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+	while ((skb = skb_peek_next(skb, queue)) &&
+	       virtio_transport_can_collapse(skb, max_size)) {
+		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+
+		if (len > max_size - target)
+			return target;
+
+		target += len;
+	}
+
+	return target;
+}
+
+/* Called under lock_sock when skb overhead exceeds the budget. */
+static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
+{
+	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
+	 * to avoid adding pressure on the page allocator.
+	 */
+	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
+						  PAGE_ALLOC_COSTLY_ORDER);
+	struct sk_buff *skb, *next_skb, *new_skb = NULL;
+	struct sk_buff_head new_queue;
+
+	__skb_queue_head_init(&new_queue);
+
+	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
+		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
+		u32 src_len = skb->len - src_off;
+		bool keep = false;
+
+		if (!virtio_transport_can_collapse(skb, collapse_max)) {
+			/* Finalize pending collapsed skb to preserve packet
+			 * ordering.
+			 */
+			if (new_skb) {
+				__skb_queue_tail(&new_queue, new_skb);
+				new_skb = NULL;
+			}
+			keep = true;
+			goto next;
+		}
+
+		/* Finalize if this packet won't fit in the remaining tailroom,
+		 * so we can allocate a right-sized new_skb.
+		 */
+		if (new_skb && src_len > skb_tailroom(new_skb)) {
+			__skb_queue_tail(&new_queue, new_skb);
+			new_skb = NULL;
+		}
+
+		if (!new_skb) {
+			unsigned int alloc_size;
+
+			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue,
+								    collapse_max);
+
+			/* Only this skb's data is eligible, nothing to merge
+			 * with. Keep as-is.
+			 */
+			if (alloc_size <= src_len) {
+				keep = true;
+				goto next;
+			}
+
+			new_skb = virtio_vsock_alloc_linear_skb(alloc_size +
+					VIRTIO_VSOCK_SKB_HEADROOM, GFP_KERNEL);
+			if (!new_skb)
+				goto out;
+
+			memcpy(virtio_vsock_hdr(new_skb), hdr,
+			       sizeof(struct virtio_vsock_hdr));
+			virtio_vsock_hdr(new_skb)->len = 0;
+		}
+
+		/* Cannot fail since src_off/src_len are within bounds, but if
+		 * it does, discard new_skb to avoid queuing corrupted data.
+		 */
+		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
+					       skb_put(new_skb, src_len),
+					       src_len))) {
+			kfree_skb(new_skb);
+			new_skb = NULL;
+			goto out;
+		}
+
+		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
+		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
+
+next:
+		__skb_unlink(skb, &vvs->rx_queue);
+		if (keep)
+			__skb_queue_tail(&new_queue, skb);
+		else
+			consume_skb(skb);
+	}
+out:
+	if (new_skb)
+		__skb_queue_tail(&new_queue, new_skb);
+
+	skb_queue_splice(&new_queue, &vvs->rx_queue);
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
@@ -1363,8 +1494,21 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue)
-		goto out;
+	if (!can_enqueue) {
+		/* Try to collapse the receive queue to reduce skb overhead and
+		 * make room for this packet.
+		 * Unlock rx_lock since the collapse may sleep or, in any case,
+		 * take some time to collapse the skbs, but this is safe, since
+		 * sk_lock is held by caller so no one else can enqueue or
+		 * dequeue.
+		 */
+		spin_unlock_bh(&vvs->rx_lock);
+		virtio_transport_collapse_rx_queue(vvs);
+		spin_lock_bh(&vvs->rx_lock);
+		can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
+		if (!can_enqueue)
+			goto out;
+	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
-- 
2.54.0

