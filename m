Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D435F16C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612649; cv=none; b=NQZe+WshMQGqrEIrhtBLd45S0dF6Rp+oN9d5OZ4ysWWRwsp4MI8/Zeh08RXoLLgA14ukmtycXre9AgFTuQOhdeZWGyFknYO4FiS8q2uvNHCA8xTUkL4qmrYvoT/EvDZlQid2S8otfotSYfSMasbLqxrYDmD3QIHSO9ducBRbtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612649; c=relaxed/simple;
	bh=MPptYhe/YPX6nrVuQ66mmLJidyzDA1qkbXnIM3c4k7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id0fbOtQCgZaKVwfCYVmQNzEJIjHsq9m5p4qd7NOD4Hw6471Rsg2T12hZ4vHym0W3mr93b0G64G+43njGd9xqVc70HI+XXkArm6wSnupKJM0O/51kzmovV1FXMj6HnYV/QiGcBiIozErk6u1KeOiFlj89PmMud2ZUgNdmPip7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVDVG+T4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVDVG+T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6541F000FF;
	Thu, 17 Sep 2026 02:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612637;
	bh=dbuiMrCdFKIuu2UEa2V4LRvPIVhTzAUra67mWxHqrP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVDVG+T4+jt+hwy2wTOEpVwWWuU5qOobd3VNxsV7Gp/yqdNn+/LNvVgyVM+zDWeI+
	 nQEjtmd7tI0h6kJiB4gpuewX7fqmSwiAMv9BCqf4pppLlGkz4DYYl9UCeIYc2Mwmrl
	 DzjkyxBx2trOowIp87MHKIgnO1hrQc6JZViihPYrZTjMu6N/mzBLglQJXm+MzFtWWY
	 Cp/8mSBaZc+GnpTskqw03Mw21vv6gxxSZCzFLDMPMq35hNmBZXueV9RjFL35Jvw70L
	 aEXiq1Z9ACGQ0Wr9oHhTu8rfHTgWbd6M0UiGsgyg8H1J4CdFUWUYMUpmbfOQxUndKr
	 v+JMN4JrAXL1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
Date: Wed, 16 Sep 2026 22:37:15 -0400
Message-ID: <20260917023715.3900225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091613-definite-creation-7022@gregkh>
References: <2026091613-definite-creation-7022@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit f968190c0b42ea2004dc1426359a53ec365a7a37 ]

When an ADD_ADDR entry is reused, the timer is re-armed, because the
goal is to re-announce an ADD_ADDR, and eventually retransmit it if
needed.

In this case, the retransmission counter should be reset as well, so the
re-announced address gets its retransmissions back instead of relying on
what was left before, and possibly not being able to retransmit it.

Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
Cc: stable@vger.kernel.org
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-9-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a67efcfa26f14..01c91edbee1e7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -461,10 +461,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-- 
2.53.0

