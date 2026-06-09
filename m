Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6F43901E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022683; cv=none; b=I/tW/j097NbZT3EZk/9Ubca/K9I2WQxqkyF4osVkxTl3GD0D2k06J17H3JMaS1T56lb7IW/r+TVbWQJj5onV/tQ8vplxBZJx86fR8SiXFokQO99csnmeGlBXJmhFUkvGW72XGlcaQgBDAM5dpaiQLUkf+s1xG1e+D3kcKGTjQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022683; c=relaxed/simple;
	bh=rIznTwLb+grN+SEa4jmN1Kf+ePS7qTBPFnyTDfo7REU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQIycTqREZ4uh3AFJkNT6/hkM54gIAc2PYKhFSKefkHTUg0gOkdjbCwWlMmav3yxhtqA9b2DMyxNpusmPWLXcidwZIOOMOsG/zy00DZ8N/lwf+QxXkFHGSo+y1pv8Ywp/9HrwrvTjrlYjtZotBtjNRhomT1x+zUsoqEr/KhvoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwydTfql; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwydTfql"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0aa420401so44733055ad.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022681; x=1781627481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOScBN8qzHidY1x3Y7+FW8ZQCw6XnOMJJfJFMyByHk0=;
        b=hwydTfqlHJfSLNmf5j0KG/3V/OJCQPoj1Izx0Pt/mehPHG1lafPm5iehy9Oz+MCY08
         wOBfKzhXjsJP9LetdV7iLu4IoxNlCPtcVqlPEK7NZMbou6EUjENz3SoR4ZhzaJrFWYv4
         G+DOd1KTIxfOVdupUD6emfeAcvzpuwysHETOGus1WcVNCVxnHvpGqctzlymeavADNqOv
         qbSJ89styy5c1h8nnb6w89J3CgfpDTrd4u4uZDZylnpTzwqETehekdnzlza44pSR2E0q
         ZJxazG3z8v1ZJhNg9zedC3DUbdtRu2o9xgVE3tsVFEE9r1wNiLahlRGdWniGuPpZaLh/
         EIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022681; x=1781627481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOScBN8qzHidY1x3Y7+FW8ZQCw6XnOMJJfJFMyByHk0=;
        b=bK1PyrtaNGi/fXhFb1FKptDp/aOgr/9tTFyL1F0qKbhwDKWFFpD/ZmakRVLN5Fa6J4
         UZu6bcKWtfnz/IlJsS0znLWzfHiUZLQOPJpCyQmWhBYxP5PbP5r0rqTa3nKHkbgsQkY7
         X5kuK/zBkc1ghhdl2aYJmaHCx12MYmpJF4hN16ibDwUrRieNXDs1YTCQmkOi1iAoBPX5
         evaQzRIf9DaICPcT7G3P100X+dDgTdK/B9bQde+gaVWGaYQvaDTBhu9i+qI4gQMXy0b3
         zotwRjRLNl3fbUIaqZSI1cl+KdHj7CFL9sp+At5M1SHhAk29nQd3EfzWheeo6KSutoS7
         HLLw==
X-Forwarded-Encrypted: i=1; AFNElJ+6DwQGkFzCAD6p7aoAGRU7n/5Kf7Eeiue22bkY/JYp6h+KTugwX1UqOFxc3SC2FH2X5AmbJBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xIFuxiZ3g1XGj37b9hDjFkD61+/xoJK8jS6NCgfur6S7Nl+D
	INx7cAyzQMxYIp+fpQxdiDcwX3fn6Mvo23yZeR+EL4uxvzE5sp85fpYB
X-Gm-Gg: Acq92OHjGx+I0GmeO/BLsrDa+fTAoSc+sgDIjq2SR2GyvCk60fLCK6jDUOHJKmTf/Vt
	4+bMeHODwIW9WrIWMXX4lrSmKJtF1TjlpBMLLEyoCdT8BBK89yK0scJOfJatM7D9BMzy8SOLj/h
	c2ZfvYN9v638Hj3tYh5XlMf54Jh18WfrNx/qZZZVVwRPi+ivDqnOzjZAJzYcCvYE02CPo4YSOwF
	xnPg7nR736whJYP1awtSxisqNGVHjwvvFZK/QkUvZxoICnZaGiuPBcPTuxGWVKt3DKqPxzZUJBc
	1yY90FGeoL3mjPg+tw5PamADAMj5cE0RmJCAH+lnIVKEcIo04DFKExWG7K+BQhd3eX0rsi7BTmS
	e9qkTuYHWPNaHbXeVBro7uRB4m852TapfmoIyK9i7FyetfJhmYSkb4FV52WLwGkCobF98f9H3V2
	yf7EX1bzrnNv0hEJ3aDXyxouElJw1VCYFlDZvlM1L9y3RCZCTBjfErW+m9+6w=
X-Received: by 2002:a17:902:ea09:b0:2bc:8f9a:3642 with SMTP id d9443c01a7336-2c1e7e6eee0mr235696225ad.16.1781022681487;
        Tue, 09 Jun 2026 09:31:21 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:20 -0700 (PDT)
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
Subject: [PATCH net v4 1/7] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:04 +0800
Message-Id: <20260609163110.1717419-2-maoyixie.tju@gmail.com>
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

A tunnel changelink rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's. The rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel
that lives in another netns, and it picks the endpoint addresses.

Add net_admin_capable(). It requires CAP_NET_ADMIN in the tunnel's netns
and is skipped when that netns is the device's current netns, where the
rtnl path already checked the cap. The other patches in this series use
the same helper.

Gate ipgre_changelink() and erspan_changelink() with it. The check is at
the top of the op, before any attribute is parsed, because the parsers
update live tunnel fields first. ipgre_netlink_parms() sets
t->collect_md before ip_tunnel_changelink() runs.

Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
adds it on RTM_NEWLINK.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 include/net/net_namespace.h | 18 ++++++++++++++++++
 net/ipv4/ip_gre.c           |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 80de5e98a66d..17fb71a78cb6 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -358,6 +358,24 @@ static inline bool net_initialized(const struct net *net)
 	return READ_ONCE(net->list.next);
 }
 
+/**
+ * net_admin_capable - test for CAP_NET_ADMIN over a network namespace
+ * @net: namespace whose state the operation would change
+ * @cur: namespace the operation runs in, e.g. dev_net(dev)
+ *
+ * Returns true when @net is @cur, where CAP_NET_ADMIN was already
+ * checked for the running namespace, or when the caller holds
+ * CAP_NET_ADMIN over @net. rtnl changelink paths use this: a device can
+ * be moved so its state lives in a namespace other than the one the
+ * request runs in, and the cap must then be held over that namespace.
+ */
+static inline bool net_admin_capable(const struct net *net,
+				     const struct net *cur)
+{
+	return net_eq(net, cur) ||
+	       ns_capable(net->user_ns, CAP_NET_ADMIN);
+}
+
 static inline void __netns_tracker_alloc(struct net *net,
 					 netns_tracker *tracker,
 					 bool refcounted,
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..040a0ef95184 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1457,6 +1457,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1486,6 +1489,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
-- 
2.34.1

