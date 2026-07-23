Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15E38E5D7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825665; cv=none; b=pgZcDgan/ADqO5ebPdAVJZ8Kyv4aYo2A7kll7MykF+6G+FbcEjAwcjmiT4vNDTmQGSJY+oy8wO3Etjbnqfo1VTaoqZKqgjHn1DLOlKe5G/qbji52rivE6ymPJCfU+9RE0fhLPkB4nW5pjplFiBMwJWTELEmBQd+Wu0mylRCt+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825665; c=relaxed/simple;
	bh=j4nsl7WsayKg60RfMkaiMOiYgEkPvZjP+CwOAaA5BEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhRhOWYU6TAwCMPUat0vs85uxzjIHuQnLTC316VM5CjyfjMwXKygLV0G5/T5CTzVVRab39bMZlQg5GP3N/f3jOR8iBoX9bcNWoQ5CMggnPp4CFSXuGoBlHDb/fpEP5YaEIbISGl/g6C92jP7SGvAHw+eJqy7AUeThP0kEnydOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfdciCK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfdciCK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F4B1F00AC4;
	Thu, 23 Jul 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825664;
	bh=0oPjhgG57DKd1xucu3SeO+pwj7RJY2cA8vAZmuxVjoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfdciCK/KGHddUC9Au2QZzDvkNLZ6LJ7cmaUcI3fnTW/SzFFtplDcAykuVvkxG45R
	 fYyB4xvKNkTJdUeoh1IZduIiQe31t+7ge6IS5j2WnFG+0jQYMsIoLsjSz1BrlIobja
	 7TB4mUpGfR3SHJ8QS/R76IwQTzoPxIytchLOnwqA9qKGal6wnkOQ5t71i0dHg76Jhs
	 7JdqxgJKT1meAsri2iKVip0g+yeUHRWBJM7vqneLhOfLyzirbPhMj9MNE/GFpweK41
	 CsaxMiPGRDiW5ZAojVyc6k3yem8Drqj2tH/7HnYP26XNSw0Kjt+xlTHHMzGCvfvWel
	 x0MjyFcIzGnJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 12:54:21 -0400
Message-ID: <20260723165422.3390558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072003-quintuple-cascade-1edd@gregkh>
References: <2026072003-quintuple-cascade-1edd@gregkh>
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
index 4326d5ea0400d2..d2373733e98179 100644
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

