Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586847AF42
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577466; cv=none; b=nzgJXTs2HODLndvZMBSasivFlUh+KzztQBO18a1Wh/FH/gitQR9TJI6JwA7QHNbHy9uTgyQIiTxzKFaWU7ihGcCgi/s13OnaLb0jZFjzAKNLud/hr/qrzRPPEANUkGXteP52KW8Y4i8BqQfepO1pYwB/p97lIfeJPRtWWRhm2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577466; c=relaxed/simple;
	bh=Ue0t80Atf9FROn1T+Fppzbjlf+qCi8HLopNvvDd8atU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7sLXY1qJLqk9UPLlFxHrX7ZtiNVS4rCMEebvgvyL/rOxOB71WhpEXdbfoYFaX90BdOdOapGp6K2JaRb4eFCGDeaUaH8/dC14LHGdLxtjbMhjujzieENfTENgl1dgEOS2zw4niuKjGaB+ra20y+OGMFAbUMIuY1H25x6AqmcDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbMaw+lm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbMaw+lm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf36a6905cso4373015ad.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577463; x=1781182263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seUz59e0svXloX8vBJn/Xnyh/69QhVVV1JmT7ssvJbs=;
        b=hbMaw+lmZK8JNCLjk7Mws1+ERpGPqsRK0gZFnPOu0Ix6dSnq2SYLvuW/0GUcnLLZWh
         /l40EFEUZzdm710dRE8jYQEU4KLHnbvzZoqg7oGMHDkitZA0t+gswDhwaG1lVaK/cLO2
         DO9lCu+GDV0H+/IBVbVqPgMWrIBaRJalX+IUrPcOn2UiJqn32ud+nh8JwGW3SQOiHg48
         OvMdo+f3YIu1jntsbZc1NdcaaHk9LQLNWpWyaiwRkdYx4IudPlLZNCzCBKREJYo+O4qU
         KcJ/MtaVb9dxDobksslXY4JHal8ghsK+GEv03zAQLRXla9Y5WN/TJFxT4kf6By1Z+WUV
         YWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577463; x=1781182263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seUz59e0svXloX8vBJn/Xnyh/69QhVVV1JmT7ssvJbs=;
        b=rC8IBHKXZCGo1s5Y3KuBr5RW9V/wRiqnu/Uh63n8eL5w4t8zDu5vqq2BAxBvICgWXI
         1AE3XQxOL7Yx6Dhkk7G0M7Kwee0cOv0PwGuCrWyDAPxUztpjyvhiLnJdUbEo8RKEYbYZ
         JVjfB94Eg56VU2q5eSdKM6E+kVeV7zXdlY9gnnEZeS/JGcOgIGH+zATp1dQFKorBHSZI
         ZPkcKOVrKi3EhgE9aMULqr4nVP6VxnNdTQHJtqggOWIfGVwVKv8DXU8+kJbJqXbv7kOQ
         Bn1CvL/LzRDrElX2UlBGlRnF9qABpUb2/FTHkG+Orz4HerCnXiBl4Xi23zaZvGQShVom
         J4Lg==
X-Forwarded-Encrypted: i=1; AFNElJ965JNlgnEg8rAs5KcSfnws3V8R/qox4XOwfLWbtAkAfF7dSkG//+qviJk24dui8fS3U1/NWMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSFR32hLkXwCraoTQ6HpbdG1hj1AYzgAHv+b1OubdIniXLrIM
	Hs6ScSB08FdMSfTwY5vo8LpwNY6wSZ9AF/cUaRTBZgJinPKVqJRfmn1w
