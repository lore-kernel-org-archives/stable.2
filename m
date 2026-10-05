Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0F4CE66B;
	Mon,  5 Oct 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222153; cv=none; b=TXX0M/4e/r8rNI581k9azzy09ZcsPjizvaqF+pApYMmca3b+DHpvpFWJwv9089LKSyCB7/UZOJp+aOJBOQLO5f66kYlT33AWKziE6yyJqb7D/JEHmqunj0V73q1FbbVDar9yVrUfYeM3fT0FlNMQqFLc4zr+ibLn7L1RIV83o8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222153; c=relaxed/simple;
	bh=Za2dX5FqS1ZQjfGl7lMumIPEWf1lnwcUgDledDDUo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hs9zHGKQSLMgmufqLwU3S7GBeY2VjtnmwbgonbEqx06gGpdl+W3KJ6xWHP2YKUvad0Q4oeFeyQJM6C6AGfRQtoRAp9E16d4OvxP8fGRyyTV3UMbeYP9axmiOalnXb0IqHosJLqdpqBvEiwem/0E0o7bxF4aQmjSSnZguX69NjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKlG8h24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKlG8h24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41141F000FF;
	Mon,  5 Oct 2026 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222150;
	bh=vQK2vqQ097SOINaf8eeaU53BMa5XdHI4IDf0I96U28c=;
	h=From:To:Cc:Subject:Date;
	b=HKlG8h24xS0ktArzET8qceFQuVQSqwULA5NfNTEKRLT7FtaWTzs80f0HL5Pe0JZu6
	 NCh4db7pQWF/xFPpedVy1IbLAQA3z9nJeN+k8Ok3U6D3OxR2XlVcIl7dnIyN6ednWN
	 VPbnbxTAVZROFCE50XCNwvrGwtp3sCEqIq1BP3YnKAFlaFMsgXV1Dkw9JBSKE+4s9i
	 lXUps43RWe4nrntLIBPGDlUJ2Oufg95difrBn5msUPhCENE8B3XrmQgodEsfol0tJ2
	 UOimNeytbgCu359O7crhNQpz3BOR9gRLQ/cTxPvJetJfrECtrZ4sf6IXq9uvTwzjHJ
	 b4CxFDnF3fAGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 7.2.y] mptcp: fix msk->timer_ival reset
Date: Mon,  5 Oct 2026 19:42:23 +0200
Message-ID: <20261005174222.3524381-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=matttbe@kernel.org; h=from:subject; bh=Za2dX5FqS1ZQjfGl7lMumIPEWf1lnwcUgDledDDUo/s=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIOP6xfHaGSuHpNl1ISv7BTZ69ckNaHjj3fIvdxRktnL AvPqevrKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIiKF8N/Xy+BXW/kZR/KuP7I W8PN9aSV7122gq3borKcZyLbjpfyM/wP2Xj9fOmB656rrOU6BNWu86j+ae1fPCm3Y4ertsHzeam MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

In this kernel version, icsk->icsk_rto_min is not initialised, because
this version doesn't contain commit ea4eb2adb0d3 ("mptcp: honour
configured min/max RTO in retransmit paths").

Reset it to TCP_RTO_MIN, which is how msk->timer_ival is also reset in
__mptcp_init_sock() in this version.

Fixes: 69a7b2a91267 ("mptcp: prevent race between disconnect() and rtx")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 49c46498af96..5a97ed9487b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3475,7 +3475,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* The later subflow close can not kick again the tout timer,
 	 * as the msk is already in closed status.
 	 */
-	msk->timer_ival = icsk->icsk_rto_min;
+	msk->timer_ival = TCP_RTO_MIN;
 	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
 	icsk->icsk_mtup.probe_timestamp = 0;
 	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
-- 
2.55.0

