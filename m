Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AC372ECD
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613909; cv=none; b=R+rAGVigcg2HAmFy3lLJVdQhNbPGCHkWaGhhS7OjNc5zvzmGxtQepWJmG3/Cn1SswZYiKWAmmZ/OGDj+cYiwNuyYlvV6+V1WIE4eajwE/fSEQ5U+hnwPizIe42tGW3Yol60eNiZ9FrnQfzb5alw1A9WTjU4AiBPjunTxznsGEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613909; c=relaxed/simple;
	bh=YgXmg394nlA7u3/4Ue5qdeaoPqt2pGiUQJFMuXwVRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu26KySw4nnIzagZwZ62ZojRsp1UNfRZdBzjJQ7TWnXbC5DfY+4+eAfIUM+gbpBbuwLYGI7SkVt+jgyWxyFMObCMfrWjmmVK41wZSXJvAF86uaxvxVNbpPWD8Yye3Uz7L/eHldtr1IvRRy1QUW1uAh2Om5jb4uFqmhhI8p4M3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM0lVmfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM0lVmfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B001F0089E;
	Thu, 17 Sep 2026 02:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613895;
	bh=fGQuQ0Sioi2BMyjeIOz9hOO41MZYeLRqgF81ZnU5g+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DM0lVmfn52yc3xiwovvq6QHWLP9C4YuBZC1lQZCoyw62gag/kPEgMXC8LhsbyiBPy
	 JRP2AYn7oXFojxzt/liHikggGqrpYaaZAN+PsIHiX0gSGcnFCRdB7VSs+y8OaGorjd
	 kWnPceZ1i/x4P1sInwi9mIotVE0A8Y083Q6yvCz69RrM/rruExVvi59rCenn1pOqVC
	 oEh6l5xiLqYw+oFwkfgGXP8/c2mDJLQZMvzWZbIAaCaTBNfp12AH3Et39Yg0jOmKes
	 6mIalV2tfWFr1s91eXlZ0vN5c8sMZgaAjLAW6x4P07zxGpt7XL0BMGMTK41qotJ7Du
	 f0WCP0UvAiThA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] mptcp: pm: userspace: fix address ID overflow
Date: Wed, 16 Sep 2026 22:58:10 -0400
Message-ID: <20260917025810.3934358-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025810.3934358-1-sashal@kernel.org>
References: <2026091627-sleep-poem-4828@gregkh>
 <20260917025810.3934358-1-sashal@kernel.org>
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
index 493a4511a5398..335ef95da4034 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -64,6 +64,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
@@ -73,10 +86,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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

