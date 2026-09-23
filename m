Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72229386C3D
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135550; cv=none; b=L+j40wM9MGLU82TRkerKjqT7m/QLXO6+vIRJahRohItgVuU8g0aD7AhqqbzcwndiSzZook6y0jFFh+rrfPNEPu7YZXY6LTNBj4/uGASD7LeyIMqo6urr+RO7AuhSR5X8gn8nU7Coh7bXVBNNgGlWlAKvx6d3MzKH4dzxXef5+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135550; c=relaxed/simple;
	bh=rPiC+uCFu90Lqkt4Qk9pCC1tgZC5YFuVirJ3CyHve3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKIkoDtf9h+8sv1folZpynJqfv4LD1UhffbPy7u3S1/L+Ns+28L2zX1Ftu8ryLWJcFja0SYvNH37OIq5XD4XiK/62kjrktKxbIQPI6L5eztsFUjhw0B8nH4blh8VDgoaA1QoQ4Ej84YPPUpWE+KUvqCqGakJqkIumA1fBBAR/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RbEt4pJN; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbEt4pJN"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939d6c515deso111683985a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135547; x=1790740347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AvunH3lZA5SzB1/nKEm1wbN4OSx5dvqfXoKjGa22K0=;
        b=RbEt4pJNq2JGsdsk+56YzQky00jzAOi8WAswFmqtjK8tAIJit+JxSuvYyKAhuLlih3
         qICGsdXmr6UAG39XdxCl1TKP6exVlSWnCspmZ37PMBelF7XjaTlP1LyswA518sKSI6UU
         71j7TMSp1V0lfS6M+G7aMMrDx3wfZDujLfCnNhV3sjFj5jBI7xFMIFe6D016apRSmAfD
         80H01umLPwpUaoGQjK8KOJGrDcrfEuysyuTt4hoSfhCdBSOyvWfCYxonmogKxTT66rKw
         HYQUcU+rqddPuMhfFLJzsSflU1SGe4Xt7mW1/h7iNRhmbYIyhcb9okHx4psA4tPThS7D
         GmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135547; x=1790740347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AvunH3lZA5SzB1/nKEm1wbN4OSx5dvqfXoKjGa22K0=;
        b=GQIsTdDWET+H0Atg/8GdOzNS6YXvfUtXSCj5j07Sx9NdD0TXPU8jWcLQWi8jj7NmLx
         z90nfSY1c6xy2TfT/QlnatftOc6sDC9Mm/wyZvVB+K/NWqvP3e4ou+N2FIVDbQ07YPHo
         s2DNrzCRHEiSVNItcFoi3h+wwQO14cjY0n+hf7pRrN33pHr+7woHiFYyvVdrlN4sHV6m
         jSLU16OOeNEHliYLpQRQmXc3XjbwFlJ/c3DylKD0bm0UFC9Ur3V9TW2YcWoLlHFH3X4Y
         dEMt5nO4pZoxyBl82KcP/m1c0+2I4p6XbSqam90KmERfI98gZjbVClnZXb2Y7W2ErGPu
         kWRg==
X-Forwarded-Encrypted: i=1; AKwUvByMi8FbFZ0hV1KdimgmqhMnyAVvJF+q9cIdWCiKisNFITjdCPS+dM/KiZUf4Xk8I0+NUpMdPLY=@vger.kernel.org
X-Gm-Message-State: AFuF++lznQINbPijL3QiHBOXhIKLaUu+v/dAGy4Yj5/dLCSn9jki5Qep
	Lin4V7YWowPJP4IZz7/76Uca2f0Mout4iJr1A52aFbHvItw2ZguLmsirPRqOFpyE77Gt67Lbx3T
	2mwWZPBY1a87+DA==
X-Received: from qkmy30.prod.google.com ([2002:a05:620a:e1e:b0:93c:2c30:6178])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4403:b0:936:e938:b07a with SMTP id af79cd13be357-93c25096a23mr215616385a.8.1790135547082;
 Tue, 22 Sep 2026 20:52:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:14 +0000
In-Reply-To: <20260923035217.179102-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923035217.179102-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-3-edumazet@google.com>
Subject: [PATCH net v3 2/5] ip_gre: validate netlink attributes before
 changing the tunnel
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ipgre_netlink_parms() and erspan_netlink_parms() mutate the live device
and tunnel before all netlink attributes have been validated:

