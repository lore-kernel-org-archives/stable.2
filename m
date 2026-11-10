Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=206.220.120.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291377;
	b=Vs8mZVlMfJiw7Z6/4OQ+YurbowkiEUUHYnvHF40gFc3Dm1jop5M7lP2NsvdDFxjomI82
	 EHUkPHfVwTtaB0++kmIyAB/SB5ldkBl4JreK5o5KGFwYAAX4cb66FekDOD8RyXg7UwtQi
	 4brcigmOGflbV7lvT1Ob6xGbwJyG1GCVz4SD9rNZmzdZWP/x2KvPo8lWwDj6IW3knXgiS
	 sCm8sS5hOYhV83wqECDO6Mce/24MCgVsrU7kmtqUnFofgM9D4IN6ddazx7g5AZ3zEjAz3
	 Aa0N51HrfKvOsJfCfGTYz13/t/WeCFmZjIM1DOmi1iNXqNJ/OxgwgvalPuHSOLyhVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291377;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4LS1Zfya615xsUeheOA7iZAshf3PDe4fPBV1OJEdjdw=;
	b=BXHkF9JkfvbmOylU6IoSdG5EN3GVi6k+QenbB3vBeiz4cF0yN6wGqQ+p3pS+hJ0fsk6X
	 wI/StzYeAfJ5oPTS87YD0ZvJ3pN2PoNgOkRrvivJ8V/DGBzct1d4ipPgTErb/bgRUPico
	 PhQNmhoJr173F7b7UD8bUZCufiHvihH43pM05iUqnoTGK2oULI2AP086Ofx4vNa10BtqJ
	 dnbAA/Q4556P/s8RPg4Sj3zr6QGJBatcgif0v/+hP2lTS9JEA8heLb2/Hxgcug+cWfNk3
	 Tl9KnIDa76H7yxcWY4JS9889AGCLKA/j1N+Pb1TVl+5A3Fb0h5C5nHlIiunvGgacdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grapheneos.org;
	spf=pass smtp.mailfrom=grapheneos.org;
	dkim=pass header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=WZTEFYSJ;
	arc=none smtp.remote-ip=206.220.120.4
Received: from mail.grapheneos.org (mail.grapheneos.org [206.220.120.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5F60A261B;
	Tue, 10 Nov 2026 06:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF5F60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=WZTEFYSJ
Received: by mail.grapheneos.org (Postfix) id 80E0B3C08EF3F;
	Tue, 10 Nov 2026 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grapheneos.org;
	s=default; t=1794291376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LS1Zfya615xsUeheOA7iZAshf3PDe4fPBV1OJEdjdw=;
	b=WZTEFYSJOLQ6tPKjPouxH+WoNPeac3gjh9OfKm2kayjyG+7IyAGnAboto13RbXw2EmEd/e
	yzJCeF+K595fdkEKp2c9f1t30/D76JZN1i+d5geJegdDBdw1kNn6N9TJmlQaUQGkfL/Qdi
	5GiJP3iS013CpUVYYK1r/nX/PN0ik0azxo1DwoCc2zh4zDVnxHA7yuQMug7wgM1KnrLzSE
	xwQdiwdDjlsPJz7IS0TtL9E/lm/qVqflPCWJqbSQgLqFd/bqxyOaBNM0lne6Q2LpXV5yja
	hlJ0uE6UwAyypqzFF3wIfjl5Xk0FAVvkuXwLt3TH7xnr8fCPAETJ7L462h6MmQ==
From: liamsmith827 <liamsmith827@grapheneos.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liamsmith827 <liamsmith827@proton.me>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] ipv4: restrict on-link fallback to lookup misses
Date: Tue, 10 Nov 2026 06:15:34 +0000
Message-ID: <20261110061536.10811-3-liamsmith827@grapheneos.org>
In-Reply-To: <20261110061536.10811-1-liamsmith827@grapheneos.org>
References: <20261110061536.10811-1-liamsmith827@grapheneos.org>
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

From: liamsmith827 <liamsmith827@proton.me>

For non-vrf unicast, the on-link fallback currently occurs regardless of
the particular error returned by fib_lookup(). As a result, routes and
rules that are supposed to restrict traffic (blackhole, prohibit,
unreachable) are unable to do so comprehensively.

A specific example of this being a problem is within Android, where the
VPN "kill switch" is implemented with prohibit rules. Any process that
can set flowi4_oif (SO_BINDTODEVICE, IP_UNICAST_IF, IP_PKTINFO, etc.) is
able to utilize this fallback, meaning unprivileged Android apps can
trivially bypass the VPN. This is particularly bad on cellular networks,
where ARP is often not needed.

Restrict the fallback to routing lookup misses.

This was originally observed on an Android device, by way of packet
capture.

Tested fcnal-test.sh in UML with CONFIG_IP_MULTIPLE_TABLES both enabled
and disabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: liamsmith827 <liamsmith827@proton.me>
---
 net/ipv4/route.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3a90c8d28b94..80a2c8a3c571 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2851,12 +2851,13 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 		goto make_route;
 	}
 
-	err = fib_lookup(net, fl4, res, 0);
+	err = fib_lookup(net, fl4, res, FIB_LOOKUP_REPORT_MISS);
 	if (err) {
 		res->fi = NULL;
 		res->table = NULL;
 		if (fl4->flowi4_oif &&
-		    (ipv4_is_multicast(fl4->daddr) || !fl4->flowi4_l3mdev)) {
+		    (ipv4_is_multicast(fl4->daddr) ||
+		     (!fl4->flowi4_l3mdev && err == -ESRCH))) {
 			/* Apparently, routing tables are wrong. Assume,
 			 * that the destination is on link.
 			 *
@@ -2881,6 +2882,8 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 			res->type = RTN_UNICAST;
 			goto make_route;
 		}
+		/* Reverse the mapping induced by FIB_LOOKUP_REPORT_MISS. */
+		err = err == -ESRCH ? -ENETUNREACH : err;
 		rth = ERR_PTR(err);
 		goto out;
 	}
-- 
2.47.3

