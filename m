Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC42494D8
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817275; cv=none; b=m61yfgnvS6/fKOxOz1fv1ZAKEGrP7Ye3DrSEpaoNmfowlN6z/P85WwVWgqNI6xvjGt7vLkCJQABixqn+QAFCnLNrMdcBC2ZNeNxo91EVxAaNz22pcfXfU/HOPPo/AvoQCbg6CNZwQjZ1f6BYw4F9YDQDDX01IbU12Jef93hTr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817275; c=relaxed/simple;
	bh=ah02gPMpj+EIZYGfxgjH0v/2l8YJEnbFSEjLmAUYWZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok4334s7hnFdiDfrEnuXdmeyOifqPCsrcaIskF4Avdx2H1UmdsLtSSDO7nKJhn7YXn3w9HcLOEjcLKJCqMyO4sEDrK/HTRWYYrGMtlrbLZnNwrLqxSJIrtSmKfyEfs7jgMsCM5AQxKA0MPW4ERAipDXdk+UcOeSVA/5s0Zw1+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOo6xi5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOo6xi5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8A31F00A3A;
	Thu, 23 Jul 2026 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817273;
	bh=YDhHTlWZlmsypHWW+5TRTo5P2BltCIo0x35fzKtO9Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOo6xi5cmHL//Pdw/jTMrv3O9lj8WyA4v+JjlSq+7kITcWRRRaWOkAIExyCx6aucD
	 3N5Pf2B00nqjZ28PHUqN8NYoN6qmayQm+p9i7MKT0j3+b3a10qLNdQ+SEJNyzU6SzM
	 5yrdF+Ns6XsT7CdwxUQjwBw6ysSFrrIi8yLmhc1YpJMQwRIeVjr5Wr2ssG0oKwFwS0
	 9Y8T+bojNJe10sDfu6MN4BqnTUHjHry/SOeP6ZIjET4X3kPPMFvayK17R8F+ifIoTZ
	 2JMmHQnCWZyeIMUKwpJhIEDtqlKWG2rJH0hNm8KV3ToV7SKkYLaxlKiE1vJq+hZK+p
	 MZRBi9rhp5bsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
Date: Thu, 23 Jul 2026 10:34:30 -0400
Message-ID: <20260723143430.3226511-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723143430.3226511-1-sashal@kernel.org>
References: <2026072002-habitat-confirm-9500@gregkh>
 <20260723143430.3226511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e5e24a365a5e024efef63cc49abb345fbd4852c5 ]

tc ingress and openvswitch do not guarantee routing information to be
available. These subsystems use the conntrack helper infrastructure, and
the SIP helper relies on the skb_dst() to be present if
sip_external_media is set to 1 (which is disabled by default as a module
parameter).

This effectively disables the sip_external_media toggle for these
subsystems without resulting in a crash.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Cc: stable@vger.kernel.org
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 911e35e3b71be0..bd91b8b47f4b75 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -947,7 +947,6 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 			return NF_ACCEPT;
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
-		struct net_device *dev = skb_dst(skb)->dev;
 		struct dst_entry *dst = NULL;
 		struct flowi fl;
 
@@ -969,7 +968,11 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		 * through the same interface as the signalling peer.
 		 */
 		if (dst) {
-			bool external_media = (dst->dev == dev);
+			const struct dst_entry *this_dst = skb_dst(skb);
+			bool external_media = false;
+
+			if (this_dst && dst->dev == this_dst->dev)
+				external_media = true;
 
 			dst_release(dst);
 			if (external_media)
-- 
2.53.0

