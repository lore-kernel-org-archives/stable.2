Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F125A640
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609160; cv=none; b=jcalg4lcr9KYXiFeMjAA7M/LEIQH4oRTIWDlziutgV6Tlgsf0sD+7frfrQeU5/ABnQuZKA8sDwFz9q8e7oS/90AhdROrwiBdkL0cSjfqy8zGzfgML+ahPpVcWEHWJQ/Azm/RXnN9LKn2Ii7N/HscbOua8Hvo5WPVHtFyGIce1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609160; c=relaxed/simple;
	bh=SZyTia8F3E7QVkzw0rkEPLeI+6EgHmHpfEtn5wdtYZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfXD6F3tMY+tgO5b1phoEWF2ahdyhIyTFNCWa621nzl3y5M7kByxcgUOh5jkh9vj6GDHbksgNA8zIRnjto0xlQLHyTPboQbYKIOhLiRMxCUePBl5I/0fnuxLQBOmlMjownIPFpWquVQ+8GPJQ4bOJ/JQfFH4MKTfYaS3IAQGJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAuu0j+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAuu0j+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C2A1F00A3A;
	Mon, 24 Aug 2026 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609159;
	bh=E1v1GSqa2k6dxWGttVdnXkdMF0bbjA9dP1m3XdPdQyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAuu0j+mDUrqqjZdpNzMzCQmP+krbx6UHAsPS9oFzsB/6Xo1PMU88n5jEbcQxM9Y0
	 S9KiBOppBEvZJV+CFTCMAcP2sk3ylCTz0mRU/Ph5ulDr37sQ9T/2qjjRR1+gkUeF4f
	 n0DTxracj1bB6mAGeEfkgtadQCyRhjwPzDNclrW5m6sYT7+lU3T8pOlIKW+ohW8g8a
	 X06RmehIQcTJaVH7a6OWRu5xa4G17U/1maDhjN2Hd0W6HGOo+lnVRXfbQoBB8t0tuG
	 0lL5vE06Z86SyANGvDAVUJg0cL0W0NFHnCuPaselqA8Bae9iDoOjMfVV+7oM9In18g
	 hqm6bdssszh+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: fix data race in add_addr timer callback
Date: Mon, 24 Aug 2026 18:05:57 -0400
Message-ID: <20260824220557.440554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082025-multitask-unfazed-269a@gregkh>
References: <2026082025-multitask-unfazed-269a@gregkh>
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
index 242011de052a8..6ae37d017d893 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -297,6 +297,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -334,12 +335,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
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

