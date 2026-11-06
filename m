Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001247;
	b=ZmxnytssGHOfQi/PRSjLZeZuZXl2m5J+O0fbVHJjzRFMZkcN8ydzlLzO88ZnbQDFod/x
	 9AP3XJZC//oyVmX+DXmPYvcOXpv9H9F08I2YJWPjFDjMPBdTAyjVTUtK7vTupN9KZADpC
	 BcZwjp+R1n/i2Ugsc8lwzOJw0ntl1EsxpvVnjwu4NuPj0ycVerUNLKmG5FvZYsbXyrWJP
	 7pW/hGOtI0dzCzCF7QBBlq1Xc/ZLVTPieulCx42a6966yaXQYzAob15ENcDIYvzBTYKnY
	 R9zkrwZA2f6847ehEJwE5VddATMDPP3+iwZC+jna3RKubXRncyGBXcKG6bAfgTsU3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HDC3HGct+N1kATD3ozLle6tkVgbjKWtzjQkKlLDrKRY=;
	b=Y+FtICA8Az98enhbzZdk5/AL79huYqsC+AmleftSqCzqBdlQBhl4kw3TTx0bIdE729ns
	 fSRCl+AFijQWB+bPlvNFsXT65jvsFVyXGtfkvNIQnr53BfUr6NoUHyjU+JtisORZebZrs
	 WVBe5FA+9BudFuEsU350WLHUaaCMaxdD4r93mn6d8jKYdvSOCsgk/hRVlBiWSHUSJqd4e
	 vTRQPUQX0/KWfhZL4mEZms/EDSLc5lf3PAV0TNKQvuNtTMhm8XbdMrya6+bcGSaNtqDqT
	 V7ZoCDNp90sqxbYu376ZVnuQM+LT4tYBslARDPdUHbYwWYjOXEnwceIg7wGQhtM+UjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lk7q8SwX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2E606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 21:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C2E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lk7q8SwX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso8375e9.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794001245; x=1794606045; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HDC3HGct+N1kATD3ozLle6tkVgbjKWtzjQkKlLDrKRY=;
        b=lk7q8SwXuna/HE2iiiMlyVcoL7yI2SAWKVqoxClIP/wSAqDxTRgly2E+zFPvHr47IN
         xD8FNxo+ibPoOO6WkHJajZj5eDdJujEBcelV2iDO1JTxHN2X0uM3r5CTxDpAfSOO2Afd
         nGd+Z28R6QnWNYZTZC+MLnIS5Y2/Kbfkj3Dye/BagbNF8FHfoBoskvSIT0KnYxCsHNMD
         brYEou7p+RVeB/Km3pDNSUECAxgxLeUSrXzMDUxiweSGez+kWIAAOq14qcPfJaacHnnA
         N2CF4Rq80fnpiBd9satdmiIv0Nf1jfKrNakIKToAL85O+z9SXhb+Y07D41X7SxIGUqW+
         YlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794001245; x=1794606045;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HDC3HGct+N1kATD3ozLle6tkVgbjKWtzjQkKlLDrKRY=;
        b=Xc1941IAPMeyMgSOXDmDn0Aav0oPMF0vkBqUvV5E6WP+iJWsqNX/xap5Ou69su4bgn
         2433mvfR4+KOMZ53p7ek72BTvKpwAAIt4n92kymnvaykRIyGI4gIvvfGX9r+JyUJzOPY
         mT9DSQTNk3iCZRl4tIgC8P3hVUAxGTVtdY42VWWBokndd4+2v1NKwzHxJkz8EzWu6MTE
         49cWVH4gbOZ5YMpi+NS7qmRVQGxVTdnolPd8uorvwR8NhXtjC777/EKxzsfUK+FC1de1
         7snW/laiqbHl6kaGbhRJKS0aS/hRRZLPO+aplkNqg0qy7nhKjewnW09SBJAXUgmWM//A
         t7ig==
X-Forwarded-Encrypted: i=1; AKwUvBxqcapMiOxhuaZpt0PP9JAqOS3qtd/vgv7E9VCZmzKg7EtWcBpowD5eAk+Q5JauInLLMkP9jiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TvxqYmZixwxb2WCWWVOhXWDn0ag8WagVyrdFxpp5ozHsabqJ2
	l6Fbd3mny1x3uqIlb6VicLv+cOBc4vq5IiPxnlw+KXF/PPGqvV39GjCy8pZtobafqA==
