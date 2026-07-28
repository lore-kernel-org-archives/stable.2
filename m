Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0142F701
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241010; cv=none; b=DX3foCLhSzSev2vA4FLLBN8tWKabFxO5i0H/tL4+bQvekklh64ZiXCqsQMJ1WshKITtibkrRADXHHla0wf94KO+ecsCA3MWnHSoM5s0It8gvoyQu/a/XFnvvbTVpwif8csTGG7YJI94JTE0MMk4vUMDxHXf1v0sNOLfH4JLoJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241010; c=relaxed/simple;
	bh=ptIzxn0rT8chC3i5KJruCwVZEwBekkUQAAhiLQuYZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnkg/FoK43A+/Izn+9kln0HYzd/lRZWk97jA3UgJHetyPC9N/GZpEC7JMLBQOUfvS9xmUr3zoyzmJxtTD4c6DHUtxCASfJXSUD06045tHjcI40a0byARpbP+8aQ4DDKsV1i8N27znwTRMwuasjWaj3neZuQrlHO0N086ZmXRdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPrjeF8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPrjeF8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9C71F000E9;
	Tue, 28 Jul 2026 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241008;
	bh=siEwVnoq35B+lZs7xFxw/7lUqzjCYh+IjvKG//X5UhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPrjeF8Z8ziqp+RLgdKOQJP9R2y1ZE9bo6vd+xC3lq1YJHqczRLtWL5dF7UFqyJPT
	 9478fpqrdZaBDbzsHo5HtyYeV7FuYZ14Tq/xFJWqwCzupLGFVzJSGNZpdaCfjDoY8H
	 eWD0SeziHdoqbkDUVXyzFjJ+bRzjLEFxM76aN4zZn2PajH7n8Pq0Pn0OnVMykXVkyA
	 HvoFyuv3zmPCeZ5X7WEMfr63MHQyOvpikV5won9+SgfHcHnv/BthgMauBTZEOpKOp3
	 rNAnLi0vxqZ/qGE9Ry4T4fJJ9qq0mOhCllqDVpYtyDHYPipbO7CAcrfQhvsFOat4v3
	 1Sew+xFsaCCMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Jian <liujian56@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: Add helper function to parse netlink msg of ip_tunnel_encap
Date: Tue, 28 Jul 2026 08:16:45 -0400
Message-ID: <20260728121646.3713785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072006-purely-upload-afbd@gregkh>
References: <2026072006-purely-upload-afbd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 537dd2d9fb9f4aa7939fb4fcf552ebe4f497bd7e ]

Add ip_tunnel_netlink_encap_parms to parse netlink msg of ip_tunnel_encap.
Reduces duplicate code, no actual functional changes.

Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 8211a2632466 ("net: ipip: require CAP_NET_ADMIN in the device netns for changelink")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_tunnels.h  |  3 +++
 net/ipv4/ip_tunnel_core.c | 35 +++++++++++++++++++++++++++++++++++
 net/ipv4/ipip.c           | 38 ++------------------------------------
 net/ipv6/ip6_tunnel.c     | 37 ++-----------------------------------
 net/ipv6/sit.c            | 38 ++------------------------------------
 5 files changed, 44 insertions(+), 107 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d7a037d32bcc2d..b4be1f90f1495d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -297,6 +297,9 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm *p, __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap);
+
 extern const struct header_ops ip_tunnel_header_ops;
 __be16 ip_tunnel_parse_protocol(const struct sk_buff *skb);
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 712555c56a1836..b35153758fdfa4 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -1099,3 +1099,38 @@ EXPORT_SYMBOL(ip_tunnel_parse_protocol);
 
 const struct header_ops ip_tunnel_header_ops = { .parse_protocol = ip_tunnel_parse_protocol };
 EXPORT_SYMBOL(ip_tunnel_header_ops);
+
+/* This function returns true when ENCAP attributes are present in the nl msg */
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap)
+{
+	bool ret = false;
+
+	memset(encap, 0, sizeof(*encap));
+
+	if (!data)
+		return ret;
+
+	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
+		ret = true;
+		encap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
+		ret = true;
+		encap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
+		ret = true;
+		encap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
+		ret = true;
+		encap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_netlink_encap_parms);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 75d35e76bec2c4..358aaedd27b2ab 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -446,40 +446,6 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip_netlink_encap_parms(struct nlattr *data[],
-				     struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ipip_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
@@ -489,7 +455,7 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 	struct ip_tunnel_encap ipencap;
 	__u32 fwmark = 0;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
@@ -510,7 +476,7 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index dda90c77f89840..d56ac2e1ce4aa9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2034,39 +2034,6 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static bool ip6_tnl_netlink_encap_parms(struct nlattr *data[],
-					struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
@@ -2079,7 +2046,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -2116,7 +2083,7 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 89581010a1526b..1027bd104941be 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1536,40 +1536,6 @@ static void ipip6_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip6_netlink_encap_parms(struct nlattr *data[],
-				      struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_IPV6_SIT_6RD
 /* This function returns true when 6RD attributes are present in the nl msg */
 static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
@@ -1621,7 +1587,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -1676,7 +1642,7 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == sitn->fb_tunnel_dev)
 		return -EINVAL;
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(t, &ipencap);
 		if (err < 0)
 			return err;
-- 
2.53.0

