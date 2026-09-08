Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111F56B87D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907045; cv=none; b=TIuSeaBWKjpwB7mMzMgVYlbRhR6i6CXsGIyILf9t2SLsKcIKxw//ccE7Fks/8UDWv6h09yMzjkcrl86lcAHJ2qUUht06b9+wdTYhbpllDPWV5nSNhpEMh6vx7XzeNQ2vMcAOvm5QDPt33jA1V5c3H8svN5xkjYYdhQkQR5G3U2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907045; c=relaxed/simple;
	bh=OdUb9HArOYeRa9J52eL+BVhdZ7t/UiPxrq4hT/N01TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmjAxBQ2AujXtrJFycDCpkMM4awlZ4lSqirNFqZxaZW0siDzWNJN3Rw2+k1pPItD8LcnENY8ldaiLUWFhxkiAlkZMKhkH49avopWTkIHcUPK5gDzee4NyWUQYP+WaxuF9T4nLCp/6r/B9hDsm/MsfbVWrEZpKAtWM+AmbxnGRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du69FkOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du69FkOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBAB1F00A3F;
	Tue,  8 Sep 2026 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907041;
	bh=yzhTZEl6fP//euCKjoEZEiflpwt/CqGYo4GNbHcnf6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=du69FkOVlacXoodwpgluhgXk6AHJyqLM3B7JODnXW7yZLeCTimf8P/lfmu9RGAPSb
	 TjcAVQ+47b1NoR2o78fcVlN53gwrwtF2nH5tYEJpg+QFRtJQvgdmq+oaM+6iSKEDe7
	 P2A/cWtc9GhQI9/oIGqRe+2BWG66o0OEhlb9HwZW8qfaaI7GIj0n/jsrnfaUKxdvG7
	 BnM2cqa7hFr13N9WtYHbmcsR1NKEsG0LBa6YNJEI9A6ClztQfi6GXl+z6q5GYygRmE
	 Q8OS0Xghz9aDZ9yHSvSI6JPfmw/zGiJQfvKtXKexc2JoNqDTJW1GJ9GxiWu/BQWL/O
	 HJ+pdQnofGwYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ipv6: icmp6: add drop reason support to ndisc_rcv()
Date: Tue,  8 Sep 2026 18:37:17 -0400
Message-ID: <20260908223718.507924-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223718.507924-1-sashal@kernel.org>
References: <2026090351-sagging-obliged-3e7b@gregkh>
 <20260908223718.507924-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 545dbcd124b02c9dc93c8a5894c71d682effc3e6 ]

Creates three new drop reasons:

SKB_DROP_REASON_IPV6_NDISC_FRAG: invalid frag (suppress_frag_ndisc).

SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT: invalid hop limit.

SKB_DROP_REASON_IPV6_NDISC_BAD_CODE: invalid NDISC icmp6 code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ sashal: Reduced backport -- upstream 545dbcd124b02 touches 4 file(s), this
  backport carries 1. Not backported here:
  include/net/dropreason.h
  include/net/ndisc.h
  net/ipv6/icmp.c
  net/ipv6/ndisc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f826df95332c ("ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 6111fe395ff09..1a9e2f989734c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -495,9 +495,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
-	struct in6_addr addr;
 	unsigned int chdr_len;
 	unsigned char *buf;
+	struct in6_addr addr;
 	int accept_rpl_seg;
 	int i, err;
 	u64 n = 0;
@@ -507,7 +507,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
-
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
 		return -1;
-- 
2.53.0

