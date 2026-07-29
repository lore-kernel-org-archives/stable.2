Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8453A6B81
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358591; cv=none; b=WWKNF13jJYzxHN+Y5TaP1ED2UdyN4kS4XNyqmCDLA6a1Vy+x6O9NYYjXpPbCKyO5oKo7jxGWzWOJDvLWbBy0K2fVN5TNFnE+nDl4ZDUBFd6SR5B00jLwD794BsY3rgwm3iPT2bnQd4ir4ULA4OGPzJXFsMqk83FlOJcELXPI4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358591; c=relaxed/simple;
	bh=SUd9t5Zmta4KAPz2uGtKjdI2iuzGShD+xsyg/ZXJI90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqEpImeiT3eB3/Swk/dgTCg80JaZMY5rqjPASE5yzYzUkWD+2+nkGMXWzDLCqv1SxJm2AQFpPvye8s+onGaOLtyG7AS2jxKFIRuX5+xCZSH3QNQxZrkKTSgmFSvPyRTDhybAaqduTpBPOesLO+9E8BjY6tavE36ANp2KvQDF4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so4190765e9.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358588; x=1785963388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eo613K6JQNUFuTfkSyDvFxvZrnqBfMUZJYOVlaRH1vM=;
        b=Ie13rKA368jghLL3AG88ds6BlZLDfR5f+mjayn8sNAhnUD/6Tcdx7HsbByX/RRTrsO
         aVEYk1azltJ4lbZIC9eNpzqgs9tPl6r+pFQ4Mx8Rkz1Mup7QVmYnyIpNTtDX6HJVBmyp
         L85/YTaX9O2Zq5/hp0fJDjV90zEufBZ9hf0RzkjCZzL3qvik30nvO6BRxLRm7BSL3pCf
         aQJ/n56mHSEgVeXWhoGIHFLmtbig+zdAfSMBZTTuW1H4d55pzTth1Gf3yPJRUTga5eZD
         87Wq8TI03604fVq96bAirBaqecrLl9NfTk3dUE7IUd9O/iifug7UxlA7QYCcBdbAL4Pg
         YoIA==
X-Gm-Message-State: AOJu0YyuZcqnHW2rmiVeN2k5e/dzkmJa9uEX7osrNBjryBocYthQ+sOK
	2DhHjP+HJtRLLCOJSMXEJJO3Xh7EEzGFae7fqSBNHZPFMM2uRWsh7/AvEnWUqS1mIcY=
X-Gm-Gg: AR+sD12xWKVzHlVoB+OgzV1IZfmO+ef3FPAABp7J7BKeiRaWQ61E8fsTErv0oRL6+7l
	aVLEJN6WN4CES0fYZkqw/xVBKLBdsB0r+IHduZHjNno3CHgMAoAK864m0Z0mtWM0WhnmZdAkTaw
	0ryOcgdKgd6i08i5XMk+OGG7pb3u1AzHMUx43dBFjMKh5VesUFAGQk0YDH/AQfUl5zMhYdhHtAz
	nt0j7VB1xkFm8vdweJnHMrs8QtvsE3cNoFoEB7RKHrc+RRmRiy4RK+/x1qrjQNmRGfgPI51tcRx
	qx7jzoqq+EScsEz1rqDoZ5jNj/pN1Juhpneyw6XPs3hCQxMiOigae4pxuv4yT8j9o+ynHH1kLzz
	y9nkbJ1iUye8BE95KKz6/h144AmAyEQ6FEOPVo3aBRND+NVv2a6rc/1i6XxCjw3zwpr+dngmQYQ
	v4tMzvbE33P8MwYdRhoJTcWz8Y8NqvFb9g76HAIhMl/fOawazYYlSvziI1VTVzBxqku6KEXBZF5
	1wytWQGCI/SEnDtaqQLHv9zZzuE5w==
