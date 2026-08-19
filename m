Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFD37BE93
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166522; cv=none; b=maxkSSWIqcCuHURavkKz5AFtHXuDxsCbRi+BR2kOXFIT0arCxlZE6XmdE98bB1etoVhHP9TO4dvCkPxj2bmzPn17dLAwoqEj/01Ei5zlHusMIZn7k6pXuDBW+jWfIs18sgE+4NTiloyGtkmr74x3sO64jsr/6FZCBQY/Q1QZR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166522; c=relaxed/simple;
	bh=Bbo/c0L4e6n36vRPRvufQqVLDdXgqiDS01ANVigp7GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvyIgq/vpQM6khRhMQXgYYin2AF9jaXo8mWKl4E1Z6CIcLCZ9/XovYWCy+Ta5fZ254eRcP2BBhkK0bL2pDY6uciAur7F+WWfa5FREgXMFgsGVkZJ8XVoNsx6opCS3sU5AhUR3ZIXckFcWnOFl9TWklP2kYXN26/aqSuZadkU1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuAxnPrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuAxnPrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C895F1F000E9;
	Wed, 19 Aug 2026 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166520;
	bh=IC/flKP6keQUglZAciIbnAN7YWawBoQNT/Zbu7t85i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FuAxnPrlCViHmm9wEFNxJm5h5ppQsz8QFeE93p2xlYAp/JZVplze5aez20F965+v6
	 qFK9Uxo0GFmW00rLQp93nExpdTcQV8K+qLMYJ+Aef9nnGAo5Eqxg2GzAylGXVY+Z37
	 zM4dMqYb8b0xU4G+FmFqYVR/9UIvzbcej8DeoeQjVNyIzQMzfLSdTAwfg+R8Uaw9Er
	 2BbXoln8KA5pMnzFJutMHZMmNrE+EfBxNUNAx/N9u8wzM4CMTIiaPfq4YvrUSXxhmE
	 HiQqR0jNZ4q4dOxjvFLUd1Xug6biH2Kn9wNdfa7Y45n1wR9NvOxzb/whWSMbWFI1WX
	 I5xCg/LOjnZdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] openvswitch: use skb_ip_totlen in conntrack
Date: Wed, 19 Aug 2026 15:08:33 -0400
Message-ID: <20260819190836.561493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081753-suffix-dill-686c@gregkh>
References: <2026081753-suffix-dill-686c@gregkh>
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
index e0ff87aaf979f..3bb361e70cdd4 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1282,7 +1282,7 @@ static int ovs_skb_network_trim(struct sk_buff *skb)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case htons(ETH_P_IPV6):
 		len = sizeof(struct ipv6hdr)
-- 
2.53.0

