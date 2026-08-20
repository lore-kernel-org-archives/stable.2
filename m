Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932D18DB2A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199701; cv=none; b=CJAvGCNK2igRG55ulPZehWPR1E8oXDYog5i6pe+aHqg6SlDbSQROBM2Mc1dFKrq1f7rwLEiNUVwD4gpSNS4x2uCUcZO6IDlC+H3zH02ibTUZ+XKaFZF0k/5IGuWjrzK3YqTKeFZ7RADe0uQSBTOGbwWX/fBP96BvaErw4F4JJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199701; c=relaxed/simple;
	bh=QDI1bQm9kJdOOgwoLcR1l/1VQyVuAlGLZuXdkAI+qBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhfxQNogYtc4WO+pqvd0+z54vlg1ga/rQeKZUQxDpJ6de/V+LmzUykCn/l0Pzkdf3SVlKRqGLgO+C4n5qnf8eZOf6B2brA3Jwqh5alOvjzEj/6jQHXmupRoVn2lsmMyeiYrHo4qTgb8+t4TpGIPVMjHXbylvB2n2I3S8nTh6lio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjVGr1IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjVGr1IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6EE1F00A3A;
	Thu, 20 Aug 2026 04:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199700;
	bh=fBUReIMrqaGNxS5+cVc20pK8Ly2rB9b9iMRuYb+Ahh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjVGr1IUShOxKImBWlgQkBhPrkxknrnU9S9vPQH7guIcrx/NZ4hb2QpgqIbPFB9wX
	 dXBKAduZoWpRtIipjFmcIN5ZBt9wP1OQd81Y5o6bKCNwzrbvHJEJMrdCm9QOU29smv
	 O1ezNIi5KDhCnYUyCdhCmTiHtDcnq2ANYm1sObNVuHUN1PABL7TrUa7myGmpCXM3GJ
	 4QRkemxHa3D7oNc+n+NGkbhds1LI0Psjj80taWJJi85SLRrmxHZFeTQh84HMedounQ
	 /hgkyjAuOrqLAuFgLrpQOuA3qh0KBoij5Q34ogG/F5/aS4s0DQPcuOMTkj2RbxwPUo
	 EgdXlfDjZrcOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] net: sched: use skb_ip_totlen and iph_totlen
Date: Thu, 20 Aug 2026 00:21:33 -0400
Message-ID: <20260820042135.1376434-3-sashal@kernel.org>
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

[ Upstream commit 043e397e48c58b4442ea5124dc1bdc95367a0a33 ]

There are 1 action and 1 qdisc that may process IPv4 TCP GSO packets
and access iph->tot_len, replace them with skb_ip_totlen() and
iph_totlen() accordingly.

Note that we don't need to replace the one in tcf_csum_ipv4(), as it
will return for TCP GSO packets in tcf_csum_ipv4_tcp().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8a7ed561671a ("net/sched: act_ct: fix sk_buff leak when the header checks reject a packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c   | 2 +-
 net/sched/sch_cake.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 1639cc2869ef1..0742060400805 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -629,7 +629,7 @@ static int tcf_ct_skb_network_trim(struct sk_buff *skb, int family)
 
 	switch (family) {
 	case NFPROTO_IPV4:
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
 		len = sizeof(struct ipv6hdr)
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d94c9c11ac1e2..367ee57377059 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1269,7 +1269,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    iph_check->daddr != iph->daddr)
 				continue;
 
-			seglen = ntohs(iph_check->tot_len) -
+			seglen = iph_totlen(skb, iph_check) -
 				       (4 * iph_check->ihl);
 		} else if (iph_check->version == 6) {
 			ipv6h = (struct ipv6hdr *)iph;
-- 
2.53.0

