Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660111;
	b=q+Cw/NDrRE7hkNYB9cASlRI8d5oWlhbeIX1MMhrubbCj4LJppZQqQHIru3ZaeJpOtH61
	 grr00GgVqoKNnxkRV4sTzi3PV0s+J6BfmTvWcIWIwcZEDW052+Yt0eUGLjIeBHw9mYwiS
	 CBvsVHu4Gs1FUb9kKQqSPkFu9vh0lfNfSsWj5DwgVK0dCusJ4y5mMu1jV2JEu1Y9/IvLO
	 VQW8zD+i2k8Chcl95cRUqpe3xtBYJt5jj9hBUhuKl21BG379qXUqumEWWAa01VFIUNh0O
	 NR5lVwSN8pNx9AJ9b5zmsoWF5RCbQJnpp9+goijttOG+klu2Y4fwy/eEdV5UkDOCZ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660111;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FnPAv4piVPBvJnqlLGMEnfUI5qWz/TzWKkbWb8G7NQ0=;
	b=SGHi/mu5Ani3CDg/WFm0KglTDjEdJ48yQczrUbwv3FFIGU5Oy/QsFc1qtgGH8j/pTy+l
	 G6o8bFQ38T8toQHqVzzlMpqSfqRTeWcMU9c6B+35Htz/dLC2+9hWiM5nqeb6gquTfNiyt
	 V/I9sCCB8ejuxBrbjVkycINFNzDJZaByYKHDkQbVV0dV6SBLegNkFgK+4YRY7Ztq5VA36
	 FW61fhU2u3oFZwGV2+0rMUFvSUqmVTSywQ/n1yNC+Mw7DP2pK/oqwD9iKriE1T1e1WY4B
	 PeDVakYGmQT5uBut6IutgUekOE2HVuR5iSHT+r7PNl7W6oHuSD7paesrVSjOHfthzFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ve3U1wmN;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6B606A31A;
	Thu, 22 Oct 2026 09:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ve3U1wmN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ve3U1wmNKvAKWU8zgJGJIVIotNyD/lmrVRwuEeNGTi8Qrgi4pp9P8wnZHw1xAjOyM9hJhEECm+yr0
	 1kr2K6PGw2urpF6Do13YE/mTH5vVwb+MSOjbeskuI19qw/ED2pdHQXVrYplY4YdTnwigKH87Aj6obv
	 2/UfiKKDdgfaiTCU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ad9d284a4a-0a136;
	Thu, 22 Oct 2026 17:08:21 +0800 (CST)
X-RM-TRANSID:2ee16ad9d284a4a-0a136
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ad9d282d89-13201;
	Thu, 22 Oct 2026 17:08:20 +0800 (CST)
X-RM-TRANSID:2ee66ad9d282d89-13201
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] macvlan: fix passthru promiscuity accounting while down
Date: Thu, 22 Oct 2026 17:08:09 +0800
Message-ID: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
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

macvlan_changelink() adjusts the lower device's promiscuity count when
NOPROMISC changes, even if the passthru macvlan is down. The reference
is acquired in macvlan_open() and released in macvlan_stop(), so a down
interface has no reference to change.

Clearing NOPROMISC while down leaves an extra reference after the next
open/stop cycle. Setting it while down can remove a reference held by
another user of the lower device.

Guard the count adjustment with netif_running(dev). Keep storing the
requested flags while down so the next open uses the new setting.

Comparing changelink with open/stop exposed the unmatched count changes;
the same issue was also described in earlier macvlan reviews. A netlink
test on UML reproduced both DOWN cases before the fix and verified the
expected counts afterwards. Repeated flag updates, two open/stop cycles,
deletion and bidirectional small-frame delivery were also checked.

Full x86_64 builds completed with WERROR disabled for allmodconfig, and
WERROR and KASAN disabled for allyesconfig, including the resulting
dependency changes. Neither comparison showed new diagnostics.

Fixes: df8ef8f3aaa6 ("macvlan: add FDB bridge ops and macvlan flags")
Link: https://lore.kernel.org/netdev/179170088566.434549.4699134797461783473@kernel.org/
Link: https://lore.kernel.org/netdev/20261016003009.2692872-1-kuba@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b..a48c9e6 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1664,7 +1664,8 @@ static int macvlan_changelink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_FLAGS]) {
 		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
 		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
-		if (macvlan_passthru(vlan->port) && promisc) {
+		if (macvlan_passthru(vlan->port) && promisc &&
+		    netif_running(dev)) {
 			int err;
 
 			if (flags & MACVLAN_FLAG_NOPROMISC)


