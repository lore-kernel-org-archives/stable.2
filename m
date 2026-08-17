Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5323E6381
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969279; cv=none; b=OJS1zAQd8EEGS69hHQdTIIsawvtPKwjCtJwHHO9iUzLvUjOXWEacCMW32HVUNSBk3KDhZfedU9qdu1SgIBVrUpAk1vUJS+tS1yBxuo/bOafLCChQHdavTMB7+tIUPqFaDjozaz0IrPl4HYYxkF2Z4R9IE7Sl0cpaAGXbeJcJM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969279; c=relaxed/simple;
	bh=+Yl5j4tOZqDzS56N4CJO6ebogOc6w3fhWvFmjkkoCS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qG+0STVdrNqTt/Om0ymehAp0uZHBmQdBMGbc9DwpmpnZwFUjaaHStrPgWXxq2Gk/chC70EuPYBRyEOeT73k/jDdJBspzeDnBf3LWjWMy7Lw23PLAWCTG9fXL5So8he7W+PjC4ilKJCibd151mFrLY01Y+mW2yeQWeijH5Cycx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWuWckve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWuWckve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52621F000E9;
	Mon, 17 Aug 2026 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969277;
	bh=KjqjR3M121XDLw+LDTURiJNAT+DMkHCW6dN5eYnhZzM=;
	h=Subject:To:Cc:From:Date;
	b=WWuWckve3CjMvF57lIe6u+D8uePRxG7i3EkY56yVEbYtgBnQC5FqtBg3JGcfoPWA2
	 irsTvBeuEU0MMmKB4bW+Rke16JAzFtiQnqPYXP344qaWTzr/0xp5gOw5hNUXTj8FG1
	 XANMpGdIY2q/Ye/OIzRPJQszknoms0roj80zrMM8=
Subject: FAILED: patch "[PATCH] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,idosch@nvidia.com,kuba@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:21:13 +0200
Message-ID: <2026081713-siesta-mute-edca@gregkh>
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
git cherry-pick -x 4ff9548d84945d2cbf9e4c207288063a200ea397
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081713-siesta-mute-edca@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ff9548d84945d2cbf9e4c207288063a200ea397 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Thu, 30 Jul 2026 12:59:26 +0000
Subject: [PATCH] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

fib_nlmsg_size() still estimates nexthop space as if every gateway is
encoded as an IPv4 RTA_GATEWAY attribute. IPv4 routes can also carry an
IPv6 gateway, which fib_nexthop_info() dumps as RTA_VIA.

As a result, route notifications can allocate an skb that is too small.
fib_dump_info() then fails with -EMSGSIZE and rtmsg_fib() hits the
WARN_ON() that marks such failures as a fib_nlmsg_size() bug. With
panic_on_warn set, this becomes a kernel panic.

Mirror the actual nexthop dump layout in fib_nlmsg_size(): account for
IPv6 nexthop gateways dumped as RTA_VIA, for the no-header rtnexthop
layout used inside RTA_MULTIPATH, and for RTA_FLOW only when it is
actually present.

Fixes: d15662682db2 ("ipv4: Allow ipv6 gateway with ipv4 routes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/6f53fa797fcaeb26966432ed7ae9bb87c4961f37.1785411220.git.zihanx@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..78f84ae3ee12 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -490,6 +490,34 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	return -1;
 }
 
+static size_t fib_nexthop_nlmsg_size(const struct fib_nh_common *nhc,
+				     bool skip_oif)
+{
+	size_t nhsize = 0;
+
+	switch (nhc->nhc_gw_family) {
+	case AF_INET:
+		nhsize += nla_total_size(4); /* RTA_GATEWAY */
+		break;
+	case AF_INET6:
+		nhsize += nla_total_size(sizeof(struct rtvia) +
+					 sizeof(struct in6_addr));
+		break;
+	}
+
+	if (!skip_oif && nhc->nhc_dev)
+		nhsize += nla_total_size(4); /* RTA_OIF */
+
+	if (nhc->nhc_lwtstate) {
+		/* RTA_ENCAP */
+		nhsize += lwtunnel_get_encap_size(nhc->nhc_lwtstate);
+		/* RTA_ENCAP_TYPE */
+		nhsize += nla_total_size(2);
+	}
+
+	return nhsize;
+}
+
 size_t fib_nlmsg_size(struct fib_info *fi)
 {
 	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -507,32 +535,35 @@ size_t fib_nlmsg_size(struct fib_info *fi)
 		payload += nla_total_size(4); /* RTA_NH_ID */
 
 	if (nhs) {
-		size_t nh_encapsize = 0;
-		/* Also handles the special case nhs == 1 */
-
-		/* each nexthop is packed in an attribute */
-		size_t nhsize = nla_total_size(sizeof(struct rtnexthop));
+		size_t mpsize = 0;
 		unsigned int i;
 
-		/* may contain flow and gateway attribute */
-		nhsize += 2 * nla_total_size(4);
-
-		/* grab encap info */
 		for (i = 0; i < fib_info_num_path(fi); i++) {
 			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
+			size_t nhsize;
 
-			if (nhc->nhc_lwtstate) {
-				/* RTA_ENCAP_TYPE */
-				nh_encapsize += lwtunnel_get_encap_size(
-						nhc->nhc_lwtstate);
-				/* RTA_ENCAP */
-				nh_encapsize +=  nla_total_size(2);
+			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
+
+			if (nhs != 1)
+				nhsize += NLA_ALIGN(sizeof(struct rtnexthop));
+
+#ifdef CONFIG_IP_ROUTE_CLASSID
+			if (nhc->nhc_family == AF_INET) {
+				struct fib_nh *nh;
+
+				nh = container_of(nhc, struct fib_nh, nh_common);
+				if (nh->nh_tclassid)
+					nhsize += nla_total_size(4);
 			}
+#endif
+			if (nhs == 1)
+				payload += nhsize;
+			else
+				mpsize += nhsize;
 		}
 
-		/* all nexthops are packed in a nested attribute */
-		payload += nla_total_size((nhs * nhsize) + nh_encapsize);
-
+		if (nhs != 1)
+			payload += nla_total_size(mpsize);
 	}
 
 	return payload;