1. ipgre_netlink_parms() sets t->collect_md = true and changes dev->type
   from ARPHRD_IPGRE to ARPHRD_NONE before validating IFLA_GRE_IGNORE_DF
   or running ip_tunnel_changelink(). Moreover, unlike ipip_changelink()
   and ip6_tnl_changelink(), it accepts IFLA_GRE_COLLECT_METADATA during
   changelink even though ip_tunnel_changelink() never registers the
   tunnel as itn->collect_md_tun; a subsequent ip_tunnel_del() then
   clears itn->collect_md_tun and blackholes the netns metadata tunnel.

2. erspan_netlink_parms() writes t->erspan_ver, t->index, t->dir and
   t->hwid directly to the tunnel before validating the remaining
   attributes or running ip_tunnel_changelink(), leaving the live tunnel
   with a new ERSPAN version paired with the old flags and parameters
   when a later check fails.

Reject enabling IFLA_GRE_COLLECT_METADATA on an existing tunnel during
changelink, stage the GRE and ERSPAN attributes in a local struct
ip_gre_parm, validate the netlink parameters before setting up the
encapsulation, and commit them to the tunnel only after
ip_tunnel_changelink() has succeeded.

Fixes: e271c7b4420d ("gre: do not keep the GRE header around in collect medata mode")
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 115 +++++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 38 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e0f1f6554e7028be8e05d769e932d..df4d2f1f1d60c7f3755e4f554f04a06480512909 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1183,15 +1183,41 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+struct ip_gre_parm {
+	__u32	fwmark;
+	u32	index;
+	u16	hwid;
+	u8	erspan_ver;
+	u8	dir;
+	bool	ignore_df;
+};
+
+static void ipgre_commit_parms(struct ip_tunnel *t,
+			       const struct ip_gre_parm *gparms)
+{
+	t->ignore_df = gparms->ignore_df;
+	t->erspan_ver = gparms->erspan_ver;
+	t->index = gparms->index;
+	t->hwid = gparms->hwid;
+	t->dir = gparms->dir;
+}
+
 static int ipgre_netlink_parms(struct net_device *dev,
 				struct nlattr *data[],
 				struct nlattr *tb[],
 				struct ip_tunnel_parm_kern *parms,
-				__u32 *fwmark)
+				struct ip_gre_parm *gparms,
+				bool newlink)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 
 	memset(parms, 0, sizeof(*parms));
+	gparms->fwmark = newlink ? 0 : t->fwmark;
+	gparms->ignore_df = t->ignore_df;
+	gparms->erspan_ver = t->erspan_ver;
+	gparms->index = t->index;
+	gparms->hwid = t->hwid;
+	gparms->dir = t->dir;
 
 	parms->iph.protocol = IPPROTO_GRE;
 
@@ -1234,20 +1260,24 @@ static int ipgre_netlink_parms(struct net_device *dev,
 	}
 
 	if (data[IFLA_GRE_COLLECT_METADATA]) {
-		t->collect_md = true;
-		if (dev->type == ARPHRD_IPGRE)
-			dev->type = ARPHRD_NONE;
+		if (!t->collect_md) {
+			if (!newlink)
+				return -EINVAL;
+			t->collect_md = true;
+			if (dev->type == ARPHRD_IPGRE)
+				dev->type = ARPHRD_NONE;
+		}
 	}
 
 	if (data[IFLA_GRE_IGNORE_DF]) {
 		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
 		  && (parms->iph.frag_off & htons(IP_DF)))
 			return -EINVAL;
-		t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
+		gparms->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
 	}
 
 	if (data[IFLA_GRE_FWMARK])
-		*fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
+		gparms->fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
 
 	return 0;
 }
@@ -1256,39 +1286,39 @@ static int erspan_netlink_parms(struct net_device *dev,
 				struct nlattr *data[],
 				struct nlattr *tb[],
 				struct ip_tunnel_parm_kern *parms,
-				__u32 *fwmark)
+				struct ip_gre_parm *gparms,
+				bool newlink)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
 	int err;
 
