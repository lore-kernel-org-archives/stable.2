Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFF3921E7;
	Sat, 19 Sep 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847818; cv=none; b=sSUG7ivz776aRi3Kw7RTc3sTlxlZu/UXNFfPaI3Rkcrc41io5Z7TByWU5+IrI5gFZbGEKU7/7X+Eu4gnFMXqwBaCRwki2lwt3PypELa20WTiy4Jc5YVmqsyjHPTSGREP5Ul9snRAWbaq+TSHQ2FPXq877UrqyY1je5b7SlQVsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847818; c=relaxed/simple;
	bh=L/U/q3GwSp1dCDuBP16nYLIlbyjw8YUla85CzeN6vxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAk5PiuI1W8tpjnF8zNVaGJhOWomACH1tIJSn+L6nBcWjJKp7B4caJoEBnGpioTqWxYDIgiiR+l+4s8vrc9SdBnjYILOHhjJCXOM7WwgGtbsOtQ6uOW9CTpL8P+loagaKljY2pi/N4GxQZhfv2F0WWr/m9SL/V5r0nunlyIUJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTqTDbj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTqTDbj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CBC1F00898;
	Sat, 19 Sep 2026 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847814;
	bh=z98abEKY+Cl6qz8dNFUF6hxJAMW2tSEpFi/bfLMaIEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTqTDbj5mzICk0SUn7qQREnag8svKxOJO01qaTRVCzMSGUr+A6qkq6cQw3QOHY25a
	 +MFiFDbwXFuCTccKe+5xWCYG4eGnPnZfWdvz7yFCe0kj6Z3U6hiLVvPL7rpFtpkAbC
	 5RyOS/UkA654nU6efl2+S4GKooFHSnu9IvjCJaNQPOli+lYkFz4P+UanjSH93aqKPM
	 3lq5rFEtLqLbwrQCZglOGqCGF5mdMC8NDgsDvmqmAOnK0+kqsqQ8oRrptvqnR+Um/p
	 bzkG5F9V0CNdX2ssa+FPBzSSpQCPqOs19m4wy0MPLD0WXRI29VdTrpMQoMD26YiGPj
	 PVUW2fJxu7wEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Gang Yan <yangang@kylinos.cn>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 1/5] mptcp: annotate data-races around subflow->fully_established
Date: Sat, 19 Sep 2026 21:56:44 +0200
Message-ID: <20260919195642.1977885-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919195642.1977885-7-matttbe@kernel.org>
References: <20260919195642.1977885-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=matttbe@kernel.org; h=from:subject; bh=G9nFiKTkNU/3i3ucIlDwZs2EsvszO6Vxtaywsd+5bQM=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfhjOuPrbT+pW9uU+/j/l9xYnLx0Htfk6/GcW+Wfh 5eENcvGdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE6zrD/2SXqPTjMZaV3ySv c75+v3XCJbnajfqMpjeCzPepXTtl0Mnwz+jZv9s6rKaHf1zZ3bLCSHabPjuv2xTTKt+8C9JOfIX L+QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

commit 581c8cbfa934aaa555daa4e843242fcecc160f05 upstream.

We introduce the same handling for potential data races with the
'fully_established' flag in subflow as previously done for
msk->fully_established.

Additionally, we make a crucial change: convert the subflow's
'fully_established' from 'bit_field' to 'bool' type. This is
necessary because methods for avoiding data races don't work well
with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
the size of the variable being accessed, which is not supported in
'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d238dd374ce9..123c3691833f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -532,7 +532,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (subflow->fully_established || snd_data_fin_enable ||
+	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -999,7 +999,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established)) {
+	if (likely(READ_ONCE(subflow->fully_established))) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f34e92d9cce..a4054ed24605 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3685,7 +3685,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (mptcp_subflow_ctx(ssk)->fully_established)
+	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2ac28f6ddff5..cd4481c93b6d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -545,7 +545,7 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
-- 
2.55.0

