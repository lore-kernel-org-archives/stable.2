Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14C33A71B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816346; cv=none; b=R1kD0JZuSUZiw779MLmFOmBbj5bW0g6ToJYVD87LSWI59FfsWgoAdjGcCwXTUTWJkIvch5wWiO/Qs3E5rai0Rrzy2Fuob/GHGoERtdadKd7U/i3j7utj/7CpbS1Y35SFmdgRyNhq2P7AGy31hj/cGKzvcFBvGUEcJMW2+fZ15yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816346; c=relaxed/simple;
	bh=xUW/zIxSKWSwaMHn31hq/brGUaZnpgHVv7IvOUYmijY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxhJSJZN6su7ovK/gsEjdU0XPRnhea7L/Out06PU8ioSEi/IfDE4lIjQcTpOwqPobC77FcFuNihctqyBiTBARL97KxIieBmmzDWdzni6/PYKDsco2PtuZbYqFtPeV21sbmR4cyB/ADxydXeQOmL9OME9KyKKDV91SJ2IN1AtRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqVN7QLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqVN7QLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F91F00A3D;
	Thu, 23 Jul 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816342;
	bh=iMnjht8iuqYgsaSv6KJnHtXfcjH16v0GykTN3bxzy8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cqVN7QLmatVLEWbq+hrkOA6Or1GoSaLzucVEttcix/yLTcHkpzpCuIlyFXOmYZsMw
	 SxNL2nES4tgl0t3qneEcCe4KHCrPixc91rZ3lUPJETb0M6lrOnii37qFuJQjXc3dMf
	 NqIpOel/T37cO/u+d4vIpijCPmTq86jql2p7vIQWcUpQ/LCdxkBCUJKUUZa1ZFvMpA
	 fPl/U+B7+IJpI18f5ngyx4vd1eWD55lEGdlLiqOv8oGRNJ+2+IuGcVT67FWNqUANBt
	 9FpdDh5AG0DCBQ+jyZiDc3FKVSzrwI/TyR0KnrUXRyIvR5dDr5noyhT+/Jjp/qRHDd
	 MallhpR+R7rsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 10:18:39 -0400
Message-ID: <20260723141840.3216559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-sedative-yam-0618@gregkh>
References: <2026072002-sedative-yam-0618@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7970d6aaf710db166de98c5356a260089896fae5 ]

net is already set, derived from nf_conn.
I don't see how the device could be living in a different netns
than the conntrack entry.

Remove the extra variable and re-use existing one.

Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: e5e24a365a5e ("netfilter: nf_conntrack_sip: validate skb_dst() before accessing it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 81534213f00f34..58fce6242f89cb 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -948,9 +948,8 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
 		struct net_device *dev = skb_dst(skb)->dev;
-		struct net *net = dev_net(dev);
-		struct flowi fl;
 		struct dst_entry *dst = NULL;
+		struct flowi fl;
 
 		memset(&fl, 0, sizeof(fl));
 
-- 
2.53.0

