Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B432939C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617491; cv=none; b=cYMNi1EejeKlZupDKctbf+8d7Mp9C5kz2S3fY66ursvDG6mZkfjsTmA2fqtBIajGZG0lCPA9q/gfY7B79g5/i/h5FYyKrKCy5mIvXVDE8Bu1nHmHoMU7JmA4bEaaPsCuOdbXShW8GrbZFoDJjlroSjSnsSbhmEv3RkVClgwLbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617491; c=relaxed/simple;
	bh=T9rQcunM0mKgpnt4Z+D02lgjyUg2fcMuGdcSd3NoxcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT2mGbkHmmZKP7/kcLAYyai+IHM8n27m4RxAdw4U5eF4+HN9e4v2+8NJxzaS6QEuQc+wCxGXCKmFo9Zz8pD5a9W8WXV0/PXctTPSQ6nDCZYVix69+9pWPOaw7aAjW+94gYSFs9bIqcSi1hXLriJWMk1qj74EEzE8wgLUtXd5/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmCTDXzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmCTDXzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BE81F000E9;
	Tue, 16 Jun 2026 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617489;
	bh=Hx24TqTipQcPYFgAu4lgAsOWOpQsGAG6tPaXPaCIldE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmCTDXzhzJZ4BRmn5Id0tiDZJs/MtnZinJGYsh424yn8xmQgpncLU9D7WXV/xsCD8
	 1p0JcdOUBADLmlugIQDiSYvA34SLwtgtWyXVPMpnBF3cY1pkHNFqbw6aPFaKkjn0Ve
	 y2dcLFihaZroxs2oKl7Ea4k89wfi3Rzlw1kkLWFvBV9Ff/An0UYqp9waA9uhK0sFYe
	 iNi7tu6ykFPnUeVGCQ+MmbrYCPy2dw+T+rAaCV9OYNrYVBRe8wtkwd8DWBK8TOf69+
	 XGw8Frlx7pfGR8apPUOj0brwcAO0bJnbHbPjvXeE+OjTZw4cZIA3ck4/99kK5JZYBL
	 rQQpoFEuFAk3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
Date: Tue, 16 Jun 2026 09:44:46 -0400
Message-ID: <20260616134447.3269618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061517-grandpa-bondless-cbaa@gregkh>
References: <2026061517-grandpa-bondless-cbaa@gregkh>
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
Stable-dep-of: bd34fa025726 ("mptcp: add-addr: always drop other suboptions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/mib.c        |  2 ++
 net/mptcp/mib.h        |  6 ++++++
 net/mptcp/pm.c         | 40 +++++++++++++++++++++++++++++++++-------
 net/mptcp/pm_netlink.c | 16 +++++++++++++---
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3e773259fa8335..e4fda3ef98438e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -38,7 +38,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
+	SNMP_MIB_ITEM("AddAddrTxDrop", MPTCP_MIB_ADDADDRTXDROP),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("EchoAddTxDrop", MPTCP_MIB_ECHOADDTXDROP),
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
 	SNMP_MIB_ITEM("AddAddrDrop", MPTCP_MIB_ADDADDRDROP),
 	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 0690db18fc95d2..c6b6f470b04cf6 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -31,7 +31,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=0 */
+	MPTCP_MIB_ADDADDRTXDROP,	/* ADD_ADDR with echo-flag=0 not send due to
+					 * resource exhaustion
+					 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=1 */
+	MPTCP_MIB_ECHOADDTXDROP,	/* ADD_ADDR with echo-flag=1 not send due
+					 * to resource exhaustion
+					 */
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with a port-number */
 	MPTCP_MIB_ADDADDRDROP,		/* Dropped incoming ADD_ADDR */
 	MPTCP_MIB_JOINPORTSYNRX,	/* Received a SYN MP_JOIN with a different port-number */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d52e1d2950100e..00fc7da99cbe49 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -270,6 +270,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
+	bool skip_add_addr = false;
 	int ret = false;
 	u8 add_addr;
 	u8 family;
@@ -291,24 +292,49 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
index e99247f906a3cb..336c04e81fbda8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
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
@@ -384,8 +390,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

