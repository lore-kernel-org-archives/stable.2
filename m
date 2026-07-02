Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA02E175F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005989; cv=none; b=H8kolqH7PSJvjMgLbV542mM7DT8/jB90gc9ksK7QHfbJGwtKQbm3L2TIxmeCiVNUdFjPoPX9XHeNyg2eouYLTd5H8hgOjysnFNzonDDrbnzc/2ifqFafuo97rUaI0+fVcQJH/QF89YRw+fQKchCTgUJRfllh+VZ37/LFqvhWAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005989; c=relaxed/simple;
	bh=1W4RPctZSYFj7CZbwOfp/6mIZicjg8yPCMzMpujCM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4ejXsGrs0Bt38J+MCP+Ly9rEoKD2i+5zn9AYUDESiaHtZX0jmynU4jte0GhwiMXIDBfdiFRY8TjnPrvIYAlfN4+soUn/mzVxLRcKmjxQSs4GJBKL1mdB+3wF+rQHeCB8aDzo97xs5ZKKkKD4k5GjCy3gQi0Bf5aYPVYFdJExRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt/fkU+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt/fkU+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8831F00A3A;
	Thu,  2 Jul 2026 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005988;
	bh=+DGxvot27Azavwqu6krI+R1VnPC1dOVKYFjTb+fYeDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lt/fkU+fpPcdwQxZlf2LrmP2ZspqryfLVqp4KRXOA+ORyW9o+c8VTgmfHkh1BzXE1
	 c1IJxMF0Ej2CEudHUVwzRmLh8zCl5L5T2bOM6DYjwI8ckOh/8NAbjGg0KJUZk2mwXC
	 gwqvaQSau80bwnagcnRJt/hhyyic7gC+KxzXPfnQZRieF0swE18HPIM8sCzZVFgDPO
	 H1S2cuDUC1nCnvBC3ADXicRKNGtGwPRshLsJZQf9UlVHmr57kgHK7eofHuH+H7wreJ
	 z0zKNgz/5c8h851qaO73tyZyAyJKQQQtw+w+q+Bsx1Vd2N46KzR7I3SFHE9FxFfVNB
	 ncfJryabIvviA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu,  2 Jul 2026 11:26:25 -0400
Message-ID: <20260702152625.3530290-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070222-bullhorn-skilled-e133@gregkh>
References: <2026070222-bullhorn-skilled-e133@gregkh>
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
index fdc7b4ce0ef7ba..649d4f88a3da5d 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -209,6 +209,8 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm);
 int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bf68492e274664..ac9dd385d80f9e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2065,6 +2065,14 @@ struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
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
index 2f9f5c583dba13..a812d7e5adcc6e 100644
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

