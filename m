Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE62CCC6;
	Sat, 19 Sep 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849772; cv=none; b=Lex3wbRQMjZteVlTZQQOFQTrHakIZQJGSiGpGOi9lJIjv/AO/1JPV4BJ/C1Kh0vVw2a/Yf/CNyqU4FcCav5jboQ4W61covhAK82Wcbbv/jre+jJQ29Kd9fSO3P0REVN2U7Dn5DvMuJnpV9sNi+b3cgx/0c3RjCWCC/Ye0SYMNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849772; c=relaxed/simple;
	bh=jr6JtzfJLZJ6Rcyo+JBr5e2OEnanKPEWUu2j/hh/7+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvknl18YLVaf+wdzG/FxL8W4tGsuydctvJqmH47T3BAwAgQn4h+0zmhr2AsKhxVp160xXB5Q7GR25Iho6W7JWQTAqHx+/O5vmf5a5rr42CCPlbnHHjaMyORFbBAhDAD+8K0se2/HJWeT47EurrYoEhH60NMwmzOLarZPMpWF1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHCuldAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHCuldAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12E41F00899;
	Sat, 19 Sep 2026 20:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789849770;
	bh=OXob0CtWk1GOuG4T0K4+bZW8lSxsiKhi0tjFvkvtUlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHCuldADl67xmuPFMFTXaYS1+wakpLWyBHvddKVZLf9V3iKdjd5TS/+DLMI76yDrm
	 ET3NLAWiV+QTpbUpeKBpvgDn1pIhwPwN77donBF0op9kUwPlmw3DdXg/9MureESXxJ
	 9MMEiTZwDHG0HLtmeG2F/RloZi8GiJaVycnMtya3IKh7StGefreMoROpK0Gxz/M2m7
	 4rfl5zgYRYJD1+VVTmqwVNKxBKliAKqCZZhQi4T/3YGPGA5vvCcdliiWmnIZDW28PY
	 bSrX1ZmusrfisAYV2lHsOBhfuZG7m6/KQ6JooqC+vKoMcoXl6hr6FppMEeS8Hh7iJR
	 iYjNbnrAlffkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 22:29:20 +0200
Message-ID: <20260919202918.2074632-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919202918.2074632-4-matttbe@kernel.org>
References: <20260919202918.2074632-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4736; i=matttbe@kernel.org; h=from:subject; bh=Q8LVpAPEcJDd+SeIXPfiNFrP8EjFcU54jFxZUfCfZe4=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVhQuCXsVsrmDX4SHiqLvEteRbKsMvmkILFoRoHM3 Ck7yted6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIZA/DPzOlVNNE1fkvplm2 F0oe+Kwby8TxWUEmwO3WM/F5NfZzvBn+KV7tXHb+vzvzxoj3bfa1W4rnn/24f8eclj8HHv/ZxqA rzAgA
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
  consequences here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 522d8740a0f3..42190efadb11 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -687,11 +687,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
index 609e7768fab3..913d9b1474b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -447,7 +447,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 11;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 10;
 	enum mptcp_data_avail data_avail;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 33b16ea7ae5b..5ee090b74fa4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -373,6 +373,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1667,6 +1671,13 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_propagate_sndbuf(parent, sk);
-- 
2.55.0

