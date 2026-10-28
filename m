Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188649;
	b=BLopQbroO85SFP2TwN1b+kWqKd+zhxV9O0Wx/GeXShQ+0P6UHUYf+v/mMI9QUuWd94HM
	 oFDgzjhS7wLJe4j55W4wji1m52jkI+97+ovq25HfgtqQKMfRAwtXpIE/HR3U0gzbMmipu
	 XcwPFMFR0cpHfCtE7J4BHj6/6rwX9DS6UwnRQmfVGp9v8oc/pdLqUGwkqWrHsUA75e4Xn
	 zy5w4HtEo6ZnyTro5ojOSa+HZ53OIx0zIyodSxASEWv6SBBXWCnfMle9zP15x0mVVLPwC
	 FuI1aBd4ZwacZZlSJqyTKIawx2x/ib+0+8HuiY/DpbTowQQFMzSquHliJ2rqLnO2Ibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188649;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dE3bjK6V6q7+0Kp3at70qUH5wNVpLQIy6nIGWt4NgU4=;
	b=2i4MvmvLGZqKRYL5DFXeFrwRbZXKGK/sgnIPOuQnCZEHa4HTGWYAG0V8SBwYXA+AvWTu
	 MlVwFhgjTqHVaJCNW58SsQYo429kPdCVyMW7WYzzG8lrG20MZJyFgkKienAaTH+sHRNBI
	 XudsbrW1YzGNoduxK+GbGTogQp31HchrNSbbXkVpf2JXOpOGl7slvEZOGdyZPWh5NUbKb
	 zH3+KmfnjpV6nKg26ll7UdyjnUYiQAZbRrjrKn3mzqZ4UQJ6YiCGdM455/Qf7l3ExDEt9
	 rzf+egtsS33QQ4AkcCZEjtlPVdY9WW+6chrud/LOie9yuPyf+ohqXvw69P01fFLAAyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WqLjdv2z;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00E606A31A;
	Wed, 28 Oct 2026 11:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD00E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WqLjdv2z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WqLjdv2zompj8IeLPNY5GQXZVtfO7iHJdcfU3VXaMtFA9w6GYUDqhOIoCs84LU+14+Q0gKEU7sDEc
	 +krNQJ1Ud97ZlWRr5xNb8ER4vT1WBaTdPD60DYJ3mBkRifDLu6wi3YF4atGTD9QQp77JT1Au+CbGQG
	 kE2BBfoITL5X+sSw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae1e31fee2-2e1b7;
	Wed, 28 Oct 2026 19:57:25 +0800 (CST)
X-RM-TRANSID:2ee66ae1e31fee2-2e1b7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae1e3230cc-3de32;
	Wed, 28 Oct 2026 19:57:25 +0800 (CST)
X-RM-TRANSID:2ee46ae1e3230cc-3de32
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	xeb@mail.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] ip6_gre: fix changelink conflict checks for L2 tunnels
Date: Wed, 28 Oct 2026 19:57:10 +0800
Message-ID: <20261028115710.27806-1-yanxia@cmss.chinamobile.com>
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

ip6gre_changelink_common() calls ip6gre_tunnel_locate(), which only
looks for ARPHRD_IP6GRE devices. The same changelink helper also handles
ip6gretap and ip6erspan devices.

This lets an L2 tunnel change its parameters to match another L2 tunnel,
since the duplicate check looks for an L3 device instead. Incoming
packets can then be delivered to the wrong interface. An L3 tunnel with
matching parameters can also make a valid L2 update fail with EEXIST.

Use ip6gre_tunnel_find() with dev->type, as the newlink paths do.

Found while comparing the duplicate checks in newlink and changelink.
Confirmed with ip link commands. For example, with an IPv6 underlay
named under already configured:

  ip link add tap1 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 100 dev under
  ip link add tap2 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 200 dev under
  ip link set tap1 up
  ip link set tap2 up
  ip link set tap2 type ip6gretap key 100

Before the fix, the last command succeeds and received frames move from
tap1 to tap2. After the fix, it fails with EEXIST and tap2 is unchanged.

Tested with standalone namespace tests in UML, with three runs each for
ip6gretap and ip6erspan, and with L3 GRE IPv4/IPv6 traffic and normal
tunnel updates. Full x86_64 W=1 builds with adjusted configurations
completed before and after with no new diagnostics.

Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Runtime and build tests used net 7076f684d513. The target file is
identical at the current base.

Kernel selftests were not run.

The allmodconfig- and allyesconfig-derived builds had WERROR,
KASAN and KCSAN off. The allyesconfig-derived build also had
KUNIT_ALL_TESTS, MCTP_TEST and MCTP_TRANSPORT_USBLIB_TEST off
to avoid an existing MCTP test assertion. olddefconfig dropped
IWLWIFI_KUNIT_TESTS when KUNIT_ALL_TESTS was disabled.

 net/ipv6/ip6_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8f0c369..df490798355de 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2055,7 +2055,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 
 	ip6gre_netlink_parms(data, p_p);
 
-	t = ip6gre_tunnel_locate(net, p_p, 0);
+	t = ip6gre_tunnel_find(net, p_p, dev->type);
 
 	if (t) {
 		if (t->dev != dev)

base-commit: 5d7f3375cd574fc83f0cd30839b21455c0e79ae2


