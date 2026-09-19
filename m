Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F721E097;
	Sat, 19 Sep 2026 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847172; cv=none; b=KdluIKafQaXRaBQ3gY6Y9rDIanBnYjbNmH4DGM6fOC8H6WCgNLfuU8kaCBDg1IfA3526KLUaaVtgXhyhFuesErH1od8Doq1QaJMu3k2bwNMDnsXD1x2FtNOR3vfBtemPrq2TUbB1YtukOSFfz0afrCseyrbknv2ifesZnEapeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847172; c=relaxed/simple;
	bh=4nnvDODdQjHmfFhi/J35q4Ra6AqjS+EY1v/fdX73R8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDTRDx5IPuDizf7I8SmJ+vZ1UNESTAAWemEF5dBXtc62aMWOksIS+TM3qT7UEZmHlwGGxo9hqL4OzCdBDalBNxhUGv6KapnzD4PfiOhHvrkYLm6usdfEFKRtgNHdPQTq+R7z0nvAwGOL6el3bRCMK0QwLLSkFl8wIExnvNMTS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfSwt6RJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfSwt6RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383871F000FF;
	Sat, 19 Sep 2026 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847170;
	bh=VzL2RXag44aswm6H0CNJet9Iyu0WotGU/SiDa/pmvYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfSwt6RJyN+M4JTcmiI/VDW5JWc/hjvsZn62fBxHsLB+F3imWeeXZk6LECaO30kFb
	 0U/+mDtb2o23in4kIHxO1SVPO3PQdjjlIFhorCVIUCPgrsl6Tjfp4DPTVAZdkky2w5
	 Y0OLh5osJpl1cyC0MGNHhUZP5O5ScOhwk7+Gl9iBmYIPW67hl1pYi2MZRpYBeMTz99
	 wLe0ZGpD2UJ8pfRBRCcmcMnitfmhWQc1ZAJpTiVsk+pufXtHyZenfpA11Jl4PQpyxq
	 7zQ5WKhINIEFEik8bfxb3aU2sZ5FOrDHPkku40NNU7CHxloIPces8IwD/uvHR75XHj
	 OvXGc4RsVnpTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y 2/4] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 21:39:51 +0200
Message-ID: <20260919193948.1927666-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193948.1927666-6-matttbe@kernel.org>
References: <20260919193948.1927666-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3752; i=matttbe@kernel.org; h=from:subject; bh=TwEXo4sAWu8C2MWECnaVnk45GCdRUe7jQDtgvf6QFhA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPeUokGPiPCn+s9nz0KnQDZ/39SXP7ussn+Jz4v7JF UIscVV3OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbi+4qR4a7jA4/yqRld06fU sLdbvZQu3HNn3450nzZe1TuxQXpB5YwMH3kzqirrzrl/uipynz1gg2btB8Oe3PnhEsdT+R3Un/J xAgA=
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
index a9d8f63d3b2a..dee5fd3787b5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -727,12 +727,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
index 68f7c67d5f49..dc8920a6a90c 100644
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
index 96794baac3e1..1932fcf9f925 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -441,6 +441,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1864,6 +1868,13 @@ static void subflow_state_change(struct sock *sk)
 
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