X-Gm-Gg: Acq92OGQsz0QI8gD/06CU8XXUquKpJAZ5e86ZLfsU+Qs+SSMx+KYUeTNnE/4EjwlqFV
	ibLVP4titmJEtOV8Y4e6XYOEe40XP1fwww4k55yQz/Lbud4Q59dAC+Kk+mdEkVeDoPLFCb5ps80
	HdHt4hacP8Qj1wzcbc7w7LBrYmSZ0ObwUVtKhZtyxDO/fvLRtIaRnapIt+pCFXtolCbPmk27qzM
	+JKnxfZCyLmhKlOVJvzdSF3ECbgiM0KO1szoKRmoxgAE5AF2O/QAaAUNGwZqwcUrA5ySCfb5tAK
	8poNMzokmLTTgkfFXurpizyORJ5Tp2CLv/10ioZgq555fWhD7SJrKzUluaXI76c9HCzFiEjgSDI
	CRFLHBQZ6+A8yzm1Twl2oKsuUBfNXr2A8nINIZbSKVaHepln+7OT0wIjtVP9fUkbEPj+SGanNOH
	gWH+9zSVgqgDHiWstrfQJmOyEsF30QJjCCUZ9kTVg78HnGzOYK/UUylqyjlPA=
X-Received: by 2002:a17:903:3b85:b0:2c1:8fea:4dbf with SMTP id d9443c01a7336-2c18fea4df8mr50899115ad.8.1780577463135;
        Thu, 04 Jun 2026 05:51:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm57654715ad.20.2026.06.04.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:51:02 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: dsahern@kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v3] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Thu,  4 Jun 2026 20:50:55 +0800
Message-Id: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink mutates the tunnel state in the device's creation
netns. After an IFLA_NET_NS_FD migration that creation netns differs
from the caller's netns. The rtnl changelink path only checks
CAP_NET_ADMIN against the caller's netns, so a caller with caps only in
its current netns can rewrite a tunnel that lives in the creation netns.
They pick the endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This adds it on the RTM_NEWLINK path.

Gate each tunnel changelink on ns_capable against the creation netns, at
the top of the op before any attribute is parsed or applied. The ipv4
types need it there because the parsers can update live tunnel fields
before ip_tunnel_changelink() runs, for example ipgre_netlink_parms()
sets t->collect_md. The check is skipped when the creation netns equals
the device's current netns (net_eq), where the existing CAP_NET_ADMIN
check already applies and no extra LSM hook is wanted.

The newlink path has long checked the capability in the link netns. The
changelink path never did.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v3: Per Kuniyuki Iwashima's review. Move the check to the top of each
    changelink op, before any attribute is parsed, because the ipv4
    parsers can update live tunnel fields (ipgre_netlink_parms() sets
    t->collect_md) before ip_tunnel_changelink() runs. v2 placed the
    ipv4 check in ip_tunnel_changelink(), which is too late. Also skip
    the check when net_eq(creation netns, dev_net(dev)), to avoid an
    unnecessary LSM invocation when the netns is unchanged. This also
    answers Xiao Liang's question on CSUM and SEQ only changes: with the
    net_eq guard the capability is required only when the device was
    moved to another netns, and then every changelink writes the
    creation netns tunnel regardless of which attribute changed.
v2: Reworked per Kuniyuki's review. v1 gated on
    dev->rtnl_link_ops->get_link_net in __rtnl_newlink(), which is too
    broad. For peer types like netkit and veth get_link_net returns the
    peer netns, which changelink does not mutate. Moved the check into
    each tunnel changelink against the creation netns.

v1 [PATCH net]:
https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/
v2 [PATCH net]:
https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/

 net/ipv4/ip_gre.c              | 8 ++++++++
 net/ipv4/ip_vti.c              | 4 ++++
 net/ipv4/ipip.c                | 4 ++++
 net/ipv6/ip6_gre.c             | 8 ++++++++
 net/ipv6/ip6_tunnel.c          | 4 ++++
 net/ipv6/ip6_vti.c             | 4 ++++
 net/xfrm/xfrm_interface_core.c | 4 ++++
 7 files changed, 36 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..02328c9a3c07 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1457,6 +1457,10 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1486,6 +1490,10 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..91c6b2ed7d30 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,10 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..95976e551bbf 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,10 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..7b86deda7e1d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,10 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2270,10 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..dd1458633ec4 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,10 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb..d981ec710f0b 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1044,6 +1044,10 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..f11a22edade9 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,10 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");

base-commit: 78ef59e7a6459b16f8102e0ee1c718443323d1af
-- 
2.34.1

