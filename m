Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C1272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070169; cv=none; b=gmOa7xknepWkLIDAioNEraAhIng8ZnSbTqLR9kmQFBiOUNYnsNO0IW8VYRrgU7KiPnkbamjV/jgNq2C+DhZwJc6DQrGZzBaVLUAxpn2efcgQIpmrWN3Kos9CLUV3X1shQGMKhi2fW2z0Le9+EDsL7kOZH+a2hmhgtb0X9NKGK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070169; c=relaxed/simple;
	bh=PKt76HaFslR0JgR/XEJOl9rookH5EJMtfRaSycUQePU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntTfAoVrcUNLwN573HMhf8TOuFSR7IrfrhTkYH+XMidxoRhCTe8cqCU1yT8C08mjX0RqSMc65lAU+oAnSUTkG/qDjjxhHqSvM8uUX9JPw74qbVfqCNLPGycVNOarppA+8Q0Bph3Ac3aiGAZB/IG1B6jVIvJOTJccTCSKqWieTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPP+zCho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPP+zCho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C477C1F000E9;
	Fri,  7 Aug 2026 02:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070168;
	bh=I+DkMvBmktTD/kGSBAkQssgi0KqHjA27qa/H/USHkpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPP+zChoFeK31eHv8mVECyea6Zpi1YJfvJ46SyFGrJrIIFyVimOnEw/AzLScbbZ37
	 bucfihf6SGDKY6Vm6+/SWeDAd74kQ/HCUUaEJzKS8XidzXORvZKql14+L5Us55eWfO
	 zDRtSf1QHqr25ldz1m8D7fSIPjT13iMFCB9nDXvXDuuyHyXQpmqDs32NYl0R6mZVnl
	 gKtUuj7ZpX2nvVww4CRR9XvxQwW4IZr9CiTf1auk5zLENBk64Pmz0ycPVCatVKsK1V
	 aj9yIA0LOPof+j1UuGUczOxC48CKJRsPWJYqIU2VSNjVYAZvB9DFHHZsQghWJgVMAo
	 EFVYn3UilYEtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mptcp: pm: avoid code duplication to lookup endp
Date: Thu,  6 Aug 2026 22:36:03 -0400
Message-ID: <20260807023606.1683287-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072919-slouchy-backpack-abaf@gregkh>
References: <2026072919-slouchy-backpack-abaf@gregkh>
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
index 8159ffb8466b0..044a80a66f139 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1278,17 +1278,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
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
@@ -1315,15 +1311,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
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

