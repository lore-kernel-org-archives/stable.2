Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2E4D09F3;
	Mon,  5 Oct 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222764; cv=none; b=Hoel3vjGbvJKjTJz8ecyRaUt68RwKAKvFqSDzdFH3gXFQ+3oTzcSu4kZsFdNs8kYy5UogcYKawOvysVvnul7P6Xnup+4WFakMIy3ibIM8tYF5ryCp3G8plAmMe0xmgn/TGqjl8XWaD4yLyU/3NqnS6Pd7JwdVKRkFz/Jxp6velA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222764; c=relaxed/simple;
	bh=f9rd21x5DZSuVd8FWnmQ/KL4URpKty4MjvFS5ePCjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLzKl2v20qnHYuU2cyVdZ98GsPEsFqLAJhoWSLAzAjEK49iLwNvy6YBtdyoCcZSZm1H8Y00KFSjlO6L+xxDpBhfvkCgLQuFbXzJbnTXs8dQJLehB0AFiPxmvksOUDYRhGLaHr3VMV1KPUamtn0iioy6BVJQsHFxpn8xxGHylIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G63U00he; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G63U00he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454721F000FF;
	Mon,  5 Oct 2026 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222762;
	bh=ltFlzoui2IybJ3dTllemfAKO8ho/zVRNbUg4BL/u25A=;
	h=From:To:Cc:Subject:Date;
	b=G63U00he6uBJiM7h181QXRiXoCJhlDGQ9OMYJs674M6f4cdy0b2SGkS8jLcVnH0Tp
	 ijvsEW4L6Mt6fqEI2miK0HikaRmgi/SAEzE/HKJmoBbmVip+D1qABJIEDjntBRWHCk
	 HmYZNMkuKLeLiV0qCdV4XVPd/gVBekcepvS6ayiIkMd0QoZriROWEWt5NURiod+wqU
	 IeMVjQuLMWyhpyEO4UQirlT4Ukqf9HCZh5hQ0F521b5mAOIY4wCcZy1IORNMR87S5t
	 2ggIs5jclRdkMYFheXUqR+BmdcD/cPcg+yV2Ne9rX+yKMY1iZbizIskdV9lwlxytPM
	 0bTxfTEU90CfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mptcp: prevent race between disconnect() and rtx
Date: Mon,  5 Oct 2026 19:52:27 +0200
Message-ID: <20261005175226.3607979-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=matttbe@kernel.org; h=from:subject; bh=Y4cT23Fa5wgVWhDpUkzKpfDXcB4kHp8rjSVmqFRfnXU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIOP769M/Jz6KftGSIZaW7+514zzGBViVbYeo6fNcfg7 cpL85P6O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSm8zIcK/o4oKmwGnVqbmh /1bdsjLT+rBdRnuX/htbhb9hW3TPCTMy/K9bfaP1zBY1HZZG3/7f85SOWqse28Sprdgbp9uVPfE 1EwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 85c580b0d8590520ae00a15c29e9fb9c99427a3e ]

Sashiko noted that the two event can race, leading to inconsistent
status. Prevent the race using the synchronous timer stop operation.

Cc: stable@vger.kernel.org
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but reset msk->timer_ival to TCP_RTO_MIN: in this kernel
  version, icsk->icsk_rto_min is not initialised, because this version
  doesn't contain commit ea4eb2adb0d3 ("mptcp: honour configured min/max
  RTO in retransmit paths"). Use TCP_RTO_MIN, similar to how
  msk->timer_ival is reset in __mptcp_init_sock() in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a64223c3884..da774b1a9460 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3367,6 +3367,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3379,8 +3380,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = TCP_RTO_MIN;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
-- 
2.55.0

