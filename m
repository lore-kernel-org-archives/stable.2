Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDD25CC57
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284772; cv=none; b=hTlcRnS/E4R/qj4vPzMWpi8dFAqwihE051tCXgwEkinpVYVBSgXmezn1YQu3oq+sH9kWrMNQ7RfuJirb1VioumLTEEDZyq0QT1EqHFIe5XiHxQeD+zVwkfPrqBfDoy3fDesoVOdQmz1IcsDiPUO7K3mWagRbiY63J0iB0/ogyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284772; c=relaxed/simple;
	bh=+URIo7SY8jj0awB/+nehKTXenK8Ep2W1PuFZZckzNL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4mY88DLRagW+Jb+aZ51KpgZ5QoNPcgN9Yi4U0CcWw4gfLyiSl+72YtWiDrzzykbS839SeSIEX8pMLWHBhdXIm0DJwEueaQ7d8pHeWU+rqB1fCc+KqCUej+4vQkROePUMdOQEQcD17E+qe83aSWgWeZlgclgYZIWeED8/KVeLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT8Pw3n3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT8Pw3n3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047421F000E9;
	Fri, 21 Aug 2026 03:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284770;
	bh=/C/53UmG6ykE579riarMg3eMXTn05RkTlHbmRQVx0EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MT8Pw3n39BiQwjSlygxxssxTdv2I/LsE6caVLXoqqkOL9z6zQIqXAJuZ9okEwbfoG
	 mEBlgLYyE6dOJchlPkwmXpg3ihplE/a1lnm1ufeMUf/gaE+fZk4PhB4qEvFPkWVaB7
	 LbkgnQsInotYAxoiXhmVwyPVT55zego2AYfPk+MyUNtqUb0CEoZn6AnO27GLXcU+k8
	 cQKtyZkVJdyEeBL75WCw6Bkikerb4FJrupyjnT033/71hP7r3iAU43iCc/tYtY4jIb
	 31tBYd3uD0cJzx9ZYKFKMCRWBj+L2fbERaUzFmV9SPgiySsKn3tz4qhxPc/yrgjRkb
	 kshaFL7KeMhrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: ipv4: Publish fib_nlmsg_size()
Date: Thu, 20 Aug 2026 23:59:27 -0400
Message-ID: <20260821035928.2525228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081713-siesta-mute-edca@gregkh>
References: <2026081713-siesta-mute-edca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amit Cohen <amcohen@nvidia.com>

[ Upstream commit 1e7bdec6bbc7816cdc6a093374f4bf4e732c3d44 ]

Publish fib_nlmsg_size() to allow it to be used later on from
fib_alias_hw_flags_set().

Remove the inline keyword since it shouldn't be used inside C files.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 4ff9548d8494 ("ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_lookup.h    | 1 +
 net/ipv4/fib_semantics.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_lookup.h b/net/ipv4/fib_lookup.h
index f8fe0da3d9af6..becc52d9f3ac4 100644
--- a/net/ipv4/fib_lookup.h
+++ b/net/ipv4/fib_lookup.h
@@ -44,6 +44,7 @@ int fib_dump_info(struct sk_buff *skb, u32 pid, u32 seq, int event,
 		  struct fib_rt_info *fri, unsigned int flags);
 void rtmsg_fib(int event, __be32 key, struct fib_alias *fa, int dst_len,
 	       u32 tb_id, const struct nl_info *info, unsigned int nlm_flags);
+size_t fib_nlmsg_size(struct fib_info *fi);
 
 static inline void fib_result_assign(struct fib_result *res,
 				     struct fib_info *fi)
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e0370462293c1..e82cae18e4aa5 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -460,7 +460,7 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	return -1;
 }
 
-static inline size_t fib_nlmsg_size(struct fib_info *fi)
+size_t fib_nlmsg_size(struct fib_info *fi)
 {
 	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
 			 + nla_total_size(4) /* RTA_TABLE */
-- 
2.53.0

