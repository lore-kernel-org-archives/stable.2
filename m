Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440356;
	b=OKPCtDQjUrhfjDHY7tRWu1DmFixYUsNVpUGbKKe6lCijjTZOinl5tpGA0gcQzb7yDrDu
	 4A542B6Epjw20FOz75xutc82Qr84b889n7RxW2hdnpx+EeFxXDGosxNfA1OXhiB1U4oGs
	 NGn0XI1cRbcB52ego9xUNEipF6V+yiUZTPDlyNQ+HeKU5dCLwJalFz1nPFVj5FyOS3jCZ
	 75bDkJ/gleNxgkiq+LBWgV6O+LkgTmSM2Y7VVgGzdAGlQOaCGi5kLfun8YUBPQPkCxP60
	 oqQczVAd/DkLS/0qM4nEOlH7KuwoxAWTGfcAjS/bf/K8NhJVsogjnddAbgfOVXrKynA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440356;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vo5WUJPjTE8BWwdri/c1H0F7M+oopPW8vIab7gd30TY=;
	b=UitVBLQNrqim8H0iRRqE0iaqlHINoKmiurLx8OXWRX9i1qIAr4wq+EbExso4Vr6y+5cT
	 vy8czpw2kx2Zep98HcCkVJF33sCIL4fhk1Q9Mgo6ykN1ZGHHN4wPk3IB3QXWvFWRDDCln
	 +zcHU1bKVAz4RqlCKGON9twbEwtQGhAGQjuwhljBXep0xrF/yK2hWh6S15XOp2LdrZ91R
	 vJFCChS4yX/bDGQoRzffNwBBxgbL3oiYNeziplAmdkSS4QQra6FxATLymyG2fVcfjfRje
	 gu4cyQNXjj25Qae7KtodGr+fI7Yd0VYM7VluC7ztHoVlIPM+5MHNQLU2E2OEqyVKiCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Irmlc/mO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749460A2600;
	Mon, 23 Nov 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Irmlc/mO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5A1F0283F;
	Mon, 23 Nov 2026 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440356;
	bh=Vo5WUJPjTE8BWwdri/c1H0F7M+oopPW8vIab7gd30TY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Irmlc/mObBKbg5o5DVhzTlWmm2RLuoFwetcxyrvsqnhMh3i1CY/FGxpQrGOE3XuQf
	 wd3MbXeqaq57yn1dq0ToNmffm0Vc0S5LTbX3K2VUW+FfvUlDKf3ozjJQPbz62QyxQH
	 CvbcSzVL3nTdTBHhsGXSCczIiVEoSBwZHKE4HNKs7RVD5ImsS1mqWJrkW9Y8MurchP
	 rGhGwSCBC0si8xgVuvmZN2rym/4Aozm8BoKjvMlEGS45BjRtFVD3V1qCVjdGR5LoUj
	 8O/NN3gGYvFGbiwzxz4zvrUHvaSWSaYirMyjjEQ0LIX+sUhMih7PGwLKp0pAEfahNp
	 +QwPX4naL/NFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:57 +0100
Subject: [PATCH net 09/10] mptcp: initialize drop_req in subflow_init_req()
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-9-278042217e8d@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qc4IGFaSg5Eh0l/L4vMsKDmfSUE8oIAs7yqqnNJAt+o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7PYdSFZWXst0r6p96835aXNS8uOPBu3SF9x4eJ2op
 dcP1kNnO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy2IDhn86CNXzGC9mn3ch8
 McWj4qCI+dHgrVzM7xvfhX39s6xwz0xGhpb8e6ZS8SkXp36sO/qnyU3rgmnR8R5BbqtfdYcnHMo
 4wQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With CONFIG_MPTCP and SO_REUSEPORT migration, which
net.ipv4.tcp_migrate_req=1 or a BPF program enables, TCP sockets can
leak until reboot, and each keeps its network namespace alive.

tcp_check_req() keeps a child off the accept queue if drop_req is true
in a request socket that an MPTCP listener created. drop_req has one
writer, subflow_syn_recv_sock(), which tcp_check_req() calls before that
test only for an MPTCP listener. But if SO_REUSEPORT migration moves the
request socket to a plain TCP listener, the test reads what the
allocation left in drop_req, and nothing drops the last reference of a
child that stays off the accept queue.

The fix used here is to set drop_req to false in subflow_init_req(),
which runs when the request socket of an MPTCP listener is set up.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
run as an unprivileged user in a user namespace, with
net.ipv4.tcp_migrate_req=1: an MPTCP listener and a TCP one sharing a
port with SO_REUSEPORT, the MPTCP one being closed while handshakes
complete. Without this patch, the children were leaked, with their
network namespace, without any message from the kernel:

  repro: step 3 to 6: 32 SYNs, 16 went to A. A closed, 16 third ACKs. accept() on B returned 0
  [...]
  repro: RESULT: 16 children never reached an accept queue
  repro: one RST for each connection. TCP: inuse 0 orphan 0 tw 0 alloc 16 mem 0
  === exit code 0. The process and its namespaces are gone
  === after:  TCP sockets allocated, all namespaces: 16 [...]

With UBSAN, the original version of this patch also reported:

  UBSAN: invalid-load in [...]/include/net/mptcp.h:144:47
  load of value 14 is not a valid value for type '_Bool'
   tcp_check_req.cold+0xb6/0x189
   tcp_v4_rcv+0x11f4/0x4230

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3e674c21bdb2..054ee992904e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,6 +151,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
+
+	/* read by tcp_check_req() even after migration to a TCP listener */
+	tcp_rsk(req)->drop_req = false;
 }
 
 static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)

-- 
2.55.0

