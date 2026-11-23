Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440352;
	b=uxPiiR3A9vJJSYdA2PqqpfdYsKHMJiI0MjbUBamHgbCC+c0BuS8O52m9Su9wv5/fXuzx
	 CheAjn83WyJHln/Ps0BtBM2rAjibdgPY8KCuErKe8nZlX/1fbeTDOq76Fo37dvgYTmF00
	 acn0x+EuG8sybHvASZe1lSooUrQvu0FLiuBYiky45QxUxkxw1EnhgqNMjE76m2Ejtt+jp
	 S6R6pUvUK6hQcumyjifVdfMhfYEPEasTUVPqhnsK4a8bHLoO16zUFYBgwQ3D+n3HYm4fN
	 15XhJfRxwfYz0W5nrbkkYFE09LqxVQGJeZpbyeVGfEwXyT4JKIMmbWwLpTKBXY1auIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440352;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=agZbsxC8XRUaliCdELdXroftudvx5Dzam1Cf9BBH+64=;
	b=SUzfCRulywrFsnkinA/3GRBxaQJ3Hp1EdlsiLAmZOd2UlTmZSGkfcFKU7F9QhtTUXfWI
	 P3+hgUlw+ZPVo7KQ3nYy8jPttK+9C6c/mUnHyJBO1wFaZ6m8s7RkfLEfNvKU/9QTz0dBJ
	 tG7sHb7Pbur3axKtW6ImdKCoNn7/+ArtAYZcHq0bQBtAEtOvD40pB1S9O+rSQYaTGDAjX
	 MONMJyXUuxlLOmQuxmFbNhBO93GVF4VDDlnvO1C3K83Sui+W3NhMZoX58IwBuFJcAfnZ1
	 8Mpoxj5EVol3ZZ8IHPoMdWbm5QrygEkZ7+IIsO6EfAkJGC8J2i/LkKtZfnn9/RKLO2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xlicqqh/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595F606A69E;
	Mon, 23 Nov 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xlicqqh/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB11D1F02836;
	Mon, 23 Nov 2026 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440352;
	bh=agZbsxC8XRUaliCdELdXroftudvx5Dzam1Cf9BBH+64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xlicqqh/Cw5bLJbN+HG52G3c4xNs1cTXM2eUWfaRMqdL8BsntEygAFQEJ8dRXPpmC
	 8Y81BOcGdTRlrsz4uDudVuS18KQNns1FMIC5YXeSjs2bdIDRYr6UfrVVNfeAZheAvn
	 GHjOEMyW3ZDpQXeTry6Mh4iK2Z1uC3FFdy/OTfTdyBwXBzI+3R7jdXoBP+02I9uzf4
	 SV5CBphoyptb7mgzqdY7jujgjSYdcc2WZDivcZ1aeS5YEUrODG6qL+3dQsnDR0XU18
	 fRrGwX5GBgupI4zbj0bawQLKqt8memWF2YDnuNSAE1ZnOkFnzpaQlJFhpQDjz7qG1s
	 r0Msn1ugu9QIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:56 +0100
Subject: [PATCH net 08/10] mptcp: pm: don't let listeners pin their netns
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4454; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/+RpJZZCr+9fWGrIXW99TKLAy50OJBD8MN8jo5gWqtc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7PY+49geMVVSJO1/wQ+W9ysC3k2Ya/fH5Dm/2t/Tu
 aHiW3QsOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbS2MfwP8XG5vzrgL+c3Pk2
 69QcjWfPMe8v7r3C+rDtzON7RScTnjD8d3PIusF7Yl662rRos38HGc4I8f23tNU0edch9XMv/2Q
 9DgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

For a "signal" endpoint with a port, the in-kernel path manager creates a
listening MPTCP socket with sock_create_kern(). This socket is released
when the endpoint is deleted or, failing that, by pm_nl_exit_net() when the
network namespace is dismantled.

The MPTCP socket itself holds no reference on the namespace. But its first
subflow is created by mptcp_subflow_create_socket(), which always calls
sk_net_refcnt_upgrade(). So the namespace cannot be dismantled before
the listener is released, and the listener is not released before the
namespace is dismantled: unless somebody deletes the endpoint, both stay
around for ever once the last process of the namespace is gone.

  unshare -Urn sh -c 'ip link set lo up;
                      ip mptcp endpoint add 127.0.0.1 port 4321 signal'

leaks a namespace, with everything it contains, each time it is run. It
remains charged to the user's max_net_namespaces limit.

Only take the reference if the MPTCP socket has one. A listening TCP
socket has no timer of its own, and request sockets of a dead namespace are
taken care of by inet_twsk_purge().

The sockets cloned from that listener for incoming MP_JOIN requests do
need the reference, for their timers, but inherit sk_net_refcnt == 0. Take
it when they are created, with __sk_net_refcnt_upgrade(), from the
previous commit, as this is done in atomic context, and drop the
connection request if the namespace is already going away.

The TCP listener of such an endpoint is now a plain kernel socket, like
the MPTCP socket it belongs to: it is not counted in "sockets: used" in
/proc/net/sockstat any more, and its destruction is not broadcast to the
listeners of the SKNLGRP_INET*_TCP_DESTROY sock_diag groups.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
the command above, run 1000 times by an unprivileged user. Without this
patch, all the network namespaces were leaked:

  result: 1000 network namespaces made, 0 taken down, 1000 are left

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Use __sk_net_refcnt_upgrade(), from the previous commit, instead of an
  open-coded copy of sk_net_refcnt_upgrade(), with maybe_get_net() like
  rds_tcp_tune(). Shorter comments, and describe the condition: any
  kernel msk. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 20d506235074..3e674c21bdb2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -844,6 +844,22 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->fully_established, true);
 }
 
+/* Children of a kernel listener need a netns ref for their timers */
+static bool subflow_child_get_net(struct sock *child)
+{
+	struct net *net = sock_net(child);
+
+	if (likely(child->sk_net_refcnt))
+		return true;
+
+	if (!maybe_get_net(net))
+		return false;
+
+	__sk_net_refcnt_upgrade(child, GFP_ATOMIC);
+	put_net(net);
+	return true;
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -912,6 +928,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 		tcp_rsk(req)->drop_req = false;
 
+		if (!subflow_child_get_net(child)) {
+			subflow_add_reset_reason(skb, MPTCP_RST_EUNSPEC);
+			goto dispose_child;
+		}
+
 		/* we need to fallback on ctx allocation failure and on pre-reqs
 		 * checking above. In the latter scenario we additionally need
 		 * to reset the context to non MPTCP status.
@@ -1860,8 +1881,10 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 * Update ns_tracker to current stack trace and refcounted tracker.
+	 * Not for a kernel msk, e.g. a PM listener: it would pin the netns.
 	 */
-	sk_net_refcnt_upgrade(sf->sk);
+	if (sk->sk_net_refcnt)
+		sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;

-- 
2.55.0

