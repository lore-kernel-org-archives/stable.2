Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866939;
	b=DDxo954dcmlOnphyFq1XFcglCoCH+fx5yW0jipSZ1AOPz9jbRnrrFDL9UqaAAjyzGe7K
	 RroJXkvRzBaKo3JT4+IAfAPzQVqzi1ae2JqbeVXl+wN9ckRXr1GZWYX/VMm6Awm9gGHct
	 egFFtvUK0IwVNZg/rj+FUm7+ILCLQryZdi2YeCda5TFxLuL4PSIJ2Zo+sX/pivT1C4NGh
	 BwuQO6QgZMVx5djO4OUf918hkFEmt1fJ0XfCx3aketUYornXHHSi1KegoPmIxtpKHMpw9
	 SPBdNfXpwHqJwssFZT6YHtt3qv8ais6K658NTsd4vd0XYSWxYN6awJoGxJq1aFl20NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866939;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XqaW+Qhx8VDnAfYz2JghfbB6/NHBkgGqjkXI2iJsQaw=;
	b=PjRZYiL5xd0wZ3aeDQCZSF+61YPF/Dn7C3uLdqUfDssWOGOmCaJryZm2mTipXFKDChbW
	 AAO635bkTwWmj3eIKgfwwf2fEnStvz3gKPvcVyo5TbRvoneNtV0/B5cS1nfAJXjrAXqKK
	 1frmoDr5onDq/6KnA14OIDRNtOo+1UWy84U0igC/wzLxwgs8y3yXeNJROuQDadDa4fFvT
	 lwntin/lAaN42OeHlOWfZ0Z2/NwliexkZsnM1ili9ewLi8NSw5ZAX1T2GCiMsgW8p0kN2
	 asHCNBWYFAdhVizZXg45FuNzfyHdI9jvEAxwAj2S0u0Qk68xA5c7grUrXOu2T6RHzow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6RZv3rz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D9606A898;
	Mon, 16 Nov 2026 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6RZv3rz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036AB1F000C4;
	Mon, 16 Nov 2026 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866938;
	bh=XqaW+Qhx8VDnAfYz2JghfbB6/NHBkgGqjkXI2iJsQaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V6RZv3rzfI9+SBVg+revsPO6JStwynq3VsxgmT4Pw47vOj0SuUDiS74oS00zM/qSb
	 wfsGlXcJ91T8XSKQMri9HCZrkxZ99CBSpbI9HNm0M4+brQ3ciAh1v61yRThaWrUW88
	 kiTWkyQRLSfZVVAshK/4aseJ1/ZhqdB76UQii7VJhkKvC0quBI0+TOL/boEjnyVCiu
	 5OTxSNXmQxXe63PRRuPIRLnpTbplOdmFOQfycAr5yIgKHOmb7sugjZo2hISQtiOvkI
	 a+DIZ3Hhqwn1iabx0hZuxvatAqat/zV+tu2+tbzqo7DWELgmTw00HzNs31tBr5hjSb
	 87gqmgWmF+6aA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:11 +0100
Subject: [PATCH net 4/7] mptcp: push queued data on passive TFO subflows
 becoming established
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-4-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Petar Sakic <petar.sakic@ink.fish>, 
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=d/ZZTVBXnUn2aIb2rzqSvZ8PZ3bEm+rqCAf6ZVsqk2g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+173oa17MvcekNbtcp++8RyWb3bf3Cwp/+VyZ8jXGw
 fLfzT+XOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiYMHwT83pfsP247cS1CYG
 /t133Fv88G2eBOfImSaed+v6M/u+fWRkWOxvXrElc0HnnhqJxRXNjSoc4Xu05TsZzfVqn39N4Xb
 jBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP Fast Open, the data written by an MPTCP server before the 3rd
ACK is not sent when this ACK arrives, but only when another event
triggers a push, e.g. new data from the peer. With a request/response
protocol, the client waits for the reply, which can then stay stuck.

A SYN with a valid TFO cookie creates a child socket right away, which
can be accepted while its subflow is still in the SYN_RECV state. The
MPTCP socket is already in the ESTABLISHED state: send() puts the data
in its write queue, but this data cannot be pushed to the subflow before
it is established, see __mptcp_subflow_active(). When the third ACK,
with the MP_CAPABLE option, arrives, check_fully_established() marks
the subflow as fully established, but nothing pushes the pending data:
this ACK has no DSS option, so ack_update_msk() is not called.

The fix used here is to push the pending data when a passive TFO subflow
becomes fully established. Checking subflow->is_mptfo is not enough:
since commit e00b63056fb4 ("mptcp: fastopen: only mark MPTFO subflows
with SYN data"), it is not set when the SYN has no data, while a child
is also created in this case. syn_fastopen_child is then used instead.

This issue has been reported by a user of proxies over MPTCP: the
clients put their requests in the SYN, and the replies from the targets
close to the server were stuck. It has been reproduced with new
Packetdrill tests, where the server writes data before the third ACK,
after a SYN with and without data. Without this patch, and before the
earlier commit "mptcp: arm the rtx timer if a push leaves data behind",
this data was not sent:

  server-tfo-write-before-3rd-ack.pkt:24: error handling packet: Timed out waiting for packet

Since this earlier commit, this data is sent, but only when the MPTCP
retransmission timer fires, here after one second, as the tests increase
its interval:

  server-tfo-write-before-3rd-ack.pkt:24: error handling packet: timing error: expected outbound packet at 0.237174 sec but happened at 1.181857 sec; tolerance 0.100000 sec

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Suggested-by: Petar Sakic <petar.sakic@ink.fish>
Suggested-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/mptcp/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1c58468b985b..bcf3440d1901 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1047,6 +1047,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock(sk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	if (tcp_sk(ssk)->syn_fastopen_child)
+		__mptcp_check_push(sk, ssk);
 	mptcp_data_unlock(sk);
 
 check_notify:

-- 
2.55.0

