Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE436493A
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141172; cv=none; b=KJ+Sy4oDWVZEeU7a3pHIzmDP64SB4+GHJgggzSaV6AoEsra9k+MifPJeP6RLcOw2cNIaYsmFnpXilhlJe+ALA+8QzaJWTP8fQfEXnY0yLaK2HRaTWiLO5HshnpWggK4EqTO3rKyTWiPoQJskjJVN54x14DvONn0Hn9Q/F14ZMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141172; c=relaxed/simple;
	bh=tPuhf1ieZXBtINf2UqZNGq8DceBkVPrP1NzUJ5JlIjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8AklKdxJX8DdgBAWruwQYM1WT/yegDT28WoQbVl44iVBLvLYbhqBbZhKbQ1zT9WsumBknE0XCLdjsULbYXfVnSwuh+4gujrYWD4WKkL4GQFEDukDe/WJAr0P4wxYbNRqReHOxZEe7PqpxeCB2g61S+8D4I4moSbac7kSs6x1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRe4YFBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRe4YFBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5201F00898;
	Sat, 30 May 2026 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141171;
	bh=vf2x+gIk38Znbubxnk8gIlGklTjSBJieFYBgXT+rdYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRe4YFBGApGdL/yXqjZypEel27x804UPyfXYeQylrnWKTfPGocQjQDllDWW1pjhBq
	 fDKjQOuZOsnvGFYckzTxRSEZr+HeZsx8D+KSdOJhe0bN9PBnKBseGazSsPmVECJyQW
	 sAv/HsRF25EvjrEzzTTAfcE0YrxjFvel4yV0vZ8STZOmllNHr1m0TRzBaL4Up2BkXm
	 5lHveerlPj085NbxQ77qKjRlkCDakqvZYCqe/AROJz4uDdp70OM2GAwQDfEjNKnPlC
	 8Ltb86yRgSAcAEA4wL5zEVj8MoDBnU6b09/2TrEkelUn+eCo5DRSJmasbhyZq+I6uT
	 v6l1atv3aJDhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Iurman <justin.iurman@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
Date: Sat, 30 May 2026 07:39:27 -0400
Message-ID: <20260530113927.1939561-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530113927.1939561-1-sashal@kernel.org>
References: <2026052814-waggle-aerospace-72c0@gregkh>
 <20260530113927.1939561-1-sashal@kernel.org>
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
 net/ipv6/exthdrs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 8ba89fc5ac0ae..8aeb9906258ce 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -941,14 +941,20 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		goto drop;
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
-- 
2.53.0

