Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE941A547
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422159; cv=none; b=W9BJOyKKH+YjEf4nXM5XtqoXj9+/9mjh0/XFEIf0cblOvCihcImhFmENXHew4xsZ76FL3mhTDmCNC6kOMUghLNDVL80ezZCcjVN409byodzMpiUs6UzytvNDztIEwByV96n0n1SU1mPP4yRJ4tfpQ0WvXLFUBSMZc/VAWJW6/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422159; c=relaxed/simple;
	bh=1EbnlpS7o9WVD21F6X+KOYpuw28dShJoet6T/qTr4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STsxy0XHyBMxju5Ur01hWiCW7/p5LXIGGjDVSgpr4F0qlmu54F94upwFXriHw+Ad6IR9beRBvtVnjT5PP17a2AFyb1fACieCv5w3dxS6vd7FongRhpqhz8cEYyyWhTmtHnUuUF52iG5Jt+2mPL69BQhC6caI0WSvNZNNunjrYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPIhZd0x; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPIhZd0x"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c744a00edso3038650d50.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789422156; x=1790026956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On2HQKwvLLaaGQi+LXd6sRuY9/yCDYxoT8ZhUifrzNc=;
        b=IPIhZd0xjR4Te4ubP+UQlvZOz13Y56BtamCzvZ/J4GaTpoyEqu49qwgBcrjqCUd2BD
         ROEvi9KmlJt1hU8Tys1aOT9SIRXMA6FK7hj2RqsnbbEjtVMdnxN3tyv5pPqk4df6maG1
         whSb/ACNsmT4MM/AwkXQNdJ4qgyKJexOW32GO1Ygs5ioSX3SIQJ6Z0n14RLDjFuLcpHf
         OBfvzrTHwuLTLVWN8k524nJNh81v0F9G9D+6YveD84mvJ4uBBeogvgjJBt9RCsCB7XUG
         LOkuhGuURYW7c5IHvF0e6kfkvA8cvITb2SFH3eB/zJcN6Hz6CkemKZ/mRuKjJ20U7qFU
         wsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422156; x=1790026956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=On2HQKwvLLaaGQi+LXd6sRuY9/yCDYxoT8ZhUifrzNc=;
        b=Z2I6RDHBJ0VmAlKUVMHyyRsymZAJaaTLdJ2LRgvuxKCUkOAMyfxGGqRnNkgOEpioNm
         g59qNWtFyUMwp+OmkCmUI2mV86zD2lMLPPLUyn1TIZl6TTjg9GftZxzQlu9DCPIacIre
         UCZuM5lwcWfUyX2JhWplrK8W2oeHl/1ZzfXOA6/0zB3P7a3c5wjdk5RaE3oDDMWN6cb4
         MNFmR6/UUiBcx7GvhJoYMScTbwfT5ZuA62ZI9FJOU4Ds9m3CRyEBdoJm6f9sC7L/i8sW
         Gqjxl0NAFkNClpPh2Cyp6KzFizvf9yfdloAnd1aKdVf9Gu8YE4jj6e2A1kbzPO6MIdbR
         269w==
X-Forwarded-Encrypted: i=1; AKwUvByVhMg3xUWw/bEnAygAdhIYkvy2A3ND4bzryq+iM5Ws2cVt6CDYEF/11Rhg9vE9AH/jBBQTZxM=@vger.kernel.org
X-Gm-Message-State: AFuF++kEeP7z994aS1V9TT73ZZBg+mLUNlJKVCJMxZX8Gun7WGgFdwX+
	/4YxcK2kuTy+nO4Ci+olD4ciE5XaY0gLLhyd3hNW5CCIuK4EZZHFXIzk
