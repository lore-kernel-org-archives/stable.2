Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282323;
	b=wFzuCqLuYp9OicZE6qyRTt0vpokBH7w4AIqdTBIRe0tgLbF5ybhem2KNBBNIgUDO37QN
	 yUu0UNYZOnYgrQCmSD0t6Kz7BRirxU7Arlsc/RgNPl+TiYU9LgL7lsILQ10TfSOnJzc2q
	 LqaLF781xb8f2LgDNHYweKlwFOToA3uYNjvzMlhb97kgSrlYHCVbt4oaw4Y2wrrvq0fV0
	 +Jbb5rVYDqI363IQfAxSqoffCXyy1BGw3MgzQ4XNogj1PkLIg4RlPM57gE44w/21PhdR9
	 wIudwAVLYszab9MUzh1mzxupK9AaSk2gO4RV9EhSb6VTKijA/OHq8xqDiFmK6BV1UQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282323;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fLo6xHFxBrxaHNFtSj4sb2yRxlgS1/f9BbjYKUllULw=;
	b=D27qqjDHzWQbT9NkUNcFmUR619ilzii9avx1GPB/s6FFCy5NGlOFmkEH6vUYr8U/97vW
	 gO7FnLJaBQPbZdvS0YMl8M+iLUx94cYG0UsvcQQTKjPNMF45Yiw3FSa7l2SY/v+DHrN3y
	 uoHyWACiScR9GXkGeNsgBXzRN6DbEYcw94/CqQ/97hmJlZTYNAJwBWHZMPMBVY7hLu5/s
	 /QaDuVp166/tldyOTi/PzDLauS4yVfePD/QbFS65uOJOe4EogSKBNKShJ5zC4okg3RLmI
	 7p0UAb6eKqHOxPb5Ji4Twx+e4gL5A+ikvzTfu9vmuxfVKvfwYEOqZOxjWdf0qJOjr1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MElb80of;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBB606A32C;
	Thu, 29 Oct 2026 13:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DBB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MElb80of
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=MElb80of1kW0MMkAmbgNi73F/Jug1IQvOKwdkv55UOQEWhf/6e+1zhQTKNZCl50hQs0izVpzKyayI
	 vlA7kWZOldlF+P8mPVVCtdPtutxU9Wr9mPoEbq75xOHlU8Fj8IkblPUE4YAKR4edJXO7KrEytElrnH
	 wbUMefKJPShpfQAw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ae35108762-0ad7f;
	Thu, 29 Oct 2026 21:58:34 +0800 (CST)
X-RM-TRANSID:2ee46ae35108762-0ad7f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae35108b5e-32a98;
	Thu, 29 Oct 2026 21:58:34 +0800 (CST)
X-RM-TRANSID:2ee66ae35108b5e-32a98
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] ipv6: fix device binding after failed datagram connect
Date: Thu, 29 Oct 2026 21:58:22 +0800
Message-ID: <20261029135822.448299-1-yanxia@cmss.chinamobile.com>
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
Content-Transfer-Encoding: 7bit

__ip6_datagram_connect() can change sk_bound_dev_if when connecting to
an address that needs a scope ID. If ip6_datagram_dst_update() fails,
the old peer address and port are restored, but the new device binding
is left behind.

A UDP socket can then keep reporting its original peer while sends and
attempts to reconnect to that peer fail with ENETUNREACH. Replies to the
socket are also dropped by the device match. The same problem occurs
when a scoped multicast destination picks up np->mcast_oif.

Save the original binding before processing the scope and restore it
along with the peer information on failure. This completes the rollback
in commit 2f987a76a977 ("net: ipv6: keep sk status consistent after
datagram connect failure") and preserves the new binding on success.

Found while reviewing scope-ID handling in __ip6_datagram_connect().

Confirmed by exchanging UDP traffic over ::1, then attempting a link-local
connect with a nonexistent scope ifindex or a down interface. After that
connect fails, the original peer is still reported but communication and
reconnecting to it fail.

Tested before and after the fix in UML for three rounds, covering explicit
scopes, multicast interface fallback, initially unconnected sockets and
existing bindings. With the fix, the old binding and peer are retained,
and traffic and reconnection to the original peer work. Also built on
x86_64 with W=1 using adjusted allmodconfig and allyesconfig
configurations, with no new warnings.

Fixes: 2f987a76a977 ("net: ipv6: keep sk status consistent after datagram connect failure")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 net/ipv6/datagram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 191c9733ff9fa..ff7a7ffbf9833 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -149,6 +149,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	__be32			fl6_flowlabel = 0;
 	__be32			old_fl6_flowlabel;
 	__be16			old_dport;
+	int			old_bound_dev_if;
 	int			addr_type;
 	int			err;
 
@@ -219,6 +220,8 @@ ipv4_connected:
 		goto out;
 	}
 
+	old_bound_dev_if = sk->sk_bound_dev_if;
+
 	if (__ipv6_addr_needs_scope_id(addr_type)) {
 		if (addr_len >= sizeof(struct sockaddr_in6) &&
 		    usin->sin6_scope_id) {
@@ -261,6 +264,7 @@ ipv4_connected:
 		sk->sk_v6_daddr = old_daddr;
 		np->flow_label = old_fl6_flowlabel;
 		inet->inet_dport = old_dport;
+		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
 		goto out;
 	}
 

base-commit: d7314b51341c037973ce022f12c6009fd07b021e
-- 
2.39.0.windows.2



