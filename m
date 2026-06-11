Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6235F191
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159301; cv=none; b=GEjfjGoroHVuLkN/d2zv2GdyCSyLYHkddI82s5QM3mQFZcN1r3ARnxnDy95AEzceh/xZ8grobX9CnQb7/alUgvG7lzUN81JwysCSku7x6PJQ42nsr+Tr3kciJCIgRt59N8sQxMRQn87gownfmCkmDaTmfDoUYOWun2ztiTkow/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159301; c=relaxed/simple;
	bh=ABoF11LlsjDImEw0o01Srl9sxas+dXW8rwIo0VibxEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kiq+7arRwktqzsP/FCUQmbCanB0DzopxFiZFd6+b1BqnXSGeVvdELOqcgxlX/XjQAPuFv14Mx+DYDUcrs6Z28Qd5XpNyCDAk0oOScEJtfxuC5Zh9zwCsUtNP3pG0nEv9ZHfJ4Hb+zPjbGs9P0gqd3PX87p+weOZ7QzcIWKpa92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3RkNECM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3RkNECM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf20f6be6bso60088165ad.3
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159299; x=1781764099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKHDbTRgcEA8qLlfBQUFErqZeMY2tu7A8JF88+7Bp4w=;
        b=l3RkNECM5FfUFpqSDDFIUENv3a1Eo2a+uYFO2u9U5X9a/ASFmNjDmfXR3O8RruskIt
         dkUTgYtzny5JquUyprUQ58nqo6ptMOHQ+ybSQUla1pTeWoy3PVrQ//pcbl7jgo68KpZj
         QmxIR/5aSScusWaDxczdO21WZMZHKY77aMYWSQ4yKxYKt2uiqmuMiJVtVoeSg5lWmKak
         W8pfbwlqyZoPa1Sa+cjtws5xaPFDSJRQO3oF9lO7LTb/6mPn/9rwQTb6yLUmpGDaXoO7
         0TBAExRREgzy+Tc7rAmLBtgMpOFFIqjdtg+P3Evs6K4klB5/WZMB7IMqdSVyiDHA0ZlX
         OvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159299; x=1781764099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKHDbTRgcEA8qLlfBQUFErqZeMY2tu7A8JF88+7Bp4w=;
        b=s5FoBhSouG2WYo++9+9tAXfLT5N1hdax/Bb/8/ixt0T42PS5uzTZd7FOl/xzkzrDHD
         PAY7VXR9STJQnmRCdP4OyltI9xG72tYqPqEFyQlBi/+aT0Yj5oEoy8IZH+DvBHvTtlxz
         N9ilIPbOWux2luhMIsiNygwWV0oMxEpD8tIgEXO/2uWv/UEppjsgqwMzJVSEVjc2eU9h
         in1HxIlANkeK38brN9iT5Oas0eVG4OGGlGBNPQwhRfEqaj6sEuqrtmcoBuyDcrcM3l3O
         s3yIx2r+LTJZ7PVSUtktNaM5VsyFQxzIWlmnpLt9NGHRQ+69bHJq1TgzRJN8v9n2m95C
         vLVw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q8r/ANScInSKVMbc9GNRFbVFGx1oQTxZqoaUpnVSsVaysV9xZ8jedccQ71evK4Vt9Sri94cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiwz/+e/fs2wAuWueXtJIqYApH5uidlOFzRYqLe0jNuGHIwVE
	9nCrIRmI840+7gLUqAi2LsnfZrp1QBnVYATmVooN2YYHM0pzy+1uu5+1
X-Gm-Gg: Acq92OHmBCdNkyR5mJ8shptcbA1/e4sbN2rl3h4+4/Kzf9fkBklmD9rz3TFWv1ZLMUJ
	8yvYR7o9dajBR/rfPVlbfsHlorNad47mZjxksNqUmw8Fkfsi5qfsWcOzXnzLGeFPqvonUsCNCN5
	xdQReZQHlZNkKFyvCK6UBtT3/QyFo7WsiXWQm+TvJX0O9765OVF+T4F9RXGyiCil34Fdbe+o4TT
	v+2GukBeXUwatYrLnzV+7wOGXYCCbol3pgw2GUVqW3iqYFEKowLetCLL3G6eBEsf03Mj25LE/cD
	eLFAJH3qi3vnoSWo8fKMXi9IBBAhhYIAenORrapeOk1R4aQofxhIraNkNrFk3fTc7HTXFnnrjW+
	hLCsuAMUHvFWAfzFz5KEZlIyMYBar8Tn5nPAAemIvZbW6Pl9UkQaRzQRLhng8kdPjN8N94/mKE7
	A2aNmd+mhrVeOv+CQHlMOdfLC6BOcVACPU4YjCR0ej5weJ/DZaW5uMwBqOgEQ=
X-Received: by 2002:a17:902:e88f:b0:2b0:b016:773f with SMTP id d9443c01a7336-2c2f10174dfmr15989465ad.11.1781159299332;
        Wed, 10 Jun 2026 23:28:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:18 -0700 (PDT)
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
Subject: [PATCH net v5 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Thu, 11 Jun 2026 14:28:07 +0800
Message-Id: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in the link netns can rewrite a tunnel
that lives in the link netns. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first
(for example ipgre_netlink_parms() sets t->collect_md). The check is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked the cap.

The check goes through a new helper, rtnl_dev_link_net_capable(), added
in patch 1 next to rtnl_get_net_ns_capable() in net/core/rtnetlink.c.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the link netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

v4 -> v5, addressing Kuniyuki Iwashima's review:
 - Move the helper to net/core/rtnetlink.c next to
   rtnl_get_net_ns_capable(), rename it to
   rtnl_dev_link_net_capable(dev, link_net), and drop the kdoc.
 - Reword each commit message to state that changelink() operates on at
   most two netns, dev_net(dev) and the link netns.

v4: https://lore.kernel.org/netdev/20260609163110.1717419-1-maoyixie.tju@gmail.com/
v3: https://lore.kernel.org/netdev/20260604125055.3254652-1-maoyixie.tju@gmail.com/
v2: https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/
v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

Maoyi Xie (7):
  net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ipip: require CAP_NET_ADMIN in the device netns for changelink
  net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for
    changelink
  net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
  xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for
    changelink

 include/net/rtnetlink.h        | 2 ++
 net/core/rtnetlink.c           | 8 ++++++++
 net/ipv4/ip_gre.c              | 6 ++++++
 net/ipv4/ip_vti.c              | 3 +++
 net/ipv4/ipip.c                | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 9 files changed, 37 insertions(+)


base-commit: 512db8267b73a220a64180d95ab5eebe7c4964a8
-- 
2.34.1

