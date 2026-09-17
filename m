Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F03B42C1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616152; cv=none; b=YOQvH7lP0GftwkNyAbrLwrbhl8FdITln0umT3dS24yihqAcFzCAUiBWsjs/6ckSPe0Bi53FIdZezOHn2HA1sFGGmdfc2q+47h47GWfgQTqEGRnySuhVhQWcKRkqLNRXY8ZLSytWHfX3k6hv6tKaRin0ezO//PjIAjQRxmAlotAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616152; c=relaxed/simple;
	bh=74qnNLM0k47o+MZy7Ge9fDiR5fToosI9xhspst1qVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3zfyumxzzNqaMfSrS3qsPeJvEUb/EoBMzcgc7jCN4FHV4y5tnebsHzFrXfbHS9sem1E39HgdaW5vB2nBt3Fl1tKcu/T0yZugbR9ka3o02ufJKKQ817pT7msz5IzbVkNGfv8wMHsdi5Vi0wg+1v4/C94yM9HW0bLPJWvn9yd3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTg23WUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTg23WUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C69B1F00898;
	Thu, 17 Sep 2026 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616139;
	bh=w7QweVkUqLqhZxHkso8Q6aCgd4HbJEEkj7r6I2jrNxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTg23WUP8r/baqpHwOlQRhMHig7THEywt2JwdYx+zHqfPBBOobsD52BsmnRFK+HtP
	 FtHQIYyWagFuQNrN+X/QoEDS7eaBHaKOFDL7+Cg3dXW9I0IZva+sn5Wu1raJIbqNDh
	 d4wjWJbroPuXxwt+rI0lnEQKntctFzNYfQVVAAA16oMfyN9yi2WfkqX3SBmMIjJP8Z
	 0B8FctepmJ264FlbFcdW0u6tl8HFRDXV5iIVZhJ4srdO0I3tr6dAK/98shdg4AuYCp
	 +75FSfsXczPJ5EPMnVizv2TLVqGuTC0sc0eTELWSwMZPLW0Ef1S4078gBe3D4aPHpH
	 RxTmuw5UCXAkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] mptcp: pm: drop match in userspace_pm_append_new_local_addr
Date: Wed, 16 Sep 2026 23:35:33 -0400
Message-ID: <20260917033537.4044281-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917033537.4044281-1-sashal@kernel.org>
References: <2026091628-sevenfold-cursive-c662@gregkh>
 <20260917033537.4044281-1-sashal@kernel.org>
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
index 129ae1fef054e..e203b7f878a90 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -43,7 +43,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -62,16 +61,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
@@ -89,7 +84,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.53.0

