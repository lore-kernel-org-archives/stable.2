Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E743E9FF
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837059; cv=none; b=pPilIkEY4l6oXI70ZUEEgWnA2QrlnAPHSQye4x8LPdUVZZ8aYZ7IpLiJMUHt9vtSFjYZMmDtgc9fLOl+cK9NmvlBJf2HvKZcaxWUjjHOB6uhgOTRkkMqUsW2FhWqECPg0LzsBl/N1vwGybCMGq3w5QF3RtJTQ7XY6r6NaKIu0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837059; c=relaxed/simple;
	bh=CXhrDt2N1ZKsuvoyPZevD5brYgEi/7BxYv7KLNTjNVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCVWOLIECaQs+gZON12vMkZCaG9lXrAK9iQg7DFHmAGrje6ULrGcgBatayyFVlbWUef08OPU3wXLD4Krk6kXdHrOHEOJ7QUXRa6ae90pD6ckRQJwvAtyEYkGj5oRpOjOZPZF9nKtUSIwQhn1QvWx8IA1Qtw1tzeETLBaj9X8MxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=JCi6S5GL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="JCi6S5GL"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efef6533aaso29521896d6.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785837053; x=1786441853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PERyMvv//ZV8JmFeNOxGHBbrhQ702Zt9Cubl7TxpCpg=;
        b=JCi6S5GLb+Czx7f6BwX7M9fXpYUWUiWTYuuIRhZPom5aPKBNivMMajUWT1+pARAimt
         43yYOa1eZJi8FTsGexJQjgI5HSZiAMbKpzczisR96a4E6Lo+YGuiAXtuS640Of163Zfz
         qSV/lxsC0N3/pvSleXLkJY7ZmuMqBu92U2E4YGvDpNzkKZN7LTo0coDj0fHDPJR2+2wx
         uBY+yjetVevBAGCL2NiDCWDjpqJLZG7ZZWg92EyshjoTPqAUO54L8c4Xr2jeqVXVjYDS
         OxfPWlKouPfdYXCT1ZSiNXODp6ymAt3TFbx1Mei6ouJesgssjhbtRfk7vy1q6u/HNkqS
         NA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837053; x=1786441853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PERyMvv//ZV8JmFeNOxGHBbrhQ702Zt9Cubl7TxpCpg=;
        b=fbzhPmmCJ5uDk2TWSIdVL5TAQF6TP+wPoleyDgt+igXdN+1rbakzTrxZmEWVn/cuAl
         pRA6NeYwu8PPmYB9na2N3RgV6SQK3w6jdL9b2iNRPhy+4JROV3/Y9hL5u8jVXmLuIiR4
         WEwekdEdp/h4NNlgWG/+p/ZRDRhouDB6qCvzrbOAW9FuhIkEEVcl+AiFv9j0BZDEW5YL
         +J+ewFS5FcbQyWKyHdREUElAe0l4wdfWYNse1HMfJt84YqbYtbMn4wqHWMzlELkbkGS7
         UP8/wDtCN2/91WcUvttFB0DFkaRx2G9NyDykt9/xRTXb2KWOTkg49ESTBR6qmLvI0wI5
         lkLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0lRTg8PzhrFKjEGdTOGxD1uEOpqp466fPbobGUTJQBsS9FKF/AiZam+Mo9Rc6wXHh5y+HV3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4n1vpru2zV+N31oqqUzxBr0JzJYuKNknqkzcKuSNZnY+xMpw
	2/uCfeABAGiZyz9/ePFVzBSRfHbtXNL0WesN6ZTSOcGoNWKbNcRbtq/2k55XHdMDUDw=
X-Gm-Gg: AR+sD12QPYaKxZcZU99FQCoSHbGRsF2BEodlDrMwVBzoe8W1JkUEwXb2cMbvTTSZxo3
	79V08ZbRKpyy6gzSEkevyCXUA6BjjeUJbeieTvjcSNPmzVAaTB7XMxhDpC/CIi3wtB1pfV4bJRi
	MfuCCRfXw8/89bHHUe9y601DqW2kv2x4s3ZyJMEWmm8Bca2tzSnfIQF+nzws8t60ogLwdbEqoQI
	iO3qP923NzgKVMowcbwsDImO1d/fKUdH8TGRl6Cds0SXi4FM50OurZVMerS4gwz6mS1afG8pzPq
	QWXKmMo4PIUwxuQnlCiOUI0AZRCEtDRCEDSj81YZRJcK+BaGCjZsxQ/NvE9thhDTPck1QsQH2yR
	05Rtlox1Jqx6cnkO9cd5GjrC9Nx4w6CgQlehLfKX3/cDaEyc5+xctG3TvAZU5Gs3nz9fxdrPKuC
	I6jtCWkZwZq5I9qnGmVn2q/cJUr7fsumI4cTmeOWBfsp/lcCrK7w/63aKUkdIM7p3THg==
X-Received: by 2002:a05:6214:5d0f:b0:908:25a2:6bbf with SMTP id 6a1803df08f44-908496b3d1emr290394186d6.30.1785837052734;
        Tue, 04 Aug 2026 02:50:52 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908434a2c2asm95469626d6.19.2026.08.04.02.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:50:52 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	geliang@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net] mptcp: hold msk reference when cloning request sockets
Date: Tue,  4 Aug 2026 09:50:49 +0000
Message-ID: <20260804095051.715355-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

An MP_JOIN request owns the reference stored in subflow_req->msk.
inet_reqsk_clone() byte-copies that pointer when migrating a request,
but does not acquire a reference for the clone.  The original and cloned
request destructors can consequently drop the same reference, leaving
one request with a dangling msk pointer.

Let cloned MPTCP requests take their own msk reference.  The source
request still owns its reference while it is being cloned, so sock_hold()
is safe.  The clone's normal destructor balances the new reference on
both successful and failed migration paths.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/net/mptcp.h             |  5 +++++
 net/ipv4/inet_connection_sock.c | 10 ++++++++--
 net/mptcp/subflow.c             |  8 ++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5..51d4b02f5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +310,10 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5..f3ef9c15a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -17,6 +17,7 @@
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
 #include <net/route.h>
+#include <net/mptcp.h>
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
@@ -946,8 +947,13 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 	/* We need not acquire fastopenq->lock
 	 * because the child socket is locked in inet_csk_listen_stop().
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
-		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (tcp_rsk(nreq)->tfo_listener)
+			rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+
+		if (rsk_is_mptcp(req))
+			mptcp_subflow_reqsk_clone(nreq);
+	}
 
 	return nreq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899c..1b6aa5e8c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,14 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
-- 
2.47.3
