Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414A384CE5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614837; cv=none; b=cguCMQ+HHXyGIgdvslY7ojzkslnEQFKWbaSjv+3gOn0GUbZaFMr3alikUkBWWwhVuAFyOtVp7lid3j7JLSekHSDOLHfIn5e9Ata0TF0Aivi4lMVyuoPvE/AZEUON9bRl3UMmTCDz20+oTxBEpN/MUZPVGCiv/Ws5ZEm128wiZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614837; c=relaxed/simple;
	bh=2mU3RdsvxtaBsYYzGDEEjaj5T5b/mv9Nfjp9HTOwiEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t93JFaJCiYTc+gIaJ8n6X8FM1b3EIwbgYYVeY3L/I5qqtr2un7KN8zty8OvzWTxFeEoh28+0gl7f/YMa7cTo1zoFd5jV7iNeR7hU8BXcc0f9njhJzADgtPiWgYOxsz+sVPz0OR5coDw3ucIBfxEnbB6iS6RgXJYtLla8je7E3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAHdNDeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAHdNDeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E4B1F00898;
	Thu, 17 Sep 2026 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614835;
	bh=JEGTbu32C5LHkdXNroA+954lplyOJVMT9cnXvo2UyNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gAHdNDeSRXSwWM9XMbhuM74Pd1/Hq2T+cSaL+TrDFJ/f3GRWO0wNyl3UXtVZtYlkr
	 o2ASxmA8LpgbVjzcT2La94cq0UXbOtbljQTW2BjMooyD3TvS9HpRYMt4ItHXcyciqS
	 MoOek7zWqB7T/AB+0hkxVXBJUDFAjh/Qhy1dRMJvS8E4szjq9tLGgzuU/t/e7sNlIv
	 NVjF77kqxgu/af5ZsL8f+0pYR8O9uE5PW03gZTgFG9HO6hMDvw3nfZpjDuq5G9cSxt
	 sWyYkjU5zF4JlHFJRAKNOjsyN7j96QeRSU9PvOVQtABH1YPw3RO+LUMdQjn4YX9GTo
	 HauMfxnRffj6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
Date: Wed, 16 Sep 2026 23:13:53 -0400
Message-ID: <20260917031353.3971927-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091614-legroom-celibacy-38bd@gregkh>
References: <2026091614-legroom-celibacy-38bd@gregkh>
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
[ adapted mptcp_pm_announced_alloc() in pm.c to mptcp_pm_alloc_anno_list() in pm_netlink.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2be19e1877c88..2e5eb51d6ee09 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -418,10 +418,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_get_add_addr_timeout(net);
 	if (timeout)
-- 
2.53.0

