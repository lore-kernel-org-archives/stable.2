Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED04756AB
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107966; cv=none; b=LSCEqA9SoYgkEgEy5puqRFr86LYP6z2ne21cyrlKZ8JsFurh05VBvKmeE0UPD8DVYfUujPftBGpBVI+tqqbYPRxZZHvdpS5Aq3fueyLgtgzqn1GadL4wncfcv00W5CUVZZHjkhMWO4lKDeEq/ZKMk9M3FJwB8fkpVu0FtlMI4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107966; c=relaxed/simple;
	bh=8RZUP6FjjVAKwiE/zcJHUPON/A+nrz9nYECKHTSpxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeUvmDkG51EowKOQltmG0+AENLyBoi/Pulj5JUl5mY+Pl+VOT6wj2Xxj0oPy8gbtpyv1Bh94jkEbNFi08OT9XcdhZEHwJv0H4T8aQ2AmcGetWwfkFNobOG9Bd/JWyUAScf7FngfqZ2bSli0yV8hVE1ngKhQ++SuGibAc8eFjRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYYGZDd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYYGZDd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3E81F00A3D;
	Fri,  7 Aug 2026 13:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107953;
	bh=TN7hbpjq5ZHrG+6qy7w6ujVa5Iv/cjkRupezdvPKFd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYYGZDd2fRXMVKDSi5oorftfgudU6b0e4Oi+XCAht+nFQfaZROLTd1tDaocn2OB5F
	 se4OqtxJ5glGiPg75znqtjMM3zBG8oxERe4iYjeNKftp1Hu7Dyu8PtG95x9TWQHQb8
	 7vrBvW+vCiFu2FY9M01mUpvJfeE2IwFdkdjAnXX7XvHsZYW3ke85NMJQ1RI7LgTgvV
	 trXUm33nC3E1le2DqgpaW7KOCM/cFqiCrktD5yPdS7fUu2pentDI8mJAX7p5cSIMif
	 DOu6ouASuX6cc+2h75KbacYRxPBzOQY1rf4F7JF4ZwwuS/A0Ky7RD12rWcla1ys0Lq
	 yGz2MibnkDV5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] mptcp: add mptcp_userspace_pm_lookup_addr helper
Date: Fri,  7 Aug 2026 09:05:47 -0400
Message-ID: <20260807130550.2153435-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807130550.2153435-1-sashal@kernel.org>
References: <2026072920-retread-pastrami-b8d9@gregkh>
 <20260807130550.2153435-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit e7b4083b90b7213902124d13fd1ed808360e32b1 ]

Like __lookup_addr() helper in pm_netlink.c, a new helper
mptcp_userspace_pm_lookup_addr() is also defined in pm_userspace.c.
It looks up the corresponding mptcp_pm_addr_entry address in
userspace_pm_local_addr_list through the passed "addr" parameter
and returns the found address entry.

This helper can be used in mptcp_userspace_pm_delete_local_addr(),
mptcp_userspace_pm_set_flags(), mptcp_userspace_pm_get_local_id()
and mptcp_userspace_pm_is_backup() to simplify the code.

Please note that with this change now list_for_each_entry() is used in
mptcp_userspace_pm_append_new_local_addr(), not list_for_each_entry_safe(),
but that's OK to do so because mptcp_userspace_pm_lookup_addr() only
returns an entry from the list, the list hasn't been modified here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241213-net-next-mptcp-pm-misc-cleanup-v1-1-ddb6d00109a8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9bc6d5e4ca9f ("mptcp: pm: userspace: fix use-after-free in get_local_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 69 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5260a34a617eb..03c1b17badf7b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,19 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
@@ -88,22 +101,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			sock_kfree_s(sk, entry, sizeof(*entry));
-			msk->pm.local_addr_used--;
-			return 0;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
 
-	return -EINVAL;
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 static struct mptcp_pm_addr_entry *
@@ -141,17 +152,12 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
-			entry = e;
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
@@ -171,15 +177,11 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 				  struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	spin_unlock_bh(&msk->pm.lock);
 
 	return backup;
@@ -593,13 +595,12 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 		goto set_flags_err;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &loc->addr, false)) {
-			if (bkup)
-				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-		}
+	entry = mptcp_userspace_pm_lookup_addr(msk, &loc->addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
 	}
 	spin_unlock_bh(&msk->pm.lock);
 
-- 
2.53.0

