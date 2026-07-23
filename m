Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33272466AF7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818413; cv=none; b=oYYQvCoqSmH2hZDJEUTu3omDvMtQTX40AYKySGIeArZv3UWXozApYOVagXCiku72K+2WsrWXOjyaRtZUrjP2qr/G2QInlln1jQVmqnhTQi2j/F+9iO+RqZn94stxtMQN5b888A29WIUXuqsWgjsrqRdjwfV1A8L50eApeDSLrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818413; c=relaxed/simple;
	bh=j+cCeWzoIWZkDBL7CAUpF/JLKA2pJheN1nIjJ6Byv2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PczyG8n/NBcay2PlwnTyzk9jdzo/BuxOaXcT1naEgSMFhhfwxQlzTRZhUcAe4yiJUAkpfP3Ytm7uhyAMl0TjWj+8o2ODwvvyTAqWZZfW+uTPCk/zoYx7XltGX3F7n+uSXBxmyPAL2ibfgpYyeUNyw3i7OS6oL0Tw5wjCr/NP5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F4D1F000E9;
	Thu, 23 Jul 2026 14:53:29 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 10:53:18 -0400
Message-ID: <20260723145319.3272168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072003-scorch-encourage-ddad@gregkh>
References: <2026072003-scorch-encourage-ddad@gregkh>
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
index ec31611b7a290b..911e35e3b71be0 100644
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

