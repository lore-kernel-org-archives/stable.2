Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BC3AD525
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103313; cv=none; b=TOlWGLCeji+3vCAnBaZJal+KPcCAk9djyMWaJ2a83MNb8x8dJgQUzBAxMSI4smJfCiw1NPdTuJfdnvEVUAj7KLoCberTxob9dTKB+2nxXuBKVSavcy0D8aHg205/EE4rJQxdmk+6BefZQl8g49Lq0+Jx1olF3iVfgJMkbdSXi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103313; c=relaxed/simple;
	bh=yQgiObThLBNLrq0f325zeHXIHm+v8LNfkDAiuFHAwok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZZEZsc1OArE0fXFrKYCoSb8+GbMPo9pmYz3VEFg1wvnGY/vi6f3LAOg8gwdE//1+aH/v1MK/9nu0oVPfncbq+BSGHI+HUeWV/lxvg4TCxAp84BnG0j5+nKSJVeJtdTUdovv7Ce9Qo1ZaxPvimzZrChr7ALiye2cGcQN2zgpjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE9zjX+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE9zjX+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6739B1F00ACA;
	Fri,  7 Aug 2026 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103300;
	bh=0m8MOGySINZm1jqvRc0zochQ7+jdLwwUceZv7KrdnpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eE9zjX+uay96inxQLmMy0E0ZlnbCda+CqyId3bIaP0cOiaLWuA94lvcfr3ie712Qh
	 0D9odPAFYCgFNhhU1zPJbU2cllI8KkSAGMdOPpcOn14GDV3c2qitWgOKTQe8nnuisQ
	 E0/5XHWPAOoRBqgcXZ1jJganp1Czv31Jdr0/6YRYBFRKTPiqt9vp/7rv/zqWRcz1UB
	 i+zt3yShzFQECg5nsJLuBOEpo9ucPljOLVhQXhb5bd9tw8srho+hVnlyHqmSCK3qKG
	 xORXFz/enqhFbbR//VFPzPh6gpHwD4zovtZfsEQLIV+pCHJ5lzkMiEacd7mo8pRLu7
	 tp2wUaWmZT8Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mptcp: fix subflow accounting on close
Date: Fri,  7 Aug 2026 07:48:16 -0400
Message-ID: <20260807114817.2056504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072945-unsalted-ozone-c2bf@gregkh>
References: <2026072945-unsalted-ozone-c2bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 95d686517884a403412b000361cee2b08b2ed1e6 ]

If the PM closes a fully established MPJ subflow or the subflow
creation errors out in it's early stage the subflows counter is
not bumped accordingly.

This change adds the missing accounting, additionally taking care
of updating accordingly the 'accept_subflow' flag.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f3ca0ee2cc30 ("mptcp: decrement subflows counter on failed passive join")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 12 +++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 313c8898b3b2c..ac064c44079d7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -498,6 +498,20 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < msk->pm.subflows_max)
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9a8d0d877bd13..b13cd310882d3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1122,18 +1122,18 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1187,6 +1187,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 
 failed:
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be caught by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
-- 
2.53.0

