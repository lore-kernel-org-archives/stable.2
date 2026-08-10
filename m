Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A1440A26;
	Mon, 10 Aug 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395451; cv=none; b=t7BRcvYyIg4AjDibySi8QeRizyvIpmz2z3mAI9Mxrtq339x3o68mMlxBD0cc6RJAFoGok5lCXATzqwTB7IBiCOYtszFMro07Gt2B6++eCGx+0rd6x4MUP2G0Ee+Zlh+cyJkLkBIhTBVwLxpWSQiUqiXgvjsUSunwXlkgmHOjwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395451; c=relaxed/simple;
	bh=DOp9Y2aUzmFf6CiamfCyAS+Gg8Ut+zWdr9u36XpuZmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GLrbVw9YyP6SpsZCedR6M+zks+UDVksaC9WPbc9kogK+ZwiV/fFf8uK83TbBuvtxao1gu8qGXdkiFe5novB1Cy4rlSBdJ9zhS9WRMVIdKke8GtNBXcDraJrCkTdPDufgWy2q5LEtaVGAeMa5rlZqyOS2WvrfQ4E03m8yfHdeQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=uplwzw7D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="uplwzw7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786395438;
	bh=DOp9Y2aUzmFf6CiamfCyAS+Gg8Ut+zWdr9u36XpuZmA=;
	h=From:To:Cc:Subject:Date:From;
	b=uplwzw7DJ5Hiehp+VCN5K6iX+1qNpiu0Myijl60l2oU2h8g2fwxmAMjb4V1kE9/cZ
	 SmnWsFG3RDXInb5s0WRjs/D/1blncX9XV6oUepdOgC1yTuV1BDXawywE732XcGUDyn
	 jl+Y8d5vmO8IkgqgRLJnMXxJKl9heQtfHyjsBge8DrT+TBQ/thPAKkg8mkjY82zKQi
	 R3vK2voWjq5whw2pyvfrwxASu8/h4cGbqknjj118LNe+gOUvOo66zo6nVG75Mij8nX
	 SVoJA0bEaffjrEa5yKi/kKKrTnlQfwXjIOjBwp97smYFq26bJAhdLDoCqlJTc6GUaK
	 PPRxYq8mE680g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DEFD6600C1;
	Mon, 10 Aug 2026 20:57:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 86C45203344; Mon, 10 Aug 2026 20:57:03 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Nielsen <knielsen@knielsen-hq.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: reset late connection after listening socket close
Date: Mon, 10 Aug 2026 20:56:40 +0000
Message-ID: <20260810205642.1611338-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit c82199061009 ("task_work: remove fifo ordering guarantee")
Eric removed the ordering guarantee, thereby changing it from a
guaranteed FIFO to currently LIFO ordering, in an effort to reduce
jitter.

This significantly increases the probability for a race to occur
between a TCP handshake and the closing of the listening socket.

In that case the client sees the connection as ESTABLISHED, however in
tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
-ENOENT, and the new connection is dropped silently by put_and_exit.

A client may therefore hang indefinitely on a blocking read() if the
used data communication protocol is initiated by the server, like SMTP
and the reporter[1]'s MariaDB protocol both are.

Had the new connection been processed before the listening socket was
closed, it would have been in the accept queue, and been notified when
inet_csk_listen_stop() was run, and the client would have got a reset.

The call to __inet_inherit_port() returns -ENOENT because
inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
called by tcp_set_state(sk, TCP_CLOSE).

This patch adds a check on the return value of the __inet_inherit_port()
call, and jumps to a new label, where it resets the new connection,
before proceeding with the put_and_exit label.

The blamed commit was identified by testing on ancient Debian stable
releases to get a rough scope of where to look, then identifying in
which release between v3.16 and v4.19 it broke, and finally bisecting
v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
that era, and confirmed by reverting it from v4.3, v5.10.y and net.

Additionally the race can be reproduced back to v3.6, by backporting
the blamed commit. Beyond v3.6 there are too many conflicts.

Reproducer:
  https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c

Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
Fixes: c82199061009 ("task_work: remove fifo ordering guarantee")
Cc: <stable@vger.kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

While the blamed commit properly only made the race observable, then
the commit that made the race possible is less realistic to track down,
and I don't think is worth the time to continue to the search for it
somewhere before v3.6.

I'm not submitting a selftest at this time, as I have only found an
efficient way to often detect the issue, not disprove it, and I would
need more test data from different systems, before I can reliably
disprove it with a low runtime budget, without getting false negatives.

Changelog:
v2:
  - Use return from __inet_inherit_port() to trigger send_reply()
  - Use req->rsk_ops->send_reset.
  - Clarity commit message, and update to reflect the changes.
  (Thanks Kuniyuki)
v1: https://lore.kernel.org/20260807194513.1263310-1-ast@fiberby.net

 net/ipv4/tcp_ipv4.c | 8 +++++++-
 net/ipv6/tcp_ipv6.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b8887cdd66c5..e0fba4579a57 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1690,6 +1690,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	int l3index;
 #endif
 	struct ip_options_rcu *inet_opt;
+	int ret;
 
 	if (sk_acceptq_is_full(sk))
 		goto exit_overflow;
@@ -1756,7 +1757,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 		goto put_and_exit; /* OOM, release back memory */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0)
+	ret = __inet_inherit_port(sk, newsk);
+	if (ret == -ENOENT)
+		goto send_reset_and_exit;
+	else if (ret < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
@@ -1784,6 +1788,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 exit:
 	tcp_listendrop(sk);
 	return NULL;
+send_reset_and_exit:
+	req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
 put_and_exit:
 	newinet->inet_opt = NULL;
 	inet_csk_prepare_forced_close(newsk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..021c93de2273 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1400,6 +1400,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	int l3index;
 #endif
 	struct flowi6 fl6;
+	int ret;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
@@ -1512,7 +1513,10 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		goto put_and_exit; /* OOM */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0)
+	ret = __inet_inherit_port(sk, newsk);
+	if (ret == -ENOENT)
+		goto send_reset_and_exit;
+	else if (ret < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
@@ -1547,6 +1551,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 exit:
 	tcp_listendrop(sk);
 	return NULL;
+send_reset_and_exit:
+	req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
 put_and_exit:
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);

base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
-- 
2.55.0

