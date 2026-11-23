Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440328;
	b=E+pvSo3MhXndsHE+9ICKQ/4ZBmFGqil2bKrbNyDjSgl+dfGJKCwDWczNFAy2ju9oozt6
	 FjJpNYU5YhqMQ3QxS9f5//w083I8cr7/r1lMtcxfgF63Z/Qnv7fsW++Prz4+Cj5UByxLM
	 UUezXb8aUYNQ+5Q7gEbW9eO76cZF4+nSPQlBBdftWG1tPKPe0rfOYK2E5sjPgFm1Ah1gN
	 sDcgbS6ZPf2K0+iHKvxqVpW2KzeGZQDLkUMCaDs8OszjLwV0++yJif/K+58ZOjf7mBDak
	 f3E3nPxbGXbBpY/nY2FhTHe77DawhBjSl0pweev8OSwAJ58o+LFfEtLC3ueT5zQ9rFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440328;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6R0zS6N172iECvWqZi/RpO1fp5+dWMwp4TBDt1rOy7s=;
	b=5gOS2EIvEIpLjcOnrIRf5NGeku7zH2vhDQ8iLPW120oi5OxJo3yaHdSfKG8G017QOXuU
	 r4skZMSZ4eRTgCqEcmMcJ57cQ0WOkd1lQk+kLU+6bNVBWVKwgOpORGuyMg4gm3Ys2dCw0
	 uT7KgqPL0tcLIZqSdhFGM8gA7H9jgyX0xBTxx9s+ZcjAaf1aEsLbvK3UdFslSbhH0pVm8
	 sWJuH+TunKIr3brlpt326DqPIDCYT8UVQMrMBRaM1ThjT+AUowGmkz+p+FpqkoDO89aYz
	 aQ5TsekgvOR+hfllY3ON5ADinUZjn7cFuBhPw2AvBnw1PL1cWyX6wYYezxn74yKiWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEDwx3+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB19606A31E;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEDwx3+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C81F000C0;
	Mon, 23 Nov 2026 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440327;
	bh=6R0zS6N172iECvWqZi/RpO1fp5+dWMwp4TBDt1rOy7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UEDwx3+uNiHMUL4GO+K4dqiEN0B6XHou27kEd5w84rx8hnSsoSGKvY9Me7j01NG3w
	 8zNkBG2nEmVECvJ95ohI0fiqpXmGxeLe3mTf9xmJP6I4jRVNvJXw2SviBPuStQMSqy
	 ahyfPtC/0U+qNIoeFOaowGeCwZVhUQ1UA48+dy54MJ20ZuGru9dgseCk8R8m8oOZMB
	 HhrZisbYfr7PvY6xoAYNudBRcxJ4j7P/oR92cdpQqr55kqOVml+Aj8tyQ1x9AF9N9p
	 woo1wTprHvY/8zbhz36YQYasIu+ITRuZ9EsitXT4IZfg/SRjxuNvXyywvFSuskgxtu
	 4r3CoycoOjDmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:49 +0100
Subject: [PATCH net 01/10] tcp: drain the queues of a listen() that fails
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-1-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KnhMwAMfUYPYaDgdpX1a2kmd2Cm5s4SvnOfH/+Eo+Og=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7HYkGLsnnXU/4BrlKNnWGdxxTmhh1ZzQQ/tOqRtHv
 5Xd8Seno5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLu8xgZ/hueWrSIXWsHJ9M2
 3kmCXIq3rfsrmCdcC2yL+7vdXpL/AMN/r5gK3jLDz5rf57xxfSzM37jjlQ33x6rMIwxSwVdtPh7
 kAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

If listen() fails on a TCP socket that has listened before, the sockets
of connections from the earlier listen() can leak, together with their
network namespace.

inet_csk_listen_start() sets TCP_LISTEN before it calls get_port() and
hash(), and its error path sets TCP_CLOSE again, then purges the Fast
Open RST queue since commit 342e62fd34c2 ("tcp: purge Fast Open RST
queue when listen() fails"), but not the accept queue. Pending request
socks outlive an earlier listen() and still point to the socket, so in
TCP_LISTEN, inet_csk_reqsk_queue_add() adds them to the accept queue,
with their new child. These entries, and the sockets that they hold,
are never freed, since close() drains this queue only in TCP_LISTEN and
the next listen() stores NULL in rskq_accept_head.

The fix used here is to call inet_csk_listen_stop() after the error path
sets TCP_CLOSE, which also purges the RST queue, except for an MPTCP
subflow, which needs mptcp_subflow_queue_clean() first: only its RST
queue is purged here, and mptcp_listen() has to drain its accept queue,
which is done in the next patch, "mptcp: drain the queues of a listen()
that fails".

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user: listen() failing with EADDRINUSE in a loop,
while the connections of an earlier listen() complete. Without this
patch, sockets were leaked, and network namespaces too when each round
was in its own one, without any message from the kernel:

  result: request socks: 10000 made, 2535 left. Sockets: 33373 made, 5070 left
  [...]
  result: namespaces: 1000 made, 694 taken down, 306 left

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Commit message: how the issue was found, and its
  symptoms. On top of commit 342e62fd34c2, with a Fixes tag for the
  accept queue. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 9a3b05edb62b..2e27b3e592a8 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1382,8 +1382,8 @@ int inet_csk_listen_start(struct sock *sk)
 
 	/* There is race window here: we announce ourselves listening,
 	 * but this transition is still not validated by get_port().
-	 * It is OK, because this socket enters to hash table only
-	 * after validation is complete.
+	 * This socket enters to hash table only after validation is
+	 * complete, but reqs of an earlier listen() may queue children.
 	 */
 	inet_sk_state_store(sk, TCP_LISTEN);
 	err = sk->sk_prot->get_port(sk, inet->inet_num);
@@ -1401,9 +1401,13 @@ int inet_csk_listen_start(struct sock *sk)
 
 	/* A Fast Open child accepted before a previous shutdown() of this
 	 * listener might have queued its request in rskq_rst_head while
-	 * we were transiently in TCP_LISTEN state.
+	 * we were transiently in TCP_LISTEN state. The accept queue of an
+	 * MPTCP subflow is drained by mptcp_listen().
 	 */
-	reqsk_fastopen_purge_rst(&icsk->icsk_accept_queue);
+	if (sk_is_mptcp(sk))
+		reqsk_fastopen_purge_rst(&icsk->icsk_accept_queue);
+	else
+		inet_csk_listen_stop(sk);
 	return err;
 }
 

-- 
2.55.0

