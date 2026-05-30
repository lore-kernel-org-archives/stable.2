Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6063AC0C3
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141694; cv=none; b=W8h/BjbxKXb9gaKc6Oa6wE18Fua4KKkU1zAJ1L/1V+8E928vjkcZffBgPgkg694koS79AqVK/YKqGD1bHVzK7zmXUvoZtACl2bPH/HL2r+Si+/Pe9MrnyeJCTuJCyGm7Fr/VSshkZZgcsAGx4llwHhJahDAjzoQgrVw0VRxOT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141694; c=relaxed/simple;
	bh=kqUw9d+rru8QGMgxdGx4usaSlZP7fCiZs8Eq/hOqwJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL3RLthCNZMksuT7cLYFRn0eWjwEPI590vHBETT0z7gZ5N73+TPDm0kfx7zxP01i/omMk9joOu1QwU/LQk2e5TZ+lq/bJ5oNU5usCHKd9zpJl9TaN6+L/EQuyMeBSt3lN9vlg4pPsXY7KHP5pnTRwIAYjUdIZ1gTCp4sHcpbg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2BkTF+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2BkTF+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70D1F00893;
	Sat, 30 May 2026 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141692;
	bh=uleICPhijoa74JBn5DqdzNTgUMijJ6dZx4GLNAv9OyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2BkTF+qBoDszaIbjJKgE9/YJmLZbZvzhhoCBovfQOoDGKzZmKsp0aC7SvL6y5zqq
	 xEhqB45W0a581bI+UA79UuF+HKwUkyhQT5Y0dgkIoaUxou/ILzCN4mVdZlAyBtZuC7
	 s583wE1MvLdgv8Ar14oIkM8MdlA+gl3tAWfqhrDL+DSrfc9v4xr+cAniLiGKUzQ81L
	 0n9N4sxiz11CtEX7rnfzUsYFgx7hsn2ZY62tyAawq3P12FBBwO+UX1Z/WJK607m588
	 Y7G2leh554OYWjNnR7hovE/4rJbp5njxeacesrrq9knmafjcw8ZejE1ELe8I7Jod0j
	 xomRDLq6e3hhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] mptcp: handle first subflow closing consistently
Date: Sat, 30 May 2026 07:48:08 -0400
Message-ID: <20260530114810.1965750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052835-evident-dutiful-f601@gregkh>
References: <2026052835-evident-dutiful-f601@gregkh>
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
index 1dbe6c8a8b8c5..0dde73543da0f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -854,10 +854,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 
 	/* The peer can send data while we are shutting down this
-	 * subflow at msk destruction time, but we must avoid enqueuing
+	 * subflow at subflow destruction time, but we must avoid enqueuing
 	 * more data to the msk receive queue
 	 */
-	if (unlikely(subflow->disposable))
+	if (unlikely(subflow->closing))
 		return;
 
 	mptcp_data_lock(sk);
@@ -2455,6 +2455,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2465,7 +2472,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2474,8 +2480,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-
 	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
 		tcp_set_state(ssk, TCP_CLOSE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5a03c8824ab68..feacb1feab476 100644
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

