Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3F4968E7
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022698; cv=none; b=H/cd6bM7cLVbnX6NNFp6tUyuSj9LGfa7X77/nbU4YH+steKsLahsHNliPrNVWn29Cju6miAK1sRbQIQOC3Li+GbzBpbRrHDgCPaZ2vE18TO/NqnJDGq34PrfwGVz9+5O3KwRpgpLix5rHLnuYrEk04BMXGwZnzzcWyXeV1BIT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022698; c=relaxed/simple;
	bh=w/92rqpxBcjX7hp01jRGc5Qwva6xnPaoYP6bbl5lgnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZZ9mGBCP7gQ9jRG7T+oS+0zV2BV5+WkSqxQcGmo0Q5vg/HPE07rMR1dA4UCZ+TL0644hvT9gdm8gAIjjWhWOYgWwLaLgGcB8y3r52Kw5ykWNwM0juxuu/w8jaAyIoRS3wKj9YEOPZU9h5vAeJGy13GrhK5xdSaBgIs1DQk/ZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRUSwy4O; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRUSwy4O"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b9d265355so3504925a91.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022696; x=1781627496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBNB2vRgnwcfwhi+Xg0KULzMXGMj4ph1wDI4x7EyfeE=;
        b=CRUSwy4O/t3xNUyPhEyrv7OPqESyorVeQEJD+oWwOcio/w/TnfOyQv5QQW5N+QBr1A
         eywfhgBY0YYydFrTwHIhAJep1EWhRlkwGgCFaTJWlu434C6dS9ePP5xe3U0gDh/kgqT4
         JlctWmRcil+F9Q69tSWTTuQeg9d/f9Es6W72/iO1UGblIf+/VYFYffZdBAksLUxyDjLT
         FTKU2BmIRcXECpfuHVfudVl7FAA5X6zvCvoXPQL0G7UMVaWCQmYVmssEUp/SVVc7B4No
         EwDq9eCVd/0AotyjxPyt9ITKCuiClSyKz7sDota1ssHJShoCvdD7c1YXdjo3Rc5o0hrS
         KlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022696; x=1781627496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBNB2vRgnwcfwhi+Xg0KULzMXGMj4ph1wDI4x7EyfeE=;
        b=MtwbmzcSrc4VrEqalA7u1nGDFPgduO1c7pT9yqHpWqbuGPrQ25gyWaSxV9cKhOf8ZC
         Hv9+TTKoVe1gXLrjnxvSPnnZqYK/ptJeHTDrZW4HZYT7rvPys4/HFOcMT7nvXvfOwYuv
         r86PfAclZSDr6Fzou4ISfGKjBom3Qq9/tUKnrFxv9oOqn8EUbEl85fgH8SrrV35WWtkf
         /BQrBSim+YecrOf+WiCYsY2akyoLlyZxQsYQ0S5qgC3PYubZCP575FLuuG/uNKPvGWVi
         o/Skbs/LnCrvsYywAzRnXhoUKd5m6PZ+R9vjhYokL+GI/Df0MLz7UzjL22IDNpMKwMFf
         0ARQ==
X-Forwarded-Encrypted: i=1; AFNElJ/s9oNA2Pc0Ru7LL28mO5qV+lWCNDa1+sHAAlM1KN/oHdYzenmyp2KXIGfUuPndvGu0Wnv0/ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbZBs9dBMswTPqKQGaMxFv+K2sstxVm4PBfwMvUtpHBDQIHkH
	nxif++FPYM7eC+FNOyQGZlmP4rd/n5gqhJifbxG4F5EfykvAg2mbN1MB
X-Gm-Gg: Acq92OFncIvkNOOucjxtYeZuOwcOljLdGLI4ILA9hbbVmZmQpQCBh/DHcTX9n1JsBCi
	zw1knyF4QN8G4DpL8OSk1lau9cwhDCqcPwOPYgYhJQrgrTbZRdDBtua9Ir4xVccksLJo0zkFQXW
	1qn2NECgobogX6e6jjPWY4266mom7YuexxdvMCPH+Cl3WJwbCj6h7dF5NCap0iVQt4+uuzGkyU4
	cJJqwsPJWoMrQY/wWkdAKXI6hLA3BFs7jvMjKftWJD/W4me19WbR0ebbnMiIqIhXCTe/yjjbGKH
	MUgP0uVtnhNHs63oIk06dNppLfbyiOsx3a9sAx46MVt8gOISx9kwI9LqawHZIRoWST2DUFSKmkW
	1su5BiGdGdAsfPSgdCBuAnqoEQotu7+j0zg/uGq3A0irory/QzeObPtkTyxtVqPpvU3pmkvuKcz
	RDgA9EKBkp6jwuVjReUDEIZS4nb2aSfipKpqBlpQASyVSXGEFuSBzMpPxqiV8=
X-Received: by 2002:a17:90b:3ec6:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-370eeff5ea4mr23914086a91.9.1781022696271;
        Tue, 09 Jun 2026 09:31:36 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:35 -0700 (PDT)
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
Subject: [PATCH net v4 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:08 +0800
Message-Id: <20260609163110.1717419-6-maoyixie.tju@gmail.com>
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

ip6gre_changelink() and ip6erspan_changelink() rewrite the tunnel in its
creation netns. After an IFLA_NET_NS_FD migration that netns is not the
caller's, but the rtnl changelink path only checks CAP_NET_ADMIN against
the caller's netns. A caller with caps only in its current netns can then
rewrite a tunnel in another netns and pick its endpoint addresses.

Gate both ops on net_admin_capable() at their top, before any attribute
is parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..829388d7b870 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1