X-Received: by 2002:a05:600c:870e:b0:495:3af9:4cfe with SMTP id 5b1f17b1804b1-49800ea2937mr161295e9.20.1785358587919;
        Wed, 29 Jul 2026 13:56:27 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d777afsm102464935e9.4.2026.07.29.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:56:27 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] openvswitch: fix GSO userspace truncation underflow
Date: Wed, 29 Jul 2026 22:56:07 +0200
Message-ID: <20260729205609.628158-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072949-transform-lagoon-f0a4@gregkh>
References: <2026072949-transform-lagoon-f0a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 4032f8ed10fcb84d41c508dfb04be96589f78dfe ]

OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
length in OVS_CB(skb)->cutlen. When a later userspace action segments a
GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
A segment can then reach queue_userspace_packet() with cutlen greater
than skb->len, underflowing the length passed to skb_zerocopy().

Store the maximum preserved length instead and bound each consumer
against the current skb length. Use U32_MAX as the no-truncation
sentinel so the value remains valid if skb geometry changes before a
consumer handles it.

Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260707221635.27489-1-kylebot@openai.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[6.6.y and older don't have OVS_ACTION_ATTR_PSAMPLE]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c  | 15 +++++----------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 0ea4fc2a755b..793f86e24755 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -861,12 +861,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-		if (unlikely(cutlen > 0)) {
-			if (skb->len - cutlen > ovs_mac_header_len(key))
-				pskb_trim(skb, skb->len - cutlen);
-			else
-				pskb_trim(skb, ovs_mac_header_len(key));
-		}
+		if (unlikely(cutlen < skb->len))
+			pskb_trim(skb, max(cutlen, ovs_mac_header_len(key)));
 
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
@@ -1258,22 +1254,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			clone = skb_clone(skb, GFP_ATOMIC);
 			if (clone)
 				do_output(dp, clone, port, key);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_TRUNC: {
 			struct ovs_action_trunc *trunc = nla_data(a);
 
-			if (skb->len > trunc->max_len)
-				OVS_CB(skb)->cutlen = skb->len - trunc->max_len;
+			OVS_CB(skb)->cutlen = trunc->max_len;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_USERSPACE:
 			output_userspace(dp, skb, key, a, attr,
 						     len, OVS_CB(skb)->cutlen);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			if (nla_is_last(a, rem)) {
 				consume_skb(skb);
 				return 0;
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 857edc537393..fb5b72700d82 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -273,7 +273,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -438,7 +438,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -459,7 +460,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -474,13 +476,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	 * padding logic. Only perform zerocopy if padding is not required.
 	 */
 	if (dp->user_features & OVS_DP_F_UNALIGNED)
-		hlen = skb_zerocopy_headlen(skb);
+		hlen = min(skb_zerocopy_headlen(skb), cutlen);
 	else
-		hlen = skb->len;
+		hlen = skb_len;
 
-	len = upcall_msg_size(upcall_info, hlen - cutlen,
-			      OVS_CB(skb)->acts_origlen);
-	user_skb = genlmsg_new(len, GFP_ATOMIC);
+	msg_size = upcall_msg_size(upcall_info, hlen,
+				   OVS_CB(skb)->acts_origlen);
+	user_skb = genlmsg_new(msg_size, GFP_ATOMIC);
 	if (!user_skb) {
 		err = -ENOMEM;
 		goto out;
@@ -541,7 +543,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -566,9 +568,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -625,6 +627,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 0cd29971a907..88156a677f22 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -114,7 +114,7 @@ struct datapath {
  * @mru: The maximum received fragement size; 0 if the packet is not
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
- * @cutlen: The number of bytes from the packet end to be removed.
+ * @cutlen: The number of bytes in the packet to preserve on output.
  */
 struct ovs_skb_cb {
 	struct vport		*input_vport;
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index a0a8854e9f19..eb0eb57dabe2 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -503,7 +503,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
-- 
2.55.0

