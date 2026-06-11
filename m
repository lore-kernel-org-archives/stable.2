Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD535E1B6
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159315; cv=none; b=kGnQ5GfthyeNUbLEADBxo0mdwXq4F2+86g5IsDk4xaA0zTjQyo6ASyKcWhUlajGQA9l3GDwYg1j58MIjgRO4Cd31+fD/goE9HBw6Lb52zsAFGUeUddVYr2+Jrt33BPcD+EdzFHhssLcZhyikTz2MKfPouAg44cKHFtiazzWXmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159315; c=relaxed/simple;
	bh=qq1AC8mmu8ksZN9y8lKno5QGVHkBTEEHkuTf+PQy6l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNRGK2CQer3RKIrDfytvynvYqyY6eB2sKFKwA8MHCa3p/zFf19cSnWb7IOLM1DABqW76Qk0Ouvc0ZIs1ufMYa6Peax3FnhcAAT+NP4yCdz1lzQDcOScQ8PIaz1BBt6TgwQkWBfD52bgagmXAdfsWO3T4RaBGM4JwRDsjxfNHsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFsqbGyW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFsqbGyW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf1f074a12so77493345ad.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159313; x=1781764113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiSEDdFXwp4wzfKRu/Jr/XvNkOP8+EYI4EAvAyk7TiQ=;
        b=kFsqbGyWUy/RvdRacJBJHxJ8FBnhw56U50nwFxBnSWyLiF7LC/XCB9nJtVYNkWzzIo
         +EZGsZNGSa5fRgj2JrgPCAul3QHuNJCZaUQJQCqQUIANdkKUmfU5AFcnZi+6OhuazLh/
         fLEQbQvjeo8yj4rs4kJeGyPh4p74ydB8wu23bIyA1AYXthjZjKlwFcDqJGO97S1Zumyh
         oOZG1KPnQEnHTRIG2tcYkih2A/mft0fynoLtwsHy4/+0bwhC7nQestCprEMm4Co9d+s2
         T7PcDmAbLBbI6eqLBbpA7laYr0CEsunWtdL5b53z87xDp4aoMemmYEnWT1Kppp5f9pu2
         xSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159313; x=1781764113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiSEDdFXwp4wzfKRu/Jr/XvNkOP8+EYI4EAvAyk7TiQ=;
        b=RmDJ2NMh6GXTamk9lh7lhHWVEfQP8aTVEYsoxTCt//w2Qd4mIHkzGfSWvtzq6dD757
         bPpjhovfdhlj9B2ked9SwJ+7jXMGvTnykL/JtYuTHYdWx/GVVZBIRhLCrfLCub/o8GN7
         E8Sv3dEpZL797doYwIuYGCdPDwg+WlzsoC90mofSdvdgQsr5XOOcdviAhmnRjp8M5osv
         mKGUJ+dEQRAWsrrp16rln4QrFrNYqKtwSDWk0d6emu4WrdUNFS/gOlBDCtfZ80kC1R83
         J8+pmDpIPfwrr8NOHzoQgb58kUHKUaMp7P8BdtolOcWpwPV2vNFgzJP7YK4bcZg/ns0T
         gqOg==
X-Forwarded-Encrypted: i=1; AFNElJ8CEgMRtcnyfOjOXRK7JaK61x7vcXFK4DIpmf6bQSvEBJ/3h5A0x+vkIkQK8u0Ti40nBpjcZv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOLjeLMcPrL/iIaNIEs5YZECvvYnMZw89j57DVUZynwvru2GD
	ORgpO/usdKZBCZNdXALekz3sGS4kSb0u0ezsfD23cYoYA8QL3DyxIVGZ
X-Gm-Gg: Acq92OGsthxCpYd+pusr7188yUzE1zdKI1CGTUiUkwmkt6WAYjkfe1i58bFPxpKSCWX
	OYJRbBa5aOitDcl76A5RVwLETCkRW5+/hoCNH8HI1rEDOiX6uvm1zI8auxDKn+cr2lpCIAeQ1Hl
	fsa1Ax4qr+YJwDXsFg9kFMb764zylhs2AhLo6+U4Zzvv+3ahDiz03fS7hF02jEG4+rCTK2oUZh/
	6LzrfwquovTQNu8zXJYEW3h1Iz9XitWYVdcPx6WgKERVOmj5afTtWMUE/yhMlOIvRhwIIWB7gfi
	Hluo0GqM48j+m9GmnhJ3HrO5v9ipbv+2AFOiG5iA3xe1XBSahj4RE5YMld9y08DcMXWPMvJvoWl
	M7aGsmcrLTFY4VvD0XbeeEnoz1sLsRaTUDG9X7ZmE3ewvGtXgkyAKv+NEMxM7Ks8F496N9308rk
	vmbji600E+x/JO/xrzSTv1i05zMufgUpnEX4Z7hdoHAPTZg5HyaLBIHgovY58=
X-Received: by 2002:a17:903:189:b0:2c0:d097:51bb with SMTP id d9443c01a7336-2c2f005b33amr16117395ad.1.1781159313422;
        Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:11 +0800
Message-Id: <20260611062814.2528793-5-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..922b0feaddf9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
-- 
2.34.1

