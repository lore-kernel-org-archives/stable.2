Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14426347FCD
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614256; cv=none; b=nmwjGmC1UYGK829cU5VKb0k+g6Q3T6jaKldzg9uIIWZIs4a/I3D2spJzMZPEN+0N+TcYrcUk+D5KUXsPmmHPbnEyPLLghTVgNVkFEc5mGOP+md2D6wIlbGzLoqZo1FUOplgrFLwW2u/9Im0epZy02ECctgB+Cn3QH7I3PpUlAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614256; c=relaxed/simple;
	bh=ZV+xodTfYKm2weRZMf4aA/16bo68GfsfmP/64RKIVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+2xge0zOtSjdbacrvPNOPJigEFGQiheAdI2ZeFPdZVmEQmNTgLtaoKtsJ95ew4bB3gCl7aw/e+IAcTryzJ7L5sSmbwg4hFhTgCWN7Nqu21u4uZFRA89G7RYuF5fzCZLS2oC1tCefRMbkFtDpE6RXtk9AMNlFs5g5Hr5siQwaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOLuNL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOLuNL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F8C1F00893;
	Thu, 17 Sep 2026 03:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614251;
	bh=RWUo8Mdy8Z0Yj3VR1WcmFfn3TXag4AuOPYSh6vC8Ulo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTOLuNL4XasAVk7HJLV1ZuKVouqZyHelw9K2FxhW7pmbtDpJPIILTqgPcPZQd2Xpp
	 lwqEuI0G5zWCzrUc2GNS2b9sgtWXxUPcY0fj3Hy+cK6pVHVs4HY9V6Y8hm6Jj/d2mG
	 ltmylMw7UvHvRL+xgfWjqw1mr8QE8XJfT3RWLdXsjN6QPIepDA1yGxdElRK0kYRBKm
	 uJ5eFG30jvbAffrDrOYmbGLIZyX2V0zNjVvBlpKELDz0q6QMYOhd87ZWLoPVgAA59W
	 gPWWRVwBfjGtvpnB21Rbe3E/bNK0n8qbkQeh0TKZKJlgnWJoSuISQYgT8AEH++/jA2
	 rehgLznuDFrjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
Date: Wed, 16 Sep 2026 23:04:09 -0400
Message-ID: <20260917030409.3945992-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091614-duplex-storeroom-dfdb@gregkh>
References: <2026091614-duplex-storeroom-dfdb@gregkh>
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
index 7ea8ccd16df2f..18f310e50d09b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -417,10 +417,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