X-Gm-Gg: AYBFou1URobuDkHV5vDzagYQUgJIHkxKO++IJKc+hF7XEBl2N11TdBz6eEF2ht13UFI
	rMTccrpcajQazzdQzBRQZ+DTvAliiP4Yes52di5SrKbYsOvdS9+yK5UGEakwmkanh0LcXodye30
	goHxkmj/jnx2p4eAEWDV/tWx7pehGV9BtptJkh3fXUP3WeMeLmTMR4dZa/K1oJej+msKlxsbDO4
	62j5ykwa4LjapkTRFsJgXSsaSHTDUnkMDKLaUWcPsDNvgJsij7EaBLrYt302HcolQ2SksgAqZ22
	FtlwISYm6WPETI4j9YE1nCEEc4SGPNTZOvqrn8ZJQd7Jq8dICinZbKmJq6nzUkHJV5jobQ98VaX
	/iYlUiX8AEi6y0xS58Zx9+bkSr6iyYLGDo9+gouN3cFJsnGon00fCnYFbWhv2SCQoxH6lwsDPQD
	TitlmlnF2sZAKCmCcM8fTfV9lHsTI2tRM0bGgiaUEl5YB2OD/hQ3xS5xxFbA+k7YqF5GeaLsH8/
	dvEA/MnRMoa+D6bYRrDkpMrXWJVgwjcIi4gLHwBDM0q3TsyEVwcA9oMeAssbsmiVsfyucLIy5A=
X-Received: by 2002:a05:690e:d0a:b0:66c:effb:3706 with SMTP id 956f58d0204a3-6714dff575cmr1246776d50.38.1789422156342;
        Mon, 14 Sep 2026 14:42:36 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88486086224sm41718997b3.10.2026.09.14.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:42:35 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	Katherine Leaver <kleaver@janestreet.com>,
	Bjoern Doebel <doebel@amazon.de>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING packets
Date: Mon, 14 Sep 2026 17:37:43 -0400
Message-ID: <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

tpacket_snd sends skbs with frags pointing into its ring slots. Slots
are released when skb->destructor is called.

A call to skb_orphan calls skb->destructor before the skb is freed.
This can cause the slot to be reused while still linked into the skb.

Switch to standard zerocopy completion (ubuf_info) so the slot is only
released once all references to the payload are freed or copied.
Restore skb->destructor to standard sock_wfree.

To prevent userspace from aliasing in-flight state on shared ring
slots, allocate tpacket_uarg per packet, rather than per slot. This
adds a small allocation to the transmit path. Use standard kmalloc to
allow backporting to stable kernels.

The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
the ring pages.

As a result a slot is released when its payload is copied, which can
be before transmission (e.g., in skb_orphan_frags_rx). Any slot
timestamp then reflects the time of copy, rather than of transmit
(or skb_orphan).

Revert the now unused previous skb_zcopy_.._nouarg infra.

Reported-by: Katherine Leaver <kleaver@janestreet.com>
Reported-by: Bjoern Doebel <doebel@amazon.de>
Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This is a complex patch for stable. I have tried a variety of
alternatives for stable, including a two-step with deferral of this
full fix to net-next. But all have worse caveats or side effects:

- disable tpacket_snd zerocopy:
  performance regression also on paths that do not call skb_orphan

- detect tpacket skb in skb_orphan and set po->tx_copy that
  disables tpacket_snd zerocopy:
  - does not fix the first skb/slot
  - hot path function now needs to check skb_shinfo(skb) field

- insert skb_orphan_frags in skb_orphan:
  - hot path function now needs to check skb_shinfo(skb) field
  - needs extra code for virtio-net and cxgb4, which link the frags
    into descriptors before calling skb_orphan.

- insert skb_orphan_frags at all relevant callers of skb_orphan:
  10+ sites across drivers and qdiscs

---

 include/linux/skbuff.h | 19 +---------
 net/packet/af_packet.c | 82 ++++++++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..b14d6be7370b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1834,22 +1834,6 @@ static inline void skb_zcopy_set(struct sk_buff *skb, struct ubuf_info *uarg,
 	}
 }
 
