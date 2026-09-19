Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424A35FF6C;
	Sat, 19 Sep 2026 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846570; cv=none; b=Q0tdP9Ui3MTYVMF/XTH4PGsT5Wgkal93DFu2/b4/7OUNHZAZkWJOs0NEevssL4JX7pwX8+kzLDs9KfXc1XAjtLLraSDeyE0vxtTTALWxp632ZxAHD1GRAVquZ0cXulrRysJORl81yj03dDtzJ75GqemhUxFE1/N2aM3qVzq53TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846570; c=relaxed/simple;
	bh=/zyBhep2tMYKrPaNAHIGYIl40eFmKLj8No/Z6mxW1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKnVHpBPGIVABn8i8ZkOwyPFunPwQbG8TlxmgHwUd3O0ae/iQSzXLGzUoRSVghcl8ySUsEmgasO3GdB9PJ+76Td0b2bkt75QXnPAC8KytGge2sTOXVtO/6HPoZyabLHtoGIf2CLNheris3GHm4O9/W4vxy7T3hLux5cXURD0kmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg09bk/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg09bk/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E231F00898;
	Sat, 19 Sep 2026 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846568;
	bh=c4TeFYzXb2H8L3hwwqpe+jEoL2EFuS6ojdVr9hrJqFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lg09bk/Ew8KwRVHgDLE12V/2UYWpipQKKA9W6t7vyo/6il9DtIg8qECX1kIDkfSbB
	 p3+BGx/KgWJR9X448+aHi7K+O+4EQqkHLn+QlNOF/b2ugIGXJlhV5MyAacDUgiN73Z
	 NzFJe/A3KLDz1uYjN+I/Up/y/68UtDF10Xq97aP3+jFMV+bZrc8MsNcj+jfNhDJJYO
	 aeasneBGk4Sfs/R6xk8M0jD68IC60aL7LzLABEqi8y7sf3QKfSd+u2UwQBV/IybCZC
	 PpRRXXNriVBiQVN3YyIyQfNUKbqisx5Vol+VAO1dFXwosziur3Ln5mc6ueNHjVyElW
	 YH6l9Pv8Q9WYA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.2.y 2/4] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 21:35:44 +0200
Message-ID: <20260919193541.1915297-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193541.1915297-6-matttbe@kernel.org>
References: <20260919193541.1915297-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3752; i=matttbe@kernel.org; h=from:subject; bh=AVrDwnrVWRrcQWUftTQ0Y0xp0+rHHcsERJzquA85cwI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPRFwsdI43n67s2u6QHOUQnbSv/W/Im4FKn534SvjU WVa7Dulo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLy8xj+J0XN2rNvxiu5sDf2 tXHNr5Vfht2Rbnn+7DhXkKFi/qYETkaGzTNSf21/cytp6m1jz4MfvsisPbfRunBvyKzA1zvea/z K4QIA
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6db944b5c423..b6581858979d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -773,12 +773,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				mptcp_dss_corruption(msk, ssk);
 			}
 		} else {
+			sk_eat_skb(ssk, skb);
+
 			if (unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-
-			sk_eat_skb(ssk, skb);
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 825533614468..d44aaa783c22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -585,7 +585,8 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bde79720098a..edd33dc9367f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -436,6 +436,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1873,6 +1877,13 @@ static void subflow_state_change(struct sock *sk)
 
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

