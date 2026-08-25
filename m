Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9D3F4827
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657077; cv=none; b=S14+QwDZMhMa0sxq/DXP/MJidGLz9Za2keuAGy/o2jsEOeNKTGkmezgaOOz3dxrew+ODM43BynZl05d5e7MT81NJoIMIUelkDFbgzC06Mv/QPCikEeBhc2Ulhhvs/AB3YXG7ej0p9Le4AOkLqeY0MUy6aBWtLmwuz7u+0e5ro48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657077; c=relaxed/simple;
	bh=LLe3z5qPS86FUsG9t7VApZfURryQxcIh08+LTjz909k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy7sj9ys6Kv8ZUETSKtx1f5hySZlXqJ7aTNTI4r2Os4q9A5UUrgifa6tgupVQ17DYk9hBA4EdBzv+w1rdUsuIk/j/0mrrroF/bmrsQomq+RPbbmh888bGKz2aGia+205dtcpzw5JSwT0IFcvQREPZYKUMZ3/XI2NYlQLFgEE4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNxzI/kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNxzI/kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67CE1F000E9;
	Tue, 25 Aug 2026 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657076;
	bh=2kSnZ6CA7r6qho/o+33xMlNCj93erM1WgUhMNqcQ6BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNxzI/kjJ0EWt+oWTjLBke5PEycOZ3oPddb27svoKr8z3IMUl5EyuB5PpMSgKgbkC
	 VKW+Nq028dp+UQjnYwozRS0XXylxOpHzNFfCgO3lcjzTuHGG+zJKIDAtS5piP5va7V
	 WlP94HNJjjX52Qfmlous3pCUf1+OZiTQuK4z3skQZNDahADONOiUJ7Az5AFj0nonpi
	 vNeWlGF8/WFSnuN4eO/oHXpt11zqk2QKMacDI6PLyAqDzKA715OP+2TFZBOKLv2ScA
	 ab03qtGyOhfo+u2zBk7saqBDyVvRKjxSLb2FUzF0W8vixnuaHNNWJSx1cC+Xr0V2Ma
	 Zd7z+idNdnEUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] mptcp: pm: fix data race in add_addr timer callback
Date: Tue, 25 Aug 2026 07:24:31 -0400
Message-ID: <20260825112431.3541047-4-sashal@kernel.org>
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

From: Qing Luo <luoqing@kylinos.cn>

[ Upstream commit a7aad5b69d3bdaec20a3ed9284e184502450c0cd ]

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

I discovered this issue while studying the code. AI tools helped me to
verify the issue can potentially happen under race conditions.

Use a local 'retransmit' flag set inside pm.lock to capture whether
retransmission is still possible when the lock is taken. This allows to
call mptcp_pm_subflow_established() accordingly, and not depending on
the situation that can be different when checked outside the pm.lock.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-4-b8f496d71664@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied hunk to mptcp_pm_add_timer() in net/mptcp/pm_netlink.c instead of pm.c, dropping the absent adaptive-timeout shift line ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 70170fbbc38d5..e912615e008f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -318,6 +318,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -355,12 +356,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times >= ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (!retransmit)
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:
-- 
2.53.0

