Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D045A28E;
	Mon, 24 Aug 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590143; cv=none; b=F7f+LOvSq8FNSzY5kqxSLCFQ4C70JyXNG8ZrbQ13D+csN1Js2G/ERont4jpgD7cgvpw0h7Ayv9xBnjGdQWOBQ8cmpmjbMdOUih7htgTwfuaMHzb7QjfuJ5pZeQ3phe1SZ259XbexLw5ioY86hID05/WXhyH+hPWkKJg4PFz3gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590143; c=relaxed/simple;
	bh=lVJenzjXjdfsZSScnVX8pRJkzdkpjcMIvI0kuS8t/hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJm+0R/r3jc11ng61Nmg2efb1Pte98zU1OsLT9+16AFjxP/byJv6cKbOLIafHYvwdePIwN3+WgQMXRJXrFNAcyp1m9njwDt4i9rx90wgYiWRUgDthlhW7gyRvC6O6e1Fjpg3c9u+EprwszV1JRECFEadiBQ3CA3Hgc3th+H52T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9gfpBt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9gfpBt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D51F00A3A;
	Mon, 24 Aug 2026 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590133;
	bh=MVBCOcAhhkTgizAJL291DY8sdaXrCYJIDJVdWAVd6zQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C9gfpBt3bmxNlhDiJWi5U0NSzFLhYJr4DqwjqhKwVOzpbeLgmL8ePaAhbg/NPsv3k
	 I08VKooImJo/Q6Bk45o4XiMQgdkPGBDFzKbaVbETo2OiG7zolZiAffNJ/ZSKYsjLK1
	 ybPlLZOjxA7GNOiG8CVSiRKELtwhCMwXrqaG3H9ujrA+8dxfqkMYr9RHo7QC6NGkRr
	 U1AZZqtt2A8NH8AyVNupQoxy/LmezG6UyzdC8e8MkR83xOI83aGxUZeYGmB3AiL1uZ
	 vi4pyk1R3+43XUj07BINCblXTxN0Dx8dT2xbiDV34m0RyhKcB/4+tZsvt2r35nOtyu
	 7Tsccu3MevSzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:24 +0200
Subject: [PATCH net 04/14] mptcp: pm: kernel: drop pending ADD_ADDR when
 removing ID0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-4-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, stable@vger.kernel.org, 
 syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com, 
 Tao Cui <cuitao@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EYl0Mkm8u/WrEKNWPSNYFWjt9rLGKIDrZDnJvIhuJXo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Su+v+nlm29X3Pj3Lt+QIfF/8wKK89YrwrYWxyRWrs
 z0vziq601HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRmSsYGXo80wzPflh/hfvE
 1tTMqz2Cr0Ot9v+Y6N6YUsBa3PXvyBNGhgU973PjVSM7llSs3rBsWc2j9CdcrnduMSwPqj9ufah
 Iiw0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint. This happens because the id 0
removal path does not tear down pending announcements, unlike the non-zero
id path.

When the PM later reselects id 0 after adding another signal endpoint, it
finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
in mptcp_pm_alloc_anno_list().

Root cause: asymmetry between removal paths.
- Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
  mptcp_pm_remove_anno_addr() to clean up.
- Id 0 path: mptcp_nl_remove_id_zero_address() skips cleanup entirely.

Fix by making the id 0 path symmetric: call mptcp_pm_announced_remove()
and decrement add_addr_signaled before queuing the RM_ADDR.

Subtle detail: signal endpoints are stored in anno_list with port 0, but
msk_local carries the connection's local port. mptcp_pm_announced_remove()
uses use_port=true for comparison, so clear the port before the lookup.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Cc: stable@vger.kernel.org
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 424f1a7f9248..1a7750813235 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1137,6 +1137,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
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

