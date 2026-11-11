Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414189;
	b=qkZD0XNGjdFI3jSnFAHlbW0G4In0uDFQ6syzD/iCn229hH2FjPEBWjqUSU3DiC7opkAM
	 bfRGYiGb9TyatbkIkhAUO3Wxhv41KV+zrzjWsGNGpqmxyG+WjS3dYAqA4kayTa2uQCd+u
	 MlnQbsVPXnRuzyodByqNbSNW0U8tRnGK30po35V5HGte4O0GiYBuMmVI3Jde0r4W1xv5Q
	 dYSoS5rTcqG5NumKGTILaXIcnToXulGoW/jx28bZXYQO8Rw8jlanDGITUK4CrtcB92atZ
	 dO2Od7VQXvhub6CtxE3h3pLdK7HuC21+DmEE0Qk8KWydqKxqeGTVJYkqk4RJehDI/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=asJLg+4iFeuVzhaHRel1gXB2lsm/WtNZxntwpquS1aw=;
	b=Wtcqde9yZvDeWUXAeGKFQcSPcUNnM4YBkABXu8ZzWzP2J8GvE9YfTwWxv1M9BrwZNISX
	 GhbkcY5Z8bb9wiIbLy40RJC5Gl5SpMFASItrWsvH+ZlrCJYSryLXto3q7K8+1AgivMXlU
	 pOfzMIZb9H5PruukTqqnw6UbFIyL/Q3QwlMyUGLbvrx9WxqFArt8cAFOOW+UUVT1H6+j1
	 2PkLVpkxoZND4wS5QfN+EPW7FJDX7V9oRXgoEZIB3Kh3dNo+iDe0cXyMIEpv8tyfrwWo5
	 VFT3RXFd0KZxjEXHj1QkVkTGzuUv2XkTw35+J/RmLNT0I/g56v41TAXLeTpXtiinnLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XitGnwer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD7606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XitGnwer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C161F00A05;
	Wed, 11 Nov 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414189;
	bh=asJLg+4iFeuVzhaHRel1gXB2lsm/WtNZxntwpquS1aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XitGnwerDjo14tNhVxQ/PQjWA7NeV7MKy6bMRhEmUyGJt6dAxAl4wpo+9gRVQ+OcE
	 MtqRJeprmZv/c0iHgzu84K0d/WnKyubzxBWPOJV/Y/yNV6ET45eFHcv5eCm5oDr/FC
	 eidAr8c1p4rqC6U1ncTfcDNerQcUSHKuP/KGd1g9f0sMDlmSMeq8difrlAWr8qEaXN
	 Byluf3PUa7GvLb/oLbFB3oexcpmhM5HKVofkSJsAtwFlCEfh2Umasu5qIvzPwfPy4n
	 /5mmyI/5wpRUSytmpwEVD4Ohu/HeGHpIBNEgINU4wsWDjDoNnhRN+rOXBi8Yp7Oc8Z
	 ZdAKXldQgEvAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] ip6mr: ip6mr_sk_done() can exit early in common cases
Date: Wed, 11 Nov 2026 11:23:04 -0500
Message-ID: <20261111162230.3239471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062657-failed-5.10-6ace56ed7b13@kernel.org>
References: <20261107062657-failed-5.10-6ace56ed7b13@kernel.org>
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
index 43bb75ea93898..bcb2f8513d847 100644
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

