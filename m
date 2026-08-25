Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3C3F4827
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657075; cv=none; b=sTJ5xxK7tr+I9QkI0x77PinZvPtcKdUti1tXOfm4IRm915LKinkqH43UgBahWtD05VmcbL9WZ9tRseSM3s7zK7FZzL6YWPuqKnGm7QkmhgrdVRjM/K71ojHdF7U/EKd1uRQu3oI9kfNR02EFRxzON2yzwG0hU6yoRGATUBIMEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657075; c=relaxed/simple;
	bh=7CLa9+8fbZtklptzEOiu4tAbnyTYJ5DdtpJD59Fi2Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT/zVm4BMh72uvfGGsDJMEIOzBmlkXh6euQ4idR8saqSp4QfwYGkpTNbVAiWOo7csk8aiItZMoHUEEQsV6T/bWnV+U/Gao3BRVXLCqoQ8MM27GgT6TLALLE3HO6uUn0I0LGJTw0cQ/44gqcpHKuoSuZdENGpavrfOsEtdsjfUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9X2FRHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9X2FRHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9FF1F00A3E;
	Tue, 25 Aug 2026 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657074;
	bh=1zrSr2maqHOqph0ar5QVbGnJxotZCLuUssXQtcrKlKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9X2FRHxTUhxuSF1JVlIPgIOBFdXUIfdiq/aCcLgz0+yuOhd5DXemylCx3lSr6Be0
	 hoc3hfCqYT8FohEZ9Q3SOL7AqnEg4WJ8ZXNi3mZQV4RRhD5AF4HiWOfWaEWpsFZbhE
	 7KFgtm3oTEmTT4N6MoDiqdkrjjachQJaESWs7yO+6Ha2NZE5khebjfFl9g7bhu9Dhp
	 59Qf38kVAxD7i/qmHfKZqEYLRYshDRR/blt/3EKk5G+kVd9AfANsQKAXGzhclBv/7s
	 vMzSHmVldins+X2NM5/20JZozo6ZLq2tL5iXQ+puu84MrQCVIBekYegPjBc4JQgeyD
	 d1UMW7gqgsJ4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Tue, 25 Aug 2026 07:24:29 -0400
Message-ID: <20260825112431.3541047-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825112431.3541047-1-sashal@kernel.org>
References: <2026082026-treble-stylized-d851@gregkh>
 <20260825112431.3541047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a7aad5b69d3b ("mptcp: pm: fix data race in add_addr timer callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index efdea351895d2..171d1542f2a4f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -320,11 +320,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -368,6 +365,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

