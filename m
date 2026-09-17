Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182544FDE61
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649355; cv=none; b=jO0ZwY3Za0TZ+16Q1mrWKx/bWcsBGzRXaJLnAKLpgsHTjs5CTNn3kNT+v7Fjl9E6d9CoLAMJ77OBhiQLEX9vtLyIZxxY2xTHCNwRqFLbPtD0Rofo+a/8wfknHQjBlWPHQOAE4LuKjPQBY5mZcGKcZXvQBGgSdZxzXIRWeffFn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649355; c=relaxed/simple;
	bh=+iAzaRdzMStocBQs70FGiS4xXvWbBGOEstnu7kckNzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A99BJzoyUsrtrnXiLtNP0UpsJTCVZayEuvMaMiKAr6rJ4J7twqmzaTlWQe6480J89O2ZohTrDc9eXcIaJH/uyF8xNX/KzzLoKs/yyboYzyQwzsi0DaanDKq/bvNSP3En02rgHMog5TGLUSlm5PupUl1uJoEcWq5jbW1dLyUvt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1oMXKn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1oMXKn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895771F0089D;
	Thu, 17 Sep 2026 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649343;
	bh=NxIH4jEObebVbvetMltjGNEIKzyByU7eDcKs2tZW+3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1oMXKn/+aJ5SQSmJccYsELV/m6sUb/cJ5/s6nIF0mnZnQSz4QQpOPpINMRZHhGhr
	 QSL4icGDJnd66lK2qejRAsB/6t4N3d0DGB0Tp0Jctu5wjhsj9NZBNrlkzBnhEQksZ3
	 DUong7Xr0RqLg2adEMjodyRUc2+Jh/e19fnz5rhgEQRrmAwFWp998bug4iww6T7Lct
	 blWJoqq8E4NNVka/z3hLYArUGfUdYLwjVlTRnZIU5n9hgM+FfJqSJ4ssGebQaCjmPj
	 M7neP9UX0qdW6p1qsnREEZmFrIHaza5u4JPrx0wx1V/aS0P1Ig5eDIKS/F8rc11LBj
	 hJYuvbTxBfhjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
Date: Thu, 17 Sep 2026 08:49:00 -0400
Message-ID: <20260917124900.223767-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917124900.223767-1-sashal@kernel.org>
References: <2026091604-overhung-liqueur-670b@gregkh>
 <20260917124900.223767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

[ Upstream commit 2ac7d6e620764f1fc79eb4edd3610a7a661981ca ]

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint. This happens because the id 0
removal path does not tear down pending announcements, unlike the non-zero
id path.

When the PM later reselects id 0 after adding another signal endpoint, it
finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
in mptcp_pm_announced_alloc().

Root cause: asymmetry between removal paths.
- Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
  mptcp_pm_remove_announced() to clean up.
- Id 0 path: mptcp_nl_remove_id_zero_address() skips cleanup entirely.

Fix by making the id 0 path symmetric: call mptcp_pm_announced_remove()
and decrement add_addr_signaled before queuing the RM_ADDR.

Subtle detail: signal endpoints are stored in anno_list with port 0, but
msk_local carries the connection's local port. In other words, entries
linked to ID0 paths should have port == 0. A follow-up patch will ensure
that. mptcp_pm_announced_remove() uses use_port=true for comparison. So
clear the port before the lookup.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Cc: stable@vger.kernel.org
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_kernel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 116a2c92f851c..ea20ce6393d20 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1720,6 +1720,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1729,7 +1731,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address. */
+		anno_addr = msk_local;
+		anno_addr.port = 0;
+		announced = mptcp_pm_announced_remove(msk, &anno_addr);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
-- 
2.53.0

