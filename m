Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C03998BE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613446; cv=none; b=i07nP5XK14RCkmnoxk/hcLdvmtDB4/OdABVdnvNJMn7lQ9dhxb0VpvM1+MDHpH09xVxCr8I6jm8k1lNroAx/0p/QC8w22zo/MYC5vtYt7QT+CNHv8eAgB6TXMPD+7g48pBleVxlbZr59REkyZrA2teePIUNOf6sx9rl/7Wv9qnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613446; c=relaxed/simple;
	bh=5Ot0REBdqvAHndsnmv68pX4D7QqVjPGBXfzkz+4GM94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns88MdgqozzBL/jvP5nJ1aqOE/z9sRfa5+PJmLX4i3ydnkwxtZfpi7LarNRvYaX/3O+D0aNsVPh5/AAWz2Tlzo0MAbl+b+kX1ODH9DzYOvneNVLvkEoM6THHSOGXgkzA5p64ALHL3GilfzmBAFWIZWOygFkt2Br+Q/dXpMPoh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNm20C0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNm20C0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AEA1F0089F;
	Thu, 17 Sep 2026 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613419;
	bh=0YIMly9ix9UNlXvb1NSyQQpDv71rgV/HYYRjRAr3D1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNm20C0sjpjD2vQprUJhQD28ZxZPUfmQAVM4m1G2eB/ytcNbVDxFxIecJ7mz7xmez
	 rXhzNrwrUA52jGK8MO2MCsUS4qdwW0ee51dVILRqyALEbflsnRHMK8Rffn8Mc2F7VP
	 8QUouvH+5RS8WiDEeee6OPtR4VpVonc0kXtQWTlOCmcxTtDPO28KiMEyKMT4J0/QPg
	 JePml1Su3HAPOl/37BHbTTMfE0UnisJb0mFH5nFaBe3Uf0HVCfnG/luwkYgeAoqyhq
	 GFAqpOn4XpsqRB9VYjXk6RkGThKmHN6ilYCCuTLwWrvgPCKVWJEZRaHnfd3oEs6bV8
	 Zd7a3/indC+ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] mptcp: prevent race between disconnect() and rtx
Date: Wed, 16 Sep 2026 22:50:15 -0400
Message-ID: <20260917025015.3917201-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025015.3917201-1-sashal@kernel.org>
References: <2026091620-haziness-luridness-ad42@gregkh>
 <20260917025015.3917201-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2dd6840089f86..a31ffe2fcfe91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3289,6 +3289,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3301,8 +3302,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = icsk->icsk_rto_min;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	mptcp_pm_connection_closed(msk);
 
-- 
2.53.0

