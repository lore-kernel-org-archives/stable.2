Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0393241CB7;
	Tue,  8 Sep 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876876; cv=none; b=NdeQzzVcHh6MOwzW+INy1WOBvYSBb2vQQl4ZQklfUIzAhTG5YVcLgIV6K2v/IrxPJd+t9zSDEQKcVfP50HikwGhWfmemeLI0WiOy8mwqQdxhH0+ncvbqlncM1arCyHajL3Fnjcne2zcZwGJXqF0Mn68ZlhaswGLQ5w5SCHM0W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876876; c=relaxed/simple;
	bh=xGnuahGwPP4f82k0zQU436ZpG60wJ/aEuwZt7vnyH40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZMowbOyvbaJMgyEcJdSY8yHyvDzvm1srTkVqdecBgBvmfbMGSF/C06yaS+fPvjyrF1TRhMBk8gNz3KzY4oFGTpE2bXqoLTfs4nrPbFrJ9akpQxhocmTXx4yyjXnsIsoLgbYIHCQvSDu2CZnK5uVk/8usQCkUolRcTMEFe5WTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLmpwWLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLmpwWLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B81F00AC4;
	Tue,  8 Sep 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876865;
	bh=NqkLnNdB1iaPRZgzHgODWa8SlkXcWwYoiM8hBJRiEzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HLmpwWLmY3lKHL14XJaUCgEBnNq58yiKP83mpEFIqmWz6bCK4TKq2nH5sxqNhFb1Y
	 RXF2lxMhMJZbEUGSzljRwYf6PZO9I17NCO+02uJyQuPszaZYUggDcldE1eUYrP5LEE
	 cicSGXc7aKq/tiCZ3pY4KDt5Ub320fxgTxwfWYgcAS5aJynB7ws8a+W2nIfpCr/GSb
	 e0CIObRQCMoT/HwyZ2XQz+ysKab2/w3h7Oz697/vfOZZUBlie1NqyH9GP4XPg3iile
	 JcQqlibgQY2wMMoKKEEpkOCotM5vhFRaAZVRr93nvpDTHuripXqTM3EH3LRINpI3jE
	 2T1qzMKkPaxWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:09 +0200
Subject: [PATCH net v2 04/15] mptcp: pm: kernel: drop pending ADD_ADDR when
 removing ID0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BiUuBgq0c7aOBr6JJpkC2oZ8vE+NuO1ltFCd3RnPXgo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSGg+jpR9sNbqe1nXhsAXa379uDutLnXbovXn7/zav
 0b1X/4OpY5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJ/Ndn+Gd0e9v1v9Fh1xOO
 Vd13myd/YX9eZ2Xaaw/d9VUr1B41cisxMmzLNt0W/fz95528L7r9VhlP353YGSEjt/bf0ZqvZXr
 +/7gB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

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
---
v2: use new helpers name, note about "port = 0".
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
2.55.0

