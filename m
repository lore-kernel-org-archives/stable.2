Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C74A2078
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290923; cv=none; b=gp3y0hJIzJ0IeFOCOIawe75dsUT/lCwb5s6rj74Tc07WkZfnvTFAkAmXMHleV9SwCg34NgVgJ0e/ywkuKBThCmr4ad/fne52QAAgNc5Ap+ONipd2cZdbWl0bQVjzT8cYHnJx0l514BcCnTgIbWsy+HZ4xK9UvDCTo2c/PfPDTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290923; c=relaxed/simple;
	bh=Ovf6BKlIdPtklHY+wvAsIMgFxltbJIjej9FSVW4gC6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BozVennAq1Jwk5YlwFDXp8mfgkK2kTPwtAAqiD/JwoSrQhKxAdPLIaE3+UxpjOV3htwmQChxVE3mP7j6JRcF2idOuX8n0CkZQSgtkDrUdPwd94OcC1eQLrGy/wKqnxXcWbxkdZwQSWlqYmSElfTjHagweFId2gxnRYxXoj7rv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyM2sGMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyM2sGMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0DA1F000E9;
	Tue,  1 Sep 2026 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290921;
	bh=sQwmGO2rHoyUqySv/wo/pVeruFzaATPY3x6YInpmUGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VyM2sGMsIYyhOx3NsecVoUARCsHGTGiMnW7fyatSd6Yz1tMbNfuD4radYIbqge7tY
	 moqLCBHbz21RvX7HnFUF0E4ux07F7oeW8HkM1QhLuxoedP6uo/oO/4OTzfX1nhud6p
	 J4/igCQJQyo+yLxBCL8gdBNO4Z4gYVXlbH91fC6ctK4D2cujl24vBzIY2cH6Zjcht3
	 DZ9p2z8/aQw6fr3Aw03GzdIe6zqlz7m2yBBmcx9YA5XLpq/l4LhDY1hBdQ3Z0+0dDg
	 xlaVcjtOL44s9w5BKuoZueNBoQwhO7PiYtnnVP7g8T/piWqHGYrkHBaCRidB5x6nv+
	 CSlJAWMl5hB6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 15:28:37 -0400
Message-ID: <20260901192838.1439895-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192838.1439895-1-sashal@kernel.org>
References: <2026083117-magnitude-talisman-5d78@gregkh>
 <20260901192838.1439895-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b40f0130a23b6bab8b359e158a40af81f11f14be ]

When we expect an IPv6 dst, use dst6_mtu() instead of dst_mtu()
to save some code space.

Due to current dst6_mtu() implementation, only convert
users in IPv6 stack.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ sashal: Reduced backport -- upstream b40f0130a23b6 touches 6 file(s), this
  backport carries 1. Not backported here:
  net/ipv6/ip6_gre.c
  net/ipv6/ip6_output.c
  net/ipv6/ip6_tunnel.c
  net/ipv6/ipv6_sockglue.c
  net/ipv6/route.c
  net/ipv6/tcp_ipv6.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 1b0722e9b55e4..f44808d6f420b 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -453,7 +453,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
 	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	unsigned int mtu, res;
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
@@ -477,8 +477,9 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
-- 
2.53.0

