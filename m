Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFC425868
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562993; cv=none; b=s47Q14bPO1jkf1Kle8BRkKuIkPmKwseW1K4Q+s3RNRcN8oJLIEYho0oukL2bN03FwHasm9qdayZA5bbtJvLGczEb/r0iP3NSr1Kb9TXOG4JUkGqP8g/aBRMVWSMHON485UAuLYFK1RNQSvtXlmC0Nz9KIfsxq/iupQkvu2WKr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562993; c=relaxed/simple;
	bh=GldhLgbZFvXdBusdEM+2WUH3mP/RVu28c1TZ0TYvk8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pz82gd3kNveDok9OTodtE05bIKi1kncBVb7O7Egq8v+qmWWIUYbjc8r001nIdQudrBU6zM5GKdLRc8BrOa+yea0aVVJhd0riusfmryoeJbqWyXEHYWvbbiSJGLaCvZcZCyYO5Rj7HIc71N4pQpBRscW+Fyd252XyQrpIZcT1o38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkapyIOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkapyIOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEACC1F000E9;
	Mon, 20 Jul 2026 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562991;
	bh=O9eWnnJJjqiA5yrp1J+y9sZFc4BQKe4q4b5y3pMrcF4=;
	h=Subject:To:Cc:From:Date;
	b=VkapyIOewR8Lau0USk9nyBDxpTZl+Q9y/VJ9BmVd8Oi3d5OLE4/LViIO4vLUhAHa0
	 aZhDb5DCLYiGD/Sw4mspTwhFgWBJfcRC40gBUxi3joTzJJ7FlCffk1twVjnUlzSRJZ
	 vQQo7X77A4P8XX1z8UbAvrfNsclVtPpZBZLXLmq8=
Subject: FAILED: patch "[PATCH] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns" failed to apply to 5.15-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,kuniyu@google.com,shaw.leon@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:53:24 +0200
Message-ID: <2026072024-poking-emit-1a0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2496fa0b7d180b3ad356b514e7ff93bb14e6140a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-poking-emit-1a0f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2496fa0b7d180b3ad356b514e7ff93bb14e6140a Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 12 Jun 2026 16:59:38 +0800
Subject: [PATCH] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns
 for changelink

ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-5-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 73fc5a0b8203..d7c90a8533ec 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2103,6 +2103,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so

