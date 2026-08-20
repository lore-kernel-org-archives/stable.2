Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D467377034
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199700; cv=none; b=km2YJkTCvpRwfR/ysb4rfJc5numEfv+IQvTqcwAUmQ/+f+4/D02fxeyQPMCwI7YmZ4+Tal6dNqFe11M4ZFSXTMDqi72vnsZ2lHfYDfdd1SsG004xeLlK9rmIug9J5sgh9Fl/17L2ZF7fQcaqtBtQQ22eo3S+2Zki51DjmKCO60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199700; c=relaxed/simple;
	bh=WBopMc9O3oBm+1UJuezst7plDYDXQZZNT/cAkC+TYwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8m/v+TxVR2FI+OWs99a541lE2Mf2DSUPdUns/crG5gV6kiyf/i3bjoXWkbcyzsHbyhXnVh6fPcO7Lwivsao8l9S3H3bua12R5LRt+Uf6jFuFSqVBwQshLA425mRF78lvWIX3noPUHrVJVdI/IK+4aCXTczWkD92rOUtAMrwm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJwFuQv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJwFuQv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E01F00A3E;
	Thu, 20 Aug 2026 04:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199699;
	bh=ht3Hywn0bOmu65UwrthdlBLGDg24HxWqDJwPSJn+th4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJwFuQv6SWLR6XlMbfKDLjK71/J3vbsWTbRzrH1tWRj9cFHuwyo236FJ+3fnyXHB5
	 q/eNqOv4Txv2U3etoXX0zFWDJp56h35mHyejLLBp0lNPn0pwLnGpOmHCTUNep8vN1C
	 kyw4k14butSKoekOT2wjcbVNSWPBRjk8kcK9tJXDFHP/eUdH9esHjhFoippzOxe11i
	 3Akycogx3T3G2zd1eoKWuj6VFbWbOL8NT0mxkL2GCp7BDkQ0Dwyw+UpunGyy6GRGy0
	 /G639ntRyhwouM/IHm7FrB8/OK08rcQgTJkZxwZfPHsQuyTcJjBBlvUGE64aHZUAvs
	 GXsNivf1qwlfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] openvswitch: use skb_ip_totlen in conntrack
Date: Thu, 20 Aug 2026 00:21:32 -0400
Message-ID: <20260820042135.1376434-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820042135.1376434-1-sashal@kernel.org>
References: <2026081754-splendid-scabby-9156@gregkh>
 <20260820042135.1376434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ec84c955a0d06cef31664bae328d94be7a3e2f03 ]

IPv4 GSO packets may get processed in ovs_skb_network_trim(),
and we need to use skb_ip_totlen() to get iph totlen.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8a7ed561671a ("net/sched: act_ct: fix sk_buff leak when the header checks reject a packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 527a181c842c6..f401de5e8b386 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1275,7 +1275,7 @@ static int ovs_skb_network_trim(struct sk_buff *skb)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case htons(ETH_P_IPV6):
 		len = sizeof(struct ipv6hdr)
-- 
2.53.0