X-Gm-Gg: AYBFou3PJZzmyz+B0yQeENOxWatpFIRVt6aDdeQSS9aiIzwyEp4Idixad87nkIDhXoZ
	+Tkc0DzKPpVIF9uZj4DtrkroEVSqApG3JTW4XyNYaux3tVnyOX8ggv0jpvVrh0CsTSuEBHqS+0r
	yoeeaJMTKOcq0h1CG/unOsWi8Ae1VcxLvWLT/qkowAyGVtihGFt2PyE6kLJ+pYjFHkJe5BYIq7m
	ncdT4azl7NJzGYiMaQkMQ5NpP9Yln0AiD3dZOZSsj08VVE/0lIMtd0uTj3jl6pUZ+OFFrai5U/W
	DfqbiaEB3BW6c6BXI78i3V8PUjSTnglpieX8baseFuMuEoVpbtSu8rsHFXVjdLslyTF1sqOohf6
	gAD2eNltk6fYE1VgPyrbqsi9e+O6KQ+8LjFPUgr5zC96smgnjd+PtZiopxJ8ijU7Ou4HzNpu4Jj
	E0SZkKUJpj11+Go4sxvSI2GGUGPtAgEdyUhJwA3ixXwC/T7naTQfQ4cbWo9qfNB8XG+WAvWlPO/
	vj7o+aTOEFzdsGZzrJ5z9juPuU8wSIlG4SObqI1HPdXHVeG37pZU+7DA15vo81ZzsshtkxmwKsV
	U1kfBXTZT/TbwAyMlqmSAXdHszwAnvKCytmkFt6FldWMV2GupxxbQnico24pv8/COgRGojl/E0e
	7lDeGuUVGD07kmPZk2nDJuW0m+XXGTr0n6j8=
X-Received: by 2002:a05:600c:8b31:b0:4a1:d7fa:ae36 with SMTP id 5b1f17b1804b1-4b8190f3b55mr98285e9.4.1794001245067;
        Fri, 06 Nov 2026 13:40:45 -0800 (PST)
Received: from localhost ([2a00:79e0:288a:8:476d:4cff:b13d:f028])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701bfasm5887936f8f.40.2026.11.06.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:40:44 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 06 Nov 2026 22:40:31 +0100
Subject: [PATCH net] cipso: stop modifying live ip_options_rcu
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
X-B4-Tracking: v=1; b=H4sIAE5J7moC/yWMQQrDIBQFrxLeukK0rZBcJXRh7Lf9Xaj4TQiE3
 L02Xc7AzA6hwiQYux2FVhZOsYG+dPBvF1+k+NkYpjdW694qz1mSKn5JuYoiY0Nwt/t8HQxakws
 F3s7fhEgVj7+UZf6Qr78TjuML9iD+83YAAAA=
X-Change-ID: 20261106-cipso-rcuopts-e26ffa45b392
To: Paul Moore <paul@paul-moore.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Simon Horman <horms@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 selinux@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794001239; l=11224;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=sFzK60Ujof6oKkoUevi0RWgNEC3MXkp1co13ojYs7hk=;
 b=ej7CqHV2tcGY7zGDHHLVd8mlD+53sVeZqHB/LxVS7JAqkBTxC9XWBqz93yNoSe62PFZyDBayT
 2629yyXmgJ9CUPFiQcovKdF2pBDFI4WKrcPwToXC3u6z9XjHzAG4Zc2
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
socket, and tries to remove CIPSO options from the middle by moving all
subsequent options.
That's not allowed - ip_options_rcu can be read locklessly and must always
be consistent. For example, ip_options_undo() reads trusted offsets and
length values from the options buffer.
Fix it by doing the modification in a copy.

The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
propagate memory allocation failures.

Triggering this bug requires that the system is configured to use CIPSO.
(Setting up CIPSO requires privileges in init_user_ns.)

Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I've sent a separate mail with a reproducer to Paul Moore.
---
 include/net/cipso_ipv4.h     | 11 ++++++-----
 include/net/netlabel.h       | 11 ++++++-----
 net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
 net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
 security/selinux/netlabel.c  |  5 +++--
 security/smack/smack_lsm.c   | 14 +++++++++-----
 6 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
index d6780d7903f4..b41672221797 100644
--- a/include/net/cipso_ipv4.h
+++ b/include/net/cipso_ipv4.h
@@ -185,12 +185,12 @@ int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
 			  const struct netlbl_lsm_secattr *secattr,
 			  bool sk_locked);
-void cipso_v4_sock_delattr(struct sock *sk);
+int cipso_v4_sock_delattr(struct sock *sk);
 int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr);
 int cipso_v4_req_setattr(struct request_sock *req,
 			 const struct cipso_v4_doi *doi_def,
 			 const struct netlbl_lsm_secattr *secattr);
