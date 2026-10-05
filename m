Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DB1F5821;
	Mon,  5 Oct 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222132; cv=none; b=kD99JfLztDOjZEnHSgx7+hvWfjUufBXpydGuhYcn8dX1zPEf5ki3+LBmofqWAL51dsuNkJm04zb4Zb6YDPfZ/Dt5OCxz4pO5UnK7nyizBPoIapjsJzN6ARfxuAnuTPQvCeFOYpiS70KXFw6dXilJP07YwO/Rav8ktFfTf1iR4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222132; c=relaxed/simple;
	bh=CGm6ph1IBhJ8hiJ/GT1AIMCs4pBFUcVB/aSkqQRyHQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDYnIQMo5c+J3SmEOe3Qyfse5EVImP51mmRcZ3eBirtPA46e4XCDXsb9LKPjHdQNqxKvV/OD+5nxiAa1GgQkm4omQzco+46NvJhLC/0O2DmNPMjMwOHYqANa1W0TfbYvmkaD+cI4tTcZNrUJLg3OBILdR2VfHIeQsDBb683odzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXS7LhA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXS7LhA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1352F1F000FF;
	Mon,  5 Oct 2026 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222131;
	bh=bDTdKoSj30/4yoqOoyu9+GmBwMUZtlmLRAXIIKlDZc4=;
	h=From:To:Cc:Subject:Date;
	b=PXS7LhA98X0Xt+ouSyukD+Au7IHeapO/WEXrauHqtAZZMrz0OswFZik+fBGQ9gJ8u
	 PD+01k8w1bbo/gA1lQHPe4gEuNGoxJ/YKJo4TNubYbGqZ7s2DWopF8WrmMs7LiXdPp
	 k1LUMdtuONuS+qTVy4wcLLLSU426XThN0QQ6X9zjKI43DoSHSseAJs4YpBZ1nM1y7z
	 ccznw4Ltp/my6expOSLKezuQH71ZIckZcsm0C8I4ViqOomxiH16y+fiyDk3iq8MZNg
	 tL03N0pWefst7SLykPdcfaJ4OABSeHp6IFrwxOOBaeInEQuuU03RQ9ihW935Px1nWY
	 TljD1Xki6lTOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.18.y] mptcp: fix msk->timer_ival reset
Date: Mon,  5 Oct 2026 19:41:17 +0200
Message-ID: <20261005174116.3521187-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=matttbe@kernel.org; h=from:subject; bh=CGm6ph1IBhJ8hiJ/GT1AIMCs4pBFUcVB/aSkqQRyHQQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIOP7Td+4SlmM3OdtumFx4GVmkJC/dc9Infrnzu2fW04 q+HX4Uf7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjImXyGfwYzfZuyCzc/zPLz X/f0TLrUtSW31hlKSaWfmn5L28TfL4nhf8kH2dTFAuE73yhd6X998d30zmqpC+uWn+Zc6DnhN6u UFDcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

In this kernel version, icsk->icsk_rto_min is not initialised, because
this version doesn't contain commit ea4eb2adb0d3 ("mptcp: honour
configured min/max RTO in retransmit paths").

Reset it to TCP_RTO_MIN, which is how msk->timer_ival is also reset in
__mptcp_init_sock() in this version.

Fixes: 374da2b9be12 ("mptcp: prevent race between disconnect() and rtx")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9967d55b8ac..d0e3e17c698e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3312,7 +3312,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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

