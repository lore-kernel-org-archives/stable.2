Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5C3911C5;
	Sat, 19 Sep 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847822; cv=none; b=ZjgRPxb0M1Ngf4BMoCG2Gbo7xXPOrSK1jEt5p2W88+tMlRQI4nOsagMfpKcbAMQlm/TaSEMMogCDEMYXi/xSigHC8TowBxYbg0moBbcyRSHoXE5zRKohBEaSJdpE8wvXlF7fEji7ipxqhUWJ0IG/wtv68UL9JuvWeXlRpoRoKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847822; c=relaxed/simple;
	bh=Z55UInsA9wBgIgUaUHSle2M3efRAUI0Iq5LQuQxaxJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hECplsq7ZdNuYtWv1v7gDqJvT/IbUu1LRKFd1wzJFbUkina9b+5Ao/NeoMo0IcBZuXh+khI0oDR/l/8SU4lwDyRIs58ZKyJhvp3IaQe9G2rG306pmX5KRHbfQszfysFG1kYnsMkXnvKyLIXKIoSL5SMGQY4Z91GxHsJEY8RlgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPR5yGHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPR5yGHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF13A1F000FF;
	Sat, 19 Sep 2026 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847818;
	bh=G4asTY2bz9YuGQ/Tr+BhqtmrZnu2HsW6AXTOMK6CM/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPR5yGHtQE+OqIyynimvOUqAax3+soIBhFdBsiGYSCavv/g+c/A4Jn+D4wav/fjGv
	 GP55SAqthuSZZJHiZ6lcZhLdbG8ZiXgQ89qK05RyDi3zKgUOD8pirGAdES4KDPxNxp
	 ycvY+eyIB3YfisZIb5QjafVx5ScAhu1UbCwo/kzt9sIdyezrf7bdTT4SErCksGcD9U
	 UIKYm4WobDxVe1Kscl/1mxTUw/HmzIIeagaaV8kPft2OKkImE1jBZwf/VrqOCxcyYD
	 qk0EnJ6nAAL8b/pyspnSbm0gpw1/OuZTkBJfcRrh6/s0G+cPQrI2AcdkViRZjusnzF
	 Fo039V5nyHxOg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 3/5] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 21:56:46 +0200
Message-ID: <20260919195642.1977885-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919195642.1977885-7-matttbe@kernel.org>
References: <20260919195642.1977885-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4091; i=matttbe@kernel.org; h=from:subject; bh=NR346V9KsBhZ28IqdKdMt1XBY5IbXskqCHZmpmePxLA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfi3m/3tbveoWKH5p4694nbNy678H2Dxz9/E/Mc+q Wta2S/3dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkAwfD/7qFwWsLlp7hLVn7 bLtIghX3SX/3Toctah9yG/7sP5uuW8/IcP/LPZ81Jn1tPtNFX/rPzWjeKL318JxaNSlD1Z8hazw XMwAA
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
  consequences. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f34e92d9cce..ff63ba5ee464 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -747,13 +747,13 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
index cd4481c93b6d..436d3c92ec4a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -545,7 +545,8 @@ struct mptcp_subflow_context {
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
index 267e0424eea5..cfa029b4d7f3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -440,6 +440,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1857,6 +1861,13 @@ static void subflow_state_change(struct sock *sk)
 
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

