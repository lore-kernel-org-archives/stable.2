Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CA4B0499;
	Fri,  7 Aug 2026 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132065; cv=none; b=MxFluoae95yKl7cG6xarSK88uXtFEIvkVkVpPFCKZXhoKUtNwXWoBI1X6cVZnTmJXEeUv2q4ZyNpM29DrigAVk0otAk9MqPVmI2qI/YXIloX21igWQGVmhRm5GzBB7t8yTgO37X12ol1VUtpNN6G92SWL0DyNwIDNc2FRIbRzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132065; c=relaxed/simple;
	bh=QntrGngumTcllej+FfCdcocjCbzb02RXnrTN48F9GKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cGZl9o2tQHKvIrAJ0tNpULCQJDQh9KDjPdTgaw10UMQmWGjqWsW3okVSKklDugwhkj0jge1gPRuvl16/7Bo6vtzLnrW8trAB/eniv9VySK9685AznLMo6q7JoNVxbXiOeb/HR6GIwBUloFbvBUNdRNoy7WzL11JkGib9aUyst7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=AHtEEN5A; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="AHtEEN5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786132060;
	bh=QntrGngumTcllej+FfCdcocjCbzb02RXnrTN48F9GKI=;
	h=From:To:Cc:Subject:Date:From;
	b=AHtEEN5An0lY1ClT5rM8Ep5yspcSNQhvDxsEHiwF/HjupGcU9295W9RvK98P4lY7y
	 tQinRY4ZOBflPrVuFEuQNO5SXXC5kFRt8FrKtl9PT2awrwwKbpc3md5Qvo9rdY4jf1
	 OOiwlTWq0yzzlnU2qtMgHuUunD4i5JOH2n7WqX2iy+83m3qsqXI1BYcEOksg+rSf9B
	 h50UzZuReq5DF3px9nQqwR4+QNHKi+PBv4Bm8tFocte6VHAvQ/BAQfYUEo1Pse7RC8
	 Rn4cFaDAeZIP7EzDjUM4t6QWgmELRGqauRoaVFOxPruJKsVqfz5YtlUZIDfGIAiaXA
	 CWc6ZSRZZimXQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4F225600BF;
	Fri,  7 Aug 2026 19:46:47 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 20787201E49; Fri, 07 Aug 2026 19:45:45 +0000 (UTC)
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
Subject: [PATCH net] tcp: reset late connection after listening socket close
Date: Fri,  7 Aug 2026 19:45:10 +0000
Message-ID: <20260807194513.1263310-1-ast@fiberby.net>
X-Mailer: git-send-email 2.53.0
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

This allows for a TCP handshake to complete, after the listening socket
has been closed, and after inet_csk_listen_stop() has been run.

In that case the client sees the connection as ESTABLISHED, however in
tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
-ENOENT, and the new connection is dropped silently by put_and_exit.

A client may therefore hang indefinitely on a blocking read() if the
used data communication protocol is initiated by the server, like SMTP
and the reporter[1]'s MariaDB protocol both are.

Had the new connection been processed before the listening socket was
closed, it would have been in the accept queue, and been notified when
inet_csk_listen_stop() was run, and the client would have got a reset.

This patch adds a check on the state of the listening socket, and
resets the new connection, before discarding it with put_and_exit.
The check is placed just before it would fail in __inet_inherit_port(),
and just after TCP MD5 and AO options have been copied to newsk.

The blamed commit was identified by testing on ancient Debian stable
releases to get a rough scope of where to look, then identifying in
which release between v3.16 and v4.19 it broke, and finally bisecting
v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
that era, and confirmed by reverting it from v4.3, v5.10.y and net.

Reproducer:
  https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c

Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
Fixes: c82199061009 ("task_work: remove fifo ordering guarantee")
Cc: <stable@vger.kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

I'm not submitting a selftest at this time, as I have only found an
efficient way to often detect the issue, not disprove it, and I would
need more test data from different systems, before I can reliably
disprove it with a low runtime budget, without getting false negatives.

The check could also be "sk->sk_state != TCP_LISTEN".  I have only
seen TCP_LISTEN and TCP_CLOSE at this location during my testing.

IMHO socket migration is out of scope for this patch, see commit
54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in
accept queues."), as it would complicate backporting to stable.

I have not yet tested that MD5/AO works, I guess that would involve
extending my reproducer to place client and server in distinct netns.

 net/ipv4/tcp_ipv4.c | 5 +++++
 net/ipv6/tcp_ipv6.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b8887cdd66c57..45d9a7e40e951 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1756,6 +1756,11 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 		goto put_and_exit; /* OOM, release back memory */
 #endif
 
+	if (sk->sk_state == TCP_CLOSE) {
+		tcp_v4_send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
+		goto put_and_exit;
+	}
+
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa7..c7aa3c6b1c314 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1512,6 +1512,11 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		goto put_and_exit; /* OOM */
 #endif
 
+	if (sk->sk_state == TCP_CLOSE) {
+		tcp_v6_send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
+		goto put_and_exit;
+	}
+
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),

base-commit: 594d905195024b228c962627ae5ae7c17bd582a4
-- 
2.53.0

