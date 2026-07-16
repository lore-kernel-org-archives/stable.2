Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910553BE652
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219870; cv=none; b=IqEHc3QJ2n/HVwo3ISPMTGe1yL8e1//xg6BT65NZuoXfege+wEhhKSSxuYlTC6koMXqgx9hiyuiL5I3Sj6ctrG8Uvvx6oUbMgDrxw+spQiR3QGeUUNWjC2SgpB5Z2jJm+/OfJcLa6UBdHvOIHD8m7JDmlt8r39qIj1JGaJ4IUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219870; c=relaxed/simple;
	bh=o/HwCVgYgQFkz0/ODb7pKMxQLGAduLjD199HG59bSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwBX3FuPHDomhKGq8vNL50qltCkynyw8X2yFVzXD1rmMp8gnDFiWf0jRnMfvUOGVjEaWgtS1wrKxIH5+cLuZtMotS/DSJACOcfHs8UYQGyeqLPG+4f3qPgYunj0V3ixUZdY7dT7tKlVNAayQYxzO5t73ENCVBUO6mPB8dDb7ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7f48cp4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7f48cp4"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso6590459e87.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784219862; x=1784824662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=M7f48cp4I0hteFI5/USpDZwKw8qvmCAzFC8n/QB7fNdDX95CxoWBuu80JmXBzvpQL5
         +A1XWjIq+J8JdgUGBDIYvWTLthSNeQx2fvuvkr6bI8TBslhO/rjk0G1yoad7VM2OWv3n
         gh4J5gDfSLKeLCtuF/nj8zd/lT6mdhwwSr03sdkm3y4HTZD/kLDqVhYgvZdpZeEkV+iO
         4TrnEaKTvbopKIB7Ph8OZLM3r4ncsqPoVGkTa9GtHgp5RBl5o4coht+cD6eZDA0Z3uY5
         37RTWcQ/eqj15gEomEcIA+lVZP8yL8W4zf2auHajOx4rfbeViVscHWAZRLldN/TgWUSL
         wEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219862; x=1784824662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=nki5UWwrw0opLGQ1YEhmorCrgR+gqAKChUxha6Ws9urARXftYKyXyoziRfxRS4oNF/
         XZ3ap9tx8jTWdkB+4mz69gzQcY9yv9PNQ/SFogCZ0TgpFX4m67jNA2BkJD5Bin0+Xost
         rrSIPGA3A5z78PzyCcyEQUv7FqWvXZZbHn2/6qa6nFCnaRpb5gMpersNM4Vt8g+FGOck
         SiKYlTFA/akXiXWhLWFUNO6+gmLpBMVur0DArmSsUY3Gl2odExpBU9C+RW4675UhA7eX
         CrFtd/oG6X6S882hxe97/10IeeP6kfwIxNbFPCkL2MxCTY+hS6lFzDYyaJHc2JSDkhut
         /p5Q==
X-Gm-Message-State: AOJu0YzDVcpQE+iQsMklj1/1Nh4j2hRLPHH3pYWDJTQLEtHEhuJfiAmw
	g/I04SSyslMc7iuYf9WA2Vz+puUXunH9ZIEjfC8NuWkiLXsOo8ParAXBtUleTjo4
X-Gm-Gg: AfdE7ckuizs2GyUvyxl4fPhUrmGdQJv5GW7ifzfCXTt3vQi0z0gMj2pPfHc025Bo4bT
	01QpuQU8AJbsjZ9qAm4HlL/ORFX7j9vuS4iyuy/l7LqTQqKH03bw6zSYzY0rSHwbY+WSSrvAlIx
	nwLrFaDN9viM/eqgYJ3iZuWdcdpaGO4UUvwP+mqxpiws8q1TiGLTQg4qNVsVlMwFVVaHejMPixC
	6l13IR/NwBl0dCSn+eb0qGhnk9D7QTaOZKdQD7emBJVRuXLu4L9naXl/RX7XedF10b0FWsE1GVr
	mlA605XlzdcalU63KtZQbxUdX+yDNOm8UOA0aUtpXUFeAFOjberxsfYylLFrrQjG1HBVXzQmmUb
	SvkhSQtjL/TR77B6QMPG/cOgXUSwysF98SqFe8bzon+xRDvAf5yTMju3r5jtnZN+FXm0OAYSpTD
	o+QfzBoPW/
