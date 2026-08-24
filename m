Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359B3932C8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608803; cv=none; b=Ge5xMHwT5oK3rw4+xLyafHTPbLjGYz3Ote9CwNquvq0CUtciKiJrne/LgWl60PLYSlSQ9chineVUkLs7Y71LlFLZLdWJsodbBpRIaefxudKtuJ3ROPpQU36wwEq6BJJwHXAUa4H5n1rS/lLQg2ZOpJH1z/pkCDB9+EbaF0JjoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608803; c=relaxed/simple;
	bh=QksABwgAvg6DmuQOWq5Wkxreu+d0Ds0JhybRkA6Gg3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUXMh5Ee3rCryEF8pTBY/4l/5m1m3Pe58Ud4Kx4194wyLJxYof+2XapmMKuxQhvfznANcyqNJjmfDzyfdFZ9idSYZ3FFbgdef6ZG3s5A4qh7GzIKr5zfhbXSgO/plrcSCx94u0D9TLqU+gbBp3Hk/iDlbaI5vhGjXIHMNNLEsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwV1pQOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwV1pQOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9861F000E9;
	Mon, 24 Aug 2026 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608801;
	bh=hOdab4E3RpMe1RtVtqAxI7giORjKRUt9E+cY2eRQu7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwV1pQOQT6JxYv3DOTq/VwhAevR5UMY9044N8pWE9FD8717SuyaSxjM9GUFEEJ3ml
	 l5C8df5DPfvqyCZoS+rlbIk5NOoVX67DgPNjKz6ksFJdBT0J6j/kj+YgZc+NKF0Cqx
	 AsQU22E1NN8UFkKMk8l9zN8EEP1eXiUd8EeRf91YXjRpp2hm1EF8Z4mEN8lBtmwf/K
	 eb/5Ek5ryRqAcVbqIShwDB6yWOKIz1uusMJp5WD0f6Ks/3+fzF5JkZhlGfgLpQUnEm
	 1+J6gctDvAGgZMCMRlkuaFQ8H4bQABAWfvb4zUuq+lPvsmWbpEmUjSFBsr1IhgkfnM
	 IGI0pd0tv+C8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: fix data race in add_addr timer callback
Date: Mon, 24 Aug 2026 17:59:59 -0400
Message-ID: <20260824215959.435260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082024-pyromania-remix-dcd2@gregkh>
References: <2026082024-pyromania-remix-dcd2@gregkh>
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
[ applied to mptcp_pm_add_timer() in pm_netlink.c instead of pm.c and collapsed the adaptive backoff branch to `if (!retransmit) timeout = 0;` since the tree lacks exponential ADD_ADDR retransmission timeouts ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 550c4c1b963d8..2762b3f1a25ac 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -296,6 +296,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -333,12 +334,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
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

