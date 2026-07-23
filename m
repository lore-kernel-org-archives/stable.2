Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9E3D3486
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825869; cv=none; b=hTkZQ2CmxN+xaM48xrcPA3XMjz0lcCNmz919eA/+p0Zq2rcjKYoXJYR/n6Bjg5pVMwi9QqBqmlGzPNK9QnarAPPHVmO7qqlrUBw2g+TnqT5lPlD6y9BIujshs98eLrDOygocY1CBuE/nl/ZwXZYz9TUVwUCbYySN0PYcTXusblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825869; c=relaxed/simple;
	bh=zcpRuMcG8V1WLzVteCewRJ1or6ZXKD93iEaEVE4fRw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JglAAtcTPQYDEJ3amAYZdj+A+VPjXFwVn6Ar2aiQSGdF9fE2gVunRnZJlyBm/YOZQYvskO1CAiJ+XnlcgDAtu9H0Nt8DKPpuwlQTORNjpHuLpK6d/HaYN3rNhrxaBKls5kVhzXVML6/lKPKVXNqDel++xLFAVEFvEpWWHNLG4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjbog/M+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjbog/M+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F11F00A3A;
	Thu, 23 Jul 2026 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825868;
	bh=LHpetW3KaMJsuqf1crKGDCq45JumnQTPUaA8edbuY+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sjbog/M+v5nrjsNwUr2T4zcHmHYkkffKEcqpPyJHRneXcet2qclB58qBp0Koqw3yJ
	 qAotRZzd2aDG6v8BJ9jVNvBk/nQgxQh/MMI+BTA9udmwIZhyH4E9FPznXlPBjUSN9V
	 ATGPwfnZmVH/zV4wJ/eA3W4fM1JN2X91pCtZOhZRHIVI4psdcBasDg9Dbjw+P5ajWx
	 JbXiFT2B2PeE7rvrfGZAAj0gIWztQ0EUdN3zz4ig6hzUHZeA5rhHd1s4KXdd3qQLdy
	 ZuLOVigBjv6TbqSjisoZo+zQ92FcdHOvDqTXOAlDIiSKTxnpK5/fO8cflo898eyVJW
	 v/2rqRPy3qDqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
Date: Thu, 23 Jul 2026 12:57:45 -0400
Message-ID: <20260723165745.3396221-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165745.3396221-1-sashal@kernel.org>
References: <2026072004-prelaunch-refinance-a01f@gregkh>
 <20260723165745.3396221-1-sashal@kernel.org>
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
index d2373733e98179..10f57b12f26f26 100644
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

