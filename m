Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705435FF6C;
	Sat, 19 Sep 2026 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848789; cv=none; b=jAxj759jB8qC0H6Ees+OtIJJyZcuuT7N82qgB7bpVCIKYVgSvPjzvVzLgu1wm4m6Ph6heyOMfjzFylsIV/YdR8QJfQfF/YWEVqShGxYGdlGnNAaq00foIXVe1p+8k369zH29o7sgsMyU1ajXNNGyju074xMc1yooyRgjKQIhAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848789; c=relaxed/simple;
	bh=1WO0zlFUIqFs0tdWGgmmVfyB4GET1GmoOqkiokHSxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+IaM+qC1EgEBHLPbfhCGYT4p1Ij0lHwOi1z3DXil3Z2WhnyusBgsLNXVc2tKQ+MG/RayZu/NHim+CaVXmaEYYaCNWrVKkfLab4OUiTvjQQ3/T8sozYt422Y1yzlRyDiBAznjbKr/KCZCBBVanHDm4de8RDZwX0GOg7Ntrk8sjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo5QZ/ut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo5QZ/ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AC21F000FF;
	Sat, 19 Sep 2026 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848787;
	bh=xouwOPrkxaEpY908u6h7kOvFvIViEUzdFPGLnhTu4Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uo5QZ/utd/AyfGw2HJJZaGPNke1/pgV0oIzf0hgBbeyjCjhmO1VKLHzDYc058CYLj
	 EThM52aPVU8MuiADdu9rrTzgOiFvOXv5UsMDI6DzujaS/ZB9xLT+PRxkxvzU47re4D
	 IAFwp/Q1paL0hs88PiH6TRNcq0oBa7zInG4jGOmYCRMjQcExjGtKuesyEZOE6mWCRQ
	 g4a0T3gBoYbqDkNxj5Kk4m0nuw/KtcGWlnNLweYi5HxAX1Hc2pf4TIJytKUY6C5lgD
	 O4yEQR91TSe74OcUawoKP04czr6zPSqSe4wxCbjEzcus1hDSSjChtM9EVAZeRhC9iN
	 /mMEGJx+KFHQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/3] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 22:12:55 +0200
Message-ID: <20260919201252.2025112-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919201252.2025112-5-matttbe@kernel.org>
References: <20260919201252.2025112-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385; i=matttbe@kernel.org; h=from:subject; bh=XcstLkYZhMf+PhHW4AP7Sz2v6ws0XodyjpnN+Xr9kRY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvTnRes7UNvizyP/GhWLCd37UHMyufnCB1yjKs9S1Q vTYgb0uHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNhqmdk+KTG+VKT6wjD6f/T upn5OU/w/pMwff6CobElytTkwfFsfob/zmuYpPgPFjW2nO4+EbFba0Or+Przj3fuPX153RFlltM 6HAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 2b0f561f21b27c40c91ea4975268a06092bd7e9c upstream.

Once in a blue moon, the mptcp receive path can recursively call
mptcp_data_ready() via state change under unlucky error conditions, and
then try to hold the data lock again.

Break the recursion loop explicitly checking for the exceptional
condition.

Add a new flag instead of using an existing one like 'closing', to exit
early in subflow_state_change(), and explicitly flush the RX queue at
reset time.

This avoids unneeded processing to check for available data -- calling
get_mapping_status() and more on a dying subflow -- but also in error
reporting and worker scheduling.

Note that we must consume the currently peeked skb before invoking
mptcp_dss_corruption to avoid consuming it again after the eventual
reset has freed it.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-1-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Note: conflict in protocol.c, because commit e0ca4057e0ec ("mptcp:
  micro-optimize __mptcp_move_skb()") is not in this version, and is
  part of a consequent rx path refactor. The conflict is in the context,
  and is easy to resolve, "done = true" can be moved along without
  consequences.
  Also a conflict in protocol.h, because __unused is at a different
  number. Decrement the one from this version and add the new flag
  above. The context is also a bit different with data_avail being an
  enum, but that's without consequences here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ce20884d730..ab83cf46a8c3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -754,13 +754,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				mptcp_dss_corruption(msk, ssk);
 			}
 		} else {
+			sk_eat_skb(ssk, skb);
+			done = true;
+
 			if (unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-
-			sk_eat_skb(ssk, skb);
-			done = true;
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e835028fc4e5..1de257b86839 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -492,7 +492,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 8;
 	enum mptcp_data_avail data_avail;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07cdb162b709..cc62681d6ea8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -379,6 +379,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1710,6 +1714,13 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
-- 
2.55.0