-	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
+	err = ipgre_netlink_parms(dev, data, tb, parms, gparms, newlink);
 	if (err)
 		return err;
 	if (!data)
 		return 0;
 
 	if (data[IFLA_GRE_ERSPAN_VER]) {
-		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
+		gparms->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
 
-		if (t->erspan_ver > 2)
+		if (gparms->erspan_ver > 2)
 			return -EINVAL;
 	}
 
-	if (t->erspan_ver == 1) {
+	if (gparms->erspan_ver == 1) {
 		if (data[IFLA_GRE_ERSPAN_INDEX]) {
-			t->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
-			if (t->index & ~INDEX_MASK)
+			gparms->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
+			if (gparms->index & ~INDEX_MASK)
 				return -EINVAL;
 		}
-	} else if (t->erspan_ver == 2) {
+	} else if (gparms->erspan_ver == 2) {
 		if (data[IFLA_GRE_ERSPAN_DIR]) {
-			t->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
-			if (t->dir & ~(DIR_MASK >> DIR_OFFSET))
+			gparms->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
+			if (gparms->dir & ~(DIR_MASK >> DIR_OFFSET))
 				return -EINVAL;
 		}
 		if (data[IFLA_GRE_ERSPAN_HWID]) {
-			t->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
-			if (t->hwid & ~(HWID_MASK >> HWID_OFFSET))
+			gparms->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
+			if (gparms->hwid & ~(HWID_MASK >> HWID_OFFSET))
 				return -EINVAL;
 		}
 	}
@@ -1401,7 +1431,12 @@ ipgre_newlink_encap_setup(struct net_device *dev, struct nlattr *data[])
 
 	if (ipgre_netlink_encap_parms(data, &ipencap)) {
 		struct ip_tunnel *t = netdev_priv(dev);
-		int err = ip_tunnel_encap_setup(t, &ipencap);
+		int err;
+
+		if (t->collect_md && ipencap.type != TUNNEL_ENCAP_NONE)
+			return -EINVAL;
+
+		err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
 			return err;
@@ -1417,18 +1452,19 @@ static int ipgre_newlink(struct net_device *dev,
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	struct ip_tunnel_parm_kern p;
-	__u32 fwmark = 0;
+	struct ip_gre_parm gparms;
 	int err;
 
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
 
-	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
+	err = ipgre_netlink_parms(dev, data, tb, &p, &gparms, true);
 	if (err < 0)
 		return err;
+	ipgre_commit_parms(netdev_priv(dev), &gparms);
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
-				 fwmark);
+				 gparms.fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1438,18 +1474,19 @@ static int erspan_newlink(struct net_device *dev,
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	struct ip_tunnel_parm_kern p;
-	__u32 fwmark = 0;
+	struct ip_gre_parm gparms;
 	int err;
 
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
 
-	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
+	err = erspan_netlink_parms(dev, data, tb, &p, &gparms, true);
 	if (err)
 		return err;
+	ipgre_commit_parms(netdev_priv(dev), &gparms);
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
-				 fwmark);
+				 gparms.fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1458,24 +1495,25 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
-	__u32 fwmark = t->fwmark;
+	struct ip_gre_parm gparms;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
-	err = ipgre_newlink_encap_setup(dev, data);
-	if (err)
+	err = ipgre_netlink_parms(dev, data, tb, &p, &gparms, false);
+	if (err < 0)
 		return err;
 
-	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
-	if (err < 0)
+	err = ipgre_newlink_encap_setup(dev, data);
+	if (err)
 		return err;
 
-	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
+	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
 	if (err < 0)
 		return err;
 
+	ipgre_commit_parms(t, &gparms);
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
@@ -1490,24 +1528,25 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
-	__u32 fwmark = t->fwmark;
+	struct ip_gre_parm gparms;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
-	err = ipgre_newlink_encap_setup(dev, data);
-	if (err)
+	err = erspan_netlink_parms(dev, data, tb, &p, &gparms, false);
+	if (err < 0)
 		return err;
 
-	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
-	if (err < 0)
+	err = ipgre_newlink_encap_setup(dev, data);
+	if (err)
 		return err;
 
-	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
+	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
 	if (err < 0)
 		return err;
 
+	ipgre_commit_parms(t, &gparms);
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

