Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419280;
	b=wOll7jQ6yOiMiwdRJysOPQoVCJza0oRPGLyLbd7W2ymh+XvV2sZxOSHMnFC8tsBfQs6L
	 avCUOTIhfIn3vJ1MshPE6hsvmaE/aVaWum+JwaTHWKQPiQq5/JBGJG0ZZQV6BENz+ELXk
	 ePPbLF4YiZtc/qL+oHMPeb6+ECv9Apoaazo2SzhHl8YPlVmu+Og+90DSENM3SkW2ccIHg
	 e5WkpPLv3kE7G3z3/pWLtYIjiXctyjk5hIu6V6kkBfwl7rPqEbitU9YvXuwu1nKj90KJC
	 YWXxxauP8/e/ZvE3wnB2/URs0OR5keLA6LhXj0mYRMlv6l7+T+0D98OSmj8//hqsC+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
	b=lVZ+KhOiUgdZW8TwCLIl8sVPeOPDdCLCl1kj4TP1Wx2zNgMYY2qHote4KNl9hQrYiRBy
	 4hsM0ELXqIVyGVanBwdikT6VOMQgzLgZdWIoXK2hiSW/PAK5umbRMYqXGSVn+WTKlqSmW
	 kb3z2Lhq/F6fOPt6Zg2Y2j+f9ZmzSLMdFIvPpfQskfihR+Tx/4N55ZQZ3LKyWPppyZnA3
	 6ioT4ba6wJZ78zUxcz5DbZQLthSdcwZbKDICpVcWFEU8Wluw/MH0vcZgVVsavQL9zxi+z
	 mR4nI8lPb6e4r71sMn0r07Iu18UKQXHGPfvg7deoCAcEqBausjvINuGm/LMf0yaFMkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPpOiav;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7B606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A7B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPpOiav
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-675617e81f9so3557229d50.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419279; x=1795024079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
        b=mzPpOiavZjWGC0VpKLXkiQTk7jWoAOSjROcU2NNkp2/udg76bL0g9eUJdQkMGbxkTh
         Zc1kPkeMv9ZBOMw3G0+h+HnDlcBf7fNY/o1IivdREn+um+JymdJNJjuawplssP7xEmut
         V1RdxnoNpCuXOQ0QiEMH/XtC88DYUNQEY2urQo1lZaKPhyova0/mEOOD7YPh7hip+wdC
         z26uYPMFc9Mx4FRiiz1kH6t//38s2+72XwfBgsD2OEO7PH6hb9MhdXHjumzrhWMYCetr
         gnYbnLlqcHlyfQsAdqqAmP5VUhrOTF6DwWFBnjKREsXg7+OVprhfoJxzjdQa9KepzYXt
         ZWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419279; x=1795024079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
        b=XBkwufHzqcEdmAdFe7R1faPQAr0yYW49TC8cKRz4M7038PALVlVbtWARMME2JTktSj
         rGgazQCEhSaS8XykLeGvbbZ4x0vOKPWNLhkP3zX0bSLSFB+gd30/ct6G4CLYBtNYOKgW
         hyqkiQtYS1rv3HqAdOMfgWNzXP8EZaTuugp2ysJx5nR9TSTfSq26eAbkdijrsT14h7uR
         xcfMp396t+g/UgShXcX8BcDlmw2+4CpqnLqsgmEn5yTLyRD5pWxmr3MDEqy/T84Hgzhr
         TXU47y1Q38oHdct7pXYWjnLr+9DJ9pUMRZSi/ZIAQblzou9Qj8NS+p+RLFBPE0Q5efn6
         hy8A==
X-Forwarded-Encrypted: i=1; AL+hErH4gkuNn9MbrRZRWb369SmyqLcRhVo0fPgIx93/oiSfObB5AhU2UGtLpVaGfKMoGHyqTGZyLiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kk1nmbrKxcpW/k8JjmjkvORah4vAucM3R/nUcWGzOO/cYOcuM
	p6FmN7O9AXfBbysRWr2mIb9+DaxVIbqai9dpt0n0QIj0extf7sxK5N7a
X-Gm-Gg: AYBFou2eOzsAnay+T3hF5p0OnG2YEM5hBr2CvpqfoymXvgxJd7yctTEP60vLTyBqJPU
	sC/01Wv+U7bznPqGK0EnhJBj5nU01oLvsBsfaS6Ig4yXEGoK5ReU5Dd3DmwXY6NJjmX0Gyax4xV
	XFwfK5PsDTSdYJ3Mrv6PJEtfF854te/MFJIgIGhtCsVKWTbs7GPesHA9Ob9G+UtP0nXBRQj2WYy
	zduWedVxtTsIR8js0lNaeXx5K3bnIdqqTuTUDkl/d4UYK7lyOKlQQn8J2uy8zibZUc4VKjjXgIV
	lqz/yrYld55I8binuPpbxYoJMu2JAIclyUn2WZ6gWCr9+FtzRLsallGK0gzGW9kyoaJXpzpDFuc
	9TnzFWanksiLghkRZarDPAByCFprn/nUofJRjPZEyL1VRYQsVT33YY7JkoZvfBXwpvzI94wT5M8
	3cJwi12tFCqTLAG1DizMMgejcx4Plj3TwFyuNHACMWDLZqQBpKAfg7MfsgBwPQ8apNHwAMRhj1y
	3xKvtzeS3t4dy3r388fpiO2cO89dHAlwV12gzAA8pNPrmbdXaXF/yvaT2p/nREr0eDJI70TML4b
	3H0vHEuZkDpewXhaCErFnvma5RfkbL+S3T8cX6BYDooqCdov9TzVPA==
