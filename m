Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D62FD7D3
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153664; cv=none; b=UkJxJyvv3lpGiU/vJXMhagN9G1OsHntqCDvbzRNSFsfZsF8b25ubFNJ4742H7zFE3m9bO5uuz1nJVWaVMvsvEPfoQBJFClF9CijCSMoUR7Ooh8meBpXYykmp4GhTYcMwExJ/IhAB4MhuP7ftpSGl1L2OwzqABPvsbH8ihvtSOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153664; c=relaxed/simple;
	bh=4ITldezE7KVQD10cBCnP3Ycy8CtVXwZPKR8YTdayl/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf+sunub5rIYR5VzYPTvLx+qP1zz5V1RrNX2jdwenV/9ZWSwQcYAhIZ36Q6klyH5TOHn6bP556j+YHOGL0pHd0bO+6Szfu0tWMvrgDezJCqzRD8ZbPfZ5wS8BiPurixhlidL/UdLCNsnNR6q4HH2iYboXmQtNX+HNGL3KmlYXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbD05PKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbD05PKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A14D1F0089B;
	Sat, 30 May 2026 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780153663;
	bh=NlepVFsZs0VRzu/vRYW9jCg/vfDx7XU5hjbvxeJLDDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbD05PKbA/BO8xgS8UpLzbg3rhs6dNLUDRnHqdjIhRPwmxckZf7QoC/hOYSICV7gV
	 lGM00DaOir69uQx7kmEEhJH3lOcVZ3+mxEtRQuRdHDasHNjpGDr14AYbWJdVKFGZoo
	 M9cK+n4VXivp9mUuxLrhuy0pGWmFq3XnHViJeyg/3t2GqW+m0jtGuUQY8rFI81LyqM
	 2nW/PMdhgg1ahVfL298Ez94L3njj9tsVuAIIEMAC7Bog2xZosnOEGB3kS/ZD3DW/dd
	 FIZRIjVYmHvvxX1hic65JaRdlfmQs5dsOu5c8aQ3rrToUnzzFQNkJi29pzS3kfRYJf
	 vPlRSOUroDpVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mptcp: handle first subflow closing consistently
Date: Sat, 30 May 2026 11:07:39 -0400
Message-ID: <20260530150740.2598142-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530150740.2598142-1-sashal@kernel.org>
References: <2026052837-repave-immovable-cfa4@gregkh>
 <20260530150740.2598142-1-sashal@kernel.org>
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
index 1c30bb369498a..959385b1e564c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -875,10 +875,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
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
@@ -2477,6 +2477,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2487,7 +2494,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2496,8 +2502,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-
 	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
 		tcp_set_state(ssk, TCP_CLOSE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a33452715597..2039e030230a0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -508,11 +508,12 @@ struct mptcp_subflow_context {
 		send_infinite_map : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
+		closing : 1,	    /* must not pass rx data to msk anymore */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		__unused : 8;
 	enum mptcp_data_avail data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
-- 
2.53.0

