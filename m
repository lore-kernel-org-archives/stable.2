Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324846AF2A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103303; cv=none; b=fSFYwUjUPA1LfVMUNDgeZnvSq4nZDQnqehqBdSVq4YHcXqBp32dlHe7ARuV7aT2riKI5M1hN4cEXvEX4CHm/u/1H6xRmQ+orTiE+02y7lsaM5yNfUYr4cRmoE+9+CUbGFkjF7jLzcqUjjZPu8KN3wDRV+L5eBDRT4F7m00ZNnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103303; c=relaxed/simple;
	bh=cS8QlEGWiSh0RNllWjqmYzD53RIhSVTRjuFEA88DPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgN6fYOFCVwLLKWbjY3iCKBE8vru0/J2Uf55DBRuTiL10W+RPkpumz4rRrVZWxD6e6WSG/SljECUENBQbmPUMUKcEojz8CzBVbJqTH+JUR4VJQBiO5QUSAmtPmm3iGMOq4TFRMrI76BzwsB7mRflJo8lkedN2spvI6UiLCeWCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ9u6mfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ9u6mfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567221F00A3E;
	Fri,  7 Aug 2026 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103295;
	bh=lW1wj5gnOCcmmX0IRpEe/AvHanQQT2gDlE+9HzGvyZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQ9u6mfkUrxxNPZSClUfjOCxRT9UYHJO2qPONAr+LsYHjQJCewkOohexXE3rw782V
	 WHi9EYbeT15wt9uUmg+bof8G4e6GVsxfqRTJVuWF5YT76i+8yFewI+0UP2qk0tq0GP
	 Hj5LEn24lyqxYKEOijeK4OGotIIp+ZzO9EpUB5BBcsksDhQMHgXQ9MN+l3le6ZyoG6
	 AyPGu18zGsOhum+rhPV7f3K2KFvvTp7hl5N8oEAuQUU6FYgrBUUFmWtbTra9OQyatt
	 Wd75nJqI5sUVWewIitaoZRilczb148NWEP/lnePuI1E+oHHkgLTfWCAMK1tKqXnO1u
	 qjnI9ov/m5q2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] mptcp: pm: avoid code duplication to lookup endp
Date: Fri,  7 Aug 2026 07:48:10 -0400
Message-ID: <20260807114813.2056374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072920-budding-prescribe-9ea0@gregkh>
References: <2026072920-budding-prescribe-9ea0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 1d7fa6ceb91fddbe38cae3521d5d1075bce6a00e ]

The helper __lookup_addr() can be used in mptcp_pm_nl_get_local_id()
and mptcp_pm_nl_is_backup() to simplify the code, and avoid code
duplication.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241115-net-next-mptcp-pm-lockless-dump-v1-2-f4a1bcb4ca2c@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9bc6d5e4ca9f ("mptcp: pm: userspace: fix use-after-free in get_local_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 74ec7ecf4e8ff..2de42055b78f9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1281,17 +1281,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	ret = entry ? entry->addr.id : -1;
 	rcu_read_unlock();
 	if (ret >= 0)
 		return ret;
@@ -1318,15 +1314,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup = false;
+	bool backup;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-			break;
-		}
-	}
+	entry = __lookup_addr(pernet, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	rcu_read_unlock();
 
 	return backup;
-- 
2.53.0