-void cipso_v4_req_delattr(struct request_sock *req);
+int cipso_v4_req_delattr(struct request_sock *req);
 int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 			    const struct cipso_v4_doi *doi_def,
 			    const struct netlbl_lsm_secattr *secattr);
@@ -221,8 +221,9 @@ static inline int cipso_v4_sock_setattr(struct sock *sk,
 	return -ENOSYS;
 }
 
-static inline void cipso_v4_sock_delattr(struct sock *sk)
+static inline int cipso_v4_sock_delattr(struct sock *sk)
 {
+	return 0;
 }
 
 static inline int cipso_v4_sock_getattr(struct sock *sk,
@@ -238,9 +239,9 @@ static inline int cipso_v4_req_setattr(struct request_sock *req,
 	return -ENOSYS;
 }
 
-static inline void cipso_v4_req_delattr(struct request_sock *req)
+static inline int cipso_v4_req_delattr(struct request_sock *req)
 {
-	return;
+	return 0;
 }
 
 static inline int cipso_v4_skbuff_setattr(struct sk_buff *skb,
diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 02914b1df38b..f896b9d52ed1 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -477,7 +477,7 @@ int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
 			const struct netlbl_lsm_secattr *secattr,
 			bool sk_locked);
-void netlbl_sock_delattr(struct sock *sk);
+int netlbl_sock_delattr(struct sock *sk);
 int netlbl_sock_getattr(struct sock *sk,
 			struct netlbl_lsm_secattr *secattr);
 int netlbl_conn_setattr(struct sock *sk,
@@ -485,7 +485,7 @@ int netlbl_conn_setattr(struct sock *sk,
 			const struct netlbl_lsm_secattr *secattr);
 int netlbl_req_setattr(struct request_sock *req,
 		       const struct netlbl_lsm_secattr *secattr);
-void netlbl_req_delattr(struct request_sock *req);
+int netlbl_req_delattr(struct request_sock *req);
 int netlbl_skbuff_setattr(struct sk_buff *skb,
 			  u16 family,
 			  const struct netlbl_lsm_secattr *secattr);
@@ -626,8 +626,9 @@ static inline int netlbl_sock_setattr(struct sock *sk,
 {
 	return -ENOSYS;
 }
-static inline void netlbl_sock_delattr(struct sock *sk)
+static inline int netlbl_sock_delattr(struct sock *sk)
 {
+	return 0;
 }
 static inline int netlbl_sock_getattr(struct sock *sk,
 				      struct netlbl_lsm_secattr *secattr)
@@ -645,9 +646,9 @@ static inline int netlbl_req_setattr(struct request_sock *req,
 {
 	return -ENOSYS;
 }
-static inline void netlbl_req_delattr(struct request_sock *req)
+static inline int netlbl_req_delattr(struct request_sock *req)
 {
-	return;
+	return 0;
 }
 static inline int netlbl_skbuff_setattr(struct sk_buff *skb,
 				      u16 family,
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index e65a3f29d2ca..ee0c72fbc877 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2004,11 +2004,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 	if (!opt || opt->opt.cipso == 0)
 		return 0;
 	if (opt->opt.srr || opt->opt.rr || opt->opt.ts || opt->opt.router_alert) {
+		struct ip_options_rcu *old_opt = opt;
 		u8 cipso_len;
 		u8 cipso_off;
 		unsigned char *cipso_ptr;
 		int optlen_new;
 
+		/* ip_options_rcu must not be modified in place, use a copy */
+		opt = kmemdup(opt, sizeof(*opt) + opt->opt.optlen, GFP_ATOMIC);
+		if (!opt)
+			return -ENOMEM;
 		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
@@ -2036,6 +2041,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 
 		memset(&opt->opt.__data[optlen_new], IPOPT_END,
 		       opt->opt.optlen - optlen_new);
+		rcu_assign_pointer(*opt_ptr, opt);
+		kfree_rcu(old_opt, rcu);
 	} else {
 		/* only the cipso option was present on the socket so we can
 		 * remove the entire option struct */
@@ -2055,7 +2062,7 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
  * Removes the CIPSO option from a socket, if present.
  *
  */
-void cipso_v4_sock_delattr(struct sock *sk)
+int cipso_v4_sock_delattr(struct sock *sk)
 {
 	struct inet_sock *sk_inet;
 	int hdr_delta;
@@ -2068,6 +2075,7 @@ void cipso_v4_sock_delattr(struct sock *sk)
 		sk_conn->icsk_ext_hdr_len -= hdr_delta;
 		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
 	}
+	return (hdr_delta < 0) ? hdr_delta : 0;
 }
 
 /**
@@ -2078,9 +2086,11 @@ void cipso_v4_sock_delattr(struct sock *sk)
  * Removes the CIPSO option from a request socket, if present.
  *
  */
-void cipso_v4_req_delattr(struct request_sock *req)
+int cipso_v4_req_delattr(struct request_sock *req)
 {
-	cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
+	int hdr_delta = cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
+
+	return (hdr_delta < 0) ? hdr_delta : 0;
 }
 
 /**
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01..c0eddb6afef3 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1045,18 +1045,18 @@ int netlbl_sock_setattr(struct sock *sk,
  * ensuring that @sk is locked.
  *
  */
-void netlbl_sock_delattr(struct sock *sk)
+int netlbl_sock_delattr(struct sock *sk)
 {
 	switch (sk->sk_family) {
 	case AF_INET:
-		cipso_v4_sock_delattr(sk);
-		break;
+		return cipso_v4_sock_delattr(sk);
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		calipso_sock_delattr(sk);
 		break;
 #endif /* IPv6 */
 	}
+	return 0;
 }
 
 /**
@@ -1156,8 +1156,7 @@ int netlbl_conn_setattr(struct sock *sk,
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
-			netlbl_sock_delattr(sk);
-			ret_val = 0;
+			ret_val = netlbl_sock_delattr(sk);
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1185,8 +1184,7 @@ int netlbl_conn_setattr(struct sock *sk,
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
-			netlbl_sock_delattr(sk);
-			ret_val = 0;
+			ret_val = netlbl_sock_delattr(sk);
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1234,8 +1232,7 @@ int netlbl_req_setattr(struct request_sock *req,
 						       entry->cipso, secattr);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			netlbl_req_delattr(req);
-			ret_val = 0;
+			ret_val = netlbl_req_delattr(req);
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1255,8 +1252,7 @@ int netlbl_req_setattr(struct request_sock *req,
 						      entry->calipso, secattr);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			netlbl_req_delattr(req);
-			ret_val = 0;
+			ret_val = netlbl_req_delattr(req);
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1280,18 +1276,18 @@ int netlbl_req_setattr(struct request_sock *req,
 * Remove all the NetLabel labeling from @req.
 *
 */
-void netlbl_req_delattr(struct request_sock *req)
+int netlbl_req_delattr(struct request_sock *req)
 {
 	switch (req->rsk_ops->family) {
 	case AF_INET:
-		cipso_v4_req_delattr(req);
-		break;
+		return cipso_v4_req_delattr(req);
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		calipso_req_delattr(req);
 		break;
 #endif /* IPv6 */
 	}
+	return 0;
 }
 
 /**
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index d51dfe892312..24b11d1891d8 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -557,9 +557,10 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 	 * is set to AF_UNSPEC, if that is what is happening we want to reset
 	 * the socket */
 	if (addr->sa_family == AF_UNSPEC) {
-		netlbl_sock_delattr(sk);
+		rc = netlbl_sock_delattr(sk);
+		if (rc)
+			return rc;
 		sksec->nlbl_state = NLBL_REQSKB;
-		rc = 0;
 		return rc;
 	}
 	secattr = selinux_netlbl_sock_genattr(sk);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 28a8e12603ce..3a4a33568297 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2656,22 +2656,26 @@ static int smack_netlbl_add(struct sock *sk)
  *
  * Remove the outbound smack value from a socket
  */
-static void smack_netlbl_delete(struct sock *sk)
+static int smack_netlbl_delete(struct sock *sk)
 {
 	struct socket_smack *ssp = smack_sock(sk);
+	int rc;
 
 	/*
 	 * Take the label off the socket if one is set.
 	 */
 	if (ssp->smk_state != SMK_NETLBL_LABELED)
-		return;
+		return 0;
 
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
-	netlbl_sock_delattr(sk);
+	rc = netlbl_sock_delattr(sk);
 	bh_unlock_sock(sk);
 	local_bh_enable();
+	if (rc)
+		return rc;
 	ssp->smk_state = SMK_NETLBL_UNLABELED;
+	return 0;
 }
 
 /**
@@ -2711,7 +2715,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 		 * Clear the socket netlabel if it's set.
 		 */
 		if (!rc)
-			smack_netlbl_delete(sk);
+			rc = smack_netlbl_delete(sk);
 	}
 	rcu_read_unlock();
 
@@ -4548,7 +4552,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	if (hskp == NULL)
 		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
-		netlbl_req_delattr(req);
+		rc = netlbl_req_delattr(req);
 
 	return rc;
 }

---
base-commit: a91337fb5e8e0127c8b5be87be9f3027f95b48bc
change-id: 20261106-cipso-rcuopts-e26ffa45b392

Best regards,
--  
Jann Horn <jannh@google.com>

