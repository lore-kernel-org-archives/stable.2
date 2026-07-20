Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D6383326
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562998; cv=none; b=h/CTI3nbsOGTNHfB8gh+lNO2a9YQbNf59yhErxcBCIHArM74kbYIc9+MljAd6q4bBP0l6Y6ScQ/eU5kCFa2yeGZs/FyaN+17sfxLYj7F9ca9DQDZ0xJHK+zWJV/yNhba/8SHvviTOYg9i+DMIauCNuJ68qiKXv3wC8JCLodS3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562998; c=relaxed/simple;
	bh=Pf+BeLEhQVTW7nJQ0fDcweYPrwAar7DRR971YdXHApg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V2R8JUqD8LLvS31xfN/syglTBtA21SAh8BASuw3GYoSTdUV85c5lfz3fqFQXomE/2NWGIP+UukEz9PVzwCMsMBBAWTcYT+vLUhTAYAvvDNWUN8Cqmetc1bWBRP6s0bY4GKo2g+Fz5VMTj92o+Kd30Vb2Zr36am6qSk4jiGlD4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AiV0wdhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AiV0wdhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D5D1F00A3A;
	Mon, 20 Jul 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562996;
	bh=UbNlgmozSmjoUtDIbrN8qbDtRWNXQM7VnV8xRqOmkqk=;
	h=Subject:To:Cc:From:Date;
	b=AiV0wdhe5BfwJLoxge/qaJFqnCDFaTAOnRDWUAcniD8eQWJRgQ1+H2+tq/tWhRAuw
	 VHmmStf1lhrSCCdUdYcUU6m6WyUyeAY8Nmwk+crZ7bvWl/n3L60TFPwY2YWd858D2e
	 xAC5LWzTZFxB4GC9/FWWk0IyR4kLNdi4P3alfqso=
Subject: FAILED: patch "[PATCH] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns" failed to apply to 6.1-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,kuniyu@google.com,shaw.leon@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:53:24 +0200
Message-ID: <2026072024-tactical-enquirer-b40c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2496fa0b7d180b3ad356b514e7ff93bb14e6140a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-tactical-enquirer-b40c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

