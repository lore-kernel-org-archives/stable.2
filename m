Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A042885F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556354; cv=none; b=VdhR4dzqo/W6jKh4bGOjueSYH6exOAW/sR6v9CUJvwB4hEYyfo/Bz1OSaqKw1bZzl2/8QqBgJsHY+X2vfvTmqob1HKL7PlKsxn4A0AFtlFn/pEf5BqF4BIFBTDsA4FVphtIJx32yYcOftGFInbrXXCbnGM/D5gATz0a1qGg0f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556354; c=relaxed/simple;
	bh=ePAKTHXDKdNb0FH/H3wB+Xwk4sX0kyILjAOUtmZQnIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNZZrCoKcqB/lwbu1hMc27i2I+8Wktbh/s/jP0bQMen36gDglL0EGZzjD+OMK+1XeXpSFIQSzlkA8yQe8/ftOWxzFUP0LFi28FiBa6TU+E5d2IW/wGij9gvsvzek2b/v8BjlxjZ2/xAX/EvFi8Z3Psex/+KL3UP9zrGAAnEiEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=FGtpU4+z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="FGtpU4+z"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f7872abb6so440734f8f.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784556350; x=1785161150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRi4OgK0lR0T6QvblIYz4VmndjhrAJYR+QcTs5ku3lo=;
        b=FGtpU4+zq3uD/a4wQijQAAsqSKc2mq31h0WlT6dzLh7tbF/bI4JYTljJVy6rfvRM+4
         CXBPa7RbSCfCVraD3AdExqyKnvN5cPbUCrM53+98rEdoo1PzP5t+yB3+3F+DhDIJqdWF
         09AWjN91TwmSNEg1FjNyDQDm8pCv2AAvDtafedBUBSvUTy9B1zOC/oB2L5vx6bUeWlaW
         vAM14aaW6/gjUTbWQJEz5uZFJo0fbyDo6EwUMQ3NOWqsPDckfRaFL53s4G/qXVTI1Dl3
         MzW6G9YwxZELV+Cfec3GiFlv8NqMOqnR8mShujj4pqztllJXzXf4EMcWu5NBnkzNx+ns
         7g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556350; x=1785161150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRi4OgK0lR0T6QvblIYz4VmndjhrAJYR+QcTs5ku3lo=;
        b=fGE8cigsGy21d27KsX5d6WEsqHzHBVXdn5xMr7Ms9B2aB67rc+TBAQY3Ys8Y9UA1Ya
         IsiN+GJJioamC+scmmhVewIexiC2oQwv/ipvRW4aQmwHEnpvacgRyaLr9KKHUTX724d7
         h4Ku9pQ9sdnk4UbwfYgFLvcAxQFopKSE2vJV7tuzN85WTEjQZPwr3O7GcKDg2nieL3a4
         I+7Km/pk/3LJWXd/wrR6Nm+oHimjLhHPZ7sMWwDH8hebJqIa83o202DjYna1CALlzRQS
         RGbQMOIO2s5XNgYpHuMSrlvwQ6Av+DNtITE00AudmaI1DmxfxIJM5D75M5F+Qj+MBnD3
         fc6g==
X-Forwarded-Encrypted: i=1; AHgh+RoQZ9+FsoOYQojYjKPAd0Cn5Wx+v/QoaafZTCGfpyOZiQmF6SyuyzJl+X4RR5qVWaKya1H7aa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6m1+0oVHbvjx676tyufDjzwRo1ssgiuDCZAQ6PYXdmO7uFQf
	HsX92YY6G9JFVe4TOJQWo9xI50vFsVeHn+jhxxsgWVArhOV19ohqj7bqxa/5bD8Y/Dg=
X-Gm-Gg: AR+sD10/FKVOk25EeNoMZZwbFZQGGjM3tGrhc+oSzeSxzVOk+HU34MyUj2+Io9NiaX4
	KfayFFl6h6Nr0jCoD8AyKvYuXWui0HXXurdn4WvJ9hg/6wFSEmbtI+nL3LyJBNITNlzKny2ZJcA
	qa5Tl18LhPKckQfUgUKBoSBfcAN2lIGekH/yELfCarPPZ84UcGyfQAbfdQ1td7VIXSarUy9YSke
	jpZwesejEHa60BaGhwOJTnfd5je3rH9RFaSxKMYMI/AebITB04HseoDYQc0hDCF6FDW7Kj+R1GI
	31H6QyddfYbcX5vkB1l/WoayCDNro37+ihztOVpJVjGFksHEMpAvo2WjA7NQ0Ratf0gzZrTeTNU
	zZJkOtrSYtttnA/oTMAH0a+h7YmvpWmAbbdaVibGr5vJ9Kqzt3mwWPqb1/js7l1B4M6JawgA0bj
	a5AylW
X-Received: by 2002:a05:6000:4b15:b0:47e:4b05:2c8c with SMTP id ffacd0b85a97d-47f622f81c1mr17766182f8f.15.1784556349482;
        Mon, 20 Jul 2026 07:05:49 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:1cdc::2e0:ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496ffsm29757674f8f.3.2026.07.20.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:05:48 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
Date: Mon, 20 Jul 2026 15:05:45 +0100
Message-ID: <20260720140545.461747-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

A frag_list skb can reach veth with data_len set but nr_frags zero.
veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
locked, have frags[], or do not have enough headroom. It later uses
skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
xdp_frags_size.

That exposes frag_list data to XDP as if it were stored in frags[], but
frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
metadata, walk an empty fragment entry, and crash in memcpy() from
__xsk_rcv().

Route non-linear skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the
representation XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v2:
- Use skb_is_nonlinear() in veth_convert_skb_to_xdp_buff().
- Move the skb_pp_cow_data() comment into kerneldoc.

 drivers/net/veth.c |  4 ++--
 net/core/skbuff.c  | 16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..00e34afd858e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
 			goto drop;
@@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..66f57131633a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -927,6 +927,16 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+/**
+ * skb_pp_cow_data() - copy skb data into page-pool backed storage
+ * @pool: page pool to allocate from
+ * @pskb: pointer to skb pointer, replaced with the copied skb on success
+ * @headroom: headroom to reserve in the copied skb
+ *
+ * skb_copy_bits() handles both frags[] and frag_list input. If the copied
+ * skb remains non-linear, it uses frags[], which is the representation used
+ * by XDP multi-buffer.
+ */
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -936,12 +946,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	int err, i, head_off;
 	void *data;
 
-	/* XDP does not support fraglist so we need to linearize
-	 * the skb.
-	 */
-	if (skb_has_frag_list(skb))
-		return -EOPNOTSUPP;
-
 	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
 	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
 		return -ENOMEM;
-- 
2.43.0

