Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFF3D75CD;
	Tue,  2 Jun 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402497; cv=none; b=VMl9E27wyzR5WyVCCeMUqGuYiYH/VTVe4esK6b5ObrhTnxfctHrVF3cFRN1yeFNT328NBZQQIIc5BGqc8mN7gGFbAVGgH/OENmxKc3K3aXhGWKbVIiBU3QtMC1zHOE/QRSjrakRbM1ujUMeaMTgX54UjYL1YDBNMnn1dABaFN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402497; c=relaxed/simple;
	bh=jBgzogHroSyH3RGwTgEBFf2pIGnpDvwm5wRjXJySUWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWMRTzew8P7L/gSIN8TzJ/n9S6AajQ8/bNWb3naIv6khlQ9UZO1RNi8qg40/Ci0sYQfJd3LpSO3gJho1HtnduPRSEtnBlF5rCPnlfQQWUqv4QtfT+uM1J+PAeyXH0dvVSngu+UxH/RTEUjb3vH+tAWJgOXDr+I7zck0gCbG98GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNWLhE14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNWLhE14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA61F0089A;
	Tue,  2 Jun 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402496;
	bh=PeIzH2RQMo2+yCD0FPitqljkg8IzJphIovhYUeiSSIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bNWLhE147UyzR/IIjrn1kd+y8zjjWwl2YE+71Kx5Vhi9MV7NLwGK0d7LXcHx1mhcs
	 69cMRMZKQnLFGvB4mEW7K+PNeLX5uPovCfU+wgCZnv22v9iqwJYgbhg9YRmiOtC/Nm
	 JHo6zxSfZH99wO8Bxbi/MzZwtOFMdhrnvsywp506AotK39XDvg/yEfZ/o6chsvO1TE
	 ZwnbEnxIfJdcMhOOjOn7XWDpIeRUH9rpvAoNxW/UnvkXaE8ffZyoTxx9ujGRsIEJA0
	 zYXAfj+yscpjS3DH7PSdeVDC/4vN0MN1uNwgQLvVz1U+B0KcAp5KIMCUfBO6n+5ZdF
	 2j+2lWGL6nw9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:10 +1000
Subject: [PATCH net v2 03/11] mptcp: close TOCTOU race while computing
 rcv_wnd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-3-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3838; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2Fsu/GUr9y27OlxB9B+kvW2hHPd+B+X0zyN/HUKfhN4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsks5sJKGW2eZlMU2xV5T/SPDA/c60LO6Me8o
 bfVzbFpTtuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 czHMD/oDGBXCqu0tpdkGP7aleZq5C2SLkw7SwS2vcgjrGs1o6NY7X0lK0PLdggjBeCHyyu2fAzR
 T/PAVWePFIN5huWbYkmafQ9C2sQCyyMbx9SPxy0bpzmfE6Quwd7CeHbG855LENimXZaTB2wTwed
 Tna1UuRlH4AeGyTF55CQ4+hoEhHwww44nqNKDrOaD34lf8Aiz4as7D/7dRuLzaiJrhKPI4g9sPo
 XigetEqZph3c5Dnog1NW/l11U+Par8A/ZLEHjovcc1q5f+OB4L8Ysunl63zNKw2bvks9u/KhG0F
 12PsMGGvVJYTbTCER5qKQ8RWIEJjuKZAjBiyKo/1ctMWueZgdi3IJBLROLfyGaz0mAz+HHzL+rn
 dN7iHgENWmVoZLplsX95gVI5mJHwYNON0t7RGalGwGzi1oBUZdX+23xkMQRhEITE9BM7qRVetPp
 1RF0ISuQcXolLfCN6hmmVVpssDGbQa8fc6tptoqRYntyVckIQaRp7Kkai5Ylu8GpQmz0wEDkp6x
 N5d+T+qwmSq5LRthsf7Tspu3AK9aWQwf5FnqF4Tbliz9Uh/abuw+PJduczDoW/0/ZwxUgeOlfBB
 trXNtIySlJq3EY00E4YhlT4GU5kqSwAAvAo45Ud3rIcZD3nI9d2mkhmDtfXj0j/4c11eJn0ucTN
 nrO2QjC2bcp7NZQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/options.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..2d25f319f328 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret = false;
-	u64 ack_seq;
 
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
@@ -601,14 +600,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
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
@@ -1297,19 +1293,14 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
+static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock *tp,
+			  struct tcphdr *th, u64 ack_seq)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	struct mptcp_subflow_context *subflow;
-	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
-	struct mptcp_sock *msk;
+	u64 rcv_wnd_old, rcv_wnd_new;
 	u32 new_win;
 	u64 win;
 
-	subflow = mptcp_subflow_ctx(ssk);
-	msk = mptcp_sk(subflow->conn);
-
-	ack_seq = READ_ONCE(msk->ack_seq);
 	rcv_wnd_new = ack_seq + tp->rcv_wnd;
 
 	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
@@ -1362,7 +1353,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 update_wspace:
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
-	subflow->rcv_wnd_sent = rcv_wnd_new;
+	return rcv_wnd_new;
 }
 
 static void mptcp_track_rwin(struct tcp_sock *tp)
@@ -1474,13 +1465,25 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 
 		if (mpext->use_ack) {
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
+			subflow->rcv_wnd_sent = mptcp_set_rwin(msk, tp, th,
+							       ack_seq);
 		}
 
 		if (mpext->use_map) {
@@ -1708,9 +1711,6 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			i += 4;
 		}
 	}
-
-	if (tp)
-		mptcp_set_rwin(tp, th);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)

-- 
2.53.0

