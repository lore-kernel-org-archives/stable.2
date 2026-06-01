Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C826ED3A
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285317; cv=none; b=SaYY7Ne5FZ71Pd5RS4M0GE95uWV81Hwso/on0w9FvraLMjDk+XnOgphtfxNPpiSqsNad+7s1yU2zGcSWsBWZf4ZPqg0X1hbwsVfBBVhp/WOmkBWPandd+qsgJH/8NPWF3k097upUtzG7ZHwlVMlZovFdD+JqdFpYhyFf330I+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285317; c=relaxed/simple;
	bh=GEhvFyiVmNJeqdaA6eLWoM9Z2RJA8csZr6MFKMn8Zec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mOM6XwosECAlrrE29szcmbx1Eu6n4g6JOosrsZiCuqwUr1En/CAyLqYeaok7UxY3wH+4d4Ymn5nCr8YtRIUzYWrxRF033GTyvaLlBdFBcoZd2RC0TzdUzJez3pTInfrDpllAiO1cJ1Z265gI0uB+KNUroraGbiIyLHUuBXjpcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi+nauqQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi+nauqQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so2128998a91.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780285315; x=1780890115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZZTE+oP6vZaNBQBkjw1JwOrw7qBKUTRNGV3G9H2hng=;
        b=Vi+nauqQZzyVIC+xrqrREWIqhHFckOf4FHmSDku3s7Ov2TIBIjlQMwrPt4pij2KRsf
         wYa8pRQ6preNqnpcJpJEX1bBE/RZVG7gnFawflbdeU39Au2Sobme6Rukpjnm9RLqQgJQ
         lEbsA/DgLIxe0kzeb+n6v9VlgzPJG3+j7/s5OlNY3jSFZkM1KquFmfYTVHTT6uLTyvqu
         abbwgX87tXaQ/94kaT6OyS0c+dmP+hCfmc0LPTUAYebPTZUqEuWXTAfEM74Z5cpImDrT
         v1SzCW8Hs5LwDKNvgy92Eb8cff50FObRq0deVD7Eo059zNA99hpT48mltOR4vfr8WDnl
         hTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285315; x=1780890115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZZTE+oP6vZaNBQBkjw1JwOrw7qBKUTRNGV3G9H2hng=;
        b=btJMA2PvHyae1fLw874Z2LUco+YzL4z4RKlUdJOg2J5YubsidTS6pT2hXvJfLg5zO4
         hckdZuu/H1GU5IM93r2suSaVwH7g0g8RcArQSyUYP80MHf6cxjQ3+B5VZrUnUCQQHSPc
         81CJjhHACl2/uytdpMboyi3glLyCqZLi3fyuq+1e9jpwpjFTaY7ZRHRa/O8VaJkEcd5p
         BfC+CD07oGCrvySEUBOITVlgm46CM56WWRkMArsahrjZpuhFIRKmT8XvbgUKjkrlKYHp
         BknlOCU2vz0EkjzQrxEjpzl7XJvy0uK5Nlj+u4IVS93ysxIcL8QS7OpaPvN6y6sbQXdE
         GlPQ==
X-Forwarded-Encrypted: i=1; AFNElJ914HtA0xEayhWc/dQNb5+vHuzEOd99iDNdJQ5BOah/4S7FzSg8UG4fsWoI2wOl/Sl3MZXdxCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yoWS+sGBeuAr7HnJMOFfQ1gPOPBNDtY1VDtXAWiXGNYkm03p
	shygovaPmKxde3Oq7F9pfLuw7kfn2zBUHRtGxcKSMnUcDdUqxitrCk4i
X-Gm-Gg: Acq92OGEXVldFtLt0ebcmWiaXvMWbYDy7TqPCTldBeYrsd9qDJZrgFlfPwb6MLUs6v/
	GqQPytIahTWrkDdCB2RolTflhZGMX2rhrccNWwtYJWoCY2HKEXjdbbexZp1PCT4j9h+zZcMinFK
	FbFGB6R2wRftYCTPD3BzMSGdjLN9p5i2Wp4E+3jX2Wc96m5BsNpfEw+ncBlZU4LHXxI95v5i4Tf
	g7RvTq9cFkkCVrHQsidC++KjlllxsJpfe0E/axb4jX+ihjPxY7WrYpY+3X2OBsnBkBWSCbQHcWA
	QDfHLw0rDja4wk+uuuEOxO6LFTChYki43Zs9pWNw0OtjD3WAeAIPIjG+4vKymQvrPiL61EnAAIB
	28R/CduupGNAYYJTKuZxO/KCwUPf8cg1XTFCvgeUkUiHLHWsV0mNbvc613Ua8eM7dEzJOFvQ1Fv
	EN1rCzvDsXesgVeU1COUCPyY9U+edkz9efONPtuMHrSfXVycKFoNOynt5M81I=
X-Received: by 2002:a17:90b:1b0a:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-36db6628d75mr2305338a91.9.1780285314995;
        Sun, 31 May 2026 20:41:54 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc90570sm9605036a91.4.2026.05.31.20.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 20:41:54 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Mon,  1 Jun 2026 11:41:48 +0800
Message-Id: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink mutates the tunnel hash of the device's creation
netns. ip_tunnel_changelink(), ip6_tnl_changelink(), vti6_changelink(),
ip6gre_changelink(), ip6erspan_changelink() and xfrmi_changelink() all
look up and update through t->net.

The rtnl path into changelink only checks CAP_NET_ADMIN against
tgt_net. After IFLA_NET_NS_FD migration the creation netns differs from
the caller's netns. A caller with caps only in its current netns can
then rewrite an entry in the creation netns hash. They pick the
endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
adds it on the RTM_NEWLINK path.

Check ns_capable(t->net->user_ns, CAP_NET_ADMIN) in each changelink
before the lookup and update. The newlink path has long checked the
capability in the link netns. The changelink path never did.

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
v2: Reworked per Kuniyuki Iwashima's review. v1 gated the check on
    dev->rtnl_link_ops->get_link_net in __rtnl_newlink(). That gate is
    too broad. For peer types like netkit and veth get_link_net returns
    the peer netns, which changelink does not mutate, so the core check
    would wrongly require CAP_NET_ADMIN there. Move the check into the
    changelink path of the tunnel types that mutate t->net, against
    t->net->user_ns. This mirrors the ioctl side in 8b484efd5cb4.

v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

 net/ipv4/ip_tunnel.c           | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 5 files changed, 18 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..51d8787318f3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1251,6 +1251,9 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = tunnel->net;
 	struct ip_tunnel_net *itn = net_generic(net, tunnel->ip_tnl_net_id);
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == itn->fb_tunnel_dev)
 		return -EINVAL;
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..0de4994bc92f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..2834004c7011 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb..7b05e0c491db 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1044,6 +1044,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..a1029a829406 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1

