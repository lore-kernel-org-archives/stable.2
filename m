Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1813A6F1A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615116; cv=none; b=AJ8KYziqcwT92LFMtFTeaQMxhLfBobotJCnFnXuTOSxq4djwIRbiv3DXEkT1WvwGhoaHua9iYVAtGhMNdz9mILkOQJeRWOIaoVYkB+7tuMHTpveW/Kc2j7IB40PX73CrORNHpW40Fc+OVVJb4f1rphcNjxR+qOakKvC4srF/5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615116; c=relaxed/simple;
	bh=y7BhD3LNpCO5eLniCtdet6ZafeXIrmP8yZXbc22/024=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHVsqKZrEmIOwAc0C3aqHCSeK6o1DRdS3plITKw5zBB0yaiApyMr+whJhTuwfwEXAQygGxlgnytVhqg8EPs456qzgBXwRPoeyWPjhwIoOAmCmbPmmKcmeB3gwA/TuMB7cGs4J6yJbH4mxOWTsmxQmgUJWxxoC2nXb4tY4U4y6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izduct8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izduct8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D01F000FF;
	Thu, 17 Sep 2026 03:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615112;
	bh=i1J/iwWmBYlU+w09aPTbN9hjI7W6cC29QlFMT7cxGqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Izduct8IqAM3dO35wzKe57BBNT6D9lEVwNAzCupfFJBOSNzA6zF7J6BCTHJKul6I4
	 9EnjOG8ciro8f8tpidXHC+KfEsqV6AbOqUhTcmcxLzKwPIChdCYUM1ZsgabYTp2wxG
	 wN7768akgrahtbS5MbUNjduEc1rEWe/PRy2DUA27WbMNlhSqhM1qL4uJRSSCvPtePU
	 /Fdu+liYkim5EaWY8CVWSPsN/mFy14bdNNlJe1Ce5Rl6DTSZ/omy3F2833Z6dQMcnE
	 VJv341UKF9IMR6/nAbfkGMEGGG3+wnClfU8ZcSgumdXf857B7D8lV/Z5+7IC3GzTYb
	 te+ns14kPRMqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
Date: Wed, 16 Sep 2026 23:18:30 -0400
Message-ID: <20260917031830.3985013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-twisty-extenuate-7c8b@gregkh>
References: <2026091615-twisty-extenuate-7c8b@gregkh>
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
index 0d8316bc50775..532f75d29124d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -428,10 +428,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

