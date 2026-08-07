Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B927A916
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070170; cv=none; b=fDejLhm8Lk4jH6oZ0XDspMqNlcGauDwrTFwXUusarVFdyz7sVh77f+dt1luhUyRf5TaUmNpJpHAULJhlHeWUhp3lorpFsfkI0nWJyeGmaE36s/HRfHGreH+apWwkVwTmd1YOXtm1B+Z3nA4dWxitVdv5EtuGitDJdoCSX5nlR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070170; c=relaxed/simple;
	bh=xI29HoZKGKoeQb2I6iIDJmaTWL+cRHpF0+vnyv2fqlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP9e7Uz3nH4wJddy6L5d7B+C3wCOaOPaGh94rZDpLMP0/NQ9mJBR80oTk+2cdbwBqEz/FazxId6hrQFEQNArr9H95WokiP8P6qgwnBRfFwIBbW8m5nRq4zC8FJdXaoEkfiG5MqzlavSOK1d/zUfPUCwmkLzOBA3qjja6p+HSaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezymiBZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezymiBZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF621F00A3A;
	Fri,  7 Aug 2026 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070169;
	bh=kNlUZAWdF6fJBKK52qyJMDYTitze2j1/ivKg37XCX1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezymiBZOvhnZhZ5iZHGNiXtTHzXTAEIQM0bn42tcMsYGYvupwo4dX577zIwso+BtY
	 bvKgNy5O/THMz31SEefL6oPBMlsmU80x4TLB9mFmNovvlLSIku5aL+wky6Hrav8jwt
	 nBZp4Bc8ivgymF+JZULW9giqZgEy2EnZbO9ULZFm9/XYVJAajYQlF6fbE/Ni/UuR+l
	 9hhk108Q+dBaFhc+r+wwA/0Z9UBzccX2baoGeu0J3g7I0M2unSVErpbRoEQQgdjQQV
	 cpImw9lD63fu8b3scxy4sV/sdEJixawPWVvMpq0lxQT1yAFPUVJzGF3HduKn1VY64U
	 AAVVkElfSVfbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mptcp: add mptcp_userspace_pm_lookup_addr helper
Date: Thu,  6 Aug 2026 22:36:04 -0400
Message-ID: <20260807023606.1683287-2-sashal@kernel.org>
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
 net/mptcp/pm_userspace.c | 71 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bc3eb242f2980..a3106583dfa57 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,6 +26,19 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
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
@@ -90,22 +103,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
-
-	return -EINVAL;
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
+
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 static struct mptcp_pm_addr_entry *
@@ -123,17 +134,12 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
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
@@ -153,15 +159,11 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
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
@@ -607,13 +609,12 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
-			if (bkup)
-				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-		}
+	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
 	}
 	spin_unlock_bh(&msk->pm.lock);
 
-- 
2.53.0

