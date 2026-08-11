Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4847CC72;
	Tue, 11 Aug 2026 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482647; cv=none; b=sf1w87gNvRi8+pd+o4Ktul4YJN16tgdQ5RgBI1dbfKtSP398FsoRvJkMRtDtB9rT5mT/A5fnh2SjoAde3YToPjoFTT/ZwWOl1Um0vqCZEOiCJgos64G4Ml9ybugHC8FJOONRp7zmadAAV66BzFSw6XTcPNxquowmR0Xn+gKWVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482647; c=relaxed/simple;
	bh=6HIsaC5HxG4NdDGE9sUM/bNXwqfJM9H3QlSlL2IN8XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFB2x6ff06FOF5tchb07igmItG/lV3UjeSoC248Iyc4muOm+vs+ldeCN5wzYyBfNZz1xZ9Z/GT7CT9f+TxIJRUdOi91LlMnXJSwAy3VxAIqTZjrKot5qgycXOTMw0XcLXrS4O/4iLPgfIRYNASAzXWpLmG7AFmW2UIferVCRjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=o1jsJnhd; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="o1jsJnhd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786482632;
	bh=6HIsaC5HxG4NdDGE9sUM/bNXwqfJM9H3QlSlL2IN8XU=;
	h=From:To:Cc:Subject:Date:From;
	b=o1jsJnhdJFPmY+c4EElh1ZNOsLMGQuBRp4TvD9KeleLKd8IwQm0GWc63M0NHaZE8B
	 8A/+03LSuSovymaWFLP27uYWoiD9UjbR8ZoT8yDayyPWpjv0HIR1qmc1pJiKb+myJj
	 kDUUmEh2v89MxmEjkOcGZloS0V5/oAVCvqb7J39QS4zPTvxcv1cyCMbRKffb9ALTbI
	 ZCPO9tpViJ8QUrReZ2E6DK8vOoeDj5YYLGs7+skF/EdrQut/PPIch5o9+y05ti+b8L
	 M/C7Fylvz7Nb5+j3w6BjvxDEh68PzxPmbMvdK0mdGt2LeDLMdRMQ0V6YTq9EOt1sBy
	 BVXYcRzaQhu4A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4CA0D600C1;
	Tue, 11 Aug 2026 21:10:32 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 287BC20156C; Tue, 11 Aug 2026 21:09:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Nielsen <knielsen@knielsen-hq.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3] tcp: reset late connection after listening socket close
Date: Tue, 11 Aug 2026 21:09:23 +0000
Message-ID: <20260811210925.1751466-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When __inet_inherit_port() returns -ENOENT, the new connection is
dropped silently.

In that case the client sees the connection as ESTABLISHED, however in
tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
-ENOENT, and the new connection is dropped by put_and_exit.

A client may therefore hang indefinitely on a blocking read() if the
used data communication protocol is initiated by the server, like SMTP
and the reporter[1]'s MariaDB protocol both are.

Had the new connection been processed before the listening socket was
closed, it would either have been added to the accept queue, or
inet_csk_reqsk_queue_add() should have sent RST.

The call to __inet_inherit_port() returns -ENOENT because
inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
called by tcp_set_state(sk, TCP_CLOSE).

This patch adds -ENOENT handling to both __inet_inherit_port() call
sites, and ensures that RST is sent before the connection is dropped.

Reproducer:
  https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c

Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in __inet_inherit_port()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Changelog:
v3:
  - Rewrite commit message around fixing commit c2f34a65a61c.
  - Call tcp_v{4,6}_send_reset() directly again (but with sk, not newsk).
  - Nest the two return value checks, and wrap in unlikely().
  (Thanks again Kuniyuki)
v2: https://lore.kernel.org/20260810205642.1611338-1-ast@fiberby.net
  - Use return from __inet_inherit_port() to trigger send_reply()
  - Use req->rsk_ops->send_reset.
  - Clarity commit message, and update to reflect the changes.
  (Thanks Kuniyuki)
v1: https://lore.kernel.org/20260807194513.1263310-1-ast@fiberby.net

 net/ipv4/tcp_ipv4.c | 9 ++++++++-
 net/ipv6/tcp_ipv6.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b8887cdd66c5..9a14c2e56ec3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1690,6 +1690,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	int l3index;
 #endif
 	struct ip_options_rcu *inet_opt;
+	int ret;
 
 	if (sk_acceptq_is_full(sk))
 		goto exit_overflow;
@@ -1756,8 +1757,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 		goto put_and_exit; /* OOM, release back memory */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0)
+	ret = __inet_inherit_port(sk, newsk);
+	if (unlikely(ret < 0)) {
+		if (ret == -ENOENT)
+			goto send_reset_and_exit;
 		goto put_and_exit;
+	}
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
 	if (likely(*own_req)) {
@@ -1784,6 +1789,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 exit:
 	tcp_listendrop(sk);
 	return NULL;
+send_reset_and_exit:
+	tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_STATE);
 put_and_exit:
 	newinet->inet_opt = NULL;
 	inet_csk_prepare_forced_close(newsk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..ecb0b405703c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1400,6 +1400,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	int l3index;
 #endif
 	struct flowi6 fl6;
+	int ret;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
@@ -1512,8 +1513,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		goto put_and_exit; /* OOM */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0)
+	ret = __inet_inherit_port(sk, newsk);
+	if (unlikely(ret < 0)) {
+		if (ret == -ENOENT)
+			goto send_reset_and_exit;
 		goto put_and_exit;
+	}
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
 	if (*own_req) {
@@ -1547,6 +1552,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 exit:
 	tcp_listendrop(sk);
 	return NULL;
+send_reset_and_exit:
+	tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_STATE);
 put_and_exit:
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);

base-commit: cba9ccb47e9fa4cc77692fb896cc5ab57a667882
-- 
2.55.0

