Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20678212FAD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358742; cv=none; b=mxkyw1riXwXywcEbQKB13x8SLxM4N7yH/7e4fEdr5v1v91Rzox2jVN8L7rRmxPhMkWSYTOoIBffsRaXcgMFo3gIhb3W8P3e9rGkJqmMfAT5+EfoR1s+kdy8pmqVDKHK9BdP8b58p7saOkItJcCQ76GJGfL4tE/O244CmnAnzvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358742; c=relaxed/simple;
	bh=Hzn4FscOE1ds874ePxfbdbmYon8VWf3RVIrF03+4xPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRq7ZOGugWLWnVjyPCFNObpjqkQPN8Ns4wu7FoGBWG2VSqrhWYL+oDV8ZIeuOA31Z2LAPIwA1wfXZXFmzeK6hg8twr0KdREZpD9LB5NpupbmjmJJWkrtNDqkc+IAT5J5nArRaInpubnqIfagHGusLGiFAxQvnRm+wX+IYY5OHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so514360f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358739; x=1785963539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMwfZsPC4yAY9pegTK7joCuWIxCFNsCzcN9hzrVqFdQ=;
        b=gEp/6yhlzWIz0mmeGpV6PsuwIeyPGDPBt86XcHjbrEPFToyCtWUsqA1WfLFFtNEktK
         BQ0eAQgAxvmkeljbijbFdKtrUEOnaZtF6ilW9nVyDONSI9EKULoegOQNqbJzLDhsPjAQ
         K0EHEAdTPtH5QDTPeAcUBICpLv3F54B8SpjI2RopMYL9U9edH95MTkecAp8rK6xjXwQq
         UsbplU+CY569ljl5ENLxEMjzKOSwjyftiE7gq6m35Q1yHNAAh40UcwfOiLoGCVvCOJuE
         m4GtzqrdHZ31a0HMqA5TbP+8r9uPZbd2HrduF5V8f4iC+RZq8ctqvHx1KKFXih5J2O6F
         aLQA==
X-Gm-Message-State: AOJu0YxhiFT2vnkZwyVlG/WLTedhCSbmIwOKF5EQdYxuVWDa3qFJjZWa
	HjYVlxVe+DTZGq7BMMIGgU6nOszK6WlzVGvLpceYuPf3Jiw5ctMBPtWf+/7LJzi/SvE=
X-Gm-Gg: AR+sD12QalZJ/oagXvGbTYIM8/tAz8V/C9AgzqIW3HQ/Q/xFIoZ2zPKR/zUy0AjmOVb
	O3pEynsUIuUT3KMwjTJpIMGCKZZr720PlEDdSAQAs3szUN0sMCREoA5DYs5kbWEXMR14rGzKWA/
	C8znmPs83bwdypm7/es0TaqmtTu9kdLyBAIEYpxb54V5Jufirvt2VnwFtSNR6qCarrnTrDJ8mBs
	TWnzYuVN2utTxFmA4TbnCEGilCkLrL5LySAXZzDcytrAR077H/zpQ2IbRGC0bRp4zV4WCS6segR
	M5Ni8dRdc5rdOuwkWu4R0GsdXBsgfEDHlgDQtKAlvnB5oLvArxjnzGrC0KhikXbL5q9RlCnQGp+
	6kYMl0e7lAxbSTLdzmhS1+QXm+7I4PgyL5sZlpSv5DJU9iaBmJwA4uUQq4mUfDgNtCuL7Kt2eTK
	9tyhKubiBVc7tnWNq1ZOB3dJsHDN+BXno8s1bTVt/OUH62S23TymilRZqnyyYN7GzLyy/j5KWdu
	BbxKFHDYUIGTPC44rr68OGR6NMulw==
X-Received: by 2002:a05:6000:2c0c:b0:47e:aa42:4e42 with SMTP id ffacd0b85a97d-47fc66875ffmr390074f8f.55.1785358739241;
        Wed, 29 Jul 2026 13:58:59 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm10656090f8f.11.2026.07.29.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:58:58 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] openvswitch: fix GSO userspace truncation underflow
Date: Wed, 29 Jul 2026 22:58:53 +0200
Message-ID: <20260729205856.628744-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072950-catalog-shore-3727@gregkh>
References: <2026072950-catalog-shore-3727@gregkh>
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
[6.1.y supports neither OVS_ACTION_ATTR_PSAMPLE nor OVS drop reasons]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c  | 15 +++++----------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index f7cc87e67d3c..18e419affb57 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -856,12 +856,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
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
@@ -1242,22 +1238,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
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
index 0c0d89470145..1181807f2b50 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -251,7 +251,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -414,7 +414,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -435,7 +436,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -450,13 +452,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
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
@@ -517,7 +519,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -542,9 +544,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -601,6 +603,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
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
index 5d7af559a20b..e83aa6417ffd 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -438,7 +438,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
-- 
2.55.0

