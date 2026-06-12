Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E5369D77
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254792; cv=none; b=kLo3miFV4IT3oNOsWs9wUSGMpEWXXKdJpYe38fSaxKmGpgCxXiOfnjZ93q66x8spnMQ9JY+TES2uDSk3otGtCk7lNGn8UVGUIuMa3shq7fZisxuOOq22EndzQ6qwE4DGxwaWFKx+u9EpjuYpPuivYRSFtGGo/bPGlzLEW9HnK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254792; c=relaxed/simple;
	bh=G05kt+p38tNXHiYLTc4A2JJZbcOK706Y/c/CzobEF8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iul/Pd1jixlQuqLRQ8CDOp734mjGUUN+I5rug6s+TdnLdppDCvIpeXsrIp0H3HjR7I1uuLa/Qd9iHsj+m4wQ0Jo45g9w2+B2PAOCVSHjFrlUsqMmkrfNw/YsEEGVSJtCQatEwuVTsBq/hVTdBrpAIBt11uXnFZDW16HoY2KYj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrfxVDWB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrfxVDWB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8573e75425so267450a12.2
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254790; x=1781859590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3glrKxkjlf2Vk5WupEYNGotMiOWYzbthgIen70t2gY=;
        b=mrfxVDWBvaNrgAhXbOyJACb6wxOK3ns+pyBfAuyFYXsOUnMuMH3a5LSYSwYNCZeeTt
         IqTKNjrV+KVdsAMR4/y9e8Qj+kR5NL+xHIq8gcFfyT6UZHS8YbyASOq9fkwF5L994E2u
         hJWzbDnybGWZWQKv4SlzfUdOvDYi2ySpi53V2uyURqYBJaErvFTPyhkuNUoy+Y+D8Gf0
         HwC0KggZs7rbb9YxlfTYRQaO5lIdT6c0KCWtrokuxuWQpwprDD9nTVFFlPIhxQ3b/gj8
         U6tUZ5sG11Cxh+uiEI80AFi90piQKfJrFXfVl6N5YTHQPbi+mXch73m+wBpEiGCno74c
         weSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254790; x=1781859590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3glrKxkjlf2Vk5WupEYNGotMiOWYzbthgIen70t2gY=;
        b=cjsI/ByCIjBhH4VZEc+SF6eNqk1jOIVKl8oJd1dz1otoiM5699n1Mlg1ge5C/wUDsV
         4VK9ipAP0594PxD3ZIzZWLBYAMh91X3F0/JK+qjKnAnt0t3cvQ1bMI86+jeeUuVxaQHa
         cUBsn3DisaP9KSafmDhdLuDtJAIKndUpFoQJEtmAuAPyqQGejH6jQHHi59k5Ed6yIN2h
         9FpyXOH1S/ZlRK35UIQrdSFBf3TWFSVunQztLHa2+t55jzFc2cW91IYpxxhM9hCkpsCN
         O7eKyBEpvUSqKT5U3Gw59wSXBN1LnoiLTOggTEjcSRTnGCRswrNOeDWdcZG0EWm2NVRE
         HALA==
X-Forwarded-Encrypted: i=1; AFNElJ80nAOAz3RFUtR2WN56KA4eaavJkCR/sgUkz+R7PJXFYcM8cXDgSF2OPA+82POmlH84VhPLKx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Vb5i+NME2vQC5zwaaA2tgkPIH0KTdiXNuUIkyc46mcStna8I
	+y4WS4/p6ENkzTjTPxRd6gYQc8mMSivKPegY6oKZFcVHBVSG+W972UhB
X-Gm-Gg: Acq92OEENILiYZeNyPkGCA53CxscMmzMv0YUwvki29KpaFIX1d+0RSl49H76FoKD6mw
	Jf9M41Tfg9yzZYjN+oE/zn03RurPT9cUv6TmDz7ZS77wE6w0999zG3DTS6NtFJ9/M6c6QeF+z9h
	LvvXuuh7OMC1i42cmhNi4Ej6SPm/CVmKM7K3l6NkK2/u2SViW/DIqKISci0qBJhXIAWwoT87k+H
	xPRGvqqpaQQhGoLCLzYQZ2aA2oJmmSW1uWyRY8eIu9fBlf/9mqp2rTlcj5YeavcQIFQGWaYNcQt
	bJL6YJTaxjF0By82T3G4wk2bLlCX3LW/InLDq45BxUsjIMZsNg688m9Y/jSA38rw/cJPLfeyJab
	UKOcZuK7KyENIbSObBBB7BkDJx0DAcfzPzJDtclEUpXZUW/H95kJZKL+Osqx7b45E6x7m8qwa0f
	KUNI+6PkQDfqFSVJJZlM7o9DlJmbq7h9V9JcmR7hB96gtHGrGg
X-Received: by 2002:a05:6a00:4b55:b0:842:248e:5d26 with SMTP id d2e1a72fcca58-8434cdf7dbamr2138726b3a.11.1781254790583;
        Fri, 12 Jun 2026 01:59:50 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:50 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 1/7] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:35 +0800
Message-Id: <20260612085941.3158249-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Add rtnl_dev_link_net_capable() next to rtnl_get_net_ns_capable() in
net/core/rtnetlink.c. It requires CAP_NET_ADMIN in the link netns and is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked it. The other patches in this series use the same helper.

Gate ipgre_changelink() and erspan_changelink() with it, at the top of
the op before any attribute is parsed, because the parsers update live
tunnel fields first. ipgre_netlink_parms() sets t->collect_md before
ip_tunnel_changelink() runs.

Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
adds it on RTM_NEWLINK.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: b57708add314 ("gre: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/rtnetlink.h | 2 ++
 net/core/rtnetlink.c    | 8 ++++++++
 net/ipv4/ip_gre.c       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index ec65a8cebb99..2bff41aacc98 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -256,6 +256,8 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 511c25bf6f2a..3be5f264f5ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2421,6 +2421,14 @@ struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
 }
 EXPORT_SYMBOL_GPL(rtnl_get_net_ns_capable);
 
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net)
+{
+	return net_eq(link_net, dev_net(dev)) ||
+	       ns_capable(link_net->user_ns, CAP_NET_ADMIN);
+}
+EXPORT_SYMBOL_GPL(rtnl_dev_link_net_capable);
+
 static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 				      bool strict_check, struct nlattr **tb,
 				      struct netlink_ext_ack *extack)
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..0ebed1438f6c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1457,6 +1457,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1486,6 +1489,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
-- 
2.34.1

