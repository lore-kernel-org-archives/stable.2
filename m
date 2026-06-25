Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6A37DE83
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375915; cv=none; b=E1VxViqIS8P6afZ6Oegi9FumbgGDgn9uFL12zUxh3pRgI0F7zwZN5dTnNnNWeRkHj8nlPzyMq/O0AkXEVDeIV4ud6EHITu6L9IMZ/dEeWR309nk1zdNvkLqd3y9f7417hoUkradLySjgl4wFx1LXZswtZZqSU3LJu0sKpRmqqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375915; c=relaxed/simple;
	bh=FttxWcQB/hNn+4s9v0hsj+DpOXG7C6zn1XazAFM7dH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D26eCnLmRqwMEktKt6mwtMjUci5E65mr+yc/HlTy+Ru/BMzgcJpw2u95qioxvdbguqcbI8IXghmIzoJCTTQjv9h/RxGXFAYzActFkKGejg3IfBC4jujl6t/VubDbPtBQjqzJHKqdJ4cvcchF4JuLv4cBZpu3Yde6OMNg2YJWss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxfWE3wX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxfWE3wX"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so2022587e87.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375912; x=1782980712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNsZSX3/QBjqrDIvX4drEF9Odl8RtjkKP8nQ70A9iWI=;
        b=lxfWE3wXOPqeE/e51favXN6jlbuBkWkaWVrfdA1/4TTbjaGumbP2VPamidjALhrg5e
         caq/MgRnP7+INT4a4QVtS6zy8yF7n4qNB7yR4mpgATEMF2/pfN0bSPwhAF9V+cP8y9Ki
         aN1AcuTMN3mfUY3u6c2nY7gTQ3CSFziVJlaRrXoariu8wIIzyurG7Ny+qQ1TNOuhVt2z
         zmjq53KrcqIR7uqPBiKiLNRxxSG09MLt8JNpcxOecYErnmsSwFtMMlcWZ6dquyraQ5UI
         bqdrEGsl0985UBaYUSIg3DtoRbIdd7Zj7Qe4BtBjzKtO+9AD1X3vyCK+EiykwvwZ6bM7
         2Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375912; x=1782980712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNsZSX3/QBjqrDIvX4drEF9Odl8RtjkKP8nQ70A9iWI=;
        b=Z6EXyJ0rEsHiCf/lg/wPmuSxcht+8m4oKHlT9yW5UAn0s6eStw4A3oeXgyaeKqPjfC
         INSlDSEp3yaWmkMM6UcGMd43BqFNs7C0zzBlprVsA8M5aKmXZzZSxx/TZX2xUvb3saiO
         KQnsAQl6kMZDeJFb5DaFLXlXGjNnNW6cGDAv2wSkpPo/HZkL9K8zuiusbpJBbGSve9Kw
         GqxK+D4cQx7dOiPAoCaN84+5JX+2NGePNInNHzXAnb7v8jN2/bEtxcX/G+3kfSm7GiDR
         QnPVqGwD78qAz7BzOR0TdLmLKF4vzSxk62XhzIUhzkg6ZbW1RGSHLzkipK+ie0KVQ5rj
         fa4w==
X-Gm-Message-State: AOJu0YyMO8OcgwiYYFSfEjLEsd2EKGHI7EIaQ4fXn6veeOFS3h8Amc8h
	PfAJKLKMsxTUojH59IrR9Uv61zi1cyrjE4YRxw6UAWjd1jxz6+aFHRG4ZWdtdIKrXjk=
X-Gm-Gg: AfdE7cmm+suRSX0sVnHztmaJ97vN/Jn9kWw5Lzu2VdqsRtA4oLKmPDp+5w81Z04flLF
	Dj8R9H4mkqhT3x9RSPQve58ZqHqkZ7xSYdaPou4FDushL32uh0Y2awXntd8XmPyBoyyH6OxmJ7B
	j3mOkTVO/bsH1xkELVNfzJ9RCDPBWIwtZYE21g5O3sj07bXgFUjKL8rH7QpixM3CEk6aN3fLAX7
	CYlQl6egeuZ8/2lyEmq3Q1Cha1e5aQyNP1ptdkBIpLqdy2EUpGYDBGJIKkUuVdAo8QM44oJpH0M
	WgFElERZP6ymqPX9MnqQbasMslulU4HB93Wg2Yo78ymu90hzVYOgnAzRH4b8ogGrGLwQy+HUhUK
	lg+v+uWTtTt7KodxDm7gAZiwjjRgyMQ8VYr+9moX4eyOj8i2Y0XKi3F6XfWa/t0q/robXgRIoAS
	5rdhFP7Hf5afVqA9Ccklh/NaKP1Z+N
X-Received: by 2002:a05:6512:b8b:b0:5aa:6df7:4eac with SMTP id 2adb3069b0e04-5aea1f2d8famr531570e87.20.1782375912271;
        Thu, 25 Jun 2026 01:25:12 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ad31a81adsm566391fa.28.2026.06.25.01.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:25:11 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH 6.12 1/2] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Thu, 25 Jun 2026 11:24:41 +0300
Message-ID: <20260625082442.96390-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082442.96390-1-alexevgmart@gmail.com>
References: <20260625082442.96390-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

commit 6a7d88ca15f73c5c570c372238f71d63da1fda55 upstream.

The function always returns zero, thus the return value does not carry any
signal. Just make it void.

Most callers already ignore the return value. However:

- Refold arguments of the call from sctp_v6_xmit() so that they fit into
  the 80-column limit.

- tipc_udp_xmit() initializes err from the return value, but that should
  already be always zero at that point. So there's no practical change, but
  elision of the assignment prompts a couple more tweaks to clean up the
  function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/7facacf9d8ca3ca9391a4aee88160913671b868d.1750113335.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 include/net/udp_tunnel.h  | 14 +++++++-------
 net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 6e2c5c77031f..8ed36ec520d7 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,13 +152,13 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck);
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 2acf1bb93fc0..f22eff2ba77c 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,13 +74,13 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck)
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -109,7 +109,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 9f835e674c59..b4c321bad033 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	return udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr,
-				    &fl6->daddr, tclass, ip6_dst_hoplimit(dst),
-				    label, sctp_sk(sk)->udp_port, t->encap_port, false);
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+			     tclass, ip6_dst_hoplimit(dst), label,
+			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	return 0;
 }
 
 /* Returns the dst cache entry for the given source and destination ip
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 258d6aa4f21a..1b8d6bbf8a8e 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -172,7 +172,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
 	struct dst_entry *ndst;
-	int ttl, err = 0;
+	int ttl, err;
 
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
@@ -217,13 +217,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		err = udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
-					   &src->ipv6, &dst->ipv6, 0, ttl, 0,
-					   src->port, dst->port, false);
+		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
+				     src->port, dst->port, false);
 #endif
 	}
 	local_bh_enable();
-	return err;
+	return 0;
 
 tx_error:
 	local_bh_enable();
-- 
2.43.0

