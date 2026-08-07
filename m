Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE144237A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103305; cv=none; b=rZZ7xeIqj0qwoyXZhbsNdfvUglclYZxc7/aY3gFKZ7qzMqfGce5CzLVzgXQUkVSXMIqmOBWZQk+/EvjcFfov/O6/maw98WmPset8kgbireo7+AQwJ3znnfKCiprlgzLXOeUYgXaxaPRo9k2YHKkCDYr9dFFDJ0AdtcilXdpp/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103305; c=relaxed/simple;
	bh=QhTnFUTsRl5KcYfj3cMV3bcjnPVFq2/BPHtrdLjyRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZgBYJFcxJjh4prA4FXRqctGPFVoetPvmsYbd575W39wxCqQuW/IzGu5M7Wb0jBlkYkVbi1CizN0CqOOtq7KTN6OHEGYO9i8jDPF/2DUXv7ZSf00qg4pM5TQZX+1r3L7tNQbWemWkcgi0g2sdR+mIW2hsL380HJu7lvZuDG56+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxPd5QHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxPd5QHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F541F00A3F;
	Fri,  7 Aug 2026 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103297;
	bh=Da0xI+kt1F3YqUFh/iLaKC0/OfnPQoDHCHTkcoxNaec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxPd5QHjrKZvII3wlcpfB/DNfKDQIflle/6b0ZhKEPDGSyQ/pkQNZLU1SfcCyOfOE
	 AR6YVCV+LrsXBtfWp44Ws3tpaebsX+Ioo8vTDex6AaX5G7prDs7BWcdFtaD4J/ciXk
	 OrVPzixcgBK1jJVTUPxhQSVF9VfznpZu+Yu57CLbq4TjZaUPSVHHeeD/MF1bTQtDcU
	 r0ABhRZgqbC8I9b/v0jtlv6vwAq84TAE+lovGcsG5z19uqi4LU6TGlaVofwbHOlPQg
	 GZJ/9P4d1NMpTC/MEZQrSJKq6Pd+CJMGeYM2oz/+n/TPuCNUR0OotnHDT/UdDfCcRE
	 TA9vd538g9TlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] mptcp: pm: use addr entry for get_local_id
Date: Fri,  7 Aug 2026 07:48:12 -0400
Message-ID: <20260807114813.2056374-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807114813.2056374-1-sashal@kernel.org>
References: <2026072920-budding-prescribe-9ea0@gregkh>
 <20260807114813.2056374-1-sashal@kernel.org>
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
index a92b1d0fee191..0d21f4e693908 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -428,7 +428,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
 
 	if (WARN_ON_ONCE(!msk))
@@ -438,10 +438,13 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
index 2de42055b78f9..242011de052a8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1277,7 +1277,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+			     struct mptcp_pm_addr_entry *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
@@ -1286,7 +1287,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	entry = __lookup_addr(pernet, skc);
+	entry = __lookup_addr(pernet, &skc->addr);
 	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
@@ -1297,12 +1298,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
index 3a9a57fd9424d..31d45b1db3903 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -148,27 +148,22 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
index 48e1a3f853d3a..251a1ad71ebbf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1048,8 +1048,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
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

