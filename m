Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F223E334
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778887; cv=none; b=RgrqtHfOv2GR+gHITf76pVsOOqlXw+F0cmttONORqe/x69TGqUQ4uRzuSxQU898dcDESy2zi8CJFOhzSSuE1nOz4OQcFuIJxo4i1IpQbUPmwqgkQi97TiXeiW5PAyIR/R8BnijkQgdrHSdDseIekUoytqK3v2X5XyYYI39euLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778887; c=relaxed/simple;
	bh=wSk4Fz4BDquIXzLNy02xRxAovKGzM/2XCdVQBNtIntg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUazim/XUWyao7/pAvrHyaR/XNrjQm3MpWEyd8agJMtB0RLL/zq6NlKRVXhL5muOjJZNZWzRepL87u5MBxeSgO1XvE0DULEyIBGAHCxUAhaVkzkVemx2NL2xxMrkrCVMPw8ROm0Kin40GdcB1fJXZJFoQZ6ALgRj9HvtjE8yo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+73bYqO; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+73bYqO"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43db0c16so11041447b3.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778876; x=1790383676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/whdCyQP9V9wsTkupkEtb5GqAo/EGERIlBdKlmh3Mdo=;
        b=k+73bYqOT+9qNC+EWd2L7gxrSX0bYrElQsWDauwsreaOgMsbcEPPn/+fX2ENuIu5H2
         1XYRHptpdJ4rbaXd13q6iaIz2qHZjb2/qrpMcnw4fO+h5Hsv7XiIJDFO0LKWNUnMXkP3
         9/19f3IyCJNVTrUjLmahVCIC1gpKCnCVEN6iN090UmOA3YMhyfVEsLWMue7r2snibyK9
         Hvyxvi0LkL5BdsZgdfwteCHXCjjIdxoRyYebRkd6MA9nIxXiZ1+Vu8KXWUVREfOwqeiY
         TRtnF63FTFli/T/boz9LCkFdfiM1ZBBVkmidq9RKgLYq0sKMrOC3dX8ENKN7//6mbqwY
         2sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778876; x=1790383676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/whdCyQP9V9wsTkupkEtb5GqAo/EGERIlBdKlmh3Mdo=;
        b=Fk06B/V5npJTVUqYBiZsJv2JeMgdpOBBO6JRFjzkFzGhmfvj7gIPKAja1k+vJqY5Tz
         yAiUEd6+JlpvoVmW1fhR6z9TQQz4uFHqpHSfeS1DmrxmXlhnag9LEMfCJH+9n+Yqcxns
         zuMYxMGxPe6Xrv4ARc6Rva6hJZwI9ebN4rvdx0vFfNCR/fHphqzhjB5dx91hu/3uOApB
         kr3GCYYbZoJj3KnDbZ+TON5BUHSRLgGbXM/JnPcXGUpcpa91TP6/FR/i1ReqRqi16PjE
         LzBNijApsMjSOkWupVKG/GHtuvOeHFxVu68KAEW0D69h1o0eObeIz/FdDrZiTaherNdM
         2wAA==
X-Forwarded-Encrypted: i=1; AKwUvBw3OrcZtPkEIeTUbusgZJ5jAIvNLxa+bSfFYhWyNw3A+46FSKTgZJsxYmKlJI7jq6+wWjegdRk=@vger.kernel.org
X-Gm-Message-State: AFuF++m+E1lCq+ffO1VDIAmXlBXLPo+PIRYfKkV+HnxksjlgV1ZLPFT6
	txtgdLIOflYnZG0jUU3WBsllcVEdzsDKYH/z5OAUPQxpnInBk7IOHVu1
X-Gm-Gg: AYBFou1yAsKaTQCT4b0/L/mzxpfTfnvLkP1zI5gRrhpI1v4mV9lfrW3F39KetvLct2m
	hGFUSX0k8wKiLaLksoujQamyTk1zkMaMxao94OrtJ82y9/Mx1R7A4rC8WjxOTm23ni4FKcMlLy7
	mHiTgaThApzLTjNY/Ds19rxU7l3HzZyi+LFRZIsTnbwThCcgTLifNgypE5z5L7g7SEBQkM18Tnn
	bd+YPUR94sknfuTBwRkmY4SJXAzexAYVyU5RmwLyuzJoQsTLIpM3sNXxQoJKeswu93bSeckwERP
	Bl/42QP1uBRjTgYVgt6w5Hxoze9B5rEzpP7NNSxkJmMKlk2PodNiV31Z+oIARZ38ZZOxJw+ZZ5D
	7qHIrKLBSR7o4wDYHtfzfkKaBwbXPc6mcIt/sSqqhq1HIhO5gg4FwA+LNQM0a13iP6MWzQ5P98v
	yWWmfq2AooQx83WIz38XzXvrsIOhg9/dcnkUVvx5XH9FozxIFSstD0229LW/7kKsxvkh4yVNLhN
	Z7L2To2c66XAlXa8e7i2cguKZZKZ2J1uKe9eEZQbykM83duQiXG96Ha3xsR5mWQBVzK92uoa5sF
	2Kp8xjDcKA==
X-Received: by 2002:a05:690c:82:b0:841:773e:8d86 with SMTP id 00721157ae682-897331482famr13696937b3.15.1789778875495;
        Fri, 18 Sep 2026 17:47:55 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a478ff1fbsm4999977b3.31.2026.09.18.17.47.54
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
	Katherine Leaver <kleaver@janestreet.com>,
	Bjoern Doebel <doebel@amazon.de>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] packet: use ubuf_info completion for TX_RING packets
