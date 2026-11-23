Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440331;
	b=r47wX0Dybv2tnFp+0WOzfBTQRkO73Sj79VhFyPzxm0TUS3R7cSxe29y2AOJey9Ohq5NE
	 gcmlVTiJuXo1kFOppRQAj0778k5g00Z4sacs1u/dGNpXH2p67in74/CuY6VCpjGkcl4Cr
	 M2fi7MvcqG2oHKA1+5RUCx2odhh9qh1vH46QpcvZKPQQ9zRjP73HbYF26ivRRGY8uRwWX
	 4DTWuE8tWA+dsNRk9/KSiM6hikiroe5825H2TfGkeuTRIZWeFdI5jA1SRjUTO+jGsWs9M
	 Bgpw53ekJaigbXuI2ePGFa8xq8z+cJUTliSddufQVSnjZKTJv1TQsUxJCpAlbQYt96w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440331;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5Og4wPEpf33bGTGjibI2FKvY8gzfx4KipgO1zg400HI=;
	b=46JF105YN+WbWK1XqbjAOFFlaDVBD9rfPqNSlCojCFZ5gnItsNKx62Qazlg0EjFwdhHL
	 UcrsMYztjR96fAlrRhXXDjYWCRcXaNs4EjcASwTMTYNgsxeo8tCGaA6BOToI+Aent1YmI
	 m4Gtl+sCybI50zqiTse8Ut7RT38HBnDq5UonFlfk8qvdaRYZJoEnvPtTRgHowKgSHFjl4
	 ZCNWkfyMIQ/tM81iRk1R6YH+mx4i7HqklnnrCJjRfzQgJoMJ/7orju6aCPgm0s/PD0Lcv
	 xnY6Do2YVbEeJAS9fMGv69WgpRSRxC44JwpI1vIDT4sEMNM8Q0ifOExwf/pDejF0wfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYrLs4xx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C849606A31A;
	Mon, 23 Nov 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYrLs4xx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC1A1F000C0;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440330;
	bh=5Og4wPEpf33bGTGjibI2FKvY8gzfx4KipgO1zg400HI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SYrLs4xxjlE+W9jwIaVnjMfMZQps17wlsnjriKk1pYedZzY6MTXo53ZqG+N1XiBTs
	 eXAdnjJkn6XMUkCnZUFzWmfgKOzkO04ii9/L0DAQnyFm2Ej3UQyH90P+VIhYtXid70
	 kXvRIT7EBzZ8A/cAoDfezzKIoXfdKuzeRAKGAVk13yZok6OzF20TOrTGhvq8OZnlIF
	 Wk8hohNYFcc+fYQ3EqsyfYfgth5huC/0ZUIeRO1YYYfIq39IAwWTGjgQ+VNn6g695+
	 Mt+0itpsBlmIdjYtcsAZhacI5Ddn1sV8GnepfDYfrBCsR5ssryIJBoX2EM4Luqe33L
	 fxRFdP0Y+qWFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Nov 2026 14:24:50 +0100
Subject: [PATCH net 02/10] mptcp: drain the queues of a listen() that fails
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
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-2-278042217e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2rgOVhu1I0CypO/fm+P6652Bhfc+fCsfBf4Pl3a7+LY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7HbetzsQ+cIjN7gu+155cF/wf626O2U3PM7Pt+o9I
 5ZiVZ3TUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGlqQz/69/4LyjzOxL2+uUE
 Ie3VfoVn+rLlClKFpa9lVShVyXonMvyVdzw0wfORZ9TT6hf5PgdEHtefk3DQWG9l/pRvmcI6YRV
 mAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

Sockets and their network namespace can leak, if a handshake completes
while listen() fails on an MPTCP socket that has listened before.

mptcp_listen() passes the first subflow through __inet_listen_sk() to
inet_csk_listen_start(), which sets TCP_LISTEN, then calls get_port()
and hash(), and sets TCP_CLOSE again if either fails. Until then the
subflow is in TCP_LISTEN, so a request sock of a previous listen() that
still points to it can get a new child and be added to the subflow's
accept queue. But neither close() nor the next listen() frees what is
queued, and the earlier commit "tcp: drain the queues of a listen() that
fails" only purges the RST queue of an MPTCP subflow, which needs
mptcp_subflow_queue_clean() before a drain.

The fix used here is to call mptcp_subflow_queue_clean() and then
inet_csk_listen_stop() on the subflow in mptcp_listen(), if
__inet_listen_sk() returns an error with the subflow in TCP_CLOSE.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer of the previous commit, modified to use MPTCP
sockets, on both sides. Without this patch, sockets were leaked, and
network namespaces too when each round was in its own one, without any
message from the kernel:

  result: request socks: 10000 made, 1151 left. Sockets: 64982 made, 5755 left
  [...]
  result: namespaces: 1000 made, 923 taken down, 77 left

Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Add a Fixes tag. Commit message: how the issue was
  found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b375da1f17fe..fd88104f0631 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4340,6 +4340,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
+	if (err && ssk->sk_state == TCP_CLOSE) {
+		/* inet_csk_listen_start() leaves this drain to MPTCP */
+		mptcp_subflow_queue_clean(sk, ssk);
+		inet_csk_listen_stop(ssk);
+	}
 	release_sock(ssk);
 	mptcp_set_state(sk, inet_sk_state_load(ssk));
 

-- 
2.55.0