-static inline void skb_zcopy_set_nouarg(struct sk_buff *skb, void *val)
-{
-	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t) val | 0x1UL);
-	skb_shinfo(skb)->flags |= SKBFL_ZEROCOPY_FRAG;
-}
-
-static inline bool skb_zcopy_is_nouarg(struct sk_buff *skb)
-{
-	return (uintptr_t) skb_shinfo(skb)->destructor_arg & 0x1UL;
-}
-
-static inline void *skb_zcopy_get_nouarg(struct sk_buff *skb)
-{
-	return (void *)((uintptr_t) skb_shinfo(skb)->destructor_arg & ~0x1UL);
-}
-
 static inline void net_zcopy_put(struct ubuf_info *uarg)
 {
 	if (uarg)
@@ -1872,8 +1856,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
 	struct ubuf_info *uarg = skb_zcopy(skb);
 
 	if (uarg) {
-		if (!skb_zcopy_is_nouarg(skb))
-			uarg->ops->complete(skb, uarg, zerocopy_success);
+		uarg->ops->complete(skb, uarg, zerocopy_success);
 
 		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 76bde7906d49..41fc053075da 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2528,26 +2528,6 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	goto drop_n_restore;
 }
 
-static void tpacket_destruct_skb(struct sk_buff *skb)
-{
-	struct packet_sock *po = pkt_sk(skb->sk);
-
-	if (likely(po->tx_ring.pg_vec)) {
-		void *ph;
-		__u32 ts;
-
-		ph = skb_zcopy_get_nouarg(skb);
-
-		ts = __packet_set_timestamp(po, ph, skb);
-		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
-
-		packet_dec_pending(&po->tx_ring);
-		complete(&po->skb_completion);
-	}
-
-	sock_wfree(skb);
-}
-
 static int __packet_snd_vnet_parse(struct virtio_net_hdr *vnet_hdr, size_t len)
 {
 	if ((vnet_hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
@@ -2587,27 +2567,57 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 	return 0;
 }
 
+struct tpacket_uarg {
+	struct ubuf_info	ubuf;
+	struct packet_sock	*po;
+	void			*ph;
+};
+
+static void tpacket_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+				  bool success)
+{
+	struct tpacket_uarg *tu = container_of(uarg, struct tpacket_uarg, ubuf);
+	struct packet_sock *po = tu->po;
+	void *ph = tu->ph;
+	__u32 ts = 0;
+
+	if (!refcount_dec_and_test(&uarg->refcnt))
+		return;
+
+	if (likely(READ_ONCE(po->tx_ring.pg_vec))) {
+		if (likely(skb))
+			ts = __packet_set_timestamp(po, ph, skb);
+		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
+
+		packet_dec_pending(&po->tx_ring);
+		complete(&po->skb_completion);
+	}
+
+	kfree(tu);
+	sk_free(&po->sk);
+}
+
+static const struct ubuf_info_ops tpacket_ubuf_ops = {
+	.complete = tpacket_ubuf_complete,
+};
+
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
-		void *frame, struct net_device *dev, void *data, int tp_len,
+		struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
 		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
-	union tpacket_uhdr ph;
 	int to_write, offset, len, nr_frags, len_max;
 	struct socket *sock = po->sk.sk_socket;
 	struct page *page;
 	int err;
 
-	ph.raw = frame;
-
 	skb->protocol = proto;
 	skb->dev = dev;
 	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc);
-	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
@@ -2747,6 +2757,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	struct virtio_net_hdr vnet_hdr;
 	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
+	struct tpacket_uarg *uarg;
 	__be16 proto;
 	int err, reserve = 0;
 	void *ph;
@@ -2874,7 +2885,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 				err = len_sum;
 			goto out_status;
 		}
-		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
+		tp_len = tpacket_fill_skb(po, skb, dev, data, tp_len, proto,
 					  addr, hlen, copylen, hard_header_len,
 					  &sockc);
 		if (likely(tp_len >= 0) &&
@@ -2906,7 +2917,24 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
-		skb->destructor = tpacket_destruct_skb;
+		uarg = kmalloc(sizeof(*uarg), GFP_KERNEL);
+		if (unlikely(!uarg)) {
+			if (likely(len_sum > 0))
+				err = len_sum;
+			else
+				err = -ENOMEM;
+			goto out_status;
+		}
+		uarg->po = po;
+		uarg->ph = ph;
+		uarg->ubuf.ops = &tpacket_ubuf_ops;
+		uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
+		refcount_set(&uarg->ubuf.refcnt, 1);
+
+		/* Hold a sk_wmem_alloc reference until completion */
+		refcount_inc(&po->sk.sk_wmem_alloc);
+		skb_zcopy_init(skb, &uarg->ubuf);
+
 		__packet_set_status(po, ph, TP_STATUS_SENDING);
 		packet_inc_pending(&po->tx_ring);
 
-- 
2.55.0.1032.g73a4cd73de-goog

