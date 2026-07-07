Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CF316190
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462489; cv=none; b=FYY+z54NtPwF8y/BMO4dT9lqMRR8la4Ij9czYMiIs0uMP4Yv2iFLrZuW6RM/B6pdoK9ufiA5igXT5S/rm/jk2asTFW5E/NmCE/dB7rmf76Joh6dDyIGPQtI0hQ6k6MmnjvXLvN/nBtsXKwBbLP2Sp3BSawsTYIOaU4KEoDQ41Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462489; c=relaxed/simple;
	bh=fa7ot51AK4GvjXzjN2xatzNnAuOJJlWeGalMMZcyHX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cauuF846ak3TJRMWzcQDri4AfowVoUz5bFJhFKBGommEC95qXaVfFTk7ffV2usV48Xr6cM7Q5E28uP6vVn7uu50Xf24Pa+lkLQOU5GZzPDB9DGqizZ1/tlFelp2164IocGyHvKTcdZyjni0rccW1equBaGQ6VWV0owvjZnOCnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ceopi2uz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ceopi2uz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84794e800f4so14239b3a.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783462487; x=1784067287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdJZd9tQ2oh7Af4gmwWaKxs5ZeO+JiGwmEDefw5S65c=;
        b=ceopi2uzZn6LP7K4x/e5S1zW65qD4gkMzdDphgFAbgJJVwGawGnK07ufORuMuC9Bgl
         IPWB91G9H8QBNti+DIRS/j4q58X5tXUzNng2PJBGbqMXIyRGiO2HFe8hcl5Hn4hksz/h
         hHYkd7f0+FG4c9s1lFnDQEZR6+KdyqBVG6WIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462487; x=1784067287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdJZd9tQ2oh7Af4gmwWaKxs5ZeO+JiGwmEDefw5S65c=;
        b=IVyS517U8Lm6UjEwj/u/wslPkvR+DaxI5MKUAthnDkU5FBnkZukoIKGFtxnydHC9+K
         KRx8awXKeaAK4vn0y1O7yG6c9Qq06KiLWr/J3goVF8wj43M5PAQl6BvAwhZUKIB6MzEY
         nDVUZwH+znv4mPZAyvl2x2oz5ZIifFDAaRba4A9DMYl96nqBc/X78J1Qs05ENKIpmd1e
         BAy1JREhj85W2U4dgwwmHuGCjcB212+wrH1HmLp75T9GH6E+zQcOuqsVqLUDme01d88m
         PJ3lN7pmzQdHd6Wercza781/YbiW5Bb0VMKhypDiXbmJS6dHUOdvQNIycVyt65T4YgVD
         keHQ==
X-Gm-Message-State: AOJu0YwoIiqtMlbQeONADqaP+N+UYbwyPWw5CasiVSW7XWSCwZZeRuyC
	COL4ynbyr4w4mSmL1kzcfyzxfH9wPeWjrCnm8LbLVOePgCZ79NaQgxcrzVZ1MxUO4lgPEJqY+o0
	ZsTpwrbQ=
X-Gm-Gg: AfdE7ckSvQ+wckuiekZMieD1ky86bpn0Ebiw6+jvJiAI0z/qTrvj43odBG/ZnldspHa
	gyFgZWb/LjmA4o21mOgvDJmMqdYyrMEb4PyQXk+KM6Jpx0CWnQrjl0jZgMmAo/UnAoIe7dii1jS
	bxDdzdtcpDxSkakmsPxoAsBGsjs5BLFPg0lGX1BrsSZH+5CNnlmJ1nfcJH2zrz2j5jplWOzqN43
	Q5YfAa53Ny3BCY59h62njlvaTI+fGNP0DIHaw34Gj/0bu6O10BP9noiAtrqy+ODmd1jkDd/An6S
	fHhm45LcO67ARMzpWTlv2AhUO0N8R5R1lkE2GWMKEtyVW9bRwRfWNaE0SSIILBJwCKqGnWgDL3V
	kd1IBabd41oyT9YR0N5+hgiAsIHAtu+gaMeoXYqdpH/HiKnssjo2J9iXjBSECDwlx4ykEIx8iUI
	AKhc+ssvzKbIIvOf4rAZ50couuKNG48urvpiooXtERnu4Nr9AFaRpHQ4U5+iQ8SYhe6LuWO24+c
	eU+Dkm4fOTl/MyxaAw=
X-Received: by 2002:a05:6a21:1f8d:b0:3c0:9c1a:894e with SMTP id adf61e73a8af0-3c09c1a9cb5mr5412972637.70.1783462486921;
        Tue, 07 Jul 2026 15:14:46 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm85499eec.14.2026.07.07.15.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 15:14:46 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net] openvswitch: fix GSO userspace truncation underflow
Date: Tue,  7 Jul 2026 15:14:42 -0700
Message-ID: <20260707221442.27159-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/openvswitch/actions.c  | 19 +++++++------------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 140388a18ae0..513fca6a8e8a 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -837,12 +837,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
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
@@ -1234,7 +1230,7 @@ static void execute_psample(struct datapath *dp, struct sk_buff *skb,
 
 	psample_group.net = ovs_dp_get_net(dp);
 	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
-	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
+	md.trunc_size = min(skb->len, OVS_CB(skb)->cutlen);
 	md.rate_as_probability = 1;
 
 	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
@@ -1284,22 +1280,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
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
@@ -1453,7 +1448,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 
 		case OVS_ACTION_ATTR_PSAMPLE:
 			execute_psample(dp, skb, a);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			if (nla_is_last(a, rem)) {
 				consume_skb(skb);
 				return 0;
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index f0164817d9b7..eaf332b156d7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -276,7 +276,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -457,7 +457,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -478,7 +479,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -493,13 +495,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
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
@@ -560,7 +562,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -585,9 +587,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -644,6 +646,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index db0c3e69d66c..696640e88fa7 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -118,7 +118,7 @@ struct datapath {
  * @mru: The maximum received fragement size; 0 if the packet is not
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
- * @cutlen: The number of bytes from the packet end to be removed.
+ * @cutlen: The number of bytes in the packet to preserve on output.
  * @probability: The sampling probability that was applied to this skb; 0 means
  * no sampling has occurred; U32_MAX means 100% probability.
  * @upcall_pid: Netlink socket PID to use for sending this packet to userspace;
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 56b2e2d1a749..12741485c939 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -502,7 +502,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	OVS_CB(skb)->probability = 0;
 	OVS_CB(skb)->upcall_pid = 0;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
-- 
2.54.0

