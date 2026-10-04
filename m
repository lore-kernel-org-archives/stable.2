Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C624AA02B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149086; cv=none; b=Zu0yKOVWwwBhn90CSVL0+QsWhJuDJGScA9mqjgOxfvoN9sT3frsfHy3uKL9YwnfCSpVbnb62oykIXYJY9X1A4elfPjxhZkGFh6RWP2tOPVsYA6LIHPVfIS4VLHNQDAiLym50DaYyM2s/28WiRNslGrzWFbUzJIb4X2luu4V/QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149086; c=relaxed/simple;
	bh=yd3SvQ1usHAP4aqbb+hfLrE84zju6x7zQRRGsOcQdx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1jipzTXZw49oKBXYefztorYcXX8gWty57qchRFzs0LnA3epLn/RGQ8kBq1PWalwvzAE2zYnDvpUT5KARMRzoSoB9vlcixgyLVC4UUC9gDBKi7GibLYLWhllAEwDXJ3Y9p41sLjKFCcBcvxX5M8Bie8YKCqvFsQmgIDVngnShPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnn81NSO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnn81NSO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49ff680331aso11510855e9.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149082; x=1791753882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=gnn81NSO44KA+Bsj2W3hrpsvLdEcNIvYZuJqaKGUWMv8C9fEgzbs2OC6ZyW1lzYf6W
         xIeBtSNvjILDN4Da1xWgZF7wn+dtpwMcOLbuXwKHCsOBS2KZLHae2ypuuccZ8eVEnNZE
         OS7JXf9IDnDn4xKwSsNp1blcESgGtLmANzcd1sZWl9HghPfZdjNTUEfyI7D06EAG7uHZ
         RSgiQpu2/HrcjVs3mxFonMvfnwHO/NBYBUEfT7LVl5HM+IE8iwezwYZ4bKldz62OXKsv
         n1V7NlkwHms0jRVy1zgEYNX4Uyv3BsnNFOFaDP34dJmAYibKXlrprePPncAPcsLG0o6g
         8u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149082; x=1791753882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=hVWeAHVSgldYW7kEl8uUT+JUsIFmq7baCFpSg+EKp02cbKnU8ZeFm/T5/7wnYoy5Vg
         U/YE1GedGNHr7Ug7LeazxgtQq27HX30AFmecRD4xaBlZ1Jy5z5tt5u1np+OotJYOgNk2
         5UmBRMCa6W2Qarlwn2hWNNM7YAVOe60XYErjvGjI0S/qYwsbAcccVqFUX5IhFIU9W++N
         ivboCyJ//VKlyaXnOoRJUG6agNPODTXi+4G/LVqdZ9Uof043U4owyLKoX6PRfmlAvUbJ
         GyMChBOwuoLb4TKeV+AhdvWJ5PzE+YS/5aZhs4ljA3/mK66LxhznLnwKcGCQtn1UK1EN
         ARTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiJIj2QTeu2095kZKxCIU0CbzQ1Zurt9/3upf2z04F+Iy6NWgSLIxgr1djPHaG4MuMaA+QOFc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGpeUsMXPXyIJPOpzQ9e19U7aa4IfyZr80lLaeOd7afqYBkrcJ
	auESBvSJWFIdSZeaKXTGXBDjxff8NGLSpY8guRF2zm39eSZB+py/eEtT
X-Gm-Gg: AYBFou0qNIymcR2A0G6m8rrJbP2Apa3BMFG3XpXf3x+FpKGhstCpnHihSjqTlxJv1dI
	2u1SCXGX6PBQMOmAhv+6IjgN0FysC28OHgCpVu5RbPPxKyFJNWYB4XiDDej3eOLkFa4B8j0IMhv
	+bfM3RKB96hfQfJV8cH3n9zrGEuZKMFPmRYSXLMW2w97FKIfcrfk/W90FGs47ZYVh1oVi1mhNeV
	m8Gtd2hxTtLhnXYdEsUlU2/w8CiGIEo43fulPCd+EkRJbEEtpEVDTrnfNu5kczNqGVDaCvHVLPZ
	ZsPCwKBMYq7k9c0OqqCP3eEQ8gHJKoEIqtnI6t/2+CxtJQnrhI+gy3MGl+H/QOJiQ9JNCaTMdzT
	63H1t+FfmTA96joqzd87b3PYZoIlvTYvcLdlFaJAmQsx+mXcT3C05YWT0H9qPaJtXFlyvOzjs4F
	33EKYJIWk34zssdfn6K1GP8PQBXoXsvg3i2GsgZdwGw5UJCu73mTjECHU1T3IsNhvgMFv0jNbYG
	S408EgE3Kxg1qGl3vLihTYM7WWaQ8n5wc82yQdrTG9h/iGrcw==
X-Received: by 2002:a05:600c:548e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a168106b7bmr77512805e9.33.1791149081734;
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm20407354f8f.27.2026.10.04.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Sun,  4 Oct 2026 23:24:27 +0200
Message-ID: <20261004212429.3648-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004212429.3648-1-parri.andrea@gmail.com>
References: <20261004212429.3648-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, or on any bridge with bridge-nf-filter-vlan-tagged enabled, this
can send fragments with a different VLAN tag from the one selected for
forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

This was reproduced on a VLAN-aware bridge by first refragmenting an IPv4
VLAN 100 flow on the same CPU. All fragments of subsequent IPv6 flows left
with stale VLAN 100 instead of the VLAN selected for their egress ports.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so the fragments that ip6_fragment() builds
use the current packet's VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..fe8d2910dae21 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Saved for br_nf_push_frag_xmit() to restore on every fragment. */
+static void br_nf_save_frag_data(const struct sk_buff *skb)
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

