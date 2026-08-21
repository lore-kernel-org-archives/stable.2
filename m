Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504C352C5B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284773; cv=none; b=guhpf4sxw2cTgmWxQfWLD9ASC9h2nu7yg8HQPbCLgLisnn6QmBpJIE5SdWZc98AZ9wausU+zOtMxNb1AFwQ7FA+ZlMqR4cbxYbMFrEPJlhvZ23xboeA4pMeGA6hUmXbf4BWWbnJXbjCKtOBiG8gIZGUm7JZNCL2hqykTMG2aG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284773; c=relaxed/simple;
	bh=Ka0TYIye5shh24OJrXcWCHxL0XQKDuQRmoxg8LUhFXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWw0SIUogw/Au1gqerDEPwR0qS23U6Rw6HcqtqwJrBVRJklUT/Ns8HMivn0eh2RTa+ISL8QhC6PMMivot0jg7EkY3+NgDnEBAmhP6mMwjVz8u/ZWhvGcDb3kTl5EbstdFEKC6RoBD7cNkKpqwEVa8bv9PEO1rhat2/sWLuyf1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksV9gGhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksV9gGhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA6D1F00A3E;
	Fri, 21 Aug 2026 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284771;
	bh=GNZbzXquoJKZefrmFeG2DPH4xOqWozRyPC1a9b/Vs1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksV9gGhccFj+f4GGLMLIdvxBUbUn4xArkYRagI+MirTwuKvp83S0ALSJMbQQTcb77
	 CCOSmud2oEPEK/YMC7nnpWOgsY4Y3y3KS7xKjVwOhzwxrtdOTYcxBUvTJreNz+rF86
	 H9xTNCUpDBaxFOkHJCxWyRsw2MCFw8u7jk49iDMvF3n+mIv2I+EiWQGn2tpzCqM/AN
	 qOlpB0Pp9439DkXTFM1SdQO+EfJx+vU8NIhNo/gM/hZ/BRka4LszfG4R0i0/ptZ9cw
	 VnUtNL3fuZcr/0jVAMajLiCYNK4qJ0BaeHK7/fHCgF/f8Q+bmPHuF4QcCWiB/Hv4NZ
	 HdAOr3ec9SVyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Date: Thu, 20 Aug 2026 23:59:28 -0400
Message-ID: <20260821035928.2525228-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821035928.2525228-1-sashal@kernel.org>
References: <2026081713-siesta-mute-edca@gregkh>
 <20260821035928.2525228-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 4ff9548d84945d2cbf9e4c207288063a200ea397 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_semantics.c | 67 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e82cae18e4aa5..bf722eb5efac3 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -460,6 +460,34 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
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
@@ -477,32 +505,35 @@ size_t fib_nlmsg_size(struct fib_info *fi)
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
+
+			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
 
-			if (nhc->nhc_lwtstate) {
-				/* RTA_ENCAP_TYPE */
-				nh_encapsize += lwtunnel_get_encap_size(
-						nhc->nhc_lwtstate);
-				/* RTA_ENCAP */
-				nh_encapsize +=  nla_total_size(2);
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
-- 
2.53.0

