Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412947;
	b=VfEVrc1QZIVkRAPTLwAfsVXdeoxf2iHzPWcy7S34qOy1vS9YD/2+tC1Q5R2yH15Tzm3s
	 daS3XUyIOKExwgM6ULTdG97uWYWZKgjkvoZDqtuzwEDopdCEcGvdtavGnWoRlPJ1AQl2Z
	 6Tl+FXelDjHJM6ufu8SmDglrRTxExLK/pON9q+D2TYYgWCd1vX4PL74uHqXMmM2NoLZJB
	 uBm+D5BJanXBc7KX8HtP7BW+0PayoDoCSekuH0++1K1Lfy1XlB8czkUw2sq465wayakxR
	 Hb/x5id44E9CiwlSJLeIR8N/hQLqd4xtlnTcoW/AxOd97znmU8kLq6MxwtsWRQN10zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UeVL5tFMMwezuNQAA/rFonblZS/6GeGknSarzUeypvE=;
	b=1HWr4rISz1XZQVzxE0mHLjYySv/NvM05Vvv5pUErUl1p2X8dm9oo8Ga7bB49/brT4bZI
	 ST0XGZXVAg4JIph9ijnpq62/MP0PSzz9UEmX19qq/wNfuRKVI+QYdWOZQcNofBGJ6btxm
	 YJu7PGLGPlUhS7LmPtirsQIN5Noc2qYm+ngxaOfjdXIRapRBQf/hNDTg8oE1WOmfj3wRj
	 NbuDLoKHP8hVP6gHhsQa04CXuYVUrOSKhWb3yc8YVbyIZavcEASwMvYArMKmPy0IF4hpJ
	 3Lcpjq3wKkQdPKSO0FHkPOlCZ84FB53ke3F71Hl1SnrXobZg7oYBMUfPmIkB12X88PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M6/Pv+Rr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6/Pv+Rr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B7F1F00A05;
	Wed, 11 Nov 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412946;
	bh=UeVL5tFMMwezuNQAA/rFonblZS/6GeGknSarzUeypvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6/Pv+RrOtTNeeLs+FbKLKOTSLkyUjQD1zSPnMkn/rcgzW6IItgsg6BTNuIwyL9fC
	 erjEWhFMAxli8a9oDx8CibQlW3oM8sIPvPuNHfJ8q8fGfOtNkOhGziPEKY0WvV4BXl
	 7AVCIvVYReuBO2uPS17s/3u9hUK3nALxArwrlJ7BxHnapHnSgXIo1Og5dI+Uw58s1i
	 xvoZPujI6uJML00FsWlhVo672rfEQhsSLgIObhBNhI/bwRuAMPUvPP2fuAXNOZsQmr
	 W+TDsc7uoTzh0Ch/HLEtNwcC94iJuXjY8c0WTEuIKe1hVwY4HwhuN0gixzWM+Tebvv
	 MH8Y11qXiu6oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] ip6mr: ip6mr_sk_done() can exit early in common cases
Date: Wed, 11 Nov 2026 11:02:21 -0500
Message-ID: <20261111160144.2767084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060950-failed-5.15-6ace56ed7b13@kernel.org>
References: <20261107060950-failed-5.15-6ace56ed7b13@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f2f2325ec79970807012dfc9e716cdbb02d9b574 ]

In many cases, ip6mr_sk_done() is called while no ipmr socket
has been registered.

This removes 4 rtnl acquisitions per netns dismantle,
with following callers:

igmp6_net_exit(), tcpv6_net_exit(), ndisc_net_exit()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 6ace56ed7b13 ("ipv6: remove ifaddr from hash during ifdown list cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a793dcd24813e..0e2c566ec04b8 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1581,6 +1581,9 @@ int ip6mr_sk_done(struct sock *sk)
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return err;
 
+	if (!atomic_read(&net->ipv6.devconf_all->mc_forwarding))
+		return err;
+
 	rtnl_lock();
 	ip6mr_for_each_table(mrt, net) {
 		if (sk == rtnl_dereference(mrt->mroute_sk)) {
-- 
2.53.0

