Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA1395AF6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613444; cv=none; b=tLgnWVmHAVtTQGOX78Y96EVTE0VZrBVcQyDF6vaJtB6J01DqZWKSsd/Uswb4aFoOZuPmM6d7Iy1m+TAkXqrj/NRiTNfbyGhdbFyVlSNrYXPpkIzHiMubHYaIqsnC/kCxpyhDpdLYfiSbC/C8Z7gq0BeyS7KDSk9+oBdfpfTPo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613444; c=relaxed/simple;
	bh=buvLIcd3wRyJnZvFOKtI6bKb51pGT8RBzKr2f2QpxNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIcq0eNeXoOCNV6DS2Xu3SGNLIA3XGrXkhHaZP8eKnLuJ46aVsZXbx6pHpSr/fRAtL/+JCM+qBuDeuVtK8e4+NPqa7/LDnAlfhb36vBN+R1ZmEz/CmkSWPSXxu4nJ+Y+JaI6nB4IZdx5vCR8nFiqeY1cPsZ4S6RmwcORnoD2qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdDSHUfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdDSHUfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7E41F008A1;
	Thu, 17 Sep 2026 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613420;
	bh=xT0+xbxPesKjnkmjwOSdBeHh0sGkOipazElHOtd8vyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdDSHUfjI5CnJ0rzBF3oHCZWQLp5eaKfn5V1/v2MUD/xVMrBiQiS3Rolw8nIIgZau
	 pxWLmxDv02P6a+8+nGHVPaV/1EcWfZD+t+R0/aTAIM08siLflIj2JW55AIeqpgTes2
	 lC1Xzm7X29Y/SHFP7FjIgs1IfErqhgIt2Z2b2GG98T+wS9Pf/zQV0ufmksoXKeVidI
	 ZQq4ddlkLJ0oOtbojaNuHWIB6Ez3QFqGt2rn8qp8Imw3qm/wTUkb+ypQCVORXiAbkZ
	 B1C2KTVBJKsYPqHO7GS5psD1bDw1jFbVcZurDx45ILdHLRPoP+gaV0AXeOMy2/DjNs
	 O4e1ARDvu9KCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mptcp: pm: drop match in userspace_pm_append_new_local_addr
Date: Wed, 16 Sep 2026 22:50:15 -0400
Message-ID: <20260917025018.3917338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091626-embassy-overhead-d482@gregkh>
References: <2026091626-embassy-overhead-d482@gregkh>
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
index 33494c4a8fb29..708cc81e707e7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -41,7 +41,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -60,16 +59,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
@@ -87,7 +82,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.53.0

