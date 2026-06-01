Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EE1465B4
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274656; cv=none; b=LXjli6WI5FsNZ0YVDlag+cPG+VluSjXb+KQcBbislPv0168NP+mFdlKBD2jwCaxMqPkNMIPawSGXs+UhkxplplgOt0TstUplvySHs6AtjyKB/XxzOdqy5his7mu1rV1h5ldvZ3gMBebQdSaunBtOnzTU3e8A27YPJj5B33FEpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274656; c=relaxed/simple;
	bh=C5K+IURjv1GFRGM6G2rDKQkH9tyxqZ8qkMSQ+yWMaJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEIfGUvsAfA2zHvtjpJpDt1QbBoSEcse4el6Z2WdRM6g0I3ixX+usnYzjnLRtn74C2WCUG1woUpbNIk2DVsTCqa0C2gHRXF6ieExApHTJ9s6lrX++rlt3IFbi6zO3vmgqABpyyQdnciDgVITtk45tJdCgAgVKGdWcDI/3zVU/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUwjgqIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUwjgqIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF15B1F00893;
	Mon,  1 Jun 2026 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780274655;
	bh=bt/RlMss2gDhEF0SrsIdoI+u5Z2Bk/zlNfVfB1kckSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUwjgqIGHNDiD9frPHc8nYzlio+yMWDd1NBByYaTTRd9DvOtaX2oMT0e6sJHRTjWL
	 JM3pP4WhJTzJOQ+cKcufdBQGyqb5EPAfYjHmtZUwkm1xf4prNmoLo4Ngz4p6eqgiL8
	 b2OmqWfOus/HqkXi0/tjoVlT72ra8ekotWiQFkG3BATM/sO6Be0DpqWa0Z1X33E6kF
	 0tSCbDvvVDOtxPlhm3I+DKOb8bD0UDgcACwBusMTZkFqZTbZTvPGAI/tRBFPUG++I5
	 fuUyK12QD9px6GhqpcEzLMfpeg5hqxOAa12LaUWPAKZyqw3A04wOGbTMCuLlUjG3Lf
	 V4Oz9yGiriJIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mptcp: update window_clamp on subflows when SO_RCVBUF is set
Date: Sun, 31 May 2026 20:44:13 -0400
Message-ID: <20260601004413.90717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052819-lifter-chariot-8dc6@gregkh>
References: <2026052819-lifter-chariot-8dc6@gregkh>
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
index de12b3c548edd..566ab5e6c8621 100644
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
@@ -1558,7 +1564,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {
-- 
2.53.0

