Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4838AC6A
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980921; cv=none; b=GaYDuuTNt71OeAs3ZoS+D07T+8QYRY9nt9I9fh29Aj/jJhuPfDT44bJ7c5CxEpwcC4nPZF7tOjDVuZbgpvUAwFqtY0bJ8Zz+/d8yUGEUfQP76IVaR0bWN/m5eerux3s19AGRbCMb3MnxQV3oX1pCgzNgOegvq/xYnCFZiAWDdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980921; c=relaxed/simple;
	bh=L1JNBUaVUBAoBPJ1uZvgUyZugu7idjfCVt8/Wba8sbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FHy5N6kT9qsQ2cFh/WCBvQL5pefLASPZIydBYYEXRyaIUF6Ud4qB/dGlb8XZNnlnMOAwGGlYxTYlqvrIV6G9x2XeNKyLvRHkORFfHbw7U93qfDl6iaDk68vTEAwfPU4fog3Jme3obGOIsjB6giidS35EFTQQwFKvGHReQAs8biI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7LJYfPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7LJYfPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284171F000E9;
	Thu,  2 Jul 2026 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782980919;
	bh=YiEPUufA7zrJEfg1PaMTKZz2yT4elYnWZbgPIEIJ7SE=;
	h=Subject:To:Cc:From:Date;
	b=j7LJYfPjYXT7WIDI+tTC0IwGq/o3ZJEVQ4F4dvT4wPXF5vDWBhw/y9Jw1Mv4MIahn
	 7zqFzdswDnwpBT5v2UxDMNvWcBEEX6Nbj+nJgK0sFiaRgLGWn7gmpurRV/L9UGVCPq
	 jd9umaOdwjqftcwghWHs2osvspM3XG5zK2JBixHQ=
Subject: FAILED: patch "[PATCH] net: ip_gre: require CAP_NET_ADMIN in the device netns for" failed to apply to 5.10-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,kuniyu@google.com,shaw.leon@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:28:22 +0200
Message-ID: <2026070222-gently-rally-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8165f7ff57d9667d2bb477ef6af83ede7fed4ad7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070222-gently-rally-f7d9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8165f7ff57d9667d2bb477ef6af83ede7fed4ad7 Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 12 Jun 2026 16:59:35 +0800
Subject: [PATCH] net: ip_gre: require CAP_NET_ADMIN in the device netns for
 changelink

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
index 61d095ce1b3b..12aa3aa1688b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2438,6 +2438,14 @@ struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
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
index 208dd48012d9..3efdfb4ffa21 100644
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

