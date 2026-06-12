Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7138333D
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254803; cv=none; b=rVMYVosmeM6ZB3qnSvmBFBs6tsqrfkhrpm7ErT4g8uboE5l9aIKLJnFzCrTDzQLzZ5A3e0hNkYjM/nX3jIDtwyr9vb/1cw3iE7BLhFjjSfkA/2L4REwsfKGJCXGUgiQmDREuVeGQARDZltZUGVUNRhzil/3N8Y/rrUUFGVYJmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254803; c=relaxed/simple;
	bh=+MtzfQkD/z/fSBvbWuIvx0eWpg9+Pm7DJLCS3YtxuCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRxXwFJwCzfDagK/ArBmyhPfwuGDJgRJYG+W4p1huRz38+Wwxfq3sOtM9lXPexOd4aZ+x+9uQtC5bO+ZiBEQXscgheJaWarxnYEUdd53JvNgkajku9aUvTP0o2cIHqtvo/SsUBcDIY0I4HkQB/3Yq7Ekwjvn53jerguHxxACoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBtUL51l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBtUL51l"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84237c55ef9so563230b3a.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254801; x=1781859601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2qINeyPf10jAgXQZLfSqS4XHQzzQiX47+bouG75nmk=;
        b=GBtUL51lwgv3+9SBp68atBKcQittHZvjIPF/y2hp+l5ylzVcgS+Di5jhL/fRLIBmJk
         o0uyrHArXtl3FP3b3ZBbW2+/5+dEdyAiSdIe+suv6nRT7uAtt0mUGdCY8vxkfusv+nNe
         5qRIQFBGloZnq28xMh1CYesmZfhvMoJrBEPR3SwKFMjhVt75cE9ufwY3Q+mvqaWFth7y
         eU2o5q7BmpWhvCxrRsCkGFDO9TusOGCNYFKfGcFlG6VAK0pH/QEpB9eFIYtAshQvuwnx
         mzj6kHx1dJVUXQLn67lqTayNgOM0Mi6oM77arLUkVo63pvU7Ek6SF9KOqjFhF29Yt2Q1
         c87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254801; x=1781859601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2qINeyPf10jAgXQZLfSqS4XHQzzQiX47+bouG75nmk=;
        b=ne0TC3M3r4tX1I71fOP729hQuKHcowHaPan6VbLbdag58xTxp4R3qVuDIjL/7E14GI
         P2t6G2XsUdRBAQc0PSt4Rdg+bRWqOscX24nOdhPrCWgcGqeQMHA3jbgO/gSzZThKlCGR
         5j2fIz+/Vy2ww3cxo8k+9H7SGrETHp49u10Ipie0amskCrS5Y2rbn4aBamGClhwtC66l
         xGn1ZPBOefreQK9vuBBxYaq+Zgo60vcinuYUavVY7m6evxg5X3SM4jWQueTCQYvj9i+c
         VlfRiRBdNC6y2NvjLTNTvtTSw8YFGfE7WSQ6j7tNR/h+rJHCOa83C6bmqv6PGqZY6aHB
         nNnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rXqwKDSJhrt+Iv+j4nVSQf+ajnKGOrClaIK5vUEyiH6g5ArH97OBvizHformKyku1Be3nSjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9SAu/Ob4ZtX1SnOzkVitJ0H51XNyu+ZHrn5T5ZEifXT6nl/t
	XXsD3nLW5rubYpJfynYgIDf8xMTl6v+xhXtZxppBeIFaZBdZJYPJIPLO
X-Gm-Gg: Acq92OGmlXGInhaBfUTGhmI1j8t55oUarFQTCtjpd0dlWefwg/tAiyUt/3LD+zzD1Ia
	uNuYH4jEXbWRKNkUwWrLVpEdDkitA8J2m7cnZBfYysjTCTvvj2eVdDJgUWgtNuE0FL4CqJ4hWax
	RQb6yNGnGJbLHiYdCLLC+kynqz9icaJVSLnrqQMAWetaN6b7ZqYoN8L+6jODb4Nf4vNJCU748L+
	HcLdCei+06mCqDnyJrtaU451O2HiYHbedAT+0xyWjWx5RJx+MU017jZxPObYQMJc4UTlkhbXPJh
	RUjVYHYHFnE+sU0RNbuJll8fSnW7NX+J0fsa6fovZF+vUBAHG9mdzNlkzDqDJ7kMQbXejXmDU4L
	RleZwmnifZO2dYKptJYEihPEni4zg3XhWO45jv+v0J8uRObOxwph1hFiRckxGSmxYYVeweca+OB
	BDFisAkEYIs64xQoSyKPEt9k06MjU0B/n8MrSTZalf0phMj+pqWPHBPw1xJ+s=
X-Received: by 2002:a05:6a00:2191:b0:842:2f28:4e36 with SMTP id d2e1a72fcca58-8434cd4ae2amr2162681b3a.17.1781254801309;
        Fri, 12 Jun 2026 02:00:01 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:00 -0700 (PDT)
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
Subject: [PATCH net v6 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:38 +0800
Message-Id: <20260612085941.3158249-5-maoyixie.tju@gmail.com>
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
Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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

