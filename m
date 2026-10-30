Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342181;
	b=SKsZt7K6yE/ipyXN8O76YcEN5n2NV0h2pb+dzrQc12pEWugfQHuS9QzUNlLw7XPB46ND
	 ABbu8a2eiBxkHYW0Eg34C4jJqvT1WYUcyeNYh9z2JGo+T5rt5qCyEqbYaTzGbX6wlhV4c
	 U8ev0mFBjhBh5d8tcpKbkTNRibq2rcnACSBaBGhSoaPvokPhQy3AuB5Pgy1sKXh6hlihD
	 z5BCKSEs7P3CEn8WBRbdqeegpp/YBW+/K6DPV9BzkcJhhp5QV/bW1qaN3yNT90oVAZOP2
	 K2CUTFIfmL9mb6JTMDASUfS2ss/izOj5teoNDwr/Y/muL8Yibu9AogmH2PklaPXtK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342181;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oo4Ex/ixow2sD4fwwblWZTawB4RSoFqlqTAEwanw7bk=;
	b=DGqVCCl5f5QAgVcibtXr2CBJqyo0X+SncCO4eEL4NZ3w1SzlQeUnLTHbxL8gxGbWnjh4
	 OG8lxhlQdAyHd3SQXbKY5gXt88WkowblqCTGaElUMXutbwO8OpwECv27Tt6A33cl685lP
	 Xa0S8UJps/SLjf9S0CCWSF0wvL7G1oW1WfdgV7A6VrG0HRo8n1DiJZmhaA5Qsy/zsuOhS
	 kjF3d4MC+ZdaVNnCFbjFjYlWwramFlzNysGsjE4ci8ONzp3b5n/B8BV4AHX3gQCNfw81D
	 W+1pml4GTjYdl4Xfpgjs0uOxQAx9uASYkLioo4gNN2fkni+X+LJMG80FY0gxThighUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tSWeqm98;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF0606A31F;
	Fri, 30 Oct 2026 06:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CF0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tSWeqm98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tSWeqm98z8VEhg130xuN+b0AEhE9+aP5VLqUSRxOQ9ihm4VKesj24/tnxLRfmtU+zf6V/XsPzDKPf
	 TGHh/ttGtIb6p4u5Zn+mSzCJLh3EdM8qQyQzvPyByc6OlEud9DH4zAX9iN6h8Frrxux7osdaYVX9bZ
	 TpQifXreDZflcL+k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96ae43adfe52-76970;
	Fri, 30 Oct 2026 14:36:16 +0800 (CST)
X-RM-TRANSID:2ee96ae43adfe52-76970
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae43adeea3-892f2;
	Fri, 30 Oct 2026 14:36:15 +0800 (CST)
X-RM-TRANSID:2ee46ae43adeea3-892f2
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] ipv4/ipv6: preserve multicast filters after a failed source leave
Date: Fri, 30 Oct 2026 14:36:03 +0800
Message-ID: <20261030063603.697510-1-yanxia@cmss.chinamobile.com>
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

After joining a group with IP_ADD_MEMBERSHIP or IPV6_JOIN_GROUP,
MCAST_LEAVE_SOURCE_GROUP for an unjoined source returns EADDRNOTAVAIL
but switches the socket's filter mode, so the existing membership stops
receiving. Leaving and rejoining the group restores reception.
IP_DROP_SOURCE_MEMBERSHIP has the same problem.

ip_mc_source() and ip6_mc_source() allow an empty-filter mode switch before
checking whether a source list exists for deletion. The failed request
changes EXCLUDE {} to INCLUDE {}, so the socket no longer accepts packets
from any source.

Check for a missing source list before changing the filter mode. Preserve
EADDRNOTAVAIL for the rejected deletion and keep mode switches for valid
source additions.

Found while reviewing the error paths of ip_mc_source() and
ip6_mc_source().
The reproducer uses socket calls without kernel changes or fault injection.

Tested with a UDP socket reproducer under UML using the IPv4 generic and
legacy APIs and the IPv6 generic API. All three paths lose reception
before this change and keep receiving with the fix. Source joins and
leaves, block/unblock, last-source leave, and ordinary leave/rejoin also
pass.

W=1 x86_64 builds with derived allmodconfig and allyesconfig configurations
also pass, with no changes to the warning sets.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---

Validation used net fcc00b15cb21a6de76826e5012b2c758505f5e65.
Both files are identical at the base commit.
For the x86_64 builds, the derived configurations disable WERROR and
KASAN; the derived allyesconfig also disables KUNIT_ALL_TESTS. The complete
before/after warning sets are identical for each configuration.

 net/ipv4/igmp.c  | 7 ++++---
 net/ipv6/mcast.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 144fca158adcb..9c38045e38731 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2520,6 +2520,10 @@ int ip_mc_source(int add, int omode, struct sock *sk, struct
 		err = -EINVAL;
 		goto done;
 	}
+	psl = rtnl_dereference(pmc->sflist);
+	if (!add && !psl)
+		goto done;	/* err = -EADDRNOTAVAIL */
+
 	/* if a source filter was set, must be the same mode as before */
 	if (pmc->sflist) {
 		if (pmc->sfmode != omode) {
@@ -2534,10 +2538,7 @@ int ip_mc_source(int add, int omode, struct sock *sk, struct
 		pmc->sfmode = omode;
 	}
 
-	psl = rtnl_dereference(pmc->sflist);
 	if (!add) {
-		if (!psl)
-			goto done;	/* err = -EADDRNOTAVAIL */
 		rv = !0;
 		for (i = 0; i < psl->sl_count; i++) {
 			rv = memcmp(&psl->sl_addr[i], &mreqs->imr_sourceaddr,
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ecef55f261890..2ade3351c904a 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -395,6 +395,10 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		err = -EINVAL;
 		goto done;
 	}
+	psl = sock_dereference(pmc->sflist, sk);
+	if (!add && !psl)
+		goto done;	/* err = -EADDRNOTAVAIL */
+
 	/* if a source filter was set, must be the same mode as before */
 	if (rcu_access_pointer(pmc->sflist)) {
 		if (pmc->sfmode != omode) {
@@ -408,10 +412,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		pmc->sfmode = omode;
 	}
 
-	psl = sock_dereference(pmc->sflist, sk);
 	if (!add) {
-		if (!psl)
-			goto done;	/* err = -EADDRNOTAVAIL */
 		for (i = 0; i < psl->sl_count; i++) {
 			if (ipv6_addr_equal(&psl->sl_addr[i], source))
 				break;

base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.39.0.windows.2



