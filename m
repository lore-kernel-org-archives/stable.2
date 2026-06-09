Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D243B3C17
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022679; cv=none; b=hkZgpkUWDka/aMiRa9URg/9Vi1H0rrqT2haplqqI68Geul/lqO1F2U7nA/BeZCRNJWHQqVMoEaxG+ymPZtDHE+5X+iar8/Ca8ASrK4jOMk6NR6lvyH1NpRhShCYzjqi6DpWvfMqNKphopUwLbOT2JrULFuEy4NsUwsjnduT22Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022679; c=relaxed/simple;
	bh=lcw6o3LpcRWYiXzPRd7yr9iPF3eQBiSsCn+z9STO9yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=doOAks251f67vVyvLBuucr1Ho057+PFxViqK9scpnESyKm5IIYfyZSt8swTgH8O5CHIP7FL+dCLZDDbtabqKeAlnzUvMzl1oIhUl6HkI7HDVdxDa3kn6NJX1CJafCllj4m7ZFH7J2Yy7FfnHdyE5DZF4lxwAnSOOd/nwHwzopNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fveSsuS5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fveSsuS5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf125989f2so42619005ad.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022678; x=1781627478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gIZvWeafMBWMTEFvk0iicarP7tjLAo3+syklIyGGAE=;
        b=fveSsuS5bhu1JNVl5HVStxGcL6s7cRMlH6gNmSMGhr7DC5KvdmMlWuJmhkXr5cr5CC
         khKdXSk1iAhQ/mrKR2p9pS077ectn7dVBtY5GwWulYwtmIggouK+s+CNJbmnrP+4LgrY
         +As5Q5q/Xcls8H1iwZ69k7EtgxXAiSPjsZGefoY2n1OC92t0hN0dFMnaQzFFNrfrJcCn
         hTyzhDF9mDFvgscwRjxfRfLtIQKGhAP1UyOsks3Pujg5kILFqanoDdszUCdddKSv00ck
         pD2shozy7dYp5hrKzvHiPOkUbAIY5w27ZoakkUOOoQoVnZ+Yg+d32RhnnkA2GtBnXkkw
         gMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022678; x=1781627478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gIZvWeafMBWMTEFvk0iicarP7tjLAo3+syklIyGGAE=;
        b=bgbhIHW64lw/trH3zMsfRi5dAgsomaNcN7i4WjDJIX3ppPrnGesTs05gz5s/EMZw3I
         k+ZFBplV3RluPeKMiA2laRf+E8XhtdDMuK+l4yM1I4QQwik4TN9qWJRifVC4hQWo9QM0
         Q7Uo01WVjV03+0HQIa57L4JWtRhYtAM8P6qjs39alLak0w0kLjdESWv8PGA9O32d7yFm
         s8YjTcPCL/CGhqsVffBoeszXTs3NycP3uJfDDWY5wD62vOPfiz8siu6QQe7yQnxQ4p+C
         xKQFsoCLfz5nBcBrFkDxAXmEhXY96C7J3r14pIXgcH90kvfGyUYsuEgMj0AlljxsjFZr
         7p4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Mjc/4aX8OAUTuS9iAnRC/o7RVPhd9+bJcxu0I4TdovMaDcIpqTq3wl36rHdJ/MqWGEHQj1Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHy7QybZQzrQBJKtdq4RlnoG8mwzUQk68z/9eqgV0sU40Zrs3
	sNMbQliBMGqfmLeOTSo40lviq3x3THotlCisYo47u7aaDhfVHuDxyCRV
X-Gm-Gg: Acq92OHRVd8DkpipdQ9dGCksfGY9s7r8iDe4QyHuXCLy2Ui5t+uEOwATJv4oDtgINaW
	EP3n22Ko0uoNSanNF2fRl14CQ+xzhyanWIuLMv1uZH3KhSrXwff6TBHpZegL/QWhVv2EcK0/JPl
	bvaBgk7qHA2HfnQZKV2dky6b46Ye5YFkOF7vBBgvBQi1DmfK+EBFHD6S7pqNYKikJNZYXMSd4UK
	twglJeDYjaaTLztfHrVB9pjmG0hq4/PtcNLc4bNUB78zX3T8ayjaHiIuoGrgvMF6miNx0zA+LoM
	GPzHjOid/0UutmI1UcT3lr0LhKG/bVSkuLIB+KYbTS6m4YgRhnMpeSNolnQefZoWKxW1/IA0cTg
	YIa90lC2cCc8jtcEurlSzcDdxlyKNRY/WZyVsk/mWWwCWliH2PlDafXo/2kYRWTXVGGH7EpvXnK
	UA7zea9kXzLicKJETQPchC/s5p42GCAOzBflIVM1s1d1qXTzR23c3cGXy8oTQ=
X-Received: by 2002:a17:902:c947:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c1e776ff40mr256666825ad.0.1781022677662;
        Tue, 09 Jun 2026 09:31:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:16 -0700 (PDT)
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
Subject: [PATCH net v4 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Wed, 10 Jun 2026 00:31:03 +0800
Message-Id: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel changelink rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that creation netns is not the caller's. The
rtnl changelink path only checks CAP_NET_ADMIN against the caller's
netns, so a caller with caps only in its current netns can rewrite a
tunnel that lives in the creation netns, and it picks the endpoint
addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first.
For example ipgre_netlink_parms() sets t->collect_md before
ip_tunnel_changelink() runs. The check is skipped when the creation netns
equals the device's current netns, where the rtnl path already checked
the cap.

This is the same fix as v3, restructured after Paolo's review:

 - Split into one patch per tunnel, each with its own Fixes tag.
 - Move the repeated check into a helper, net_admin_capable(), added in
   patch 1 and used by the rest of the series.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the creation netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

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

 include/net/net_namespace.h    | 18 ++++++++++++++++++
 net/ipv4/ip_gre.c              |  6 ++++++
 net/ipv4/ip_vti.c              |  3 +++
 net/ipv4/ipip.c                |  3 +++
 net/ipv6/ip6_gre.c             |  6 ++++++
 net/ipv6/ip6_tunnel.c          |  3 +++
 net/ipv6/ip6_vti.c             |  3 +++
 net/xfrm/xfrm_interface_core.c |  3 +++
 8 files changed, 45 insertions(+)


base-commit: 0aa05daef7848a5ac11158949dc73cd741995dc1
-- 
2.34.1

