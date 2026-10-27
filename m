Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090662;
	b=mmIENJRkzjosoe8KNK4+FVPevJeLXX1JcNsXFr33lYGQIZL8XuZyTanqtzh7FQ8/NM4i
	 nM7gSAF9PmmvG79RpZL5Lc4+xh481vVIk5ELcDMdliD3t9ylPMniL4p7eatIlUjUVQbhY
	 jtWXIubMCBan3mY7wiRKKKiKfhoRhjURV9vEUYL9gTig431UANfRQoCTEmoxAND4lNXhg
	 BdoORTkYwNcTnG/0Jzgl9/osLo/IBNacB/xbPxq3rsTYxfAyVp+BNGgtjzns7dpfvF5d+
	 JOVT8ygAmJuL0uIeQYHV24tuNlnY5tIPDGaVt43vIuRHhqQF3+9ThveoHHDQFwtPFfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090662;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=QQtN6MBrzVTITESxnnTPIPrTXdMtx56mlZnfrkfj2rE=;
	b=Eie3W0II7ETX9bFQDbZJDXhmoUOFt/DN12ucuziooxSdA/WQOaSgQ9KgPsXTdN9BD9oT
	 Ra2rLSJ95gpdJPdmCYY2lzj/HU31PaSrmiO9wpRvENzrTLXIml+FJlBP4ZwHLz2iSzScJ
	 hY7fMYvqzCLznsXy7NiMS0NxP+pSd+xjmdogH2QNCJVMpYSb12KV9wPanLBz97HCgafNs
	 /f+7oiW2PhabRgmingEC+7m8AikqXB5cBW/ynXJTgRGjAZrbZZzsYsS7AmPN6FWs7bSlL
	 BkcQXSp21YDd8DfYi+kGweqrYns6e0P9I34+e43yv0aritqKlKio2gy0+DLiBJ2ODGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=s0vRB24K;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D80606A31A;
	Tue, 27 Oct 2026 08:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=s0vRB24K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793090650;
	bh=ypiwmVB22gLJ22DC3pLViaIYbfsJ8+15HGo2FCwbYf4=;
	h=From:To:Cc:Subject:Date:From;
	b=s0vRB24KiSd3tSDxBRpKLGEvPAbgXbmfy1CxlHwYAd42xnUG3mqGWSbJeS5E6MI7R
	 GfDoldQ90dQzrocyQNpLMpXvaZAt9wQ2Wliw3kBfMgeYofoDrhJLR2/vStnlNkn621
	 SrPzPIprKrl5VwuZCZ99ohPOIS9Rpz05ShsAsjhHp9rS0K6FXgMoW321eli8jLFchd
	 W32LO8T7CSKfpvpET4UFAk/b37AXRO2ayOSFS9ql0942CcStP7r893L2yqfafFf1+p
	 3ZHUNNPFN/5vadSRCYbVpj4eXW1pALC3JlPsU5Jv+YMX/Ivglw8obf76457QSgbJgx
	 GFYLE5nYUIUjg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 543822556D;
	Tue, 27 Oct 2026 11:44:10 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue, 27 Oct 2026 11:44:08 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.50.125])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jDPBv2WJyz223n;
	Tue, 27 Oct 2026 11:42:47 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	AutonomousCodeSecurity@microsoft.com
Subject: [PATCH 5.10/5.15] xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
Date: Tue, 27 Oct 2026 11:32:55 +0300
Message-ID: <20261027083257.1879-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 132 0.3.132 b92628ca234da971a1a6d61b32804bb3075f0fd2, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207017 [Oct 27 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/26 18:21:00 #28745978
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Xiang Mei (Microsoft) <xmei5@asu.edu>

commit 136992de9bb91871084ae52d172610541c76e4d2 upstream.

On the error path where in6_dev_get(dev) returns NULL, xfrm6_fill_dst()
releases the device reference with netdev_put() but leaves
xdst->u.dst.dev set. dst_destroy() later calls netdev_put(dst->dev)
again, so the same net_device reference is released twice, underflowing
its refcount (ref_tracker WARNING + "unregister_netdevice: waiting for
<dev> to become free").

Clear xdst->u.dst.dev after the netdev_put(), the same way the XFRM
device-offload paths xfrm_dev_state_add() and xfrm_dev_policy_add() in
net/xfrm/xfrm_device.c NULL ->dev when releasing the reference on error.

  ref_tracker: reference already released.
  ref_tracker: allocated in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:86)
   ...
   udpv6_sendmsg (net/ipv6/udp.c:1696)
   ...
  ref_tracker: freed in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:90)
   ...
  WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x58b/0x780
   dst_destroy (net/core/dst.c:115)
   rcu_core
   handle_softirqs
   ...

Fixes: 84c4a9dfbf43 ("xfrm6: release dev before returning error")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ mdmitrichenko: 5.10 and 5.15 predate the net device refcount tracker,
  so the error path there drops the reference with plain dev_put()
  rather than netdev_put(); the fix itself is the same. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-64580
 net/ipv6/xfrm6_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index b504eeb59224..95dd8acd45ad 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -88,6 +88,7 @@ static int xfrm6_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 	xdst->u.rt6.rt6i_idev = in6_dev_get(dev);
 	if (!xdst->u.rt6.rt6i_idev) {
 		dev_put(dev);
+		xdst->u.dst.dev = NULL;
 		return -ENODEV;
 	}
 
-- 
2.43.0

