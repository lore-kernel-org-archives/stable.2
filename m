Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069631280C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254796; cv=none; b=c0pTyGLqu60n02GU23lSH7ipjt6dTb+nnvPSp+GuZJ97rg9M4xeL40wAjUdstVQNJZSfuaAZ2r0ojaS3qYSsbLk96wUaCYRYlYZsa/KCYqizGgwOjAyDpLTV8VZN0qgojXOL6/KtOTRpOi6V9G9VO4OLtrvX4iduvTUSGrxULnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254796; c=relaxed/simple;
	bh=9KELg0fF52vLssDqyULifU6gVEgt2TGPTvM2ovfjH+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtXqcgqiyEfKu71laUHcnxSQPPZwXq3yuXvs13NYMyYZQcwe27U/GCuYSkaolX1m1mfTS6Wl52P5H1B6mGSJTI7QgWLGe7oV1NBDUh03VrDwuQtIzVoWxHaql7hQJdfqsiCKfmyuNubR4aKJm9tkWMVQK1RH2llLQyBLhyk0neM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwrQt5Cy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwrQt5Cy"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422f395a4aso565807b3a.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254794; x=1781859594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kTdniclDK6QIUDXwqEIxG+i53yHxIwhyl42LN144xs=;
        b=cwrQt5Cy48rJw6j8NEME6vSlVcJkPUcy7s+siaCuqjQkkEWZjhqboaOgN6W/r9t2Pl
         5xGQPwVxN9zwx8whdTJHHnzxqM5qe7MW/lFAZ0UJK0hXkxovaheirgUf5hWGSV4PI/0G
         Ojx1/jqByRt0sJPAwrlUtEZOUYcH8I815lQnTJUhvmmddOTSS6o5/KlyDHZ0TOKwqeJS
         yTD//4Gdp4TqvsTtQlku8hMU/RH8cnam35uXQDPQjIz065vB0j9NgHuT20O+TzbPu4ge
         i9uk39ycsnJX3t5lqQbs1RIkG2npVhMEXtdRHuEMHjSH9Jf3Gk3H9xyxBjWXXIfrxgvq
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254794; x=1781859594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kTdniclDK6QIUDXwqEIxG+i53yHxIwhyl42LN144xs=;
        b=tC0uk4ee7iM+mIegy1Ycj2byTxTvpvvZO8l3bLL4uoNCkMdQiwle+d8PV+vKIBMm8N
         RSdtdKcRPltcf//GEk0WuJdY0Zh5IEHrV3+K6PBZkN0odKgN0CdTuOrAP/WQWcfWUJYl
         ipHLkqTigi0Xi/kkPZJZf6IbL1x0+pB5vAUaiA3knLTzy0HjtSf5v2FQMhPRsy8abgu0
         ThZ2Y5lT24p11pYKwdw6MY3MHVtMUtg3tKEbcWQzFq2mB2/UfYL8lBtpvtaVzVOQ++nD
         g9Aly/MPpvC2TjSUIoFfeEHcJszSw8kR3K51peJu2bAT3Cyk9FOqPhyGX6CvspNWx0ep
         Cmlg==
X-Forwarded-Encrypted: i=1; AFNElJ+58PwWoFoArWDaoZ/l5HqOrAfTtMbCChHY+BihktMF7v9BMvJ/17JQrah9ToVFlLwgFFIndIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Qsl+Fc56NW7ofiCdNrZQbv2DMAhr+JgMfj7amw7Qpqd4YCfy
	7+D3SZpaZzHkhVIDcgeJRk1oP3JwhMez5g1B5QbPYJS7iMt8U0zC5zjc
X-Gm-Gg: Acq92OFE9BIv1GVGduVTdd6zx3BXkj6fjej0KMh16JO7OHoVsqfyzohKxkXj+cGHRgN
	dzgiiLUVqBO/zvtO6xcA6eyDoWf6oPEPGcpiWS3vJkBqcTN52VoRX3y05sJt4b2zOCSyPrMmDZU
	bjv9PoZq7icy1Q5VL+8mRJWz9k5WQQYlKldl+QTADkyrIIahvWuiI1LAl6AQt6rzZiYfZBawF/3
	V42cH48g2f7knKzZ/OIYERhhFKq4zNSRCt3mBQjd+kD83uXHHRJxcLF+XePV3DGcUE89LYWmDmR
	JwkBDqYGSsu6FzMFle7+vu4Zt/BheLrGHNEB5M5G6qGhCRPgh0zE0CODjpUcn+ijm0g9LBr1/sc
	x6BNJdTki1rz2VPmKC5yOmYoR7HfDh6ARU1IiFo7WM6Bp2whVTyy2Mi4dw54JTS5ux1sT/eERXI
	jFvJI5//7iq3b1kAw8LYxQsPC6UaoxM9r5TcqUJxXu/zO2m84N
X-Received: by 2002:a05:6a00:14cf:b0:838:5145:c1c5 with SMTP id d2e1a72fcca58-8434974f482mr2183604b3a.21.1781254794144;
        Fri, 12 Jun 2026 01:59:54 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:53 -0700 (PDT)
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
Subject: [PATCH net v6 2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:36 +0800
Message-Id: <20260612085941.3158249-3-maoyixie.tju@gmail.com>
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

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 6c742e714d8c ("ipip: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..e7378569bd5b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.34.1

