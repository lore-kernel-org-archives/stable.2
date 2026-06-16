Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A312E1DC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612391; cv=none; b=KxVgFlCGv3wtI7Ui5K/LJ8DKK19/DFimquw56NE/ec3afViA4zzNey2PdBDc0F+ZTDncQK8b50gC4hr1ug+ZYpJTSC/Jm0ZObN189MfQ8efLLUfh2JMyABlTmlZbMqESOG/Ir5dGe5CW6glh7aBrV80ug4TvFtuwa/d7vjXG9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612391; c=relaxed/simple;
	bh=8u+xWEZn+Y9Xcmr4bPp4XsuNlRsxfQEhXMWEHhwD/s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlBov0VvbBO1XIUi6gO0et38nWDWYOOnICShaojTYpk/HTUX9INl5L3CsyW7MLOAXJ+X7ASjHga77EJ4rcd4DUag4XFMrLDMr4snez0o61msDloPLGRB/l/LaCe3An9wnsImNxM01GPNWm/njWG9LFeglnpXfn7sajwwdyh2r8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIqJHKn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIqJHKn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C851F00A3A;
	Tue, 16 Jun 2026 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781612390;
	bh=vnpyd8XAIHbxDeN/bs5hX5pjTbkL81Knzc7ek/oFTG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIqJHKn/aFJIYHLX9YaW5jBT13Bv42m/RxEi8BTw2esUq2waNk/KRzWDNPf34rXtv
	 yP9+zkgDHKzJO3es3hLD0gdD5mEqnrw0Vb5dsDA+qNf4BlkjKp4vwbgPxJz5p2Z7zc
	 nMT26H6cZ8mWpplwQx+OORX0ZmmzyWoK6u8NIl5tn9T3//p0w9FKOr5hOeLiOdDHaX
	 LjIFhv/CymE0uTTXCbrEwxU/NMgZ4ERanV/hzbnLkcw5m+i9CPMdSBMEiwC/9Z92D1
	 V0Aw57wYk1/72btJT5N27JO0O696py54lvyj6bwsrZLM+KwXOVJm3uw+ICzTo0Pn87
	 i+KUxGveOV2Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: close TOCTOU race while computing rcv_wnd
Date: Tue, 16 Jun 2026 08:19:47 -0400
Message-ID: <20260616121947.3136498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061521-laborious-platinum-e85f@gregkh>
References: <2026061521-laborious-platinum-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8ab24fdebc369c0dfb90f82c1650b1e66662bb45 ]

The MPTCP output path access locklessly the MPTCP-level ack_seq
in multiple times, using possibly different values for the data_ack
in the DSS option and to compute the announced rcv wnd for the same
packet.

Refactor the cote to avoid inconsistencies which may confuse the
peer. Also ensure that the MPTCP level rcv wnd is updated only when
the egress packet actually contains a DSS ack.

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-3-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 85fcc378c711f3..cd576b40d4db2d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -555,7 +555,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret = false;
-	u64 ack_seq;
 
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
@@ -587,14 +586,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	ack_seq = READ_ONCE(msk->ack_seq);
 	if (READ_ONCE(msk->use_64bit_ack)) {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
-		opts->ext_copy.data_ack = ack_seq;
 		opts->ext_copy.ack64 = 1;
 	} else {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
-		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
 		opts->ext_copy.ack64 = 0;
 	}
 	opts->ext_copy.use_ack = 1;
@@ -1235,17 +1231,16 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(const struct tcp_sock *tp, u64 ack_seq)
 {
 	const struct sock *ssk = (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq += tp->rcv_wnd;
 
 	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent))) {
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
@@ -1369,13 +1364,26 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 
 		if (mpext->use_ack) {
+			const struct sock *ssk = (const struct sock *)tp;
+			struct mptcp_subflow_context *subflow;
+			struct mptcp_sock *msk;
+			u64 ack_seq;
+
+			/* DSS option is set only by mptcp_established_options,
+			 * the caller is __tcp_transmit_skb() and ssk is always
+			 * not NULL.
+			 */
+			subflow = mptcp_subflow_ctx(ssk);
+			msk = mptcp_sk(subflow->conn);
+			ack_seq = READ_ONCE(msk->ack_seq);
 			if (mpext->ack64) {
-				put_unaligned_be64(mpext->data_ack, ptr);
+				put_unaligned_be64(ack_seq, ptr);
 				ptr += 2;
 			} else {
-				put_unaligned_be32(mpext->data_ack32, ptr);
+				put_unaligned_be32(ack_seq, ptr);
 				ptr += 1;
 			}
+			mptcp_set_rwin(tp, ack_seq);
 		}
 
 		if (mpext->use_map) {
@@ -1559,9 +1567,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			i += 4;
 		}
 	}
-
-	if (tp)
-		mptcp_set_rwin(tp);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
-- 
2.53.0

