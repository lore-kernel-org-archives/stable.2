Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8D2DA75B
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002852; cv=none; b=Uy7XiD649CiP7gO6m+4bvQQZaxKXjYD1zCGKB5o+DFAeDxF+RWDGn6wzgQ8ytne75YzxQ/XNIN7bJ/e7nYeWLUorVmzU8s/s85QEvuIJc4O99MDMwnSr7xWW6rsIzG6vk3OlktuHjPq7dU8EyUDDYguXrt5b+jb8hm5d2anJQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002852; c=relaxed/simple;
	bh=fHPiWCU3Nga91srhexwrjDbFQbrVqk7QMHHmP3ZqJU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruHVAOnoK8O1xRo6OOFjr2EoZM++UT7v490cvrtklJpZMkkpAr344O8wZzQtHcDnemUaoAkB+SqiBjdhUP0HME1nMLv2ZbKuU9J2rsZkRW+f0dtKmSqo7+50Y24eMu0tLQMvAmRcfltvdCInlt5IMdozQYZ/jw3f/3OPmZxcVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctpheO3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctpheO3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4359B1F00A3D;
	Thu,  2 Jul 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783002851;
	bh=Cx/JqrdyRnAVEk3Z9F4eHYZeRVIFuzXnRs5vPQkmchc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctpheO3ROU2uawnI+LV09w/qDnhPzOdZZz6RkNnSF5tB6v7rI92WSrX6BKP7cgHM9
	 9Bj9cqgzbPpAFOuohfGYoVJaT/BFfVYIPreuEgQ9nqNeiZFAEPN9Ej8Da/vYLej4ju
	 y9g8JqQIPwkO3XKMke9kRb6uG8TsDCsuU616+5TDVbG1ZKWy4PV45R70EikNHve8gS
	 YZMrxbjiEhf4g7ZElnTLHCRaL2WV3Elw9YWiKoH2qoXoAIW0XkzKhtF0SBsO0qBeB0
	 Ynw0NKLemyuYm9UJz/j5uvSmnufRletEDw82Kyxun1WR6aqpLAaOFaNJwIayLfTa3U
	 oBBb4tNqMFmWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu,  2 Jul 2026 10:34:08 -0400
Message-ID: <20260702143408.3487262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070221-liberty-skimpily-9ea5@gregkh>
References: <2026070221-liberty-skimpily-9ea5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 8165f7ff57d9667d2bb477ef6af83ede7fed4ad7 ]

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
Link: https://patch.msgid.link/20260612085941.3158249-2-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/rtnetlink.h | 2 ++
 net/core/rtnetlink.c    | 8 ++++++++
 net/ipv4/ip_gre.c       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index c1fa6fee0acfa7..17a91f7b69ea51 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -211,6 +211,8 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 350705730f76a1..09a3ca7e64c54b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2157,6 +2157,14 @@ struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
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
index 75d388dd5ac62e..e58965ce8263d2 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1412,6 +1412,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm p;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1441,6 +1444,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm p;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
-- 
2.53.0

