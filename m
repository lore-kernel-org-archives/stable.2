Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1C49553A
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022694; cv=none; b=uVF5oHaz9nMywLaTkU2T21/Thi8ohYam4pAW5N1/+qYr16GRUiXL6YgZMvufggsZzbbd4LDNaPAgbEOEQS7sGzb8Ko1cWWEVsCp7D4NmNqbhNUK5BEMft6mTlGKSaniPnaMWRSzX19pkb6kYttuRkJdzItmJtyNu5HXqqhDxUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022694; c=relaxed/simple;
	bh=9CeSQ65EFy++LfGUh9ogh5aCzFhQ1qyM6WnEMY0Q8zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMfMgJFQ2Eg/LmIPtGwZYireXyPrO14yMlLZcjVgDsNiX6fJV6kMc5B1uhmWm5pa206N+EuI1N0nyQDp8ri53zR6/C5vM6gp4FA+z6UiMbH+Am1fONpxnSF1hEQWu2OMij6E7uFJ6zWPdQOUSzZL/efKqP0/0HQK3yZV1lLnYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AajOKwAi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AajOKwAi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3184c71so44125775ad.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022693; x=1781627493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/NUtWL+pGSdZG256FKpKppSfEdak3fTDyGu+gJY7Vw=;
        b=AajOKwAiXrBCsuRnXG7hDUCjLxFkiy0QtamciUoMbPVBSHg80MJMqHMHHIxFtC4Kp3
         jjrZ01g9uI1ZvSa1PHn/MlU1HF2bpk4NbdzwZD+wyz7LEaKlqXOK7+yeKEHpRNV71vDg
         e8SHdFyWYkDc05DOMHkD5qZYBqRJRlGL19y9qWXPP2bfJL+KOhKMOVlnR+Ic4cld1dSu
         +bJaVOjHZwxIKqpNnCiXucleIBDP5+ZbaGtOKLPc6MIV+FH4GDe60cT/QygWQic72JXE
         ijz6k3QqUhEdsdHLT4DW6NS0JlNqixMseVk+JhwhHIA7ZBKtQz9+R6K9vvTn1vqcnbwv
         OQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022693; x=1781627493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/NUtWL+pGSdZG256FKpKppSfEdak3fTDyGu+gJY7Vw=;
        b=n4SuZ+aXBbM1sBIMWVKciJFauu6Iyfl0Dzy8JHmIvvWbwI0S2hiSPTnHIAnZN7+p1p
         jW0zKj7Fvo0D1UOjH+Ywadwn7VNbjCX1+DZzY5CG8tGra4UpbJBRpnxiT7bS9u5sVpDZ
         LCP99hqDzeGv7O8vmj+Z4tqcAajhjAkbWsyy7MazpHHrWfKtRorA6yqXONUy8U32CK9H
         LU+2q2g5hWIffEZmt+2X3Xz75JrIEYcWDPU6pzgvURWxgff4lGJCxIrxsSTVasyR9Zm6
         H55C2KNaNHVcKXRrQ0VYIwg7JOPIKYl4bnzCnlGjdV3GJndjhd2g1Wwl5E+fOS9WqHKJ
         9tyA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ga30xrYmCrMMVMMTX0UHKc0EY/DbFMHxuEbdSAEhKdHE1gY/xu/orEYn2z+Szx0bHSGsyI7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AMdDwOHSo3PpMiLlhc//vG7yqkiCO6AzA+0TnTSal4KVCn6i
	Hs+qmcxlDLT8JJiHgbfCvWToGPr8H7h7zV00aZZc9BK4XrYZueZYPnPP
X-Gm-Gg: Acq92OEwAGgJm+so2PLmOCCw50I8zPpq1i+Bi2CKpncRjb/M6eAZQaYSq+mpD8k5EGx
	mtTpjdunaPrEP5jp1EI8ELolQR63t+/dMAaEFZJ8en/WrawPV/oINCN2ZIdzXqI6y+Gtp2LaJEV
	EtxH6Qzc/W4mtjZgozqqiMv2bliSCKRRU1lX+C4fhVTerxtT39ff9QI2TAcpAUzhljXRh3/K4FS
	kWMCHPepi7Bptkc1gZSjjaoKvUJ6RFlpgDwXgCMQq8Ys4wy3UZD+VZRwzHaUPAuPC4mhR9tsj8C
	kxynCuuR+uaW4gge9yykGtWf4RYOfuKk7+O41fMzA9TbWnMmmASQa1af8MPAzBL40gN8hRgJmM2
	JXbOUiZ9w4B8WKoitcjWz33LBsh/u2dT3TPUlAxSRJRF18/odaDwbVL+jibJ9ziynBu0vc2CzvK
	ixbJbhEVRRIK73u9i6Ivzn8BYQR6jWf/9AsyN89Q59Uhu8m+SSXTeW+x8enpc=
X-Received: by 2002:a17:903:2a8e:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c1e83502b0mr303154615ad.35.1781022692635;
        Tue, 09 Jun 2026 09:31:32 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:31 -0700 (PDT)
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
Subject: [PATCH net v4 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:07 +0800
Message-Id: <20260609163110.1717419-5-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_tnl_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..5ff8e057fb1e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!net_admin_capable(net, dev_net(dev)))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
-- 
2.34.1

