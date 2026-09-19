Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE6331EDD
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778881; cv=none; b=UVzYyPLtd8yZu1njcReZQApIDSe8wO/eE4tNTUxqO6sGDCrXAlD13e6ZdnZHG5YAnv8aR9hafCMntvnMIOg8Phu6Z8T3st4wIVDZK/QRXOfwM1tUmd52alNk/uYHwxtFAYfxXW3CskiQgHkaAQBhL5CyfM9z9Zo+94IzkaQ9E9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778881; c=relaxed/simple;
	bh=+mogkCZ91YORXT0VVZ847oEi+tvqSVDBDcgwDwPEQGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVyCbO1bDTXunVowLnOQP7Y7W6pRiTYS6qZ6U+Ef3jIGx1yok3qGytESPbNsdZUEDO0QU1x4M2W50lEsj+R2Ajjh4p1zMSAAJ5jpxjWZRF5r5lDotMBCJrZHBYppsXSc7fhGP9jwZ3tw6fexR3R8UDzrj02CcY7St87Uaq2bHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULPfnTLk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULPfnTLk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac6089so10018227b3.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778874; x=1790383674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmQdeC/7WtnxFir3/Y9/uG3vqCUZqvSTleXCCkU4qnk=;
        b=ULPfnTLkwK8ztBaGawzz+Da70pbIC/9Gb5q3HnCwjLht1wxsSOemfHx8yKenSmLCBo
         QeQBKVK5BZYSzr6bHpNs06OrJ38DwhIF647ibcxaPq6y2q641S+bDWE0tPbVHWAJj7Uz
         mZ3orMIOUOzYz8necPwKc2HbDvT+ycNWOOp/U/n05hJ1NoA0GxcS1E/PMg30jKGfNtvl
         QBVzz5gUmRRvKedxlAUkEg3+3tSK/woDbgKs3ozF4t1mF7TJlrpv0R2r6t5p4XnDc5Be
         1hQxWdsTXM3BidD7ChsHFnRuAe9OXz2bASjdVcQGBr44BIfz0qeEV094DjQbtDM1b5S0
         ItQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778874; x=1790383674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmQdeC/7WtnxFir3/Y9/uG3vqCUZqvSTleXCCkU4qnk=;
        b=Ll5cvfCcfvD5q/Fs5gUndvPvM4ikkZpOGBX+HAMTPuW10+nEgQVs40yjnEZT9u9Eat
         +UN2dh1TAaJIU4Jp8p01rIvL8evLEkt/9hH9JXUKvjQO/JdkSAW5kyIlbAmd+d+gX2V4
         1VFygk2yiOKoAKYgN0wu1hZIfg/3XcOpgjHOV9oPfnSertc8WSLr/NNQgnDLIHKMvaBT
         JMAnOhB4qpMAaL4BxXatNcCgHJkABu22j5J9HLnn/bJZBYqtpT3OuEntq9otX5VJftiU
         cRwKSaGQum4WknvS12TNhCR6zSwttV9fcASaSfd9Be50jkB8/aCyqHTTAAv40PMzuYhL
         R97A==
X-Forwarded-Encrypted: i=1; AKwUvByI4bGvM7b03mGO4o6IEj3dlle2zvhKep97HlDxGydK43Vm6aJ/EQjoVRUjE0iQYVclKuReOL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nbT1MBBlgXiMF3QmAF2JNGIHhfBvWTomvl00DlVg9mmllU66rv
	246/9rVww/80I9peGja57SFkHyOs9akdUXtUk7wcLmrQkmEFUb3d0pen
X-Gm-Gg: AYBFou3rw+JI2drR+ixvdAOO0W0TCwKh81pdu6oAzhlxlQzOypBE00bwAe4J/gNZLdk
	LDvs/GP42VP9xTky1UrLV+sUtBVUZSgR3lNPr1OFHHOydeLWToRt++s0u148Qn6qAfSAMWT9Kz9
	X2CA5x/qpk5c1CoD0HOhC1pnBgICfCvWIGey5+E6XDNoYvPTnoi34rlPee8lx14Krm15NiNznqj
	fmA6ThTIkyLMo29w8zyWUUvR7mhx/NAMpIVD7ymsKixphvKKPTHwUacrWL4rMEstPGpvOmYXAD+
	NVkEuY2TRrmjuLJEsBvgbQHIZKH2LVy0zlKbZMtrFmlWMuP06PX6bo/C4PzLd/GrBFcWfGR93KG
	hGzFDjfxcmEK/zWjodvVSRuJjzGcRoRwgyo61HqyU+VZ8PwKpn4D+87f+3b71bFwl+ltpUYBnUt
	B+0yQcOU1K2hA0fl7inikfR4e/ICdvlp/ONsu2wKvsqEkDAPQjyLxNHDNVDdDtXn0xNb4f7o9BO
	CXo0LVfUcgo2ln2uGV/pQuQIFxsxH14flJ5hpiIRnuhse3WDPZqt1c24dvdOU8jHZeRCXvysnI=
X-Received: by 2002:a05:690c:ec7:b0:871:a319:3ee8 with SMTP id 00721157ae682-897311d4f82mr15049737b3.10.1789778874607;
        Fri, 18 Sep 2026 17:47:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a478ff1fbsm4999977b3.31.2026.09.18.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:47:54 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com
Subject: [PATCH net v2 1/2] virtio_net: copy zerocopy frags in start_xmit without NAPI
Date: Fri, 18 Sep 2026 20:47:28 -0400
Message-ID: <20260919004748.1463985-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919004748.1463985-1-willemdebruijn.kernel@gmail.com>
References: <20260919004748.1463985-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Virtio-net without NAPI frees completed skbs lazily on the next
start_xmit. Senders waiting for in-flight zerocopy buffers can
deadlock if they cannot transmit more packets, as then no
completed packets will be freed.

When !use_napi, virtio-net already calls skb_orphan to avoid waiting
up for transmitted skbs to be freed. For zerocopy packets that
require deep copying on orphan (i.e. those that do not set
SKBFL_DONT_ORPHAN, such as PACKET_TX_RING), call skb_orphan_frags
before orphaning to release the buffers.

This fixes the tpacket_snd slot reuse bug on skb_orphan for
virtio-net, and prevents PACKET_TX_RING from running out of slots.

This fix also touches vhost_net zerocopy packets, which also do not
set SKBFL_DONT_ORPHAN. This is fine: vhost_net packets only encounter
virtio-net in nested virtualization, and only if napi_tx is
explicitly disabled (it has been default-enabled since Linux 4.12).
In that rare case, copying the frags is desirable anyway to prevent
holding guest descriptors pinned across unbounded intervals.

This is a prerequisite for the next patch, which converts
PACKET_TX_RING to standard zerocopy completion. Without this patch
first, a bounded ring sender can stall indefinitely behind a
virtio-net virtqueue that cannot reclaim.

Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Cc: mst@redhat.com
Cc: jasowangio@gmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - Do not suppress device kick on skb_orphan_frags error when !xmit_more

---
 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..bf82ef9874ab 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3349,6 +3349,14 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	else
 		virtqueue_disable_cb(sq->vq);
 
+	if (!use_napi &&
+	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
+		DEV_STATS_INC(dev, tx_dropped);
+		dev_kfree_skb_any(skb);
+		kick = !xmit_more || netif_xmit_stopped(txq);
+		goto kick_vq;
+	}
+
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
 
@@ -3381,6 +3389,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
 			  !xmit_more || netif_xmit_stopped(txq);
+kick_vq:
 	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-- 
2.55.0.1082.g2b9226bbc0-goog

