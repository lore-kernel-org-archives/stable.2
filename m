Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188743;
	b=FesyZeisXiU/YVCo+kXrlh9RDtTf+vQ3Kygs7TCTAY6qY3x1sNYl6v5l3LMkJwoqOnIR
	 mGvDe8dqmyg6vvzQQDx1kYjMtsqksBcS+M9smr3uysmu5F1GnzyMPvgaNXx815xACyX69
	 SUTg1clwjTgH8g9P0nwSbLvtGF5LCuP6wMham/oSYps27jV/1R9SN+T26xu/HEI3VDz8X
	 s5lvYmTmTt1D+gwOrFKkLzK8TCO8m2KHDfVZIJfOAnBag7padPsUd/tOHMQnIio/oKbOD
	 A/3LNPMGmYVmri3Q1BQwl6BwC3j6KqnLxAMU/m9wS2HK6ybwQxo+P9bgPiyOPoUAttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188743;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Sf9xjMisnPuuJIfrzz6CIBnS51JvwzLeY6jUL8yvs4=;
	b=DT3hOmL9jVs0yBapxgHG4cSqTKQCZlVy6la4jbPea1jos4lb3cJaEB9XINaEtWjZbuw5
	 ApbZj3l6FmL6bafDiJruZ/eCPyaMV+RxPfL8+CqmeQo+SVyFHeBtfCkgU2cMwZDurndDl
	 hLr9M+je9tbGsJbaJzNNFHPEt6pkTgmgU9XjY/EO6/yFEqBOj65rwBrXBYhzjAeXmfVS5
	 ByWuFsRM6sm/z133XvRmOE+lAswDaEwaozjSMD/2i9jD5DIAK6Jalk8p/27GqHxkcSkgw
	 qHpkZVH7a4dmmK3frvQAUZu+2PgzBVtFEYEw4ZvwAaWUcq3lIGUAKNAovnFca6HvHoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=eL2QQhjh;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A8606A321;
	Mon,  9 Nov 2026 01:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=eL2QQhjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=eL2QQhjh+YlOy50l26Muskvn2IMoC5eJIlr2qSNJyibMvg8hla1+C1J9+vhrsMY7pXBcs6uMgXddH
	 GQ5CsBPqpYfa5rSwIZDWnjX7myuL2EN/yk4I63YAwaqCEkDIDRyILLC9EQAC74inmEklmDmUnrtnUf
	 4R2CyatZEoBFinwQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af125c2749-5e7e3;
	Mon, 09 Nov 2026 09:45:39 +0800 (CST)
X-RM-TRANSID:2ee86af125c2749-5e7e3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af125c1671-7c022;
	Mon, 09 Nov 2026 09:45:39 +0800 (CST)
X-RM-TRANSID:2eea6af125c1671-7c022
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	tpluszz77@gmail.com
Subject: [PATCH net v3 1/2] ipv6: fix cached route reuse for control messages
Date: Mon,  9 Nov 2026 09:45:25 +0800
Message-ID: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

A connected IPv6 UDP or ping socket can reuse its cached route when an
SO_MARK cmsg requests another mark. A packet can then bypass a prohibit
rule instead of failing with EACCES.

ip6_sk_dst_lookup_flow() reads the cache even when connected is false.
UDP clears connected after parsing IP or socket control messages. Ping
always passes false.

Only read the cache when connected is true. Ordinary connected UDP
sends keep using the cache. Ping sends do a fresh lookup.

Found during code review of IPv6 UDP route caching. On UML, the same
connected-socket selftest fails four IPv6 cases before the fix and
passes all 54 with it.

Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1e0038bcc3ef8@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
v3:
  - Read the cache only when connected is true, as Willem suggested.
  - Drop the SO_MARK-specific cookie flag and UDP/ping branches.
  - Restore the discovery method in the commit message.

v2: https://lore.kernel.org/netdev/20261104092240.15649-1-yanxia@cmss.chinamobile.com/T/

Tested on net cb284914e749 with GCC 12.3.1:
  - UML route checks: 50/50.
  - x86_64 W=1: vmlinux, bzImage and modules built with allmodconfig-
    and allyesconfig-derived configs. WERROR, KASAN and KCSAN disabled;
    allyes also has KUNIT_ALL_TESTS disabled. No added diagnostics.

 net/ipv6/ip6_output.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba..cb648c8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1305,7 +1305,7 @@ EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow);
  *	@sk: socket which provides the dst cache and route info
  *	@fl6: flow to lookup
  *	@final_dst: final destination address for ipsec lookup
- *	@connected: whether @sk is connected or not
+ *	@connected: whether the flow can use and update the socket dst cache
  *
  *	This function performs a route lookup on the given flow with the
  *	possibility of using the cached route in the socket if it is valid.
@@ -1322,11 +1322,14 @@ struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 					 const struct in6_addr *final_dst,
 					 bool connected)
 {
-	struct dst_entry *dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
+	struct dst_entry *dst;
 
-	dst = ip6_sk_dst_check(sk, dst, fl6);
-	if (dst)
-		return dst;
+	if (connected) {
+		dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
+		dst = ip6_sk_dst_check(sk, dst, fl6);
+		if (dst)
+			return dst;
+	}
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_dst);
 	if (connected && !IS_ERR(dst))


