Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531852;
	b=DaImXjPmfr1WzSJ+rdqc3AzdmrWCE1zOfVeogpaJpDJccczHfBSPidYeQ5771AViKaLT
	 IlaynSvb+kmYtYJEdwV6ihsPX3BEy+IrYeB3TcpFE4HTfmNs8g/Y7IlQBfnal+A4aM8fQ
	 JkjYh7AcHayl2/+MFzoUD8bX1pp039yPUN3CjHy30o/zCGs9cpUYqUMR0yAZrwt9Ye+xO
	 tc7gMJDTdkthy60Ig8TLh+V2wo2AycVpvDDWcNF7NyWtJq9FszVSd5SnMgRmfXRZPsENx
	 8qfmGxR3ks+BHDlzGjoJlR20oH6nTzGyd7uJ7Li/1ieejUKHTyUZ0nEuhTMC4T62SlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cqpJMVDcI6RbJhyFDHk1sH3juPS+chDXW4qLSUHX3QM=;
	b=V/djf8H8tZwINtO7nVT9paYftbX1jS2t1inD6+Vo5wKBtz7n8ticLYFWc9mDFx0NWEUp
	 48flaxiQkXQBMiGpUoLfucS1paO9JLh2T2/7IHmmj4IRJBiHB6D3COBXqLxzQT9IbwCLL
	 e3thEPoNcVdrH06aL2nKe0433+d/bY5qS2BHfN94fi6mfV2mnkklZNd/unE0K3Sc0XJHv
	 9ngccA12ve4X1OXB7u9o9zz/RjWjSfvFwN89HS0W8kCltlkw8pcOfsMx5A4NK4NFpLNDK
	 lX+gC2e1qlhyPnHCeVoKYk9piQp7cCfm5SpN3TVM6W7i7GA+vIoyv2svh0we2yOINhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+PpQxUM;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6428606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6428606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+PpQxUM
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso4568936c88.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795531851; x=1796136651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqpJMVDcI6RbJhyFDHk1sH3juPS+chDXW4qLSUHX3QM=;
        b=B+PpQxUM/HIt53cx0GXcfD3AVOb/Pt1uFe71Hq5AUMObRk0U9PG8SJTq7C48g9e46Y
         MsUVdRgQnBySkdUW1KHDpOqIpCFjUMtF/bEza87GtAXnKzXk5U2pyxix9qSXD2P4n3sQ
         pZuRQyqugvdAxvKS9P5Bfi1SgCOp7xsDhej8PpCehdylwRXTdhjh3Z2ae9TG0076em01
         VaQ9kl6d/V1AAF1auxwW1fxICUahoJ1U3vQTgCeR2yzTabt4Di1NHXfZW+FpPPn9xoxH
         MK+lZA4BBivqL/rPUpb4kOKKpYIfen1E59DcuWGJW8twzSHEFtETylknZfu/yeKql5Rb
         gyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531851; x=1796136651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqpJMVDcI6RbJhyFDHk1sH3juPS+chDXW4qLSUHX3QM=;
        b=jWczHiUzEdniDV3gz0BUAL++MbXlL6PdVxzvhBXPSuILXbo/zs7kojsusMS6WLb1Np
         d7qtXwz8ya5cXOXOZLBWcX/9Uz0Vng/PC3NgidH3nnTjLmWckEwDwjGVLbq9r9qwFtp7
         iIfxrgSmjOA2eI++RPOSSQVOtqiZFQW149mUIRLoU2DUo/2V7duRhNSPY5AGPenR3kJs
         a5MQGO1BbGaE/4Zmx3BrF501eb3bjduxjrxy0a6qrGdRcnhAYfFz7e5qsU6zdSedlVDj
         SEgTPm8lmwJx8Y8gj+wOjGmux982qG8Et5QyVtBLbvmy0wf8lnXa+/qs5BWJ8kbjl63W
         RTiw==
X-Forwarded-Encrypted: i=1; AL+hErE+50/zkviNHnzCaNzm7JDOUEaCbpDJw+V0pkTleqhBLeVPLKX3kkZCz9krvvPaSgINfTGigds=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vdb+jsTJy8y4eqEy0/n4aO9Gg8ouekOfvcRPz1t497P7hovIM
	4wuPgdV4MlQxbaB7Ks5Geyo1wn257aS7/ur//xlljSJe7yzA/Y5Hpdwd
