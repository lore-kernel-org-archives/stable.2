Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125C433041
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103302; cv=none; b=cilfDNsD7mUGgy6B9Cc2Td3sAOwa2E8FohsTd/9+UJ3sD1+Kx5F3+Zuk83byiYGxH2evxDyn+c0MA9rBmr05j+kX/3fLtwppzQFAo000dnucFDJ/+erK1/bJkNqa0BaoewRQBnxrVN4wZblmSAk10xEe4SlMVgGwV5gh4zvWVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103302; c=relaxed/simple;
	bh=NgnTNHlcLKxnqPQgj1Il69Qn+Tqhm6uhKTtk7lgllrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR+J4A9Cb/wg/W7M8zm6BUJkRd/gqeNm3BTRpa0ot1DJjv0qdTVMeBXMgt8Wbc+538DFaeIA/keO1E8t0y3mmYpkFLLAQHu6M+W55qaJXQoB40X2kYxH3A45DgttS+8gUR2Wj6XRJQZLHzC9IGRavlIbUnqJKqdjkZYLB2Rl//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxfYrFkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxfYrFkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1E01F00AC4;
	Fri,  7 Aug 2026 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103296;
	bh=eRrP2RHj8JH0Xxygarhvi5nMnmk4/4ifhc4zcN2CAFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NxfYrFkVnWIFBw8AlUFy/1wCKDFUoBzUd3jRvagaqq8OX5FMt1Wcd8yfRBb2Edjzv
	 v6Crn5JEoIl530Bet8G8gxbgnln9XqBPVMFTWu/yUyteQKT9yQCnZ1BlVh/USP+CrF
	 mPvxItBIiIIC5dnAAjXwZFtUZqMuPhNmcTbGqIYCm7LVvOdOCAslmap3eLsZhiFczI
	 5sYe8DN04TIm7bZw9zzNP9V8gUumulcbgFu+efDEevRug+Fwb9YHGweUykWeERWR2U
	 pEbwiJGdgNtVDgvEliP6f4YHUJDhUsl2j/jCHMMWg+cg4RS8Dm1epgiklPHG/DQ2nh
	 Vfd1cHA3Btdzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] mptcp: add mptcp_userspace_pm_lookup_addr helper
Date: Fri,  7 Aug 2026 07:48:11 -0400
Message-ID: <20260807114813.2056374-2-sashal@kernel.org>
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
index 663aeefbd1b23..3a9a57fd9424d 100644
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
@@ -89,22 +102,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
@@ -139,17 +150,12 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -169,15 +175,11 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
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
@@ -591,13 +593,12 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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

