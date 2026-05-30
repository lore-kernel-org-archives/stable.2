Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473A26ED59
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102226; cv=none; b=jX7zbze4jBQFI1LiUV2Miv8tbuVrp63CEbgHVYLkfT54B5CHns7NxlB04dDqkfIY9TeYnW8PpmtjsfTQfeE+hxVnc29G7bXF4zNmzsB9wov3qmwr6C+h7jddkptqgp07P8uIvoaqvKgYg9A/x0CaNNI6vmutGjL+J4jWf7HsfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102226; c=relaxed/simple;
	bh=cvQG6tRKXi362IvSgCZgAnNPcXC60TTM92oNoMSU44k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EisiJziDfeap5jnBp9EekwQx/Rc6b3wjGy/ZyI3gsza/LMUWUoLzcwVjM6IokaFvrIhZDsnXhpEcJGNrKj1ZeMQm/xReyL35c1zp+hHjltbgT1ydMihf6f/6J7Letb3jHdQRE+7x3DkQYY3Jk7k6P98erU5vr56+LOyF8eS8jPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi7pwrCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi7pwrCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A21F00893;
	Sat, 30 May 2026 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102225;
	bh=DWZWcylqzhuCA5zMjt9tg72UeJCb4Qp2oQFBQWwDb4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wi7pwrCV1/on7ezhB4xvNTyy5N1nFiHBiIOCpZduzPwWdMdKr/uP9p90XFxuLI4Qa
	 8IEPKEnNZIjVWUHEkcPwqKI9L+s2lBOaOVsgbxcG7R4id9k+LxMM8jwX7PSCfd6QdK
	 RynUf/Xy/3b6DJ0sCABJ+OR1E1bB7nuvBsiE5h7fG7EW5MTl4AMlxeNCDyACHtekQC
	 fuXRw1WFDefGORt+3wFgn+u/7tbEnWQ1wqO3cjaqsDH4ydI/Xju1JB6PJqnJM/U30T
	 pr/uP32Brv1Ux14H6U4/8Jw85zXvl6qGwdZifNzpEdQ2E+MgOfwTB3D/XTCtxApGEn
	 qARs+uN8j47xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
Date: Fri, 29 May 2026 20:50:21 -0400
Message-ID: <20260530005022.2387154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052805-lumpiness-evict-5ec1@gregkh>
References: <2026052805-lumpiness-evict-5ec1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

[ Upstream commit 51e398a3b8961b26a8c0a4ba9a777c5339791707 ]

When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
IPv6 address and port while tcp_timestamps is enabled), the original code
jumped to out_unlock without clearing the addr_signal flag. This caused
mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
preventing subsequent addresses in the endpoint list from being announced.

Handle this case by clearing the ADD_ADDR signal and skipping the matching
ADD_ADDR retransmission entry. The skip path cancels the matching timer
(with id check) and advances PM state progression, preserving forward
progress to subsequent PM work.

This cancellation is inherently best-effort. A concurrent add_timer
callback may already be running and may acquire pm.lock before the
cancel path updates entry state. In that case, one final ADD_ADDR
transmit attempt can still be executed.

Once the cancel path sets entry->retrans_times to ADD_ADDR_RETRANS_MAX,
the callback-side retrans_times check suppresses further ADD_ADDR
retransmissions.

Note that when an ADD_ADDR is being prepared, a pure-ACK is queued. On
the output side, it means that it is fine to skip non-pure-ACK packets,
when drop_other_suboptions is set: a pure-ACK will be processed soon
after.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-2-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c         | 40 +++++++++++++++++++++++++++++++++-------
 net/mptcp/pm_netlink.c | 16 +++++++++++++---
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8d2c27c43ee0b..b601dab95a42c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -334,6 +334,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
+	bool skip_add_addr = false;
 	int ret = false;
 	u8 add_addr;
 	u8 family;
@@ -355,24 +356,49 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
-
-	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
-		goto out_unlock;
-
 	if (*echo) {
 		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
+		port = !!msk->pm.remote.port;
+		family = msk->pm.remote.family;
 	} else {
 		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+		port = !!msk->pm.local.port;
+		family = msk->pm.local.family;
 	}
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
+	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+		struct net *net = sock_net((struct sock *)msk);
+
+		if (!*drop_other_suboptions)
+			goto out_unlock;
+
+		if (*echo) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
+		} else {
+			skip_add_addr = true;
+			MPTCP_INC_STATS(net, MPTCP_MIB_ADDADDRTXDROP);
+		}
+		goto drop_signal_mark;
+	}
+
 	ret = true;
 
+drop_signal_mark:
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
+	 * clear the signal bit, cancel the matching retransmission timer, and
+	 * let the PM state machine progress.
+	 */
+	if (skip_add_addr) {
+		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_subflow_established(msk);
+	}
 	return ret;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d892583ab4ef..1609428ac06d9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -325,7 +325,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
+	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	 * callback. Once cancel updates retrans_times to MAX, suppress further
+	 * retransmissions here. If this callback acquires pm.lock first, one
+	 * final transmit attempt is still possible.
+	 */
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
+	    !mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
@@ -369,8 +375,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->add_timer);
+		else
+			sk_stop_timer_sync(sk, &entry->add_timer);
+	}
 
 	rcu_read_unlock();
 	return entry;
-- 
2.53.0

