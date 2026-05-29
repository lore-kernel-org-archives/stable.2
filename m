Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DE330D23
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098800; cv=none; b=SeAFHXjk40v68g4zEnyZrboha2CkmvUEZtrUXjjyo50aoVn6nDZf8tir473+zOsEYWuGEWsTGewu84LiFoTgjo5Hza7bIAsa9H+X+QPFF2aTeA7enoIYWi9Ea5Ryss49qja4C0zl405XxTGHwN4Pimg51qeqbCluR3zB48EjMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098800; c=relaxed/simple;
	bh=RLdKLF03ChFz+xtF5ixUP09+GLDXkuEcuHuQg/iJSyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzWZSPjURNlEvxUfAQspskCaFDE83wFx6M3WdtMrtHhfU7pXw4/t5HYP2G0YZ4+4GmcXAmwRubh1EQh43ff4J8skldxbkYybQvpPjGBT23KijNhH6XTogCkJKQasNk6jlpBZxIx3ZMMDmqB9y1op/vCwYuXNR69XxBffpph6n5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEWBBs/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEWBBs/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78A41F00898;
	Fri, 29 May 2026 23:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098799;
	bh=jsOxGa7xQ0cTYImQ7FZul0c71zTOBckOXV41izLI9cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EEWBBs/zCRFWhf5f3s9WX2IQbm+Qf3+ljEv+Z1FNy0kl4Y+1T76cTbz7VlzazH5KR
	 CXdv7pgesxbMMROtc3f50rBMydcNQrT0cVys1h1ly8JD2R15bTegx1WAR4UkX5ddsP
	 w6k2xzXrrA/C6DpHo4ywzSifLAppgx7XzsfKkw7+wtRm4JyPdgCeGPa1q4RDa1GLyA
	 l2tfQEl1I45+OYoJGaJS+7q3VIQNFLH6RMraO2l1L/xK4tZeUQ8xO+N4AbEpiAYKvR
	 8Cv8JnETlhOuVroanUqG1kCVt0h+QFZVBpxf6fSLtyWyKR1+Px8rKtI0oDxDqFmyz5
	 3vZlEW6qQnRow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Iurman <justin.iurman@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
Date: Fri, 29 May 2026 19:53:16 -0400
Message-ID: <20260529235316.1963855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529235316.1963855-1-sashal@kernel.org>
References: <2026052812-uncoated-spry-43e1@gregkh>
 <20260529235316.1963855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Iurman <justin.iurman@gmail.com>

[ Upstream commit d4ea0dfd75011b78cebf3808f98ac4c4f51a6fb9 ]

Reported by Sashiko:

The function ipv6_hop_ioam() accesses
__in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
via RCU, __in6_dev_get() can return NULL during interface teardown, which
could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
option.

Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260517183059.29140-1-justin.iurman@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 404555311bc74..f6f6830cc466e 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -919,16 +919,27 @@ static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
+	enum skb_drop_reason drop_reason;
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
+	drop_reason = SKB_DROP_REASON_IP_INHDR;
+
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		drop_reason = SKB_DROP_REASON_IPV6DISABLED;
+		goto drop;
+	}
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
@@ -978,7 +989,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 	return true;
 
 drop:
-	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+	kfree_skb_reason(skb, drop_reason);
 	return false;
 }
 
-- 
2.53.0

