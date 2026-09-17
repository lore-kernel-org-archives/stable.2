Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDC517BA1;
	Thu, 17 Sep 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650383; cv=none; b=TWUWjHq1gg27NNQuxkw1b8ziwjsKpwKjGjUJWn9Xqpz46xH9hiDSuxC2AuKcHRdMgHMTi7xt9JFj8OMUF+W7vh7YTtkDdOg8qMqMLIEE9/JRFgitlvGoiD/0c7WuoDhPxF8Ka4i6RoYMFNBsh02s9/zCbTy+mH45SikYmNcE8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650383; c=relaxed/simple;
	bh=sF/mLLG1ZZl3LSR2aID3VowAjKEVXc879Fwc96KbUHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0jOHCKsRCrg3I3R47sUQx3UsTlUzPZkc4NhPxK6FV4syUbZnKlN+xOkFNXqBHNSxjabIjWRwj6OKCwZ+rKx5COha/cRED+GbdVVKJgkQtUWiCRF8whrI9pCkLyXHLXVwA8gErfRzvAelgYwe9xL1CqNl3Afu2KM1n6aqubWUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8KkZPC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8KkZPC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBECE1F00893;
	Thu, 17 Sep 2026 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650374;
	bh=SNMCW68SqYp0pSeHZ5srnhkw/FExK5Pj/HQ4DdW2I8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a8KkZPC02/GTvfdXxcRFwel5iS729NkpbvcGdYTkVAJjoUxp/yOVeLfGmuUpkmzKM
	 D3iOf7bitDRgAtrqjVODhHIoBIRA6RPZ/z9PErify/o7WSEEbNrIwN4NNnwVgBu+Lq
	 8F/QsKs62k4qmXMUZyvEk4FXzHRy+U8kQdIflLXMlPb8oK0U3qKlRKmRnBw21pr6jy
	 66JuLOI5TqFrh/dJHi3ZN0smlu2oxg4XgTCzwmu+Q4MZHOBoepQX60bTu19P8snXTq
	 YoxpakzyyUszzoE9vd67jJazh+t8rzC9QLH2oeQYkUKlkHFI55RG+8JpY4GrszNhXq
	 xZ4vg/TztJqdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Sep 2026 15:05:57 +0200
Subject: [PATCH net v2 1/3] mptcp: avoid unneeded actions on subflow reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-1-0cf5c72667c8@kernel.org>
References: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
In-Reply-To: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Xinyang Ge <xinyang@anthropic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3596; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qUWthSuufu0ZncDmyc4KJwzky04oj3Rw/23POGuDd50=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWP92/REjbVvFvusrhoN6DtmYss+Zvf9jue0z0sbVgw
 pftahInOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayu4fhv8Nj6+0/Pzxa1bE4
 oPneHe/T1Zka9wRmJMzbtETEtK3pGDvD/8LjwpeqRSebXTF9VXtFtNI679dUjY5p4tfvcKWsK2p
 I5QcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
v2:
 - rewording to please Clashiko
 - consume skb before dss_corruption, and purge queue during reset
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8dc25ef1542c..d9fc3be9d2db 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -856,12 +856,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
index 2b4c27426477..0384d6a023f9 100644
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
index 01db7edce18a..f0a6725d2c37 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -438,6 +438,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1883,6 +1887,13 @@ static void subflow_state_change(struct sock *sk)
 
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