X-Received: by 2002:a53:c7c2:0:b0:679:9afd:c0de with SMTP id 956f58d0204a3-67c6805a592mr1606256d50.97.1794419279142;
        Wed, 11 Nov 2026 09:47:59 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm5077708d50.12.2026.11.11.09.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 09:47:58 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	josef@toxicpanda.com,
	jbacik@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juan Agustin Niccolini <juanagusnicco@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] tcp: Fix the SO_REUSEPORT bind cache admitting a conflicting socket
Date: Wed, 11 Nov 2026 12:47:03 -0500
Message-ID: <20261111174704.24312-2-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111174704.24312-1-juanagusnicco@gmail.com>
References: <20261111174704.24312-1-juanagusnicco@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the port is in the FASTREUSEPORT_STRICT state, inet_csk_get_port()
skips the bind conflict check if sk_reuseport_match() finds the new
socket's address covered by the socket cached in tb->fast_*.

This is only safe if both sockets match on everything
inet_bind_conflict() reads. The cache misses some of it:

- It does not record sk_bound_dev_if or sk_reuse.
- It records the family and IPV6_V6ONLY but never compares them with
  the new socket, so a cached v6only [::] (or 0.0.0.0) socket covers
  a dual-stack [::] socket.

As a result, an unprivileged user can bind and listen on a port that
another user is listening on, for example a dual-stack [::] socket on
top of a 0.0.0.0 listener:

  victim:   bind(0.0.0.0:P), listen()
  attacker: SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P)   /* fills cache */
  attacker: SO_REUSEPORT, bind([::]:P), listen()       /* should fail */

Only take the fast path when the new socket matches the cached one in
family, IPV6_V6ONLY, bound device and SO_REUSEADDR. Identical
SO_REUSEPORT listeners, the workload this cache was added for, still
skip the scan (binding 16384 of them: 9.80 ms before, 9.86 ms after,
5874 ms with the full check every time).

Fixes: 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a reuseport sk")
Cc: stable@vger.kernel.org
Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
---
 include/net/inet_hashtables.h   |  2 ++
 net/ipv4/inet_connection_sock.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 6e2fe186d0dc..44b7e39a1245 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -87,6 +87,8 @@ struct inet_bind_bucket {
 	__be32			fast_rcv_saddr;
 	unsigned short		fast_sk_family;
 	bool			fast_ipv6_only;
+	unsigned char		fast_sk_reuse;
+	int			fast_bound_dev_if;
 	struct hlist_node	node;
 	struct hlist_head	bhash2;
 	struct rcu_head		rcu;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec43877..70b8662b3004 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -420,13 +420,18 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 		return 0;
 	if (!uid_eq(tb->fastuid, sk_uid(sk)))
 		return 0;
-	/* We only need to check the rcv_saddr if this tb was once marked
+	/* We only need to check the fast_* fields if this tb was once marked
 	 * without fastreuseport and then was reset, as we can only know that
-	 * the fast_*rcv_saddr doesn't have any conflicts with the socks on the
-	 * owners list.
+	 * the socket they describe doesn't have any conflicts with the socks
+	 * on the owners list.
 	 */
 	if (tb->fastreuseport == FASTREUSEPORT_ANY)
 		return 1;
+	if (tb->fast_sk_family != sk->sk_family ||
+	    tb->fast_ipv6_only != ipv6_only_sock(sk) ||
+	    tb->fast_bound_dev_if != sk->sk_bound_dev_if ||
+	    tb->fast_sk_reuse != sk->sk_reuse)
+		return 0;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb->fast_sk_family == AF_INET6)
 		return ipv6_rcv_saddr_equal(&tb->fast_v6_rcv_saddr,
@@ -455,6 +460,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 			tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 			tb->fast_ipv6_only = ipv6_only_sock(sk);
 			tb->fast_sk_family = sk->sk_family;
+			tb->fast_sk_reuse = sk->sk_reuse;
+			tb->fast_bound_dev_if = sk->sk_bound_dev_if;
 #if IS_ENABLED(CONFIG_IPV6)
 			tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 #endif
@@ -482,6 +489,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 				tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 				tb->fast_ipv6_only = ipv6_only_sock(sk);
 				tb->fast_sk_family = sk->sk_family;
+				tb->fast_sk_reuse = sk->sk_reuse;
+				tb->fast_bound_dev_if = sk->sk_bound_dev_if;
 #if IS_ENABLED(CONFIG_IPV6)
 				tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 #endif
-- 
2.43.0

