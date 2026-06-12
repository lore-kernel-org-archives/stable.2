Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F1379998
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254806; cv=none; b=HpUSilxl3f5agONQntQGq2GppL7lNN0Ct5J6UY1mQwJkZcb/obGVSwoQDhfAdtDULYFTDds4/a4q7TpaVPwFdyPDfETWfjEoXn2MEcyum/AyWMMxddw7rqG6EH8Wk/Yec/stj03BPJMEMjL4YAT1ed8tiaU8OygxeVJADCbmGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254806; c=relaxed/simple;
	bh=c5Ovqn0fbu1jXKNfhzl7xwQ/WtrZQNup6EQ6zkDC9cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnIyrkJCUERWvDGt9ux5Zzzc6HGMDpXcnG4pjOePilWoDj6YjdIeCyhEy3ZGFGatIo9MPkojHb2Cjr+pDulB6RFgm5o0j/+3rXu4gF105MMvKF266GIhfILPD1XRAE4CenlaV0hzrMFEk/I5pSTiejafF+RR9L4cNSzLZRK6Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLOmaGh0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOmaGh0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so497285b3a.1
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254805; x=1781859605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=islszk4qO02xP4bfqkbmrVfs4AwnzsoexkuUe8m8IY8=;
        b=eLOmaGh0jKlwz10vMJ117BuOQrJIev4xUUvsVjqv0nnSLa5folZr0isSqlyu8fGalv
         BhgR8zDr/jh8EIyCB1/4GZqEdWGmuqxC0TxWKyx2KkvYpnQQ4uYd51sK53fV4Z22jbRG
         PYMmDgLqbTkkdYLyPiiUbnpBD984AVQFs9U11W9z9PcKqK7Ig+OXXz7RPOQiJJdj6p/+
         3akW82T+DrV2ZOk2xYkwTovBSQNP6r+7nF53ihya+QMdCxlZg01ZSZt+kvYMrTgzqtut
         frvAweGzELedoOco9Z7rU1LPPTeb8xFM9+URZOIMXaBHU0zMZSbPQQJ1KAW0Owv+f0A0
         0aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254805; x=1781859605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=islszk4qO02xP4bfqkbmrVfs4AwnzsoexkuUe8m8IY8=;
        b=Js6gZn0EdffIEsFEmSS4nesyhBXa09dt44shjOPKZR7T1gkzI/ds0lIhej/vFepKjt
         P7d+ZweuHeJ9JKXYRw8bbKEHDlVyo43MQHdUu++2v5tJAnslniRHdRHPPk9HVYzkeXZu
         LFmrkGzhStRuQyLC+GrMJSvycDAFfiTDlIclhy+g2eDse7/G/0Wxr2msmtSJpY1QqxVF
         MPMNQg9O6wbQdzijh6AFVD3ASpWUJl4MA8sSTE1hiTH4tQd9E7c+34m1krkTf0+iU+Kf
         AYq6oS8AN3/Bf5YZh2RVrx1bQRYOnCR7e+uYL3oQ4Fyz6xRIyySzubZzyUwZoDxatKeE
         gCVA==
X-Forwarded-Encrypted: i=1; AFNElJ/hLg6aX/fL6FFoWby8P44k16ggBKYfJuLPWxHNQF5w5NRzjs9pCIHiGhS/x5w85PAqSv17uFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzfn4k8TX8+r+q9m/KWqeOTOObsfOwNh2DRI2LGXlYP9fhdz1Q
	G4jkpexZxXjC58DbLz0UHoJ1uoqgwYwuM2UdDIvGF7W4/TcGM8TspKKaiPJM3w==
X-Gm-Gg: Acq92OGPWOmb0kwzeQRi66GGpJCoWD9OjomUIMAvHyFdnwpD7h774vfi17cYvBu/x1x
	fdlElm1yV6rboFWXnOGuDPzGywdOSySevX/egSpKvAkrS2qqm9svqUB1YuW6iB66Ea4ClTS/QLo
	LUmHwsHWBQgcL44oFqMI0+o7TlYMF3jgEq40aEoPT7zpliaMlltMZUvorGnt6ZNsdy7QpZHW/bV
	xWWUJzw5dPYnt+idWyJbc0H6ejthepr6vdg4UG/nKsA8UjnFa/hq24NMDQFEiocOlNutnhgOLb4
	NqRS18/0B5VtHFEcV+J0pXGu7jDKu0ARew07sZ493VBucAt+ruHBPRxfgXyUvo5+fAneObsTqFr
	tywRdoqAPd2uQE+ucAemJv6onlNVAr0uP3mt9N7T+zPA+EFIGmtxoH6GFJpVSUIPt16wTfFjP8y
	iZO+QsOKZNB0rz9ky7cAF879DBSXqb0IIJjVK7SrismWzDsZ03
X-Received: by 2002:a05:6a00:2ea5:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-8434cd5cf1dmr2207276b3a.20.1781254804923;
        Fri, 12 Jun 2026 02:00:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:39 +0800
Message-Id: <20260612085941.3158249-6-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6gre_changelink() and ip6erspan_changelink() operate on at most two
netns, dev_net(dev) and the tunnel link netns t->net. They differ once
the device is created in or moved to a netns other than the one the
request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
against dev_net(dev), so a caller privileged there but not in t->net can
rewrite a tunnel that lives in t->net.

Gate both ops on rtnl_dev_link_net_capable() at their top, before any
attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..8ebc99a299c9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1

