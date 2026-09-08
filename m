Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD0599A53
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907045; cv=none; b=F6POpUdlydOqBzHbSLmtRh+jXtnzwieJvmMW7reDb2lbVu2dxw7G/Rb0ADUCqV1+X+o3xB79f7lVc6soWUhN4fbOIrWD5dY6lRKLJv02tqPdDAWz8bvNtWDiITBEDEJyePWg5FTY6d3lhElldEJBXiCa1Oc24vB9qLIY8mIRXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907045; c=relaxed/simple;
	bh=szC7GdbYLdE/TPVceFffOofoe2/SOVetr5hGVOOPwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz+s8JmqEnAu9jd7bBHZyiXjbnRR+bdRYshI+6AzYT7zwHg4cOIJR+qSbW0AKmzMtKufGU5Jxy1DCyPLm4QlUrF4fXKA14hElrzvBmp2rW1wHa5hmp/68P3hL9sOFyx49gW0Uksa2YLqSNono5DH1ufZR//jU0cDxp2xLxhD9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZMyDDsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZMyDDsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92B1F00A3A;
	Tue,  8 Sep 2026 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907040;
	bh=SOyyKfdaAGyZKWdZ+Uf06HP+gjS1AYKYGQE1q/sze9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZMyDDsbbAMbnTfFqwiOtdk8+F6yJvmB8wmTYZrJzGOSm+OpATPUzXCtbCVEtn7Pv
	 ghpeels5FsKmsUWNL1ZA+LcaXm8kVXF7t8IN4m5Kmo0wdl/eDvGX9fDOoxaN5SdGZR
	 wV6SUjbTt9jwsCsk/Q27OPcWmdtEcZ1vg9uifB9yU2MHvBjq94zuTSzmcCJA3O6wjs
	 gJE8JpYKuBY9jOU4OXjOOpCOLGNAPu7Lf0aX3NZUHlZ6BXqz6XW6R9JTpwGPOM5mAa
	 Y7Rb+PLCWjbq2yuels8/XMYoC6IGL9h0LiQt9yzJIhG79/6uutj78HOlZquReuuqzj
	 Dmht3DuNhwd0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] net: dropreason: add SKB_DROP_REASON_FRAG_TOO_FAR
Date: Tue,  8 Sep 2026 18:37:16 -0400
Message-ID: <20260908223718.507924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-sagging-obliged-3e7b@gregkh>
References: <2026090351-sagging-obliged-3e7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3bdfb04f13ebdd4ae50fc5dc595663874781e48c ]

IPv4 reassembly unit can decide to drop frags based on
/proc/sys/net/ipv4/ipfrag_max_dist sysctl.

Add a specific drop reason to track this specific
and weird case.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Stable adaptation: the fragment drop-reason hunks rely on prerequisite
  plumbing absent from 5.15 and do not affect the target fix.  Replace them
  with the missing IPV6DISABLED drop reason and RPL devconf read annotation
  needed to make the target apply and build. ]

[ sashal: Reduced backport -- upstream 3bdfb04f13ebd touches 2 file(s), this
  backport carries 3. Not backported here:
  include/net/dropreason.h
  net/ipv4/ip_fragment.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h     | 1 +
 include/trace/events/skb.h | 1 +
 net/ipv6/exthdrs.c         | 5 ++---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 24ceeab1b509f..af4924ceafe61 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -337,6 +337,7 @@ enum skb_drop_reason {
 						  * is multicast, but L3 is
 						  * unicast.
 						  */
+	SKB_DROP_REASON_IPV6DISABLED,	/* IPv6 is disabled on the device */
 	SKB_DROP_REASON_MAX,
 };
 
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 485a1d3034a4b..33bebe0c7677e 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -23,6 +23,7 @@
 	EM(SKB_DROP_REASON_IP_RPFILTER, IP_RPFILTER)		\
 	EM(SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST,		\
 	   UNICAST_IN_L2_MULTICAST)				\
+	EM(SKB_DROP_REASON_IPV6DISABLED, IPV6DISABLED)		\
 	EMe(SKB_DROP_REASON_MAX, MAX)
 
 #undef EM
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 3c6de4ccbf53b..6111fe395ff09 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -505,9 +505,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
-	if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
-		accept_rpl_seg = idev->cnf.rpl_seg_enabled;
+	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
+			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
-- 
2.53.0

