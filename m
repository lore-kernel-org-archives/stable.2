Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B03A0B38
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613903; cv=none; b=CPlLiz7FPezhiWi0Jmcdu8Y9GFHNE6NXZKNvoMsOgU8VN/xzyIKHAX18GBXaaY6P1nGDJUb00k7FW9s9Fwm0pVpYJ6xKHWOxCrvp7TjS4NLvO54E2oLOn6HM8Jy7/O3MdfPsbOYlDEPv23IlMYXA/dHjkJp2iNr0LTEzskGEwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613903; c=relaxed/simple;
	bh=cKnmbd1yjMg+Uzn6yJvOFHRSLkTrdvK9GwENvxd6g0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKuRdOAT7vaWKTXppex2g775fRH47EcLE+9/6I5Nofnz/oZbmwv8Qtbc7sXWJ1cxRVk8uoDm0o++mtxnEc6tqnc3rQ+6EGcxZolef8BYKlTAg9BFujyIO98WVxpf3+hXUmV6UuRzJHVa6Rin981FavvtG76zw2GjcPuMhwENQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7daFDqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7daFDqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6961F00893;
	Thu, 17 Sep 2026 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613892;
	bh=aRcjG12TpOlGZTM3DBVGE2VK5b+OflZY/sXuyBc5F4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7daFDquz/prTlFqdlC4jJLOewderllgWKzNXs+kTXVM1YjBAZKjS6octXqYbMGPc
	 qblXKf+4mZCaECUo2YtCTi4oc9Jch2eqcxf6tZ+jsMikPErOuX/Vo0W8xR6cuRtQWC
	 OUjWIqihEQPofTGjdz5UYrcxsslX26zM27OcOrK+drMvvmoH2A21U1pDdWTE6lOWHZ
	 1DEcDj5GEmQE5/2445jpTkZVKvh0f/Npts1vTg7SNWMd6YDOwhYRYOVdi3Tjlw0kik
	 g7DPMvkcNnNlu9VZ8OaLlzOHrTE3Cmjha/ml+zwik5P7IaqZZ2l6je91G5ClXpH94I
	 5Wa9uo4Xhf8ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] mptcp: pm: drop match in userspace_pm_append_new_local_addr
Date: Wed, 16 Sep 2026 22:58:07 -0400
Message-ID: <20260917025810.3934358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091627-sleep-poem-4828@gregkh>
References: <2026091627-sleep-poem-4828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 640e3d69d0bc70d7d3de34800a1640793262bd08 ]

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250221-net-next-mptcp-pm-misc-cleanup-3-v1-5-2b70ab1cee79@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f9f0068e8813 ("mptcp: pm: userspace: fix address ID overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 12dd30d63c717..bfcef17fe9dda 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -40,7 +40,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -59,16 +58,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -86,7 +81,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.53.0

