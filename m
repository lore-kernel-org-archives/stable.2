Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D3392828
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652109; cv=none; b=YJvRSF5X56veY5WRbFEMTXyFxDsajPqZ7LLkGIPA7zYuD/g5IzCDNsbyg+0Yy3yWI/GPL8hBl9akGClFD0yq5cU3kCPmD9YSd066dkF8rGaINhNIuMiFnsK9aR3YOpwNa8nPNR2VT+1LuiyxVpIzfngTNmvSWiMunogY5RQlVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652109; c=relaxed/simple;
	bh=P4hz2A8fMbSxCHGZYWlFg8fR7bAiNWDqFHayZqWpmPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWv6joCvWoDPU8xrVTiqhzGXNxjkbi7PXKVxsQfzdBgz8IzCC42+r9OjBPjP7jgO/KU7Ut+M/Bti0JnQKCDMId9mY4qQzLVvr/epTnRZYpSBLA6rQc6MLEfhjyMAy5SsIXPYin38RxI6B7rk4jhzyhSwQnlUDw336T9oSroUGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDCTTAJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDCTTAJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA98F1F00899;
	Thu, 17 Sep 2026 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652083;
	bh=EhMNUQfXPEyydEYJz71FkkzFPk/t+8zSJaWoNNpmY1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDCTTAJ0khhd7T9/mZjQGxFu7WfOpjFddr/yA0J10YCekC6oOU3phIYo6AWsy+ldo
	 FtPQuYbPr43Ca/+9gy3RusFlJzQfcVqEvEJN8hcqzWTY/peo+TKWkNZFRVVgRRsA+5
	 reRa9QB6lwUva9Qg0ZPd4Q7nfBXJPk6/HorzXdZQN+KmCfsIGRp1Tri3q1KEZf6Oro
	 5EXKZ6QIAxsWiEa/er4ta6s7wdNDOnSJ5s/1yKWCsuLTz7GiLQEx6CGvNZVY33tytG
	 0JAszko4e6aYKjAfgzUjQvipxYzJ0jSmSBYGnVzc1oDQq09W/Ma60KpRbeWGXNT0Ot
	 CEhxP1m1Fv3EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Thu, 17 Sep 2026 09:34:40 -0400
Message-ID: <20260917133440.405725-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917133440.405725-1-sashal@kernel.org>
References: <2026091622-thieving-raffle-4915@gregkh>
 <20260917133440.405725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 85c580b0d8590520ae00a15c29e9fb9c99427a3e ]

Sashiko noted that the two event can race, leading to inconsistent
status. Prevent the race using the synchronous timer stop operation.

Cc: stable@vger.kernel.org
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70810fa673c34..3e01ed990cf07 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3267,6 +3267,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3279,8 +3280,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = icsk->icsk_rto_min;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
-- 
2.53.0

