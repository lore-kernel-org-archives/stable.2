Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8F3016E1
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150776; cv=none; b=c6wWSyDytO1P0SATkh0RzTHbSanqwpcoSpL4dsPB3Tb4ae0ixvmyi48HrVwpjI2mJ4hHPZ7MjEEFO8KTCSKKlyG12lFf5FlXS9TfGHQjVicSVWDTxQsikQ2YABTQtDIoZwLva8EmZ5mZxv41QSXQCeOdTqdXY2Bm8/iYKBQa8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150776; c=relaxed/simple;
	bh=i4mH2dq8Haz2G/gzT5ZPNm2AWDplZIhm3+ogWCW1wXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sER0C0IJmGlqVURUL5whjnYwg7VBhgrONZELCT7ge0Y4q69fw+14oucnxrjvx5TVklvMs48BJz1nhV32PtcBIphTVD4n8slJp9gPbw9GerI+8OqSPLrcFo7gtxPvAHGtVJGofjipNY4zCBtt9jBam1+drGnQG6pQ0nhvmCOkSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuXKKa/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuXKKa/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BB41F00899;
	Sat, 30 May 2026 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150775;
	bh=TBZVgQQ09o7SfgDS1dsaVHzn+cq/7gsSGj6UJ30o3Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fuXKKa/xPNgguXfZiKg3nzVZPb0Whm2AUijOdx4q+R9sD4AQUciutvPtgOoIhZC+R
	 gj/7nteoFWwLthDhEfApMD69AO3Naj9jPWhQgPzTaCSwgzCV+AA8/9cK0MxSddGO/J
	 S2PpmpbCWRv+Tr5ayK0L9NGDG6qjWGAQ9MIGOBW854tyNdxHGVAfoIsmxprxg5lQRa
	 dAqg4CXbsSwiKI8JLdhNhWx/Tmr5WrEb9r3buQseZ5t2h6eq9AvB3I0x9ltulaYixs
	 a2reY2KPTQscj1yHV3/gp2mAuQqnLI9+ClA23Y7HVeoZOB9YsWpWG9+3xEqKuImGFv
	 5PFVz/CfRx92Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mptcp: handle first subflow closing consistently
Date: Sat, 30 May 2026 10:19:31 -0400
Message-ID: <20260530141932.2407122-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141932.2407122-1-sashal@kernel.org>
References: <2026052836-subscript-earache-630d@gregkh>
 <20260530141932.2407122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 0eeb372deebce6c25b9afc09e35d6c75a744299a ]

Currently, as soon as the PM closes a subflow, the msk stops accepting
data from it, even if the TCP socket could be still formally open in the
incoming direction, with the notable exception of the first subflow.

The root cause of such behavior is that code currently piggy back two
separate semantic on the subflow->disposable bit: the subflow context
must be released and that the subflow must stop accepting incoming
data.

The first subflow is never disposed, so it also never stop accepting
incoming data. Use a separate bit to mark the latter status and set such
bit in __mptcp_close_ssk() for all subflows.

Beyond making per subflow behaviour more consistent this will also
simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251121-net-next-mptcp-memcg-backlog-imp-v1-11-1f34b6c1e0b1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 50c2d91c5dfa ("mptcp: do not drop partial packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 net/mptcp/protocol.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4fdce559a2235..9b8f7d2bdb315 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -877,10 +877,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	int sk_rbuf, ssk_rbuf;
 
 	/* The peer can send data while we are shutting down this
-	 * subflow at msk destruction time, but we must avoid enqueuing
+	 * subflow at subflow destruction time, but we must avoid enqueuing
 	 * more data to the msk receive queue
 	 */
-	if (unlikely(subflow->disposable))
+	if (unlikely(subflow->closing))
 		return;
 
 	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
@@ -2514,6 +2514,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
 
+	/* Do not pass RX data to the msk, even if the subflow socket is not
+	 * going to be freed (i.e. even for the first subflow on graceful
+	 * subflow close.
+	 */
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	subflow->closing = 1;
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
@@ -2524,7 +2531,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2533,8 +2539,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-
 	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
 		tcp_set_state(ssk, TCP_CLOSE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9ed9cb36e9bbe..8ba3b0244bad2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -537,12 +537,13 @@ struct mptcp_subflow_context {
 		send_infinite_map : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
+		closing : 1,	    /* must not pass rx data to msk anymore */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
-- 
2.53.0

