Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784221;
	b=Yka8PxPDzQ7HsWP5ICroDHKYslXlsdoVlECzeCLhbhp8iAIyQXjyMnHX1VpYT6S+6aRO
	 YaIbqCihXtE98lRgZsFHdEkuI9VvHPhezWHFnZmqFxwraT2mRWwBdGU6OGLlTrPdm+qiL
	 ww45d/pf8iYCCfOncb0sxlFSiXtrJ7YoEI9r8R5OVZOyaDv5wkn2lzMymOJ0mTrqUOqkb
	 b7BJdEo6kXU6Hv89/9aIahifiPuvFKiK9jOghEtaUg3L/fuP/x8+RZJ08zl6JX6guRlV1
	 ylMCXfy351EhBkTaPZT9lcSrUdP2cBWjI6oQonanAswAPYaL5vmA+y000iJUoLX2FGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784221;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XyxQL7N3jJ1+AgX+vuqyEXAXQ6bEZTTPu9AIW39S+SA=;
	b=FG8aAThxjAwOpeWecyiqe7+Z94u5K1lx24+4PkVqVb8CDfzpoPxcmU1x2r+JVrrGUWp2
	 FRWwRzyTMQi/t7/f2pA+8BFvxgBXiueZb9rZuVTnwbBaiXDO4tJdblhqryO4qMIemmDo+
	 lcoIaOYsoY3+eKNRoh0qR21PaNssYSHv06jOWmgBesKV8ZwmmY52O9dHONOHL6EBXuu50
	 x2Bnio10nKtne8ehELx4HEUzQqf8yDYzDG0RG7PHoMxLvEekep2/Hkvn5zWbaZKo5iAsh
	 Wx2RjuVDqJXXuckBfc/Tlna/IwMyf5VMU6HArOj9Z0RJrg74fFZe5ayddCiqMYMPeHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=paNFTQjM;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10135606A31B;
	Wed,  4 Nov 2026 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10135606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=paNFTQjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=paNFTQjM8M3uck52rWaW+viXtG/Lh6l03F2y4sXG99km1CIN10GXx1rARn58l/w4AW4Psv3vqMOzx
	 1+h2o2iSZMQp3M6e98z7fMoVZdboHNxHV3mYDQ2q1IhltMefhnxFY6An27bTYvN0deXb8jDoexcC3n
	 4v1k9Dyn1eEUu4U0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeaf998b23-6932d;
	Wed, 04 Nov 2026 17:23:38 +0800 (CST)
X-RM-TRANSID:2ee66aeaf998b23-6932d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6aeaf99897d-c8ae0;
	Wed, 04 Nov 2026 17:23:38 +0800 (CST)
X-RM-TRANSID:2eea6aeaf99897d-c8ae0
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
	willemb@google.com
Subject: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK control messages
Date: Wed,  4 Nov 2026 17:23:22 +0800
Message-ID: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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
Message-ID: <20261104092322.V3yk8eVsrtYc-RJ1e8wpvorIkpU8ODWWH-gyseCT4WA@z>

A connected IPv6 UDP or ping socket can reuse a route selected for the
socket mark when an SO_MARK control message supplies a different mark. A
packet can then bypass a prohibit rule for its per-message mark instead
of failing with EACCES.

ip6_sk_dst_lookup_flow() consults the socket dst cache even when
connected is false. That argument only controls whether a new route is
cached. The cache check does not compare the mark used for the lookup.

Record whether SO_MARK was supplied by the control messages, including
an explicit zero. For UDP and ping sends with that flag, call
ip6_dst_lookup_flow() directly. Keep the cache handling for sends
without SO_MARK unchanged.

The concurrent SO_MARK case was identified in the review of v1.

The issue was reproduced on UML with connected sockets and mark-based
routing. A separate test kernel paused the sender after it acquired a
cached dst reference; another thread then changed the socket mark to the
per-message mark. The old code still sent the packet. The fix bypasses
that cache path and returns EACCES. The 50 UDP/ping route checks and all
54 cmsg_so_mark.sh cases pass with the fix.

Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
v2:
  - Replace the current sk_mark comparison with a flag recording whether
    SO_MARK was supplied, and bypass the cache for those UDP/ping sends.
  - Add connected-socket regression coverage in patch 2.

v1: https://lore.kernel.org/netdev/20261030141435.779302-1-yanxia@cmss.chinamobile.com/T/
Review: https://lore.kernel.org/netdev/179371875338.488856.4546363285391899557@kernel.org/

Tested on net cb284914e749388eef402938bdb3115fe1f6d337 with GCC 12.3.1:
  - UML normal: baseline 41/50, v1 and v2 50/50; the same extended
    cmsg_so_mark.sh has 2/54 failures on baseline and passes on v1/v2.
  - Test-only pause: baseline/v1 retain the old cached dst and send after
    the socket mark changes; v2 skips the cache helper and gets EACCES.
  - x86_64 W=1: full vmlinux, bzImage and modules builds pass on baseline
    and v2 using configs derived from allmodconfig and allyesconfig.
    WERROR, KASAN and KCSAN are disabled; KUNIT_ALL_TESTS is also disabled
    for allyesconfig. The unmodified configs fail on the same existing
    GCC 12.3.1 Werror diagnostics on both sides. Derived-build diagnostics
    are identical on both sides, including their occurrence counts.


 include/net/ipv6.h  | 1 +
 net/ipv6/datagram.c | 2 ++
 net/ipv6/ping.c     | 5 ++++-
 net/ipv6/udp.c      | 5 ++++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -353,6 +353,7 @@
 	__s16 tclass;
 	__u16 gso_size;
 	__s8  dontfrag;
+	bool mark_set;
 	struct ipv6_txoptions *opt;
 };
 
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -819,6 +819,8 @@
 			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
 			if (err)
 				return err;
+			if (cmsg->cmsg_type == SO_MARK)
+				ipc6->mark_set = true;
 			continue;
 		}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1693,7 +1693,10 @@
 
 	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
 
-	dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
+	if (ipc6.mark_set)
+		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+	else
+		dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
 		dst = NULL;
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -148,7 +148,10 @@
 
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
-	dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
+	if (ipc6.mark_set)
+		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, daddr);
+	else
+		dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 	rt = dst_rt6_info(dst);


