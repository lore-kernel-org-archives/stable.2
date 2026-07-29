Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A04C0421
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336314; cv=none; b=qJm9Gvzx/aWVo4/L9qiMa2Kt6vMk9z49mtLtGy94ukcnqTBUYy7e6aQ9la/oHTFzEPs4Z7Q80bNvSLEPfrVRN/hwRedSzGlGY/PxIubAgNLnKSw/li6lzKXdeS0xtwB++GynAAJ0JSlTSC+UdD92cUAlY1k9QypIW6LYupcC1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336314; c=relaxed/simple;
	bh=7lX7DqJJJz99Wn10qhIfetlafogy3psGIsfPdMCIwAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JyvJOhMbSIsTLbuQqBwmINoik0c6ytrmeTrtDFJSybUEW1otvqTEu9iN7CkAsgSS7Ub0KLA7qLFu0xs7/JxhLvu6muTb/f+y2E7Xm+sh8huXP3Tg0V5XIDVT8Q31OmeLnz3DxGK2HgQWYcVIOzVFjDCvgiogQzfXQ1+Xv8stqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYwfk2XJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYwfk2XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2010E1F00A3A;
	Wed, 29 Jul 2026 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785336311;
	bh=MCUDv174hgHMP2LWeIjQS2N/UJZBqAFufmWfVG5YVTE=;
	h=Subject:To:Cc:From:Date;
	b=rYwfk2XJU9ww6e2we4TxWFp7LHZWiCYNyl80KDdJ8XOT1tMDTBZ93tvAsHtlglXnU
	 9zCcs63058arG64vtCLH0RacS4dwjtSGR0/4lxkKY3zwT4hbNoJ/nCUWfVkBlPGxAt
	 Q252xrd0+EH2yN3cZdx4fW/hG8qc7c/QR7J7b+Js=
Subject: FAILED: patch "[PATCH] openvswitch: fix GSO userspace truncation underflow" failed to apply to 5.15-stable tree
To: kylebot@openai.com,aconole@redhat.com,i.maximets@ovn.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:44:50 +0200
Message-ID: <2026072950-pamperer-kilt-1f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4032f8ed10fcb84d41c508dfb04be96589f78dfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072950-pamperer-kilt-1f6e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4032f8ed10fcb84d41c508dfb04be96589f78dfe Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Tue, 7 Jul 2026 15:16:35 -0700
Subject: [PATCH] openvswitch: fix GSO userspace truncation underflow

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

