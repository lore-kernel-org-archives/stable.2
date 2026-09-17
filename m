Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AF5013A8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649368; cv=none; b=Ka454u1Wy/dFFtL8rIFSkkPBdATPeuvkM/Qtnl2u8RTr8o0LThO06us1s8Mo44f8Mc2sOwuyt723t2Z+OwV/oplr2QD7bi/AlfGeFT1WWDqY2YvihyNwzpAXZTy/cDw+0hI3AGTNvuMnx2K5ZqI0QtULy19oxcKYsrebi+hALWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649368; c=relaxed/simple;
	bh=NR5NZ+SNbXPxpPiVQnZrVdqyL0yqPHzIVoBK67dRvAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/UpHbibR+tgz9PeJoaYsigCPXrNSODDDD0sM0mVvT+vTVldBeEMIL4eMO2+TuYf4K6ulKl1OpHLl6scO3vaR/GxV5ktjjx5A+bdGSTk4ruJBT9J7b7UAqpDgonWWIX36UyplxyyHbd7lwt5aK5pTWXF6DB3HQkItVWZN81m3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otIuNYVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otIuNYVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F901F0089E;
	Thu, 17 Sep 2026 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649345;
	bh=0obDed2WdsYw0KFseBRJe29BxHrw8MTK3/pDN6dAPMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otIuNYVItzAG0yAxm1v8kYw08TaxR023aGDHfskjdJ8MviDNXFCFzXQnbG2yBk9Fh
	 Ma8Apj810QsdkamzgM7oqsZMXyG1o3C1RxDLmhVRL+b6xEkztsN3vm4V+u+yOa/Ex8
	 XO6hOVe4qbF4Qm9VPfw4WuZund1vwbeye96Ks18EU3f34Nqu/Qg7Lzf6NHzFIxqCIg
	 5oEwEc7oWYTAhMVZHWl6SCLmg0CgEUOxuqeCHlD1M9q6i7ZUOsLNZAjkLgtsnMMC19
	 rBJo8VnkU+T1/PheP8XMOBTbhMtaRSmW/ilEmAxHgUFdNQyIrmXugMh9gVV6WsndKQ
	 Y1MLO+VtJnj1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Thu, 17 Sep 2026 08:49:03 -0400
Message-ID: <20260917124903.223926-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917124903.223926-1-sashal@kernel.org>
References: <2026091621-borough-happiness-9e59@gregkh>
 <20260917124903.223926-1-sashal@kernel.org>
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
index eb5ade30f1a31..8e67f3ef8cac6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3302,6 +3302,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3314,8 +3315,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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

