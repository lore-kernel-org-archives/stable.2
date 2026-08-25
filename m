Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5603F9A16
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657076; cv=none; b=DLETxvmfwC0GfXxg/yiUnz3d4jCQmn7r1wGqZgvyp/Ys/HGNEjeDlTvfyRfcnM9UqoTvJ8nDINyRHm6vcyc3yZpKlDLNq5+3+DiDXhbdMGDuG1VCq3YJgoLrDnrgYoQHWM8kY964pkc+zr6OE1oFAok+NwrNij+Opm7+muiN+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657076; c=relaxed/simple;
	bh=F5SEOItspsva3KHcvZ/nW+ZpxCq5nNqiLau68/050qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFEqnsepjXbkTpSXoAYm5qjWjQIcHgexvJSWl0xDUqHgP0uBXHdX/Dy4qvE+hxxYge+0Y6RiTRJXaR0LB+G+/pTX3hDWPy6oHvRSG5T3KPENBGblNQwKC0ObSVak+FCX0lesbWnrFcMGFG66LRR92Rr/fDiF1NUpYCRGjhGYOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyFVOHoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyFVOHoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFFA1F00A3F;
	Tue, 25 Aug 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657075;
	bh=GCpJWgjgtKAmHtj8P6b+1/fEH1DLCaw6ZpQWc/dc6MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyFVOHoI+QaePvDNtT4mYv5CPwIf0ct+wz0DVKuS6fsfrTMgWy1m1ni/9wnK2CdsI
	 WSIENI1n8FMPIrlxmYVM2JnWbQdiHAEUAlOtJ8CcGtv+bzMR6/pXYo4fcjgQzD2+8n
	 A9a4C/pafS6ltTRAsVyI6kBD/qiLsvhgB6pj+04+A8RgWJg3DkbDYWVtnZmZ5/21Wq
	 1+FNTOkKErpSR97O6s0+QJB2MFjyaxKnDV1v5utKjKeLwDcRpYIwMlm5X6jnJ6W3NO
	 GvO4hOcJlDO+wkrUWWXMNfyRmutiQ5QLIJy67OGADBdo40HXTp80XAVacmb6N51xyx
	 VP35EMttDuT/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] mptcp: pm: ADD_ADDR rtx: free sk if last
Date: Tue, 25 Aug 2026 07:24:30 -0400
Message-ID: <20260825112431.3541047-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825112431.3541047-1-sashal@kernel.org>
References: <2026082026-treble-stylized-d851@gregkh>
 <20260825112431.3541047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit b7b9a461569734d33d3259d58d2507adfac107ed ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done at the end of the timer handler when it has not been
rescheduled, not to call sk_stop_timer_sync() on "itself".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-5-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a7aad5b69d3b ("mptcp: pm: fix data race in add_addr timer callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 171d1542f2a4f..70170fbbc38d5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -36,6 +36,7 @@ struct mptcp_pm_add_entry {
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	u8			retrans_times;
+	bool			timer_done;
 	struct rcu_head		rcu;
 };
 
@@ -316,22 +317,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
-	unsigned int timeout;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
+	bh_lock_sock(sk);
 	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
-		goto exit;
+		goto out;
 
-	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + HZ);
+		timeout = HZ;
 		goto out;
 	}
 
@@ -354,9 +355,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+	if (entry->retrans_times >= ADD_ADDR_RETRANS_MAX)
+		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -364,9 +364,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-exit:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -427,6 +431,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	add_entry->timer_done = false;
 	timeout = mptcp_get_add_addr_timeout(net);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
@@ -447,7 +452,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.53.0

