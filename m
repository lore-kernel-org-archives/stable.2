Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763F336897;
	Sat, 19 Sep 2026 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846568; cv=none; b=kxSzHHyhhrzSEMrwCD2LG8fh4vSSDUWoZE0W+GrhohAUOBHZlPuTZE2sudnxNCyKck7j18VEqp9nv52DoU+TG2EjLXwGsWXEYO/aCXVaSeiiq2/M4o6Va7nIgVaNluUQpRijUchfqqD1fwpj4KYEEpKfV5LOkwXJnlePeq7rsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846568; c=relaxed/simple;
	bh=64yr2ptnBKwwopoQraamuN2FYD8M+7DAMlYze76o7Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUighys9/Ey3miW7r2UNRD13cqLusg7LSvtFH9gOagIW0ucm51IlGBAcEzlF199x5GUVOgPoCAcG5MMyhOhcoS/MwjLOZq9sk4aVh7sUClV0MTsD3RMm0FfyWZcZcrHlxgwNmZmijiT68DRVQ7PTRqI1Gw/4XaGFRndMb1XUo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGhYTSB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGhYTSB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4072D1F00893;
	Sat, 19 Sep 2026 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846566;
	bh=AlY+6k5FqWmdxj4slC2j+3BHD2CGbBQ7czBiDquDCdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGhYTSB/+58zyhM/D9WVbj7dmwRECOxoxukcHmT0DA4JE2pTfx3HxuX1jfB858yNm
	 hmThA6XhSePsvftKU9DEercM9DHBw7Ytg1qhCBfxGQR9PL+q0jx6ywqa+u7paDpupj
	 JmpF6QdLlbyjQ/9ybfkHamMHNkt/m+64OF2rrxzzd9PehNsdSfRoJ4HUqcsYo3DaJr
	 DZbhKdRQxV/PnaLhe7G5YEVofW/Dy45XpRV8OzMqfwQ0Jjh4Cm7Rml5SSCbRZmbgXt
	 dGpEs+5BjVbNRQY8oMvg9p2QqvUlDnrw/mUf4/p25igAaZ+SAU+sKEVg4rixTNa4RN
	 6J36mNjPxIt2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.2.y 1/4] mptcp: move the stale logic out of retrans scheduler
Date: Sat, 19 Sep 2026 21:35:43 +0200
Message-ID: <20260919193541.1915297-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193541.1915297-6-matttbe@kernel.org>
References: <20260919193541.1915297-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6283; i=matttbe@kernel.org; h=from:subject; bh=4ra5wgrMNu2VHjaEsJuIxYsyaDZ8HfpHsi2rjh9Y94M=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPeHzVJ59UGUV17/IGL2FYXHX0h478t9k4ZeatPmvy usq/d/vO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiVsTwP2cDu9nBvJs8tsVR GbWsZoUJJz9tiuOau2/RjtObjoeXRjP8U1sh7uKw5U8/y5kjxsbvBKTeH1gUkXXVi+Nq0C3t5z+ TmQA=
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
index 4e1d65083b24..79bf88ca033b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1065,7 +1065,8 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void
+mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1102,22 +1103,34 @@ static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct soc
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
index 97523fa284d5..6db944b5c423 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2471,7 +2471,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2803,9 +2802,10 @@ static void __mptcp_retrans(struct sock *sk)
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
index dbb40295165b..825533614468 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,12 +581,11 @@ struct mptcp_subflow_context {
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
@@ -605,7 +604,11 @@ struct mptcp_subflow_context {
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
 
@@ -1104,7 +1107,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
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

