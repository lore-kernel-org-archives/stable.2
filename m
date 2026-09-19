Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D42E0B5C;
	Sat, 19 Sep 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850419; cv=none; b=oWmsbZwp/Tru7Dl/8+GOlftAlP0jM6VhXNOulkku9MFMBfmOMB/WVa19QNCUTeDvJ21tt4oOm4nz+SMNM1gcMFIawYx0VGK6Reirj31n28nGAtjl64UpQnJEYMagHDqxYaz3lXm5hwl5Q9gIGubRweFY48tk9OuS0aCORaVWGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850419; c=relaxed/simple;
	bh=sQCW8mP4OHAWhhTSYZUlL7b0AmGSNQs41XXQWhvl0eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na5Ao2MhGF5rGQmCG0BHTkpiteES4VbsIIUJtfMHDCoqVgZ8gaMRg/svT0eAlsdP0vY1X7OmQBLQAV1/cOKDRmJSZYltHbZTZu5Mrnv368XzvrZc+YMjCcl9pWycs4cKlWfu+krGQCmn+OMaZ5M5+4FPFtt19NxQ/LwNfFT2mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ9zFCWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ9zFCWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9491F000FF;
	Sat, 19 Sep 2026 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850417;
	bh=X8E/4Wn+iTkDgeZlkfMaj5YPGAO+ob0mPalB++f/HwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZ9zFCWDuvgoKyXbZ7DIKXCauBHHKd6WaouqmD6+r8s4TWZbPTtX/NyiYpjs3PLUX
	 Gaog6zorf/QFaJkXaNOjmcKCICDcGSoBwzJFH3i0fum6Yim6/U73yZpLNdH59vFoov
	 UCCh10O+BRfGW1e3lZCtX7nFQgs4M0UTGh7s1GaJ/hhf7YEAZN+gK6qFNvsBXdz4nV
	 8s5umg2aThjKNZR3Z+KcjAMeaAc5MwQb1B9fEw2m+gp+X7tRwUjFcbXf+p7tUxVymC
	 PjDCQz4uxdZGEinV8ZZ+wHPQlGLokb0plukSYJNGEomfHxfANIQrKKDKr6WrLqoB2d
	 7pwq1lBMexXHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 2/3] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 22:40:05 +0200
Message-ID: <20260919204002.2106015-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919204002.2106015-5-matttbe@kernel.org>
References: <20260919204002.2106015-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4794; i=matttbe@kernel.org; h=from:subject; bh=lqSDkdlltO5bXEZCcYQ+P8vdMPJMl1bzFcLjBpwtQlI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVatu8/7JvVDWZ64p/CNxGUm7wLa57Za/li/y9Agf FFXwoaijlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInYTmb4p/2g+iXb50vT1Z5P 6hdrO67y4NXas4Ghj2+ob7o+5YzD7hOMDHv0Lha6LeLJs1/VdTRagS/7xe2ImH16k1S4/15Yvf7 HE14A
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
  consequences. Also, the context is slightly different because there is
  no DEBUG_NET_WARN_ON_ONCE in this version, see the backport commit
  12c1676d598e ("mptcp: handle consistently DSS corruption").
  Also a conflict in protocol.h, because __unused is at a different
  number. Decrement the one from this version and add the new flag
  above. The context is also a bit different with data_avail being an
  enum, but that's without consequences here.
  Also a conflict in subflow.c, because commit 71154bbe4942 ("mptcp:
  fallback earlier on simult connection") was not needed in this
  version, and cause conflicts in the context, but that's without
  consequences here. Also, a conflict in the context, because commit
  81c1d0290160 ("mptcp: consolidate fallback and non fallback state
  machine") was not needed in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c6aef813473..292c21713eb7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -581,11 +581,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (unlikely(map_remaining < len))
 				mptcp_dss_corruption(msk, ssk);
 		} else {
-			if (unlikely(!fin))
-				mptcp_dss_corruption(msk, ssk);
-
 			sk_eat_skb(ssk, skb);
 			done = true;
+
+			if (unlikely(!fin))
+				mptcp_dss_corruption(msk, ssk);
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac064c44079d..b64a50b22d62 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,7 +314,8 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		rx_eof : 1,
-		can_ack : 1;	    /* only after processing the remote a key */
+		can_ack : 1,	    /* only after processing the remote a key */
+		resetting : 1;	    /* subflow is resetting */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 77cc4f585cd8..fff70a5b06db 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -282,6 +282,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
@@ -1302,6 +1306,13 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-- 
2.55.0

