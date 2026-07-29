Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676D32F770
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358829; cv=none; b=tBSQnYmzofMHCIUaRQDb44BUQ/weyiZ03H3k8tlNtYy2l8hi7AT7KK+rO1dWW4TWmpfUGnzX8aKDrfQ7/fwZ/tMBZKIXC8aYP4zcODCmuau0AqtdAPv8VlP61MkPLicrcUAictOzMNqawXPddXVhfCNFSU813n7arfex5A3VWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358829; c=relaxed/simple;
	bh=NAtwHsWqHcsaft8/HEaxZR3onkuzqh0zKYopUeTkS6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snvI1pt3sIui5fhrnhXQSHOJkEgTN8sk9I5UTlpdGZ7ZJFbwHjbXYwkV48NSj/SL/8W5v8fmtrX8wZGdSb4zNR8exNAn4D62h+4BEXB3P+PCfxb9GQh0sw/9M9IjeKBzDxoU3MR84OGAEHKdwjGLcOGoN20qiWYwV2mdE5NvC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso392320f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358826; x=1785963626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJDAYaCc4mbUDXReGvyQZTxJJ5lPCowHPsft820osMM=;
        b=YdxwKQVGBbVoXROEoSs1jm8jVDB8hATzI/O+miGYYJMg6uEOQhDHEXe/7O+lffJ8rX
         L8nnEOnJmev/X+3jhNjJFvoqsaBNqleexnyzkDCVSiYU5Bbw/seKZofV09oJod1fHnAl
         N7sIPuUcQWwxE7lHPPtBLGGyejk/42mhusdztCjVU8LM+S6K7L98vcPNnbHN/8UVDEkm
         Y2Dw2QYLq90vsTD1d1M2Ck6G1FKs2Wh1Pep7Ba1Um8Y9SK2q+H8JxK8NF1+xxjX2pzQr
         COvceI7ZtiaRj/SyR87dU5GL9YK2a6+RwzUCNU4x+5O1vFgEoZcDDxuOXXcsC7NcApqy
         mJyg==
X-Gm-Message-State: AOJu0YxO4QBimvKfbL0eZ9m5SDcXFXFEbpfdT8broCjNYCvY3sUmf/Pt
	gGkyqgra5EvmnfplleRdUE+7IC5cL2zQTpmptjgVQPGYEpK+ZyGGinUBWkzQaGMkgYA=
X-Gm-Gg: AR+sD11bu/PBVVKxK8EbCQY/Bh4+2m8OoKlhldOZjZI1x6zneXplVdpK3uhfmtLfZzk
	9wkC1TIROuthVQO258d/ZCZmLBs9QSuOp5/wFPr8nZqK9tZyF/L+B9r3bCcn1UCyaJgGVcCvZ+S
	3cKBpconVMIlV36WlsMYae4wd3X3luvIo4guq115AwiJoRG5YovyOfz710AtTejkwy0bctCtTxf
	kfLiOvUnvIGETyJxsSHYY4DSQYhNg7BfMlNPgRPEk60E4ys83YnvFjF3kALyy3zdoON75/BHqTb
	mnH/mW3FFBH5JgxGMOc6tKjmhNlXFqv+DEb6EGrNeksweYaUWlLxh1VYaTPQ3u5Fmjy7pany67i
	txgjSYIcypfZctlYsz548v6rpthc2S+IFlyniPDb14AGqLZgb1zdiI7kPGVSnAqtrGHJi8GWrLJ
	CmEfTE3M5r0u7bA/l6kg+JIrFg/tVfqSErHUU72/iWUZo2K/sK47GPAqii8hUvz4RyAphd5Tv13
	lltg3O1zZeYAjZtFNCVwNFYFA4LpQuKvRv1W19C
X-Received: by 2002:a05:600c:c493:b0:495:39aa:1359 with SMTP id 5b1f17b1804b1-49800e70079mr428755e9.3.1785358826035;
        Wed, 29 Jul 2026 14:00:26 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a94sm11172764f8f.8.2026.07.29.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:00:25 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] openvswitch: fix GSO userspace truncation underflow
Date: Wed, 29 Jul 2026 23:00:20 +0200
Message-ID: <20260729210023.629077-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072950-pamperer-kilt-1f6e@gregkh>
References: <2026072950-pamperer-kilt-1f6e@gregkh>
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
[5.15.y supports neither OVS_ACTION_ATTR_PSAMPLE nor OVS drop reasons]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c  | 15 +++++----------
 net/openvswitch/datapath.c | 25 ++++++++++++++-----------
 net/openvswitch/datapath.h |  2 +-
 net/openvswitch/vport.c    |  2 +-
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index aa240953d766..6d6d82ed5bd1 100644
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
index 0202111cda35..e9ff6b87af70 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -250,7 +250,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -413,7 +413,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -434,7 +435,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -449,13 +451,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
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
@@ -516,7 +518,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -541,9 +543,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -600,6 +602,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index fcfe6cb46441..86a47998a359 100644
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
index 25197e14c123..a2a9a602dd25 100644
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