Date: Fri, 18 Sep 2026 20:47:29 -0400
Message-ID: <20260919004748.1463985-3-willemdebruijn.kernel@gmail.com>
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

tpacket_snd sends skbs with frags pointing into its ring slots. Slots
are released when skb->destructor is called.

A call to skb_orphan calls skb->destructor before the skb is freed.
This can cause the slot to be reused while still linked into the skb.

Switch to standard zerocopy completion (ubuf_info) so the slot is only
released once all references to the payload are freed or copied.
Restore skb->destructor to standard sock_wfree.

The ubuf_info completion callback can be called with a NULL skb, but
only from net_zcopy_put and related API, used by zerocopy implementations
that hold their own reference on the uarg, such as MSG_ZEROCOPY. This
uarg is only ever completed from skb_zcopy_clear, so skb is always set.

To prevent userspace from aliasing in-flight state on shared ring
slots, allocate tpacket_uarg per packet, rather than per slot. This
adds a small allocation to the transmit path. Use standard kmalloc to
allow backporting to stable kernels.

The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
the ring pages. Always allocate vec->deferred for tx_ring so page-backed
rings also wait on sk_wmem_alloc when skb_copy_ubufs drops page refs
before calling tpacket_ubuf_complete.

Drop the tx_ring.pg_vec test that tpacket_destruct_skb performed before
accessing the slot. The sk_wmem_alloc reference now guarantees that the
slot is valid. The test is also not sufficient by itself, as it reads
pg_vec without pg_vec_lock, so it can race with packet_set_ring.

As a result a slot is released when its payload is copied, which can
be before transmission (e.g., in skb_orphan_frags_rx). If copied
before skb_tx_timestamp() is called, no slot timestamp is recorded,
similar to when skb_orphan() was called early in the datapath before
this patch.

Revert the now unused previous skb_zcopy_.._nouarg infra.

Depends on commit 992cc9f94ca9 ("net/packet: defer vmalloc TX_RING
free until skbs finish").

Reported-by: Katherine Leaver <kleaver@janestreet.com>
Reported-by: Bjoern Doebel <doebel@amazon.de>
Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - Always allocate vec->deferred for tx_ring so page-backed rings also
    defer freeing until sk_wmem_alloc drops to zero
  - Clarify in commit message that copying before skb_tx_timestamp()
    omits slot timestamp
  - Drop the unreachable NULL skb test in tpacket_ubuf_complete, in
    favor of DEBUG_NET_WARN_ON_ONCE
  - Drop the tx_ring.pg_vec test in tpacket_ubuf_complete: neither
    needed nor synchronized

Verified with tools/testing/selftests/net/txring_overwrite and the RPS
setup from Bjoern's report.

---
 include/linux/skbuff.h |  19 +-------
 net/packet/af_packet.c | 102 ++++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 56 deletions(-)

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
index 76bde7906d49..fba81036635b 100644
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
@@ -2587,27 +2567,56 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
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
+	__u32 ts;
+
+	DEBUG_NET_WARN_ON_ONCE(!skb);
+
+	if (!refcount_dec_and_test(&uarg->refcnt))
+		return;
+
+	ts = __packet_set_timestamp(po, ph, skb);
+	__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
+
+	packet_dec_pending(&po->tx_ring);
+	complete(&po->skb_completion);
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
@@ -2747,6 +2756,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	struct virtio_net_hdr vnet_hdr;
 	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
+	struct tpacket_uarg *uarg;
 	__be16 proto;
 	int err, reserve = 0;
 	void *ph;
@@ -2874,7 +2884,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 				err = len_sum;
 			goto out_status;
 		}
-		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
+		tp_len = tpacket_fill_skb(po, skb, dev, data, tp_len, proto,
 					  addr, hlen, copylen, hard_header_len,
 					  &sockc);
 		if (likely(tp_len >= 0) &&
@@ -2906,7 +2916,24 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
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
 
@@ -4484,21 +4511,20 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 	vec->len = block_nr;
 	pg_vec = vec->pg_vec;
 
+	if (tx_ring) {
+		vec->deferred = kzalloc_obj(*vec->deferred,
+					    GFP_KERNEL | __GFP_NOWARN);
+		if (!vec->deferred)
+			goto out_free_pgvec;
+		vec->deferred->vec = vec;
+		INIT_DELAYED_WORK(&vec->deferred->work,
+				  packet_free_pg_vec_work);
+	}
+
 	for (i = 0; i < block_nr; i++) {
 		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
 		if (unlikely(!pg_vec[i].buffer))
 			goto out_free_pgvec;
-
-		if (tx_ring && !vec->deferred &&
-		    is_vmalloc_addr(pg_vec[i].buffer)) {
-			vec->deferred = kzalloc_obj(*vec->deferred,
-						    GFP_KERNEL | __GFP_NOWARN);
-			if (!vec->deferred)
-				goto out_free_pgvec;
-			vec->deferred->vec = vec;
-			INIT_DELAYED_WORK(&vec->deferred->work,
-					  packet_free_pg_vec_work);
-		}
 	}
 
 out:
-- 
2.55.0.1082.g2b9226bbc0-goog