X-Gm-Gg: AZFdTZdH0pRkx0qvgOY3C2v4Udfyi4IAoccXL/MzSU4bbKs6UvWILuc2Uje6377R+Mv
	K+astQ5IyFzKmiSXGRfLgKyoyxm3vb3jTh7MgMTAWSX+R/03V7AuNlgh8z7JP3mEtuFFu/WFIgc
	zaPuwFXao681laiMvZTQTAM6FORBClTxNALNXKg+6fcRzKEADywHvtgPxjrxcihAM6oDK00ajwc
	Qg7I9YlGW9eKvpOHz17WVl0Q9al4z3r4NFbFk3IZv9Uh5ozaoFKTr2QV6gJBlS4PyUSiDIc4evA
	UTdJC3OXWGLIfXLRcDiADKChirF74xza8OL0ewCWu/8/vPvvnnq0wlUr4xbmPdk2s00QJLyJECE
	T9DBKaFmMEGItazLz7jwH7bNBP41gJSKjjBQrJTUjr1Y7cINRv4406rT6BId37w2psR4sLkHCo6
	075XLNvr3GaTZZ5qExKtIJi9ebLfXerhRZf+IiM97P5kIbL0U6f2rfntQTnXdxMd9X2kB0iRTA+
	0EZohAHcR+58IMMJNEk4YuJvL7610O5LVfCOR/4P/bWeSH/RcEGyB3ICDt8auyGNXGQuS5UCGVD
	WUE8PxPVnaapPKNvGECc5loSaKBGR4t9NS2KJfUGO1jkg4tHh65ct5HX3snd
X-Received: by 2002:a05:7300:7a21:b0:384:b001:4350 with SMTP id 5a478bee46e88-3856f04b191mr17978338eec.24.1795531850725;
        Tue, 24 Nov 2026 06:50:50 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm20684238eec.18.2026.11.24.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:50:50 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	matttbe@kernel.org,
	shuah@kernel.org,
	netdev-bot+sashiko@kernel.org,
	Minxi Hou <houminxi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6 1/3] net: openvswitch: read the datapath features once when sending an upcall
Date: Tue, 24 Nov 2026 09:50:31 -0500
Message-ID: <20261124145033.627044-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124145033.627044-1-houminxi@gmail.com>
References: <20261124145033.627044-1-houminxi@gmail.com>
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

queue_userspace_packet() decides from OVS_DP_F_UNALIGNED whether to copy
the packet with skb_zerocopy(), and pad_packet() reads the same field
again after the copy. A concurrent OVS_DP_CMD_SET can clear the bit
between the two reads, so the copy leaves a nonlinear skb and the padding
calls skb_put_zero() on it. skb_put() asserts that the skb is linear, so
the kernel oopses, and a host built with panic_on_oops goes down.

OVS_DP_CMD_SET needs CAP_NET_ADMIN, which a user namespace that owns a
network namespace provides, so the window is reachable without
privileges on the host.

Read the field once and pass that value to pad_packet().

Fixes: aea0bb4f8ee5 ("openvswitch: Pad OVS_PACKET_ATTR_PACKET if linear copy was performed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---

  v6: split out of the fix v5 carried as one patch. Reading the field
    once is an older and separate crash, so it stands as its own patch
    with its own Fixes: tag (aea0bb4f8ee5, the commit that added the
    second read).

 net/openvswitch/datapath.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..96baa2488c26 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -439,9 +439,9 @@ static size_t upcall_msg_size(const struct dp_upcall_info *upcall_info,
 	return size;
 }
 
-static void pad_packet(struct datapath *dp, struct sk_buff *skb)
+static void pad_packet(struct sk_buff *skb, u32 features)
 {
-	if (!(dp->user_features & OVS_DP_F_UNALIGNED)) {
+	if (!(features & OVS_DP_F_UNALIGNED)) {
 		size_t plen = NLA_ALIGN(skb->len) - skb->len;
 
 		if (plen > 0)
@@ -461,6 +461,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	size_t msg_size;
 	size_t skb_len;
 	unsigned int hlen;
+	u32 features;
 	int err, dp_ifindex;
 	u64 hash;
 
@@ -494,11 +495,18 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	    (err = skb_csum_hwoffload_help(skb, 0)))
 		goto out;
 
+	/* A concurrent change to the features can land between the head room
+	 * decision below and the padding after the copy, which would pad a
+	 * nonlinear skb and trip SKB_LINEAR_ASSERT. Read the field once and use
+	 * that value for both.
+	 */
+	features = READ_ONCE(dp->user_features);
+
 	/* Older versions of OVS user space enforce alignment of the last
 	 * Netlink attribute to NLA_ALIGNTO which would require extensive
 	 * padding logic. Only perform zerocopy if padding is not required.
 	 */
-	if (dp->user_features & OVS_DP_F_UNALIGNED)
+	if (features & OVS_DP_F_UNALIGNED)
 		hlen = min(skb_zerocopy_headlen(skb), cutlen);
 	else
 		hlen = skb_len;
@@ -598,7 +606,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		goto out;
 
 	/* Pad OVS_PACKET_ATTR_PACKET if linear copy was performed */
-	pad_packet(dp, user_skb);
+	pad_packet(user_skb, features);
 
 	((struct nlmsghdr *) user_skb->data)->nlmsg_len = user_skb->len;
 
-- 
2.56.1

