Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1962387378
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617276; cv=none; b=ScobfvdlZEColL9e/u7pbHKn0LzXjYbCpaUODbyy+YxrPahOqlX5NGKYMGzBRnO0+rV2hDH8rlH1LgdmQz+m0WvIBvy2/cCnV2n2FrhwpURdfcOBxP3nHCEA2rYT+2hp7HFqMb1NIw2rOCFN/3JhA6lbFzTtgoZqCEJasAni8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617276; c=relaxed/simple;
	bh=SS4OF6UwvvqRbgmrOkUTlQocBhQT7d9gw0JIHzSEazA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7n3n5lFKVZhYrl8Tzx2vqLC7Z//iGWXF+gnnd3gaGqDbAOGQBM2dABV/BaahMyFUvyMe6GgdkMkhFSJ/8qToG+kDzNjsMGjcNJExqjtVsKvUslCcWqvNjnAN75DdDAyFew9J9koSaaY6HoBIyFeH4qsuvqpoiGd8wsRYxuflJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOvnl5BL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOvnl5BL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D31C1F00893;
	Thu, 17 Sep 2026 03:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617273;
	bh=BQBuBTVkgwFV9CZXGFqKt92lqRjf5FDWZX2lcjioRYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOvnl5BLmPa2GT7Eed5hU4RnW52nEv5FIngyBFpL9dOgX5G4uuFK05lGu6gpBicv3
	 1WJ662pXa+8AOP/iDd3cp8De+Mjm6/smk8L6hlAb4w/XfViUep8Lt3fJvm+YF54LdD
	 Mx5x/bZ+JTXvKp3rYF3FK3YwzMFV2hdGe3btkqP1sIKNnOwOVY/OwQxXEbI40DIrYi
	 amoUCFHD8DzCc/PlmnuvwGI7BfwuenPYv6qNmx3Jy+fLZ+N+xEQaxMrF3pyQYNF1j+
	 TcaRiXBAz7Dcp0L3n5+XJDBxILqK7f6+aQ7oHCI7bh3CJ2rfvt8wP7OkNq6BkuvlDh
	 aiQwcCgzPCFDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
Date: Wed, 16 Sep 2026 23:54:30 -0400
Message-ID: <20260917035430.4114445-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035430.4114445-1-sashal@kernel.org>
References: <2026091603-retail-undrilled-d003@gregkh>
 <20260917035430.4114445-1-sashal@kernel.org>
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
index 9354f35f390fd..7fda92e8f13bb 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1724,6 +1724,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1733,7 +1735,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
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

