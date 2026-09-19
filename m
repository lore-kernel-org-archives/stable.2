Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62D225403;
	Sat, 19 Sep 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847170; cv=none; b=f46HBAzZdUT4Zoad5495YBuX0v1P8KF10JbwzjZb2i+nhO8tOueo40zNdb8zHKeKYLoTVf5vZXV3k5z5+IFDoLZYiC7zs4X0W1gFVYDXr0hx/wYyMw5rDNaaMZa8nzdG8FIop1Foe9DXkZPB5COwvNj4X8wEV0Rtaw7yLEUW0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847170; c=relaxed/simple;
	bh=Y9JURpnyNVvXbUVCu1XwyjZTJF0tc1XGqecxqThTu0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTjtRn0fqWPuvXmItPoH7THbLf+FUQmYbUHVQMqabZE47hh20FeV57tFmu8yjgfeSgWIjiSOez2EEs+M3x7wHDsajeUGOQ0fmzvVCB7SueBgZLgW+4Bk8Ib77yTALlzFLk6UAefp6aI/vliw3E1iHG1pJ1peqJhTrpNY1CwWe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeBDa3hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeBDa3hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B16A1F00893;
	Sat, 19 Sep 2026 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847168;
	bh=0GY1gwzUS94VFcLdtnnjrgK2welX+5DdyYBJna085wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JeBDa3hwgySlshJKvqDzzE2zMvqhwN7s3B06pe+1NnH0k5uKP6YlwgeiegBq01cdG
	 F4uuBrXpFY9DV/MGo2Vpz3ygM1+1aR6gxljjf7hxLLEeaJXAg7zGPZYLoS5psboccb
	 JMdgdqSR4xlgObmtsuuh8ofx0YHhdDFdwSneLJhgHC8Ap4bMTMFOSvF/avmFu3zRXM
	 K1j7934ftfr9Qa6gtioHA6qAXR9cd/Rf5xT1z9XCpt1/h9g44lDGVKGSno/NL3thFY
	 5q6T/xQX3Vi/p92ngn3IIv0XsUJyO3O4IIC5WKFrJtmOu0KTZp6aYlozaV3Ka/OYfz
	 ix4jQYBid9TLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y 1/4] mptcp: move the stale logic out of retrans scheduler
Date: Sat, 19 Sep 2026 21:39:50 +0200
Message-ID: <20260919193948.1927666-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193948.1927666-6-matttbe@kernel.org>
References: <20260919193948.1927666-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6283; i=matttbe@kernel.org; h=from:subject; bh=wnFfjFdUTAGi4UZulKbVuvi6Fo+np7j4uUQ34slT0iY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPWVPKNZi+3LkSeB+qQkLuL0i3S5W+OpdPCBop7h7b 5SV2zOOjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInsDWdkWOA9N873zuc6ds3W xWqLX63x+rFa6UuQQNy559d/TVDwUmH4K88mvFR0882GT2Vnc5rXzV6x1/7xoRqp5byuvRZKmd9 5eQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 6cafe51e0f98fe60a106783d30b2f4c4b6039f4c upstream.

This allow separating the stale logic invocation and the retrans
scheduler, and will simplify the next patch.

It's also a cleaner design as the retrans scheduler has currently
too many side effects. As a possible downside, the retrans work will
now traverse the subflows list additional times; that does not matter
much, as this is slowpath.

While at it, pick more accurate names for the involved helpers and
explicitly note that the per subflow stale data is under msk socket
lock protection.

The scheduler and the stale logic may observe different subflow
statues, as no subflow lock is acquired. This is intentional and not
harmful, worst case leading to slower retransmissions.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260807-net-next-mptcp-oooq-pruning-v3-2-dbc1eb853cc3@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 41 +++++++++++++++++++++++++++--------------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h | 11 +++++++----
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 01c91edbee1e..6981fd48c63c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1021,7 +1021,8 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void
+mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1058,22 +1059,34 @@ static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct soc
 	}
 }
 
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	u32 rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+	struct mptcp_subflow_context *subflow;
 
-	/* keep track of rtx periods with no progress */
-	if (!subflow->stale_count) {
-		subflow->stale_rcv_tstamp = rcv_tstamp;
-		subflow->stale_count++;
-	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
-		if (subflow->stale_count < U8_MAX)
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		u32 rcv_tstamp;
+
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		/* No data outstanding at TCP level? not stale */
+		if (tcp_rtx_and_write_queues_empty(ssk))
+			continue;
+
+		/* keep track of rtx periods with no progress */
+		rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+		if (!subflow->stale_count) {
+			subflow->stale_rcv_tstamp = rcv_tstamp;
 			subflow->stale_count++;
-		mptcp_pm_subflows_chk_stale(msk, ssk);
-	} else {
-		subflow->stale_count = 0;
-		mptcp_subflow_set_active(subflow);
+		} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
+			if (subflow->stale_count < U8_MAX)
+				subflow->stale_count++;
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+		} else {
+			subflow->stale_count = 0;
+			mptcp_subflow_set_active(subflow);
+		}
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 136faedde936..a9d8f63d3b2a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2372,7 +2372,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2685,9 +2684,10 @@ static void __mptcp_retrans(struct sock *sk)
 	int ret, err;
 	u16 len = 0;
 
+	mptcp_pm_chk_stale(msk);
+
 	mptcp_clean_una_wakeup(sk);
 
-	/* first check ssk: need to kick "stale" logic */
 	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 08a4ac75ad46..68f7c67d5f49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -541,12 +541,11 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		closing : 1,	    /* must not pass rx data to msk anymore */
-		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -565,7 +564,11 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
-	u8	stale_count;
+	u8	stale_count;	    /* Protected by the msk socket lock */
+	u8	stale;		    /* Protected by the msk socket lock,
+				     * if set the subflow is unable to snd/rcv
+				     * data, the schedule should skip it
+				     */
 
 	u32	subflow_id;
 
@@ -1054,7 +1057,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- 
2.55.0

