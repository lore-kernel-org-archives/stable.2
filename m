Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E624A06A;
	Mon,  1 Jun 2026 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283446; cv=none; b=ZmoaX02yMad74Ebd1hdaGIFy/btyBcBIXZKWzrwK7PdireUzMeuRzT7GnEoJmuG5OKhs97HjwKNDMJRqWM6tsXv0wNG8Us+bgfU05JQ2gs5pyj4cQIVG9G1sm5dlNQ0+asSNezB6ZtTc/d8yPBMZugWNNw5pZYfpsR/MpxwCVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283446; c=relaxed/simple;
	bh=LvIp5FpoLlwZVJv3H6wq05IdpHGQhpdtJrZx5LYu8Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3BuJ2mKC6XO1tCPalhw1vEmszlQcIMr6ieRSPn2rqIN8iMYlTrU43Rzji/AxpXQuZF0hqVgkZI3tgXFpAR7oygZYYA+hsTZiP7VMOG0ogRW8E6Qsy1p1ZvR9DIuOu2iDf4AAKIYDjquJ3sD5E/3rLgJbhjldTNtmsR9239TtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDGwWKAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDGwWKAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D491F00898;
	Mon,  1 Jun 2026 03:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283444;
	bh=fneaZWRJcf1CABw10dTQbdjAJqpoziBhtnq/NZOulcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kDGwWKAIEtoWDvxTeIuKj/OkmOUvDLZ2jXwi5nWf515mdrN6WnFWYL6lOqKdfWbH8
	 ceLMkn8ncb4MqZIowhERRh6+j66ezdqbLACZnk+TkB7lE74T+3HVcwCTbv6+XqU5uk
	 /PlrfOonBkDsdWYYWU+cceCluKVDgRR6KWxGm5BCqLMuJQ0o2D3tZnasI++GPShivB
	 Pvkp3Ne+nJW8LPnAsVB+05SxdvT1YyZSwagWr3Lg1RkAnyKaCR2VCJSxkdnozFmfYv
	 gve3BbIOrJgkXgsF+/DM3DxNf+BRG9AtfIpa7jRh+RpvFtwSyMOVF8UqMCmSVTDD3a
	 944dY9RkSVQ8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:09:59 +1000
Subject: [PATCH net 03/10] mptcp: close TOCTOU race while computing rcv_wnd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-3-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jd0W6OwC1TLdwOI/7nVrZyQnci0vCW9EbOM1xsUajvE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeF0td0braSmVEzSl25B3GB836j21bVXHSr
 UFKFKsUp2GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 cx5NEACLgrpMg5U+JrA2ifodSGtSWC40A9mXJmvJsfC98JcAjTIKAouddpHEuHBTNkFv9xjVJp3
 ymXeZIshX0/bFmydmIDDS0ciYWYPwf5NC1ogArcnAFp9CNW3wMvivC3wX4fD88YldvOG0YKh26q
 oKwa2SqwkD9Vhf6xAtCHCLHA79iHhA8Vp0EMAGwUnH7Hiq5x/Ol15neBQvsLbx0h9WYPLdzN0WS
 17fgdg1yGs9UimQRdIvTV7SgGE0I8RmEUeNdntXrrXF/5vZXVxaPCpTUw74kgdKxK9zoKunexB2
 13L2HiJN+4YpAw/lXzWsG8mAeTbnUF7Iy1BE9+5z9H6g6TVhxnKfFlsyewOmV/tmfxdjJUGYW0r
 fEqA7MJ98iS7s3u/AbNE8xK3t0P9YTHZAskJNHoWz3V0rZ9zHJT+6422sqI5/kyCsI3OXqUEqzx
 eAKhSlAZPdRLXF6g+VzSv/isAI7XlNaEPZAOTpbsY9gZ78OGqzT0gud9gRChBottowc5i5CprYd
 u264oKV+wGUgnCAEUWr/rC1Ro0aubqV5jBhUEMDYTBsTTOkku8+99X4fhGk5BCduHP8QeUgml/L
 xSkW19ERrkvLNhS4BkgcCLzz7PEjaah/tBLHarin9pU7L/fnw/QhXdTVbef4qLcXoHfQrZiKOKL
 xGdJEitcBSPn/GA==
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
index 8a1c5698983c..5c228344e83f 100644
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
+			/* DSS option is set only by mptcp_established_option,
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