X-Received: by 2002:a05:6512:3b20:b0:5b0:21e3:672a with SMTP id 2adb3069b0e04-5b159b8b887mr2052865e87.56.1784219862231;
        Thu, 16 Jul 2026 09:37:42 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caaf468sm5164318e87.68.2026.07.16.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:37:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH 6.12] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Thu, 16 Jul 2026 19:35:59 +0300
Message-ID: <20260716163600.115458-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

commit ae38d9179190a956e2a87a69ef1dd6f451b51c4d upstream.

When a large message is fragmented into multiple skbs, the zerocopy
uarg is only allocated and attached to the last skb in the loop.
Non-final skbs carry pinned user pages with no completion tracking,
so the kernel has no way to notify userspace when those pages are safe
to reuse. If the loop breaks early the uarg is never allocated at all,
leaking pinned pages with no completion notification.

Fix this by following the approach used by TCP: allocate the zerocopy
uarg (if not provided by the caller) before the send loop and attach
it to every skb via skb_zcopy_set(), which takes a reference per skb.
Each skb's completion properly decrements the refcount, and the
notification only fires after the last skb is freed.
On failure, if no data was sent, the uarg is cleanly aborted via
net_zcopy_put_abort().

This issue was initially discovered by sashiko while reviewing commit
1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
but was pre-existing.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Link: https://patch.msgid.link/20260514092948.268720-1-sgarzare@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-53365
 net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++--------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 95170c7be758..aeb205e84bd3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -72,35 +72,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	return true;
 }
 
-static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
-					   struct sk_buff *skb,
-					   struct msghdr *msg,
-					   bool zerocopy)
-{
-	struct ubuf_info *uarg;
-
-	if (msg->msg_ubuf) {
-		uarg = msg->msg_ubuf;
-		net_zcopy_get(uarg);
-	} else {
-		struct iov_iter *iter = &msg->msg_iter;
-		struct ubuf_info_msgzc *uarg_zc;
-
-		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL);
-		if (!uarg)
-			return -1;
-
-		uarg_zc = uarg_to_msgzc(uarg);
-		uarg_zc->zerocopy = zerocopy ? 1 : 0;
-	}
-
-	skb_zcopy_init(skb, uarg);
-
-	return 0;
-}
-
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
@@ -321,8 +292,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
+	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
 	bool can_zcopy = false;
+	bool have_uref = false;
 	u32 rest_len;
 	int ret;
 
@@ -364,6 +337,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
+
+		if (info->msg->msg_flags & MSG_ZEROCOPY &&
+		    info->op == VIRTIO_VSOCK_OP_RW) {
+			uarg = info->msg->msg_ubuf;
+
+			if (!uarg) {
+				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
+							    pkt_len, NULL);
+				if (!uarg) {
+					virtio_transport_put_credit(vvs, pkt_len);
+					return -ENOMEM;
+				}
+
+				if (!can_zcopy)
+					uarg_to_msgzc(uarg)->zerocopy = 0;
+
+				have_uref = true;
+			}
+		}
 	}
 
 	rest_len = pkt_len;
@@ -382,21 +374,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		/* We process buffer part by part, allocating skb on
-		 * each iteration. If this is last skb for this buffer
-		 * and MSG_ZEROCOPY mode is in use - we must allocate
-		 * completion for the current syscall.
-		 */
-		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
-		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
-			if (virtio_transport_init_zcopy_skb(vsk, skb,
-							    info->msg,
-							    can_zcopy)) {
-				kfree_skb(skb);
-				ret = -ENOMEM;
-				break;
-			}
-		}
+		skb_zcopy_set(skb, uarg, NULL);
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
@@ -420,6 +398,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_put_credit(vvs, rest_len);
 
+	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
+	 * skb_zcopy_set() increases it for each skb, so we can drop that
+	 * initial reference to keep it balanced.
+	 */
+	if (have_uref) {
+		if (rest_len == pkt_len)
+			/* No data sent, abort the notification. */
+			net_zcopy_put_abort(uarg, true);
+		else
+			net_zcopy_put(uarg);
+	}
+
 	/* Return number of bytes, if any data has been sent. */
 	if (rest_len != pkt_len)
 		ret = pkt_len - rest_len;
-- 
2.43.0

