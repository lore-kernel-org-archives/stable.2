Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E0471252
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107970; cv=none; b=OUgJ8w0/DgehqFAEOEnVzUYkcfxHCwMn2onR98HeTUiRasR48iJ6XX3gK5PeOa9PYHRSYywnCCw0VAjDQfR6V1ULffnwRX6Ulo/pGtD8QrpNan6vENHMArLyV+RoL9f4AMU5kfIyyARory3x2l4lU7dKf4hYtnUF9hsPOHGV7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107970; c=relaxed/simple;
	bh=OCmpnNVDmmPfmkvImu5mdCnn8qdd9+xeIPn+1aj+/YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCwnGAa53FLHJBXOkY134Tjte+THA9esaNuBdz4RqtspM+LMLP7/80jh/dk3HmYp3ErAPLJd5htKuPf2mNR63NQgbpGgwT4NXWfFdCTlYC0WFEz90LU0TnPpd+Y/sxttW4ZyZo28kyvejSbaBzbXAXXbZ0xxXj/I48eDDp+/F2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcqz6hqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcqz6hqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D21F000E9;
	Fri,  7 Aug 2026 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107952;
	bh=DrT10J8XOxbhkoRrQYfVli3c23gzsTu3VPul11q9kFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tcqz6hqs8ggdbpmsp8+6cWviABTz4JD6TH3vX5FdKYrmMbKbeHnC1XAA3VxRFJCwN
	 2c4fQS2NbCkQO/0EMBKE4hCBiQiuT8a6we0d0YUVPiHXZWD2tjfSqQI+Nepbng0PI0
	 QV12E9o0cX97Hte01VYRWLJH8lXsh8pHorcs46UX6Sn4Nh6SZ+0Y1mBoCd+hWVtAwm
	 1tHwR3ynqWvpvBPJcnhYrV0KqE76KT1jtjT2T+2vPVD1tVdMfzhQ6RwW+pwSpmt0Cf
	 gT0OD2EmyKaKjRHdLOw+KTYLYK3V377eL+IWRg95JPre8xo/PZ8fMJXURJeymqXb08
	 qe6+qGHnV76ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] mptcp: pm: avoid code duplication to lookup endp
Date: Fri,  7 Aug 2026 09:05:46 -0400
Message-ID: <20260807130550.2153435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072920-retread-pastrami-b8d9@gregkh>
References: <2026072920-retread-pastrami-b8d9@gregkh>
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
index 0cde99b0872a9..816176d216310 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1266,17 +1266,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
@@ -1303,15 +1299,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
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

