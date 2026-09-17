Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE851A743
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650936; cv=none; b=K1MXDymUG1AZg40HznzpMkqV2Iu3xfFFJ9Il3hH+rvoNxXy2TV69ygGymv/kw+3H4FGXtKSotwngfbkYHFGOx19u9glxah/+7qeWbdpSnxsJeR1Ym+3Cj5JD+W+Rj19J6Ti+5MLEuZ8WIxFH7DLCYlt4wPeDTVnXHJsFPOuftzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650936; c=relaxed/simple;
	bh=OVVTYe11EBbMxx+hwNLM3VIcIZm/tSej9XFVK3AyHSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QphyQRSKNvZu22oyulCZMI0m2bCxF4cMgCUIT/rpqAgJkcUQOG9+c5epbW2dQb2lfWmICtwmfCGMTwlMbMzQ9pZ+SlbR12BsXb5aFkVL4pb20QMex55yZ+VzFE/CK/lQ9DhUxustKjovnh+6kYK0ncoFk2+wvfhCkHTjy3iPpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa+4XoA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa+4XoA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578251F00898;
	Thu, 17 Sep 2026 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650926;
	bh=4NWOfOxY5aYYVVwjV6d+hhdyHrbTxz1xPIrx40RLZa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fa+4XoA92XCQlB3R21jVVrWH4WmL6ggm1uArr/7JedKeT+iBSRQtvbHujZllGWuVd
	 w9T2H83X/NK786k24K917BgH7FXa/Dz9TZHtmzqNeNpRlBKWJHt4bSalkueOuzxnLb
	 vVtmh7G7CiQJidh70cv2PcAPmY9801pS2O6JTcMPuRl2ikQWhnDz1f3IniLFp//CIy
	 1IJLuncRHUV9ZdI/DsPIWm/praev3G0jOyQzXt4/lkeSQ889OQKhCubnbFY3cEadKO
	 HM4wBvc1aOg0S9gmoZpHBPBSI9YWSypsIia3IrKAeT5u/5bfiaXvwtUfuCpukLxLUm
	 jilODbqR/7SuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	Tao Cui <cuitao@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
Date: Thu, 17 Sep 2026 09:15:23 -0400
Message-ID: <20260917131523.352351-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917131523.352351-1-sashal@kernel.org>
References: <2026091604-bogus-decent-1706@gregkh>
 <20260917131523.352351-1-sashal@kernel.org>
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
index c91ba820e830a..6bd1686774b77 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1548,6 +1548,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list))
 			goto next;
@@ -1557,7 +1559,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
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
 		mptcp_pm_nl_rm_subflow_received(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
-- 
2.53.0

