Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919B4D9540
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612324; cv=none; b=CBtxarH8ET4L+v91GI3t0gY9dEBC4vPa3SNnj/sAOTGOgo9Lc5Rh1A4OslTYwJ9hUR06FMYPCjyhLC75slaQfxe2TmOPQFXsbLSH3x1VzwjD9K1DjcQWtRlVzeou3cc4tMwV8H9vtOBqPAn2V2kT/0pvwVBLxrCOqA8pbvnp1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612324; c=relaxed/simple;
	bh=AOO/rNbtYn/XV+z6aJLsYODwFNDUGFoFh+PHNDW0M2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOrZkWTY4VvUv9Ar7o0ftu04D6Q4fmDnav7li74nGSnVOH77gR39utIJejFFcQ+96jx/ekKv+zPaOoF7SPtFk8+e6EdobyVxNox4Lc62lJaUYTYo2avhduLIsx0OBgrUbo/rLNA+8CS68WtcQ8bJFYdcJDSqOWrORWlP5xa/HTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el8IAS8H; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el8IAS8H"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so2057827f8f.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612321; x=1791217121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=el8IAS8HS/Qw2N/7f9OT/6rcIlNx2El9mT2P7ubxrKUTQaj6ONGhczs0z4Os93LIdd
         kY2vKlF2aO3Wwnb9wBeB+qTNJ5QJHdWZ5U2nd6S6ZmK1fbepZI+0Ol61USPkaKei40ZL
         XOG13KrEMj+mwz7OSehPHU8z9IYBqH2B79pUnxH/tw4nRjGmovLDJVIFIA+er0VoBLJD
         Lx2JCW+EEAQgC2RL5dmGT10rjSGbuNRt+IpQvyXT6ybwSXIJABCl310a5OkWUpfD5ct8
         Rsph6pdcx8f/oKnWpJDM+6h1YGayXZeSjpZAIAkep2aOp9ysrWsTFvWa9UGklF3lZ4lx
         VkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612321; x=1791217121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSDv0oMqDQGMqVMxgulpjHU/XgBmZQ/St3zf1qwBsuM=;
        b=Pec5xKJx41c6hdSIt7TQDg/Di39CDyTWUIwgZMyjvZKoa9HdpRBLln4tCtOYzPOO2n
         EvK4Sh2eRyii2sGhxrkW6qrezXG8BZDirH74PURklN6i3Tm38v8yiFt5RcHGSxR+LM9w
         Bh4EoQXRymvpE8Hzz+pr7m6S23EeNBK0lUtEwyzZPvbIf/pxcRhYYDYUQ/a0Uf0SR5vr
         MLOb/S7Tj8y4Tsl+3P17PqFNL8cgQy07GMkp/YKWYTAHSujj/TrbMrquhrW1qow4WkGW
         VlNmU830OtaWgTsjKKbiiIMjjd2AZO6fuCTkmdwC4bxfEJ53ZkyVPKyXTv9rch7LS+an
         BS6g==
X-Forwarded-Encrypted: i=1; AKwUvBzSxfeaCKgj9WMgjgGl2jGMaynD02c4HjnbRDgGiJCYvi1KSIOdPK8z6sYgYSEi3x+jVPCARJE=@vger.kernel.org
X-Gm-Message-State: AFuF++lcVUodwkXoPe4tDQKHh7/1oivOkkgDIn80+YLv8CGnL2p8BGE7
	UVVY51c3oW0SaJCTXFBjH13L57FMrZXJ24PkZHXXL95zGgsURtQ5eL0X
X-Gm-Gg: AYBFou3EAnr8hw8sMG4TmdW0j/lhhmC94DRipldZeoB/Necx20k1CvI3O3x7OPu4d/x
	i8DzKYFgxfzlSzy82Z/KwbXNxVMQ8sVNdsehQiyNuNRMwmE9nZMUkM9h36IuncCYL55xqgHfeTj
	cXp5I+/YPrBHTP7G5XGHQRpdKDEpNGSNV95o7H9jKlW+wMak2Sx6VXtMMlO/FylLnXuzOZeZ7gC
	YQM12XmWl6Wc/PTSY6lz/bnTt4oa4ZuZbC52B+Ho44GQNjMLiG7FXxcDm5lb/ZzRq4VI6Dsxc5t
	PBTZxC5GlYtp9lHoFnACqswcInvrKd2IS17h51l+9wcdWNKFqPtNyLHnzA1SLeBJvOYZO7ao6+Z
	VmBgY5VbMFFTr6lv4JLAohfKTDmHhv06xRL/an+oqeglIzHL1wd1xZ8AJE0rEahvEJ9rwuL1thE
	+h3sZcHX2NNE6/GsyhOHDZxOrF6E5p2l108rnVlUSdfJh/UHlSFJinZTk2seut+YQ9myOAlgKWy
	YPgUYjVsiteCtXIM37Z99IG/LeFZjNTNSH09VhVx1kdUpDnpt2S3Wk5G3qvsVq44s/j7rrSfJAv
	YFG98Q==
X-Received: by 2002:a05:600c:a30b:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-49ffaa33f7amr92371915e9.13.1790612321314;
        Mon, 28 Sep 2026 09:18:41 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm4813715e9.1.2026.09.28.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:18:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Mon, 28 Sep 2026 18:18:28 +0200
Message-ID: <20260928161830.351199-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, this can send fragments with a different VLAN tag from the one
selected for forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so IPv6 fragments use the current packet's
VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..ec69d6254e340 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Fragments may not inherit the MAC header or VLAN tag. */
+static void br_nf_save_frag_data(struct sk_buff *skb)
+{
+	struct brnf_frag_data *data = this_cpu_ptr(&brnf_frag_data_storage);
+
+	if (skb_vlan_tag_present(skb)) {
+		data->vlan_tci = skb->vlan_tci;
+		data->vlan_proto = skb->vlan_proto;
+	} else {
+		data->vlan_proto = 0;
+	}
+
+	data->encap_size = nf_bridge_encap_header_len(skb);
+	data->size = ETH_HLEN + data->encap_size;
+
+	skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
+					 data->size);
+}
+
 static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
@@ -866,28 +885,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	 */
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) &&
 	    skb->protocol == htons(ETH_P_IP)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv4(net, skb))
 			goto drop;
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-
-		if (skb_vlan_tag_present(skb)) {
-			data->vlan_tci = skb->vlan_tci;
-			data->vlan_proto = skb->vlan_proto;
-		} else {
-			data->vlan_proto = 0;
-		}
-
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
@@ -895,20 +899,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
 	    skb->protocol == htons(ETH_P_IPV6)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv6(net, skb))
 			goto drop;
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = ip6_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
-- 
2.53.0

