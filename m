Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9237330D43;
	Sat, 19 Sep 2026 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848369; cv=none; b=JsD9Dj9dGBHKeDsyBLOXRXpg3VAvHypqIQZPKs28jXmtp/GQwW/qIWX3BI5+UTt+TTOoAEqCDvUAsrKfl24FDJuF1VgfPuKoDI1tiavgFB+w/LdftEZ7XtLst7IjPjnZILYkA4YCxSDvgGrOjgk+VEkMr/q9VS5capcgtD2jhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848369; c=relaxed/simple;
	bh=/96Ljc2u5ulJ+voaezYs4Vi3hVu/IDSkKKFZPcaykbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reFPmWW/kjP+gpM7baFOL8C1es5IRjXZCFJCbZ1JIThus5Yo5heOQKAdfUXBEtARPy/B0HpjyLrfTQ8asQwXsf7uSdFJEYEvr9Yip1Mo1fOGTyjelrheQCaKiLRcfV+Zhxte52B5OdswPYIXGnF+3Is+YlU3fONb6EdAtrYG2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khtjGCuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khtjGCuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7981F00893;
	Sat, 19 Sep 2026 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848368;
	bh=7QGiwA79oAg4pmRrtnAxgJ0r5Wlk7HGsa+ViUCSejks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=khtjGCuvRhAoL3NV4VSWlqXziF0We6IhMXyo5gLy3U3b2TniOXtB1ga9CyYj5Xcv0
	 JpXGt34uuxJu2jfNQpUbbDf2zuI1qoRAODWWtBQkSfygwxx1OtQhvC1SHETxEfXlhr
	 +UAtAabLUnH/+NBqth5T5waN/W7bdXTVt+SIzFMaA6UPKL/vcKu+Udv0RLqc9gF3zv
	 088MPKhA6K7b4Pzq+g4ypgyABg46OTwZlumhM3T0CFQ3w8NWa9UEKiOygA0uD+lrxV
	 M/g9G3KrALY5bfmYDS81r8VmB3fmIVuw0RD6l6oOGfIQY9GasebuAlmpOCATvqM8Ai
	 6Xz4dT9xV35IA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/3] mptcp: avoid unneeded actions on subflow reset
Date: Sat, 19 Sep 2026 22:05:56 +0200
Message-ID: <20260919200554.2005069-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919200554.2005069-5-matttbe@kernel.org>
References: <20260919200554.2005069-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4237; i=matttbe@kernel.org; h=from:subject; bh=cXTWNsdMfAF5XsTsINVVuP9xdgQrezw0C8mdUR+gRv0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvVZRDQo/s0/FcXXG2syInewmBeWqKf4sbnyXQpm6y g8YXfjSUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFOF0aGv8v+S7t6b3sioiPw Mn/6vsC5fYkJP/rWRuR7TbB3a32/iOGfvm5khyanb0uYp4mE1t13V/wXNHpZsnO9DF2Vdq3bL54 RAA==
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
  above.]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 127438ef120e..187e60ab3f77 100644
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
index af00d64e61f4..825f77019092 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -510,7 +510,8 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 8;
+		resetting : 1,	    /* subflow is resetting */
+		__unused : 7;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 798c87987362..8fd3a0328cd2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,6 +421,10 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
@@ -1802,6 +1806,13 @@ static void subflow_state_change(struct sock *sk)
 
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

