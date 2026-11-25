Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619005;
	b=vx5dcLuNWDQRVM5JWHRzCgqqj6CiaCcAVBJ5hYFWezg4Vbh+GdzXLN1Dvb6hY2h6N9WY
	 H5cyzejTEzyZbUM6MC6I92FGD5buySwgRGZMEhFRf2NR/k4yg1neepNQVIYxnIA9sSz89
	 6aOEJrPFnHiCBe9WkK9bgdMJWRTKX2JC7shP5oAzfWTTlRJw/KFeg+Lx4pm50Oqb9S4di
	 vz2hADSpsSm+vNsG9CQ+l6wEitt/WlniQIKQCGb4Zm+NRSDhKR2KIHUtQCq6HoD5skphR
	 dijE7Jy/sCW7rbhcPDK1jagrFJmcbGQ4AtHNb5ShS1Fn5WO2k2J/879J9uhLuBqjQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fwLhGowkQgtfjF46Vb6pG6GFQVwza8oeXHIabzxE1rk=;
	b=Irl+m16vXcaEzXCz2LA9AdaIDGblq9Pin5w0WKyjon5GosuYUwQjqk6O/1VPPrj92ibM
	 RhY3OP++cEBVh/IGvG0J/cYUUOWRE1gTynZjejjErTpHc9BJuM/FSCRw23yEWhsZ2H3yx
	 KW7XdDvamg8dlJ4KaolfRke6eXsq3APtRim50YzEDKXPplpeoBMwNtD+fHVDYZBsATBeg
	 7GjHPbuPxci2+a/bAHmlWD93uOgqVD93sHIp59xd7mxsAF/0aYzxODeBYeP4and8bE3dy
	 SdaI+k1qp8UQeg109TTDoL/YykOQfHjVUgk5oUiQrQIVeYGIKC2USvi364RoVvjXXAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qhnie4Mm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qhnie4Mm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4A21F000CA;
	Wed, 25 Nov 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619004;
	bh=fwLhGowkQgtfjF46Vb6pG6GFQVwza8oeXHIabzxE1rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qhnie4MmDCtkfhaW/+j62Gr3KEJOrOMyJbSwnU+KmXVrM2iWIkd6LBTjOv2z+1Zz9
	 sRgXLh23WEJTPGVbdCyIOBbCIg6DVxF5/eS9/WNyxQozYXgXUXppxBOncIFUR36hUQ
	 tUr75uqSHEMZ6XUExvVB0xv2aP6AUhnebXp1SO/D70RrRDZmxFe06gs7Fy/1OaXjDM
	 hoGTuTgunb6fykClP7FUU2k5YR0D2NGyHXK37+lLDaiwqrW9LCfP9olVNAUkGe3ArM
	 TRGoQoiuwmdco2wkFP/OX6F6DCQN2mxRRC105TwOM/tqq3VTHrBAVOVnqa9J3kAuzh
	 qryVR+E6DwgTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tcp: move __reqsk_free() out of line
Date: Wed, 25 Nov 2026 10:03:21 -0500
Message-ID: <20261125150312.4193312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112536-tweak-sushi-fb9e@gregkh>
References: <2026112536-tweak-sushi-fb9e@gregkh>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 22c1264415ef0d4564dd74e3de66e1895d3f7bc0 ]

Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/4 grow/shrink: 2/14 up/down: 225/-2338 (-2113)
Function                                     old     new   delta
__reqsk_free                                   -     114    +114
sock_edemux                                   18      82     +64
inet_csk_listen_start                        233     264     +31
__pfx___reqsk_free                             -      16     +16
__pfx_reqsk_queue_alloc                       16       -     -16
__pfx_reqsk_free                              16       -     -16
reqsk_queue_alloc                             46       -     -46
tcp_req_err                                  272     177     -95
reqsk_fastopen_remove                        348     253     -95
cookie_bpf_check                             157      62     -95
cookie_tcp_reqsk_alloc                       387     290     -97
cookie_v4_check                             1568    1465    -103
reqsk_free                                   105       -    -105
cookie_v6_check                             1519    1412    -107
sock_gen_put                                 187      78    -109
sock_pfree                                   212      82    -130
tcp_try_fastopen                            1818    1683    -135
tcp_v4_rcv                                  3478    3294    -184
reqsk_put                                    306      90    -216
tcp_get_cookie_sock                          551     318    -233
tcp_v6_rcv                                  3404    3141    -263
tcp_conn_request                            2677    2384    -293
Total: Before=24887415, After=24885302, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260204055147.1682705-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b9fd1a0abf0 ("tcp: free saved_syn after an RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/request_sock.h      |  9 +--------
 net/ipv4/inet_connection_sock.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index b07b1cd14e9f4..49e69b681ad10 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -128,14 +128,7 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	return sk;
 }
 
-static inline void __reqsk_free(struct request_sock *req)
-{
-	req->rsk_ops->destructor(req);
-	if (req->rsk_listener)
-		sock_put(req->rsk_listener);
-	kfree(req->saved_syn);
-	kmem_cache_free(req->rsk_ops->slab, req);
-}
+void __reqsk_free(struct request_sock *req);
 
 static inline void reqsk_free(struct request_sock *req)
 {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6b6a195ca7954..9095c49fcb235 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -957,6 +957,16 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 }
 EXPORT_SYMBOL(inet_reqsk_alloc);
 
+void __reqsk_free(struct request_sock *req)
+{
+	req->rsk_ops->destructor(req);
+	if (req->rsk_listener)
+		sock_put(req->rsk_listener);
+	kfree(req->saved_syn);
+	kmem_cache_free(req->rsk_ops->slab, req);
+}
+EXPORT_SYMBOL_GPL(__reqsk_free);
+
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
 {
-- 
2.53.0

