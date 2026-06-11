Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168D3612DB
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159304; cv=none; b=jnI04N3wa1ri2l2iZkyCtoXKcBMtStpFspRMXsqxedn4u09f7/MW7LUuECW2LiRV/oRpbqBgALhHPpr0+3SOU3zI8facmhXbLx4QLIA6WPkoYPrgINfGQ7foeVpHoihC6yGiD/B9inM2kehvNyZsNrq5vxZYWS6G5eSvW2R7Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159304; c=relaxed/simple;
	bh=DBekgeW1N4O5e2NqIDoDH7qbEtlWuFn6iO98H2FVTMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hg5Zel8zOzQX9FEgQq3y1SeOvgmzqLCIuVRdkc82pViMcAmjnY4wxGQqcktrvaiYVSZ2wQQ99HCigMarxn+IzszlqRW5uiEsfB3DRcSZO1n1g14ybl3TAO3q4p4kLDCgICmMPTjFC3KD5ly32rtT+ildmvwK0zIny947oBtij84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5L614WZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5L614WZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4856749a91.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159303; x=1781764103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItoDyefAeBltx9ce0NxyAQHJ3AQNyVruVGbMuv3S9to=;
        b=q5L614WZn2tYrW2Wwr9EYznMOsDlEH5/95EVs/qzvyqA+qHVT9e93mfbHjHDcq2bdy
         kkEXuI8cGeyutf9vN62FTQ6c7CUK+2GzPqfWcaz5v1bgKJmWNn22eiYh2sQ5YPdh/7/e
         kkhjMDkzARkuu8zNRFdn8tXTC3ZS62quqyyyxj+B38nY2rofj1wv2bv2B33rk+fY5qeh
         sc/P+tMPn6oQItWy+Q2hDfh+AZB7k4twWsKH759le1MSACZD/ijN2oVSyA6NgR+lGctg
         mqfvMXW+acTGbTtzErp1TZBgFhi0lppJkcUt5QG0x5MOLoStM775lHAfEBJ6YX4cSKDF
         qQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159303; x=1781764103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItoDyefAeBltx9ce0NxyAQHJ3AQNyVruVGbMuv3S9to=;
        b=jNPwsgQuduzf9qRHOIZ27XLs4O+T8Hltw3QBv4f/Cdys/T8Fm0Ra0dxS633U+DW6f6
         uThXMO5LDjddxCiS37+lG2rhgB85Z/qVI066eMIGkrviSm8vKwdKXo/+X5PSXXeeVM4m
         3W5moHSsCI/aQwX0F145Wm3I2e3r8p4hi5A+yuT0K556BbgUQSzkmUhHi5PCQgi98Pdw
         fKoJpj2ElhpejDnKJGdrH6kZTw5kjib9XrUFIoTPubf6fPJdZGsU+pmiDlLB+g6R1Ktf
         XhnNZzkAsaNhspCTnjkP49u9xHcHugguTxg2NZfmf7Hf1Ay5gtweLrkBd0dnDj+UOiOA
         ZrAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/S5hNpUYpkfkWA0CgoMDq22fT+55jzpeTbCdx3E0TqEpfbhLG3XHKOe9Cu+h4e2XU3U0s82AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZs2bLY+E02tcazxTeDkW4l6yKVtOlJ5fR+okNCPzJh0YQ4GO
	ZxI7xBLDUxksHXzzzQhbiQgMZ4M7TCk8nIATr6eNBSxgPC/0/Kedz7G+
X-Gm-Gg: Acq92OHHdN7VdkefrwJTfeWjsNQh484iDe56rMW6QpQaWnSkpq1eaUoj1qQnzXXcx3e
	XHKa4uPtSDSSjEoTW3RAJ45Pn7DOW+1Qa5/qwd8NcQaulTiFOdZuxNsin/h4CilB+6NoDfRbjr2
	D98FvRjOBU5IcSOw7ryg0mJQ4T7cuVwBL3+wKd1XsZVXktSRbo5fyWgHWbUuwYdWATdU8nL1H5i
	ATcs9inPfJHKvmsyn09OcjcgrBmd2FgsGgEdfccKlRQ4Jn8unyMTORS1OjZwV4/YvcTJ8FsXOQ9
	SAeDE9358WVG+mblNf75lSImnVSwoSoN0tmR7s6i3mX7wz/KNyxINL78VyfAt9stfwVhcDwMJGh
	Dh0Rnmd106imnPqW89MwCI1jRkjblrSuQhglm/2dHNjmGcGbQaHrnfbngC9Vq5Cnt8Awcyt7o2/
	LOCdNinJmQORIxvuVnNiV4LImx+ANt5xK7fN7nCYOpDeYahEsvucNT2/7gFzM=
X-Received: by 2002:a17:903:1a26:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2c2f092f624mr15788455ad.11.1781159302916;
        Wed, 10 Jun 2026 23:28:22 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/7] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:08 +0800
Message-Id: <20260611062814.2528793-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
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
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
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

