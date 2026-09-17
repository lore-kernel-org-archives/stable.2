Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65137F748
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617216; cv=none; b=EIpxdUXztN3w4iADJudceLXJih95GMqMc4C0Ajq6qO/j8BSnFJDNTF1llmlGqfduvZ4JVy2/o7rUXjrhpDtaMNQeeUCb8bnr9nM04Oq6QpGwEhfKS2Dgfy6DJIzRuSY/xGfXSmL307eVDsAF7C2nwHspcJxtz6fnCAlhsNJxG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617216; c=relaxed/simple;
	bh=2zmj4A7NFB4GGom0XIjXtIA+AVcsdzZ+5tkFpfgf40M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGjY9HMtZLSe0OAdGL8Lc+nQxLWXjWUYnWYkP/DrOwT+HJ5f/dndLdbsY5pF8Ls1atfWEdpHesU7H3jfvBs524ypcSSeQcWLOMXvPpFioKU5N0inEqjcjZ+JRbCgXrg+1yD7cskBd0oQQuNKxXCq/eIhMdieWn6mrdndJ2/jMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw4GHhIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw4GHhIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3941F00893;
	Thu, 17 Sep 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617214;
	bh=ug8AADiZO2lNio6T7xzeEBvV7JbaRzlhuzpt8dM79v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aw4GHhIlJQ/opOE9q8iV4AfiI/K4eUFa2pyV/WXAyd1Agi+gW4czkSbms2k6q7NEV
	 wSdvt/IBIsMoVwQFL4Etj+OlwHsNF1RwrDbkRKPpbRBR9JSUOBUH+MuDGCbm/DL8X7
	 Qj9VOEZRPYD5w0D2mabRHCiQ06E95uKIhWlLN8oWj+/58ciJLRVlv3/ZNLmNTboS9w
	 CMDFu+jgnwW+Azxks9YLxkryJ2xAXaasANoJYfNPFNeYjvlf+5K0X/SlSqgos/Nxpe
	 JdHaZGTUZuWZ7LGleWX6qFmnUGftsJoX8BW222h1TscivpsGVNNXkxBL9ouEUZ31dk
	 zOygwsIsJIBTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Wed, 16 Sep 2026 23:53:31 -0400
Message-ID: <20260917035331.4104961-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035331.4104961-1-sashal@kernel.org>
References: <2026091621-feed-gargle-2568@gregkh>
 <20260917035331.4104961-1-sashal@kernel.org>
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
index a84b635d8ccbf..45bcc27edf9ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3343,6 +3343,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3355,8 +3356,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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

