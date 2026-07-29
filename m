Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C022D7DDB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358917; cv=none; b=Uw0Cimix7hRA+1UenyjnNSeDSizJwHUYldQjkqOkBcsMrNyFo6rxlH5mseb2VhcHtE0vnU1QnSkw46t7/yQ+8eO8SnqmKYSAHbn04uXqj6Xv4qXzRDRybCCQsnmbaT22krKEeZQzUYzSLnJ4Vg/WwpHTuSKjSIMIuEDCOqaxylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358917; c=relaxed/simple;
	bh=OqVMwSHulr2SNzX0gjQyWpmsC4oUxQKF1YZm1CnMrEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB1xmEnZvnhZtSaAuT4gpGj3Ph7AX9pycu2hCxqaFTP/X5cGCd2FWIg3Pf/5PW4eC2/iEfNlv7i2JQP1ZtpczfdvQYqsYf9s2YOyXeFue1yoTNPH8z+HkWPYu+CMTS2P5lPMphuXDSm6Qr1ZvBuKx21n7hjLkV6U6qb4y90ORxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4955e5274cdso2153305e9.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358913; x=1785963713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66y6L0PESMagWap7kHD3/GLB9+0JyEDkn+2S8hxp4Ec=;
        b=r3lGDUOJ95C+sPaj5mrXkl5JpYDLaRQxtmwbhpQ5X3wrKEHKdQB34SQCO7Ii4m6CXb
         RSVv2c8cOpogEnpC5XX0ZWeirinRZ1Pg++Q7jP+vKbCOSRSdCIU8QM6bt1rs54pGlqR5
         UZ3yvwGhGID2LnYsT9v1mb3lgSH92iCZk2Ck48xxmj+wYbjw/rjYZS82winAPXfRzJmC
         WX1U3AZDOaCIdw1TPkaQDa8itVzo3OHwucQ+kCZUE4maZqttJx3jiR98S6T6R0yqeaSa
         X+MhCjROAnDDxTHzqqABW+ACHHhypLsr/6nqPk0c1kISZV+LCmBCCFClBOJALRnnPxws
         2t1w==
X-Gm-Message-State: AOJu0Yym3oglPEg5ehBcRklZ5bNUT+jmBVbJc3TFO9tosQNIifsgQwla
	8MB8NdaVE/i33F7Br/mHp3/6HxUXBioSJaq4ixZGDk9NuotebKWvO1mNjl8JwwCKiu8=
X-Gm-Gg: AR+sD10LwdTvgmzW4m87WaYHyRAnawl4fPhhU4Iv40jKMD37PDy/z04QaMcWBV+bDpY
	76Ko53meBuYt6VhQ9nTWFlquHwEH11J/xaEgqys8s5Tluya+tmjOVRviVxyiB0zqDV3sI09T790
	SaMj6dzGkSiFLf2fE3eO1Xk6jypG5asuhrlkT1a3naK547xCx9JqWBuca4uzfYku/gStybmN9uu
	H2CfVzsTxZoBjvDOQFTmXynSs2Zd8nR1J9j4NhTc/vIwpAxt9XyO5PHoXyzGTy/Mt3o7gqpk9/6
	m/esJ6bSuRKo0dpe7NspF2tPoAvGfOIbpuHoeZwzuJglKlP+BhLo+8Z7IOyGyUUB8Acpp/0smvM
	BmEnejbwz9xGk4xgdm/8G7DV1Dtvuc/2zFjBsBjBGBji7MNJ+4tz4NU/dNPn9hEJ11QemSIeUnU
	Bmri9IB+EbO19K/JAoPVGGRcisykUsInQThKzXKTlcrG/khlvX8AiDSDQh6o6ab4Ch2DxGDVlRP
	xNIModN4cG8emo5QeGmO6x84i5XRg==
X-Received: by 2002:a05:600c:548e:b0:495:4bf3:2150 with SMTP id 5b1f17b1804b1-49800e6d11bmr431595e9.8.1785358913264;
        Wed, 29 Jul 2026 14:01:53 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3935sm11459299f8f.4.2026.07.29.14.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:01:52 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] openvswitch: fix GSO userspace truncation underflow
Date: Wed, 29 Jul 2026 23:01:46 +0200
Message-ID: <20260729210150.629376-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072950-moneywise-wrongful-ac29@gregkh>
References: <2026072950-moneywise-wrongful-ac29@gregkh>
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
[5.10.y supports neither OVS_ACTION_ATTR_PSAMPLE nor OVS drop reasons]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c  | 15 +++++----------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 3b3cc6ea274f..4995e617ca03 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -855,12 +855,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
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
@@ -1232,22 +1228,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
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
 			break;
 
 		case OVS_ACTION_ATTR_HASH:
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 5fb74fbcb2f3..b985e6696b42 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -240,7 +240,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 		upcall.cmd = OVS_PACKET_CMD_MISS;
 		upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -400,7 +400,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -421,7 +422,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -436,13 +438,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
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
@@ -503,7 +505,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -528,9 +530,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -587,6 +589,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 38f7d3e66ca6..62e7ad32f837 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -96,7 +96,7 @@ struct datapath {
  * @mru: The maximum received fragement size; 0 if the packet is not
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
- * @cutlen: The number of bytes from the packet end to be removed.
+ * @cutlen: The number of bytes in the packet to preserve on output.
  */
 struct ovs_skb_cb {
 	struct vport		*input_vport;
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index da733b92ae8a..ced707ff6dd9 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -436,7 +436,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
-- 
2.55.0

