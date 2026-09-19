Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A435FF6C;
	Sat, 19 Sep 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848787; cv=none; b=rElh/8/Swar+C2kfdxhUhHkTqXyMKDJsg9ncekTimsjIa+xGv8QZ7wkHHeTtARKJwNU7PbXtIfddWAWyJMgQeCgz8P/SV3rxIgEspgP6mU8bdaTOjNf07Fh92RLG5L+Ph8NrrRHGBBiP7ySALyGk0nYoynd0oILxmWkhsfWB5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848787; c=relaxed/simple;
	bh=epsX1j++3Fko/DQtdSBpEZJ1wFg1qK5B7N/c591fAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i52VqHpky0noNA9pOqVYwm4Wqng999FYoyI2PrLaXdqrjV5gQ9ompdyi7uITdIVQFVTAkSOpKhPdzo2SeT2teqURUsSAaas6jFvY1IX2V/mAIipL+W27rXK7OKSQT50NLkLL3iR8PshzQ3YhcYI5+dy2fmClgl/j0CmOn+R/fXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGaLVJ+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGaLVJ+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8680C1F00899;
	Sat, 19 Sep 2026 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848786;
	bh=HFpLnNInghDL8JSy8qPkDWxdjU+CgZOajI/gTdrw9EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hGaLVJ+5rVo11oAlI9Mn+fganxyRwWvjKkmAVxnOX6Ozbt8cp/aHmUF2EQAEYXmlt
	 xL042LWWs/4avqRepWMvi3jbaxlXVX3vXkUiYPpZqJgqNfyUvkKWQDd+A4temnCHvE
	 OxVdLBPDGZ2RzlhJzRiyk7EyK4hBfUKLgAvqEUOAeJpis331oAWayPBwIMsanO4wzs
	 d+a2PX2jWB8iFqMUrbFbCN+lM+NlMt/pfLhNd66PfuY8c6NfKScIqPv0NrMwljGowZ
	 8tAA51CoollAd6EOj5E6xqVad6IfUOXtU4mfJbAHn8SvzFY6M2c2uRZsi2wdPPfS9q
	 50W49DaBr1jPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/3] mptcp: consolidate subflow cleanup
Date: Sat, 19 Sep 2026 22:12:54 +0200
Message-ID: <20260919201252.2025112-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919201252.2025112-5-matttbe@kernel.org>
References: <20260919201252.2025112-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3863; i=matttbe@kernel.org; h=from:subject; bh=LKXEot37dX6aLgczeUF+iiz11GK2iDaj3fGxVDBSGmc=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvTku0P1mtxPD1V+Hrx4WP3gu6vfFeqfMCbHxce9VO yR0uxMrO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyw5/hr+R2763WjD+vXblt e8/LVvCWdxfT1eOz9duaefYGrSr/eJvhv7uiRerK5nNHbnrK+u9oEekP+eh57vCx1zEvtyS82yD dywkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit c3349a22c2002947d29a98a77bfb36d97cfbfac1 upstream.

Consolidate all the cleanup actions requiring the worker in a single
helper and ensure the dummy data fin creation for fallback socket is
performed only when the tcp rx queue is empty.

There are no functional changes intended, but this will simplify the
next patch, when the tcp rx queue spooling could be delayed at release_cb
time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-1-4a47d90d7998@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
[ Note: also remove struct mptcp_sock *msk from subflow_state_change: it
  is no longer used after this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index eed5b90bf5a0..07cdb162b709 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1159,7 +1159,12 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 		subflow->map_valid = 0;
 }
 
-/* sched mptcp worker to remove the subflow if no more data is pending */
+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
+}
+
+/* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -1169,8 +1174,18 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
-	if (skb_queue_empty(&ssk->sk_receive_queue) &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+	if (!skb_queue_empty(&ssk->sk_receive_queue))
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		mptcp_schedule_work(sk);
+
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
+	    msk->first == ssk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
 		mptcp_schedule_work(sk);
 }
 
@@ -1688,20 +1703,13 @@ static void __subflow_state_change(struct sock *sk)
 	rcu_read_unlock();
 }
 
-static bool subflow_is_done(const struct sock *sk)
-{
-	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
-}
-
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
-	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
-	msk = mptcp_sk(parent);
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
@@ -1712,13 +1720,6 @@ static void subflow_state_change(struct sock *sk)
 		subflow_error_report(sk);
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
-
-	/* when the fallback subflow closes the rx side, trigger a 'dummy'
-	 * ingress data fin, so that the msk state will follow along
-	 */
-	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
-		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
-- 
2.55.0

