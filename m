Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED26272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070171; cv=none; b=qkO9XSGBbHa4CeGaNKGAsewiE9z89FyWU+9GGiVAd6D3rjHXj65CGzsXJjr4udHUR0qC6i7xSJTpoHTYWd9supXg/jzVGamNhzJrVBqexQA9uIWHza7hLlbDYX2Q1NBGwc7Fp8KQGn3/AGM4GCjghUwjz6OtXiJUZtuvkT2y3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070171; c=relaxed/simple;
	bh=3Q79sSjBuc/F0M/QXaRs65Fx0ImEuXyq/iiIG9th400=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqDTPQXqXFq9CLC5RIO15W25gdPEg3nntB3WfyzjVNZmO1I/vx5P7RxLDluOJQ4aDiTaml5o8/nSpl/bqOQARnuP3GbrkIde/alF2wYllGKJ4r1QUWuXSV/fY2BMKJdJJZSK/KXF9jh5FMuHU9w5/dUHZrM6iZ3ylAJG1JZ6neU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnLE7L1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnLE7L1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9B71F00A3D;
	Fri,  7 Aug 2026 02:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070170;
	bh=n7f9LNiJh0hzT2p6x+IoG7wE9yPZVN+JsahewuseMkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnLE7L1ja5+pJoZYuLKwz3G0Wd6j24vMNMAp5dIf01VuodmsoIwVZhFcGQciS1+J8
	 5I1DwO+3byKOQbvwqxJlKK+2Lbv5akfDsn3/x94ZE2IZrnMCn4qUHJnC3KJRk9fNRQ
	 lbGNBLQR4XPGyoNJICI4MGi8/Nm0LpbNw/kfiCJ2g/4uIdY8xIj4BOiE9UZGc4mECv
	 lqrux0dha61HiRwwOQK/1mUvesf5g5FjwAFySbNKGH/IBz5wbcxuxVdcRWSBjOsDQH
	 S/YPhUBWNC95KQsUEgrM7FEF/4mNJsh7jOPSD2O+/+CCeGCwZ00PuwWJbhsss8Bf2P
	 7MBRQVgL/Y5uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mptcp: pm: use addr entry for get_local_id
Date: Thu,  6 Aug 2026 22:36:05 -0400
Message-ID: <20260807023606.1683287-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023606.1683287-1-sashal@kernel.org>
References: <2026072919-slouchy-backpack-abaf@gregkh>
 <20260807023606.1683287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 7462fe22cc74321eb663768848976d42eba3ddbb ]

The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
to "new_entry" is not allowed in BPF if we use the same code to implement
the get_local_id() interface of a BFP path manager:

	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
	new_entry.addr = *skc;
	new_entry.addr.id = 0;
	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;

To solve the issue, this patch moves this assignment to "new_entry" forward
to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().

No behavioural changes intended.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250307-net-next-mptcp-pm-reorg-v1-1-abef20ada03b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9bc6d5e4ca9f ("mptcp: pm: userspace: fix use-after-free in get_local_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c           |  9 ++++++---
 net/mptcp/pm_netlink.c   | 11 ++++-------
 net/mptcp/pm_userspace.c | 17 ++++++-----------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3a27afcb4ec85..009020ee1e041 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -427,7 +427,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
 
 	if (WARN_ON_ONCE(!msk))
@@ -437,10 +437,13 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 * addr
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
-	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
+	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
 		return 0;
 
+	skc_local.addr.id = 0;
+	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 044a80a66f139..550c4c1b963d8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1274,7 +1274,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1283,7 +1284,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &skc->addr);
 	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
@@ -1294,12 +1295,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = *skc;
-	entry->addr.id = 0;
+	*entry = *skc;
 	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3106583dfa57..00c028b5343e2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -132,27 +132,22 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+				    struct mptcp_pm_addr_entry *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
 
-	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
-	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
-	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-
-	if (new_entry.addr.port == msk_sport)
-		new_entry.addr.port = 0;
+	if (skc->addr.port == msk_sport)
+		skc->addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad30b4b481434..04f33abd410db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1136,8 +1136,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.53.0

