Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618352;
	b=4HGjje3QUzq9qacKmQz+98pFV2RY3oocEYgDC9HHYGsWVyR97Ww9yWT8dJYD3XLVhI+P
	 LrvJH7mPk0OhOz1dzAD6zkgXxTfSJEP9x/qKzsLpw0RyzrX4e5kafko3uVyCDF53ykCWT
	 /QgI7pIV50obHMWLZlfVgKJV93oFa2UuMLDwkjh0wf4Ve/gzq+L0toJVejDspGXJoiRJu
	 AsYd99jyFFv5hIfrnBOueNuQbp7zE+bFuAg8RFJoDPrSOSXmay0L+O/N7at1jg2UDkTt8
	 ZN14cg1ZmoygWnZdlpM7YEejgT8vpq6qjLwqCV+G6iy6SK3zKZQr6eg1FcMv/F2+6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yxKcnOPCUTn9GESrFAeZPx/Ll5zsj6ugvHc+mQe+yQ4=;
	b=tRTJ2wez/8uDEULntRSMwSioSRx/ZpnBYsLeSiz8zcuU6+M0P4Hs38Dy6VYKSS86/Px0
	 55wzldusRhKDVaWN/GzeWhlKmkXlDkYrHCi6ht6Knda/OtLC1nJPSzZh7h1FxOeIeiFcB
	 Ej27iarmBSk+GVXmgUefaI//vYRwszq7Tdn0hkwSz4ABkU2z0hdQXNQjkug9riyGkNG8N
	 sRL8c7aiiEtoQQaL8nlAiTwMTpUUzVs3aCmBpZDAIDdJ9j9SPT59jPgct+mOBH7W7vrlZ
	 1B8LDVknte6FHAHUk9Q6NHj5fc4IwAdlSm0OgQCOLk+j7dqSlFiB3qwUetCLzO+GmNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewvjpoZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewvjpoZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0012F1F000D8;
	Wed, 25 Nov 2026 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618351;
	bh=yxKcnOPCUTn9GESrFAeZPx/Ll5zsj6ugvHc+mQe+yQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewvjpoZnKOK0BkMAolveLsD4+6bpfi69Mv0hjjSf5UDMlMfQYiw73VkVuizUUWny+
	 LbusSnpD9Lt/ke+W9PKisJBLL+1Tr+MZDyDSivmdh2DmYNuiIormohpcLsNXfFoIo1
	 F4+86qcNT3JrxhFN8eywbZ2xlsDOi4KyVlW8wgaIo87OIGhySvdYImzQ/d8zZ2BNjl
	 qztSYp4B/L8iH7Pv1WvCbwoaZW6h/TMiFAnP8UBPaEtZLZDPfV3iXbXB0PDQ23Owzr
	 1SDKx0j7sxFKq2b0frswhQIxDOIMoj/ff6XiClUhyFC06YMX/CGReFhuEsK9MHpZH6
	 b4ate35e/tBdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] tcp: move __reqsk_free() out of line
Date: Wed, 25 Nov 2026 09:52:28 -0500
Message-ID: <20261125145222.4129111-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112535-duly-drier-c965@gregkh>
References: <2026112535-duly-drier-c965@gregkh>
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
index cd4d4cf71d0d2..e5108d0b14d72 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -124,14 +124,7 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
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
index 1f75a4a94cad4..e70dd99c2f912 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -934,6 +934,16 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
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

