Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64656363C48
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613458; cv=none; b=G91WQccF8UcMBr08ayLksqt3aunn76B4Z3xktZYzrAjh7bpt253eEGtgJ80aSgMNNcecCNgvyF48D8k0Hj9pYVc/dOqNZypFjLvi35umeyYIj4C0O7XlIG9NeK2OdjT2jkV3sdCCTyb8NLhFlvsXZxepRb9jTD7VFhgKEBmexG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613458; c=relaxed/simple;
	bh=0hNsVh4+G6s8PN1gVHgk6iwspHKrA0hhqBjl6k02WvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os41jPjOxZF4TFwWTC4hMCm15Y02K8iLyccZVT9ZOBrxZqZr98ceQok/EdDIgZnIq6bRy4v7Tszio7/gDuPd2oHIqLtRRabZBmyf8qOcKCLKAqmcSaAk80czaUxSsME8T5nt0E/Jowi5rzvf4EyME29tJHqMENO33OYZ/oeB7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGGxsfo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGGxsfo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE691F008A2;
	Thu, 17 Sep 2026 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613423;
	bh=l7wTEmgQXQpuzO8ZqLsglI5kQOATcC2XAOe9WYZQXxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RGGxsfo/AQbYdwixfDds/uRV246Skn2TiEhPWzsZIPT1NhzQneBHndetfC9A23++W
	 vyGPRhN2aZm0f9Sy0SyGhdbezjDy3qJZYmstdzoW+PhcDnUHnyr/Lkth3lWy4zkEMg
	 g/TNHGNwvuk5h2BxMAnhwgPrbRxbfbmcoPU0j7cT3YC1axRApx1brkOLDFAaEH8tId
	 IQa+QgHybS4p+ciTjVvRaJ9kTrH3Ixf+6lauqNyZz75cXGoN89q4bIoAyrhe2JFNGa
	 y+/4fziuBL0Yx6qneXmza0TMFjQjaruwG5YBnk/ovWjZ45tPFLJvPweIa4Es/ff+3M
	 CmFRdFSMUSsBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mptcp: pm: userspace: fix address ID overflow
Date: Wed, 16 Sep 2026 22:50:18 -0400
Message-ID: <20260917025018.3917338-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025018.3917338-1-sashal@kernel.org>
References: <2026091626-embassy-overhead-d482@gregkh>
 <20260917025018.3917338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Luo <luoqing@kylinos.cn>

[ Upstream commit f9f0068e8813d8c10d016b030fc3a320d0b6767c ]

When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
overflows when stored in the u8 field e->addr.id, resulting in ID 0
being stored and the entry being incorrectly added to the list.

ID 0 is reserved for the initial connection in MPTCP, so this overflow
can cause address conflicts.

Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
reaching find_next_zero_bit(), preventing this overflow. So this fix only
addresses the userspace PM path.

Check the find_next_zero_bit() result against MPTCP_PM_MAX_ADDR_ID and
return -ENOSPC if all IDs are truly exhausted. Move the ID allocation
check before the memory allocation so that the error path does not need
to free the allocated entry.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-8-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index da39a2e396661..e0a858df932a4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -65,6 +65,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 	if (!addr_match && !id_match) {
+		unsigned int id;
+
+		if (!entry->addr.id && needs_id) {
+			id = find_next_zero_bit(id_bitmap,
+						MPTCP_PM_MAX_ADDR_ID + 1, 1);
+			if (id > MPTCP_PM_MAX_ADDR_ID) {
+				ret = -ENOSPC;
+				goto append_err;
+			}
+		} else {
+			id = entry->addr.id;
+		}
+
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -74,10 +87,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			goto append_err;
 		}
 
-		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
-							MPTCP_PM_MAX_ADDR_ID + 1,
-							1);
+		e->addr.id = id;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.53.0

