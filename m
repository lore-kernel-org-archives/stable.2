Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF472621
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275185; cv=none; b=ieg172pFy+vEMTHInUPYknXJMQx90DBmO9UTz4DDwY/N31By5jzh5XFDWq2Uon/qRzJZBt2Nab+SnYGze4XR41QcMD+cNz3tHDYznlouZzLlsLovJAGKJ428/PmOpMuLqwifFAd/MOLH9JD0XTSpHa98Ae2J8WJAgKYUJmGH4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275185; c=relaxed/simple;
	bh=MD4Zni5Xvsl9HTKYQazlvtU4N2SWd6XPlTzpvpWONnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVm66Cw5fQkc21G1y4H9eFa9K9vlkYYfnnZjgoBQcZm/FBfQdy3SW/R37qgCL95gjkSsqtb2ovAykgFHYOjAEhdKrlek0KswttuicNLXtlAlWbKBh3v5y5Lmoyyq+4L8bgWva4Zn6FXdMWpB9q+P1Jq4mAGUvRunytWLwzFr2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neeLOwxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neeLOwxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7281F00893;
	Mon,  1 Jun 2026 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275183;
	bh=T7UOGEspeEZvxWVT/x2Xf8aGfQDrN7+qvVoTUdCpm74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neeLOwxNOFmv8mDW2YFY/dT9iKcvRqqVdOcI3z3EIaI8pFYMX9VjaqyCof5zxLqxo
	 Xb1/HJAJa5Q6kfZwFshNvf5Rx43Q2044KhIFA88ZohXuApgarZFJEaVWy1/c2/bOR2
	 du7Q8EXzHYZh/1/esu0+AC8jhvSaRi0NQfOBHveh0ZTeGDlyD1OuZidRL0pNoYWLVj
	 WMYRRdP8EQwC6DAJHEQpLlzCpYYJXq5bJFKRk1EfuyBA3snYfgFDiPtU+9+PEQmOSs
	 dUmA2fQqbFz+y6biYKa1ksOWvf8xWNQLwZNHJ5q7JysoCskJuw301t87rLViQcRAir
	 TMEKVtnezr47A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: update window_clamp on subflows when SO_RCVBUF is set
Date: Sun, 31 May 2026 20:53:02 -0400
Message-ID: <20260601005302.101591-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052820-labored-unhinge-12d3@gregkh>
References: <2026052820-labored-unhinge-12d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

[ Upstream commit 3a543ae0e2092d5c2085d5f21f7a7dbafdffea3c ]

Add __mptcp_subflow_set_rcvbuf() helper to write the subflow sk_rcvbuf,
but also to call the recently added tcp_set_rcvbuf() helper to update
window_clamp. This is needed because the window clap is updated when
scaling_ratio changes, in tcp_measure_rcv_mss(). Until scaling_ratio
changes, the subflow is stuck with the old window clamp which may be
based on a small initial buffer.

Use this new helper in both mptcp_sol_socket_sync_intval() (setsockopt
path) and sync_socket_options() (new subflow creation path).

Note that this patch depends on commit b025461303d8 ("tcp: update
window_clamp when SO_RCVBUF is set"): it fixes the issue on TCP side,
but the same fix is needed on MPTCP side as well.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/619
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-5-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ inlined missing `tcp_set_rcvbuf()` to `tcp_set_window_clamp(ssk, tcp_win_from_space(ssk, val))` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/sockopt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b5bf47218a18f..580ac41197649 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -67,6 +67,12 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
 	return 0;
 }
 
+static void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
+{
+	WRITE_ONCE(ssk->sk_rcvbuf, val);
+	tcp_set_window_clamp(ssk, tcp_win_from_space(ssk, val));
+}
+
 static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -100,7 +106,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
@@ -1491,7 +1497,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {
-- 
2.53.0

